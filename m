Return-Path: <linux-kernel+bounces-133606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4BA89A663
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909C11C21494
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F91779B0;
	Fri,  5 Apr 2024 21:47:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026B175559
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353624; cv=none; b=CdbIJ3rDt/YfHzoNB8I5TiK1vhUpw8NqMOTxB7E1+/4IoRoNnqTIPKDGChLijr+fp35gY0KXGBQbfLF5iK37gfEt5IFz9KJZEp71u552tlhmdKZlHpA+5WE74ae/Ib824TBiMphlyZISV5EviqyCSu6YOjEbVscROipprToNZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353624; c=relaxed/simple;
	bh=rJ4YY4QFJn+ifTArMHIAeiROsDo8grNaRijlD9TGpqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTXVeD/1pkloSiT8GN8wZh8NsaiRCggDyK3aborxpOTiE39V/drvoDQra6uNtJkuVsLXw8e6eh6wA0UUMIA/OPsOq2Y+42gT+JqlavpKoAfP/BDUW1iQCx5A9H8nQQ/jAhiAtYW0nrUKxRWRgzlX2EwF7O2Q2ALEYXZHcsyHOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-0002yt-Ec; Fri, 05 Apr 2024 23:46:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00Ad3T-1O; Fri, 05 Apr 2024 23:46:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOV-00FZoc-34;
	Fri, 05 Apr 2024 23:46:43 +0200
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
Subject: [PATCH v1 03/49] ARM: dts: imx53-ppd: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:50 +0200
Message-ID:  <1ebd22d44eb7db1975a22b8ac7108f406cf070f2.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rJ4YY4QFJn+ifTArMHIAeiROsDo8grNaRijlD9TGpqk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHAkCZsNg6wBLvXP3BEFbIMjuzMeSIPfTEJBW NJ2IwQt5IOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwJAAKCRCPgPtYfRL+ TnYVB/0SGb0aNrpqqb3jWw5LkWLaa6jf0fbGIVzAkZuWG4QIxCUANRzhoW3NN9FfcBSBb/xzOSk wWjRn/lsBfZ1l51T/lt5GmnKgvMc6XMFbsS7dTZTGR0TDmI+m9Z8sNTCQ8uf4DFbrqBwiogDoN8 XtjOE618ow1TEEFjualN3yMCzNY/btDHarlkIlgnqtV6RWtcGGGHRZmWVTMARSg66MC3NLoLc8L B4b1TLAGTuxE4P+dr/oL+DF2tGTVtnFKQFeEfNiO+eitJCS576q6O/iWWpxlKh1A2r+lx+c8LtF bapLukcRWUV10GGkJXe0nvEbBOG2iSwry50ikUEAC6Qa++8k
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx53-ppd.dtb: pwm@53fb4000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx53-ppd.dtb: pwm@53fb8000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx53-ppd.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
index 70c4a4852256..e939acc1c88b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx53-ppd.dts
@@ -167,7 +167,7 @@ reg_3v3_lcd: regulator-3v3-lcd {
 
 	pwm_bl: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000>;
+		pwms = <&pwm2 0 50000 0>;
 		brightness-levels = <0 2 5 7 10 12 15 17 20 22 25 28 30 33 35
 				     38 40 43 45 48 51 53 56 58 61 63 66 68 71
 				     73 76 79 81 84 86 89 91 94 96 99 102 104
@@ -187,7 +187,7 @@ led-controller-1 {
 
 		led-1 {
 			label = "alarm-brightness";
-			pwms = <&pwm1 0 100000>;
+			pwms = <&pwm1 0 100000 0>;
 			max-brightness = <255>;
 		};
 	};
@@ -628,14 +628,12 @@ &pmu {
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
-- 
2.43.0


