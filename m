Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF85E8134B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573789AbjLNPZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573856AbjLNPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2074.outbound.protection.outlook.com [40.92.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F241A4;
        Thu, 14 Dec 2023 07:24:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHIBH9fhMpI6o6WB3b04prcWGr4Jhvjfw3e0n6DtQCKZLkDcNe8saaqXicN9QGj1TE6DspcSBNxEfRqMrAv31+LdXb0zbgeeJs9YPnFeSw/1GonkoR55hX+O/BQsqJWCYk5GcoiNfQG2TVmcaOage4WJkcIIX0OgYvSD8XmSadwQoZmPi2LJJZnyj2BSc3qfITUiPe0y41cQT3Sw4Z/e2f715Xr3ABcBLzS++5wQfse1OL9Tx/sKJoFTmadIt36T8wxiD6MZGssdMKop2LZxGQ0ZeXueGKWXElBUwOUJgoQjaVJBsEnFCjFvC8Fu5UCbIRJgstVLQZkemNoU+iiUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=ZkIABnOHNHKMLaFvU0oY9pTekcyo/nUlNa6JmLoyJhw4Ykiwy2XwXKuswvmlorvtDC/MWJvvCgNJ/UXHFYUDiBa8jks2IcIfvVc6QzWLIrpnbpOBxdij30eroX+M7WxMeaTEbatIy6JGssYB3B4L07B2et1XFE/qxHIBUONh8kuZlispSMBtycDBbmzqpEwUWa7QiFT3ysPlX6h1RwoqGbjfHE2OjCzKBm9lyYfZrGzKfhOZZNCM0tU4/l+3WUEIONU4ITpSk6JHeAqDjtzZP1b5Dwtvt/GKvaw8cjpab6rgpYtRBl+YFSd8GmMgNlv5qiN2V8GkMdrgLxgYIi02WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=dcJl2BC5uQkW1ErJwikbvOVeAwFOsomysuE2A6qY+e0Ond+r5tKfaEzIO1jx84SbPLManCkuar0366sqz54Q9gLhSFExAQ074qkbfBpYv7zXq/wk3Qp8JIkH+9gatguTedwihHds3USbIJUVlBAbf9aJ2KlePZ6KmXjwRoqBCR0KblJpDhjWjJTwdfUQnI5F6hbmRZAB1g03WBtSeOWXT1PhhKEv56vZMOuMOuPQ7Kjf1QOIJDgeEVo0YJ0z1gStirYI/TbR45hDj95ZKztnG+fFCUObzcGBFRSByXC+R5Zkn1t4r753UG8P2ZdWwSJizbQHpf/aTeFfi91uHdqPnw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB6252.namprd03.prod.outlook.com (2603:10b6:510:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:24:41 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:24:41 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date:   Thu, 14 Dec 2023 10:24:15 -0500
Message-ID: <PH7PR03MB70642FA60659FF2A519E9E48A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214152415.14785-1-lnimi@hotmail.com>
References: <20231214152415.14785-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fr9c9r7i8ZnQzcPuuAmCeUT2/59DKXe6YWXweL8VdGk=]
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214152415.14785-5-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d98b89-fe08-42f3-a15d-08dbfcb8ca5d
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrf5XTkHvzLuPL047Guub83ie5xQtlga+49LNCSAf9VFoHU+cQ6YFyN3zRkGfeuhEHDPhUl+OviL5mP8wIIF2cVaZBbQGF7x4RJ9AQW2L8rmt4P91jL2wwI23lTi1JttwmjCE6vTIkfCg/Gvp5b6eFGN30tUSANIBq7pDeJ0EzhzhIocOFqBQcb8C56dhbud6m3S9gqG6E8iy/+Hh2KHCxkyP7Uo8ynZtkRFuPwpzIfondfOk3+xod0oFxlGrdTOaKCvJViQlNT7b28VCW/J53cWxFBmAoMMT1R8EhniSozsLMD+1hK+YGCSPGcPdF5Tht6dHDQopoou96VBgYpYYiYb4yzwc0xtfMwLfVQupPo+R8m7M0KYJvnV9PWLbrVSi0MzjIekMpXZ4jOKzgIGwZd/dpvj0w8bGlYo1xVm52bIfqGW+IkYWJHEaIE0AWmwnyxV0uv35g4emeb/1PYCAMUaPpAwQfE/iyQlbHpDPsalBMd9A9KQPXAaYPVs/71gcph1MY8FkSO3FyyyIutQKbmLBrNuq/SfUACHwUCuiKMsnDhpWVztC7h97sSA5zs1J7AjsN/PDOuMcwpI2k7eJeSDVeLpziESkem9goANp1a/eahsKf7nlTvSGWn019WTJJ6H7TdNhMTEv2wF1ol6z/qapf/XotrgqEyyMNKZbzvortUlHuzzLE7wUwbinKHPfLKWhznTtRhTO9HG0+JbcQZh8Go9En/h4YlerNNnzIvjWJIK1bzXhwWYxiEc8zvOXw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uFstCzvZ32t5oiOuYB3BPauo+1yXJWCEcqLtXnQ2Jop7P1lH7BwCoe5l4+fk9J7nqGB0LsbIYt/Atku3tUJLwsMzJyQVi1fO5dpkvwnwtdXonmbLC2pbdtzRd2pkbjN8jQwsLa2VAWVkFjuPNBrkiBm6vRP7iZn22jE0pXGe0FlTr2fD631RHfsVI0M2irynsK8AZuBTkuiv9oRM9sSkLdKpSyx4c736nuG0HBNP/ZklNDDULg/kX/vspPllNCjSrJJi4hdPf5fENvFBc49gCYHSK7jW7GKDDcAcSL0OxXEyQlZ6/QDdzgh5oBc5e2HOb840gWYCacCCbDVbqus+gGwO7HX8Zbi4mAgGMzYcc5tJc5NK8molVz4gWfp2Pul88lPHVJpbD6VfQOAGTZJ4bDcvwoNPkVJJhmYZwun8ry+gZPKISWC10/uIWkv7iw79v55iSZDtyy7k9uAoFCoxXL8U05h+P/q+zTKKnCyZW4tOeB/NnGDivw+8kSeED7LdNoa8pHdCsHP/McRCDmAl4QVLHE/3ll879SFvyXvClW0FJx3jZ9NsCDZkWpxc1ix
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQ/wRofxUxicsAaZ/rBPuinAkvuTYFa5fNlHG1mPs0m47bVqI1L0Y7Z/Us/n?=
 =?us-ascii?Q?zOOpjxrz0MQj/eaEb763khEDeha+o/g4Xe0i++h4q5BNKAUW3BvypcvpKkZM?=
 =?us-ascii?Q?yKMv+q27q1+pJlMvWfBETPCIv5BkHUwt4sdtg0A5kj/8Q/TXLwLt5hehVVVU?=
 =?us-ascii?Q?Du9o1ObDHOLWdCQsrK63um2t5ciz3rfRdCN2YdTpGsHfqoC0J5dENukWpuZW?=
 =?us-ascii?Q?ncCPGDR9TDOIY7BbJiD3AkylUf1oUH4dLdOW5BvFUySgpkE/4a4vf/II9hI2?=
 =?us-ascii?Q?LNvGhlUAxavRrJfx9Z/48J23MMBibjODfRb/UdZn17sZd9LniTTnyTqoR1S1?=
 =?us-ascii?Q?loUqS/+Q4yDug++oun3ual+QyMhL4KPa4Byl8xxcu4c4ckJv2IsoMxVxV7Dv?=
 =?us-ascii?Q?5p++CxWMqT0eq/fgoSpEz0ScO2ot7Vv5wCw3fGau8e6mX0uZ6X9pDXiQTTAj?=
 =?us-ascii?Q?EW+KQ9K/rFFNJSsfZPVVTN6Ct1i8f2deavzx7HIWrdO8PnTI+c22DpjGx+S0?=
 =?us-ascii?Q?vHSHVOj3svzy7hCDaFRc2twtWf1+NEQ9FQhxAyCARxuiK7YpE4CCAVIQhlwD?=
 =?us-ascii?Q?S2RJeqzI8UJsY3V/LBACytzHBD4ew9i+viwxCBzOefu9db66uYeB05L/nUlY?=
 =?us-ascii?Q?xNAztpozLZ6vts5lwUTK7pD66q0Ac8rxFAHrjjTDzlKEudTtYhkSGzbG2HBy?=
 =?us-ascii?Q?fuYRN+vy8VhvveAOf/Lmk6IdyOo81IoYhbpkZ0zT5sSlL1ToWgF1haI/I/OQ?=
 =?us-ascii?Q?TfGFnKcaydPbU/wYVWZ9dUZpTRwh+MAQtrUBzTpU1pWepo0ITIEtsvdS9N5+?=
 =?us-ascii?Q?2SRtPAHlENEQXh0HdCIkqzH4EXAj5YkyMskkDTbG8alhPPciS1gVgTVdeiEb?=
 =?us-ascii?Q?Sh0cVp8Zc51CD1dtzRD/gCqpwLJNixLKVwmqb5xbYqEpBN0ccDVcWbvTvfGF?=
 =?us-ascii?Q?R1nFmpebWPSmKN9pvdqsVneO3lfD5A5B2T9lsVgV6LtOQUEbkmm9mrVA/YFS?=
 =?us-ascii?Q?CfOAoGjZFJt58nE4X97xt0SIBTInzKcsIWmSlG2xDEX7iqFT+qpnpDDcvoyp?=
 =?us-ascii?Q?9B5/sLnKKwjjVugGVbhYprQhmZ+Dqpqejpq7RkDutvDUmjRuUBA57Gvfj+Mx?=
 =?us-ascii?Q?Dd4rl2wD7NKz7CX8qyeGCDAV5lP81FZMKM6wdYfZ6PWTnkSNjtRYGbcBlR6/?=
 =?us-ascii?Q?8jVt7gGAtP04ZO1Aqz+7eOFzta/yaokXEFmeRw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d98b89-fe08-42f3-a15d-08dbfcb8ca5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:24:40.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

This change is needed by rsmu driver, which will be submitted separately
from mfd tree.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.h    |  33 ---------
 include/linux/mfd/idt8a340_reg.h | 121 +++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 41 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
index 31d90b1bf025..f041c7999ddc 100644
--- a/drivers/ptp/ptp_clockmatrix.h
+++ b/drivers/ptp/ptp_clockmatrix.h
@@ -21,32 +21,6 @@
 #define MAX_ABS_WRITE_PHASE_NANOSECONDS (107374182L)
 #define MAX_FFO_PPB (244000)
 
-#define TOD_MASK_ADDR		(0xFFA5)
-#define DEFAULT_TOD_MASK	(0x04)
-
-#define SET_U16_LSB(orig, val8) (orig = (0xff00 & (orig)) | (val8))
-#define SET_U16_MSB(orig, val8) (orig = (0x00ff & (orig)) | (val8 << 8))
-
-#define TOD0_PTP_PLL_ADDR		(0xFFA8)
-#define TOD1_PTP_PLL_ADDR		(0xFFA9)
-#define TOD2_PTP_PLL_ADDR		(0xFFAA)
-#define TOD3_PTP_PLL_ADDR		(0xFFAB)
-
-#define TOD0_OUT_ALIGN_MASK_ADDR	(0xFFB0)
-#define TOD1_OUT_ALIGN_MASK_ADDR	(0xFFB2)
-#define TOD2_OUT_ALIGN_MASK_ADDR	(0xFFB4)
-#define TOD3_OUT_ALIGN_MASK_ADDR	(0xFFB6)
-
-#define DEFAULT_OUTPUT_MASK_PLL0	(0x003)
-#define DEFAULT_OUTPUT_MASK_PLL1	(0x00c)
-#define DEFAULT_OUTPUT_MASK_PLL2	(0x030)
-#define DEFAULT_OUTPUT_MASK_PLL3	(0x0c0)
-
-#define DEFAULT_TOD0_PTP_PLL		(0)
-#define DEFAULT_TOD1_PTP_PLL		(1)
-#define DEFAULT_TOD2_PTP_PLL		(2)
-#define DEFAULT_TOD3_PTP_PLL		(3)
-
 #define PHASE_PULL_IN_THRESHOLD_NS_DEPRECATED	(150000)
 #define PHASE_PULL_IN_THRESHOLD_NS		(15000)
 #define TOD_WRITE_OVERHEAD_COUNT_MAX		(2)
@@ -121,11 +95,4 @@ struct idtcm {
 	ktime_t			start_time;
 };
 
-struct idtcm_fwrc {
-	u8 hiaddr;
-	u8 loaddr;
-	u8 value;
-	u8 reserved;
-} __packed;
-
 #endif /* PTP_IDTCLOCKMATRIX_H */
diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index 13b36f4858b3..5aeb0820f876 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -116,16 +116,41 @@
 #define OTP_SCSR_CONFIG_SELECT            0x0022
 
 #define STATUS                            0x2010c03c
-#define DPLL0_STATUS			  0x0018
-#define DPLL1_STATUS			  0x0019
-#define DPLL2_STATUS			  0x001a
-#define DPLL3_STATUS			  0x001b
-#define DPLL4_STATUS			  0x001c
-#define DPLL5_STATUS			  0x001d
-#define DPLL6_STATUS			  0x001e
-#define DPLL7_STATUS			  0x001f
+#define IN0_MON_STATUS                    0x0008
+#define IN1_MON_STATUS                    0x0009
+#define IN2_MON_STATUS                    0x000a
+#define IN3_MON_STATUS                    0x000b
+#define IN4_MON_STATUS                    0x000c
+#define IN5_MON_STATUS                    0x000d
+#define IN6_MON_STATUS                    0x000e
+#define IN7_MON_STATUS                    0x000f
+#define IN8_MON_STATUS                    0x0010
+#define IN9_MON_STATUS                    0x0011
+#define IN10_MON_STATUS                   0x0012
+#define IN11_MON_STATUS                   0x0013
+#define IN12_MON_STATUS                   0x0014
+#define IN13_MON_STATUS                   0x0015
+#define IN14_MON_STATUS                   0x0016
+#define IN15_MON_STATUS                   0x0017
+#define DPLL0_STATUS                      0x0018
+#define DPLL1_STATUS                      0x0019
+#define DPLL2_STATUS                      0x001a
+#define DPLL3_STATUS                      0x001b
+#define DPLL4_STATUS                      0x001c
+#define DPLL5_STATUS                      0x001d
+#define DPLL6_STATUS                      0x001e
+#define DPLL7_STATUS                      0x001f
 #define DPLL_SYS_STATUS                   0x0020
 #define DPLL_SYS_APLL_STATUS              0x0021
+#define DPLL0_REF_STATUS                  0x0022
+#define DPLL1_REF_STATUS                  0x0023
+#define DPLL2_REF_STATUS                  0x0024
+#define DPLL3_REF_STATUS                  0x0025
+#define DPLL4_REF_STATUS                  0x0026
+#define DPLL5_REF_STATUS                  0x0027
+#define DPLL6_REF_STATUS                  0x0028
+#define DPLL7_REF_STATUS                  0x0029
+#define DPLL_SYS_REF_STATUS               0x002a
 #define DPLL0_FILTER_STATUS               0x0044
 #define DPLL1_FILTER_STATUS               0x004c
 #define DPLL2_FILTER_STATUS               0x0054
@@ -192,6 +217,25 @@
 #define DPLL_CTRL_REG_0                   0x0002
 #define DPLL_CTRL_REG_1                   0x0003
 #define DPLL_CTRL_REG_2                   0x0004
+#define DPLL_REF_PRIORITY_0               0x000f
+#define DPLL_REF_PRIORITY_1               0x0010
+#define DPLL_REF_PRIORITY_2               0x0011
+#define DPLL_REF_PRIORITY_3               0x0012
+#define DPLL_REF_PRIORITY_4               0x0013
+#define DPLL_REF_PRIORITY_5               0x0014
+#define DPLL_REF_PRIORITY_6               0x0015
+#define DPLL_REF_PRIORITY_7               0x0016
+#define DPLL_REF_PRIORITY_8               0x0017
+#define DPLL_REF_PRIORITY_9               0x0018
+#define DPLL_REF_PRIORITY_10              0x0019
+#define DPLL_REF_PRIORITY_11              0x001a
+#define DPLL_REF_PRIORITY_12              0x001b
+#define DPLL_REF_PRIORITY_13              0x001c
+#define DPLL_REF_PRIORITY_14              0x001d
+#define DPLL_REF_PRIORITY_15              0x001e
+#define DPLL_REF_PRIORITY_16              0x001f
+#define DPLL_REF_PRIORITY_17              0x0020
+#define DPLL_REF_PRIORITY_18              0x0021
 #define DPLL_MAX_FREQ_OFFSET              0x0025
 #define DPLL_WF_TIMER                     0x002c
 #define DPLL_WP_TIMER                     0x002e
@@ -450,6 +494,10 @@
 #define OUTPUT_TDC_1                      0x2010cd08
 #define OUTPUT_TDC_2                      0x2010cd10
 #define OUTPUT_TDC_3                      0x2010cd18
+
+#define OUTPUT_TDC_CTRL_4                 0x0006
+#define OUTPUT_TDC_CTRL_4_V520            0x0007
+
 #define INPUT_TDC                         0x2010cd20
 
 #define SCRATCH                           0x2010cf50
@@ -668,6 +716,28 @@
 #define DPLL_STATE_MASK                   (0xf)
 #define DPLL_STATE_SHIFT                  (0x0)
 
+/* Bit definitions for the DPLL0_REF_STAT register */
+#define DPLL_REF_STATUS_MASK              (0x1f)
+
+/* Bit definitions for the DPLL register */
+#define DPLL_REF_PRIORITY_ENABLE_SHIFT       (0)
+#define DPLL_REF_PRIORITY_REF_SHIFT          (1)
+#define DPLL_REF_PRIORITY_GROUP_NUMBER_SHIFT (6)
+
+/* Bit definitions for the IN0_MON_STATUS register */
+#define IN_MON_STATUS_LOS_SHIFT       (0)
+#define IN_MON_STATUS_NO_ACT_SHIFT    (1)
+#define IN_MON_STATUS_FFO_LIMIT_SHIFT (2)
+
+#define DEFAULT_PRIORITY_GROUP (0)
+#define MAX_PRIORITY_GROUP     (3)
+
+#define MAX_REF_PRIORITIES (19)
+
+#define MAX_ELECTRICAL_REFERENCES (16)
+
+#define NO_REFERENCE (0x1f)
+
 /*
  * Return register address based on passed in firmware version
  */
@@ -778,4 +848,39 @@ enum scsr_tod_write_type_sel {
 	SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS = 2,
 	SCSR_TOD_WR_TYPE_SEL_MAX = SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS,
 };
+
+/* firmware interface */
+struct idtcm_fwrc {
+	u8 hiaddr;
+	u8 loaddr;
+	u8 value;
+	u8 reserved;
+} __packed;
+
+#define SET_U16_LSB(orig, val8) (orig = (0xff00 & (orig)) | (val8))
+#define SET_U16_MSB(orig, val8) (orig = (0x00ff & (orig)) | (val8 << 8))
+
+#define TOD_MASK_ADDR		(0xFFA5)
+#define DEFAULT_TOD_MASK	(0x04)
+
+#define TOD0_PTP_PLL_ADDR		(0xFFA8)
+#define TOD1_PTP_PLL_ADDR		(0xFFA9)
+#define TOD2_PTP_PLL_ADDR		(0xFFAA)
+#define TOD3_PTP_PLL_ADDR		(0xFFAB)
+
+#define TOD0_OUT_ALIGN_MASK_ADDR	(0xFFB0)
+#define TOD1_OUT_ALIGN_MASK_ADDR	(0xFFB2)
+#define TOD2_OUT_ALIGN_MASK_ADDR	(0xFFB4)
+#define TOD3_OUT_ALIGN_MASK_ADDR	(0xFFB6)
+
+#define DEFAULT_OUTPUT_MASK_PLL0	(0x003)
+#define DEFAULT_OUTPUT_MASK_PLL1	(0x00c)
+#define DEFAULT_OUTPUT_MASK_PLL2	(0x030)
+#define DEFAULT_OUTPUT_MASK_PLL3	(0x0c0)
+
+#define DEFAULT_TOD0_PTP_PLL		(0)
+#define DEFAULT_TOD1_PTP_PLL		(1)
+#define DEFAULT_TOD2_PTP_PLL		(2)
+#define DEFAULT_TOD3_PTP_PLL		(3)
+
 #endif
-- 
2.39.2

