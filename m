Return-Path: <linux-kernel+bounces-133617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C789A68A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F4D1C212DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995F217AF90;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1111779AC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353631; cv=none; b=chK1SGsWdNHK3iCOLg5u0rN78ZgqacsmTtNvZtMFMyQqaMedsJi6ZwD/1j6qOCWbHlGUNhRYvvnqYSY/Y/MYKchqp++NfPIAHFI142MWmGIFw5eX5ETkrTevXwGyVsLawpRG6NeNWYlVP8XveUDgaWQvLB0ZXLOAiFJ04CGuZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353631; c=relaxed/simple;
	bh=9fSCtBweYG0diUIZ/WZ5izn/XHgR28JhvR2b1ZkorRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awDbbh2TghT1NJ99AOKDXauaMcUZcNRzMBEhs3SVZM59GedCFqkDWoc5/djMByAxXDwc8Y0+/8l+gKbV5gYti/18WofOlq/22wRK7EzS2Upurr66f5gYsksnTf1j9TAZb82CmpTOXGETbzWKyKwYQb5Skrbnzhfo/Q+zZYEWNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOh-0003w3-8B; Fri, 05 Apr 2024 23:46:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOf-00Ad68-Fd; Fri, 05 Apr 2024 23:46:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOf-00FZrK-1F;
	Fri, 05 Apr 2024 23:46:53 +0200
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
Subject: [PATCH v1 45/49] ARM: dts: imx6ul-imx6ull-opos6uldev: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:32 +0200
Message-ID:  <9a0d99b113ff4e8ffa3ae2b325766882106aadea.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9fSCtBweYG0diUIZ/WZ5izn/XHgR28JhvR2b1ZkorRc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjSBgp0yqzOie3l216aZeEl1F1+4MdHm/UE2AcPUVf9/p a3cnfS0k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJLHvF/k+lcMartoy1s3hF 6qwYI0PjlrTnvJR8+FSGd681/82Sm/rGNix6CdvMlGwi2OWyl89XX58vuFzwZEcK//81Zl1/mwV Eew8/e/bvqkQiW2VP0IX3/Sr3/Bt3HjjKI7Lxyg6zWUv/HX6dlV82Z/u/oniR2B079zIF6HD+qz 9nl73YaFZlPieru906PzVu9oNPzyzb/ja83/7Rsg1e68ucA5ROKvssCXjh5q1VrMpsZ/Tl49nLo an69jfOJi+Qun/si9LjB+/idv8uNvdQXiSX6+EtvDv9YfHuxKnmomW379VZ5puoKpe2N8hUN6gs 6q514Lnx0q3ottZRpmVcLssedVWftzn66VBIT1PFp+VBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6ul-opos6uldev.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6ull-opos6uldev.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
index af337f18a266..be3cacb4fa7a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-imx6ull-opos6uldev.dtsi
@@ -9,7 +9,7 @@ chosen {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 191000>;
+		pwms = <&pwm3 0 191000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_5v>;
@@ -143,7 +143,6 @@ lcdif_out: endpoint {
 };
 
 &pwm3 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
-- 
2.43.0


