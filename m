Return-Path: <linux-kernel+bounces-133653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5DF89A6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127BD1F27773
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0D185F27;
	Fri,  5 Apr 2024 21:47:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADD17E3A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353643; cv=none; b=dWspsnIhWfS99VcbUZn8BYgGuAlTa5lRxw+RdsPZnguA7KZKmjN9XdxGEMbR6wbEnGmxHLosaOvlGRUIyAFX3ykSWT2YlvOxKRpD/SJ99feTA41C+UN/NXv/J43g8Y9ok9xJCKkkLdwJC4brjzTZH9sM21ISsgV+N5MM04lkzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353643; c=relaxed/simple;
	bh=4KFhFnLwo4rwGj1k1G/6oOe1MuD3QLGh917tQ7919mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU6+aQ1cNXHjSG6vZ5dnS+V5/QylGe+EcFEomUUHT7AVxAMMaWXXiwWsvtvLm5k5ryUpT7+Hw/EaByxbcU9GhWp081PMHULGg+8ee9sN6DLwPy2nVPlB1o7fAGvnOCudSg2YIPAL2aMFOur+7W6+XIfLGE4t5x6HGykv4izOlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOZ-0003A6-4a; Fri, 05 Apr 2024 23:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00Ad48-Bx; Fri, 05 Apr 2024 23:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rsrOY-00FZpG-0u;
	Fri, 05 Apr 2024 23:46:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v1 13/49] ARM: dts: imx6qdl-cubox-i: Use #pwm-cells = <3> for imx27-pwm device
Date: Fri,  5 Apr 2024 23:42:00 +0200
Message-ID:  <f17a774b91c7a60a265860abac6668f38ba5e74d.1712352665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4KFhFnLwo4rwGj1k1G/6oOe1MuD3QLGh917tQ7919mk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmEHA6R7VrgPN3/Tty7W5jHAvS2pK7gsf0zCYV6 vAT7EBsbLqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhBwOgAKCRCPgPtYfRL+ TlN3B/9Yq7mRTN3Z0/Bk3CdccDs41nCTm3aCUfgds6QI0muXD2QT278zCtazuBRqVwxZZJFR4kZ wBEp2yEniLKNhvg48q6hSFOH3KgUSACU1VDJxymn/pbn+wH80/FAY3lml7WF2A/Gx77zhBBWCQG aHfCgI0swh8TOn4fXGz904O6E/rBH/I5LmsHAQ5nlipHq5WzXffunxQ+jFlFOxBIfaqIJB5uwK2 HRInYsV3u7152bu1cTmsBzWnrg5xreX7Eca900j1DpwtSaKjBJT0faBTTh/U5wbcIAHTQMc+AER /Uh8BsZjTpI0IrTUOkBATu2M//6bpz7mj3buAHTaGNGpSbH/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The binding dictates using 3 pwm-cells. Adhere to that.

This fixes the following dtbs_check warnings:

	arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-emmc-som-v15.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6dl-cubox-i-som-v15.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-cubox-i.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-emmc-som-v15.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#
	arch/arm/boot/dts/nxp/imx/imx6q-cubox-i-som-v15.dtb: pwm@2080000: #pwm-cells:0:0: 3 was expected
		from schema : http://devicetree.org/schemas/pwm/imx-pwm.yaml#

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
index 1e530d892b76..761566ae3cf5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-cubox-i.dtsi
@@ -64,7 +64,7 @@ led-1 {
 			active-low;
 			label = "imx6:red:front";
 			max-brightness = <248>;
-			pwms = <&pwm1 0 50000>;
+			pwms = <&pwm1 0 50000 0>;
 		};
 	};
 
@@ -233,7 +233,6 @@ MX6QDL_PAD_EIM_DA8__GPIO3_IO08	0x17059
 };
 
 &pwm1 {
-	#pwm-cells = <2>;
 	status = "okay";
 };
 
-- 
2.43.0


