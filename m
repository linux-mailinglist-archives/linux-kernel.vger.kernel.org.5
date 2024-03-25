Return-Path: <linux-kernel+bounces-116700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353B588A2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E006A1F2B6CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A598152520;
	Mon, 25 Mar 2024 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FmOoAIEm"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10740179957;
	Mon, 25 Mar 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355632; cv=none; b=Po6GE49zlEGR8RcGV4Zs1A0/L4fSyNFMx6hZJ3fdqdjO1R623cgf3f+zE/zb3IX37f14sg5gz+YNX31Nqc73YCVBAhmXosY9N4IR4AHtc5MxlFtwJmjgIe12Hv3o5UUoqEt4ablJv0C68teDy8GlD/ApaYuJRx2q7ZTTUAwUn74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355632; c=relaxed/simple;
	bh=ve2wzxhfk6D6pWJjiqnagq8/DB0FE32n/RkKoCuv8vA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Escz5uiYronc0mQftcU4BGca2Rbx8h74d3ctRIcmRM+2+S/VFDVqzi48r1YIPxqQsWzI9So1hw74t3B1avi5/B4liGTkBxeDdIbWXxA6Q7mYDMfncZPNQ220M/KQ0DrKFQ1qkqfGKf0g56d03tdP5IkbEOHy3xXTp+CbiAEyGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FmOoAIEm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 08ADB1FA01;
	Mon, 25 Mar 2024 09:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711355625;
	bh=mNS41FOyVsAOnUEk3gZHijAjdgdn/kzDlZJLki1qjos=; h=From:To:Subject;
	b=FmOoAIEmj4vnfLjU77jilulW19E9VyGA2LbpEXESa5WOYsFU2UlyCbLcVxZn28isd
	 dWu7qjjBwAkD4rWnn8Vb+S0BX8QREbLB4xc/LLJcLUZAi3ZH41x8DZUQ5zb84Wslir
	 HVEJfKzrfqiox4MygqRKfLODtPmxEHr8mTNQy9xfzBiR+Tb1XabXMRiqSOUqQLLkR5
	 GCdXQW5G3XQeB/g9C18sZo5E6WiwpNYIh0uRTcEYHDZr8qkDVY5AjrMKN16grXN66K
	 5MD2lPZg3bSxLWr2g0B0dHyQvd0nPYK0KM9IASClIrTZvfxo3MUBmHJTg2kj6hBO4H
	 k3r15PikaeGZw==
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
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Silva=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: [PATCH v2] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Date: Mon, 25 Mar 2024 09:33:40 +0100
Message-Id: <20240325083340.89568-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

TI SDHCI instance has a hardware debounce timer of 1 second as described
in commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
debounce timer"), because of this the boot time increases of up to 1
second.

Workaround the issue the same way that is done on
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts, using the SD1 CD as
GPIO.

Suggested-by: Nishanth Menon <nm@ti.com>
Reported-by: João Paulo Silva Gonçalves <joao.goncalves@toradex.com>
Closes: https://lore.kernel.org/all/0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 * rebased on v6.9-rc1
 * move `ti,fails-without-test-cd` before `status`
 * use SDHCI instance, instead of SDHCI IP in the commit message
v1: https://lore.kernel.org/all/20240312144956.40211-1-francesco@dolcini.it/
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index e8d8857ad51f..b1cc2e60aa23 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -457,6 +457,13 @@ AM62X_IOPAD(0x01c4, PIN_INPUT, 7) /* (B14) SPI0_D1.GPIO1_19 */ /* SODIMM 161 */
 		>;
 	};
 
+	/* Verdin SD_1_CD# as GPIO */
+	pinctrl_sd1_cd_gpio: main-gpio1-48-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 7) /* (D17) MMC1_SDCD.GPIO1_48 */ /* SODIMM 84 */
+		>;
+	};
+
 	/* Verdin DSI_1_INT# (pulled-up as active-low) */
 	pinctrl_dsi1_int: main-gpio1-49-default-pins {
 		pinctrl-single,pins = <
@@ -571,7 +578,6 @@ AM62X_IOPAD(0x230, PIN_INPUT,        0) /* (A22) MMC1_DAT0 */ /* SODIMM 80 */
 			AM62X_IOPAD(0x22c, PIN_INPUT,        0) /* (B21) MMC1_DAT1 */ /* SODIMM 82 */
 			AM62X_IOPAD(0x228, PIN_INPUT,        0) /* (C21) MMC1_DAT2 */ /* SODIMM 70 */
 			AM62X_IOPAD(0x224, PIN_INPUT,        0) /* (D22) MMC1_DAT3 */ /* SODIMM 72 */
-			AM62X_IOPAD(0x240, PIN_INPUT_PULLUP, 0) /* (D17) MMC1_SDCD */ /* SODIMM 84 */
 		>;
 	};
 
@@ -1441,10 +1447,12 @@ &sdhci0 {
 /* Verdin SD_1 */
 &sdhci1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sdhci1>;
+	pinctrl-0 = <&pinctrl_sdhci1>, <&pinctrl_sd1_cd_gpio>;
+	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vmmc-supply = <&reg_sdhc1_vmmc>;
 	vqmmc-supply = <&reg_sdhc1_vqmmc>;
+	ti,fails-without-test-cd;
 	status = "disabled";
 };
 
-- 
2.39.2


