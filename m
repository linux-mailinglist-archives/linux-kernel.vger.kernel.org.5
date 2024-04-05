Return-Path: <linux-kernel+bounces-133642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499389A6A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54351F26918
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFF181464;
	Fri,  5 Apr 2024 21:47:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DC17965D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353636; cv=none; b=P9IweWQd55mbAdxUfZ3DxAhxsDQaLq4XUSAZxCo2WFOQQ9j32ytRML5I5dWFGpHVhFXBZkPbtUrcAhXXvnws582q/bvmPexi+aFIkW2+lDMuBEQbqRwhLNVcZRicrs8P2mPrCNYBLDcD5+tdQLfOAncD6hlgBfFkmexa1rXfXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353636; c=relaxed/simple;
	bh=NCfTnuZYX3g1kHtCPVH2bphb+ERU37LCvr3YXEwSsV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzT8zBflUqtFaE33aI/V2z8EZt9BV91KfmFlEz/T4apxG1eUV2ASEjaG7N3bd/Lp9WYHt8jfmIzTAnELfZzGZ0hryBO/+myJfMHM1ySTORI9tTueSig80JP7MeUJcRViW8SmZhkjJX06QR0Fiyqiww19wUrgXuYOBl7+W0qW5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOh-00041Q-W2; Fri, 05 Apr 2024 23:46:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOg-00Ad6J-7x; Fri, 05 Apr 2024 23:46:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOg-00FZrW-0W;
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
Subject: [PATCH v1 48/49] ARM: dts: imx6ul-kontron-bl-common: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:35 +0200
Message-ID:  <3f90246bcc1eb09d8b2e926b15c3b07802b2a55a.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NCfTnuZYX3g1kHtCPVH2bphb+ERU37LCvr3YXEwSsV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHC993Ym7krCHbbeN4prtfmujpGldUiYXav8q lJsOGevb1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwvQAKCRCPgPtYfRL+ TiCrCACWDXzX1LYOjN7Tt/s8/IaFUpGtSog4fs286beenPlH6IezC3ns3bqJvAFpga6ZUkpuTnK +PZhj3pQgkGAi8hysVS6Jwf8YVRmpStYN70s04pfU9w2xZ3cYZKw8nIQWHZXgmYvMW7W1mbOygN AIStpArCM88/+JnSkmFX6WQa9/kckM6pQ9DsG2B3NbPKSIBWlmY28ksgbbjnyAQYPq9ihUn0G+i xa/QGYqjZ2veOfNFKzm7GcYWU7g/zqhpjL+u3bBH0Yox2Lvstx53qc6/48oI8XpStMG/znd/nXR T1tN1MSRS5DtghVPhtn0P1pK2G/IxP/y7gyMeqqK1iiG/gZY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl.dtb: pwm@20fc000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-43.dtb: pwm@20fc000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6ull-kontron-bl.dtb: pwm@20fc000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
index 33d5f27285a4..d8f7877349c9 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-kontron-bl-common.dtsi
@@ -35,7 +35,7 @@ led3 {
 
 	pwm-beeper {
 		compatible = "pwm-beeper";
-		pwms = <&pwm8 0 5000>;
+		pwms = <&pwm8 0 5000 0>;
 	};
 
 	reg_3v3: regulator-3v3 {
@@ -152,7 +152,6 @@ rtc@32 {
 };
 
 &pwm8 {
-	#pwm-cells = <2>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm8>;
 	status = "okay";
-- 
2.43.0


