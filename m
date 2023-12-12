Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C419180E7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjLLJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLLJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:32:15 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD71D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:32:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNfvKWx0GtIVq4XT1M1hqxAxQKTwaYKv3DBKVBFDnu4V+t+ph46gE9aZR7NlLLM/xIxvM3lh/R+yffLbJNHlUjl0LEK7c4vxKOBsGpsRh6QDgRNFCoCr/L6ec4pTfZseAcyhI+cXXnyJ6cGOyCnblZfgVnkLCQHysQ41LuZTW9/6UvVeRKFSzMiLySzAD8JYHF8Bsa6wm2/WoYm0SMsdeLHUAiVPAQjjnoyofXil5o22mRA900u6QeI9aA+K5MfGwQgUDMrodcIoZVd3UD0BUFiRei4NJjDvmR/PTjpZUoz5dt8vdVH1jyf1E5AfEjQ4crfq3d5v3SBxzc3vmqB+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KOojxNeJ25ZvfoFLWAvOLonW2ITgD94ove2p4FiUMU=;
 b=BmR1JvsNBRmx0w3SQCokFoUmQ3JTtjg2GnQLe3TIlcIEYFZAN2ypZS5NSh/FJ0os/2T3vzuRUmWUcPTiNi8Wv4mbshDNK+cfx0Ufr3Uzj4xo+tIKnSniDkfF2j58wPL4xIGO2hk/JBTP0lnXuK/hYbFmA0wy+PlQzudBgL4n33YLRLwAxZeMf4JkAZFEYLnuu5agFf4rY+r4LlfXGpCXXNjLBmZnFZlubQChM4/LmGNmfwmp8A4qrOQ/qHJaZnNY+KISiKn1ml7OxeTcDIyH9lAy3trhMz4UMTQsCcMrutmriCla7YtHLcoeLIvEm7GOJLxarT/KMTX9RUKvhUYGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KOojxNeJ25ZvfoFLWAvOLonW2ITgD94ove2p4FiUMU=;
 b=k/aUXHQheiCMqJ4BPrl9e59FnfvIfid2p/HH25DQGm1au8uAzzehc5z47W6JrWKrOtPLcvC70xofc6d/3BewpTuBf0MdbxpRjKZNlKvQH3jc4qjLSo4WhkVAEOLMQTFJtE/wq0J9rdr6EvdE6bA/6KKuX2WW6n9I+gjeIJ1cSbmPFEbvjSCNQNZu9R2rk4wL+HejWoTcPX1r3i7ldH46PTML1zhhDgNn+ktHkRDlgkGuo58J63mXLMO4sR1XewZfh3kgnX1DMlkzkEHS9q0AbFmcjM8Y5RSMzMUcW7Pq7W0yJStZzg05wCbVNPgvkfncLwEcQlQmeU2JhSfVBYczng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com (2603:1096:300:62::16)
 by PSAPR06MB4007.apcprd06.prod.outlook.com (2603:1096:301:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 09:32:11 +0000
Received: from PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::4cfd:404c:53bd:16ad]) by PS2PR06MB3432.apcprd06.prod.outlook.com
 ([fe80::4cfd:404c:53bd:16ad%3]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 09:32:10 +0000
From:   "xiaowu.ding" <xiaowu.ding@jaguarmicro.com>
To:     viresh.kumar@linaro.org, Tushar.Khandelwal@arm.com,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org
Cc:     xiaowu.ding@jaguarmicro.com
Subject: [PATCH] mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt
Date:   Tue, 12 Dec 2023 17:31:47 +0800
Message-Id: <20231212093147.773-1-xiaowu.ding@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0214.jpnprd01.prod.outlook.com
 (2603:1096:404:29::34) To PS2PR06MB3432.apcprd06.prod.outlook.com
 (2603:1096:300:62::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3432:EE_|PSAPR06MB4007:EE_
X-MS-Office365-Filtering-Correlation-Id: b95f12b1-b664-4c09-b459-08dbfaf53616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IoW8X8OSxjCdvnANvF2v4ftkOTgm9YH9USwLhAYZQPWvPz/S0ZfWSrkT3qykkibw4pfILWssVVOrupfYUf84ajVIlnsH9aA/12Aqk0lEUZ1hRloipofyUKYWx3I2XJ/1Zv3yiJNUJYgl6+tjfXB6IW9MCZ/1VIpJfL0i6SyxLuIAF1vC8z+PqicIXhSCkwt5d72wkAqO7Xr6f9lhnQun6bn7P/qhU8O7vsxoPk/6pSse/8XGhd2EHp+Gy99Em2uUYlW8EItQA0Xo0pQ+GauN+OW2DPzAJVtPdMFLRhohbrzhL3p9O94yfmRarM2+jq9p1/meoxMGBNar+mwPtwHIyAoBW3/CTG94TdfMmk22AqWFvbpoj/mWwAfGNLmWhVv3Bz/Xiif2Vc3Y2y2K4J2d0L2X8e/UH2WNnwQp+aSE3Rmp9TOomR6FWUOCdWLL6gG2w+sTr6w9q6GuTlu7a47tOwNXGaqurzOo18Tl9fF/oCquCnNn3SxLNm8vvidWU18eoWTgwteCe84ivKmbxPL5Gqm8qd046xHRYDlCGzdoolDn/VUth3yPrM7WDIwWyep2geX99xEOrjKSv1wiIr2GywrIsPNOVqC5s11WWDaE11iPdyOfRbFLkBd6kc2S9qVZ38fExarY9eVXAvEcW9Lq+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3432.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39830400003)(376002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5660300002)(15650500001)(2906002)(8936002)(8676002)(4326008)(316002)(66556008)(66476007)(66946007)(478600001)(6486002)(2616005)(107886003)(38350700005)(1076003)(41300700001)(6506007)(52116002)(6512007)(36756003)(6666004)(26005)(83380400001)(38100700002)(86362001)(449214003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AeFbooiVm7FQwkF6wHFPnTyS3DuUdxVV+jWYBowdEX3ISILbYLhEQKEEQsCQ?=
 =?us-ascii?Q?xTygiVoxGSDgCejDVb07WBXmM5SA+TOse/EDF1XfskkZbyQcCfveMNBywFSG?=
 =?us-ascii?Q?y1TKQRmQYzAw5Soy1LlO+N0gQXhM8RYGKyC1mTp+jloxrsfMS9g9TdqeP8fp?=
 =?us-ascii?Q?CIvZKtMYIx1Ev9gOinOjcvud6J8dw1M/vsJaON+eoILXDOwqzsHkhRvyf/Yi?=
 =?us-ascii?Q?jKmtP0vhzzqu0ZT5nqpgULDFC7AYWPTyi3n/lD8v340iivz+pPffDS/8lfs8?=
 =?us-ascii?Q?BngHsstDJ2FUrWJsnFBnNt99JPyfThfGBNkHiBkT5nuGraFgLlVsA3iKU0tt?=
 =?us-ascii?Q?uYTDFtKpNMRbFMYMAzXUa2P9u3uVWuLzErMeBFgZzjEI7hNyLJidbZ9tG7Fr?=
 =?us-ascii?Q?PkDmstTT2h3iCx2He4fGC090I0ZFBzgHh/MJ68NxLO5ODrF/zmhi3Aqgz28i?=
 =?us-ascii?Q?P88iliO7mOG0gd5AiLfnPpEI/CQ+/ImxdcSyXb/JeRazf287S2e+JpwHKcX3?=
 =?us-ascii?Q?WLSi73Og9FxjNdmoFSsAzaODIYziQ6jSVQQAG46DHghAgeudRygKpmiDxQAQ?=
 =?us-ascii?Q?+osG1P8xklzsJsYBEOZ7890HTSaS/Q5DL4b/6PY3LVdhio8AbP0gzYIPPRLU?=
 =?us-ascii?Q?iyqvFbVuY1y8+jeixT+US2hPMV+48Se8wNDI6Gw6Vjyg+NGvZ1XuyosKpM1v?=
 =?us-ascii?Q?6wugx6XRJdkBvtHZb28uf5mPbBtdFNi7L1eU3W0UkLiXXp4qMqD/QLX26YDL?=
 =?us-ascii?Q?nB76JsvbqPasfTVAR/qp2mY3fTlL/x+IG6RtLk5VnjbOpQm8QahvymHz4UDd?=
 =?us-ascii?Q?47xuQZjRxVxB1IyeIZ0Hx3+SZjKdcdYZgwDaQoQqD+4UvpMcfIrr36rgFtM9?=
 =?us-ascii?Q?LR08wIRoL6LePkKtmZEYsazyXFPhk8nKQXNEJMWox1A4BCofJZ6sXakmDvfF?=
 =?us-ascii?Q?U+2GLv6BRTy5fKXkKS7PrILRRSuFdLRPykzWZCACXrZlgXvCGZUVU07T2+Up?=
 =?us-ascii?Q?ssRfOaD1OHtgiDY1RXPbTlV/gqTRoDctAjA6SF6hLeVUrDjTcxOSwezXEE48?=
 =?us-ascii?Q?DVLFnqo1XJGNir9OyuQfxm80hmr8p13y8EjfE/m7gmEkTSVZuJMJWtSA6mGm?=
 =?us-ascii?Q?7cJpYqqbiK+4YYBfgL5bY4NHrQ6Yl5M3Z8N80UXL38Srmuyg1UI3B6vpeOLv?=
 =?us-ascii?Q?zf0xlHLxRpnO9RUUZncAjJ4TWrVhFA9XyyrxJN4YLKllpDXKcE1C4SY7WTZe?=
 =?us-ascii?Q?M5WiJj3PniAtjM4nzSRb1Wo5dYCfe+XYHL1Q6yNyfwvCkavHyqYXH/LcOLi6?=
 =?us-ascii?Q?M9PKg85FvJUBtDH/+eyKAThXpZETeeVGz1yQVabzYg5GIhIHWNBzKSxMMvxA?=
 =?us-ascii?Q?mzv2IDD3PqHIu/kfIuzgcdBH9xE8HYTvJtUyQbhI4a1jN1pLeS4gmX04RZ5R?=
 =?us-ascii?Q?m3XBSewcwqbUASHtFlrgQgmahtiiqX+KlePNRSxcwG8FOQIlVM6z5I7iBUn4?=
 =?us-ascii?Q?ZoCB2ChUBLllJRc0UAoMdOgWnCoNhCNgc9g245P8XdHfgCJ1fFb7TvtybumV?=
 =?us-ascii?Q?wGZpSoCF/xNjJMHCSe5DK/fOSfyGUbm1w4hWimY6vnQO9VImvWrEYeSvQtzU?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95f12b1-b664-4c09-b459-08dbfaf53616
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3432.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 09:32:10.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM569DGNFfo5g8I0y48fVrKacXQNvJL3+XUn0Z9T7bpzbEbSmqUoHVcsFQCSgt9QIcgqsljkATDYuCjntrMCbHgu7Lm7Y7sK49XR4Wz+3l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Xiaowu.ding" <xiaowu.ding@jaguarmicro.com>

Message Handling Unit version is v2.1.

When arm_mhuv2 working with the data protocol transfer mode.
We have split one mhu into two channels, and every channel
include four channel windows, the two channels share
one gic spi interrupt.

There is a problem with the sending scenario.

The first channel will take up 0-3 channel windows, and the second
channel take up 4-7 channel windows. When the first channel send the
data, and the receiver will clear all the four channels status.
Although we only enabled the interrupt on the last channel window with
register CH_INT_EN,the register CHCOMB_INT_ST0 will be 0xf, not be 0x8.
Currently we just clear the last channel windows int status with the
data proctol mode.So after that,the CHCOMB_INT_ST0 status will be 0x7,
not be the 0x0.

Then the second channel send the data, the receiver read the
data, clear all the four channel windows status, trigger the sender
interrupt. But currently the CHCOMB_INT_ST0 register will be 0xf7,
get_irq_chan_comb function will always return the first channel.

So this patch clear all channel windows int status to avoid this interrupt
confusion.

Signed-off-by: Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
---
 drivers/mailbox/arm_mhuv2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/arm_mhuv2.c b/drivers/mailbox/arm_mhuv2.c
index c1ef5016f..9191c5b69 100644
--- a/drivers/mailbox/arm_mhuv2.c
+++ b/drivers/mailbox/arm_mhuv2.c
@@ -542,7 +542,7 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	struct mhuv2_mbox_chan_priv *priv;
 	struct mbox_chan *chan;
 	unsigned long flags;
-	int i, found = 0;
+	int i, j, found = 0;
 	u32 stat;
 
 	chan = get_irq_chan_comb(mhu, mhu->send->chcomb_int_st);
@@ -553,7 +553,8 @@ static irqreturn_t mhuv2_sender_interrupt(int irq, void *data)
 	priv = chan->con_priv;
 
 	if (!IS_PROTOCOL_DOORBELL(priv)) {
-		writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + priv->windows - 1].int_clr);
+		for (j = 0; j < priv->windows; j++)
+			writel_relaxed(1, &mhu->send->ch_wn[priv->ch_wn_idx + j].int_clr);
 
 		if (chan->cl) {
 			mbox_chan_txdone(chan, 0);
-- 
2.34.1

