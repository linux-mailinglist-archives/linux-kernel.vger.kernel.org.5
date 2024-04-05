Return-Path: <linux-kernel+bounces-133644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D066F89A6A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CF61F26AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C244181468;
	Fri,  5 Apr 2024 21:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946C179670
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353637; cv=none; b=T3pBiNy0e7saEhBCUF1Kv9UjxHv3fYp9F/dQsUr+SxegwivZTwpZxy4hmiPAVudy4Uqxq1Aso4ClN0zhrF2C5vLuuXygvkqDkJf3P3mlAo/lUjXdcpDVSVEmdow5cx5dtt16rCrOCc3rolNI8sH/S7sQk6Alm6prQDgPAoHLzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353637; c=relaxed/simple;
	bh=y6eVsjv5f+50I1RD+pxV3joqQI5JN5tMCmsNYdVXcrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IADcTpEIMhdUgmaNLjwED1m6gcz1jlrEagWsMmlawUIDDQpW/EYtsK25ygaA2PlT/96OdjGVGqpVguk8sC371Jp9KFS791Xd+HlzMgu/i7fZmxVY9BtkU7V+jEFi45a7POalLcB4W8O5S9gffvUQBSIj23SGfotp4DOhUUAsGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOe-0003cv-6A; Fri, 05 Apr 2024 23:46:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-00Ad5c-6B; Fri, 05 Apr 2024 23:46:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-00FZqk-0M;
	Fri, 05 Apr 2024 23:46:51 +0200
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
Subject: [PATCH v1 36/49] ARM: dts: imx6q-var-dt6customboard: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:23 +0200
Message-ID:  <c81d572914923a9f8e172c3f720b611cd264c590.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=y6eVsjv5f+50I1RD+pxV3joqQI5JN5tMCmsNYdVXcrQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHCfme+Hxj5ztDWgKjJgySGNtpbDqqRCO9UqO PLSLHKF2IeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwnwAKCRCPgPtYfRL+ Tsp2CACaQH3cqdAyFuw/WqPxvdxbpUc1aKKU/aTEwJPKv1mfzD5ISfh1EpuhnRIao8x6EIDoEN6 XdZ0Omi4HGMzo9GsHIBj3ggV6ntqxg+GPFgnwTbtPQK6KnU/R7yfgnn+znLwrNwQWQv9+3Ex98M 4TTPXonZTtgdD6+4rvnO39RBeJryheVcDU6/dxV1/fIGWMQaFiKgAapG+L03/i06Ja2JFbQNvNN 2sb7rkVzAOkjVfRTGslFF5ItiZb0CEf1kVqkBDlkVvij7enRWGBSItCeG8aU/kmKr0+60BNgf1U Vm9VWH+7uaxO22Cwwwl79urgJepVxQ8YWnw+DATqvOK4HSnr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dtb: pwm@2084000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts
index 2290c1237634..0225a621ec7a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-dt6customboard.dts
@@ -18,7 +18,7 @@ / {
 
 	backlight_lvds: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000>;
+		pwms = <&pwm2 0 50000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 248>;
 		default-brightness-level = <7>;
 		status = "okay";
@@ -203,7 +203,6 @@ lvds1_out: endpoint {
 };
 
 &pwm2 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
 
-- 
2.43.0


