Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1877B0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjHNFdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjHNFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:33:01 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D0E71;
        Sun, 13 Aug 2023 22:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYdT4OSZqveEeYe+K8BAnpdokZfquojqu7wKnJxJOQgs3/0yOdiYQGvOyvPTR6x1DaaiHMF9PACPJe3fYpAnVa345NlvyQo/srcOlaS49YFpN/AN/KMTg+y+3fsq4d/LJWScndQFmruPslLQSppaPypaHvfLCl3FrnaRreK9P9ZK7Z/UYpN+07ePjhS5l6tQNUxNkw3SqdMVxcZBl9iosPUuXWbmcmPaTRM4RI9409SpkLjG0afhPhx7gAD5ugzZMp9zynRMZOGHTMDuFkLUU6GAMnDA+rChPZJR7aPDxv/rxG/9eRoKrwsTGGwwVs1qsgUX9EKVBHpD/+c3BRRkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNzG2I/E1nYI56ioQTDifCRpeNpp7r0Mju2VNm5YoUU=;
 b=Jbzsb4bXlzLnb7r0Iqlf1aA7yjL9+Q00qfJCn089mhYwLiO6DnANOqHvW570JHZFDEe2C6W+Su4/A+nyC5SSBvwu+AlgppV90lOVFwwtZ+gIt/cOcPhVut5/Q4Cbx7WQc2G3iTAH51goIl3s9mGdTANIUhfjWZizLOkPZP9VX5V3txV/AySuAUpJicdqGfVwKHUggHVkPa17b+qRRV3okDGNmL1FswbOngvNxYG75cwj2BGWFTlWvCHxL14kCrW3IRUUzolHKDEv5UKDcH7taLdVH8tadrEmOCTtQ8D7yJMQ5NvJjpBQf1x4wfV7r5DLPo1pLMmj0TgAYvNQEaFABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNzG2I/E1nYI56ioQTDifCRpeNpp7r0Mju2VNm5YoUU=;
 b=d7e7To5skjNvLtMstEK/wUsMn1baF0jB6chseZpcI4stDTrFbTfGocYj6xaCKUAT/X2jCEuiKha59QO/ml0rhBUeByzUeJD6jrRIrR5lshOB65j0sZIuRz9FNj342P3a6r5y7Cwy8o31qwo4bisB5yPx0HgYLKMqOuTVfg2B/IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 05:32:57 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::15ed:8451:b0a2:ec64%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 05:32:56 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH] Revert "crypto: caam - optimize RNG sample size"
Date:   Mon, 14 Aug 2023 07:32:39 +0200
Message-Id: <20230814053239.608702-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AM0PR04MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: bf59b16b-0bbf-4c79-fc1e-08db9c87e9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oO3To5K+HNQTmB9MkYhBO6/UxJtCIb/uIKIk2jwz/ImDRNY5erFZAMDmMQUEtuVXpHtK1JN7oeHTHoIGBcwGT0ATfR7eVE/huVScjzcXWHY+oSzToMai70nBtVPp9D35bQiu3GiNF5oP6iqeTOf2tjErnKkTNxAt5ISAkMmd6qUv0AzG+egAIJkTU01kjp4ATTuqxVwhtmo3XF/U/yYbVz+3RWuoJFemBhvd87Bsk4X3RIi/XXSkmbPLA3bdIubumDcvU9v56IhVcP5YM0nhg+wh6dZfinnJvXBFZgMb9OtLaQlYVw1FY+6woYegE681NBJMeNmUpgpdf0l/1bdiiHZ8CkZz3hlJ8Q7omkXpyxIqI2grphz7GRCv6AtEwqkVTmfn3F+QT8U9sYJZhtWO/wo9ex2Yd6lTAWsP0vRieO1wBrZmE079agf0fYtpDkp4MhWDk5zN66GQBTrPOaevczckagA4hNoXhPBihrqY9evLgxKllRW7tFShU7PeHI6lX2kdX1pmDc6v7Oh3+nw13vovbI2IjjofGodnOubx78hcSxE4oksid0xmaSSHQU1GK4ZiwpaclG1GswrGXA/vviFwGyFZyg035yUAU9QKgnNnYgMxS8sj3JZb80TNYTz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(1800799006)(186006)(451199021)(83380400001)(41300700001)(8936002)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(9686003)(2616005)(26005)(1076003)(6506007)(6666004)(6486002)(52116002)(478600001)(38350700002)(38100700002)(36756003)(86362001)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJD2WGNplQAH5R4PzJNQKyof91fAAat1KwRn5CBP3NfKkdRvdcn9XVB5K6GO?=
 =?us-ascii?Q?Y9hLxn8Yv35V7OqY+8ROWUMNLy86Ujsg80BUBUTkj0hFPYvoBaZ73c/Bv0d3?=
 =?us-ascii?Q?Xu+tK1SSmrUW1xv0rAp84PIE1rpbj91lfiHyr2fQdTXWiLWKKl7XKMyVwGYJ?=
 =?us-ascii?Q?lgPjGfxOzK4fGiu65eqwU/+dFQJqHwOaZFNY4nBkrWXNxsk0hh/KTm+hPdW/?=
 =?us-ascii?Q?ERV5BMORWia0dI7xUftdZ8OEaY1x9GwgTrPJd0rOg8QGfvOOZIvE5m3MXHai?=
 =?us-ascii?Q?GKbPXnfIGwfI+QgM3LCGqCS4PQATVStUpGZVobgWHwQ5m8tQLFyJHcb9VvO+?=
 =?us-ascii?Q?WjPSr0UEdMR9Lp0182TO2gZprVzjwwECIu8WS/JRffb0tD1+5+RwFLTjAHQI?=
 =?us-ascii?Q?DMiQtLJahBt3tHRLfzYYKqg1Ji5x4yiv3iOVmCNRk1ol8Hm572km/0npVMIk?=
 =?us-ascii?Q?QWl1juIR6Q6LJu+bfO9NIFdy0qn5zfC32s2hfdUaqmh1F8njWDT211s5tGRe?=
 =?us-ascii?Q?YCzVsxeZP07VM5YUuWM95T7ZyjSeBI74vg2PwbQSKsUvy4W1NIUPgq/MU9Ib?=
 =?us-ascii?Q?Ea99OxKPMTvsjXsFY/EJsfde4OyHkfZHfJqB/Apbzpm4Dor+mgb8CLE1JcpN?=
 =?us-ascii?Q?KFIVDVOdr5WMcAdF5147msek3bAAtByIbAQRl8a/hsdpKkjVT18s4lQ/w/Xw?=
 =?us-ascii?Q?iJSw8/LDIdYGrXL8dBArksentrg7dp3UdWZQnsMfeY+wezlsi5aWDRcPcuG5?=
 =?us-ascii?Q?ITNQ0QVdsf8Qup6m4JQOf4EVFgfWAVR9kHjtzavxXrcnZAZ6YShQ+pWFXNZB?=
 =?us-ascii?Q?myZIUynmGOwLsGQV7s4D9UlTRcfNjbe5TbDnN7FXfbnhW0TA/8f3OS4nQIC/?=
 =?us-ascii?Q?XOrkKDgnJ59BvnGKJWNeiB5HU+yrsVcxOB6N3HBTT0J35eQfL8P9tsjX6Ifv?=
 =?us-ascii?Q?zSj+27fbMb2rhnizZmVwR6T5ysro36ubaCn2KKWcX4nPrJ5T3NRwgHG2rxtH?=
 =?us-ascii?Q?hoDJNuoljzPX8BrkqN8S0w2Kyggg3TGyPtBpXnoSXlOg97J0HOdJRLHPs2/X?=
 =?us-ascii?Q?70NdfBLV7A3miWa0ghW8d+erPCXzOxlTjUFcqiafZsK8kDa6JwfbHkPzOoiq?=
 =?us-ascii?Q?JzN6TBifIr8mWEkaZSrvUlc5kSGmQb5hQejegMs+UmirUHSN4usP0nEFWfTT?=
 =?us-ascii?Q?qh7P0kH9rQL6o3IdHwizWUo7QC/dSOe/r7JqOXY32P5IxV0Ax1+i7+CkfvGb?=
 =?us-ascii?Q?5UuFZWErKzbwEXL0fQ61wzUEnJqqcgGxehiArgreFzVRMb2btR+MZnE/ToBS?=
 =?us-ascii?Q?uFtLQCTver2Ner/7T46Q5bK90aBr7x33MPRXs1ttLDRGGutIuH8DkTwxBj5f?=
 =?us-ascii?Q?sZDj9c+aOSwhUig+6kWCBZpWDxuWtgFxj4U0NgTNnuXCTRi8jP1DRzEk0pUb?=
 =?us-ascii?Q?3vOWCorO9pz96LIiDkbs6TFbY+5Ah7Hz7l5GrHjC5/7xJ6z3E+gJeHoNufgF?=
 =?us-ascii?Q?gh5XTA2qCs1UY8cJLaJrIw3+llZYurvEWLh8al8oCp1PWyA5/7iVVUhwIozp?=
 =?us-ascii?Q?5K+jL/PJmw74/dwX360MbOqEQQjqITxXhziqeIi8FhL3hCMKCR0uQIONuR1n?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf59b16b-0bbf-4c79-fc1e-08db9c87e9e4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 05:32:56.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Nrvgh+kBUXcg2kwSFmqwIXJ/2rURtiH0+Mnd1abyEQedmPliBZV+GHm3G29jFazXpKTG8XaRlJ7FOqojQkUPZkbhrEHRbXHumq2CJAgl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

This reverts commit 1abc89661ad3cd18d8c6af5c2584bcc63df43bf2.

Reverting the commit because of RNG instantiation failure
observed on imx8mm board.

Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/ctrl.c | 52 +++++++++++++++-----------------------
 drivers/crypto/caam/regs.h | 14 ++--------
 2 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index ff9ddbbca377..ee6478eea933 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -358,7 +358,7 @@ static void kick_trng(struct device *dev, int ent_delay)
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
 	struct caam_ctrl __iomem *ctrl;
 	struct rng4tst __iomem *r4tst;
-	u32 val, rtsdctl;
+	u32 val;
 
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
 	r4tst = &ctrl->r4tst[0];
@@ -374,38 +374,26 @@ static void kick_trng(struct device *dev, int ent_delay)
 	 * Performance-wise, it does not make sense to
 	 * set the delay to a value that is lower
 	 * than the last one that worked (i.e. the state handles
-	 * were instantiated properly).
+	 * were instantiated properly. Thus, instead of wasting
+	 * time trying to set the values controlling the sample
+	 * frequency, the function simply returns.
 	 */
-	rtsdctl = rd_reg32(&r4tst->rtsdctl);
-	val = (rtsdctl & RTSDCTL_ENT_DLY_MASK) >> RTSDCTL_ENT_DLY_SHIFT;
-	if (ent_delay > val) {
-		val = ent_delay;
-		/* min. freq. count, equal to 1/4 of the entropy sample length */
-		wr_reg32(&r4tst->rtfrqmin, val >> 2);
-		/* max. freq. count, equal to 16 times the entropy sample length */
-		wr_reg32(&r4tst->rtfrqmax, val << 4);
-	}
-
-	wr_reg32(&r4tst->rtsdctl, (val << RTSDCTL_ENT_DLY_SHIFT) |
-		 RTSDCTL_SAMP_SIZE_VAL);
-
-	/*
-	 * To avoid reprogramming the self-test parameters over and over again,
-	 * use RTSDCTL[SAMP_SIZE] as an indicator.
-	 */
-	if ((rtsdctl & RTSDCTL_SAMP_SIZE_MASK) != RTSDCTL_SAMP_SIZE_VAL) {
-		wr_reg32(&r4tst->rtscmisc, (2 << 16) | 32);
-		wr_reg32(&r4tst->rtpkrrng, 570);
-		wr_reg32(&r4tst->rtpkrmax, 1600);
-		wr_reg32(&r4tst->rtscml, (122 << 16) | 317);
-		wr_reg32(&r4tst->rtscrl[0], (80 << 16) | 107);
-		wr_reg32(&r4tst->rtscrl[1], (57 << 16) | 62);
-		wr_reg32(&r4tst->rtscrl[2], (39 << 16) | 39);
-		wr_reg32(&r4tst->rtscrl[3], (27 << 16) | 26);
-		wr_reg32(&r4tst->rtscrl[4], (19 << 16) | 18);
-		wr_reg32(&r4tst->rtscrl[5], (18 << 16) | 17);
-	}
-
+	val = (rd_reg32(&r4tst->rtsdctl) & RTSDCTL_ENT_DLY_MASK)
+	      >> RTSDCTL_ENT_DLY_SHIFT;
+	if (ent_delay <= val)
+		goto start_rng;
+
+	val = rd_reg32(&r4tst->rtsdctl);
+	val = (val & ~RTSDCTL_ENT_DLY_MASK) |
+	      (ent_delay << RTSDCTL_ENT_DLY_SHIFT);
+	wr_reg32(&r4tst->rtsdctl, val);
+	/* min. freq. count, equal to 1/4 of the entropy sample length */
+	wr_reg32(&r4tst->rtfrqmin, ent_delay >> 2);
+	/* max. freq. count, equal to 16 times the entropy sample length */
+	wr_reg32(&r4tst->rtfrqmax, ent_delay << 4);
+	/* read the control register */
+	val = rd_reg32(&r4tst->rtmctl);
+start_rng:
 	/*
 	 * select raw sampling in both entropy shifter
 	 * and statistical checker; ; put RNG4 into run mode
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 189e74c21f0c..66928f8a0c4b 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -3,7 +3,7 @@
  * CAAM hardware register-level view
  *
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
- * Copyright 2018, 2023 NXP
+ * Copyright 2018 NXP
  */
 
 #ifndef REGS_H
@@ -523,8 +523,6 @@ struct rng4tst {
 #define RTSDCTL_ENT_DLY_MASK (0xffff << RTSDCTL_ENT_DLY_SHIFT)
 #define RTSDCTL_ENT_DLY_MIN 3200
 #define RTSDCTL_ENT_DLY_MAX 12800
-#define RTSDCTL_SAMP_SIZE_MASK 0xffff
-#define RTSDCTL_SAMP_SIZE_VAL 512
 	u32 rtsdctl;		/* seed control register */
 	union {
 		u32 rtsblim;	/* PRGM=1: sparse bit limit register */
@@ -536,15 +534,7 @@ struct rng4tst {
 		u32 rtfrqmax;	/* PRGM=1: freq. count max. limit register */
 		u32 rtfrqcnt;	/* PRGM=0: freq. count register */
 	};
-	union {
-		u32 rtscmc;	/* statistical check run monobit count */
-		u32 rtscml;	/* statistical check run monobit limit */
-	};
-	union {
-		u32 rtscrc[6];	/* statistical check run length count */
-		u32 rtscrl[6];	/* statistical check run length limit */
-	};
-	u32 rsvd1[33];
+	u32 rsvd1[40];
 #define RDSTA_SKVT 0x80000000
 #define RDSTA_SKVN 0x40000000
 #define RDSTA_PR0 BIT(4)
-- 
2.25.1

