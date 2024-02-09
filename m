Return-Path: <linux-kernel+bounces-59262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943B384F423
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487CC28BD72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DB28DA5;
	Fri,  9 Feb 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYxDnPRi"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FF149E12;
	Fri,  9 Feb 2024 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476748; cv=none; b=c+eZyE1YLBcq4I8SUKHBgotzc/PSmQD9PLJMQDFJAYcDTxQQSKwbBJTe2JPViwocKwEDMWi8nPNxkFfJp0nP/Y/i1XXK+7SxEqFgRcg0qgq0nfrBZgtYPhP1JUAvDgFJGNo1zQhKXt8vegl1cVOUDZOg+TrNZMPXIOm7yxk/0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476748; c=relaxed/simple;
	bh=yTyp75CZWYZNbUXtfkznJ6XWbMlAr0XgWNSjRN9Csbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbukmHJuTYbNyweZ7aEi0Lg+zVpCarMnzFq35PhngaVH1nWrKHBbH4vapgfCQ+GIN/Y4XWauhl/4eGKh+m1GpkaPeB87lH8bAPjWgy7QPHFkyCIVDBz4zdJBGJu4sQN6G7AR++zvkV4OxaUT1gmEsnurKMIA/rkIvtagRvZEJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYxDnPRi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28a6cef709so102009766b.1;
        Fri, 09 Feb 2024 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707476745; x=1708081545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbaeKdjw60cNsDBZcRkItqfkpOC+hAL3qmMor2xymZ0=;
        b=GYxDnPRiyxUbrroJpsDkFQ02qntzXzvFpSCz10+b0B7NTPR7ZC4JsbHHWVOqZZi+1O
         1Yjta47RKcyFlN0MHdG9dV9eLuevyIyp9tP2xODKMwOpmwcP2IcIgdfiMhYA/deDTKMW
         7NNkUq0fY3ENrNSEkmpXyE/PY+3qY/An6evwWKXM2dZnfHctkug7NJtSLJDlu1/t/mSx
         8n7MAIcof0ZEiIdNizB3hLM9lTQrCZNpkJ34SwyJhzKqjtAyHNeuDZjB+xXBoOOZUt1M
         mel/fG3kVuliTYB7qNAVFlrUHv0RG6tRdx67RNMwe7L5JKldfhHPzx1B79dPXjhZE/yH
         Udiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476745; x=1708081545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbaeKdjw60cNsDBZcRkItqfkpOC+hAL3qmMor2xymZ0=;
        b=fRzFHyI9XdAebowcH4dI/r4GN7g0dI0qMuSnxMRURZIHALL5oT5lEiAXQJAb17brbk
         aaYRvNWDKz61TySbbGHmO0hV35t/u7tjYaB2gOlpM4OBX0lD5sB6xgwlqhv0Omw1CvEJ
         jykxW+CxYrxw55XoPAsvUOoFJenlhCPdFI3Pxe7x9n4x24GLa32x/iXOyaoJW9xMolOF
         gdLK5RZP4j64dmmGO1Nj+HkB5Aqa6ezyXqhaTnUIZSUGiWlWXLInP+49+dwLrQ+w6k/s
         1fWe7wphWRPUd/w/f/067F7aQJ3p1gHXzVU6g2L5IDmu6qEgbhppt0odBAFLcavthm4N
         RHoA==
X-Gm-Message-State: AOJu0YwyvEhi9gQ/Y0oKLDQAGQ57c8i0cCLRrkzQuR0MmfAdpLwNseCK
	/ZcUGL9Qf2DdaH0PoSHTxNQ6H9IHq7K0EXzIxzYrTXsQmrpzDv/QJ+Ya9j21yqw=
X-Google-Smtp-Source: AGHT+IF1K8ViNAW3P+fefZz4G5jK2tN/Sn4NqbfifXPw2j4rGzGbZ3qD3nbaSf+I5j4uU3afSLWW3Q==
X-Received: by 2002:a17:906:2dc6:b0:a38:42f4:dfb6 with SMTP id h6-20020a1709062dc600b00a3842f4dfb6mr958758eji.63.1707476744531;
        Fri, 09 Feb 2024 03:05:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8H9Oqo/86n65sM39xyh0B3MD99Tc97Z87eRmLSOIKEQOZIhRAIBKUqlG3ky3zVbtYSeUy4MFPnGhr502vVr1VxSSzk6MeGqFCMbBrKkC7ch/5K+p7MhoD3I2HV+/rrhoUkWDLzTKTyl1oZ481k3BVQn4qhwft7Lk/peodlBjH0kRmHN9dgFaTjX7kinuKBKENYrj1BonzTLa1EMGbsiMDIG9tT9DQU8FgrjYxYQDgfbdzhNNZpHBpT03RoVo2OWTC+SXl5GoSyaRhDJyJYCuLfGGZUqX3YMYHNjlevSCeUxbC/e643moYXTCxFz7Uj+vGzLQPyIlptoubOH7EUw==
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch. [77.59.154.235])
        by smtp.gmail.com with ESMTPSA id kh20-20020a170906f81400b00a35cd148c7esm637832ejb.212.2024.02.09.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 03:05:43 -0800 (PST)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: add support for Verdin USB1 interface
Date: Fri,  9 Feb 2024 12:05:00 +0100
Message-Id: <20240209110500.22193-1-andrejs.cainikovs@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Add support for Verdin USB1 interface, implements role switch
functionality using "gpio-usb-b-connector", VBUS is also now
controlled with "regulator-fixed" using a standard GPIO.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 55 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 6a06724b6d16..bfd44f4a15cf 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -42,6 +42,22 @@ aliases {
 		usb1 = &usb1;
 	};
 
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_id>;
+		id-gpios = <&main_gpio1 19 GPIO_ACTIVE_HIGH>;
+		label = "USB_1";
+		self-powered;
+		vbus-supply = <&reg_usb0_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb0_ep>;
+			};
+		};
+	};
+
 	verdin_gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -151,6 +167,18 @@ reg_sdhc1_vqmmc: regulator-sdhci1-vqmmc {
 		vin-supply = <&reg_sd_3v3_1v8>;
 	};
 
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_en>;
+		enable-active-high;
+		/* Verdin USB_1_EN (SODIMM 155) */
+		gpio = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "USB_1_EN";
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -436,6 +464,13 @@ AM62X_IOPAD(0x0244, PIN_INPUT_PULLUP, 7) /* (C17) MMC1_SDWP.GPIO1_49 */ /* SODIM
 		>;
 	};
 
+	/* Verdin USB_1_EN */
+	pinctrl_usb0_en: main-gpio1-50-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0254, PIN_INPUT, 7) /* (C20) USB0_DRVVBUS.GPIO1_50 */ /* SODIMM 155 */
+		>;
+	};
+
 	/* On-module I2C - PMIC_I2C */
 	pinctrl_i2c0: main-i2c0-default-pins {
 		pinctrl-single,pins = <
@@ -660,13 +695,6 @@ AM62X_IOPAD(0x0038, PIN_OUTPUT,       5) /* (E24) OSPI0_CSn3.UART5_TXD    */ /*
 		>;
 	};
 
-	/* Verdin USB_1 */
-	pinctrl_usb0: main-usb0-default-pins {
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0254, PIN_OUTPUT, 0) /* (C20) USB0_DRVVBUS */ /* SODIMM 155 */
-		>;
-	};
-
 	/* Verdin USB_2 */
 	pinctrl_usb1: main-usb1-default-pins {
 		pinctrl-single,pins = <
@@ -1013,7 +1041,7 @@ &main_gpio1 {
 		"",
 		"",
 		"SODIMM_17",
-		"", /* 50 */
+		"SODIMM 155", /* 50 */
 		"",
 		"",
 		"",
@@ -1428,11 +1456,16 @@ &usbss0 {
 	status = "disabled";
 };
 
-/* TODO: role swich using ID pin */
 &usb0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb0_id>;
+	adp-disable;
+	usb-role-switch;
 	status = "disabled";
+
+	port {
+		usb0_ep: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
 };
 
 /* Verdin USB_2 */
-- 
2.34.1


