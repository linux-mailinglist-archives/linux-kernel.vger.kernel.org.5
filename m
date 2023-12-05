Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094838053E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjLEMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbjLELzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:55:49 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2030.outbound.protection.outlook.com [40.92.46.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC9FA7;
        Tue,  5 Dec 2023 03:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hikTb7JCD1Av/Mt5tFaPcBSTicQJrb9UjdW9PbWNh5+ZILjWli99T3+NFZ1TpvG2VJYI4PKsQYYA2gq8sP4+Xa0jS5evRhj5c755uzz5EBXpNKp6cEfNuD3iL99gvVkB7I/oDa7DXCrIJSbVbqbDVSRw3CB7MQ5eywLmYY8Ji9ttmFghetoYv2ZIYeR4EV+BDR9a4t3AeKa0afkY9qJ7a6NKjCmuCkjaouOUk9E0gZr06qggURdaLn30ETCNlCXTE/hW+Y7sKwTKA8zo5euZzkm7XSwTGND3430wwn1YA1k7ys2lHzzrM9gqRV++J8vltXP1U9PJSd1oj6OH5LBmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkJ4tuqpyYiHc8hET54cWD7UWVWXOZRgCY+HCi+5uUk=;
 b=MFMrRIDZii+jiPAkPl867NjACfwbSDyKzCuxXENc9ZkNuQO9YLVTcGI7BUf/jucNWZfRPV8HdrRu+z5B3CwjeInsOvF6d+DVuYzSGI08c4/cWJTwf9j/3sbHkRPdrUsYLFcnmHJE1mNZjuiXqKU/vQp826z/EFA2SmqorlwrW8d/vxdY30JPX0C9w91v5cMA5/HuJJObRj4/LQQgf44vWFmRnOseSFHEykjtZF8Num94vrZw+dRp+20x0iP6TP2MiuWdjxbliwooS7aw/Lb1HtrmoqgUzW/oiItwwU0b4ufIYEkOD4bdGZbaCwhcJsg85wpahOELCYEwJQhzikUuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkJ4tuqpyYiHc8hET54cWD7UWVWXOZRgCY+HCi+5uUk=;
 b=Zz+qZnwr9S0cy+TAXygW4UkHMfkRq5uSeGuWo7scHmnIyemMz678maMcU3D3D1i9MtUh6g3E2WE969IFRGCIUO7RQrulNjwiUqCciti4sFZF5GMUFoZv43IdMZPXIYL3iZydyDu1SMbYQ92caR8udaej2kn/ztCH+ttsC7CWIITctU/Ryu828OImTbO/CWPahkcQRa0debTgJ1Nr0jiop6tdw5Kw0mDtBQ0jvtohkHWRugJN0z3iYfspK9kpwK6hvJZOG3++EPOcZiGe0H94wtZ6wDmkDHyfTkDl1Zn91XVPyfNLrfg0hU7ZHnrHoly+lijh+3pzlNX5/Jx+y3MXQg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7005.namprd20.prod.outlook.com (2603:10b6:408:1e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:55:52 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 11:55:52 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inochi Amaoto <inochiama@outlook.com>
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
Date:   Tue,  5 Dec 2023 19:55:50 +0800
Message-ID: <IA1PR20MB49535CCEBCC36C864B949CF5BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532E1A3D8BA71FDBB444BCBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mbD5R0mdaJ++KPxGbHL0X+SUUgI5o57LaHsp7rlZNWc=]
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205115555.1042712-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee0d60a-299c-46fc-2275-08dbf5892197
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2I/b1LLg9K8R7Q9yzqcTxAJgglEnWIq9I9pOZtczSR8HssTB7SRmSE2cf/gUBGCqjIicNfosEj3doDOjE8wm8F3+97tnb78l3xfJ8UGzUqA5inNiZ7TZMxuO/w6a9v9MReKT/bYtJcJrO7SItWou9T0ut/cFBKJVYJeZWcYJb0RGIfgS53B8++cjhf3BO0q8bjmCylKg1VYa80eF7uqc579nhQJxybyDs1HvcIrkuhs3aAnobs2sCSNDhzvdegkCf1ZqU79O/vfCgcpsSy/HfD79ROr+t4fBlisMaoLWr7ZCXMT2NmIjvOCO0ZqjsU9Nxi2Sx7x06ap46tXNL/KfJyUQAfY6ebKzX4tNG/4cs75LjqApMFXL9f2lkiTxZPOLVNPKqm4l1vnbbX8qF1csm4qNwTKHNCes8SIO22RsQQizdaCKoGTnUm/pH/oNbBRMOBdCrbkvoEyqYxGYZqZ777kQRKBSRXw3FUEuZnZxuLfqRwcM7TtpopEVFgEI3z8UdX8KVO3G7fsiOpMU5he7B3fIvClXzpWVd5BIiVjuIZVOoiEJ7Lw6gWwmfNQEN9v6yWlZTm1MTiEZtYV1dELLnIHK17Fa/Pm4xU9dVmeh6/m8GelM1tAkYHRmoLJbpqi
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NDI5hdrqdZoAT97c1q8sAycaYjtuc7Ye2EpLHMZgKVFVNEKO48d6bhxGSMrS?=
 =?us-ascii?Q?9y29865vf9pUbAk0Pc+oUsj4PRyABGdv7JqhvL+mczJdf9MfIhGVjd6XhREh?=
 =?us-ascii?Q?nULcKHRtxYrVjlKKR3p9D0cMZHNWwn6tdqHpFea2RavDBa5MORbQlx1g4+/o?=
 =?us-ascii?Q?MqmVJ437YIrK76K3b+ox30fWGSqCGuS+J1tfETUCJ2R5NKarKjxq0A1cwru9?=
 =?us-ascii?Q?KB2G7fUG1PPnoEz+Mvp6cfAcKof5NnHNGTnntjWW4vlK0fz+QCDMFEfxCXVH?=
 =?us-ascii?Q?D2FNrOkAX8OoQ/scl/6fQCQlB1B+2/QTGEO86R9/43rx/LeFGLTe25XbYuZd?=
 =?us-ascii?Q?sKJEKbxG3r9N11qpbraE9YuW4SHnG72ooqFRV0+D0kXIgewCAiKh3gv4Jkoi?=
 =?us-ascii?Q?l214NBnKdkIDd5q4ZM+gDzbrLP6V3lteDikknliX+GNlwW/b+bPAM6Ae4A56?=
 =?us-ascii?Q?bL6/eFn91/B28FfVNEJvVCPknkSr7Nagq0YxDRPLcSZGxJUAzbEbNJFdOHw1?=
 =?us-ascii?Q?0DWSoNMAmZxNjN9SmdqZ4QUB6bz7ZJfKv0TRTDvMN63kGNA9if59YOy68WFh?=
 =?us-ascii?Q?NzxSzXMxVZfJNfv7GxiQYSe6HJAtBUa1CCygkH9YiPcCXkjhW4obZqskkT8w?=
 =?us-ascii?Q?XsgzzN/2IOcCJgqkFv+28bwHCtDVRvBLPBFI+ZKIwK5Iiz8N2HQ+BrPeUupG?=
 =?us-ascii?Q?QwbaKL8+klRgxcQkLAC1VtOvzB2pPExyqlZEnRXrkh/gYmfnCbfzSTTVSaNB?=
 =?us-ascii?Q?ALE/L49O5eCXen0Bwg9xnrmy15Tc/ZJdL51jOaAAyazrUGtvSIYGgtQ+VIEk?=
 =?us-ascii?Q?EoA8abDi/TWQ2PXRkciRpQBkjOkXAG177xTXcLp+Jvc7YAY3Ur5wkXWakJI9?=
 =?us-ascii?Q?HTJDpuj/F2zLhfh6NtSBQTsqpiQokm1YUJdLVHc+JO9vLEcnpcnev9nHMKKZ?=
 =?us-ascii?Q?Sa63Whkx/TDX+YvJRmmREHy3i93VoXeygA6ebhjP8vo7HHwWHi0cxXRSQIms?=
 =?us-ascii?Q?WNNVFmH+53KI1Wp2SuIHOk7xsrB/h9kCasE7BeGRmjCX6xMJEgb78Z5+CX3U?=
 =?us-ascii?Q?DekdozwCR/KX4N7r1MtBUYpSo3vpnLGhleXyfmDZYdysxZIhxV0yINcgNaWS?=
 =?us-ascii?Q?r2zXnVNoKJQ76Nmiz6zIq9VJtgiQrwBueTJqIfBdZNXEV3IhDDaC3d2rkBRt?=
 =?us-ascii?Q?jLYPebBRgPxbYSgsk7vHAuTWeLYgDihKeK0W8JKtHKJdK3m99tOAc2utleg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee0d60a-299c-46fc-2275-08dbf5892197
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:55:52.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7005
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

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
---
 .../bindings/clock/sophgo,cv1800-clk.yaml     |  53 ++++++
 include/dt-bindings/clock/sophgo,cv1800.h     | 174 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,cv1800.h

diff --git a/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
new file mode 100644
index 000000000000..388be5bfa163
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo,cv1800-clk.yaml
@@ -0,0 +1,53 @@
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
+    items:
+      - description: Oscillator (25 MHz)
+
+  clock-names:
+    items:
+      - const: osc
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
+  - clock-names
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
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/sophgo,cv1800.h b/include/dt-bindings/clock/sophgo,cv1800.h
new file mode 100644
index 000000000000..a71ad2a93153
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,cv1800.h
@@ -0,0 +1,174 @@
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
+#define CLK_DISP_SRC_VIP		121
+#define CLK_DISP_VIP			122
+#define CLK_DSI_MAC_VIP			123
+#define CLK_LVDS0_VIP			124
+#define CLK_LVDS1_VIP			125
+#define CLK_PAD_VI_VIP			126
+#define CLK_PAD_VI1_VIP			127
+#define CLK_PAD_VI2_VIP			128
+#define CLK_CFG_REG_VIP			129
+#define CLK_VIP_IP0			130
+#define CLK_VIP_IP1			131
+#define CLK_VIP_IP2			132
+#define CLK_VIP_IP3			133
+#define CLK_IVE_VIP			134
+#define CLK_RAW_VIP			135
+#define CLK_OSDC_VIP			136
+#define CLK_CAM0_VIP			137
+#define CLK_AXI_VIDEO_CODEC		138
+#define CLK_VC_SRC0			139
+#define CLK_VC_SRC1			140
+#define CLK_VC_SRC2			141
+#define CLK_H264C			142
+#define CLK_APB_H264C			143
+#define CLK_H265C			144
+#define CLK_APB_H265C			145
+#define CLK_JPEG			146
+#define CLK_APB_JPEG			147
+#define CLK_CAM0			148
+#define CLK_CAM1			149
+#define CLK_WGN				150
+#define CLK_WGN0			151
+#define CLK_WGN1			152
+#define CLK_WGN2			153
+#define CLK_KEYSCAN			154
+#define CLK_CFG_REG_VC			155
+#define CLK_C906_0			156
+#define CLK_C906_1			157
+#define CLK_A53				158
+#define CLK_CPU_AXI0			159
+#define CLK_CPU_GIC			160
+#define CLK_XTAL_AP			161
+
+#endif /* __DT_BINDINGS_SOPHGO_CV1800_CLK_H__ */
--
2.43.0

