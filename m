Return-Path: <linux-kernel+bounces-41951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04683F9EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF0B218ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF03C484;
	Sun, 28 Jan 2024 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="LCKLWsPl"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB33D568;
	Sun, 28 Jan 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706474932; cv=none; b=okGhcue5hG0yueaezKnh0BqhNSMRs2PUEa0GFzhGfQOxPQuzc6KXxc1VXESqT8VaLxiQidz3VSNrJGav2F/Hf4orXc7l7GrwosEakVorVGnM1XPD5ps0FMsQ5wcunksgnqxviaceQHxl7G+Sw3nQYxXN/UKPqudQU7wreEejSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706474932; c=relaxed/simple;
	bh=0llpIrBcrSsgkq+tDt1UudYHAWxp0O8mGXQOF1XSgn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOFuyXajjpI9cES4T0zLQasnOgyrkULcFwVe5ivt21yCcPbzRoKzNTbaGUHyeFMsxj3RAuZ/XH0hzh1L3gPHcARMMw+0hFKRQWvK/pSgB+GlBgx9KRuD5y4q1J36Zg7mhCG50AUt0S16Oz9gPGUQWBh6hdIFocvHfLHSLsVRCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=LCKLWsPl; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id F2CFE46366;
	Sun, 28 Jan 2024 20:48:48 +0000 (UTC)
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
Subject: [PATCH 4/4] arm64: dts: sun50i-a64-pinephone: change led type to status
Date: Sun, 28 Jan 2024 15:45:10 -0500
Message-ID: <20240128204740.2355092-4-aren@peacevolution.org>
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
X-Spam-Level: ****
X-Spamd-Bar: ++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706474929;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=d/DBwpJ+je99z0h/gXOCUsLpwa/Zbmn1hRkJbFumB7A=;
	b=LCKLWsPlqvRQtiFZG1vk9RGo0PpHdusVxfhM+KBizv3IAzHDsEBOKiiqeQm2cRJysOQFlj
	yPD70phfaq/ONb8DwmyRcEqXprMWwQOEdEHKTscwSMPBAhH8XM4LwjOs+hHD/8GPzG1smq
	Sh/bcnY8qMKjVHRvgiSCewPgy+j4XG4=

The status function is described in the documentation as being a rgb led
used for system notifications on phones[1][2]. This is exactly what this
led is used for on the PinePhone, so using status is probably more
accurate than indicator.

1: Documentation/leds/well-known-leds.txt
2: include/dt-bindings/leds/common.h

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---
I can't find any documentation describing the indicator function, so
it's definitely less specific than status, but besides that I'm not sure
how it compares.

Please ignore this patch if it's not useful and/or just causing churn.

 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 6eab61a12cd8..4f39cfeb13ec 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -40,21 +40,21 @@ leds {
 		compatible = "gpio-leds";
 
 		led0: led-0 {
-			function = LED_FUNCTION_INDICATOR;
+			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
 			retain-state-suspended;
 		};
 
 		led1: led-1 {
-			function = LED_FUNCTION_INDICATOR;
+			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
 			retain-state-suspended;
 		};
 
 		led2: led-2 {
-			function = LED_FUNCTION_INDICATOR;
+			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
 			retain-state-suspended;
@@ -64,7 +64,7 @@ led2: led-2 {
 	multi-led {
 		compatible = "leds-group-multicolor";
 		color = <LED_COLOR_ID_RGB>;
-		function = LED_FUNCTION_INDICATOR;
+		function = LED_FUNCTION_STATUS;
 		leds = <&led0>, <&led1>, <&led2>;
 	};
 
-- 
2.43.0


