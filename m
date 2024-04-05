Return-Path: <linux-kernel+bounces-133645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C589A6A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E11DB2115E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682818146E;
	Fri,  5 Apr 2024 21:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902B178CC2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353637; cv=none; b=WzGbOIHb7MZ9L159jzQLCtX4rgEhM0dllzkzHdr7ah1ZYKo0iLK7NlB48Bhll8443ndepWbY8KLIjZbElIMeVwXf6mxeB0LBE2h7N6PIKv8aUsSyAYSISaQ8aC5GRlWaQxmfpnvKTl7L3Abt2DngJqtW33+OcHcVpH/3LvNY9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353637; c=relaxed/simple;
	bh=0dYl1SyOidFE2v7fVyYEZ+EClZfh/dUkxtDv1eKQvQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kv4450Sh3Rczf92K7zirs5rwlWSn1FJnsBCkVrBd0Kn6Ly1O9GYG62JJbuKk/FRVOWpTN6cAzUqBTlZDml38GPktfNpo3fZxM54j0+v0rJCV28BHo9Y8T0uMhBLN1rpkfTbwB2d77QeJ2gh0SCJ9K7X7PcY+jctt9JT6U/zBR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOe-0003hO-Jl; Fri, 05 Apr 2024 23:46:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-00Ad5j-Lu; Fri, 05 Apr 2024 23:46:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOd-00FZqs-1u;
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
Subject: [PATCH v1 38/49] ARM: dts: imx6sll-evk: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:25 +0200
Message-ID:  <fc97afe9931150a5adabe383c6b7beedb4445675.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0dYl1SyOidFE2v7fVyYEZ+EClZfh/dUkxtDv1eKQvQo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHCsMqZnBgKoCLHGXu+yPPXh7yVtYkJ8JSMoe SYXvaXyo0CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwrAAKCRCPgPtYfRL+ Tq6SB/wLgWKq0+7sflyws74XETZIvf1enpRx4hzC5MHWdPiqlxQhzVhjsOcOxjwulq91EbObC+O phCLAzNvaTAbD8BPjDKyHhCdcR2lnVmdBlgpT1X4sZYN3iXxQDjmk8f+9+bm8d82pq96L+c9sUw svio6j8voHLFAggyumpW9WBDrEkqd6rO+pzaDufzQd2j0vb+mMBZ/8wYqbl32WVnio8Nqxo2MBt HaqWL8tJ9phw1agvUYzjuvvgKarEBy6UARe96vK9loo55m5VsLtmBVe5TI6T22HFQPnwKD4GqXO ywRLFjqRzf3XDEvrDUaBFnptbXNDFWUPxibSvD29yMlqz+xj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warning:

	arch/arm/boot/dts/nxp/imx/imx6sll-evk.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

There is no need for an explicit status = "okay" in the pwm node as
the soc dtsi doesn't disable this device. Drop this property, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts
index e3e9b0ec4f73..febc2dd9967d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll-evk.dts
@@ -26,7 +26,7 @@ memory@80000000 {
 
 	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
@@ -314,10 +314,8 @@ display_out: endpoint {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-	status = "okay";
 };
 
 &snvs_poweroff {
-- 
2.43.0


