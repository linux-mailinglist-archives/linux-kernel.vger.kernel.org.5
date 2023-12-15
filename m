Return-Path: <linux-kernel+bounces-271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC9813E80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C93C1F22B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD522DB8E;
	Fri, 15 Dec 2023 00:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1E+NnNx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D319474
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc2683fdaaso12142821fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702598477; x=1703203277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lGhZrUhVazmXqa8F42tLFaEnXfVDDi1b+3+IHxb9zY=;
        b=G1E+NnNxtO57smK8lwtTFP70KR2V3Jcr3Qy1mefArNfTs0mu+w4OMhwJ6xNOud7qmw
         T69zx2M6D0e2sigIrHw1O1OiFcUpHoQ3UpdJ2kCRClsu9c/YhPhUbOoSjGQjWNPSV6NB
         5RTflhoPjTfDtBtAdcswWDrDiqTlq9lwOt07AZSWxHQa1T0KASHknum8asmjotEMC69s
         4fEmeQqKZno45Z3dMdV/6McMizo314JMEz1FZtJjMungFLk8wj4fLezqH60AOldklQm0
         yeOou/dNrLbXRTJL+e8FBMUNTePmQ+jqHxUCB8LLO1SjtGQ/XxmqqGKuKFpWgm5/QnTV
         jCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598477; x=1703203277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lGhZrUhVazmXqa8F42tLFaEnXfVDDi1b+3+IHxb9zY=;
        b=t6fl36XDRpmKJT4qeC7dC25osF4jrm3ToXLfs6s5kkH/i3cgGDK/5OnEiKDCkcxYyr
         OJpuuNdPbcx4srAnALSwYHUu1FvV8zNDbdq5Q87KtxpJmLlgy5TsVaK71S/abJnK/uDn
         NgScz+pqQWSkeAepCGi8vVhVgkuoByRgS3rxLPG6X/LdUdr86sJ/N8dtzPz8rh7C7cNH
         YEd/OPZh5cRMSRtL2QeLKiXYHaRTsxI7ghLv9erZesGJgWlODoz197FfxhijtcUUL7uo
         FPbU5LVTz4Gv3lpu+VY+ehotN7hN8lS5dHONni+bFJ2NTZ0pmq+hSL/dS0YVSd0doBGJ
         5X4Q==
X-Gm-Message-State: AOJu0Yy4WhX+z5uUrDO+OD5352uKXT//7Rsz0Tth51gO2arm4XHFbOJB
	3MPiGqFfS6BA64PaHNB5LfatDQ==
X-Google-Smtp-Source: AGHT+IF3wspDpRFDamizOwIZkKCYntjaRgb3QV1L4zzDeXmgJdkZgcq+xw+AWJvAuXyZ+RXM2tHb2Q==
X-Received: by 2002:a05:651c:2220:b0:2c9:f87e:deea with SMTP id y32-20020a05651c222000b002c9f87edeeamr7187593ljq.9.1702598477337;
        Thu, 14 Dec 2023 16:01:17 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e2f06000000b002c9f939598csm2184518ljv.70.2023.12.14.16.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:01:16 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 15 Dec 2023 01:01:09 +0100
Subject: [PATCH 2/3] arm64: dts: qcom: msm8996: Hook up MPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-topic-mpm_dt-v1-2-c6636fc75ce3@linaro.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
In-Reply-To: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

Wire up MPM and the interrupts it provides.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 39 +++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 35a0d2a69711..11e3fe4f342f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -444,6 +444,25 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	mpm: interrupt-controller {
+		compatible = "qcom,mpm";
+		qcom,rpm-msg-ram = <&apss_mpm>;
+		interrupts = <GIC_SPI 171 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 1>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#power-domain-cells = <0>;
+		interrupt-parent = <&intc>;
+		qcom,mpm-pin-count = <96>;
+		qcom,mpm-pin-map = <2 184>,  /* TSENS1 upper_lower_int */
+				   <52 243>, /* DWC3_PRI ss_phy_irq */
+				   <79 347>, /* DWC3_PRI hs_phy_irq */
+				   <80 352>, /* DWC3_SEC hs_phy_irq */
+				   <81 347>, /* QUSB2_PHY_PRI DP+DM */
+				   <82 352>, /* QUSB2_PHY_SEC DP+DM */
+				   <87 326>; /* SPMI */
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -733,8 +752,15 @@ pciephy_2: phy@3000 {
 		};
 
 		rpm_msg_ram: sram@68000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x00068000 0x6000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x00068000 0x7000>;
+
+			apss_mpm: sram@1b8 {
+				reg = <0x1b8 0x48>;
+			};
 		};
 
 		qfprom@74000 {
@@ -820,8 +846,8 @@ tsens1: thermal-sensor@4ad000 {
 			reg = <0x004ad000 0x1000>, /* TM */
 			      <0x004ac000 0x1000>; /* SROT */
 			#qcom,sensors = <8>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 2 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
@@ -1343,6 +1369,7 @@ tlmm: pinctrl@1010000 {
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			gpio-ranges = <&tlmm 0 0 150>;
+			wakeup-parent = <&mpm>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1870,7 +1897,7 @@ spmi_bus: spmi@400f000 {
 			      <0x0400a000 0x002100>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 87 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
@@ -3026,8 +3053,8 @@ usb3: usb@6af8800 {
 			#size-cells = <1>;
 			ranges;
 
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 79 IRQ_TYPE_LEVEL_HIGH>,
+					      <&mpm 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq";
 
 			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,

-- 
2.40.1


