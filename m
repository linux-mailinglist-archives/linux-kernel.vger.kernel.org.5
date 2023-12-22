Return-Path: <linux-kernel+bounces-9558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607081C783
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481FE1C23E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F839FBFA;
	Fri, 22 Dec 2023 09:45:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2FD2F4;
	Fri, 22 Dec 2023 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id AC31D24E2E2;
	Fri, 22 Dec 2023 17:45:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:45:52 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 22 Dec 2023 17:45:51 +0800
From: William Qiu <william.qiu@starfivetech.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Hal
 Feng" <hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v10 3/4] riscv: dts: starfive: jh7100: Add PWM node and pins configuration
Date: Fri, 22 Dec 2023 17:45:47 +0800
Message-ID: <20231222094548.54103-4-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222094548.54103-1-william.qiu@starfivetech.com>
References: <20231222094548.54103-1-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add OpenCores PWM controller node and add PWM pins configuration
on VisionFive 1 board.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../boot/dts/starfive/jh7100-common.dtsi      | 24 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7100.dtsi      |  9 +++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7100-common.dtsi
index b93ce351a90f..11876906cc05 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -84,6 +84,24 @@ GPO_I2C2_PAD_SDA_OEN,
 		};
 	};
=20
+	pwm_pins: pwm-0 {
+		pwm-pins {
+			pinmux =3D <GPIOMUX(7,
+				  GPO_PWM_PAD_OUT_BIT0,
+				  GPO_PWM_PAD_OE_N_BIT0,
+				  GPI_NONE)>,
+				 <GPIOMUX(5,
+				  GPO_PWM_PAD_OUT_BIT1,
+				  GPO_PWM_PAD_OE_N_BIT1,
+				  GPI_NONE)>;
+			bias-disable;
+			drive-strength =3D <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate =3D <0>;
+		};
+	};
+
 	uart3_pins: uart3-0 {
 		rx-pins {
 			pinmux =3D <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
@@ -154,6 +172,12 @@ &osc_aud {
 	clock-frequency =3D <27000000>;
 };
=20
+&pwm {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pwm_pins>;
+	status =3D "okay";
+};
+
 &uart3 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&uart3_pins>;
diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7100.dtsi
index e68cafe7545f..4f5eb2f60856 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -280,6 +280,15 @@ watchdog@12480000 {
 				 <&rstgen JH7100_RSTN_WDT>;
 		};
=20
+		pwm: pwm@12490000 {
+			compatible =3D "starfive,jh7100-pwm", "opencores,pwm-v1";
+			reg =3D <0x0 0x12490000 0x0 0x10000>;
+			clocks =3D <&clkgen JH7100_CLK_PWM_APB>;
+			resets =3D <&rstgen JH7100_RSTN_PWM_APB>;
+			#pwm-cells =3D <3>;
+			status =3D "disabled";
+		};
+
 		sfctemp: temperature-sensor@124a0000 {
 			compatible =3D "starfive,jh7100-temp";
 			reg =3D <0x0 0x124a0000 0x0 0x10000>;
--=20
2.34.1


