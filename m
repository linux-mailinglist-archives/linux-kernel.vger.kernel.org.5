Return-Path: <linux-kernel+bounces-11033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FDF81E057
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E195B2821DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2EC54665;
	Mon, 25 Dec 2023 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXtO042o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603B5381B;
	Mon, 25 Dec 2023 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d4a7f0c4dso27028135e9.1;
        Mon, 25 Dec 2023 04:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505822; x=1704110622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5brTRSD7VKH6s5ZdAUAu2zmtV4YnYCW0hXVi17eq6+g=;
        b=nXtO042okFdbG7QsBqiEIQ9tOIoc/NRjKexUkqR9mM7LBlsf2dgdVTtMuJvTNmvKfv
         JtAQ4oGqNLukksAamiBV6/VJeuiKiXDyRogD15y9BvkXGXQu0ytRMjSFO0fIs4RcWw8b
         HsXTDAhqE1deC0J0TE/fd6xAwUjp5bu0cCry3GUmfEhoXRww6CPDSNCQAjaObg0RITwp
         mukbRyzwStZvkTf606KTw7B2WZByV8zQaTGMGlBDUQIb3WA8n9FWZQzOuSaqOQW+++vS
         hEK/ClYX3ApTWmFyCKGiroa97BLkMLDOKeXKwJMfPB5SBK+TthteEBHwY+tqwkD36vFH
         WoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505822; x=1704110622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5brTRSD7VKH6s5ZdAUAu2zmtV4YnYCW0hXVi17eq6+g=;
        b=dMe8DAliFv+JWsbfaxr152mXYalPu32lkBjDb/0RXjmh/7FfolyerQr6Wi3forQJlZ
         8c4mHZ0nrKToIfK/tniOrjHZdkrdxP8TfFH8IOEHznqROvFJNMUgyZPm4Mpadug2lnlN
         bQG5Zvr8fbycsVz95Z6I9FHkLNX8C3sVJx7vNVca0ccn1v+hcrzIg81g0RmNJTcdfwkL
         nAGKpLwXuOZ1e7RAaFs7OfpB4EQ9S/cqzy7jm1SbbczMfCK7lzfebSYpM6r38uwh+JjK
         i/0AE0xXTnf/mvrYcWNPA8b9d0lxAxOEOwRlI41xSqyxyXw+u7eE3IgFC1jml4ymFi0E
         W1dg==
X-Gm-Message-State: AOJu0YxvPSqMZfhbpzisCHoe5ycjK8IJ83sNYR573vE5imYVvFD2HfP3
	vCMXSB7WZZLGpLELaDI8SIU=
X-Google-Smtp-Source: AGHT+IFHLMVKU018jt4XmkVhXpMI+8bK+AStn2t750d5ydJIRbx+bgO9nhFTFfH4CMG0769heh2oOw==
X-Received: by 2002:a05:600c:5027:b0:40b:4c39:b4e with SMTP id n39-20020a05600c502700b0040b4c390b4emr3193558wmr.1.1703505821662;
        Mon, 25 Dec 2023 04:03:41 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:41 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
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
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 6/8] arm64: dts: qcom: sc7180: Add UFS nodes
Date: Mon, 25 Dec 2023 12:59:59 +0100
Message-ID: <20231225120327.166160-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the UFS, QMP PHY and ICE nodes for the Qualcomm SC7180 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4dcaa15caef2..93c867cac755 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1532,6 +1532,76 @@ mmss_noc: interconnect@1740000 {
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
+			compatible = "qcom,sc7180-qmp-ufs-phy",
+				     "qcom,sm7150-qmp-ufs-phy";
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
+			reg = <0 0x01d90000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		ipa: ipa@1e40000 {
 			compatible = "qcom,sc7180-ipa";
 
-- 
2.43.0


