Return-Path: <linux-kernel+bounces-133613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60489A681
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B0C1F21538
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABBE178CCF;
	Fri,  5 Apr 2024 21:47:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82524176FB8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353629; cv=none; b=esE7XenvTO6CJ2YbUpNfP2mZB7lcTKXDiTcBtqdh6YpncBnZ8HMuISTAnDgu816fGCOPDI7v/WsPrRmHdvIUw8XOasS0jxgV6UMB9QHNwHdYJjP1R2xO2MMrMdnQxZT+rVvemeioXl098rd3SazGz7DNXo+CpAuzyR9BCeqLR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353629; c=relaxed/simple;
	bh=tNVm2qnMqxZ5N2xcWEJgM0z3c/Fs9KxblzBupPfgF+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOMZw7/+R1L4Iy4a4w1V6LLxeatf+3Wd4Ml333LGu4GI61nTacoMoBFqcpB8H/coaNRB/BRxI1ZQjrYAImpZBHIyuDW2wNEkZSrT+QRGuuKM3KgrR/ujVkaw/RKilk6DA6GVB/RaVDcnUh1ahukxzvhl0fop0imoxw+0ml7c8ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00037l-MO; Fri, 05 Apr 2024 23:46:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00Ad44-4P; Fri, 05 Apr 2024 23:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00FZpC-0A;
	Fri, 05 Apr 2024 23:46:46 +0200
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
Subject: [PATCH v1 12/49] ARM: dts: imx6qdl-aristainetos2: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:59 +0200
Message-ID:  <e8b1e259241a7b8b74b4390d96459be6a0cd5b54.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tNVm2qnMqxZ5N2xcWEJgM0z3c/Fs9KxblzBupPfgF+c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHA5GpeP3lgF1CvcNlwwOVW17Q49pkOfUYLGs Xgk2gUOlHSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwOQAKCRCPgPtYfRL+ Tkq8B/94Id9YXOv5mJR6LDwB5wOMzOjF/gmuRswq/SXQ8onWokH9Tie3ZldxUTpQLNPEF0b5EZC Le55bykFJuSrMg/Bp1iTuYJ04xzkqqofgXZ1ZXvFxdHkbRT1yvgCRV8bjQLS4aMsjKQuzpSqw6e dfhTpYI+QpncZILsAI+6L2fi33WNZB/Vy6Bm01/1cTQPr38D4wUvQzlOt/Dq/orq8G2SGFEUW1T kj7ZQZmVXhBumB+QVTI6BY8Frrj3dHM+SWWo+m3mtZSZkA3Qsn+xX5ZMPxQwXU1O6HAUaHKMJj3 FIFAwY+5kUW/ONK/XrX7kqO87gk2q9iEZGaxZGmPJN+D9tYq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_7.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
index db1bc511e71f..758eaf9d93d2 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-aristainetos2.dtsi
@@ -46,7 +46,7 @@
 / {
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
@@ -346,7 +346,6 @@ &pcie {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
-- 
2.43.0


