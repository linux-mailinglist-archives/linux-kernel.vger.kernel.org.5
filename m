Return-Path: <linux-kernel+bounces-8010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FC81B08E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25E51C21899
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E398179AE;
	Thu, 21 Dec 2023 08:44:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BA1A5A4;
	Thu, 21 Dec 2023 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2B36E7FFE;
	Thu, 21 Dec 2023 16:44:36 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:36 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:44:29 +0800
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Samin Guo
	<samin.guo@starfivetech.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Ley Foon Tan
	<leyfoon.tan@starfivetech.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>
Subject: [PATCH v5 2/2] riscv: dts: starfive: jh8100: Add watchdog node
Date: Thu, 21 Dec 2023 16:43:58 +0800
Message-ID: <20231221084358.3458713-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
References: <20231221084358.3458713-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

StarFive's JH8100 watchdog is based on JH7110, with JH8100 watchdog only
requiring one reset signal.

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh8100.dtsi
index 9863c61324a0..657d8b79e708 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -360,6 +360,15 @@ uart4: serial@121a0000  {
 			status =3D "disabled";
 		};
=20
+		watchdog@12270000 {
+			compatible =3D "starfive,jh8100-wdt", "starfive,jh7110-wdt";
+			reg =3D <0x0 0x12270000 0x0 0x10000>;
+			clocks =3D <&syscrg_ne SYSCRG_NE_CLK_WDT_APB>,
+				 <&syscrg_ne SYSCRG_NE_CLK_WDT>;
+			clock-names =3D "apb", "core";
+			resets =3D <&syscrg_ne SYSCRG_NE_RSTN_WDT0>;
+		};
+
 		syscrg_ne: syscrg_ne@12320000 {
 			compatible =3D "starfive,jh8100-syscrg-ne";
 			reg =3D <0x0 0x12320000 0x0 0x10000>;
--=20
2.25.1


