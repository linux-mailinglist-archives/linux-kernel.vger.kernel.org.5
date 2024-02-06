Return-Path: <linux-kernel+bounces-55534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49A84BDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F23E1C2483C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479313FFB;
	Tue,  6 Feb 2024 19:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="VC0TL22s"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C21B7F0;
	Tue,  6 Feb 2024 19:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246205; cv=none; b=c+L2ucVjrbnqULDOjaga4Ud1HM0EMmGYhTSS+oa6c/B7u8YbZLu7sjVHESaRNOMSjwZjCSJAtUwKw48EGQ3KS/bjGws6lR29QN+TvkJf4vZsv3VsTrRPwLvNl+miwdvjzhR/0ADBqHbyol1NomehYgJoQO9lxNWY8QzfIOYYzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246205; c=relaxed/simple;
	bh=XYDsMDVcsP7odk8FeBn6mlA5XGeXcHZ/KkPG93FWgMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A89iL5JdTdLV5uCrwwkVZw2SX7CFXd0oGyh3Xy7LP2qNORnY2ZKQv09i5mVAfHyG9bSZxyBGjkOH3ElIRo10X977e1tYcaT32B4jQbBnJtu/jSCiuQ1anQ2INzLZpOrg0hQJl2OKz8ZeA+UyA2K8AQoEsM0MS3hI3GOCxj5d1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=VC0TL22s; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 081F84583E;
	Tue,  6 Feb 2024 19:03:21 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Ondrej Jirman <megi@xff.cz>,
	linux-sunxi@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	linux-arm-kernel@lists.infradead.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-leds@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Miles Alan <m@milesalan.com>,
	Samuel Holland <samuel@sholland.org>,
	Aren Moynihan <aren@peacevolution.org>
Subject: [PATCH v2 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor led node
Date: Tue,  6 Feb 2024 13:13:19 -0500
Message-ID: <20240206185400.596979-3-aren@peacevolution.org>
In-Reply-To: <20240206185400.596979-1-aren@peacevolution.org>
References: <20240206185400.596979-1-aren@peacevolution.org>
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
	s=dkim; t=1707246203;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=o6DDRcilCg3I7Q6EoW6q5k4FGWr7L3+KOlmCTdxiqwk=;
	b=VC0TL22sbbRARJCon5mZiI14jPEcLoImFrDoq4GBZtIijTpRaGeIu7Rb4q8BT7XvDWYV8C
	8VDVgnhntAT0O2UK7pTktC9szWoeqIwBuVGvqm5xc6J6Ik+j4WsX+e5a2mKsacITrRDMJF
	x+LjefqJqs/zDQmDMA6ZIr9Td8dMLzw=

The red, green, and blue leds currently in the device tree represent a
single rgb led on the front of the PinePhone.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Changes in v2:
 - remove function property from individual led nodes

 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index ad2476ee01e4..e53e0d4579a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -39,28 +39,32 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		led-0 {
-			function = LED_FUNCTION_INDICATOR;
+		led0: led-0 {
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
 			retain-state-suspended;
 		};
 
-		led-1 {
-			function = LED_FUNCTION_INDICATOR;
+		led1: led-1 {
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
 			retain-state-suspended;
 		};
 
-		led-2 {
-			function = LED_FUNCTION_INDICATOR;
+		led2: led-2 {
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
 			retain-state-suspended;
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


