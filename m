Return-Path: <linux-kernel+bounces-32101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA62835677
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D384B22081
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58636381DC;
	Sun, 21 Jan 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ZYGyGapl"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A950381C7;
	Sun, 21 Jan 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851688; cv=pass; b=uu/TPMIm6GGYLvJOOYIRIAnr3q5FS34dg4jfdOg3cQMGyW9R+zpZaBRWnU78jogzS/MF9QBOJ12bBKG/TMWKJsSmForormS8S/5wQva8EkEfPDLUKCq66GZ3BWDZr9lZzdKYTj2Y+JnsDGan9nOxdQlcAEwz4rUUwV3wIuFJGus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851688; c=relaxed/simple;
	bh=JNfgDL/TeVgg8JNSE5SizE4qw0dFiHemtFsgCnT5juA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kERhD7j6LGrkJxFHqtfhbNhE0ckMUb0id1Z3R6smsqD8hSTLJ4IlRdv5g1UM+Dx0m6hHCHaFihBmx5B4WGUcuTO0MeE/HMEkaGtBmX+l0yYCmr2uhOXxfEz9rHeqprzyPVQMYpG3mmofylkLqKZXp+JrzSW3AbjWKZqVcM5xCsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ZYGyGapl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1705851683; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=beDkvSKJd5TjCIIZ8tUMWLRFxYQJSu+l3aEwpK58VOXJkcSZss5Eyun3pcBkKw1lhXSwuVKkIUUR9ZGWuwOz6BgJnyh4ixmbBGYBFETMNcC7ptwcNUpJz4++s55EBKPUHXaRKajEj8pBN5cFMpWFpq00SF7Ud7D1D1UoavvlmyU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1705851683; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eBi1Y9eM2A7qnPGgBFbKaTHtAvRFCRKahm/+T4CdbUg=; 
	b=TyuOSRGgtzwRSO7aQveJ8/0MIuU/1PYrnS0MJDbyxa7p1nGWag+H0FeapliFqxELMmxInKolbjy/Cae2nSncsnaCzRyLQ6SWSc2FUp9bVWQ/HM2W9i6eAMW7HEe8Mze8ETXRLSxPROEAJR4Vr/amvHU1HLGGquWyv2KCdPHOpUY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1705851683;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eBi1Y9eM2A7qnPGgBFbKaTHtAvRFCRKahm/+T4CdbUg=;
	b=ZYGyGaplgv2Lh2Cd7VYJjr426hzWAqHBmoRNq3YKeaS6NY3KfVFYMm3rx45sEDPU
	tSJmrK3AAPI8xbT5iaONKszxh0OdINLZx+mTNQLy0vjaanpfS284uA32s+SNDIenRny
	v3uC60TPC/qtUOsZ2cAqeXSfxLziiGSfyuxEUIC0=
Received: from tb.lan (182.118.232.129 [182.118.232.129]) by mx.zohomail.com
	with SMTPS id 1705851682507923.9002906477932; Sun, 21 Jan 2024 07:41:22 -0800 (PST)
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
Subject: [PATCH 4/4] ARM: dts: qcom: msm8974: Add device tree for Samsung Galaxy S5 China
Date: Sun, 21 Jan 2024 23:39:59 +0800
Message-ID: <20240121154010.168440-5-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240121154010.168440-1-i@rong.moe>
References: <20240121154010.168440-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This device has little difference compared to Samsung Galaxy S5 (klte),
so the device tree is based on qcom-msm8974pro-samsung-klte.dts. The
only difference is the gpio pins of i2c_led_gpio. With pins corrected,
the LEDs and WiFi are able to work properly.

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
index 000000000000..5a8d59ea4439
--- /dev/null
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-kltechn.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-msm8974pro-samsung-klte.dts"
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


