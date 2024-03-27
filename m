Return-Path: <linux-kernel+bounces-121827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0988EE45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5750CB254A5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68536150994;
	Wed, 27 Mar 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kPrjvyvv"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552A2130E35;
	Wed, 27 Mar 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564101; cv=none; b=Qbvhl7DOGWTltAv42wXXsDNdSngX6OCbP6umuICWuXz48+Ng6XuJTiupOf3YspDiB9f/oJ6JjC0fHwY80jHNUJrGYaYDv0bXCrKRcNrYkLw76I4LzCeCcmy3h+aQy3kA9dyS0j9Vq3BdlCqwYLDNB8EdZ6NuP8Co7Lt44BxnVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564101; c=relaxed/simple;
	bh=LLnL/dU/nDXok+K+9hwMxPGfmSl7e2k7pYod25SWBfE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVcNVmtVgy68pseMpSiJ1rDkFTWtKYpf9o6z3wPiHimdLP+6ithHe8H36O/zSFg7PFslgpZVpDb1T6rRA/rwN1QBo/ToS3eaqmMGlbmvCRRxToUs7q7ZTjr1tJI+i6d/e2Qx5RT9fwroVRYl161+kl3BAdN4Ji5eVrUEZ/ZqAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kPrjvyvv; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0C6251FAAA;
	Wed, 27 Mar 2024 19:28:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711564090;
	bh=XBE7Etg4FHFeDJ4P9UcaubZy83FkhqwTHnNHSjhW2eI=; h=From:To:Subject;
	b=kPrjvyvvNgVJgvMPX+oDD/FnJmfd5KAsFL9KOPf8NcVWZW2gVZJ8lvWoB43AowIVM
	 fdHmfNg3FgEPGf2ktbLA6LA4I93QYjie//BzGf6rJxqJzNoSCTsqqAz9tuSeJoUtft
	 YpEWK7g91A+8rQzWd77jX32ijK7xhEjTqEucpsfz711h4skLcqac/PSguuW0EUx4pX
	 ev+H4Elp1GWRy761l5B3ryimr3EF1heTw0YwYaE2Yi7jBDh7q6VUu4/sJ0CYhDUkfX
	 uzLMZsAlV2W9D2qGyvn3H2xIR2/rDXmCQa+zgDF4tFFlQFwEYaj2gZhkHTBvEtwHAF
	 dRFL7DrcTYYPA==
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
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-am625-verdin: add PCIe reset gpio hog
Date: Wed, 27 Mar 2024 19:28:01 +0100
Message-Id: <20240327182801.5997-3-francesco@dolcini.it>
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

Add a GPIO hog to release PCIe reset on the carrier board, this is
required to use M.2 or mPCIe cards.

Verdin AM62 does not have any PCIe interface, however the Verdin family
has PCIe and normally an M.2 or mPCIe slot is available in the carrier
board that can be used with cards that use only the USB interface toward
the host CPU, for example cellular network modem.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi | 8 +++++++-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi    | 8 +++++++-
 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi | 8 +++++++-
 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi  | 8 +++++++-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi        | 9 +++++++++
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index 6c4cec8728e4..e51fda1127ef 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -160,7 +160,8 @@ &mcu_gpio0 {
 	pinctrl-0 = <&pinctrl_gpio_1>,
 		    <&pinctrl_gpio_2>,
 		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>;
+		    <&pinctrl_gpio_4>,
+		    <&pinctrl_pcie_1_reset>;
 };
 
 /* Verdin I2C_3_HDMI */
@@ -211,6 +212,11 @@ &verdin_gpio_keys {
 	status = "okay";
 };
 
+/* Verdin PCIE_1_RESET# */
+&verdin_pcie_1_reset_hog {
+	status = "okay";
+};
+
 /* Verdin UART_2 */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
index be62648e7818..74eec1a1abca 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
@@ -181,7 +181,8 @@ &mcu_gpio0 {
 	pinctrl-0 = <&pinctrl_gpio_1>,
 		    <&pinctrl_gpio_2>,
 		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>;
+		    <&pinctrl_gpio_4>,
+		    <&pinctrl_pcie_1_reset>;
 };
 
 /* Verdin I2C_3_HDMI */
@@ -232,6 +233,11 @@ &verdin_gpio_keys {
 	status = "okay";
 };
 
+/* Verdin PCIE_1_RESET# */
+&verdin_pcie_1_reset_hog {
+	status = "okay";
+};
+
 /* Verdin UART_2 */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
index cd81a606c435..754216d8ac14 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
@@ -154,7 +154,8 @@ &mcu_gpio0 {
 	pinctrl-0 = <&pinctrl_gpio_1>,
 		    <&pinctrl_gpio_2>,
 		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>;
+		    <&pinctrl_gpio_4>,
+		    <&pinctrl_pcie_1_reset>;
 };
 
 /* Verdin I2C_3_HDMI */
@@ -200,6 +201,11 @@ &verdin_gpio_keys {
 	status = "okay";
 };
 
+/* Verdin PCIE_1_RESET# */
+&verdin_pcie_1_reset_hog {
+	status = "okay";
+};
+
 /* Verdin UART_2 */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
index 997dfafd27eb..7372d392ec8a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
@@ -159,7 +159,8 @@ &mcu_gpio0 {
 	pinctrl-0 = <&pinctrl_gpio_1>,
 		    <&pinctrl_gpio_2>,
 		    <&pinctrl_gpio_3>,
-		    <&pinctrl_gpio_4>;
+		    <&pinctrl_gpio_4>,
+		    <&pinctrl_pcie_1_reset>;
 };
 
 /* Verdin I2C_3_HDMI */
@@ -205,6 +206,11 @@ &verdin_gpio_keys {
 	status = "okay";
 };
 
+/* Verdin PCIE_1_RESET# */
+&verdin_pcie_1_reset_hog {
+	status = "okay";
+};
+
 /* Verdin UART_2 */
 &wkup_uart0 {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index e8d8857ad51f..e6c10d23d038 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1407,6 +1407,15 @@ &mcu_gpio0 {
 		"",
 		"",
 		"";
+
+	verdin_pcie_1_reset_hog: pcie-1-reset-hog {
+		gpio-hog;
+		/* Verdin PCIE_1_RESET# (SODIMM 244) */
+		gpios = <0 GPIO_ACTIVE_LOW>;
+		line-name = "PCIE_1_RESET#";
+		output-low;
+		status = "disabled";
+	};
 };
 
 /* Verdin CAN_2 */
-- 
2.39.2


