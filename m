Return-Path: <linux-kernel+bounces-8004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91C81B078
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E061F233EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B32179B8;
	Thu, 21 Dec 2023 08:37:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E122331;
	Thu, 21 Dec 2023 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id A268B80E2;
	Thu, 21 Dec 2023 16:37:10 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:37:09 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:37:03 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, "Ley
 Foon Tan" <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Drew Fustini" <drew@beagleboard.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH 6/6] riscv: dts: starfive: jh8100: add pinctrl device tree nodes
Date: Thu, 21 Dec 2023 16:36:22 +0800
Message-ID: <20231221083622.3445726-7-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add pinctrl_east/pinctrl_west/pinctrl_gmac/pinctrl_aon device
tree nodes for JH8100 SoC.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh8100-evb.dts   |   5 +
 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h | 418 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh8100.dtsi      |  44 ++
 3 files changed, 467 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-pinfunc.h

diff --git a/arch/riscv/boot/dts/starfive/jh8100-evb.dts b/arch/riscv/boo=
t/dts/starfive/jh8100-evb.dts
index c16bc25d8988..8634e41984f8 100644
--- a/arch/riscv/boot/dts/starfive/jh8100-evb.dts
+++ b/arch/riscv/boot/dts/starfive/jh8100-evb.dts
@@ -26,3 +26,8 @@ memory@40000000 {
 &uart0 {
 	status =3D "okay";
 };
+
+&pinctrl_aon {
+	wakeup-gpios =3D <&pinctrl_aon PAD_RGPIO2 GPIO_ACTIVE_HIGH>;
+	wakeup-source;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh8100-pinfunc.h b/arch/riscv/b=
oot/dts/starfive/jh8100-pinfunc.h
new file mode 100644
index 000000000000..3fb16ef62d90
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh8100-pinfunc.h
@@ -0,0 +1,418 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#ifndef __JH8100_PINFUNC_H__
+#define __JH8100_PINFUNC_H__
+
+/*
+ * mux bits:
+ *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   |  7 - 0  |
+ *  |  din    |  dout   |  doen   | function | gpio nr |
+ *
+ * dout:     output signal
+ * doen:     output enable signal
+ * din:      optional input signal, 0xff =3D none
+ * function:
+ * gpio nr:  gpio number, 0 - 63
+ */
+#define GPIOMUX(n, dout, doen, din) ( \
+		(((din)  & 0xff) << 24) | \
+		(((dout) & 0xff) << 16) | \
+		(((doen) & 0x3f) << 10) | \
+		((n) & 0x3f))
+
+#define PINMUX(n, func) ((1 << 10) | (((func) & 0x3) << 8) | ((n) & 0xff=
))
+
+/* sys_iomux_east dout */
+#define GPOUT_LOW				0
+#define GPOUT_HIGH				1
+#define GPOUT_SYS_CAN0_STBY			2
+#define GPOUT_SYS_CAN0_TST_NEXT_BIT		3
+#define GPOUT_SYS_CAN0_TST_SAMPLE_POINT		4
+#define GPOUT_SYS_CAN0_TXD			5
+#define GPOUT_SYS_I2C0_CLK			6
+#define GPOUT_SYS_I2C0_DATA			7
+#define GPOUT_SYS_I2S0_STEREO_RSCKO		8
+#define GPOUT_SYS_I2S0_STEREO_RWSO		9
+#define GPOUT_SYS_I2S0_STEREO_SDO_0		10
+#define GPOUT_SYS_I2S0_STEREO_SDO_1		11
+#define GPOUT_SYS_I2S0_STEREO_TSCKO		12
+#define GPOUT_SYS_I2S0_STEREO_TWSO		13
+#define GPOUT_SYS_SPI0_MO			14
+#define GPOUT_SYS_SPI0_SS0			15
+#define GPOUT_SYS_SPI0_SS1			16
+#define GPOUT_SYS_SPI0_SS2			17
+#define GPOUT_SYS_SPI0_SS3			18
+#define GPOUT_SYS_SPI0_SCLK			19
+#define GPOUT_SYS_SPI0_SO			20
+#define GPOUT_SYS_UART0_DTR			21
+#define GPOUT_SYS_UART0_RTS			22
+#define GPOUT_SYS_UART0_TX			23
+#define GPOUT_SYS_USB0_DBG_DRIVE_VBUS		24
+#define GPOUT_SYS_PDM_MCLK			25
+#define GPOUT_SYS_PWM_CHANNEL0			26
+#define GPOUT_SYS_PWM_CHANNEL1			27
+#define GPOUT_SYS_PWM_CHANNEL2			28
+#define GPOUT_SYS_PWM_CHANNEL3			29
+#define GPOUT_SYS_PWM_CHANNEL4			30
+#define GPOUT_SYS_PWM_CHANNEL5			31
+#define GPOUT_SYS_PWM_CHANNEL6			32
+#define GPOUT_SYS_PWM_CHANNEL7			33
+#define GPOUT_SYS_SMBUS0_CLK			34
+#define GPOUT_SYS_SMBUS0_DATA			35
+#define GPOUT_SYS_SMBUS0_SUSPEND		36
+#define GPOUT_SYS_CLK_GCLK1			37
+#define GPOUT_SYS_CLK_GCLK2			38
+#define GPOUT_SYS_CLK_GCLK3			39
+#define GPOUT_SYS_CLK_GCLK4			40
+#define GPOUT_SYS_CLK_GCLK6			41
+#define GPOUT_SYS_CLK_GCLK7			42
+#define GPOUT_SYS_MCLK				43
+#define GPOUT_SYS_USB0_TYPEC_DRIVE_VBUS		44
+#define GPOUT_SYS_WATCHDOG0_RESET		45
+#define GPOUT_SYS_CAN1_STBY			46
+#define GPOUT_SYS_CAN1_TST_NEXT_BIT		47
+#define GPOUT_SYS_CAN1_TST_SAMPLE_POINT		48
+#define GPOUT_SYS_CAN1_TXD			49
+#define GPOUT_SYS_I2C1_CLK			50
+#define GPOUT_SYS_I2C1_DATA			51
+#define GPOUT_SYS_I2S1_RSCKO			52
+#define GPOUT_SYS_I2S1_RWSO			53
+#define GPOUT_SYS_I2S1_SDO0			54
+#define GPOUT_SYS_I2S1_SDO1			55
+#define GPOUT_SYS_I2S1_SDO2			56
+#define GPOUT_SYS_I2S1_SDO3			57
+#define GPOUT_SYS_I2S1_SDO4			58
+#define GPOUT_SYS_I2S1_SDO5			59
+#define GPOUT_SYS_I2S1_SDO6			60
+#define GPOUT_SYS_I2S1_SDO7			61
+#define GPOUT_SYS_I2S1_TSCKO			62
+#define GPOUT_SYS_I2S1_TWSO			63
+#define GPOUT_SYS_SDIO1_PU_PD_DATA2		64
+#define GPOUT_SYS_SDIO1_BUS_POWER		65
+#define GPOUT_SYS_SDIO1_RESET			66
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_0		67
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_1		68
+#define GPOUT_SYS_SDIO1_BUS_VOLTAGE_2		69
+#define GPOUT_SYS_SDIO1_LED			70
+#define GPOUT_SYS_SPI1_MO			71
+#define GPOUT_SYS_SPI1_SS0			72
+#define GPOUT_SYS_SPI1_SS1			73
+#define GPOUT_SYS_SPI1_SS2			74
+#define GPOUT_SYS_SPI1_SS3			75
+#define GPOUT_SYS_SPI1_SCLK			76
+#define GPOUT_SYS_SPI1_SO			77
+#define GPOUT_SYS_UART1_DTR			78
+#define GPOUT_SYS_UART1_RTS			79
+#define GPOUT_SYS_UART1_TX			80
+#define GPOUT_SYS_USB1_DBG_DRIVE_VBUS		81
+#define GPOUT_SYS_I2C2_CLK			82
+#define GPOUT_SYS_I2C2_DATA			83
+#define GPOUT_SYS_UART2_DTR			84
+#define GPOUT_SYS_UART2_RTS			85
+#define GPOUT_SYS_UART2_TX			86
+#define GPOUT_SYS_USB2_DBG_DRIVE_VBUS		87
+#define GPOUT_SYS_I2C3_CLK			88
+#define GPOUT_SYS_I2C3_DATA			89
+#define GPOUT_SYS_UART3_DTR			90
+#define GPOUT_SYS_UART3_RTS			91
+#define GPOUT_SYS_UART3_TX			92
+#define GPOUT_SYS_USB3_DBG_DRIVE_VBUS		93
+#define GPOUT_SYS_I2C4_CLK			94
+#define GPOUT_SYS_I2C4_DATA			95
+#define GPOUT_SYS_UART4_DTR			96
+#define GPOUT_SYS_UART4_RTS			97
+#define GPOUT_SYS_UART4_TX			98
+#define GPOUT_SYS_I2C5_CLK			99
+#define GPOUT_SYS_I2C5_DATA			100
+
+/* sys_iomux_west dout */
+#define GPOUT_SYS_RSVD0				2
+#define GPOUT_SYS_RSVD1				3
+#define GPOUT_SYS_RSVD2				4
+#define GPOUT_SYS_RSVD3				5
+#define GPOUT_SYS_RSVD4				6
+#define GPOUT_SYS_RSVD5				7
+#define GPOUT_SYS_RSVD6				8
+#define GPOUT_SYS_RSVD7				9
+#define GPOUT_SYS_RSVD8				10
+#define GPOUT_SYS_HD_AUDIO0_BCLK		11
+#define GPOUT_SYS_HD_AUDIO0_RST			12
+#define GPOUT_SYS_HD_AUDIO0_SDI0_O		13
+#define GPOUT_SYS_HD_AUDIO0_SDI1_O		14
+#define GPOUT_SYS_HD_AUDIO0_SDO0		15
+#define GPOUT_SYS_HD_AUDIO0_SDO1		16
+#define GPOUT_SYS_HD_AUDIO0_SYNC		17
+#define GPOUT_SYS_HIFI4_JTAG_TDO		18
+#define GPOUT_SYS_CLK_GCLK5			19
+#define GPOUT_SYS_SMBUS1_CLK			20
+#define GPOUT_SYS_SMBUS1_DATA			21
+#define GPOUT_SYS_SMBUS1_SUSPEND		22
+#define GPOUT_SYS_SPI2_MO			23
+#define GPOUT_SYS_SPI2_SS0			24
+#define GPOUT_SYS_SPI2_SS1			25
+#define GPOUT_SYS_SPI2_SS2			26
+#define GPOUT_SYS_SPI2_SS3			27
+#define GPOUT_SYS_SPI2_SCLK			28
+#define GPOUT_SYS_SPI2_SO			29
+#define GPOUT_SYS_UART5_DTR			30
+#define GPOUT_SYS_UART5_RTS			31
+#define GPOUT_SYS_UART5_TX			32
+#define GPOUT_SYS_I2C6_CLK			33
+#define GPOUT_SYS_I2C6_DATA			34
+#define GPOUT_SYS_UART6_DTR			35
+#define GPOUT_SYS_UART6_RTS			36
+#define GPOUT_SYS_UART6_TX			37
+#define GPOUT_SYS_I2C7_CLK			38
+#define GPOUT_SYS_I2C7_DATA			39
+
+/* aon_iomux dout */
+#define GPOUT_AON_CLK_32K			2
+#define GPOUT_AON_CLK_GCLK0			3
+#define GPOUT_AON_CLK_GCLK_OSC			4
+#define GPOUT_AON_SIG_STUB_POWER_EN_O		5
+#define GPOUT_AON_EMMC_PU_PD_DATA2		6
+#define GPOUT_AON_EMMC_BUS_POWER		7
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_0		8
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_1		9
+#define GPOUT_AON_EMMC_BUS_VOLTAGE_2		10
+#define GPOUT_AON_EMMC_LED			11
+#define GPOUT_AON_SDIO0_PU_PD_DATA2		12
+#define GPOUT_AON_SDIO0_BUS_POWER		13
+#define GPOUT_AON_SDIO0_RESET			14
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_0		15
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_1		16
+#define GPOUT_AON_SDIO0_BUS_VOLTAGE_2		17
+#define GPOUT_AON_SDIO0_LED			18
+#define GPOUT_AON_JTAG_TDO			19
+#define GPOUT_AON_SCP_POWER_EN			20
+#define GPOUT_AON_WATCHDOG1_RESET		21
+#define GPOUT_AON_UART7_TX			22
+#define GPOUT_AON_I2C8_CLK			23
+#define GPOUT_AON_I2C8_DATA			24
+
+/* sys_iomux_east doen */
+#define GPOEN_SYS_ENABLE			0
+#define GPOEN_SYS_DISABLE			1
+#define GPOEN_SYS_I2C0_CLK			2
+#define GPOEN_SYS_I2C0_DATA			3
+#define GPOEN_SYS_I2S0_STEREO_SDOE_0		4
+#define GPOEN_SYS_I2S0_STEREO_SDOE_1		5
+#define GPOEN_SYS_SPI0_N_MO_EN			6
+#define GPOEN_SYS_SPI0_N_SCLK_EN		7
+#define GPOEN_SYS_SPI0_N_SO_EN			8
+#define GPOEN_SYS_SPI0_N_SS_EN			9
+#define GPOEN_SYS_PWM_CHANNEL0			10
+#define GPOEN_SYS_PWM_CHANNEL1			11
+#define GPOEN_SYS_PWM_CHANNEL2			12
+#define GPOEN_SYS_PWM_CHANNEL3			13
+#define GPOEN_SYS_PWM_CHANNEL4			14
+#define GPOEN_SYS_PWM_CHANNEL5			15
+#define GPOEN_SYS_PWM_CHANNEL6			16
+#define GPOEN_SYS_PWM_CHANNEL7			17
+#define GPOEN_SYS_SMBUS0_CLK			18
+#define GPOEN_SYS_SMBUS0_DATA			19
+#define GPOEN_SYS_SMBUS0_ALERT			20
+#define GPOEN_SYS_I2C1_CLK			21
+#define GPOEN_SYS_I2C1_DATA			22
+#define GPOEN_SYS_I2S1_SDO0			23
+#define GPOEN_SYS_I2S1_SDO1			24
+#define GPOEN_SYS_I2S1_SDO2			25
+#define GPOEN_SYS_I2S1_SDO3			26
+#define GPOEN_SYS_I2S1_SDO4			27
+#define GPOEN_SYS_I2S1_SDO5			28
+#define GPOEN_SYS_I2S1_SDO6			29
+#define GPOEN_SYS_I2S1_SDO7			30
+#define GPOEN_SYS_SPI1_N_MO_EN			31
+#define GPOEN_SYS_SPI1_N_SCLK_EN		32
+#define GPOEN_SYS_SPI1_N_SO_EN			33
+#define GPOEN_SYS_SPI1_N_SS_EN			34
+#define GPOEN_SYS_I2C2_CLK			35
+#define GPOEN_SYS_I2C2_DATA			36
+#define GPOEN_SYS_I2C3_CLK			37
+#define GPOEN_SYS_I2C3_DATA			38
+#define GPOEN_SYS_I2C4_CLK			39
+#define GPOEN_SYS_I2C4_DATA			40
+#define GPOEN_SYS_I2C5_CLK			41
+#define GPOEN_SYS_I2C5_DATA			42
+
+/* sys_iomux_west doen */
+#define GPOEN_SYS_RSVD0				2
+#define GPOEN_SYS_RSVD1				3
+#define GPOEN_SYS_RSVD2				4
+#define GPOEN_SYS_RSVD3				5
+#define GPOEN_SYS_RSVD4				6
+#define GPOEN_SYS_RSVD5				7
+#define GPOEN_SYS_RSVD6				8
+#define GPOEN_SYS_HD_AUDIO0_SDI0		9
+#define GPOEN_SYS_HD_AUDIO0_SDI1		10
+#define GPOEN_SYS_HIFI4_JTAG_TDO		11
+#define GPOEN_SYS_SMBUS1_CLK			12
+#define GPOEN_SYS_SMBUS1_DATA			13
+#define GPOEN_SYS_SMBUS1_ALERT			14
+#define GPOEN_SYS_SPI2_MO			15
+#define GPOEN_SYS_SPI2_SCLK			16
+#define GPOEN_SYS_SPI2_SO			17
+#define GPOEN_SYS_SPI2_SS			18
+#define GPOEN_SYS_I2C6_CLK			19
+#define GPOEN_SYS_I2C6_DATA			20
+#define GPOEN_SYS_I2C7_CLK			21
+#define GPOEN_SYS_I2C7_DATA			22
+
+/* aon_iomux doen */
+#define GPOEN_AON_JTAG_TDO			2
+#define GPOEN_AON_I2C8_CLK			3
+#define GPOEN_AON_I2C8_DATA			4
+
+/* sys_iomux din */
+#define GPI_NONE				255
+
+/* sys_iomux_east din */
+#define GPI_SYS_CAN0_RXD			0
+#define GPI_SYS_I2C0_CLK			1
+#define GPI_SYS_I2C0_DATA			2
+#define GPI_SYS_SPI0_SCLK			3
+#define GPI_SYS_SPI0_MI				4
+#define GPI_SYS_SPI0_SS_N			5
+#define GPI_SYS_SPI0_SI				6
+#define GPI_SYS_UART0_CTS			7
+#define GPI_SYS_UART0_DCD			8
+#define GPI_SYS_UART0_DSR			9
+#define GPI_SYS_UART0_RI			10
+#define GPI_SYS_UART0_RX			11
+#define GPI_SYS_USB0_DBG_OVERCURRENT		12
+#define GPI_SYS_PDM_DMIC0			13
+#define GPI_SYS_PDM_DMIC1			14
+#define GPI_SYS_I2SRX0_SDIN0			15
+#define GPI_SYS_I2SRX0_SDIN1			16
+#define GPI_SYS_SMBUS0_CLK			17
+#define GPI_SYS_SMBUS0_DATA			18
+#define GPI_SYS_SMBUS0_ALERT			19
+#define GPI_SYS_JTAG_TCK			20
+#define GPI_SYS_MCLK_EXT			21
+#define GPI_SYS_I2SRX0_BCLK			22
+#define GPI_SYS_I2SRX0_LRCK			23
+#define GPI_SYS_I2STX0_BCLK			24
+#define GPI_SYS_I2STX0_LRCK			25
+#define GPI_SYS_SPI0_SCLK_IN0			26
+#define GPI_SYS_SPI0_SCLK_IN1			27
+#define GPI_SYS_I2S0_STEREO_RX_BCLK		28
+#define GPI_SYS_I2S0_STEREO_RX_LRCK		29
+#define GPI_SYS_I2S0_STEREO_TX_BCLK		30
+#define GPI_SYS_I2S0_STEREO_TX_LRCK		31
+#define GPI_SYS_I2S1_RX_BCLK			32
+#define GPI_SYS_I2S1_RX_LRCK			33
+#define GPI_SYS_I2S1_TX_BCLK			34
+#define GPI_SYS_I2S1_TX_LRCK			35
+#define GPI_SYS_USB0_TYPEC_OVERCURRENT		36
+#define GPI_SYS_CAN1_RXD			37
+#define GPI_SYS_I2C1_CLK			38
+#define GPI_SYS_I2C1_DATA			39
+#define GPI_SYS_I2S1_SDI_0			40
+#define GPI_SYS_I2S1_SDI_1			41
+#define GPI_SYS_I2S1_SDI_2			42
+#define GPI_SYS_I2S1_SDI_3			43
+#define GPI_SYS_I2S1_SDI_4			44
+#define GPI_SYS_I2S1_SDI_5			45
+#define GPI_SYS_I2S1_SDI_6			46
+#define GPI_SYS_I2S1_SDI_7			47
+#define GPI_SYS_SDIO1_CARD_DETECT		48
+#define GPI_SYS_SDIO1_WRITE_PROTECT		49
+#define GPI_SYS_SPI1_EXT_CLK			50
+#define GPI_SYS_SPI1_MI				51
+#define GPI_SYS_SPI1_SS_IN			52
+#define GPI_SYS_SPI1_SI				53
+#define GPI_SYS_UART1_CTS			54
+#define GPI_SYS_UART1_DCD			55
+#define GPI_SYS_UART1_DSR			56
+#define GPI_SYS_UART1_RI			57
+#define GPI_SYS_UART1_RX			58
+#define GPI_SYS_USB1_DBG_OVERCURRENT		59
+#define GPI_SYS_I2C2_CLK			60
+#define GPI_SYS_I2C2_DATA			61
+#define GPI_SYS_UART2_CTS			62
+#define GPI_SYS_UART2_DCD			63
+#define GPI_SYS_UART2_DSR			64
+#define GPI_SYS_UART2_RI			65
+#define GPI_SYS_UART2_RX			66
+#define GPI_SYS_USB2_DBG_OVERCURRENT		67
+#define GPI_SYS_I2C3_CLK			68
+#define GPI_SYS_I2C3_DATA			69
+#define GPI_SYS_UART3_CTS			70
+#define GPI_SYS_UART3_DCD			71
+#define GPI_SYS_UART3_DSR			72
+#define GPI_SYS_UART3_RI			73
+#define GPI_SYS_UART3_RX			74
+#define GPI_SYS_USB3_DBG_OVERCURRENT		75
+#define GPI_SYS_I2C4_CLK			76
+#define GPI_SYS_I2C4_DATA			77
+#define GPI_SYS_UART4_CTS			78
+#define GPI_SYS_UART4_DCD			79
+#define GPI_SYS_UART4_DSR			80
+#define GPI_SYS_UART4_RI			81
+#define GPI_SYS_UART4_RX			82
+#define GPI_SYS_I2C5_CLK			83
+#define GPI_SYS_I2C5_DATA			84
+
+/* sys_iomux_west din */
+#define GPI_SYS_RSVD0				0
+#define GPI_SYS_RSVD1				1
+#define GPI_SYS_RSVD2				2
+#define GPI_SYS_RSVD3				3
+#define GPI_SYS_RSVD4				4
+#define GPI_SYS_RSVD5				5
+#define GPI_SYS_RSVD6				6
+#define GPI_SYS_HD_AUDIO0_SDI0_I		7
+#define GPI_SYS_HD_AUDIO0_SDI1_I		8
+#define GPI_SYS_HIFI4_JTAG_TDI			9
+#define GPI_SYS_HIFI4_JTAG_TMS			10
+#define GPI_SYS_HIFI4_JTAG_RST			11
+#define GPI_SYS_RSVD7				12
+#define GPI_SYS_HIFI4_JTAG_TCK			13
+#define GPI_SYS_RSVD8				14
+#define GPI_SYS_SPI0_SCLK_IN2			15
+#define GPI_SYS_SMBUS1_CLK			16
+#define GPI_SYS_SMBUS1_DATA			17
+#define GPI_SYS_SMBUS1_ALERT			18
+#define GPI_SYS_SPI2_EXT_CLK			19
+#define GPI_SYS_SPI2_MI				20
+#define GPI_SYS_SPI2_SS_IN			21
+#define GPI_SYS_SPI2_SI				22
+#define GPI_SYS_UART5_CTS			23
+#define GPI_SYS_UART5_DCD			24
+#define GPI_SYS_UART5_DSR			25
+#define GPI_SYS_UART5_RI			26
+#define GPI_SYS_UART5_RX			27
+#define GPI_SYS_I2C6_CLK			28
+#define GPI_SYS_I2C6_DATA			29
+#define GPI_SYS_UART6_CTS			30
+#define GPI_SYS_UART6_DCD			31
+#define GPI_SYS_UART6_DSR			32
+#define GPI_SYS_UART6_RI			33
+#define GPI_SYS_UART6_RX			34
+#define GPI_SYS_I2C7_CLK			35
+#define GPI_SYS_I2C7_DATA			36
+
+/* aon_iomux din */
+#define GPI_AON_JTAG_TCK			0
+#define GPI_AON_SIG_STUB_RESERVED_0		1
+#define GPI_AON_SIG_STUB_RESERVED_1		2
+#define GPI_AON_SIG_STUB_RESERVED_2		3
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_0		4
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_1		5
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_2		6
+#define GPI_AON_XSPI0_GP_OPEN_DRAIN_3		7
+#define GPI_AON_SDIO0_CARD_DETECTION		8
+#define GPI_AON_SDIO0_WRITE_PROTECTION		9
+#define GPI_AON_SRC_BUF_JTAG_RST		10
+#define GPI_AON_JTAG_TDI			11
+#define GPI_AON_JTAG_TMS			12
+#define GPI_AON_UART7_RX			13
+#define GPI_AON_I2C8_CLK			14
+#define GPI_AON_I2C8_DATA			15
+
+#endif
diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/d=
ts/starfive/jh8100.dtsi
index 9863c61324a0..9c8ca73fffe0 100644
--- a/arch/riscv/boot/dts/starfive/jh8100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -5,6 +5,8 @@
=20
 /dts-v1/;
 #include <dt-bindings/clock/starfive,jh8100-crg.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
 #include <dt-bindings/reset/starfive,jh8100-crg.h>
 #include "jh8100-clk.dtsi"
=20
@@ -360,6 +362,18 @@ uart4: serial@121a0000  {
 			status =3D "disabled";
 		};
=20
+		pinctrl_east: pinctrl@122d0000 {
+			compatible =3D "starfive,jh8100-sys-pinctrl-east",
+				     "syscon", "simple-mfd";
+			reg =3D <0x0 0x122d0000 0x0 0x10000>;
+			clocks =3D <&syscrg_ne SYSCRG_NE_CLK_IOMUX_EAST_PCLK>;
+			resets =3D <&syscrg_ne SYSCRG_NE_RSTN_SYS_IOMUX_E>;
+			interrupts =3D <182>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+		};
+
 		syscrg_ne: syscrg_ne@12320000 {
 			compatible =3D "starfive,jh8100-syscrg-ne";
 			reg =3D <0x0 0x12320000 0x0 0x10000>;
@@ -434,6 +448,18 @@ syscrg_nw: syscrg_nw@123c0000 {
 			#reset-cells =3D <1>;
 		};
=20
+		pinctrl_west: pinctrl@123e0000 {
+			compatible =3D "starfive,jh8100-sys-pinctrl-west",
+				     "syscon", "simple-mfd";
+			reg =3D <0x0 0x123e0000 0x0 0x10000>;
+			clocks =3D <&syscrg_nw SYSCRG_NW_CLK_IOMUX_WEST_PCLK>;
+			resets =3D <&syscrg_nw SYSCRG_NW_RSTN_SYS_IOMUX_W>;
+			interrupts =3D <183>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+		};
+
 		syscrg: syscrg@126d0000 {
 			compatible =3D "starfive,jh8100-syscrg";
 			reg =3D <0x0 0x126d0000 0x0 0x10000>;
@@ -458,6 +484,13 @@ syscrg_sw: syscrg_sw@12720000 {
 			#reset-cells =3D <1>;
 		};
=20
+		pinctrl_gmac: pinctrl@12770000 {
+			compatible =3D "starfive,jh8100-sys-pinctrl-gmac",
+				     "syscon", "simple-mfd";
+			status =3D "disabled";
+			reg =3D <0x0 0x12770000 0x0 0x10000>;
+		};
+
 		uart5: serial@127d0000  {
 			compatible =3D "starfive,jh8100-uart", "cdns,uart-r1p8";
 			reg =3D <0x0 0x127d0000 0x0 0x10000>;
@@ -476,6 +509,17 @@ uart6: serial@127e0000  {
 			status =3D "disabled";
 		};
=20
+		pinctrl_aon: pinctrl@1f300000 {
+			compatible =3D "starfive,jh8100-aon-pinctrl",
+				     "syscon", "simple-mfd";
+			reg =3D <0x0 0x1f300000 0x0 0x10000>;
+			resets =3D <&aoncrg AONCRG_RSTN_AON_IOMUX_PRESETN>;
+			interrupts =3D <160>;
+			interrupt-controller;
+			gpio-controller;
+			#gpio-cells =3D <2>;
+		};
+
 		aoncrg: aoncrg@1f310000 {
 			compatible =3D "starfive,jh8100-aoncrg";
 			reg =3D <0x0 0x1f310000 0x0 0x10000>;
--=20
2.25.1


