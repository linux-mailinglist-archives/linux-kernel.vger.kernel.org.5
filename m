Return-Path: <linux-kernel+bounces-22245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50C829B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AC31F25E30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06656495EB;
	Wed, 10 Jan 2024 13:33:14 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2059.outbound.protection.partner.outlook.cn [139.219.146.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE9495DD;
	Wed, 10 Jan 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iY3XDaWRJdERTcp42u7fsNpqfG0ZTkW8o1mPHUbqBih3S3/ZfoMfmpqdpAO+rXKMrGuFis6VC6QiaVLOFL3Kcb9oTXPYdDU42NcKSFAgzbWjyLr4DeLngrx3yovzkj3/Si/N2cVwB7kQ/59aLLxvceG6jGYpCFOaGtq5xB2KcPG3X7N62SM6ILLea/NnDbjgcp2gtKnBBldeNGVaq0Xs+M0VrTukyBXADDs/jKjA7xFFkPcmaOmG2jzimNfY+n7Z1jJ6EWjpkTrs3lpBwudwbFg47GPftHmmpoMJAmQUh+uhX1wnKJxdx860koi6pCEWn60U2ybCuXRUZpI5WI9ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WyGV8ahj0x/vxVMNnEUAKwcahD0k1AJxANJSALOwRo=;
 b=ccLHqEKWeG3s0Lfd7kz+TDplISiJ6paDjGfdoc6CSS2umU57KZ5eddxaAQFvRnjrJdh1zJq6p9ZfiJogjFIVzPxxN7IfJJzqrkeXY7SNjqjRus+Z1Im2hPxKBHWD9gilQPKZUI4D2BDkiaemBdifrZYKczqkxm1BZLd04e2WtFd6cU4jzV/0zL0lUbPtzW+Dj/cfYbaZ2z2FJF22YvPtmOEr1WXkMGAswEEWsjyz3RotaByo3fGlUdM4QO4Ge2DLLvS7jAdoPmTZ81TfmTElbSEbTMmAflJqKQGo7Ii+ZFhTWhzCQFg5GmF4dRUDE+8lAjjYgRR+0desZM3XUsZCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0865.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:01 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:01 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC v3 05/16] dt-bindings: clock: Add StarFive JH8100 System clock and reset generator
Date: Wed, 10 Jan 2024 21:31:17 +0800
Message-Id: <20240110133128.286657-6-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f887381-ff0c-41c8-48c7-08dc11e0869b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kW3Wp0rXG7mcRD4aNovlwIlgVDvEF82yuwHgvIVS5xYEoA9nHd+nQ5zLfcW0kS1gA+NjzrzicuCA/iYBBfGeRQcDBrg62h0YRxwmf0bl1YLBQpUMccUtM/2E6nVTjnwqIxLxf+BGMJZZtQyj7dE1Qy5Vv8IZLWx2kXt8mH62kK/bYqfJAmpdus2IqYPw6FfzazFutN3yLAREOa+rQVKo7fVnszRKggc2fMDr8VT1NbnTPwinTZz4oz/gQCfEgLMGTvQVR3JMU4VJQpSLV2vkTI9WLWEvYihChDvi9DftQQE+H+B2E+noplhSDs7sJvVO/hTULfFsFu7zfTLpvfX8vQGIz61UG0i2MIu1uiz7ypCWt8XDPGM8IDuGVXlGZL9tDczQ51ZoqI6vpq8kn5pTdAy7/tbG1TuMA31yPzNXT9QmxxTKu36qtJu9RuXKCFXiyXgT4UbcS1/1LmOMW9xtebkuiO36UvFKZe7q3p0X9tKUKkNlfO20Rpf21gLU/FxoB1AW2RsbZS9aw6kGA+YxVbZt9bIML/S0NPR9yELzJfljkb5noQNjERR3BJKSnHQ4kk1qnbfyZS5uDCEGGYT6/8fPHjBsy76wzzvpsu76n4m8e9/34zUkZvbuofxOM6MJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39830400003)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(41320700001)(6666004)(966005)(508600001)(55236004)(52116002)(2616005)(1076003)(26005)(38100700002)(40160700002)(38350700005)(921011)(86362001)(40180700001)(36756003)(41300700001)(4326008)(7416002)(83380400001)(5660300002)(2906002)(8936002)(8676002)(66946007)(66556008)(66476007)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ez/ZZ1SWLXdAy8AVhbvGTGj53IMyG0+QC+zGajRn/bdS/THMv0SRKOqwmTS8?=
 =?us-ascii?Q?f3FoqaQoHbLOf5pbP6RZLt8+7DpG8A7k5lMPGQChyS0+ymB9DoFHfSfsNzKC?=
 =?us-ascii?Q?pGA8SDI+9B7szL4vLzi2+Be3t3zKE0gLKsarC/5ER/oo0UKg3zPtCP+WfkV7?=
 =?us-ascii?Q?xzpCFTmpDv10SJagjR8Pm7AexPJ/llOAlLPHMqfjXUpfKJZUg7nvuby4fKKt?=
 =?us-ascii?Q?8NpyvHieHzHjK7C0b4nIQrrjX9JDzJ1A0L/it7jQty8d2TOtejRtL7TK3t4U?=
 =?us-ascii?Q?l2CFIHsWV5mS5wfT6ReTDE05dz4Aaixj+XiUvg/IMOQ8eEygdXHSFXDDszb/?=
 =?us-ascii?Q?+4gdUNxXkrZNa7PfN9PBJl3+w8CNd1feqGAHGoyXZc+zuJA2OxTMR9kpyyXe?=
 =?us-ascii?Q?sUuQnkQE3JFeIzThMCWrpo5PPeMG9wvURB3u0ImFOdTrpRdMEt3Z6doDTENV?=
 =?us-ascii?Q?4Usd07p37nlE1DI9ktOecazjBSP8CygwagRHG7Hfvm1Uen+tiH4eKLULHIHQ?=
 =?us-ascii?Q?PowfN5cQVrN64FY0iCK+0NscNJTjKQVXjWuFE3KTRekX+EnaehC4HVR+aDzv?=
 =?us-ascii?Q?aMPlDiShoVNVJVIlbloQYL2HEUXvkcYL9zJAk3vC4air3USEejN3MZmbHYIb?=
 =?us-ascii?Q?O17ZXw4WMAom4pwo9g8f5zfaa/mHo23kooNb7yUDJ1wuNYXBd0XkbxTRtRyP?=
 =?us-ascii?Q?MKxoO7u/K28qBK0NFJNtnXStPdTNQk+89GjAOQ7nJaCsG1JbAvNFSU2Fvm2E?=
 =?us-ascii?Q?iNGvoWHIps3ODHJ4y/LSo8skUwk2jF9Cei8df9QOOJql+b+UvfdmMFRqUNAi?=
 =?us-ascii?Q?Ba4zmlWzdgUDVpMczXpR73LGPxuEpOB2V/AUF/XBLTu8S0iUUMT7Fgootmqo?=
 =?us-ascii?Q?N6lHr5f8JG2NBsAto8hQRYIiQJvwgXVDqsxEoeobSck8z8BNp5/Zqq4102f2?=
 =?us-ascii?Q?PYOwuxiecOBEgkCwapU9C1um2aWrtQ5xcjcPoslK1waz3H2CwL6SqhvV54yP?=
 =?us-ascii?Q?I3fyv2il9244GlRWw9jk5Fl68b+G+9WPC9q8aXA6E3PyPWkThKSOY+b7M02I?=
 =?us-ascii?Q?+KrgOyrvlkqmjvzKqTUVPWxElDF1RzHZNLqH0GFg0Mv7je8gxrV6gJGEkAgP?=
 =?us-ascii?Q?oWReVohmc8F79xTTw5a22LnjwxOVghZOGWi5vV8IlPmCmteDNbEpL+lHKKMc?=
 =?us-ascii?Q?DPPNoQ9a8mQhbhnheSWZzGV7/Z1W3k4qW7T1TdNhJNd5jpXTQm7hpqPGTS7e?=
 =?us-ascii?Q?3vCbaeUI6RyHyfB+gbGtXIwdnY/8otCnnhu1btN2/IwWZPCUzS4LMjN24ueV?=
 =?us-ascii?Q?lSL7pMCJCW9LeI5y3V15DQb5PPVLXiERWuTD/oRiPQVS+OenJGm8bTHUfJdE?=
 =?us-ascii?Q?girqUZI5meX7iZC3yLRAzhq+T+JBAzvLyH0qQ+g9ObzbEnblkBJgGpCS6Nxi?=
 =?us-ascii?Q?bDwfwgYIIPlAWKNb0CIAOXi/gKdKshBK+r9bchHOObxuZuwf4ytGM0ctXah8?=
 =?us-ascii?Q?tcQKKEN4gRe0sawjpTMT5h4Te0CclN7dBOMT3s0JQ/Gk5rfJ8SqGTJpmcp/f?=
 =?us-ascii?Q?3gHJbZL0+AQgqrTpXknZrFNXDHfhAUfssQ3JJd3Yvnt1m8VcSeOc+lcLdrwK?=
 =?us-ascii?Q?VW+KhQj2zayT6lLBeCJys/4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f887381-ff0c-41c8-48c7-08dc11e0869b
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:01.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4d3bYqtAwicgm5HHd8DnFLPOKduY18WpFUvQgVw5xz0zSoVbKa2CCP95zJ66uYgz4rvkbELAeS98ksOB+wTBBKGNmpuTQhvt2QBZXUww0Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0865

Add bindings for the System clocks and reset generator (SYSCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../clock/starfive,jh8100-syscrg.yaml         |  77 +++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 122 ++++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   |  21 +++
 3 files changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
 create mode 100644 include/dt-bindings/clock/starfive,jh8100-crg.h
 create mode 100644 include/dt-bindings/reset/starfive,jh8100-crg.h

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
new file mode 100644
index 000000000000..853b13ce5562
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-syscrg.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-syscrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 System Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-syscrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: External MCLK clock
+      - description: PLL0
+      - description: PLL1
+      - description: PLL2
+      - description: PLL3
+      - description: PLL4
+      - description: PLL6
+      - description: PLL7
+
+  clock-names:
+    items:
+      - const: osc
+      - const: mclk-ext
+      - const: pll0
+      - const: pll1
+      - const: pll2
+      - const: pll3
+      - const: pll4
+      - const: pll6
+      - const: pll7
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@126d0000 {
+        compatible = "starfive,jh8100-syscrg";
+        reg = <0x126d0000 0x10000>;
+        clocks = <&osc>, <&mclk_ext>, <&pll0>, <&pll1>,
+                 <&pll2>, <&pll3>, <&pll4>, <&pll6>, <&pll7>;
+        clock-names = "osc", "mclk-ext", "pll0", "pll1",
+                      "pll2", "pll3", "pll4",
+                      "pll6", "pll7";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..611613961e17
--- /dev/null
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Sia Jee Heng <jeeheng.sia@starfivetech.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__
+
+/* SYSCRG clocks */
+#define JH8100_SYSCLK_VDEC_ROOT_PREOSC					0
+#define JH8100_SYSCLK_VDEC_ROOT						1
+#define JH8100_SYSCLK_VENC_ROOT_PREOSC					2
+#define JH8100_SYSCLK_VENC_ROOT						3
+#define JH8100_SYSCLK_GPU_ROOT						4
+#define JH8100_SYSCLK_GPU_CORE						5
+#define JH8100_SYSCLK_VOUT_ROOT0_PREOSC					6
+#define JH8100_SYSCLK_VOUT_ROOT0					7
+#define JH8100_SYSCLK_VOUT_ROOT1_PREOSC					8
+#define JH8100_SYSCLK_VOUT_ROOT1					9
+#define JH8100_SYSCLK_VOUT_SCAN_ATS					10
+#define JH8100_SYSCLK_PERH_ROOT_PREOSC					11
+#define JH8100_SYSCLK_PERH_ROOT						12
+#define JH8100_SYSCLK_AXI_200_PREOSC					13
+#define JH8100_SYSCLK_AXI_200						14
+#define JH8100_SYSCLK_AXI_200_GMAC					15
+#define JH8100_SYSCLK_AXI_500_PREOSC					16
+#define JH8100_SYSCLK_AXI_500						17
+#define JH8100_SYSCLK_AXI_500_PCIEX1A					18
+#define JH8100_SYSCLK_AXI_500_PCIEX1B					19
+#define JH8100_SYSCLK_AXI_500_PCIEX2					20
+#define JH8100_SYSCLK_AXI_500_PCIEX8					21
+#define JH8100_SYSCLK_AXI_400_PREOSC					22
+#define JH8100_SYSCLK_AXI_400						23
+#define JH8100_SYSCLK_AXI_400_APBOOTRAM					24
+#define JH8100_SYSCLK_AXI_125_PREOSC					25
+#define JH8100_SYSCLK_AXI_125						26
+#define JH8100_SYSCLK_AHB0_PREOSC					27
+#define JH8100_SYSCLK_AHB0						28
+#define JH8100_SYSCLK_APB_BUS_FUNC					29
+#define JH8100_SYSCLK_APB_BUS						30
+#define JH8100_SYSCLK_APB_BUS_PER0					31
+#define JH8100_SYSCLK_APB_BUS_PER1					32
+#define JH8100_SYSCLK_APB_BUS_PER2					33
+#define JH8100_SYSCLK_APB_BUS_PER3					34
+#define JH8100_SYSCLK_APB_BUS_PER4					35
+#define JH8100_SYSCLK_APB_BUS_PER5					36
+#define JH8100_SYSCLK_APB_BUS_PER6					37
+#define JH8100_SYSCLK_APB_BUS_PER7					38
+#define JH8100_SYSCLK_APB_BUS_PER8					39
+#define JH8100_SYSCLK_APB_BUS_PER9					40
+#define JH8100_SYSCLK_APB_BUS_PER10					41
+#define JH8100_SYSCLK_SPI_CORE_100					42
+#define JH8100_SYSCLK_PLL1_DIV2						43
+#define JH8100_SYSCLK_PLL2_DIV2						44
+#define JH8100_SYSCLK_PLL3_DIV2						45
+#define JH8100_SYSCLK_PLL4_DIV2						46
+#define JH8100_SYSCLK_PLL6_DIV2						47
+#define JH8100_SYSCLK_PLL7_DIV2						48
+#define JH8100_SYSCLK_AUDIO_ROOT					49
+#define JH8100_SYSCLK_MCLK_INNER					50
+#define JH8100_SYSCLK_MCLK						51
+#define JH8100_SYSCLK_MCLK_OUT						52
+#define JH8100_SYSCLK_ISP_2X_PREOSC					53
+#define JH8100_SYSCLK_ISP_2X						54
+#define JH8100_SYSCLK_ISP_AXI						55
+#define JH8100_SYSCLK_GCLK1						56
+#define JH8100_SYSCLK_GCLK2						57
+#define JH8100_SYSCLK_GCLK3						58
+#define JH8100_SYSCLK_GCLK4						59
+#define JH8100_SYSCLK_GCLK6						60
+#define JH8100_SYSCLK_GCLK7						61
+#define JH8100_SYSCLK_FLEXNOC0_PREOSC					62
+#define JH8100_SYSCLK_FLEXNOC0						63
+#define JH8100_SYSCLK_FLEXNOC1_PREOSC					64
+#define JH8100_SYSCLK_FLEXNOC1						65
+#define JH8100_SYSCLK_FLEXNOC2_PREOSC					66
+#define JH8100_SYSCLK_FLEXNOC2						67
+#define JH8100_SYSCLK_VDEC_CORE						68
+#define JH8100_SYSCLK_GPU_CORE_ICG					69
+#define JH8100_SYSCLK_IMG_GPU_CLK_APB					70
+#define JH8100_SYSCLK_IMG_GPU_RTC_TOGGLE				71
+#define JH8100_SYSCLK_IMG_GPU_TIMER_USC					72
+#define JH8100_SYSCLK_HIFI4_CORE_PREOSC					73
+#define JH8100_SYSCLK_HIFI4_CORE					74
+#define JH8100_SYSCLK_E_200_PREOSC					75
+#define JH8100_SYSCLK_E_200						76
+#define JH8100_SYSCLK_HD_AUDIO_48M					77
+#define JH8100_SYSCLK_VOUT_DC_CORE					78
+#define JH8100_SYSCLK_VOUT_AXI						79
+#define JH8100_SYSCLK_USB_WRAP_625					80
+#define JH8100_SYSCLK_USB_WRAP_480					81
+#define JH8100_SYSCLK_USB_WRAP_240					82
+#define JH8100_SYSCLK_USB_WRAP_60					83
+#define JH8100_SYSCLK_USB_WRAP_156P25					84
+#define JH8100_SYSCLK_USB_WRAP_312P5					85
+#define JH8100_SYSCLK_USB_125M						86
+#define JH8100_SYSCLK_FLEXNOC_APBOOTRAM					87
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1AMST				88
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1ASLV				89
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1BMST				90
+#define JH8100_SYSCLK_FLEXNOC_PCIEX1BSLV				91
+#define JH8100_SYSCLK_FLEXNOC_PCIEX2MST					92
+#define JH8100_SYSCLK_FLEXNOC_PCIEX2SLV					93
+#define JH8100_SYSCLK_FLEXNOC_PCIEX8MST					94
+#define JH8100_SYSCLK_FLEXNOC_PCIEX8SLV					95
+#define JH8100_SYSCLK_FLEXNOC_GMACSYSSLV				96
+#define JH8100_SYSCLK_GMAC_SRC						97
+#define JH8100_SYSCLK_GMAC1_GTXCLK_TOP					98
+#define JH8100_SYSCLK_GMAC1_PTP						99
+#define JH8100_SYSCLK_HD_AUDIO_SYSTEM_CLOCK				100
+#define JH8100_SYSCLK_HD_AUDIO_CLOCK_48					101
+#define JH8100_SYSCLK_HD_AUDIO_BCLK_POST_OCC_IN				102
+#define JH8100_SYSCLK_NNE_VIP_ACLK					103
+#define JH8100_SYSCLK_NNE_VIP_HCLK					104
+#define JH8100_SYSCLK_NNE_VIP_CLKCORE					105
+#define JH8100_SYSCLK_GPU_ICG_EN					106
+#define JH8100_SYSCLK_HD_AUDIO_ICG_EN					107
+#define JH8100_SYSCLK_NNE_ICG_EN					108
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
new file mode 100644
index 000000000000..c4e2501491ab
--- /dev/null
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ *  Copyright (c) 2022-2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+#define __DT_BINDINGS_RESET_STARFIVE_JH8100_H__
+
+/*
+ * SYSCRG resets: assert0
+ */
+#define JH8100_SYSRST_SYS_SYSCON				0
+#define JH8100_SYSRST_CLK_MOD					1
+#define JH8100_SYSRST_GPU					2
+#define JH8100_SYSRST_GPU_SPU					3
+#define JH8100_SYSRST_GPU_TVSENSOR				4
+#define JH8100_SYSRST_PPU_OP_NORET_GPU_RESET			5
+#define JH8100_SYSRST_NNE					6
+#define JH8100_SYSRST_HD_AUDIO					7
+
+#endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1


