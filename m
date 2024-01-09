Return-Path: <linux-kernel+bounces-20837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC7E8285EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B851F21B77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1138F97;
	Tue,  9 Jan 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pschenker.ch header.i=@pschenker.ch header.b="myEaDlZZ"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2149338DE9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pschenker.ch
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T8VL555tJzMpwmh;
	Tue,  9 Jan 2024 12:17:17 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T8VL45F2RzMpnyv;
	Tue,  9 Jan 2024 13:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
	s=20220412; t=1704802637;
	bh=18NRiwEK9xrsbm41kX9IKtn+2/A7RIIp0cAjRJXOIwU=;
	h=From:To:Cc:Subject:Date:From;
	b=myEaDlZZ0IVPr+IARUNgOfpis0Dfv/CYoi7w5QsccJMWnK+zWsySyYMzTUa1x8I/5
	 PrIWXUkNOp8LXEzrdxVP+U7bdc8j1lN5TlMkYl44RviceNuJeAlcf4I6M7/99H5TGY
	 YLfxwSgIC92Jemc2aVH3w+a26EIlYdv1NQwieAKk=
From: Philippe Schenker <dev@pschenker.ch>
To: devicetree@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: imx8mp-verdin: Label ldo5 and link to usdhc2
Date: Tue,  9 Jan 2024 13:16:27 +0100
Message-Id: <20240109121627.223017-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Philippe Schenker <philippe.schenker@impulsing.ch>

This commit labels LDO5 as `reg_vdd_sdio` in `imx8mp-verdin.dtsi` to
facilitate changing its voltage to 1.8V, necessary for an SDIO
peripheral that requires 1.8V at default and high-speed modes.

Additionally, it links `reg_vdd_sdio` to `&usdhc2`, aligning with the
hardware configuration specified in the datasheet.

Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>

---

 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 04f2083c4ab2..837db8961ba7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -535,7 +535,7 @@ LDO4 {
 				regulator-name = "On-module +V3.3_ADC (LDO4)";
 			};
 
-			LDO5 {
+			reg_vdd_sdio: LDO5 {
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
 				regulator-name = "On-module +V3.3_1.8_SD (LDO5)";
@@ -873,6 +873,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_vdd_sdio>;
 };
 
 /* On-module eMMC */
-- 
2.34.1


