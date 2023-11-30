Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6F7FF9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbjK3SrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjK3SrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:47:02 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2077.outbound.protection.outlook.com [40.92.47.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1C51712;
        Thu, 30 Nov 2023 10:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb7QG06PlEdMAVBDos4rJ5UXzJ0ctyfJSl2bOxdYANtPv1IOpuoavSJl2XtXYD7m5P8jSl5t0SHNB948QFq5ix5BgLPMdDoui+3wf0OwphTZpsev4VFh81RFTLjYZ1adZCO9VG2bnq557bIIZXVA8OCkYsXvj2c5QXq+2Td3re5vJjaQCBzo8FJ/9hYdmTAx46QRzTUw9DPji3RkUNxu2Vdhbf88r+SqAxpCQrwMyMkFJ33l8H11H/bDO5mG6zNkHCDy97eJ36nXdNZWF9pqGUhKb5Zrsz+k6TOPWew4h8O2QH6+IKl+LjeEZmZb2+XppZ3wTBxS2iTZsUoeA0saUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=R6AcLACjem01c8GayrNkA9GV0zxKWXos1kqrjnC7KewaXRLqW+xg+RuzQbt+rmEC8DC63MGp3t5fDmPnehqk4luzwpCv5UD7jVt/Qnc34UNkWMjmjFN8sFmfAVOPpvrHtY2qv1DsKIMX8DL5MuiXu1HoLNOriWKV0H0QZjqhjoXE+UQDGCgACOSHfodwkWe2iobG8J8qzedAa2DrkSYobbBPjYsr5L25E2YuRRQUo1npRzbQMaoidhg8Q/MbPNKoO5S/xziLxU3hQmb5CxnyMeQ9DSRrsUFzuJevZ3kG5jBjWTZL+C5JVkVqFudjNtk3rYKU4X2FkdDvjjc40bdfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=Mc9Sk6CxooYjJTBA6EkFX0IY5v6HBtAoGyMpMZrn8fb1nHFcxHkwRRq1rEFWIiIe1qXjvGDo3hmRKKSqEVJo0FPgvRltgNkzObL1iSqkQFYaKur8GJYRiTmiEqKDq5JgZ3o7b51S8xbnrN3cdazQGWw9eV9zGcr+Gf9vadTZ5Gf81mzQNbOAmaNF4fuLnmPGoq1Hyh3Tj2Ibng+aLlrneQPGtSuC/f/GLufw9y7yEpi7VXDpGhza0wbboDd66xxVgLMw2HbihSDMQi2ZtU5lgKeJHX8WG/rV5/Lr0ECjeuUeiO+0w0uu9HnPYHrt1h/0c/T6QOy+scBgzrZw8DUt5g==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5905.namprd03.prod.outlook.com (2603:10b6:303:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.8; Thu, 30 Nov
 2023 18:47:03 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 18:47:03 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v6 6/6] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date:   Thu, 30 Nov 2023 13:46:34 -0500
Message-ID: <PH7PR03MB70645A63EA0D578001954977A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130184634.22577-1-lnimi@hotmail.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/xfBx6/lF9F5BG0uspKjusiwXRPJbJVs]
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231130184634.22577-6-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a40415-6742-4d4b-5756-08dbf1d4be08
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ertx5e2YY3IeAl7ZVpkaxXlkO+TCn9L0YMVhRSQFOuZ04A5bf/0hWdS9zuiFxZ7r5OdMQofBYX6Zy/+1ylJKAlXaaYzYGGvB5Y7A+zqwHpXRNwcIXfBRnKTN3jFeeBmzax0Jj8zPDauHxVSjlTl9Cs0BwDCGK58J+cjt+lXQz3reiaKyv2X7HxYLjR0nQAH0AathgHD68jnTeH44ocQnEkNzDE8b9NHjJMoKvFIz8vgs/CQ1ehet3MFVO94SjLphL5oUXPiRD+Pk/wHLK6SgUp3iI++8ZVzaU2G5nbVxSsBZHrFs/xciP7sw33QXXyyhQJKt2x1EwZA4jYyX5vGgMHsQwibViITle4Cb3GTCC9OrxSA17yGjIuWgqpn1o6l7bCv0cHxvJeWkGT+AviFyUeLU4WATV7PVlnn+qqDcIxbU4y8FEy78WOGeA9qLCWqn8cLaAW6MK1Ik5tiDHhbSx/YuqbvXZibFha/dqUPBXDp0J/BskM3KBTS7Sz4gcktP5weNS3BxcF6rGRZtB2OqFx55K616VHDd5fCayaTwokl7XvSL+9y38eXqUVtzc10Z
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yAjErtFPdV9uDRqLayzsRn7A7aC/1CFTRmMpZat5m8QBsHMVrZBteZa5VC/G?=
 =?us-ascii?Q?dwRDrf+1ZiH/3Ru3fLWiGGaTpkCRU7a9dgt+J4nDpngTB1Zc6unJi0wdIgSK?=
 =?us-ascii?Q?MYvOJG3lOOxTF0etRKFRw71LoJRj5+5coUV/eZV4NUJBqlyaAfh9IfBQww0N?=
 =?us-ascii?Q?u0MHuYa3wOZLTzhwCWM/oOkDqok6vRBWHcwahpfOPXEmKCDaRVI0YYv8rz/J?=
 =?us-ascii?Q?c4dsk0jMP8BJ8dA9931SNE6ZPMF/697iUro+CJ2Hcepq7EqdgU1m7gOziRI/?=
 =?us-ascii?Q?+d7julXHjb1NpBm9AqHJhbl4YmH/ynZ3X1iomb3LXKUQDl/OLPWC7MOZWIfB?=
 =?us-ascii?Q?3rjCyuUh1epnvOYcn6LEv0ra5UwtWcOgpyLOm8Y5J2Rp5bIfovQDJzf8pTbD?=
 =?us-ascii?Q?y7v2WLVeeLB5CVXdfN8BTaoSphVpebU3IGbyycIZPGv/mY0+eUsnndNhckXQ?=
 =?us-ascii?Q?IkWdJ90ila2oWcgp8x8B7WgBwWnqijmBatwYvW92G2JTlyi5kRq2rXjqakTz?=
 =?us-ascii?Q?1HIdMEf4QPVJYESOLFq95h+guaLHsCiSDei4Kgvn+zH48u5s7vPgLJjbYOxD?=
 =?us-ascii?Q?muEm9ANjQrKF2WXleHPnx0BOA8cJB2e7+p4xIll237JQMNvjDSluIQclnZZ8?=
 =?us-ascii?Q?e5ayhaPgOIFsYi6dqomyG3qvf7FhYEZnF/oTtWkJ+97YXnFAxfVVrm5nj1mS?=
 =?us-ascii?Q?QgFWxz5bYIvy9Lsndj9fBaxVZ8OJttmnt/ZVsJyRv0k3+G7hgo6RirY6dqYs?=
 =?us-ascii?Q?LnK86h9WWRkZT9mHc+kRdm4vP1sejTFJRl+7oLO7qgcPk5U5PDN6UpcuLlc3?=
 =?us-ascii?Q?HtM8sa5ouu3Y1SWxprWNrce1y0UcWsFaRGKmZ/dBXIYHgcCbUuvy4VRbr9dX?=
 =?us-ascii?Q?E0450ODLcYKanWoOLXoGyCgDDTvTjHABHMdC9pAAniWZ7Ob0cENrPuUDCmiU?=
 =?us-ascii?Q?Lvm4pILp804cmkhD2Gf2nEz75tWoHL89db1jcaG6N4I9wInh4dtnuzSmB9pq?=
 =?us-ascii?Q?wgDM+nu+P5nAoKMKMhu0l3N6zNTm/ely3EqNbIeyhdJvZCQCjZuibL9scblI?=
 =?us-ascii?Q?gpgYzOmTXBAS0ZJx2ixsWbrb1w71abcgzBnDUXaLxceEVIRNZbCux/qNDKmE?=
 =?us-ascii?Q?ItZm6KP4TWvwwue+rUosZpY8GWta88k4WPbh77h45ATBHVCwij8y7LSqofXJ?=
 =?us-ascii?Q?wvkCkhKtvYKbIWJ0PrRhj6tc+37PNeSiTTpJEQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-685f7.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a40415-6742-4d4b-5756-08dbf1d4be08
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:47:03.2474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5905
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

