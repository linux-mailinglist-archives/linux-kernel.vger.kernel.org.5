Return-Path: <linux-kernel+bounces-133649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9996389A6AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EB1F27B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D83185232;
	Fri,  5 Apr 2024 21:47:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE061791F5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353639; cv=none; b=IAaA7txuSK8pFdsM5RQFiC54n+/A7S+lQPrwq0JNkpJDR1z7SPEgOhKQSGTXsUatu3hf/T9KaXmcrmuN/wO1Ar4jvb1HrCVvSuVJnrDjE+P+WOGBnzz2IwkjkKuOT65HTCMKcVt4E0WwCfcqogoO/Vbkwq6l1nJxntGaLlYAYhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353639; c=relaxed/simple;
	bh=31qBn+qLO55NKAOMjh+QXFNcifWq0+ObSPULX5Vwyf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzZNDzDyG00c22VAFRPmYvNs3UVEWq5PcFQv7OVjcFmizd4hJcZh/w6x5d0so0Kf87amNnB+FIgEJ7Kup+BvPTQnyAc/RPi0VT5zpodqpHbz4jMwHrwtXrKYsOQKm7GQxKrBrwevtlwMgClCtoXS2L3nptk5crnUY0xlsWQL5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOi-00043T-2D; Fri, 05 Apr 2024 23:46:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOg-00Ad6O-I1; Fri, 05 Apr 2024 23:46:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOg-00FZra-1U;
	Fri, 05 Apr 2024 23:46:54 +0200
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
Subject: [PATCH v1 49/49] ARM: dts: imx6ul-pico: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:36 +0200
Message-ID:  <9896105717abb793151c65d54001293a02b2abb4.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=31qBn+qLO55NKAOMjh+QXFNcifWq0+ObSPULX5Vwyf0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHC+EAPVGwrwkpBMCcKZ+d7Wpos+noF6umeVY qVQYU+5DNKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwvgAKCRCPgPtYfRL+ TufWCACNJkHyl5R3Kjz34dga+KJBQZHsJ7RNO/jIN8X7ltSjIEtb/CJvHy9DF6yQwhaJ3UzEsYM 8vm7nHW6+uPfCAIq+hvJGmzQaDB4vB+jecAdRBfsZAlnqPWc2KDzCXKo43YLfY2/K5sHIyR62MA dsDbgQ5vN1DbA/6Jk0ydu5nqZqSUWNF/NY+4lkaPd+YRNiuWSAIiYp3XLChudVi9aVOZsXm3ljN ELf1hiFWuSeeW+9UJaDFvOaGLyW8m276JNk0GBSTrZtDlMUlBijBXHy3j9rVxiV9PRUl/zFNqwB v+ulnxRYLDE3YxlEhWl5kGrLKEEG5zgpFvuSFkg0GEX5txvR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6ul-pico-dwarf.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6ul-pico-hobbit.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6ul-pico-pi.dtb: pwm@2088000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
index 07dcecbe485d..fe307f49b9e5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-pico.dtsi
@@ -22,7 +22,7 @@ chosen {
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
@@ -177,7 +177,6 @@ display_out: endpoint {
 };
 
 &pwm3 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
 	status = "okay";
-- 
2.43.0


