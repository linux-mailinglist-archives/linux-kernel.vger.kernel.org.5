Return-Path: <linux-kernel+bounces-105313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EAC87DC1F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B51F21393
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283634C65;
	Sun, 17 Mar 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="U1SmSei6"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84B17EF;
	Sun, 17 Mar 2024 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636113; cv=none; b=o91wK5Gnh7vcZfNTrWX389bN8lmcbnGlrE4grNywsULbxN85s+b65WBEfdzjanRHuGwnww7eTOqdl5LccC1Y5CrE1Zn/2Kki4DnfvWA1qmSwwQTyzfLg4oihzQXSBQ2NCoiL0uoWEcktqXfalllnzb94r8e+NZLzBnXh1EPr7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636113; c=relaxed/simple;
	bh=1Av75hBK2ZjiFCe76QxBieMidcj3kvppPBy6JGiyhZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+mBmfSneaPsmszZOOwtDfzd9WrN8FfwGeHV+weu42R6YNEwNKLu9TJTfVbRJGOJl0DdNx/hWQwVkXqWqZi5RtF2cABi4xGpqojEzkyJVTrRAbmlW1QfI8ZJ2BjJSqZjjYHig9SpuCqWqIKY/sMNWqq8s1P6xzPDRlfR40cLGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=U1SmSei6; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 1B236476D2;
	Sun, 17 Mar 2024 00:41:50 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Pavel Machek <pavel@ucw.cz>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	Ondrej Jirman <megi@xff.cz>,
	Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v3 2/2] arm64: dts: allwinner: pinephone: add multicolor LED node
Date: Sat, 16 Mar 2024 20:39:29 -0400
Message-ID: <20240317004116.1473967-2-aren@peacevolution.org>
In-Reply-To: <20240317004116.1473967-1-aren@peacevolution.org>
References: <20240317004116.1473967-1-aren@peacevolution.org>
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
	s=dkim; t=1710636110;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=xSOAE2dp6I0YHMlx6m2sMD8XK0nU8r7fXdBHcrqXIZg=;
	b=U1SmSei6V/eleikJbTa48p9hT9eUF/zGGwo+Nx07oMdsUjkVsF70VRl5zN9TpJgxxRh/lR
	QyMf9fmyxC5ywlw2CwTUY/1o2+MlfJS0zKDlYspqNiDVfg+MPlqprjs9EaLtqn78cNGBAV
	13g2uP6W0FzatNR/y7IEgQM/DkjGASg=

The red, green, and blue LEDs currently in the device tree represent a
single RGB LED on the front of the PinePhone.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v3:
 - add function property back to individual LED nodes to minimize
   breaking changes

Changes in v2:
 - remove function property from individual LED nodes

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
2.44.0


