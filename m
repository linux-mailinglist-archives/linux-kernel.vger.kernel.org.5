Return-Path: <linux-kernel+bounces-41341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A083EF13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B074B20A44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E82D60A;
	Sat, 27 Jan 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="C7xMRoQE"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29022E41C;
	Sat, 27 Jan 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376245; cv=pass; b=U/bDnAJsiQBMZZVuvGqWxeqXWIyTBeDxnEg3be/RFbnlklPRkoOXbYYOzfFJY1zAajXk/bTwju7vRG0fe1hC+tjyKfI5GDbNT4EDXsfyJnHsFipGxV/x3gKKEv0y7A6jeMgd7pI4N4UjKkc2PZ7e7GwsNM9MBuyZkRYj+G7Q5Ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376245; c=relaxed/simple;
	bh=ZZJDvmwgaVNUkd/QLeaQQXIy40n2tDqzdfn4OklKNVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKkDi9Gn3y1oiEpZ0WV5lOnZqRXuk6+lnnQu6rK4iwL+SkPdNqrsayo+2I4omN6o9ImeMzh1ChuzYWeoCnk3FoHVDXGgDTlSNVGJAce8KMyzD4p25G8yumsY0QJLlsApRDySlNIUY876CjuXyO4LVTxP9mFyHsKZQlFoRhrCDtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=C7xMRoQE; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Delivered-To: i@rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1706376240; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nTPb8H7xvRgdLGEg2j8n83xs1KESybnQCz5lyIuil0J39LUkdE1p3QfZ0wg4ikORaQ517AQNbiOG5b0n3H2RJVEM6Q2zM4mGf8JXW42+XBrnbaMh+cRfV6q1ENRZ8m8VzwCdHpVEDr+B6SQWBfng1ZnM4kTGBqdoxGQ8AX4iqEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706376240; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j651x5Hilte5Xbmo4xSk1+lCVyQJvHUohQWSnBdMyQw=; 
	b=CEEeMxdwNdLypKowaFmcHBUmeqYr4bIcTWuOumFPA8y5WKOwLSnITmmh+07jdUT6EC7h2p8o/QdGDrr0AGu8r9YnLrUx/qn+TqQ2/6bXPRyAEeNlEI5gnuYCCj5T6JaQHA4cEQl+jBDcxxR807Xzu0Yu8mkMWrC0FO1Cv4Qw0kY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706376240;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j651x5Hilte5Xbmo4xSk1+lCVyQJvHUohQWSnBdMyQw=;
	b=C7xMRoQEth9LevVh3MTtyXoIBncnolsugccpdeifSTkVtGnQB7343r6fBJWO5b35
	xH/qAFyvqfH1exttrDlp1vH6VyukwTMN14QjwN8VL4s9/aOiGutUkfVM9xCEYY3W/xP
	Pe9oJh9STJwHcnLWkS4U8QSHksLDHhCZampfs8jk=
Received: from tb.lan (182.118.239.249 [182.118.239.249]) by mx.zohomail.com
	with SMTPS id 1706376237613521.4403435319042; Sat, 27 Jan 2024 09:23:57 -0800 (PST)
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
Subject: [PATCH v2 4/4] ARM: dts: qcom: msm8974: Add DTS for Samsung Galaxy S5 China (kltechn)
Date: Sun, 28 Jan 2024 01:21:53 +0800
Message-ID: <20240127172155.63624-5-i@rong.moe>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127172155.63624-1-i@rong.moe>
References: <20240127172155.63624-1-i@rong.moe>
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


