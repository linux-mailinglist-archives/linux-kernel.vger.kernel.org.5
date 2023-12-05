Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637788057D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442282AbjLEOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346736AbjLEOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:39:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C51B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:39:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00f67f120aso754804266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701787147; x=1702391947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4O0UDDPSWRyxJ5a3wx0+K3NYIqTeYfsWlSp1+sj3fc=;
        b=am5rSL4X2KsMD3Hq5llpYHfX6DxKp/vmxP4x2L7xfCi09RvOZNz7fIEv69/HtYhm4m
         E4+F4MGcOUYooEQ05KNVbtE1mJnBRT9IH/jbOH45O608Qv8E4DYCN4OP+keKbzRrtGxM
         xZDEt1pthG7LMYWYAiUfsdGEvlGAVFbUpB4bVYmFtfqWf8KocljWzDEvomLnVS9uyeCW
         h7gD3fuuwMoLfcKLnQdHNcfijVCTKcR/gPRrL5++6EymMop0jWmLFhFCwj1jt+/PpK1Y
         usjGKzAhrWYRn3Zp+/ZOxs6bRRA1xyFUt0PmUYeWqBEFvJXZRLCFuzSuDtfIOkVb5m4V
         GZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787147; x=1702391947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4O0UDDPSWRyxJ5a3wx0+K3NYIqTeYfsWlSp1+sj3fc=;
        b=YeHtKQOyh8t5eZyQkgiTESj7NFIVI4fQ32myh4JTTPyhwjOMsBl4RcWRnHxw+HfDwc
         ncizyzIXjuXsWwAF7VxnjDa/OJxOebH2OD9LY/+RCuQKv8WRTLLOXyfF/DClzbNBYmXa
         WS4+LQm+0+W/tm6t7tE9hwFWFC8+scfJjdDB3aCRJD5Z0Otdv9mf50ND/RkVD2pMIYcw
         CgOGznVDfqvDhXFMtyorortO0Zr0DJtmHl38l+eZB+nn+GHS3mTN8ORO/co8MteXYj0K
         g8NE5iCAq2HCY76deI42Z36SNq+HSueg4iTOKyoFTNWJKb8RjPv1RAIoyNGSCrom5BaN
         1YnQ==
X-Gm-Message-State: AOJu0YwqbS/OPJp8NrCyhis6rP81DH4SHmnSudfUSnNM2IFsNCnUzJ1q
        vG/P4EQoeknnYU5r/wLkHyi6fw==
X-Google-Smtp-Source: AGHT+IEbfMwPsV1+ddsYlU5zo4v/vz0HOs8tKtJXcSEehNCn/w2pxyCkp3jJlifxJr5xr/MeBny4Aw==
X-Received: by 2002:a17:906:51d7:b0:a19:a19b:5608 with SMTP id v23-20020a17090651d700b00a19a19b5608mr594270ejk.152.1701787147624;
        Tue, 05 Dec 2023 06:39:07 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b00a0a8b2b74ddsm6795404ejb.154.2023.12.05.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 06:39:06 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 05 Dec 2023 15:38:55 +0100
Subject: [PATCH v6 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 soc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-sc7280-ufs-v6-2-ad6ca7796de7@fairphone.com>
References: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
In-Reply-To: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nitin Rawat <quic_nitirawa@quicinc.com>

Add UFS host controller and PHY nodes for sc7280 soc.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # QCM6490 FP5
[luca: various cleanups and additions as written in the cover letter]
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 74 +++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 04bf85b0399a..dcb6c2004f87 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc7280.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -906,7 +907,7 @@ gcc: clock-controller@100000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
 				 <0>, <&pcie1_phy>,
-				 <0>, <0>, <0>,
+				 <&ufs_mem_phy 0>, <&ufs_mem_phy 1>, <&ufs_mem_phy 2>,
 				 <&usb_1_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
 				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
@@ -2238,6 +2239,77 @@ pcie1_phy: phy@1c0e000 {
 			status = "disabled";
 		};
 
+		ufs_mem_hc: ufs@1d84000 {
+			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x0 0x01d84000 0x0 0x3000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&ufs_mem_phy>;
+			phy-names = "ufsphy";
+			lanes-per-direction = <2>;
+			#reset-cells = <1>;
+			resets = <&gcc GCC_UFS_PHY_BCR>;
+			reset-names = "rst";
+
+			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
+			required-opps = <&rpmhpd_opp_nom>;
+
+			iommus = <&apps_smmu 0x80 0x0>;
+			dma-coherent;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+					 &cnoc2 SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+			clock-names = "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "rx_lane1_sync_clk";
+			freq-table-hz =
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+			status = "disabled";
+		};
+
+		ufs_mem_phy: phy@1d87000 {
+			compatible = "qcom,sc7280-qmp-ufs-phy";
+			reg = <0x0 0x01d87000 0x0 0xe00>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_1_CLKREF_EN>;
+			clock-names = "ref", "ref_aux", "qref";
+
+			power-domains = <&rpmhpd SC7280_MX>;
+
+			resets = <&ufs_mem_hc 0>;
+			reset-names = "ufsphy";
+
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sc7280-ipa";
 

-- 
2.43.0

