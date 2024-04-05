Return-Path: <linux-kernel+bounces-133604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E589A65D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC412836D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80E177983;
	Fri,  5 Apr 2024 21:47:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1460E17555C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353624; cv=none; b=MUl8EiwbMiostszwg++k8rbv6AJ4o/JX0Kcl5GIGIbthEurS0Meoo2z4vh3Onr+F+UEtA9m3fxNqmNEzhgzWoAGwWkShdWatOR8FT9Xad/2Cl6Sv+hAC1/XmswC81vMQ94NXBL5Y3z2t1mDXbt0LAQQH/6dpgD6WYqstt5VGfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353624; c=relaxed/simple;
	bh=oSEa2gyMcGIfhQwmaPV347eueIBz6gl9/RjTI336w9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+MrElqyeBYL/RdzIlXhWydsZtesedpxjwnYKq9DgGJdJjKhg2ljbwVdQjaOrAd1SahEL2LVCduKRHSzbCMO8QkxRsg+2U0Lt9Gq0oiRiNVtvTO+94gw1zJmPUDdGagFAoV7whxX7+bOq5cEgXfSK+5DiGoRGugv+I99pV9OCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-0003Xx-B0; Fri, 05 Apr 2024 23:46:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOc-00Ad5U-Ko; Fri, 05 Apr 2024 23:46:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOc-00FZqc-1l;
	Fri, 05 Apr 2024 23:46:50 +0200
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
Subject: [PATCH v1 34/49] ARM: dts: imx6q-pistachio: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:21 +0200
Message-ID:  <a424befaebf49475f8ce5893d688fefb267b6313.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=oSEa2gyMcGIfhQwmaPV347eueIBz6gl9/RjTI336w9c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHCYHojXZwL3pxLiEyWyfajKznlUe/hWL7DxZ Tvw4XI0PZeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwmAAKCRCPgPtYfRL+ TlfCB/9oMJZCZJLaeRFIc2hdhidMhFFoZGge/qwrAbqejvsYiywWcf8rJxtmOSghFdwhcILCdoV B1tu8UqnH915aKKe29GrzmkNnFjC00cEqHS4JowK2Z4+9N+z7RkDh4WQdcMkZAb6BvEm20j1zt+ bL0rxe9be5T9osBPsG8Zd9lyvjyqqiytRAnEnaIEaZtNiLw0Dar0r7CWQI2sK+lYGnIGylbRYNM 4D3Ex5iTl+RqgBiM8yiwZUuaq1fJziKI4SJDRD+4zRStGbemMLpX9kBx96AA9ymxnSQ0owuj+qa isgBhvNd6JxUe4Wu2ASRXveI9wanBqX9u9ybbQxfgFa9Ncma
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
index 46c6b96d8073..56b77cc0af2b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts
@@ -124,7 +124,7 @@ sound {
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 50000>;
+		pwms = <&pwm1 0 50000 0>;
 		brightness-levels = <
 			0  /*1  2  3  4  5  6*/  7  8  9
 			10 11 12 13 14 15 16 17 18 19
@@ -571,7 +571,6 @@ lvds0_out: endpoint {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
-- 
2.43.0


