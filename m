Return-Path: <linux-kernel+bounces-41949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0783F9E8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC461F21ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8D63C063;
	Sun, 28 Jan 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="bFmkZPm/"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473252E832;
	Sun, 28 Jan 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474926; cv=none; b=aoyJQ7kZ64KPauof89tLXAZvdXwq8JqvHihMdFG4Wuw1L2dFlLQLL0cmZn3v5YkGRPn3xH+F/tGfX8wLsQTAw3LRCly0msb3FShPhoD8YyKM3nv+4AilkSFpbZcKmNTwo0UpMeA1VI99KrY3p+4Bmuqp+EgiTktSgdl6a4P/8tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474926; c=relaxed/simple;
	bh=ag9tr2tiU3unZXuvPUm4zcESACgalTxlviYKmkloah4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxIMx0TR3bZVBwcdG5Z/rBrBzHFz1UYForxoh8XoH8fiVZsnzgXPz6ipZ43jrpwvKTjsVT9E7R1MkW/L9uQGo2Frus43hwBTwhvqmCC/55KSLdIbuug8E1JmPiIH6JXyb6/RsqtPsG+TH+kh0JCdloTfGE4e9dQ1LiO9W3mzbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=bFmkZPm/; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 414794653B;
	Sun, 28 Jan 2024 20:48:42 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Miles Alan <m@milesalan.com>,
	Ondrej Jirman <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor led node
Date: Sun, 28 Jan 2024 15:45:09 -0500
Message-ID: <20240128204740.2355092-3-aren@peacevolution.org>
In-Reply-To: <20240128204740.2355092-1-aren@peacevolution.org>
References: <20240128204740.2355092-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: **
X-Spamd-Bar: ++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706474923;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=LF65+XU8LGrrA9Zpn4EYhMkrdltaZDZoBBCOReuYI8w=;
	b=bFmkZPm/+Yyttzt/b7BF92FqLnBgnS1PONw3BdS3t253B/ffa43+54TaQ8sg3Rb4Ig/Wzo
	Paho7iUNgddGj8+9a/Thzyj9W38GTjreOru4TPAdIPqVdQGr8aeSPsNbTA5wIMUqVQiH0F
	fn/n6G+oE80ZW9yQmoCUfHCDouUFUd8=

The red, green, and blue leds currently in the device tree represent a
single rgb led on the front of the PinePhone.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi    | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index ad2476ee01e4..6eab61a12cd8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -39,21 +39,21 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		led-0 {
+		led0: led-0 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
 			retain-state-suspended;
 		};
 
-		led-1 {
+		led1: led-1 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
 			retain-state-suspended;
 		};
 
-		led-2 {
+		led2: led-2 {
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
@@ -61,6 +61,13 @@ led-2 {
 		};
 	};
 
+	multi-led {
+		compatible = "leds-group-multicolor";
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_INDICATOR;
+		leds = <&led0>, <&led1>, <&led2>;
+	};
+
 	reg_ps: ps-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "ps";
-- 
2.43.0


