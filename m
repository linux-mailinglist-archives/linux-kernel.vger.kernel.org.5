Return-Path: <linux-kernel+bounces-133619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226C989A685
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52101F22392
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877D17AF84;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10421177996
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353631; cv=none; b=WvNX6eN8CcJfvBABn/XhHpvEc42y5Z4AruGjIKlxQYLrhtij9bjCgR9CBiLMZ8y4HxWbhZ2jaZbTFysK32sdlNKB6poppbr6/1lAO1rdy8zH/iMM5lpCoIqOU62nGhcutlMdB/lB6RHaEHNBHfQq+Rh2gTEUOCWgeCJFwqM0lOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353631; c=relaxed/simple;
	bh=ZEQXObPQXoyWJWVJ7xSA6J3JN5kiGs6xoYaG09Zv8JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH4enUb7c55wGmsUCOfmZQHqF9trGfgLqOhAmqUmBNqj7TIVRXP6ryvcjQpPd6nuk3pOMjj1Bs6WVFhL9ZZ5pwMFlXd5xKKd2vV54L7n07FZTSoee+T0mk/lNPMoX49jzUsdkFqP5WZfoJ2b5KJU9Pjo7t2ASyyKqIUlRIdPPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOX-00032h-FH; Fri, 05 Apr 2024 23:46:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOX-00Ad3l-1F; Fri, 05 Apr 2024 23:46:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOW-00FZos-34;
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
Subject: [PATCH v1 07/49] ARM: dts: imx6dl-aristainetos_7: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:41:54 +0200
Message-ID:  <294ea3bf4e4f83a1e0eb57d0b8d1e62b391c125e.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZEQXObPQXoyWJWVJ7xSA6J3JN5kiGs6xoYaG09Zv8JQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHApdzojAMb9UzxsORix42d8dxwOGAaHLTFb5 CY9qwnS4ByJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwKQAKCRCPgPtYfRL+ TuClB/9X0Wl4uU7u3YUQLYPiXsKk6UKjW/kz0P7fZe6koSCe6lZaCQsHngthZZu/m8EFyfKPA86 C+nFHBrvXLEDUnJbxY2kx5FukXVOYEoiPuySNa9VY3JS7qYBR5wFDXRd1vN2gF8hXgeOuUwVUEr ElitDtj3IRelANiNM4x8J88Z64sE978weY3Cwn62uxLy+gVwRr4wk1zVTOl6+9IoL+CmG0/6mV2 t1nMe1mR1JAEA1kaFarZAVD1HaQTmSV9W/OGypsk6LAk3QM8EwLzRna6pOVVIuAQrlypcf3DHSn cZlS2iA4eRQt/nF2PJU5tjeHYNUKr2A4iXh5E5QgPOxSs3l9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
index b6cb78870cd5..5a25bdbbeb68 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos_7.dts
@@ -49,7 +49,7 @@ display0_in: endpoint {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 3000>;
+		pwms = <&pwm3 0 3000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
@@ -69,6 +69,5 @@ &ipu1_di0_disp0 {
 };
 
 &pwm3 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
-- 
2.43.0


