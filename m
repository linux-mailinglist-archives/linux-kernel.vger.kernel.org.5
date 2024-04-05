Return-Path: <linux-kernel+bounces-133605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5468689A657
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D9B1F21233
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17D176FDC;
	Fri,  5 Apr 2024 21:47:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145A917555B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353624; cv=none; b=JjKX7k1ws1iE6BoHKUlQUshTHPQZvG6FcNQ57tMSmqy5WY6lkL37bpyVwu/rBXtqQqymbAjHbajdqfbrl/GlG1HSBhetsoEvVGoOwQGMWfS6TKUQ4cNAcPkQU55IzE6jzpA1o7T5Gqae8OfkUonsMWtVHDa6CsPqszURofVmL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353624; c=relaxed/simple;
	bh=RKudxVR+D76BRS6pwHJp4fZWRIARjdwawH+torR/KEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5ZNVo4fyRB9ByPfW2oBvOLwWYHmOqrbEBbXYuO909zAFzup12rRsCVkOJp55ORo7ctQgdZsF9ApkdybFBWuAChXrAts0IcziXI6xYe7Aat8YlXFbD8PZNCu4YqiGZyzrcxWmeF/8yKaEgirgv6SvTOI39S44QJ2miKugfxxSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-0003GN-Vs; Fri, 05 Apr 2024 23:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00Ad4R-Aj; Fri, 05 Apr 2024 23:46:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00FZpa-0n;
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
Subject: [PATCH v1 18/49] ARM: dts: imx6qdl-gw560x: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:05 +0200
Message-ID:  <cd438cf39de67aa60a82fabb99465689cf3b5b7e.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RKudxVR+D76BRS6pwHJp4fZWRIARjdwawH+torR/KEg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhjSBgoictEYpDm2Bw1NuxapcKymKPnGtdrNa5nxWb1eBe 9Ok23k7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiI+zn2v1Kmqfu/ToxK2B3F re9+RObTCbMMNm6DeKOs2Atp11k+iror7mR9o6Fyrim+z3H2qj6bFeq2jU0XK0ubzsjs5307468 euwD7zqI3QpFnzf4XKaUbSBi7hnYY1s7cdL1PqUNkEsvF87uyZGQTzT/0LeS2PMpr4y5UIXJKdP 3z/7oT4uabuzz7ELF9r8dVr9nbmH/+MOjTavBtbvxyb9LdS7NZtbgjD7hVtPMbMU3lYpSrWznL5 976tDNzRb1/uqzia1qxTZc1sit23tv2fLu2hVscp2jOZLmwUStszhT7P5nXzm71nR3WKRCwbFkF 07SpmezCT/7eOqhkPjXIInRe00zp/jiTqS0Fao4nfgYAAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-gw560x.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-gw560x.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
index 46cf4080fec3..7cee983da669 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi
@@ -66,7 +66,7 @@ chosen {
 
 	backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <
 			0  1  2  3  4  5  6  7  8  9
 			10 11 12 13 14 15 16 17 18 19
@@ -619,7 +619,6 @@ &pwm3 {
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
-- 
2.43.0


