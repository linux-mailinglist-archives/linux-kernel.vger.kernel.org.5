Return-Path: <linux-kernel+bounces-130537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920889798D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C862D1F24403
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FDC15573F;
	Wed,  3 Apr 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CaeWQ/MK"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2071.outbound.protection.outlook.com [40.92.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9776154BE8;
	Wed,  3 Apr 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174750; cv=fail; b=YfdaC+F9slyv7UPczkFKB6EXlKf98GtuBdWCVwwuVgCCiYdU3jKvoKNG52Dr0NA8+bjYTbsk0K2qPjVMHaOabLNjsxh+jhd4SSUJbZjzM9ZF5Y4KkFEWbILEFRuhb2XCYcJkF4V+7aY0mZvvhVMvzXf+DW8HCO7EdrPlH3X238Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174750; c=relaxed/simple;
	bh=6PRegIcfTnDyUmIFda++r8kJul5aUnLcVNrKnArbcuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iGRzwIZvdBBDKpZ339IhUxpIcIer/2zlX2ajxAjAHpOcd7MlIue6/3et41DsOgRL3swlOMuS39TCwNdZAcUhV36ExeNrIJn6gwVMfZ47D4uHBH/re3sceimcP6DGG9wFv5zFyFZ7BJq4ICux16IMm59xU6K5D8URecwJYHY8DR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=CaeWQ/MK; arc=fail smtp.client-ip=40.92.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrTFHCHtLTRLWHRfVYiaXKnOUjekv756nTBbQs+lcCXW4F2OpKh/xPRNR0nf3CBUZiLuNL8PRmCU/P92w2ztb57S3s8Bc8rKVIotSxoIZ641OFFLFfNipWm9dPi6HIZbzNz3SYrRdnHCb2+VWlcLXRyI36R9HVwIKwfidCWGh2IDnOGjmKEf0+RuMRB41HzhD9ViPVf5HBLPh3Km92br+5R3446gyt3cs/snVXw9LKTLphsp+lA9zrIsXKyxTVOP9VK1xqF5ZtMZpccyiO9XOrpRHhufdgTBkQOywtLiziWMv141MARBkWJnrXjbWBnMN4hWdiNH/c7ES2B8HW5H1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggJQzvswQafjwqR4CsFKqtF+uFnYuxy8dPqpEwmXwic=;
 b=H9gw7UTebIYjG5gmny8mzh8MRRXQmBP3Iuo+QKQCleAOizXrRHl71zeUvX10/nGtuG6P0SFiE4hdJOnU1+lVnWNXR7Y8ThjO60xSob7HOBcHY806TVB05YTj7ypH1YERNyErCGTXRtrPG90f4wK5OTA+CW14ZY9Rcozr2BxbXk8bMTWO9sxRTTEREyV+HQPzhMhFZIiT21Y9tMGoClYUxy1B2WhY+vkSfX8W8fU5hdxCz/tRNK/12WBNTKw5FW9YawE8z/Z1Rue2XKwkZzPiaSKz7Ef7YkjqB1gJmaCxbEfTpjljH1PpqZi7dtkUkNQ5/XwOflwBiNGraSCMNooMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggJQzvswQafjwqR4CsFKqtF+uFnYuxy8dPqpEwmXwic=;
 b=CaeWQ/MKEQb+vYkHhv4Z4N+VW9jbBxcCQve3nJY36uDYAVP+67y94euYPE9xriE5P1hV8Wkl9XonrsqBXfcKbEql9CuGwz3ZEmwaatPqgApBh67yVf4EuykIdobzqeWbNYvyFjCznItcrTauEu4hxBRSQoJJNMYlZQWparZ6XFfq5fhUji16cOyU6V0+Qdgt5dmuxc/Gq67pg3lvomckwk7A2K5E8o3K0gfbSOTCZfly70kMA9vY0T4fzjs23uVMVlXngiJin4WNiST3e4sEC2KmySrDO/V/oBOLxnleTqChcYO2a5XN9ClLXZUjgAAS/7L+Lt2Hy7txeZZ1vF9x1A==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ2P220MB1216.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:589::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Wed, 3 Apr
 2024 20:05:46 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 20:05:40 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net 1/1] ptp: 82p33: move register definitions out of ptp folder
Date: Wed,  3 Apr 2024 16:05:16 -0400
Message-ID:
 <LV3P220MB12022BEFC410BCBCD52DD891A03D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [eHg9lsO8pHOroNFQtd8UttRD5K7BkD1W]
X-ClientProxiedBy: YQZPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::22) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240403200516.7665-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ2P220MB1216:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7dfb67-80c8-4b0a-b73c-08dc54196fbc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xo2M2sfB9RRfvB56wKhA6zwS9jF11fZEqP/RABlOINKaL8qFhQ1QnLvU9D33dlRZhEv8k+8gwdirTKlC9RYeHAka9Rmo4ljOD8+bAYahek+R4AdwYf8sBz1VHQDfLbewC3WqFyQkCamntASe8zRrTPJwLQPv3B4Ga7DeqRqX0wAft8gtYcE/rj49GGeWsgFU7Rs+LGj992IGqUdNkPaRfZZN94lNWQsaYjj66/brsB+EMKIkAVRADEtpXZxt0IYBxS1pwrIEH4kpf55XYmyefviASiE7ei7pmJ8txJMqaAJvXMX9vre+nyd/YnogINPzBIU2GUb1p+nxKPa7DKM9lRQ2svygEa2SGvBwwEYjbMyYltxBzAZnQxBjh1hp7z4AITUbMSCggqHK7qR8v3YTff70JwcH5X/uQkzNObUVV47oC0mcMEWZ/yjvt3cs++5478emr7GEs1PDh2jsxvKOXjQJjpbYkZfMo7RSSgIcHO0omuU8vItSycZeuHijMj5o1YyGV4addWxljP4PjRMfrjSNjkqEVSvvAUfht38Dk1OzHHUeYnDhlk2QepNRYYuy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KYPfzkcEZ5bhc8dDpaK34KXm3PEZmCzkCtwrb6g7o/s8Hz32I7g/La0btXof?=
 =?us-ascii?Q?AL/UE0axHeAkgE8iMRWG1dANp4RQuA+n3vQhpXkW+QlV3W50n+elnWLHUo01?=
 =?us-ascii?Q?lFK/y0CP3S3utPE7xYCIqbvXuKbxk2eMjinkinyOYtSAxbAxrgSyk9gBn/VJ?=
 =?us-ascii?Q?ZhJFxBXK3OITV+3nSoT+2kVFMVyqQKQqW+/hAPyF3d8uHFYJqI1JrDVPNiZQ?=
 =?us-ascii?Q?Ugf++AN5/kLyAq9y8ROckUBLyXTZHOBlGorVfeiTVXzaaQeidprycLLDdx+o?=
 =?us-ascii?Q?3BdEVqt1kDeJ+srRlSnWMLjnB4cHQMsF5uS02tYuC6YFStx226U8U1sahHFC?=
 =?us-ascii?Q?r4pJnBG8qUbep5bsvGD7TqlFiu9N0f5p98RtrbZSjwDmIK1wdeJDT5SSfvA8?=
 =?us-ascii?Q?bL31Ko+jW5AZJc4BEOFHVzH0/o7Z/8jMzEHWJZMYLh1I9zYn0+tNEaBYHSvN?=
 =?us-ascii?Q?P4oPCW5mRrePu46NHzAzhBGXy3Ekz4Frir+AvSY6QcdeF5JQs76vF9PT2ChL?=
 =?us-ascii?Q?MPxJ6heuM273nnCoit/spybS87EXDNF5TEpdNC4gGkk+6bEOdGpW6U9ZD1b8?=
 =?us-ascii?Q?UVXtw4UHmToehrPY4+YWyVNcdMZRRpv1spky1QdMXp2tKu1C+nin1PmHVgmT?=
 =?us-ascii?Q?80eeaisx8bIiJbC1jb+MZGvOL/2bkTe1u9mrYPejPLKfruw4scu/SSX24aLE?=
 =?us-ascii?Q?MHCzX0oKUIvdgqcj9jJSBCAmDA6DNPzD1nvigHsWPSeuf/jyWTOX9e3T0GcQ?=
 =?us-ascii?Q?6NQkgQ1KvbIothisNdXVh+l+mTtyd8geYnB1op9fntTBVjjI99nZBjxRZK3d?=
 =?us-ascii?Q?3mos40u7tJ1kcETKlJuJYe1JWWwMFKBZ6S8A19mBdYnkRR/hpy5Egurb+7cT?=
 =?us-ascii?Q?6sE+u5XCk/m4jP753xS4rdf7TevFaN2SPuDNDCf0l7FS2rCKyIulwSIFvGdK?=
 =?us-ascii?Q?vtIzx/o6C/koDZGwBUDBDMNMrokkZEzxsT+zx5UUZO1+DatsC0Sm6/ik4Tq0?=
 =?us-ascii?Q?GFgVEbDbZaGGgmR/h1r9wnOzxDh5XhX/tqbmxM0+1W7RMCMP86ccg4+JGnjy?=
 =?us-ascii?Q?3OQMqxCATe7+Q3qteIWyfjjALHux0dlACpTi1Q745HenXYwQm+0AODlLBB7C?=
 =?us-ascii?Q?zlxXmHUrsrd95mDIzKWaEvp5wJsKfM+8NKgghrhk2txGPHIssAeBpuhlzKJp?=
 =?us-ascii?Q?nbMSCQ4twkVvo3RUEmQoPxzKVDMnBx3SY5xeL+KksxlQpyVkDPsM9Jnd3e0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7dfb67-80c8-4b0a-b73c-08dc54196fbc
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 20:05:40.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P220MB1216

From: Min Li <min.li.xe@renesas.com>

Relocate register definitions so that other multi-functional
devices can access.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_idt82p33.h       | 27 -----------------------
 include/linux/mfd/idt82p33_reg.h | 38 +++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.h b/drivers/ptp/ptp_idt82p33.h
index 6a63c14b6966..b4f3ee40389f 100644
--- a/drivers/ptp/ptp_idt82p33.h
+++ b/drivers/ptp/ptp_idt82p33.h
@@ -23,25 +23,6 @@
 #define DDCO_THRESHOLD_NS	(5)
 #define IDT82P33_MAX_WRITE_COUNT	(512)
 
-#define PLLMASK_ADDR_HI	0xFF
-#define PLLMASK_ADDR_LO	0xA5
-
-#define PLL0_OUTMASK_ADDR_HI	0xFF
-#define PLL0_OUTMASK_ADDR_LO	0xB0
-
-#define PLL1_OUTMASK_ADDR_HI	0xFF
-#define PLL1_OUTMASK_ADDR_LO	0xB2
-
-#define PLL2_OUTMASK_ADDR_HI	0xFF
-#define PLL2_OUTMASK_ADDR_LO	0xB4
-
-#define PLL3_OUTMASK_ADDR_HI	0xFF
-#define PLL3_OUTMASK_ADDR_LO	0xB6
-
-#define DEFAULT_PLL_MASK	(0x01)
-#define DEFAULT_OUTPUT_MASK_PLL0	(0xc0)
-#define DEFAULT_OUTPUT_MASK_PLL1	DEFAULT_OUTPUT_MASK_PLL0
-
 /**
  * @brief Maximum absolute value for write phase offset in nanoseconds
  */
@@ -103,12 +84,4 @@ struct idt82p33 {
 	s64			tod_write_overhead_ns;
 };
 
-/* firmware interface */
-struct idt82p33_fwrc {
-	u8 hiaddr;
-	u8 loaddr;
-	u8 value;
-	u8 reserved;
-} __packed;
-
 #endif /* PTP_IDT82P33_H */
diff --git a/include/linux/mfd/idt82p33_reg.h b/include/linux/mfd/idt82p33_reg.h
index 1db532feeb91..15828e205fa8 100644
--- a/include/linux/mfd/idt82p33_reg.h
+++ b/include/linux/mfd/idt82p33_reg.h
@@ -22,6 +22,12 @@
 #define DPLL1_OPERATING_MODE_CNFG 0x120
 #define DPLL2_OPERATING_MODE_CNFG 0x1A0
 
+#define DPLL1_HOLDOVER_MODE_CNFG_LSB 0x12A
+#define DPLL1_HOLDOVER_MODE_CNFG_MSB 0x12B
+
+#define DPLL2_HOLDOVER_MODE_CNFG_LSB 0x1A9
+#define DPLL2_HOLDOVER_MODE_CNFG_MSB 0x1AA
+
 #define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
 #define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
 
@@ -43,7 +49,6 @@
 #define REG_SOFT_RESET 0X381
 
 #define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
-#define TOD_TRIGGER(wr_trig, rd_trig) ((wr_trig & 0xf) << 4 | (rd_trig & 0xf))
 
 /* Register bit definitions */
 #define SYNC_TOD BIT(1)
@@ -101,7 +106,7 @@ enum hw_tod_trig_sel {
 	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
 };
 
-/** @brief Enumerated type listing DPLL operational modes */
+/* Enumerated type listing DPLL operational modes */
 enum dpll_state {
 	DPLL_STATE_FREERUN = 1,
 	DPLL_STATE_HOLDOVER = 2,
@@ -109,7 +114,34 @@ enum dpll_state {
 	DPLL_STATE_PRELOCKED2 = 5,
 	DPLL_STATE_PRELOCKED = 6,
 	DPLL_STATE_LOSTPHASE = 7,
-	DPLL_STATE_MAX
+	DPLL_STATE_MAX = DPLL_STATE_LOSTPHASE,
 };
 
+/* firmware interface */
+struct idt82p33_fwrc {
+	u8 hiaddr;
+	u8 loaddr;
+	u8 value;
+	u8 reserved;
+} __packed;
+
+#define PLLMASK_ADDR_HI	0xFF
+#define PLLMASK_ADDR_LO	0xA5
+
+#define PLL0_OUTMASK_ADDR_HI	0xFF
+#define PLL0_OUTMASK_ADDR_LO	0xB0
+
+#define PLL1_OUTMASK_ADDR_HI	0xFF
+#define PLL1_OUTMASK_ADDR_LO	0xB2
+
+#define PLL2_OUTMASK_ADDR_HI	0xFF
+#define PLL2_OUTMASK_ADDR_LO	0xB4
+
+#define PLL3_OUTMASK_ADDR_HI	0xFF
+#define PLL3_OUTMASK_ADDR_LO	0xB6
+
+#define DEFAULT_PLL_MASK	(0x01)
+#define DEFAULT_OUTPUT_MASK_PLL0	(0xc0)
+#define DEFAULT_OUTPUT_MASK_PLL1	DEFAULT_OUTPUT_MASK_PLL0
+
 #endif
-- 
2.39.2


