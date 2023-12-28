Return-Path: <linux-kernel+bounces-12471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB581F538
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A5EB22382
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A44E6FC5;
	Thu, 28 Dec 2023 06:53:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC65235;
	Thu, 28 Dec 2023 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9F3147F8A;
	Thu, 28 Dec 2023 14:53:46 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:46 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 28 Dec
 2023 14:53:41 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Yangtao Li <frank.li@vivo.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [PATCH 3/3] riscv: dts: starfive: jh8100: Add SD/eMMC device tree nodes
Date: Thu, 28 Dec 2023 14:53:22 +0800
Message-ID: <20231228065322.1176351-4-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
References: <20231228065322.1176351-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add SD/eMMC device tree nodes.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100.dtsi | 34 ++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh8100.dtsi
index 9c8ca73fffe0..545109ca6c49 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -484,6 +484,15 @@ syscrg_sw: syscrg_sw@12720000 {
 			#reset-cells =3D <1>;
 		};
=20
+		sd1: mmc@12740000 {
+			compatible =3D "starfive,jh8100-sd6hc", "cdns,sd6hc";
+			reg =3D <0x0 0x12740000 0x0 0x10000>;
+			interrupts =3D <91>;
+			bus-width =3D <4>;
+			cap-sd-highspeed;
+			status =3D "disabled";
+		};
+
 		pinctrl_gmac: pinctrl@12770000 {
 			compatible =3D "starfive,jh8100-sys-pinctrl-gmac",
 				     "syscon", "simple-mfd";
@@ -509,6 +518,31 @@ uart6: serial@127e0000  {
 			status =3D "disabled";
 		};
=20
+		emmc: mmc@1f110000 {
+			compatible =3D "starfive,jh8100-sd6hc", "cdns,sd6hc";
+			reg =3D <0x0 0x1f110000 0x0 0x10000>;
+			interrupts =3D <174>;
+			clock-names =3D "main", "sdmclk";
+			clocks =3D <&aoncrg AONCRG_CLK_EMMC_ICG_EN>,
+				 <&aoncrg AONCRG_CLK_EMMC_SDMCLK>;
+			resets =3D <&aoncrg AONCRG_RSTN_EMMC>;
+			bus-width =3D <8>;
+			status =3D "disabled";
+		};
+
+		sd0: mmc@1f120000 {
+			compatible =3D "starfive,jh8100-sd6hc", "cdns,sd6hc";
+			reg =3D <0x0 0x1f120000 0x0 0x10000>;
+			interrupts =3D <175>;
+			clock-names =3D "main", "sdmclk";
+			clocks =3D <&aoncrg AONCRG_CLK_SDIO0_ICG_EN>,
+				 <&aoncrg AONCRG_CLK_SDIO0_SDMCLK>;
+			resets =3D <&aoncrg AONCRG_RSTN_SDIO0>;
+			bus-width =3D <4>;
+			cap-sd-highspeed;
+			status =3D "disabled";
+		};
+
 		pinctrl_aon: pinctrl@1f300000 {
 			compatible =3D "starfive,jh8100-aon-pinctrl",
 				     "syscon", "simple-mfd";
--=20
2.25.1


