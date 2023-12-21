Return-Path: <linux-kernel+bounces-9147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E081C197
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27B51C2395C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CDD78E9F;
	Thu, 21 Dec 2023 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvGVIvhY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072064A96;
	Thu, 21 Dec 2023 23:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c6ea99429so14196435e9.3;
        Thu, 21 Dec 2023 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703199783; x=1703804583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxAYtGGvpSNlN9I0Jtq9IFgVDPHMyNzoqUOzXLWoYh4=;
        b=FvGVIvhYh4+P8kUwkRN8k9LINMiYTi+isVVlXv8lwhoIcIW+hDhvMVcE1sFQ6C44aE
         R3bIV/9Wm1FPOiZ+9ZhGWTCvZp8C7+nRb0wWAzTnGgpUurjdhh2vWmC5Qa1/tYlWqxUy
         k2QrHBe2LGF/ebwVFy7gLyw9jRMCw9VFakAXhOo+fwaiK3aKzlrzEMi83IA1DLxmiyzl
         BeWIYQgr2PINxyHozoiX3Z9xMafyHEyXu+mWC7pIlvJCLP/A+GXBNJgSw2QRWQJfCA7K
         ojbyolkcAeikAFst/WVyFbCp9eOKzcr1mhCTDXNjaSKuXszah6mXg3729KvW4T9XtO+7
         5UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703199783; x=1703804583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxAYtGGvpSNlN9I0Jtq9IFgVDPHMyNzoqUOzXLWoYh4=;
        b=HNLBEzNHZvI+HbVIRk5lsVBss5n7blSijEEzFo1cOWk0lfPEKLisuoySSODSRaiO4L
         wfX97baBp7ormAJNqVx6vAC0Dcu4/QeAF1yeEdZ4H1FgLzl5t1tEJ4fEZed7lJJ3DW0v
         X/WikLdtgWHVBsfZtxWmtAuwxnQr620qzYxYgvOMOnaPAaY7U/jPQuAGEtV0tjUoiqWt
         ICZkQAQZWWoMgRxxm9Mhfthc7Zw9a5nrihB2jbYTpW8zv/J1bQUr//HbuJhsi/WELIGQ
         aBDMgS6YEzY6SN9/UiaOxRrqWEuXY6aQi+Ujbb6Eo7GFElk0aAR9er62rM+/1U1gc+hk
         tteA==
X-Gm-Message-State: AOJu0Yy0O2OjkjfBUawU3TwLF3Qtrjo6KJi/CPEYT2yqasCbA9dWkEJg
	RcbCGvyrByzqoAu1BGDNnt4=
X-Google-Smtp-Source: AGHT+IEOP+HDohFwrMXh60IH1fdkrPq33q53jmpjczjz+BTaITBx8sVji+NKynW/nHWrsJZy3bGjHA==
X-Received: by 2002:a05:600c:a45:b0:40d:37d0:e66 with SMTP id c5-20020a05600c0a4500b0040d37d00e66mr169606wmq.258.1703199783028;
        Thu, 21 Dec 2023 15:03:03 -0800 (PST)
Received: from adroid ([2a02:2c60:f18b:5f60:b2a3:31e6:bf5b:266a])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b004094d4292aesm4835221wmq.18.2023.12.21.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:03:02 -0800 (PST)
From: =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	martin.juecker@gmail.com,
	linux@armlinux.org.uk,
	krzysztof.kozlowski@linaro.org
Subject: [PATCH 1/2] ARM: dts: exynos: add accelerometer and gyro to p4note
Date: Fri, 22 Dec 2023 00:02:57 +0100
Message-Id: <20231221230258.56272-1-martin.juecker@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add entries for LSM330DLC accelerometer and gyro to the p4note.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 .../boot/dts/samsung/exynos4412-p4note.dtsi   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
index 0b89d5682f857..39a3d1cbe4c3b 100644
--- a/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi
@@ -362,6 +362,39 @@ &hsotg {
 	status = "okay";
 };
 
+&i2c_1 {
+	samsung,i2c-sda-delay = <100>;
+	samsung,i2c-slave-addr = <0x10>;
+	samsung,i2c-max-bus-freq = <400000>;
+	pinctrl-0 = <&i2c1_bus>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	accelerometer@19 {
+		compatible = "st,lsm330dlc-accel";
+		reg = <0x19>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&accelerometer_irq>;
+		pinctrl-names = "default";
+		mount-matrix =	"1",  "0",  "0",
+				"0", "-1",  "0",
+				"0",  "0", "-1";
+	};
+
+	gyro@6b {
+		compatible = "st,lsm330dlc-gyro";
+		reg = <0x6b>;
+		interrupt-parent = <&gpx0>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-0 = <&gyro_data_enable &gyro_irq>;
+		pinctrl-names = "default";
+		mount-matrix =	"1",  "0",  "0",
+				"0", "-1",  "0",
+				"0",  "0", "-1";
+	};
+};
+
 &i2c_3 {
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-slave-addr = <0x10>;
@@ -844,6 +877,12 @@ bt_shutdown: bt-shutdown-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	gyro_data_enable: gyro-data-enable-pins {
+		samsung,pins = "gpl2-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+	};
+
 	uart_sel: uart-sel-pins {
 		samsung,pins = "gpl2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
@@ -894,12 +933,24 @@ ak8975_irq: ak8975-irq-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
+	accelerometer_irq: accelerometer-irq-pins {
+		samsung,pins = "gpx0-0";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	stmpe_adc_irq: stmpe-adc-irq-pins {
 		samsung,pins = "gpx0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	gyro_irq: gyro-irq-pins {
+		samsung,pins = "gpx0-6";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	max77686_irq: max77686-irq-pins {
 		samsung,pins = "gpx0-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.34.1


