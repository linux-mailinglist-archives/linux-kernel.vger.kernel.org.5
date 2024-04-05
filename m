Return-Path: <linux-kernel+bounces-133607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6A89A660
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5F21C21193
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10992177997;
	Fri,  5 Apr 2024 21:47:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712C175568
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353625; cv=none; b=GSDSrqAzeLtI0O/EUn/e12Sn5/gbXZmNYyFja6Z6FQZEJZ3/KfAFHb8Brdt9rbB0R30nzuoGpI75DSJUEvHC5Sc7GsTwdiFKirMrq+x6jTy0atuoJaEPfCGgFZRK6hNw6Q49dha8A0paDucqXbEHEJ/J2RkNoRHq5hIUHDqXR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353625; c=relaxed/simple;
	bh=5WQXbchr2+pcgHmnAk+za+jAZgPFVam2B/+DHZzH6iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SO2gyUfiFXm4aHOeebdHMgYIWURWFNnf1yOboxr02+0fHD3LYAqZBrSN4XikstAih2dy5WzuxSwjgtEqMXSmrImkpdk/AVRmbaYKa2UUZDSW/jpkySJGt5YLTg7vk7PRZf3E5GEhCeWzBhiuugMxdn9HEspEcg0XAA5hDT5sbHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOX-00030X-4w; Fri, 05 Apr 2024 23:46:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00Ad3g-NM; Fri, 05 Apr 2024 23:46:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00FZoo-23;
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
Subject: [PATCH v1 06/49] ARM: dts: imx6dl-aristainetos_4: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:53 +0200
Message-ID:  <0c7ac88b2b121841dee7bbae0ee3f9ebd7a00551.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5WQXbchr2+pcgHmnAk+za+jAZgPFVam2B/+DHZzH6iE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjSBAo242Vtjfh8y1hISmmsTJ9Y36agn0+vESUcuBIS/C ax7+o6/k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJBJ9m/8NZvshkpfoG5hcT hFkc18yOOlhaYXP/3e5JXrNEvpYUN62WsA7l+dtQON+I93m++6vpnekcL9LWvT3bFarfohMZt3K PHG/gAdan8tZ7mmpXe69mdEsqUVlTc+tN+hERiQl+2zmU+PcnrTw4tcS5TmVH4ISb7XtyDiXKNN 75fXJj1ZnKZZ7nhPaJ2ac+4BVJkg9M6OzlsQ2ec/b234TQhUpmL1qVLwcFO6h16qvPyqi5/nLq5 mbf1M3TJ/AXx2dcPpYZprr3+U+lKB9nKRVtJsEFP8rfC7TefG7t/Xxju0xfHE+cWqCf6Lmzc5Oj Cucf4N5rvV3k7ob2/btsdnpnnPHQ+vNVp/PB9Q3BH9sZAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
index cc861a43eb58..a5ac79346854 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dts
@@ -14,7 +14,7 @@ / {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
@@ -79,6 +79,5 @@ &ipu1_di0_disp0 {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
-- 
2.43.0


