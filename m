Return-Path: <linux-kernel+bounces-270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECF813E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDF71C21FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9F2DB77;
	Fri, 15 Dec 2023 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ2OvACC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB41856
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c9efa1ab7fso1023121fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702598475; x=1703203275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJcFyw95dyU2HKs4SKbZQ9m7j6jYu9nOsOQURiEgmsM=;
        b=NZ2OvACCogjRaGNCG7dzChxn+d3SAjSfRxtL4bn26R6g7tEBTxCLoxFSimA5i8/5jD
         CW+6s931oH0I4mAl7N8tpoPTgLkHoZwl9kIsNlRf0BAKr/QKSmOkQiRjTnYFKAFslI0O
         s/gaRIDE9mlPYbvIGhH0/BIEGjl2gYG0L7ACGpvVTKAXE87ogb1SxcP9OD7YSRytPoOY
         g41pUzpkLl8g9WdBpWDjhZByOLg66cON7lQoQ3HGwjseegivjXtMau8RVD0qqG+63eMB
         okv9thr0CdRiKNshyJ7GFZrrxyc9jfc9X6Op3EuxmLv7+NTraWb2L4DQgDDIRZumauUt
         Sadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702598475; x=1703203275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJcFyw95dyU2HKs4SKbZQ9m7j6jYu9nOsOQURiEgmsM=;
        b=B2kaZLN6oi93LZ3G8OZBMN5QFeR3T+DVvrEmjl/6xrExdbZjnA5j4q72w3H3YlAule
         r4dGCEAvZFC773nr5dAir+Dxja8jyVHgDvV//bQIzAukjfHMH5ujum4QpS05AjjgL/DE
         plE1yfNmurtkF79UdgOYhc6Sxv6HT6Z3SMegiVn/sfTj960Y3yzYxH1185rinSG5zG6C
         KWYenlv/sJN5WSPS7YrhTG5q4xDx1UYp2gEn807rfpsgQsVJ3SFIDT7/EpWTY29mpj6K
         iyfjSdi+lF7+3dtNygL/S9rAmCJh0WAaMS1UGtrfHpXlky16UWpBUzZZlf5IXfO+cYX2
         VUow==
X-Gm-Message-State: AOJu0Yyy+/abL0oVh9tt7anOqBX1INlw5cABp15N0Mq3k0Sk4T5YzV7k
	kFdJJXr+/1/vXsyNiBpVkY5h5g==
X-Google-Smtp-Source: AGHT+IFZZbXp/hoLZhBr+dxql5jwGryui+dSFOYgQD+KdblhhLDCJrClTqcDoVVF/bKSFL1lLnkqIA==
X-Received: by 2002:a2e:a26f:0:b0:2cc:202b:11aa with SMTP id k15-20020a2ea26f000000b002cc202b11aamr1741742ljm.206.1702598475429;
        Thu, 14 Dec 2023 16:01:15 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e2f06000000b002c9f939598csm2184518ljv.70.2023.12.14.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 16:01:15 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 15 Dec 2023 01:01:08 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: sm6375: Hook up MPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-topic-mpm_dt-v1-1-c6636fc75ce3@linaro.org>
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

Add a node for MPM and wire it up on consumers that use it. This also
fixes a very bad and sad assumption I made when initially porting this
SoC that the downstream MPM-TLMM mappings were 1-1. That apparently
changed some time ago, so with this patch the MPM consumers will actually
be hooked up to the correct interrupt lines.

Fixes: 59d34ca97f91 ("arm64: dts: qcom: Add initial device tree for SM6375")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 41 ++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 331bd98dbfde..7ac8bf26dda3 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -311,6 +311,25 @@ scm {
 		};
 	};
 
+	mpm: interrupt-controller {
+		compatible = "qcom,mpm";
+		qcom,rpm-msg-ram = <&apss_mpm>;
+		interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_SMP2P>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#power-domain-cells = <0>;
+		interrupt-parent = <&intc>;
+		qcom,mpm-pin-count = <96>;
+		qcom,mpm-pin-map = <5 296>,  /* Soundwire wake_irq */
+				   <12 422>, /* DWC3 ss_phy_irq */
+				   <86 183>, /* MPM wake, SPMI */
+				   <89 314>, /* TSENS0 0C */
+				   <90 315>, /* TSENS1 0C */
+				   <93 164>, /* DWC3 dm_hs_phy_irq */
+				   <94 165>; /* DWC3 dp_hs_phy_irq */
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
@@ -486,6 +505,7 @@ CPU_PD7: power-domain-cpu7 {
 
 		CLUSTER_PD: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
+			power-domains = <&mpm>;
 			domain-idle-states = <&CLUSTER_SLEEP_0>;
 		};
 	};
@@ -808,7 +828,7 @@ tlmm: pinctrl@500000 {
 			reg = <0 0x00500000 0 0x800000>;
 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			gpio-ranges = <&tlmm 0 0 157>;
-			/* TODO: Hook up MPM as wakeup-parent when it's there */
+			wakeup-parent = <&mpm>;
 			interrupt-controller;
 			gpio-controller;
 			#interrupt-cells = <2>;
@@ -960,7 +980,7 @@ spmi_bus: spmi@1c40000 {
 			      <0 0x01c0a000 0 0x26000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&mpm 86 IRQ_TYPE_LEVEL_HIGH>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
@@ -992,8 +1012,15 @@ tsens1: thermal-sensor@4413000 {
 		};
 
 		rpm_msg_ram: sram@45f0000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0 0x045f0000 0 0x7000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x045f0000 0x7000>;
+
+			apss_mpm: sram@1b8 {
+				reg = <0x1b8 0x48>;
+			};
 		};
 
 		sram@4690000 {
@@ -1403,10 +1430,10 @@ usb_1: usb@4ef8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <133333333>;
 
-			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 93 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 94 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&intc GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+					      <&mpm 12 IRQ_TYPE_LEVEL_HIGH>,
+					      <&mpm 93 IRQ_TYPE_EDGE_BOTH>,
+					      <&mpm 94 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
 					  "ss_phy_irq",
 					  "dm_hs_phy_irq",

-- 
2.40.1


