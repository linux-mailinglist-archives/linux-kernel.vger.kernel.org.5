Return-Path: <linux-kernel+bounces-16950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A15824669
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6951C2405B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFF2C846;
	Thu,  4 Jan 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="F50mP9PA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2044.outbound.protection.outlook.com [40.92.23.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C12C68D;
	Thu,  4 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcTJfWh6CvmM6kXbtZafLcSv+9O45+t0C3stsVJ33kbFAUdXxKZSOlTroEn698wFKtHxA96yOlQWr2jbpckU7JUEDTYR384uRISlypCytjalD4H/BqD/f0/ogZBSPaedktqnCYxfQtbXX77YOI+BQCoVb1lt/uhgXuQYkG/+p/0b+qFUf1qELBmMHo3lN0a4cBpYWbUQYZW5tbmUJbdbdYlMFWQt2QOBlnSmTGDGVMHMQyt3L2cHf6/S9DZiElUCp5FCWma8TvkXUitZj2XVStBQRWXVvlNWKRvDCiWLG6GdItNiQdqKD16hzL6BhPhBEQr0tosSTA2fBU/2+PcamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=bIIPFf+fDUE7HDywkyp2dLjQLJciG633Zb5ZoCQx9Llc5crrEqUAMe11QB5+SfRYDNkz7IksH38YHpKncB0kqi0bi+MDCXj6BJ0uKPtLVUMcl8TJ3/b4rFGDIkW3ri9uM6AzwbqcDBngdhtNQDDPo7ckc7Dxg9+/EFkjvE9bQJ4WUFQCuc/DydzASaqzNjjW5cngYQyAoNwjRAD6cajgsU80RvEKMOIt5SGFaNhaEnm4WIgCRyj4e1N2X1lrxMA1jeOWzFIbVJuZ4UKpA/iWj71uejPL0uvT9WhyoDO9v5V1MPcez4FCKhJd4bUrjnBd7W3ZCl49WWLYixIV9EvpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=F50mP9PAbdU0GIq2Z6mLtYVhTfEbh3HVo4BJYw7mr8IW5Gd9y+6E18Z+SZ5hqvQxxOCZZYmO6pgzJwOyQSc3SLbtMbyVw0f+rpvGwbKEgaNUlgUPZlR8l6n4KwryMwsc3XxYiihJkUNuc8wW5CryKvkGfoK7XVgyeD5IgMRDCpHP/V/41dG7MmOKjUkABerlMXkVVYRp/MPyN1D/bdk5lYEjHraRauED+SHr15ZM/vX6WhFMD3drismiMaJwd4jSTopbT0uUIS3+NmFHuSd++iHsx15CL7P9OwJXyYUAs2hU6JSsYK755r9aQ5rjgqmy+l/g8wU179YGwDxj136Bkw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5906.namprd03.prod.outlook.com (2603:10b6:303:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:37:06 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:37:06 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date: Thu,  4 Jan 2024 11:36:41 -0500
Message-ID:
 <PH7PR03MB7064E39ABB68A108919987C1A0672@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104163641.15893-1-lnimi@hotmail.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [BHGjy3/BcrDLqEqpgCmhKblOpUOCDX2gQTNkiT+f7KY=]
X-ClientProxiedBy: YQZPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::7) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240104163641.15893-5-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: f71f1b6c-5363-4024-a043-08dc0d43635c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p2MqhAXg50U4y8z5//b5Ch8VrMhgBMbTf8A+2aR6laWQ7KHvTjnD+Jo2xtGMGs8LPxNi7zcR6YndtCbc59WMvGCgg512mjmo6h2fQCjNWIIBzMGGxqddMblzI0zBw1LLhhzEuib2CLnNm3r5maKrI1hzVBh69DVO956xsbh6AVjGKWn9BeoHRtRfKOpHNcUoH1A4YDo3JaPhkAQgEkjp3B3WZ7CSwp5PKLBIX0Hitas1Asa9LsOyCxwez7eH4e16Dwpkq0dR1c9ylvIbyI8RmpougvESyjPgqqk/xJxT5lZ0Uu/PXS1BKjLaEjGXdRTxwnoevuca7uTm0cl9HUA2CIUzzN8bNMeF+6fksxTmRb+0Rhhp3mr9QV/g9M2DxuFU3vNYi+9L2B4w7mDjP+iIL0jljWoCNGq68W8CJif8tecGHsatFMKsjjWs4FVVD7C65I0CwmWt6ON6eGR0B6KIsZMl9P3WAbCNRBKdF8eyhV3qTapDqrGFjBzv3AxDUMM/AudArUbVnAC6bj1SRPEvm66+1HljirygMrUKfJOU4d+J4pBXk+UEonulRlRyUAMQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaFGc8PMcHmhdA1iKHRTspfREsLWQl7mX2PRvyLbnTGmEVqTz4jrNBwJzH/Q?=
 =?us-ascii?Q?KgtmBGv/ZuUcn9bMeosqc59zBqFQ3b4yHyCY67pNIgVatEAqb+ze/WRb8Ugm?=
 =?us-ascii?Q?pT5hMhoYRH2M3XYyoxOs1X6UOovC3G0MBbUN4JhBe9BBg/zi+NsGO/XNnN2f?=
 =?us-ascii?Q?pBMN7BfrEflTYfgrtSJ4TPbbCOaQD0hk86siy3AixAbzKIHZiOzwlQnBzoJa?=
 =?us-ascii?Q?4VXYlsD4JfEPLgGUR0cWe5OP9VP3YfyQIf5/YEXI6blhuCvF376WvnrSS1ym?=
 =?us-ascii?Q?7JMB6lRc88vtaoG7zuM0QauNyw7juYS0TWh8RXfsN5Ai0fAjnyzQ0my9x1Pk?=
 =?us-ascii?Q?7mx1jt3ueDx5NjnAZs600RTEObW8uuC1kMIBGmXjddLew1fpMkrhHlLrreS8?=
 =?us-ascii?Q?IGVHFhzn2HqXYWuN/i76QDGgUOpDk2Rcjo1LrM3JoWCAVxVnERmnE25nBtH4?=
 =?us-ascii?Q?nMlATijepgANgGfAZnC1LFgUHGMPzVNMoTHsd2WBIW4PgWpJX/I/uJBsV3qj?=
 =?us-ascii?Q?ncaOjjP9/W8anCKMYA0472A4Wt9KqaT4hIcCt2PbDP5Zrk/bIdD3YslbmPxk?=
 =?us-ascii?Q?Et3eZIlBlinp37T4KdWttp4bljrbAeuZ5dp/z0QVN3XmW69kuPdEU0VgNmch?=
 =?us-ascii?Q?uflieqlroabMwIWc+gIXanvSyESJEdsbn598J9Mt2RzDBJk3WIc2cVDeZDPR?=
 =?us-ascii?Q?dIfSaOiG2+SkwxHaXESXMqodJbHO5oR21rrU882PxfRwgTTIQpcKACzDSCIa?=
 =?us-ascii?Q?E7H5zXdzTagUE5Gd0/NurXt6tzW/Mdv81FZfNIYRyOb5Y5ibixtonGill9H8?=
 =?us-ascii?Q?FY7z/eRhq/P/u3Sav2umrmCEfXuzVRZiPcFAnjCKQR+bPjntZQsRc73oLndr?=
 =?us-ascii?Q?8/O426j5jFHVJmrcDLlG2cRqEHsCNDY45zY8TVGheaT2ODMFXdbPOHTnhuK3?=
 =?us-ascii?Q?UnLUhXCjF5+7NDOt9WQ4YZnfXfWfHyuHfIgJmHSS70btgMYuqlefmLmXb0tp?=
 =?us-ascii?Q?te9I3NGcXnYo9GgG9+tBpE070ODpVuI/x7TWrD9ulBTanuGGeUjtpanexFGH?=
 =?us-ascii?Q?AEbF7Sy4PQCUXuyjvLT3Ud5kQJuV/MFGSI77+8DPEgn2pPlIsic20D655NgS?=
 =?us-ascii?Q?ZESSHFvjcKp19YjWqYs1rcb3MTfUBz8TSYwEa4/Z/esV2O29Pl6bIDvRRHQH?=
 =?us-ascii?Q?jkAvGIVsU1jxGbdkF9QWYnxPiU/aaxri+YJ7rA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f71f1b6c-5363-4024-a043-08dc0d43635c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:37:06.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5906

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


