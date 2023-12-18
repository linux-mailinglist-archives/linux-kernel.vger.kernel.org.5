Return-Path: <linux-kernel+bounces-2980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADC816583
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9482827D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBD539C;
	Mon, 18 Dec 2023 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Wps1Lz5M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2091.outbound.protection.outlook.com [40.92.15.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582963A3;
	Mon, 18 Dec 2023 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5OiKCXeOg1EzemFQ3qfDoqlsUdMYzrSogkj7yw4kqwF67ZXMXyh1/JKzVljdZoaSe+gxEgDtOUqrwI2Ll7HtqmWMsSMwD7KwXgKe2LlHShDiKNXv6m17QhGz0aDw/v6d6Ixx089oiQqRueu6LR8DN7YG2+cA9wvTjZu0S9CVANHkZfexhCIP+OSvvnQ+/6tB3NZcMeby0Ircd/35YCe1fll45vq02+SDObnHvi+CRjN/N55YiTT9+tKaGx5LIp/koCP+4W+/Pn+qtk+31Pb+8wUSzuU317lMAoJa1uOEb+N7M4HiH9J6G9iVdtFwXxfm7XUK3VSf77riJDripuDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HdgU7H2nhyRpso2nTAa2zf+sY/fnXNZmmlUiuP2SJI=;
 b=FYr7aEAIktqrLBuxGV6yeHLqf9UGRK8ZYI27HCzOQ//tnY6YuwXLzPqcsB3XT1jwmeBk4P6poIAOW/5gIK6VmXkiUZcrLghEilHP4Y7SvpOxf0Eq4QMcAgBiQT7qtLkq2Y/S410l19wYrdmLumJcGsj8PfgURiGxNFMkzDXwEQrVG82gkdGKbKfZNiZvXVBa+8QQ38iX7J/VVh7Gj7YiImaNpgFQCIOUzKdx/uRl5fNNkGFMtczbqUmx0NEaLU5/DBecoxKN/9wlkUJjD7fVyD63q1NKpEqivn2DeN/CeaNz/SGo0/FY/FFQ2ngtyZpC2uDupNLf1taCvAhcwfBoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HdgU7H2nhyRpso2nTAa2zf+sY/fnXNZmmlUiuP2SJI=;
 b=Wps1Lz5Mlo3aJsf4MXiB2lmdumd/X4asYWGYgFZgxnKeIrPxElSo2ZrxLPQlwpXWEKgqHG8fjSE7CG5y4T7hoPFNhii4wnYZeHXa1u6NDzxdCY+wldHAXLf30je3tGTrua/akMlWDbPzLuAf5p4OxRTr2difDbjfER+HjyVG9gtCWGOTGPg7CVdcchsz8E3Mnv0yTdMXAOx6E24RD5pFxhpspnRoSv03g966+jt35g7kE9qkRP1j5cz23WHI7xWiDhGS/LS9zLcKeiI8Y2YjOsl4TKd/EOCI3ews3hjNZcZmatMpwfrG0uNHHjcyfQIVK5FBK/M4ruuwPl9ZXAYqog==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by BN0PR20MB3976.namprd20.prod.outlook.com (2603:10b6:408:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 04:04:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 04:04:15 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date: Mon, 18 Dec 2023 12:04:03 +0800
Message-ID:
 <IA1PR20MB49535E448097F6FFC1218C39BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495354167CE560FC18E28DC5BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495354167CE560FC18E28DC5BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ZM1fdSAnHO2ZMEmzk45oG6hlrkUOPgyOY/swCxhqyi4=]
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20231218040407.574287-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|BN0PR20MB3976:EE_
X-MS-Office365-Filtering-Correlation-Id: deb4e84a-e4d9-4532-52fe-08dbff7e6689
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hnMn27/HDXyb438Y/eulTZN1BMGbbRlFHFEMeW3YZ54tG1crr07wKtFHR/OhQUAozIxIPG8DVnya5CYTjtVyaWYSrKWfoVNRRPmZ6mEoO2KErt1mpRhlz/glV4iCXo2Lh0nwnIQLPM0siBRScKl7juEHXMEOFVOcaYXz0yRur/bprU7FkFLwXlbThPlWO1gaGsw9jXVoIFqU+FJFrxcdM2L19vAK6TXxN+gL9ZaBxjN8mxKzJycYIrFx4mk7rjBzrh8sYNboMTYF4JvBhf5yWe0MLVHoYh0rrS2xhF9SdOcrRlKgAMVu1EZsp2jlpD0XUVe/eSt/By0xd2rqboRJ62aQkGY6SSWrqB0sbDXsLnt1JqbgMQ/Mo41plXfMCHLxQmOdkif5EmJB4Y8h3/ht2qupVr+Gh21OYg71IwpGUwhm8627UCv74pTgfw9ahRd0jy6ymLWyyjmUYV8bhrdCgH9p1r8Vmbv0O6EtaJKa2E8ScLBjWmYOSiGua7xFm5RwH7kgkArlQm/u/pc9q/tMOBIpvTNAmfVyHrt2ey2GACv5dQAw5+f+S3119q0RG1ZsbHeFdMOR1Ylwrbpq95bLS/wcE1/Rn6tzXqPYarKY8NPPh+vkxz75H2yslZF7ATagUw7HNOCPxpsScX0u6SD5Uyrzhs9u03dzE4sei2xeq5g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0U+QHH0HmjmpKIHwpF71WcYmNaEYgeT4YCQjp2rKBI5hLKkHYu9kj7EqRXK7?=
 =?us-ascii?Q?SPIuCEzSiySrs2kkzgrl1vV8Aad6Ytv3b2Uaf+Mjsx+RfipJ90fG0pMvvl73?=
 =?us-ascii?Q?OjNHD6mq34SkkIxSLhtQbwgKOlU4ACEu2LD+44fLFmquQ1WNaBOt9gvuO7BI?=
 =?us-ascii?Q?YN9/LmWEnlAokgTqqjiK8aABi2B09bnUtm6JMZOgGeJu7nOFDEOl8c13zvaP?=
 =?us-ascii?Q?q455j9RIqLSO0RYxjszYBZr0Y2/+Ghr08cuE7YyDkMMdEag+aeDcQZ9lDdiu?=
 =?us-ascii?Q?02tzoQq9/B6phR9NiWBHkb7XdhjdTvLEO5uD5Zd9fdgdoLifZYPUBYTMitW4?=
 =?us-ascii?Q?x6Tqb/qzzAbN3DUHv4nHKIyfSzxI8Qjt/h5mfAQE8AW8mMxvJWUCgjWYBlxk?=
 =?us-ascii?Q?C7BvWkHU0HkNGYuKuhyLIeLN/3Wi1iUhSSCpPrYzHLcEfAVUR1Ko6qnBCfju?=
 =?us-ascii?Q?KKNz2h6Uzo/qUmMq5XsblKhTQtz1jw94MC61rGSc0Zqlns8KG6q5jzwgAg5j?=
 =?us-ascii?Q?P4bu8Xt2BQ0Le8Wh8GrtR+0lR9IKzLRMdl0kPJp69hvs9vXhOOmne36nL8Io?=
 =?us-ascii?Q?8d6OhWAN76kpanax39ffodo9UabBegzaiEkSk+uM1kksMnPN27Sym488VQe2?=
 =?us-ascii?Q?wjYKfbupdypx0ME69Qowr2GOCKhhbRGuHPhDxgteJLXcH1GzMNxqYNcIITO1?=
 =?us-ascii?Q?G9z8A6zwk0DfFN7bknJsVVtM/jZyQGLQe2ZtIqm2RuT9+8tu+CpBE0S5td8l?=
 =?us-ascii?Q?X8YK/TfaclSIeGS81rG5iDUdIxcRWcETxRAcQ3lNVx1mspPf5VEj1AZt9ep5?=
 =?us-ascii?Q?IqFASx6RVh9auyerh5KFKeeuPqktBfbFOuhDWGseI7ZaZDl7tzUDzZTz5Zqr?=
 =?us-ascii?Q?TBwL41MF54WawMQozm7A+/isBXSn/7Ge5QXh9nzF5rg91QXhM/D6kQLb9e3u?=
 =?us-ascii?Q?rECK7v0feN9JJVxU934jsyKbM/vbL0FyZmGImqbULXT9QAm3HHFGPGj/kkKE?=
 =?us-ascii?Q?zHjqCWFOoDJSHHZe17xA9/XmwyhpgHIvUSqJAgGW3cV1kGpwbB7/t4NV2rra?=
 =?us-ascii?Q?5SaZD3OmAFRNsnQr2OCJdrc36757ilbZzgpV9xQDsYZ1ZHG7pAewaDhfZ3tc?=
 =?us-ascii?Q?FEOiz7xZsoYHxyTlJn/vcLuQkM3D8BLFoqeblz6qbbHSgS4l0gIW2j+HwjNj?=
 =?us-ascii?Q?YuFrxib2DppiUlhJ/gyjvSY2CcPZTycSG4GlfKLmn7kzda1TPVyCXXEP8G4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb4e84a-e4d9-4532-52fe-08dbff7e6689
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 04:04:15.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR20MB3976

Add definition for the clock controller of the CV1800 series SoC.

For CV181X, it has a clock that CV180X does not have. To avoid misuse,
also add a compatible string to identify CV181X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/sophgo,cv1800-clk.yaml     |  46 +++++
 include/dt-bindings/clock/sophgo,cv1800.h     | 176 ++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
new file mode 100644
index 000000000000..c1dc24673c0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo,cv1800-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800 Series Clock Controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    enum:
+      - sophgo,cv1800-clk
+      - sophgo,cv1810-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,cv1800.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@3002000 {
+        compatible = "sophgo,cv1800-clk";
+        reg = <0x03002000 0x1000>;
+        clocks = <&osc>;
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
new file mode 100644
index 000000000000..cfbeca25a650
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,cv1800.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 Sophgo Ltd.
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
+#define __DT_BINDINGS_SOPHGO_CV1800_CLK_H__
+
+#define CLK_MPLL			0
+#define CLK_TPLL			1
+#define CLK_FPLL			2
+#define CLK_MIPIMPLL			3
+#define CLK_A0PLL			4
+#define CLK_DISPPLL			5
+#define CLK_CAM0PLL			6
+#define CLK_CAM1PLL			7
+
+#define CLK_MIPIMPLL_D3			8
+#define CLK_CAM0PLL_D2			9
+#define CLK_CAM0PLL_D3			10
+
+#define CLK_TPU				11
+#define CLK_TPU_FAB			12
+#define CLK_AHB_ROM			13
+#define CLK_DDR_AXI_REG			14
+#define CLK_RTC_25M			15
+#define CLK_SRC_RTC_SYS_0		16
+#define CLK_TEMPSEN			17
+#define CLK_SARADC			18
+#define CLK_EFUSE			19
+#define CLK_APB_EFUSE			20
+#define CLK_DEBUG			21
+#define CLK_AP_DEBUG			22
+#define CLK_XTAL_MISC			23
+#define CLK_AXI4_EMMC			24
+#define CLK_EMMC			25
+#define CLK_EMMC_100K			26
+#define CLK_AXI4_SD0			27
+#define CLK_SD0				28
+#define CLK_SD0_100K			29
+#define CLK_AXI4_SD1			30
+#define CLK_SD1				31
+#define CLK_SD1_100K			32
+#define CLK_SPI_NAND			33
+#define CLK_ETH0_500M			34
+#define CLK_AXI4_ETH0			35
+#define CLK_ETH1_500M			36
+#define CLK_AXI4_ETH1			37
+#define CLK_APB_GPIO			38
+#define CLK_APB_GPIO_INTR		39
+#define CLK_GPIO_DB			40
+#define CLK_AHB_SF			41
+#define CLK_AHB_SF1			42
+#define CLK_A24M			43
+#define CLK_AUDSRC			44
+#define CLK_APB_AUDSRC			45
+#define CLK_SDMA_AXI			46
+#define CLK_SDMA_AUD0			47
+#define CLK_SDMA_AUD1			48
+#define CLK_SDMA_AUD2			49
+#define CLK_SDMA_AUD3			50
+#define CLK_I2C				51
+#define CLK_APB_I2C			52
+#define CLK_APB_I2C0			53
+#define CLK_APB_I2C1			54
+#define CLK_APB_I2C2			55
+#define CLK_APB_I2C3			56
+#define CLK_APB_I2C4			57
+#define CLK_APB_WDT			58
+#define CLK_PWM_SRC			59
+#define CLK_PWM				60
+#define CLK_SPI				61
+#define CLK_APB_SPI0			62
+#define CLK_APB_SPI1			63
+#define CLK_APB_SPI2			64
+#define CLK_APB_SPI3			65
+#define CLK_1M				66
+#define CLK_CAM0_200			67
+#define CLK_PM				68
+#define CLK_TIMER0			69
+#define CLK_TIMER1			70
+#define CLK_TIMER2			71
+#define CLK_TIMER3			72
+#define CLK_TIMER4			73
+#define CLK_TIMER5			74
+#define CLK_TIMER6			75
+#define CLK_TIMER7			76
+#define CLK_UART0			77
+#define CLK_APB_UART0			78
+#define CLK_UART1			79
+#define CLK_APB_UART1			80
+#define CLK_UART2			81
+#define CLK_APB_UART2			82
+#define CLK_UART3			83
+#define CLK_APB_UART3			84
+#define CLK_UART4			85
+#define CLK_APB_UART4			86
+#define CLK_APB_I2S0			87
+#define CLK_APB_I2S1			88
+#define CLK_APB_I2S2			89
+#define CLK_APB_I2S3			90
+#define CLK_AXI4_USB			91
+#define CLK_APB_USB			92
+#define CLK_USB_125M			93
+#define CLK_USB_33K			94
+#define CLK_USB_12M			95
+#define CLK_AXI4			96
+#define CLK_AXI6			97
+#define CLK_DSI_ESC			98
+#define CLK_AXI_VIP			99
+#define CLK_SRC_VIP_SYS_0		100
+#define CLK_SRC_VIP_SYS_1		101
+#define CLK_SRC_VIP_SYS_2		102
+#define CLK_SRC_VIP_SYS_3		103
+#define CLK_SRC_VIP_SYS_4		104
+#define CLK_CSI_BE_VIP			105
+#define CLK_CSI_MAC0_VIP		106
+#define CLK_CSI_MAC1_VIP		107
+#define CLK_CSI_MAC2_VIP		108
+#define CLK_CSI0_RX_VIP			109
+#define CLK_CSI1_RX_VIP			110
+#define CLK_ISP_TOP_VIP			111
+#define CLK_IMG_D_VIP			112
+#define CLK_IMG_V_VIP			113
+#define CLK_SC_TOP_VIP			114
+#define CLK_SC_D_VIP			115
+#define CLK_SC_V1_VIP			116
+#define CLK_SC_V2_VIP			117
+#define CLK_SC_V3_VIP			118
+#define CLK_DWA_VIP			119
+#define CLK_BT_VIP			120
+#define CLK_DISP_VIP			121
+#define CLK_DSI_MAC_VIP			122
+#define CLK_LVDS0_VIP			123
+#define CLK_LVDS1_VIP			124
+#define CLK_PAD_VI_VIP			125
+#define CLK_PAD_VI1_VIP			126
+#define CLK_PAD_VI2_VIP			127
+#define CLK_CFG_REG_VIP			128
+#define CLK_VIP_IP0			129
+#define CLK_VIP_IP1			130
+#define CLK_VIP_IP2			131
+#define CLK_VIP_IP3			132
+#define CLK_IVE_VIP			133
+#define CLK_RAW_VIP			134
+#define CLK_OSDC_VIP			135
+#define CLK_CAM0_VIP			136
+#define CLK_AXI_VIDEO_CODEC		137
+#define CLK_VC_SRC0			138
+#define CLK_VC_SRC1			139
+#define CLK_VC_SRC2			140
+#define CLK_H264C			141
+#define CLK_APB_H264C			142
+#define CLK_H265C			143
+#define CLK_APB_H265C			144
+#define CLK_JPEG			145
+#define CLK_APB_JPEG			146
+#define CLK_CAM0			147
+#define CLK_CAM1			148
+#define CLK_WGN				149
+#define CLK_WGN0			150
+#define CLK_WGN1			151
+#define CLK_WGN2			152
+#define CLK_KEYSCAN			153
+#define CLK_CFG_REG_VC			154
+#define CLK_C906_0			155
+#define CLK_C906_1			156
+#define CLK_A53				157
+#define CLK_CPU_AXI0			158
+#define CLK_CPU_GIC			159
+#define CLK_XTAL_AP			160
+
+// Only for CV181x
+#define CLK_DISP_SRC_VIP		161
+
+#endif /* __DT_BINDINGS_SOPHGO_CV1800_CLK_H__ */
--
2.43.0


