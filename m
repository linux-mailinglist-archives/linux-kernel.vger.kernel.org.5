Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C00804E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjLEJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjLEJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:43:53 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2026.outbound.protection.outlook.com [40.92.21.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F60FA;
        Tue,  5 Dec 2023 01:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY6HUjN4uezscdjG0plVNSq1kk86VG3U6uKMGTEZl5l3nnbImQHCzTAIT/aMgNoUCnANfE0ytj+b508wrbYotZCcpgfNRgnDpAH1lspH6+CcduYNTz1evUe4cMr5mNxBZgkqZcD6hzgcDrz5Biw60bUSS/CICZe15UweoLQiIFgGi3O0SXEjNaDt0kjCDRR2+HJqdv6bqaa3sHXs8Nmr/N86U+IXHt552PZl2RJCv9Vr3feLTNr6YgBXxSPFkRHc8rrob6P6sET08//5cg6c7E943j+UKqDfQnNj6x2zfUxGqb7EG/MC0nH0zgQob6P9MgCsjvVE7ZAzWgl7hImmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NpWk5fG9YlMiD35v+jOlQ6yaCJRWY5P/wsjQxDHxQI=;
 b=QftxWaZRlVITjK7YCxnzxAUHoAkoc5CYTaG83URv1W85YH4wKKzxS9GAm/+TGjSmlaXTO5VwNbPpwhhAQEzuPbdvEHPMmKlDbabqWxNbV4FOaw82G18NDBdKIIbpoxbXiHKEqP0LWlzclOR9WaMr3eL2f8166lrWVM4Dj3fxYormkQCxY7/y4M5z709ozXPHOaelCOp6jYvJFjCg5EIJM1Vy4A+kMA8UX93XXZItA9/7Iq9AxXcFF7p/2jszOsML3cLv/0qHdWV0XmA5e0F0k4XMOe5kVzaQ4tM+VchKwC2+R1ty5jp6s5903EM61vmQ1YqVbAUx7sxUhS0sCZ/2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NpWk5fG9YlMiD35v+jOlQ6yaCJRWY5P/wsjQxDHxQI=;
 b=Wng2luilb1A3RyVhnU5jWk2RpCzH38b9XV2FYl4NjuTJtOGSf1XwrC+W1P0ovS9XvU1p/9te2XIzM/jaunqplDldLz0fdU0z5a8pl4DueAMxfkx2kKW3HNHL35OKHbW0XQtbCJmjI0NBaHw7sP/h89lhG6j9jMVbz+MocKYPtMgPrU+Zdw1vSB2pOCrGin8Ik1fOOoWDtxNU6EXUWlIkWmjisZCof5WqMeUNKMLT6j7L4rIfNzSI929X8vX4heE7BJB19EwZBMU860M4Oxq97s3CuxnK47w1XFTQwIEGDCMFm+Szt9Px6bDpu2TuRlHG+2toj3i0juUVDKGC8kfFiQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5247.namprd20.prod.outlook.com (2603:10b6:806:25e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:43:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::55b:c350:980:ad8%6]) with mapi id 15.20.7046.024; Tue, 5 Dec 2023
 09:43:47 +0000
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
Subject: [PATCH 1/4] dt-bindings: clock: sophgo: Add CV1800 bindings
Date:   Tue,  5 Dec 2023 17:43:37 +0800
Message-ID: <IA1PR20MB4953339100B4873AA96E2033BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495382B725AFF6FC2C336BA6BB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [EV8xY5b1DBSjdF2bar5apeJmfea3KvpvBUf92UhVlfs=]
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20231205094341.943713-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: a63df314-c087-45e6-b03c-08dbf576adc2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5oP9f3TUdBqOJYGwDsdVNQR5ti5olhthuHtDm2aRAHqadMyBHrRTy77Xk77WC601boiLfvYcYy/zICdbVbQZ04Jz7LykLY4UZ2LbdarPWQtv6bnj0uj8bg5YlXlo8v/RGLQBErrtPIzXBoiON7t0+0py/SKEjnwSRWfJ+SNq6Khil1rNPRno2whSapuJ0q5W1ZdXnZlldjrNPtLTz4jA79v3ehpalTNezPafbPskW930bzf+wyFY8HmDB+2EQApKaZMHcquFSB9lS7wdCvbM5GYinTIhrRdYii5eeV54CRUr7u2yJrjRqtNqPiyPEo/93LwxTRe5zLCkTiUqUsrgECJXEY/hG4cBqSwaYf85+7ovVrWMmy41kBA6mG4ywdLlpg9+X8bGk8AeWeNqKKaGU0a0IuXixz68ZA+9HLDuxP3mDdChw1WURZ4B1Cox7F76OztDCeh46lNe2j5tbhgq0oFuNGgx7j+3NaNYfnD5w2nJMYxBaZUQaHJ0/5WGPQIcm1V65dnRAfU5RieRM0Ua6SE9M3UjQTuMV25xADaDlAnhA7TTNyaaLZRcTGHg2LIHufg7NfBRUDTqGuKm4BFMi9kdbGsHU0bSwzY507QwdEqr0L+NPkzFM2u9asmJCEE5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ir24MkI7e0VuB6HvGGr5SrLMxLJdGZIEanfq2Ei1CfSdqndhK+sQPCDIptn?=
 =?us-ascii?Q?fT4HkscGSMt/b9DBan8fGS3JqzyY2fV6WIya3STKth3SZtBXdWe9is+m/qKJ?=
 =?us-ascii?Q?Iwl0/Z5Rh9AQs0J5Jfge+v1CKoj6N5CkCohR/0h3PmjqtKLcIU+tlvNAoYSg?=
 =?us-ascii?Q?a98s2WkS9V44ja2G48cA8V2ZWthAvqTCL2x4W9apWNM3s0uDfT2R8nbPC+Ei?=
 =?us-ascii?Q?xxVt0WF3IAfLbA6vGOZfS3A7D8bG5uBMq9DtQ46j86sitrRt5ZUNwIzgWHji?=
 =?us-ascii?Q?tmBNK99ZpxbaKOpegK6q38yk/m6ZC74isL3QGvU37ukYVnFS3Nl0rrRb2qwG?=
 =?us-ascii?Q?dtgDkR9/6iINYnQNWPbDbke1mBMvUZkbVhGJzriQ1opYewBckru7b1pU3zpf?=
 =?us-ascii?Q?KOoBvDtB9p9jWuSA9zXSKXcuKWq6H/3KEupjvx438uyPI7hirGxnYwRvLF4L?=
 =?us-ascii?Q?eripM8k44KeA2v3SKR95XOJiwye94fOB7bkZubZNzpv7DexvDq3lLQWqpzcd?=
 =?us-ascii?Q?SQ5kJvhlYFgGDCssfov3gi2yPKliplVFCHbnDQgLT/x+6Wv04ErHim0xaDrw?=
 =?us-ascii?Q?fB3l3MFUTJ2V8Rp53nsNJ1X85gv4i0t7HzmTKzj9AvfUkTWycFhoeOAykp8m?=
 =?us-ascii?Q?lWvtHTktEmCtcz8LywYh55bi5vWh8q88CLQZvaMLKW9cDtnXyC870PGi/2So?=
 =?us-ascii?Q?LQxslu3ngxWaEjNKTQtuTLU3VJyoLNTohgieRuC2btKQnia1nRhWoLAyhpcb?=
 =?us-ascii?Q?V5MkLpnqHx3W7I/O9SYexiqZMvkPH4+WoVng1yMOuUOeqGcfFytlkU/ARoEA?=
 =?us-ascii?Q?NtC9n8rXOkKRo1cm3FzgwtzS8r+OQcPbFQJPl12dZKFoR7uwxM6DkNq45g4/?=
 =?us-ascii?Q?+oHXndUfSLJBefMWSXPnzzEE/uMufNxpIrZ9m1Pp/KqkimUg37iiLZXZQE4r?=
 =?us-ascii?Q?mJ31BISqhxNwMbouL7Mvj+8969afwW4WShle8gqfzFU+V+qms/GGM/TLliiV?=
 =?us-ascii?Q?Nc0n5kGGYcad9HeAWmti2SpIWIWoBA2mbS98CIgek0sAMEFpWDrOsop2MXo7?=
 =?us-ascii?Q?FXlwn3lP8BTGqQGfHhgkeFUY9chieGz0hCqPWPNztm8A1ak6g27Mjm6eDF4Y?=
 =?us-ascii?Q?CKngnS94MKgOlTCiGEykRvDX5AyKTdcl9a9lVIvMSzAl7bNeBVv3feaGJUtx?=
 =?us-ascii?Q?+gH+envohiHbX/UMtXP29ON57ggWjNVqh6vg6rVUVI8cxRcGopslZukbcSU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63df314-c087-45e6-b03c-08dbf576adc2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 09:43:47.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
index 000000000000..6a9897b34978
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,cv1800.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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

