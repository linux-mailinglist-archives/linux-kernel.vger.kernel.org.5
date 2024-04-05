Return-Path: <linux-kernel+bounces-133627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA60389A692
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2DC1C218C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E417AFA7;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A360178CC6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353633; cv=none; b=Bgrg15s8eV1dV3g7FE82+WaISmgVHWelorlT1oTr+chI7j2fQSBodVX1CfIKuW7VS2+c9Cnw7pKgQROY8Qx0lmBh4BRo6MSUH9KNPDaKvEJViUwYMlE4PLcfKvI8T9du/PIKaCINaiIHkdSFUlrRE1zwgdJ2nFloyLcZDmvL2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353633; c=relaxed/simple;
	bh=DEnSJA3VDTM3CD8+5ySPJWAhctx6ItqFAOifFwrYS98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyNiBfyqz7ErHmHSxC6ePQEtD2Iv30qM60jeaG8uDG9/aHRDKYq5K0UV5O2yxfnpRT4O0jeouGCStR2LcZUPVswPJYOL0bVH9+A0Va4W9hIoWEDiOJESM3tvRWfsB7mfWguDJn5gamaeyK1PFTtJ3187ZWbTbo8yDPxFmQBoCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00034P-3z; Fri, 05 Apr 2024 23:46:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOX-00Ad3w-My; Fri, 05 Apr 2024 23:46:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOX-00FZp4-20;
	Fri, 05 Apr 2024 23:46:45 +0200
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
Subject: [PATCH v1 10/49] ARM: dts: imx6q-bosch-acc: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:57 +0200
Message-ID:  <3cdc316fba84588bd11ebb5cd565f582edafc323.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=DEnSJA3VDTM3CD8+5ySPJWAhctx6ItqFAOifFwrYS98=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHAyXXrDtWTyoXfnSzPRb1kEdBaHfWZVvDCJ6 NKlSfvN0AyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwMgAKCRCPgPtYfRL+ TisfB/9abV7YFKOHs+rT8DB6DdJhAWDKbcKg4/pB/Bi3WpRiJ4qXs499H9T+agUtz6lh3Dutiig mrxIY9+Fa2XaGXKw196CTgDIkN64fVOzxcya/ggxpbUrFocOtN7cXXXeP/7i3NiH+Y5Q1DTEJii tNP/sSVyjbbLr7+mBxBFpIN4ZXzTR2LsE5sdG8hXbiK1LWKq+uU/5BYUB+oBZRanjfbjBikW7IJ 2M+EW3ltAVT+PW9FdROx61SgkefgbSvpLHd30RtO667OazvQDUuAOVNQl8v9PVi3ObzJ1cn/os2 AOYrLTUN+l0qZRF0oIsDtjvRa5Q93tjC0h2onkGXHuVLyQ2t
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dtb: pwm@2084000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
index 02648806c275..d3f14b4d3b51 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts
@@ -36,7 +36,7 @@ memory@10000000 {
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 200000>;
+		pwms = <&pwm1 0 200000 0>;
 		brightness-levels = <0 61 499 1706 4079 8022 13938 22237 33328 47623 65535>;
 		num-interpolated-steps = <10>;
 		default-brightness-level = <60>;
@@ -117,14 +117,14 @@ led_red: led-0 {
 			color = <LED_COLOR_ID_RED>;
 			max-brightness = <248>;
 			default-state = "off";
-			pwms = <&pwm2 0 500000>;
+			pwms = <&pwm2 0 500000 0>;
 		};
 
 		led_white: led-1 {
 			color = <LED_COLOR_ID_WHITE>;
 			max-brightness = <248>;
 			default-state = "off";
-			pwms = <&pwm3 0 500000>;
+			pwms = <&pwm3 0 500000 0>;
 			linux,default-trigger = "heartbeat";
 		};
 	};
@@ -484,28 +484,24 @@ lvds0_out: endpoint {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
 };
 
 &pwm3 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
-- 
2.43.0


