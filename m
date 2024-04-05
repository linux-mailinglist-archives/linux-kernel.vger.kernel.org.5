Return-Path: <linux-kernel+bounces-133622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8F689A689
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A601C203DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFEE17921C;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CE17799A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353632; cv=none; b=ojzvUFB5gXfdof9PFcfGzcVgaINt9dUEm29jKvQuxnBM0/Ogqx4R4xPewxNJ+1TukwF3H+VaBs2/dGjjsnlw7b9usKL0mdenhw/qEWx1hEPNP/WU6fZ09r1AlmPVH+zxb8cPhkSd2WuG8LyTM+MzGQF+I8luepnVxiCMwxiB93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353632; c=relaxed/simple;
	bh=bH++HWYMNHgTpSByhI5slzIbvvBkJazh4l+4PdaJ7FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbSbt8J5Q5zxgNDpcQLR75ZvM9QWlVnV9B+r4wjs4PXICH89ME45wKoLGKb8OI6mow35t+vZL59oH5hkqhfDCDOto02ErIlO5kzvjI194DjIKhRpSGtjWhLL8zpvycZdifvxisjaMjTMf/33Zbsxns13qzE1oqBiJF8o0bfxd/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-0003aV-OP; Fri, 05 Apr 2024 23:46:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOc-00Ad5Y-Ug; Fri, 05 Apr 2024 23:46:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOc-00FZqg-2m;
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
Subject: [PATCH v1 35/49] ARM: dts: imx6q-prti6q: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:22 +0200
Message-ID:  <a0f5e27fffdfbd4b2d4825503f1ded305ac97ff6.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bH++HWYMNHgTpSByhI5slzIbvvBkJazh4l+4PdaJ7FI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHCejX5ULtsmgO5r/1BWt6yq5sj6vSMcJ3yXf pJXS4hSDemJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwngAKCRCPgPtYfRL+ TmJ7CAC6kN0n1vz4Xza/btjMaWoZgmzT5OAzFh5Q+kshhzyjIP7m9FoBhV4R7p6mioZO8UlH+tF k2PWUcT/IulGSXGGBkjR8IOdp8PrCgAfFalfJBfqWkb8JAXzD2WKDBRoYHIyx8ETTJu8Hr4ZqyM IRyVdNkR8QPsALHG4DWRvVKpgyMrOj97G0HWEQRGA7Pq2SSox+wrmCogy//8RP7C+qZ+DkgAwZ/ n2QeWPvWH6CX1DqEyOB3JCfaeZEQzGN/IhsIjcrwFcBXxdgH9qfneXIuYcf3Xlwp8n54X4cDG6G PKLyRyDpw5gnygZmUat8JYfycd0r5tyEKIJG0pjRt+SLI9GD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
index 3508a2cd928a..a7d5693c5ab7 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts
@@ -22,7 +22,7 @@ backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_backlight>;
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 16 64 255>;
 		num-interpolated-steps = <16>;
 		default-brightness-level = <1>;
@@ -292,7 +292,6 @@ &pcie {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
-- 
2.43.0


