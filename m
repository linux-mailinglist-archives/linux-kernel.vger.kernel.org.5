Return-Path: <linux-kernel+bounces-133628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215F89A691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EE51C214CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF5317AFAD;
	Fri,  5 Apr 2024 21:47:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2561779B9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353633; cv=none; b=ddWZ+gowQcsGrxTIrpmm4XtrVQT4Ju6zA89Pyxr0w7nfnEv1K3x3AI7B/kFqqEVvPtIdtIy687V8msjjX6RfN5wCEdGCfTpmrGjM/Qu0hi2C88jZ9518wnRNzgL7FSvHtWSB3W2m3e5gqRdUSWh062SBC513az7oWC93VXjBMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353633; c=relaxed/simple;
	bh=r8HxkqV2gZXa2CGefAk5z2mUvLGXYmlh5HjspcpwSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpbMxFPTv44mThSdvHZ+OkSO5TIbCG1jUWc+rCtumz/6ntOC31/6VAX/6GkBdl7bNiHdykdwu6qhoDA+oPgaq2vhKn+Nu4h1ai/mj72syB7RGXPiUldwNbq3GVt5Ndiz6Rwz9uMLjqs67QeN9vBM8jdW+lBOad737mTRPIegF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOa-0003I2-8x; Fri, 05 Apr 2024 23:46:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00Ad4Y-Mh; Fri, 05 Apr 2024 23:46:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-00FZpi-1x;
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
Subject: [PATCH v1 20/49] ARM: dts: imx6qdl-gw5904: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:07 +0200
Message-ID:  <8b77075bb53543af8d1cc0d30c746381e1386b34.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r8HxkqV2gZXa2CGefAk5z2mUvLGXYmlh5HjspcpwSMo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHBgKMQ8av1wQn1A41xka65vL9G3G25FEjYIF IYP5WyMasaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwYAAKCRCPgPtYfRL+ Tuz1B/4mkZzl+Y1OrFltg6u02d6Bw8J1LfCXr820Q3/i6ybfSkYutW7JnCBPRz0S2WCXvUIVV/z zBksCJ8T7q8DmXO5LjLOGTE+9k+6x2V3x4c0kWT9ZV2Ge1LW2ol5MvRCe6eRgaCvVbcKGyjBfp1 wXnUr+VRzbgo/3q/WUrpf74C4Lv+BWmhKoChRHHCQ5eni8IHW/X8889bEYDm5fm5MlKn7rAOq4X nV5GBicZe8hRt7tXF/qYcXK1fwV6JFI5A/xhQzitj0VzkIm/VzhFy4EKA57F4U2RTYXbDzVhLTN 4OnoJc58qg7stw2iETPz139FERz7HCR6qfkoqo4xOE+kd+kO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-gw5904.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-gw5904.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
index 1e723807ab4c..070506279186 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-gw5904.dtsi
@@ -70,7 +70,7 @@ chosen {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
@@ -586,7 +586,6 @@ &pwm3 {
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
-- 
2.43.0


