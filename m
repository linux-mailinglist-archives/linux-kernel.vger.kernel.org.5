Return-Path: <linux-kernel+bounces-133646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A0389A6A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AA9B20FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE81181488;
	Fri,  5 Apr 2024 21:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A8178CC1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353637; cv=none; b=n1zPqbAo851WbjKkjqLtVvTPUo+h56mTiVrf6DV8LLmbrwy/Ki0xhX1R1CKyUrDK4y3NiIRfV3gVmTD1v0xdPskJphwcKoKJqStNUhsOPMWlkvnPJ9y2ktrkoDWHrKSh81TR8xDsYtMlWsZCJVBsiS12To+MB+ox9tceUXbh0wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353637; c=relaxed/simple;
	bh=bUeL4ct2uYaulUWWr4XfDohjZDNlbjBRArHIb9PzWXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9e848fEMe8VmZs3ity4xRYzUeMDPC53Fj2D1FXOuBUlYZFuN9JgwLRvsC3RkoFPAwpYO86algfTZXMzD9knPqEW9EeVIJRayAfdC50oDeW88JkMH+P23IBMiv8/jyzWKs+eCV5ssLSUtOSzUhb51BbCNphLUgUnbD0ohl7T41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOa-0003Lf-Lb; Fri, 05 Apr 2024 23:46:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOa-00Ad4l-7K; Fri, 05 Apr 2024 23:46:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOa-00FZpu-0S;
	Fri, 05 Apr 2024 23:46:48 +0200
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
Subject: [PATCH v1 23/49] ARM: dts: imx6qdl-nitrogen6_max: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:10 +0200
Message-ID:  <e841b6cc2b3261ef8923b6bf6d09bcbd3c4c31dc.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bUeL4ct2uYaulUWWr4XfDohjZDNlbjBRArHIb9PzWXY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHBycr/7431AUEbWULUOAmBkY/X0HoauF30VO S/Smk1a+zWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwcgAKCRCPgPtYfRL+ TgvmB/9As4WfT2lbhtnk+XAf7m3V6khJXqiWZF+8o1/lssSeCfR7ppajQSs+jMrrF3g1A4CWNcX vRiwlGYdpvV0g7q4CZg20grrMYnXom90oS3/iJJHk58gB++TYZT+qILQvZXr59s00taDRv4eYhs sTglDdl845UGzK8iXBaPsWsIvH1KQ0mvEboTycudCrC88UyGCEdCruWyf/4Nou+cTh6lSrTgTWB +pbdpmHixyPAVUb3zmQZ9VJcguBictFSZ1JEpX0nqZB+REDbk1wPHBXyCJdHGd6pPNIwbmbg/3I S4HvQCKRiCSCN3EBuheNISLwYVturzTLzIPVQWAfM4tINmxv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: pwm@2084000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_max.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_max.dtb: pwm@2084000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6qp-nitrogen6_max.dtb: pwm@208c000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index 32a110a35b02..33174febf410 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -183,7 +183,7 @@ led-ttymxc4-rs232 {
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -192,7 +192,7 @@ backlight_lcd: backlight-lcd {
 
 	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -201,7 +201,7 @@ backlight_lvds0: backlight-lvds0 {
 
 	backlight_lvds1: backlight-lvds1 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 5000000>;
+		pwms = <&pwm2 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -735,14 +735,12 @@ &pcie {
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "okay";
 };
 
 &pwm2 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
@@ -755,7 +753,6 @@ &pwm3 {
 };
 
 &pwm4 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
 	status = "okay";
-- 
2.43.0


