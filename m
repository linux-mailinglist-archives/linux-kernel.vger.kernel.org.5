Return-Path: <linux-kernel+bounces-133629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA489A695
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51150B214BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B41802D2;
	Fri,  5 Apr 2024 21:47:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DC17555F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353633; cv=none; b=cXdVVJyparxUIM+GbyqDxzrGpOjoXzQC2spC59iKhZIP/qYaH97oUNPlDL2ws+QHsu5WGJTj5JucwpKeCFfn8eSqepmmlGAZNghdwelxFDTPoeI838vyXu9Hcm/aKbyxGkDarTB3lZ0Aw21L4e+wpFllbS1tm4CfZlL1U4wMs4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353633; c=relaxed/simple;
	bh=BQAkQkpVv9pP0CzEzcVuoxj9zWRFD4gFI/joTRXZZGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0JJwEBfuzk8hNqSpILe4Yo5EWYts2ncp0mmmv6/6zR8TaF1+F0O7wUjC1HE7SzbyGRX42X+PiGbVLGwtJXFfc5JVvp91W9ATWYNXX5zaonZiURQQcsPpwqiwZBYUH9GI4gE1zu3P7yT5UvJMNoYELW3uQYK5kobeoLxsGw63TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOg-0003tX-KZ; Fri, 05 Apr 2024 23:46:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOf-00Ad65-5e; Fri, 05 Apr 2024 23:46:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOf-00FZrG-0H;
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
Subject: [PATCH v1 44/49] ARM: dts: imx6ul-geam: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:31 +0200
Message-ID:  <2493f81609d9d41b92d7b8bb8d103a2b06ff8ff5.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=BQAkQkpVv9pP0CzEzcVuoxj9zWRFD4gFI/joTRXZZGw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHC43AxXtD0gFy4CqWG35T8eJi+LvNq+Lxwrt kFUIoAbvj2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwuAAKCRCPgPtYfRL+ TnkXB/9c9vC+V8sX5Gz87Svod+mAh6Xyh6Ce3VliLgMMycYeouMMY/sQn/Nv7RdcnaG1g/IGzaQ 5oAO1zXA+zwGccs6RFOrqtveZ7WtE/TmN6Iz1BstTogZ9Mt57MMut9wUjfGOGLPO071J0CVQvp1 /Ei4OmkLtK2vwI0CXs0k+DxwyERnL4xg+hOSw5M+enPHGPYJCGX7EbedsZXmSmN/nIgfunYh1jd K08CmBLh7tagIHiT735LNfBp2jbdDwsAUP6Zc7MjD0apnpITCpGbJRU9OvAGgJ5Cp6ajc3sG4Op 7B4ZtLkA7PA+0kChPQ1//IoVzP+LpLOGTn5t6hmSao96zQ80
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6ul-geam.dtb: pwm@20fc000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
index 2ca18f3dad0a..cdbb8c435cd6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
@@ -21,7 +21,7 @@ memory@80000000 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm8 0 100000>;
+		pwms = <&pwm8 0 100000 0>;
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
 				     20 21 22 23 24 25 26 27 28 29
@@ -194,7 +194,6 @@ timing0: timing0 {
 };
 
 &pwm8 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
 	status = "okay";
-- 
2.43.0


