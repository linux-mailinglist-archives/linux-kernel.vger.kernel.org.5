Return-Path: <linux-kernel+bounces-272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDF813E82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B9D283DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC29199BE;
	Fri, 15 Dec 2023 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoUPVUuS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187002DB6A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc43f9e744so871031fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 16:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702598479; x=1703203279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvYIncA4M4SGSh5JTnjhgY5sZtR0+qJcMKUor4G9V+0=;
        b=VoUPVUuSDhXbqWVprsKVMVdwCM9dTgMUGB1hhWaOl/xM76oroa/KHCkpw4qj18dyFC
         7jpoYLNBYOvBfNiqrsaXR7nyqfFMFKByikiWqbqFns64o1lPVj5wJeCP84ax41OArm6P
         alQ0rrBSBfOBHBzCA7bCnw5nhnnFsGmE0pAlAm11CKxmV0l7a4AAoDzwirZD4WNcAyEW
         3c+RXxwWj9hTVI0EgCBz5sUZz7tvbPEpJEjIbTpwMW/jS+zso6J9FLD6b2e3BONEn26i
         NOeXDs50TRW4F/3yUgbvauTKyTehq5zJIZ/dqLs0n5TszErAKDlJzqGfjWu0lsNESN4h
         fMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598479; x=1703203279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DvYIncA4M4SGSh5JTnjhgY5sZtR0+qJcMKUor4G9V+0=;
        b=coDGRLNA6v2AYJLGJ3yCOngcVWX/SWbifDkvLKYQjlyNqgWRdUUvOs8YxQqIvTtcg/
         nUYXGG8IjY4PjxDrmCjxRuzZSCURpBbV2DtuQ0euLKIbBIZECq5IcnGKwGdmFKXHsn+q
         NBbCT6qz1+j9cVJGmkMnJwKzmr73BXEFIlZKsv0uSe1+CiojkYEISZfx8td5MCbM39H2
         l//o2oHCwrBzRNgbuNlY7nqdo6txWILP0ZalaWaDhhQDBKE+uJ+ebAPaZ78TK3+yUmXQ
         og6RHUnabQsh9IPUIESuapO2aFE7cQPz86SCx4zr9tAaonMQTfjFqPTBQcCrS3EwkEXF
         ajPg==
X-Gm-Message-State: AOJu0Yzs4CeBcJC5lUhVqSzDmiezsdcPTjJkyq7fMVOMwQat+ENafpCa
	E1mSvlrcZbLpOO67wghkE1EAeQ==
X-Google-Smtp-Source: AGHT+IFAHnBdYUR0+GTVfwY42CyzywNVvhh2x5WnkY31cQX8R3pIf0jwI2wauK1oBewOAmIJsg3csQ==
X-Received: by 2002:a05:651c:220b:b0:2cc:304d:c3ee with SMTP id y11-20020a05651c220b00b002cc304dc3eemr2847351ljq.67.1702598479156;
        Thu, 14 Dec 2023 16:01:19 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e2f06000000b002c9f939598csm2184518ljv.70.2023.12.14.16.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:01:18 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 15 Dec 2023 01:01:10 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
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
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 42 +++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index ce04d0acdede..0911fb08ed63 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -199,6 +199,7 @@ CPU_PD3: power-domain-cpu3 {
 
 		CLUSTER_PD: power-domain-cpu-cluster {
 			#power-domain-cells = <0>;
+			power-domains = <&mpm>;
 			domain-idle-states = <&CLUSTER_SLEEP>;
 		};
 	};
@@ -266,6 +267,24 @@ rpmpd_opp_turbo_plus: opp8 {
 				};
 			};
 		};
+
+		mpm: interrupt-controller {
+			compatible = "qcom,mpm";
+			qcom,rpm-msg-ram = <&apss_mpm>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apcs_glb 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#power-domain-cells = <0>;
+			interrupt-parent = <&intc>;
+			qcom,mpm-pin-count = <96>;
+			qcom,mpm-pin-map = <2 275>,  /* TSENS0 uplow */
+					   <5 296>,  /* Soundwire master_irq */
+					   <12 422>, /* DWC3 ss_phy_irq */
+					   <24 79>,  /* Soundwire wake_irq */
+					   <86 183>, /* MPM wake, SPMI */
+					   <90 260>; /* QUSB2_PHY DP+DM */
+		};
 	};
 
 	reserved_memory: reserved-memory {
@@ -429,6 +448,7 @@ tlmm: pinctrl@500000 {
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-controller;
 			gpio-ranges = <&tlmm 0 0 127>;
+			wakeup-parent = <&mpm>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -778,7 +798,7 @@ spmi_bus: spmi@1c40000 {
 				    "obsrvr",
 				    "intr",
 				    "cnfg";
-			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 86 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "periph_irq";
 			qcom,ee = <0>;
 			qcom,channel = <0>;
@@ -793,8 +813,8 @@ tsens0: thermal-sensor@4411000 {
 			reg = <0x0 0x04411000 0x0 0x1ff>,
 			      <0x0 0x04410000 0x0 0x8>;
 			#qcom,sensors = <10>;
-			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 2 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "uplow", "critical";
 			#thermal-sensor-cells = <1>;
 		};
@@ -813,8 +833,15 @@ bimc: interconnect@4480000 {
 		};
 
 		rpm_msg_ram: sram@45f0000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x045f0000 0x7000>;
+
+			apss_mpm: sram@1b8 {
+				reg = <0x1b8 0x48>;
+			};
 		};
 
 		sram@4690000 {
@@ -1293,9 +1320,10 @@ &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 		usb: usb@4ef8800 {
 			compatible = "qcom,qcm2290-dwc3", "qcom,dwc3";
 			reg = <0x0 0x04ef8800 0x0 0x400>;
-			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+			interrupts-extended = <&intc GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+					      <&mpm 12 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq";
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,

-- 
2.40.1


