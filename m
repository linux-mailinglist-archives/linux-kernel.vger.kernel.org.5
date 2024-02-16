Return-Path: <linux-kernel+bounces-68463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8EB857A85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9A281799
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06052F7D;
	Fri, 16 Feb 2024 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="GQEAbCVk"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DB1EA73;
	Fri, 16 Feb 2024 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080186; cv=none; b=XpBnHInpwwY/X2YtdZo1t+HgaaKar7PBZToLi0o7UK6iaMVwK7mFAsKcyZNsIfotxiG39b7YiuDYYnAN2o2omlupH6DfK+/JwvN9IuCeWhO+2qkENQGVx+h9ztlQFM99dZ9tv7A1/l36edZKv4mI2hv1IDXA/AsIKqnCQa3FA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080186; c=relaxed/simple;
	bh=dYt4+bsRVChAZxDRXVRdgR3p1sIvnLqzGOD4N6Srd2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ijtCfx1V+LFrqQM85KreB1vVhuDAuA6z5mihvX6WkRhDnlFwIrC7fq0LKO1o0hz0Vk7unt7k4Jrn6yJkhvcbJT/JVb4kyF38UeWoONy8bTFah593BW2KaUYxG7TQlKreptnCUaaGebdgc3+gIW+KqmJ11As/0woHz82Nk9Xz01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=GQEAbCVk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 765BF22533;
	Fri, 16 Feb 2024 11:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1708080180;
	bh=lILCCVDpv4TSePKRO4sehh2ym0PKUbFZyoHWNmTyAF8=; h=From:To:Subject;
	b=GQEAbCVkfq1zUI6SODikNg5z3gVzvia8TQ0QbeYQGJJxNBrBm2PfaZBJrwb4D8n67
	 fxrYYi9tprQzfpxXL/+hs2mECWq8tFriOxLTqRCyeUO2c7AEkXDo2CcxGLIdHDmz4B
	 6HptLDaSba0lTQiobppeQRdvSsgxZ6iPdXYj4O8Iii04hjNvr9UdkC4ddBj64FWcFd
	 b1+V7uv2BEXJfQbSTKeGDTgPrdhd7Sry6mq8ndO17g9XR1tExEjkJwGb+anFgacn9v
	 Ath70p7kw2BQatrYXlBA8R76WArqhU4J4jW24PgYw+aqkEsLxxtm54Mdhb57kVYNXy
	 MZlgaUTGKIApA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Roland Hieber <rhi@pengutronix.de>,
	Hiago De Franco <hiagofranco@gmail.com>
Subject: [PATCH v1] ARM: dts: imx7: remove DSI port endpoints
Date: Fri, 16 Feb 2024 11:42:55 +0100
Message-Id: <20240216104255.21052-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This fixes the display not working on colibri imx7, the driver fails to
load with the following error:

  mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge

NXP i.MX7 LCDIF is connected to both the Parallel LCD Display and to a
MIPI DSI IP block, currently it's not possible to describe the
connection to both.

Remove the port endpoint from the SOC dtsi to prevent regressions, this
would need to be defined on the board DTS.

Reported-by: Hiago De Franco <hiagofranco@gmail.com>
Closes: https://lore.kernel.org/r/34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia/
Fixes: edbbae7fba49 ("ARM: dts: imx7: add MIPI-DSI support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index ebf7befcc11e..9c81c6baa2d3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -834,16 +834,6 @@ lcdif: lcdif@30730000 {
 					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
 				clock-names = "pix", "axi";
 				status = "disabled";
-
-				port {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					lcdif_out_mipi_dsi: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&mipi_dsi_in_lcdif>;
-					};
-				};
 			};
 
 			mipi_csi: mipi-csi@30750000 {
@@ -895,22 +885,6 @@ mipi_dsi: dsi@30760000 {
 				samsung,esc-clock-frequency = <20000000>;
 				samsung,pll-clock-frequency = <24000000>;
 				status = "disabled";
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						mipi_dsi_in_lcdif: endpoint@0 {
-							reg = <0>;
-							remote-endpoint = <&lcdif_out_mipi_dsi>;
-						};
-					};
-				};
 			};
 		};
 
-- 
2.39.2


