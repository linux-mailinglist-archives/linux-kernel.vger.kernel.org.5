Return-Path: <linux-kernel+bounces-133631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1289A697
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E7C283757
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23356180A6F;
	Fri,  5 Apr 2024 21:47:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADC178CD4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353634; cv=none; b=GC1vsnzeP7ZS08k5jqggT33+Sk/oYb85+psY9zYjUzTch4jbUUNI2k1S/0DD3arwGddXCby/6tYSCLPg1TK5+nixdBteQuHpOOgmLcFwA5K57bsbzeS9CGyLNKVm8cSEexB0OFLPdkexypRxSXBNkuFuwiiIzKFaeawWOBaiIsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353634; c=relaxed/simple;
	bh=qFhhzrzNyvdbGV96Sy0qnlUxztcx7Vy/l2xFVuwb0bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAHB1GZnSmcVjrfT6NcFTU/IlZJMgn1bjvh+KZNyZp1liA4T+68Pu1Z95vrTIcSIPE0VphUM2tPWdF034NzvCYG4o6PrF3jshzmgm0zDg5+oILeU0blh/d0w+iAvpSysadH5bg1i+S9wk21yS0henkOHuw5nbNa54cCa+vCKhac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-000306-T0; Fri, 05 Apr 2024 23:46:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00Ad3Z-GI; Fri, 05 Apr 2024 23:46:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00FZok-1L;
	Fri, 05 Apr 2024 23:46:44 +0200
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
Subject: [PATCH v1 05/49] ARM: dts: imx53-tqma: Use #pwm-cells = <3> for imx27-pwm devices
Date: Fri,  5 Apr 2024 23:41:52 +0200
Message-ID:  <a18d89342ff301a588fa852ab558d92d7586de2f.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=qFhhzrzNyvdbGV96Sy0qnlUxztcx7Vy/l2xFVuwb0bo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHAnJGvL7CP4sRCUvncp3dj3Cba5v0of6hlS1 xTtArDssmWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwJwAKCRCPgPtYfRL+ ThViB/9+OMvVGcc7wocjE3Z2d7CwGY2TpvtI/EaM3pbkzvQq7l6TWmUGtkgkykxGEdoJAGrKURP y21U2kAeKQdS1k1ZBQ1XeY45sNframW22IRNxMaq7nZ2Zf3XX2tCktbc7zbSHXsyDtx8TCerS2Y jkc8MHayeki8b+IF+VWhHRxLSkX4HAGo6Sx414/uO0mzNrGz+g/zAWkhqLLvMEvriJem5oPpFgz NMyYiccF9jea1DTBuDaJGxErFja+thryYA8oFjL96X8HpBcV4Z3xNesyzg7UN57i/N6MVWTblhU V+qS4gg1hRLDgDj0Tq1ermvHKYYiaQ3K1OKSh5ZUY8lLcQ6t
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dtb: pwm@53fb4000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dtb: pwm@53fb8000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: pwm@53fb4000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: pwm@53fb8000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-mba53.dtb: pwm@53fb4000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-mba53.dtb: pwm@53fb8000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts  | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi     | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53-mba53.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi | 8 --------
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts b/arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts
index 0e7f071fd10e..f6f116366643 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-kp-ddc.dts
@@ -13,7 +13,7 @@ / {
 
 	backlight_lcd: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000>;
+		pwms = <&pwm2 0 50000 0>;
 		power-supply = <&reg_backlight>;
 		brightness-levels = <0 24 28 32 36
 				     40 44 48 52 56
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
index 8b25416a5303..ae5f87b8612d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-kp.dtsi
@@ -13,7 +13,7 @@ buzzer {
 		compatible = "pwm-beeper";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_buzzer>;
-		pwms = <&pwm1 0 500000>;
+		pwms = <&pwm1 0 500000 0>;
 	};
 
 	gpio-buttons {
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
index 6a37616cef1c..2117de872703 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-mba53.dts
@@ -17,7 +17,7 @@ chosen {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000>;
+		pwms = <&pwm2 0 50000 0>;
 		brightness-levels = <0 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100>;
 		default-brightness-level = <10>;
 		enable-gpios = <&gpio7 7 0>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
index 294811bfc8d2..b2d7271d1d24 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx53-tqma53.dtsi
@@ -202,14 +202,6 @@ MX53_PAD_PATA_CS_1__UART3_RXD_MUX	0x1e4
 	};
 };
 
-&pwm1 {
-	#pwm-cells = <2>;
-};
-
-&pwm2 {
-	#pwm-cells = <2>;
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.43.0


