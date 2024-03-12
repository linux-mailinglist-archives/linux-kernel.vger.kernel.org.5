Return-Path: <linux-kernel+bounces-100403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58EC8796F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F881F265FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647A7BAF6;
	Tue, 12 Mar 2024 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BvTG8xQe"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B35BF4FA;
	Tue, 12 Mar 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255350; cv=none; b=gx4WaS+vXHFDcgN7ELZWWxakrnPCdvxSous0DxemWBBijQeIOsZ91KNaASxaIlCXB9SSW+CQ0kKnXJs549mrjpoBQ82cHNPNAWkaib6+P2WCgt+zMUNDHD2b1G9fZKJvAoUZrEQo+cWzvuZNwTnR8NtgnSiV2Yg257hfpyO1qrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255350; c=relaxed/simple;
	bh=Usc6II35rVzJzpenuRz/2bqBjACu/dy3zUh+dVjJGIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q/O0bLSIlea0C0ZyB0T22cyfDibH3mDknXFQZAXPKSlVkV2lTdMzJoi9ueiy5MN25udSlpMlLrpAbRR8DU98GtCJZkJLAtlx+jFSte5UCcDB15jPKvvOPA6r889Sji2j5ssKdcoHpG2BRjoUqpVVaBhjpB4NdAXticFDx+pBtWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BvTG8xQe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3DD392136C;
	Tue, 12 Mar 2024 15:50:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710255002;
	bh=KnYzDyMeuR48i4fmNxkTQzPwgnl3FF6TOTdlr9ivhJs=; h=From:To:Subject;
	b=BvTG8xQe0m0s8Lms5yOHgjAzMv4CUox3XM7B4jHt6xq90vwhoo+fyyao36uGs9Yjj
	 SGPZZxF2iv4xM/6ocuvAiTUZlKmxYMIiiMteZEhhQPKyQjpIoFiIeJvTX+v4b2MvSN
	 UPV+imeMVPcrIenApjZBIIt9axE+gDRdXgK7+u+wciQYLcShuu++oIbVkfLx1AvrU5
	 eIJg54Q0I7J7yfeyVmx1I8SVIeBMf5wdgQ1k+SM1ZKAwAHv2yEZVs3c7oV067sjT+C
	 TQLK1/ABLj7iAbMzXwRovde4+9h9BBQQg/joqQDtQbkNKzdjmxxNqhHcsG0LwLPTES
	 8KPRK05ah6nAg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Silva=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Date: Tue, 12 Mar 2024 15:49:56 +0100
Message-Id: <20240312144956.40211-1-francesco@dolcini.it>
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

TI SDHCI IP has a hardware debounce timer of 1 second as described in
commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
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
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index e8d8857ad51f..a9bf2c17f95a 100644
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
 
@@ -1441,8 +1447,10 @@ &sdhci0 {
 /* Verdin SD_1 */
 &sdhci1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_sdhci1>;
+	pinctrl-0 = <&pinctrl_sdhci1>, <&pinctrl_sd1_cd_gpio>;
+	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	ti,fails-without-test-cd;
 	vmmc-supply = <&reg_sdhc1_vmmc>;
 	vqmmc-supply = <&reg_sdhc1_vqmmc>;
 	status = "disabled";
-- 
2.39.2


