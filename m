Return-Path: <linux-kernel+bounces-133316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D989A221
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A71F2101B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905217276B;
	Fri,  5 Apr 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgsA0K8c"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7317109C;
	Fri,  5 Apr 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333265; cv=none; b=hQbSKhAIg2z/pfcpHl2NP/0DS7lzIcca2rvQn2S4tF2vYFyJC9t6e+N6zVDDUE/pqLCQf9oDbHkC8PTF+M2AvBpRdhd+jJtyC3pUzJ1dSmTpEEfiDSA7+aq7AuH4KPjajv6pCydC9bgCo3kMf4ozJgHxVJ3WuAjXcl9W14swFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333265; c=relaxed/simple;
	bh=s2oelWPLHDUwNqi9cCjSGSaQzE7ldrgKjOrCLiSRNug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D471JDL/2MMe/y7GzGsKBHDonnkf8U9hy2f8rY/zOu9vbyktmLM1M+9GETXkQ/qPSOj7ZgCfXCLuzXLsgO9QXnYReeMrUq7erMfceu4UH989rrvgKJHqkMqdII/3jgonxLcGcqXYPXPbtgOO6+JMzimV33Mt1d1lLmCs7NIlZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgsA0K8c; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-416317f5346so3869115e9.1;
        Fri, 05 Apr 2024 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712333262; x=1712938062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWZ/UFU9OUajltHDRCM2CeH0LshCjJsNLCkamYUQgwY=;
        b=MgsA0K8cB0zkMXMWo9X84y11IYKxdR0h7POgC5DWmhQ+WKeEaYcDDCJFOM4gUOM6aM
         T367X+Uqi/gxPN68S+yfR0sdhIiR5ac1zyhkriP5ZTs9eko4m6LlyXSUnspNaVapmXKo
         NqRmctfAWa0B9u5dB6PQdRC8hLUYm72i0SCJJoo0d0EfbHj516108hClI9zeqohPoZ6E
         6cTxMMKU/qvWxFbzqZ+rrN5htXpqaAIx0XYP98TJvj0zZsYjQtyxstct4UQVEuu+Cjv/
         /zUDea8WE6Eh1FBiFmVTzmcVaGg9n7P5HHd5NfvkS3PAC9rp9xIQ4az73GYc9oFPTaqm
         VcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712333262; x=1712938062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWZ/UFU9OUajltHDRCM2CeH0LshCjJsNLCkamYUQgwY=;
        b=A0HjfOHBhIOWa1jiT0vUSBnfP40hwbrBGtkn75C5iBDjiZbXWrCGk7bIU2tC1tcNwg
         WppOeLysUW8Kk9CJ2bVU1/C4E86/oSxUpWB/NnapRa8UsukWfJhP+IvIMo3PwoR2IPkA
         3eIJKA0G3oF/SkdGWjlOUZNdd3fS1QR1o20X5ehPDHa2V0+I3VSml8wKqL3DTynyJ4uR
         bccQTX+Ed1zzNHCVZ+YDxAwV5AnNjRV27wBncwF6/kUappDwfyO/U2MrOaf000eK/6ML
         EZbp9EYiCOKIGE5ziqsSAMLsJPEEt67baCZVcfdwMcL9CuRZlrgaV26NPhAhBY6ZwcHd
         7trw==
X-Forwarded-Encrypted: i=1; AJvYcCXPM2HZTFlxj2KyaoebT8mZ7azagY3vZnGPTzZt9dOrX+gqLl1lvbZ4DrYUq2hQgGC0IA2bYAQqCUpxkJlG82obSsSCQnoco8oQ8Kl+
X-Gm-Message-State: AOJu0YwUIv1yeNMFclu8rU+vewfKTEBfJE95QaGU6ADIE7H7QWtQK1+O
	izqKFuUW+Pcn8KHTYmQDIAFbcb+DLKiIoQ5/2H6gUyqOxFX8uqoS
X-Google-Smtp-Source: AGHT+IEIEeAONGwQhGeJMxNS3GD/dJh0uPbqMERZziPL6q1ylU9BP4frM9EsEdBFmc2rYLQVFaQ9+g==
X-Received: by 2002:a05:600c:1e13:b0:416:3326:c150 with SMTP id ay19-20020a05600c1e1300b004163326c150mr440524wmb.29.1712333261663;
        Fri, 05 Apr 2024 09:07:41 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:f624:ad13:2091:c808])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b004156c501e24sm6902651wms.12.2024.04.05.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 09:07:40 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 4/4] arm64: dts: freescale: imx8mm-verdin-dahlia: support sleep-moci
Date: Fri,  5 Apr 2024 18:07:20 +0200
Message-Id: <20240405160720.5977-5-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405160720.5977-1-eichest@gmail.com>
References: <20240405160720.5977-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Previously, we had the sleep-moci pin set to always on. However, the
Dahlia carrier board supports disabling the sleep-moci when the system
is suspended to power down peripherals that support it. This reduces
overall power consumption. This commit adds support for this feature by
disabling the reg_force_sleep_moci regulator and adding two new
regulators for the USB hub and PCIe that can be turned off when the
system is suspended.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index b64dac4f29c2..393fc9e20423 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -32,6 +32,25 @@ simple-audio-card,cpu {
 			sound-dai = <&sai2>;
 		};
 	};
+
+	reg_usb_hub: regulator-usb-hub {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		regulator-name = "HUB_PWR_EN";
+	};
+
+	reg_pcie: regulator-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		regulator-name = "PCIE_1_PWR_EN";
+		startup-delay-us = <100000>;
+	};
 };
 
 /* Verdin SPI_1 */
@@ -98,6 +117,7 @@ wm8904_1a: audio-codec@1a {
 
 /* Verdin PCIE_1 */
 &pcie0 {
+	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
@@ -120,6 +140,11 @@ &pwm3 {
 	status = "okay";
 };
 
+/* We support turning off sleep moci on Dahlia */
+&reg_force_sleep_moci {
+	status = "disabled";
+};
+
 /* Verdin I2S_1 */
 &sai2 {
 	status = "okay";
@@ -148,8 +173,16 @@ &usbotg1 {
 
 /* Verdin USB_2 */
 &usbotg2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	disable-over-current;
 	status = "okay";
+
+	usb-hub@1 {
+		compatible = "usb424,2744";
+		reg = <1>;
+		vdd-supply = <&reg_usb_hub>;
+	};
 };
 
 /* Verdin SD_1 */
-- 
2.40.1


