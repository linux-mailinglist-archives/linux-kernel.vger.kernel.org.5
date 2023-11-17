Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68497EF882
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346290AbjKQUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjKQURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:17:51 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1410C6;
        Fri, 17 Nov 2023 12:17:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fa2714e828so10482666b.1;
        Fri, 17 Nov 2023 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252266; x=1700857066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZYYp8sqWaLNty8urA3uerAre51wEq7E/gQTN6mMDro=;
        b=ToEhWS/fste4xrE43OQbwuByxURrLzD/gMd5CiHGP/OUR7GUlpxSng4cB05GBPjcJF
         2TV1gpBHS8kKxAIsadvdCOo3gSKcKs7TkPcFWnOg9eLvgFNv12IVkYgfOCtRLO6iV/Pb
         CIz/BBxk0dcZNo3Wdyr2C0JGUipJsjz7SjHEN5vPOR3f3x/XCb/qW0UR/ts4v0pDzuDN
         VjLhiViQIjJonmTQ11i/rj2C/JSHtzpB3xPycVRJtPSt5iKvvf1TyvZAzzdvd+CDwwpo
         GxTgW4dcGCp8l4s4dHPCxSVKfnDLXOhvR2MnHQGriFAsxQS2FNIto3UN1pU9gQWTQw+h
         4HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252266; x=1700857066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZYYp8sqWaLNty8urA3uerAre51wEq7E/gQTN6mMDro=;
        b=of6AOmgEdWkuAB/XMZSAQV0gZQAb+2Bz2Dj0tu6ysPMBV2DcsxY2ghMBu4vpcOLV0s
         DEM/y2URZYRpBK239A8vKLk23YeJCxheGPXlo7rJOps210hSadpUV6cAd0APwIop4zd5
         Og08veJvyx3MK0M4G0NX5vcEbglS/4l4sWipidwl1h32TPMNvk6LNaAoPvExBmjmqVgU
         JMyZbAi8urdRGYyVs0WEUchOwsYw49BVAAXopJXIMoXg3Q3rEFKHk6TAtNl6CXXLH9xx
         17mmeXOSeuZ1jSELH7gv/oQHPFBFUM4lEPPtDZdANIrsbniQ67YT0MmlcCAY9+weu4db
         vN4w==
X-Gm-Message-State: AOJu0Yw32Po8YN69IGdJWxbmls1r6SffbITbRHStHhcQXsvFIzlKB2G3
        XG1mE/2YCuGNzUnvrVMtjWY=
X-Google-Smtp-Source: AGHT+IGzBxBxaX/rKgTXuDrD70JQ9fLlZQLIzhnmFHwIXcrrsmoRyWzD863wAesmDaitoEZ2vFQ0Og==
X-Received: by 2002:a17:906:10cc:b0:9c3:e66e:2006 with SMTP id v12-20020a17090610cc00b009c3e66e2006mr108527ejv.9.1700252266540;
        Fri, 17 Nov 2023 12:17:46 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:46 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 6/8] arm64: dts: qcom: sc7180: Add UFS nodes
Date:   Fri, 17 Nov 2023 21:08:38 +0100
Message-ID: <20231117201720.298422-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117201720.298422-1-davidwronek@gmail.com>
References: <20231117201720.298422-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the UFS, QMP PHY and ICE nodes for the Qualcomm SC7180 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 69 ++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 11f353d416b4..daa9c63b85bd 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1532,6 +1532,75 @@ mmss_noc: interconnect@1740000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		ufs_mem_hc: ufshc@1d84000 {
+			compatible = "qcom,sc7180-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0 0x01d84000 0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			iommus = <&apps_smmu 0xa0 0x0>;
+
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk";
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+			freq-table-hz = <50000000 200000000>,
+					<0 0>,
+					<0 0>,
+					<37500000 150000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			qcom,ice = <&ice>;
+
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sc7180-qmp-ufs-phy";
+			reg = <0 0x01d87000 0 0x1000>;
+			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+			power-domains = <&gcc UFS_PHY_GDSC>;
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		ice: crypto@1d90000 {
+			compatible = "qcom,sc7180-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x01d90000 0x0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sc7180-ipa";
 
-- 
2.42.1

