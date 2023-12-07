Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2A9808332
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378373AbjLGIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLGIh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:37:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EDD7E;
        Thu,  7 Dec 2023 00:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JESCDiGF4/MV7hrr/AkUeswWki+zrXBgwvlQiphg/LENLUuzn8I0NGjS+Mf2/j0AtBtro3yUW66wk8lD+2VkUQa8o+VEKm1ph0JDjX4b7NqWZi2yrDaQLbbcFq7I1cUoaAVn/8wk2Qyw4w6dc3M2o6pgMLzu3rf0ukywO/oJJPiChpOfp4x9nf3fXZT7UqPL8RSrtQlv7rsSrHnI5jwFoqMWjkf2hPhVyx2vzemk2nEejUCUUFSzCvywGBrT0jPDcJiLxyR7SepXR/QfIt8hTkZxekFdvGz+iPaNfXQ3nk5XvGewIJ3rtAbnMqOVN/z0hvhksMtHEUR2bAbLpUq7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLSjQyBFEdYSwFCbl2Lfi51J4l1r+mCS4c9dYk52QTA=;
 b=ULR+/Pc1G2JNYzBtIC07AHIlKblSMRz6STqbEjK7aeZ8nxRBlcp4G01FMj1QiHOhgURSiIU+4wEYFklHGRRPL/oFqiF1u3Un3yziFQftXjhT2Kuz5tAqasblNAW13DsL3w8CstBOhO51F5NEgA65RK3GVZITG8MIjpFJviEA7R7naEgr4PsJvBOhUVzls8aJyujSmB7AFQ7PGTylsv9Enb6Qr1CguaJBwvRINCTwXtJigrKFpy3JhmFIvcHtCX6D2nml9B5SW7Biz1fldMUuniAVeue094Gj6KyBk0S+9fjto0bOPFt5AcVO2ixs+kIqgnxFiKkzLZMxVG7WdicsNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLSjQyBFEdYSwFCbl2Lfi51J4l1r+mCS4c9dYk52QTA=;
 b=TK3CG10RpVmh0Ahjskd+iwjNyVJIZC+mxT4nc0e6vT+j/eG5XGUqlqgvWWukOXoy9X1seXCJYMzdAT8bDROB+yfJmnfRGxk6yJfwbZE3aK+rKYAWWUSDgjjRpI3wxa/kSMveB6kI3e8BpQhEVtGW6OInzZHs5GulnxQ+IILxLD0V3RCqsot6GhpxVERzY0e5oqSgVuY0iJ0aNoOcahST0N3gXKW1FNnXJZ2qJ4LrFJtACLt/ZTeA0rJTLB+UD5GrznrhWT0/wY+fCsexsxuDDoX2jrI5adCmVOn6cnIade8r8ZCQNzy9mttFCSRbwK9zL2rUKZRjlvhlIlQiJJqoTQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV2PR20MB4582.namprd20.prod.outlook.com (2603:10b6:408:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:37:33 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Thu, 7 Dec 2023
 08:37:33 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
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
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Liu Gui <kenneth.liu@sophgo.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        qiujingbao.dlmu@gmail.com, dlan@gentoo.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Thu,  7 Dec 2023 16:37:26 +0800
Message-ID: <IA1PR20MB4953637E7A6C121D7A700F1CBB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495376DBED8EE897FE11A2B7BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495376DBED8EE897FE11A2B7BB8BA@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bc0+3z3C4BYwHN8UsIFYbHzjUmZHde5KGbdko0rKFAc=]
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231207083730.874690-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV2PR20MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1cc889-91ab-4f64-7dfb-08dbf6ffc18f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGYuilr8yf8yoRauRJOKRq1AQT2KT6048RscugYaymw6zUpIdy5TNSyhsQzLuF5L0qbFvoguEW5Ld7EBJ+X5FjhMMgrjsZHETqtYBHEvSTEiY/Jggq9/sRPjDncTxSfhiy7pPleQj6h26bqgfaAcVxFHHxhuhk6R6A5EjGDzCqw/A6O9M64nnQbtX4/cvEqz+Hx0iDqIpkJCrKCkGaH3MOPZ9Vjbh3OTJtf/CjlupAcsPQaC/bRV/Tjm3k3zZ064S2z70FbbHdOcpJgJd+1xRi6TJfmsEPdxBwCrLNoDvIMyvbPM7NBsaUe0DLxUKjPRpoUyNzKigZ+CWt0SjXvd4fHYSQNxKm6Pw/80LppvKNgqPvNFj4WoU0lfUSM2AUD7/lQFQ7ltu5eKshKLRcc84JfQHn7n0szjn2PWkEOy24oClF3cuKX9gf/45bVlVOGpNqy5g7UsC9opP18ilm2mufZGFR6U8SqqA4a+0tpuEQsSBkYNRrrZvFAEgA5IrOzrPfSnBztFiQ6NlJvOE9CtxkXxH9MHH6L6H9luvH4LJ6wX3Q2mNWM9uBQ9nxebxIfewYb7ZgWPwDdwe1mBi1naQcgiJJqKY6pefCNTNnkuYagaVYCbNmhzgXSy8sCDN+tS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSogsXByw7LVaN2tmE2B1B0KbJMKiDKO303tG5f7Qt52R7MmaZl6genkZGm/?=
 =?us-ascii?Q?Ka5ij28y2vXe37euosZ/M2xsXQ5w+n20WtUOwZnx9/QDmH06oCh6FMgqV158?=
 =?us-ascii?Q?vU0B0jhTKIY4vDSYWsusgG4fA6P1lbXZ9RQmTUR83had8a5rEIeePHy8BAzR?=
 =?us-ascii?Q?k9tbwddm3ZosYnUVIw/sxjE/3t4uiLMlTp1hWPsfPUoynOWp8e2SQlDxdanz?=
 =?us-ascii?Q?7U4CsziC6f4Xa7A7/LDja3vXficViI6uWoiz4pUkTIW0OWzsFHoYijwZQ/OV?=
 =?us-ascii?Q?4607Ox9S0uOe9BS60C4IIEb8TKEJSOXAxSiKj2xG9HIGcB21sW6AabMyYsrr?=
 =?us-ascii?Q?WX48IfXQeRzpU0YlX1Ni3jpW4kk9a68UDOEBkNgf2jeL94Neqems1nxH1lNn?=
 =?us-ascii?Q?+A5JoPixSPWhCo/oFqo5ZMzMdxZYdf2Fin85nW/QMga4UIUi2XH1mpiE6u8K?=
 =?us-ascii?Q?jmSGT1XVoZb5aGts/06lETdnxXlNTDBdCxgYzsBY+o1tO9/3Q6KpRsO2yUOC?=
 =?us-ascii?Q?nP8UTbzlwL1XVdl03SKCkNgcOZza3nryJc43bS0941/svHk3PXL1let5hKta?=
 =?us-ascii?Q?zvXgdJYtuoQot3kpFRC15ZrqQDblCK+Y80jfZeM8I4W79i4ygD2f0ldqBsKS?=
 =?us-ascii?Q?WQb4nN6YK0JexU9/biOOI/ViSN4A8pJSi93jTOhasQlx2HbIjUJdwGcWdxjc?=
 =?us-ascii?Q?LCSUbiH6hRtGDQc720c1kBIYrq/GJWEancLAkItvuBY4JyNfWbNcx4inYDEL?=
 =?us-ascii?Q?dcSzOJpTECFoyvXWz57pNZrrVOLJMoTlZPRZaI8r5uBzzkVUlOinM8oYNR8P?=
 =?us-ascii?Q?RF+AIFkjuSGDDXeND44RcZykdGjNfP/LbXJc5fgb8fSxLNbktzY4mWYh2dn4?=
 =?us-ascii?Q?FOm4ECZcIDz5UzQtvRdgWYg5rKosRDcjVQC0iM969mjmVqUUxrZh5C++wQ+F?=
 =?us-ascii?Q?jRWwwa4FcK7617CHzydy7w/8NrsbwLhAYmPuoKb1syA5Q6ZxpCFdUOcoVcZU?=
 =?us-ascii?Q?ujiL3iW0vhrbtJUAiQFyjqMkvbhUvK3PjNC9Movihp++brpBvAWdnT6nBgRf?=
 =?us-ascii?Q?NyJ8y22GLyeUwl777xeJaja562UN5W2Ze8zea8O+vbCHemdAq0FEkRBNqpwh?=
 =?us-ascii?Q?0g7yh4+wkJaYlP3HIyq1Qs5Wx8tB3KIGEXTmXlr14N3w8wjU1DVJXuhQm9OV?=
 =?us-ascii?Q?jPJjbD4/1DYdjdqfhfeANQa4jG1n+TYQKCawcSgxWpuHcRB/l9+/++RF+Gk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1cc889-91ab-4f64-7dfb-08dbf6ffc18f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:37:33.0090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4582
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for the clock controller of the CV1800 series SoC.

For CV181X, it has a clock that CV180X does not have. To avoid misuse,
also add a compatible string to identify CV181X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
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

