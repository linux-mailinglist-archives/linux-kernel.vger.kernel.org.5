Return-Path: <linux-kernel+bounces-121826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9088EE44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DE3B2566E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061B150983;
	Wed, 27 Mar 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="V5qf6BVE"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E214F135;
	Wed, 27 Mar 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564101; cv=none; b=D5K344CixhBNhYA455fWNzX9zE32jN0WOWwq2giRcH+ALA34ByJ3vzg1o8F92vrK3nZcNxFGLx774dS87xI9XGNtihWhVb3ZKoLhaEkUy/5/8T7le0Pjpn9PYs7iYpqqw1IJ3wUiqRp81SV46lHX5pc4ZLmUGkMvf/rJ6SZoDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564101; c=relaxed/simple;
	bh=DFJra9/5wLByms/C1dWD7bT5U5zIZb/H55dSfGCFYYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rq70iz7Yp5Eu0JKn43MZlfEXS5Zdu/0jE/v3rhV+nioNAM26a09MIurq+tWJum3fmTVVr+6VUbIx3in5Bg+80gplmz5Fe/JQbWinuhjgjcHh3b7Rl/A2wboLewnqCJmYoyqwI11q1OHTsVYk0Tj0NiAHfUT+Hqf84WOoyjYfeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=V5qf6BVE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6A1721FAA8;
	Wed, 27 Mar 2024 19:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711564089;
	bh=aUEDDCQ/oHsMZTtm8xZjVGlGmONXKTSdGRv/zq3/650=; h=From:To:Subject;
	b=V5qf6BVE1tVhw3lOvEt6gYXXUzfRoOGGRHopRkfyHAhcuT6uLBV5qkyGHtC8F7rRs
	 KJ/Fv0HhBoJMVGWSNYOjvoblwaGXZrDC/TxVbRiHflMjNr/Nk5p8qlbEDbza+SRGFW
	 UjK4v7hlnQt+1wdSHXIMs4Svx4VhnkY7QbJe22jUHZGa9BCCvhB3K/GvhvYGxVDDmH
	 qH9d7aqSniQ8CsdPxzOmoGI6o4EGI9vpLDsfz6oT1QYBz+apMOvq3eE1+RX1VTwc8S
	 4FKquhNItOprM/e+c4Np7ToZaRi3Prf6Bl+97L3eZ+fXa9KSpR5Y2T2COrRnHrl6Ba
	 p7H095/14Irqg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: ti: verdin-am62: mallow: fix GPIOs pinctrl
Date: Wed, 27 Mar 2024 19:28:00 +0100
Message-Id: <20240327182801.5997-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327182801.5997-1-francesco@dolcini.it>
References: <20240327182801.5997-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Generic GPIOs pinctrl nodes are not correct, gpio[1-4] are into the MCU
domain and should be into &mcu_gpio0, gpio[5-8] were missing and are added
in this commit.

Fixes: 7698622fbcf4 ("arm64: dts: ti: Add verdin am62 mallow board")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
index 77b1beb638ad..cd81a606c435 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
@@ -81,10 +81,10 @@ &epwm1 {
 &main_gpio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>,
-		    <&pinctrl_gpio_1>,
-		    <&pinctrl_gpio_2>,
-		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>;
+		    <&pinctrl_gpio_5>,
+		    <&pinctrl_gpio_6>,
+		    <&pinctrl_gpio_7>,
+		    <&pinctrl_gpio_8>;
 };
 
 /* Verdin I2C_1 */
@@ -149,6 +149,14 @@ &main_uart1 {
 	status = "okay";
 };
 
+&mcu_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_1>,
+		    <&pinctrl_gpio_2>,
+		    <&pinctrl_gpio_3>,
+		    <&pinctrl_gpio_4>;
+};
+
 /* Verdin I2C_3_HDMI */
 &mcu_i2c0 {
 	status = "okay";
-- 
2.39.2


