Return-Path: <linux-kernel+bounces-139985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074628A09FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BD31F229A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4FA144308;
	Thu, 11 Apr 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="scrS35vM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BF13E8AF;
	Thu, 11 Apr 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820892; cv=none; b=YC/Jc6VBU4zjMMYc7iHeJKXFNXRxMU6dMg/JnPUWvIGOThadOFX+OsI92m3h7hnZaWtcc2poFDuixCySTuqUJdWCbx2x9409o0wFjNDH+12sBiYDgQ7WBKFiaO9bG75/zJK0JrxOrvjr1GGkA+0wGVJuLaebXfSDgc6IewIqAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820892; c=relaxed/simple;
	bh=kB9NettRHrQJ0wmQbwmfLEJttKgN61Yxe/mRrZw/jVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRwiTe7ZUjTaxIHVsKeIzNqiRX46FBcsUtpxg5UhNBCeJ2mZ6EDvLfWdnKhGXAgOMbEFvn2RG0DmGu2wN4/CZBun2UjTt/GtZflitD7QrxKckItdE5FLRwsaqYiMQjSS3QtZUxXDkwYna8pbiJM9qHBls6iwRA4OTkF/dMtxmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=scrS35vM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712820890; x=1744356890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kB9NettRHrQJ0wmQbwmfLEJttKgN61Yxe/mRrZw/jVU=;
  b=scrS35vMEWrMMA7c8ZXe21R44OZ3xZ4cXJ3f9yxt2VazIuID/8JyYLVU
   uEFhYcmobyBdmEHEAQiuqlrZDsX0O8+rf6kqumSUjmnwPjPjS7IZdFxV9
   2SAUYE5IvuKjltRTQtUgbe6jvJ9D/5w6cl9I8T81U4WG2TgQVIC9zw3oF
   66TCG7PNwpHkeoSpHPkawEiiEDWRkbdk9tSofdw/XTntMXnDWMoY8rkHU
   pKjioHaBqGeKU7rvTzDgE08iQYxKlHrU7jzRE3PxUCAmTTodlMIOcdGnd
   ZeFk3/vskE+eeoBWNcCW5jiLi+Tv+BWcfsGM5ZpdxUZXo3eScRcvJSa1S
   w==;
X-CSE-ConnectionGUID: jDRmTUiXRgK//h330KmRHg==
X-CSE-MsgGUID: LvKumdHFTueYQi81X5jJEQ==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="21068910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:34:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:34:19 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 00:34:17 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 04/13] ARM: dts: microchip: sama5d27_som1_ek: Remove the empty lines
Date: Thu, 11 Apr 2024 10:33:44 +0300
Message-ID: <20240411073353.3831-5-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411073353.3831-1-mihai.sain@microchip.com>
References: <20240411073353.3831-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove the empty line 482 from gpio-keys node.
Remove the empty lines 519,530,542 from regulator nodes.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
index f3ffb8f01d8a..8597e7541dfb 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_som1_ek.dts
@@ -479,7 +479,6 @@ can1: can@fc050000 {
 
 	gpio-keys {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_key_gpio_default>;
 
@@ -516,7 +515,6 @@ led-blue {
 
 	vddin_3v3: fixed-regulator-vddin_3v3 {
 		compatible = "regulator-fixed";
-
 		regulator-name = "VDDIN_3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -527,7 +525,6 @@ vddin_3v3: fixed-regulator-vddin_3v3 {
 
 	vddana: fixed-regulator-vddana {
 		compatible = "regulator-fixed";
-
 		regulator-name = "VDDANA";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -539,7 +536,6 @@ vddana: fixed-regulator-vddana {
 
 	advref: fixed-regulator-advref {
 		compatible = "regulator-fixed";
-
 		regulator-name = "advref";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.44.0


