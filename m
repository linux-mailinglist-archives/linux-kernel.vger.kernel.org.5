Return-Path: <linux-kernel+bounces-63393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A5852EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9206C1F2381E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D139AE9;
	Tue, 13 Feb 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="fa5EyQD3"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B5938DF5;
	Tue, 13 Feb 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822135; cv=pass; b=FPeFfK19y1CLXA+POfZpFSiqNeoCGjcNv8edTqWDFGnnSBJJgpfRMdGngDyBQdy+x5BmNuDlpBrXwcfyJNKgmiXNF0ioNKrwAhfavDKsPPVyMdq6KYFxoontCFTPKtxqzfZMTTuaPNLTm9+0UP1Jqw+OScmqBzDrKY1M50TW1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822135; c=relaxed/simple;
	bh=ZZJDvmwgaVNUkd/QLeaQQXIy40n2tDqzdfn4OklKNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWkqSrr8Q/nLiiRwBO7po4pGhxNHNJIaGUIyHChgVxdSD0UTfHSt/Az4ryKE2PGAe/y4eUI0fNjGbbivD1i6aOn5flHYCDUPipBBM6xKGD2GAOfpfrZg5baaU1Eiwt0UnM3konKJYlQj6Vnd/p9FxN8V2fgzi9wHcU1DsJz8u78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=fa5EyQD3; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1707822129; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d9HezmARuJAYGFSwJ1LTdYoq58QKthHAhTLkBJUXfgzvkgS+sQ19AgrGLNgubdhIQFVB+epcMX8Iz4w4NTj6szBFPYNS5LCJonn3DaF0rxI3WCYsDvinwURYYxdUxFHWHqNQ+xVHEwm0bWF1GYJr1vAoY1RUOkA/tXKAbAY7y5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707822129; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j651x5Hilte5Xbmo4xSk1+lCVyQJvHUohQWSnBdMyQw=; 
	b=g4Mtnz7meTtxytGrX+owcyM+GlPTo8tAatTZ9ydEtHIc8NWb6BNd4QnbiEEdFDyrkZo4qqtG7LPm/HDgn4fXetc5cX0VoPsCzCH0gtq4jveKQuk5OrK/csN+5iGGNI+26ZMdUADWoRVavwB4VNk2ImU6tsPZr5shIbAxGTAyRHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707822129;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j651x5Hilte5Xbmo4xSk1+lCVyQJvHUohQWSnBdMyQw=;
	b=fa5EyQD3TQShmT/mjR+73kLJ1n6QjAdQ7jw85rRFHkeNOJ0pPs+JebFFtqAocqd9
	t1Le7wL/er9mmXCG/+BqYHW7XTDtWX40gr3T+vHUfqf5+GbyBoKGoGxu4dWGJtRKhvb
	PYrbppfHeIjM9w8hAb3QQxqOWMdvLd5Q/5ohdSZ8=
Received: from localhost.localdomain (163.142.242.182 [163.142.242.182]) by mx.zohomail.com
	with SMTPS id 1707822126636336.74326025946925; Tue, 13 Feb 2024 03:02:06 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 4/4] ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)
Date: Tue, 13 Feb 2024 18:58:39 +0800
Message-ID: <20240213110137.122737-5-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213110137.122737-1-i@rong.moe>
References: <20240213110137.122737-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The only difference between Samsung Galaxy S5 China (kltechn) and klte
is the gpio pins of i2c_led_gpio. With pins corrected, the LEDs and WiFi
are able to work properly.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 arch/arm/boot/dts/qcom/Makefile                  |  1 +
 .../dts/qcom/qcom-msm8974pro-samsung-kltechn.dts | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts

diff --git a/arch/arm/boot/dts/qcom/Makefile b/arch/arm/boot/dts/qcom/Makefile
index 9cc1e14e6cd0..5d7a34adf826 100644
--- a/arch/arm/boot/dts/qcom/Makefile
+++ b/arch/arm/boot/dts/qcom/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974pro-fairphone-fp2.dtb \
 	qcom-msm8974pro-oneplus-bacon.dtb \
 	qcom-msm8974pro-samsung-klte.dtb \
+	qcom-msm8974pro-samsung-kltechn.dtb \
 	qcom-msm8974pro-sony-xperia-shinano-castor.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb \
 	qcom-sdx55-mtp.dtb \
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
new file mode 100644
index 000000000000..b902e31b16c2
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro-samsung-klte-common.dtsi"
+
+/ {
+	model = "Samsung Galaxy S5 China";
+	compatible = "samsung,kltechn", "samsung,klte", "qcom,msm8974pro", "qcom,msm8974";
+};
+
+&i2c_led_gpio {
+	scl-gpios = <&tlmm 61 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&tlmm 60 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c_led_gpioex_pins {
+	pins = "gpio60", "gpio61";
+};
-- 
2.43.0


