Return-Path: <linux-kernel+bounces-133650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3513589A6AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08211F26961
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B8185F1E;
	Fri,  5 Apr 2024 21:47:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B717A91A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353640; cv=none; b=eACpTy2PLmO5OVTyQ+E2Xf/Cy6IZaG+W6/YorxEQtY/uCepq3+K4YpIa0lWGmoMOcd8e7rZnr6X2LHFtrU0s7Sv4zGUh+jE7sObmg3Q76lqWlIUQ78SPpz77mx4PQSnPL9zQUdMYx+g1ogmmGJcqTq3WBQwln0v6YNvLMHR14g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353640; c=relaxed/simple;
	bh=1OYSF06d5TIhc6A7R1nQSIWp7YGWGjSxOpQ3PlpLjvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE2V9EdU81NI41C/xMjJsntjl45KDZ+M/kDZhoK73mAUu34oZBHGz0cOYqC8Qagf0byWImWo8xCXaWqWOlhUOYjoKMacz2NHWp7FmGrpCpdY4JUne2o3ojhqhbkySXOXp2KnToRVSqHe9ewJI1/9ZJ72KMl6YIn5AIgvNsNff90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-0003H3-Us; Fri, 05 Apr 2024 23:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00Ad4V-GY; Fri, 05 Apr 2024 23:46:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00FZpe-1N;
	Fri, 05 Apr 2024 23:46:47 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v1 19/49] ARM: dts: imx6qdl-gw5903: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:06 +0200
Message-ID:  <ee6ed6ee4e72db4caac9f5694b336eb154e043f1.1712352665.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712352665.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1OYSF06d5TIhc6A7R1nQSIWp7YGWGjSxOpQ3PlpLjvc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHBfhyVUQsBrz0bHx/XcO3ip6/CN3Ls5Lkewh BY3tdoprcKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwXwAKCRCPgPtYfRL+ ThAQB/9LlS/oWREcl2yKDcOcMiGwq0RgPNsxfFJaQASPLRFa5txIBqL4fVt9eM70ROm0CHzqzoG NgVeTisMmFJi6KKjyPIS1n1Qziw2lAtZw9TlBm6GCIerhpjDZmVSZzlAC84S8nykCbiz1vIKqHd VMb3DpopqXMpKtOM5qEq0nnM3DzpfXbqXMITsJR43CX0+B8v0uEzI/rGD4oQS9Y6o0YPm8xqwlM knyh7hmNxn/6P5xDwTZmAU43ZW75ydZXGVZesjR7rQzpZSpwhYURLSwlCYh1wotz3DAdN1GQKDp ZgE9Gc4S8HeBPP3bKN8bfeeGZhte0vDNdZivkoA5xpor5UXt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-gw5903.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-gw5903.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
index a74cde050158..fbc704c064b6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi
@@ -56,7 +56,7 @@ chosen {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <
 			0  1  2  3  4  5  6  7  8  9
 			10 11 12 13 14 15 16 17 18 19
@@ -502,7 +502,6 @@ timing0: g101evn010 {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
-- 
2.43.0


