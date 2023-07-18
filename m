Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA27574BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGRG6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjGRG6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:19 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D20171E;
        Mon, 17 Jul 2023 23:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ln37CPal0xS04z2LFZut5ejnd0EKProBwhXoUcpfCaQuzAw5cyAwP/y6ZHSYOjzuEuW3wcRQWa/5lSgDBcBgpTp+Szu8k2MGnAtEst56qk+7be8XD5U9gl4SoAr5sncsQNru2OsgBcnrSiNz4aV8z0Y9X8WqpYVtmoOigF6e/DVDGV23wwCnkTMjAaX3w2xUa3d3BVrKHMR3KbEjby3I0Quw8VRZjM9MiNhX6wVlTQwXaiQw8LI0z2XymYfUhcGFRd/Lh/udvoC88grpcK/2fE2f4FOodgYHwyVnx5D5W+1UwoTJn3seK580ng6vWj3r9kS+uBE+ykd41iRKJuEADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XYZKYh5/XNOu60AoS46G4s0Jf036Mmq3C2oTqfNl90=;
 b=E1/w3ynZD90FFAvOQQkSDAox3r594zYZdnpWq6WXpwEe1qQ3+uHKp2CUYVBjxVWMNCAyH2+voJYtG59EzBPJR6u1YRZ8ulbhnqLDrRaLVW/InbEvU9uLP1STWF9NB+R8q+NvIri5j4u41Nxc1tJvyF4QDOy5lpXnnEVXjwIOhx2WNN/B9wYlZKjoRuCH/IVhdIeeDGCKilbzpF41CIcqqivY7eIXmaYEfcqXkGjzfY4R/OawTt7doqK1bQnYEYmHNfzDaVRqTY0etmwTuCQ9ZQIZC5hA9/FchxJ2w/oKY243DkXycfcnY5DAyNLRcKRHxNxEzpCb3ApDoo3W8YqzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XYZKYh5/XNOu60AoS46G4s0Jf036Mmq3C2oTqfNl90=;
 b=iXt1XGUvHMophZ15t5ZKhCo55Gn1Wzogox/wwbRbF+M+vhX3apYHiRyrM3xqo2Ivux0/zNk+vONcTSdkvGIxXX1WVc9oJsBAqUqNXpxsW4ABXdyou9mx1x2ZIk/q+E4mDtp5McJS6rTBdw4q/PCxbhGYBcy5rCgvrXkKrPzxh7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8203.eurprd04.prod.outlook.com (2603:10a6:10:242::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 06:58:10 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c5e2:98f8:b03:2189%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:58:10 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, shenwei.wang@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: Fix possible integer overflow
Date:   Tue, 18 Jul 2023 14:56:45 +0800
Message-Id: <20230718065645.6588-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3c5947-f3a4-401f-5b40-08db875c58aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQs8y0A8WaiY2Bgc/c6Pyk9M1KyrJ8TElkbldVDPuNtxHs1R1HpdZS6RFHa6FVXJ27k0MvGSbiMo/HtWBWHVeHoB6cDSgtjf7Eo7FEnMuY5ujeFr3asIlESqmAeU4JSDJDZycZ5/+OD5z0D7XuUjtxKi/QCc9PQOpQRFBoKpi0lq2OSoO5uvjWaCHKibLgT+OBUdHhHifjRIF0pU0MFwqAZs7Jg94yhNuG49M1ANMKS6lllC8dKCx3VvtwpIvJkw4b/e9nCFxAbKc71NMqnQs9UwBJ+JEzNUWlCJTQJ21EDZmJTrRO3d6zoa9fL1iwZBaYwjdtFYtepSwoPMYW9DX/lRzIMAHuyGpEDedw/fUBfipO8g7GqdHAiuQL14RYCOt6eW8eFebcCOJB5I7u9dSLNlMKQ3HYBNCPTOdFAc75WdmTiycghxJ/FbNdGsTbPR9KndJ/eqCgEmdtw4ME7QPKV89RSR1EkLb+VwCNXwNgLm3MQxpqXY3wjMs+mqbKPUy4mlZnzJxdSXtFuOdR2wVtqacYHDFm5uksVEU/xWDKOvp6PfA27UzKJJ2/mb1svy/0ucxk1vdAUb99Zq8QFdqye8bUwv6IABFq+VRXefhf2Zq2aeJcuVoSkh3tvxkiAX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(44832011)(478600001)(5660300002)(66556008)(66946007)(66476007)(4326008)(6636002)(316002)(8936002)(2906002)(8676002)(41300700001)(6666004)(6512007)(1076003)(26005)(6486002)(52116002)(6506007)(38100700002)(186003)(2616005)(83380400001)(36756003)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cy1IEM9kW5F/Yz0InWUaKVyYb1DodUjKYlnAuyiO1f6U/JmGBehwI4+snsjj?=
 =?us-ascii?Q?hwoJQ4pKjQFG4OhjPG+5hY4s4QQdmucIdfj8OK1nRh3ECu0nNDoAo8oX6kng?=
 =?us-ascii?Q?ixPG7vRxL2HbmbMnuK7+HW3KZ5SjENH0A1Pmj0W14mHMgqinNsl+vr03Eb/s?=
 =?us-ascii?Q?muq9HXDAwftBaNxO1jHsSZDUOXjbYAIDqdUVZv4BXit9KYis3rIrPRG13961?=
 =?us-ascii?Q?juHiViTH9U1JABopbD0nDSciLLH1G7CMJ5u2IOqX8URs72TzO3dRJsI7BEUa?=
 =?us-ascii?Q?7XIV5XPGvtFk9bOmMr86X9S3AUAUm99WPMuwpl+kqy3DxHZ6esJAx/s+p86f?=
 =?us-ascii?Q?uByZOJSLIBxtDipO7+wZMjWLRP7dco0TitqNK/THNKtUhLeskdijtP1nRVTU?=
 =?us-ascii?Q?AtxFJoz1ZVZQYJuPMa+8yiL49uOJwDJl6Yq2CEp7NyuuJ/trupulDNwRj5XF?=
 =?us-ascii?Q?c84GlIaTPwoKP8b+EFeLCaRZZJxzbMC6xHAQW/52bhAIqiP5IW9JZK0Jb3Nk?=
 =?us-ascii?Q?YqUkKBygZrdL1RG7c0v+/BlDPkHbD3dn6FU5fRuj3efdC/MBq1l1/WritnW9?=
 =?us-ascii?Q?13ZEVqka55m7TMDGEUm8UUeLjJU8DlDS4nVoZsjaL/udS9QsKnxwBGFKUKgG?=
 =?us-ascii?Q?yNhqh+rR79fhS9r5dGAq8vr6M6+5iEsVO/1QdiWxQQ+CNwO4r+IeeKPC1pVT?=
 =?us-ascii?Q?LhtQ0Vi6c7V0+F7SBhfyu/bbG++tAab9304BSmoRXjkYKaotBB9NJD3GvR2O?=
 =?us-ascii?Q?6RbGksRcmBwlIII89laPmno3PwM7FcLYjwlw9tsudYZOprwnxMyplh8humff?=
 =?us-ascii?Q?9aGXAo/1plJVoaedOg/33Vlq/SB1FKjAg1c9bfUAO6fRM6AfErtjLUWCVyiD?=
 =?us-ascii?Q?OtdNoSmltvXLGEEkQOU2/FYdKjwqS6IGuRXQieZ4ifv2WrOIwUy98/qUIehN?=
 =?us-ascii?Q?Ry2+xifZRda2UL/mRh1u7iKCspgj7TQ69IYnX0bz4JIhbu4JVzMuJitlbLwJ?=
 =?us-ascii?Q?ekAZ7bzkJeXM0qI7FqyiQKYwGQ5XIcjrH8+OYefOqgYSCJDjaeZHBivfeRXk?=
 =?us-ascii?Q?kyolV567iRUAObddvDGztS2534z3F3udiu5BVdUmsdGNSsC/+WvZ4pKmmB0p?=
 =?us-ascii?Q?0Kusvwb2EMVSxukMGQmT6ijRInOG25qr5Xhyh/rLZ/in/N5GL0XeqbwAEeQK?=
 =?us-ascii?Q?BlDMIJ2ar614ECh0Qh6XF7nmUsco56Muryd/QWHbWSIO6iTMbP4Fvw0Htig3?=
 =?us-ascii?Q?R0S9Zc9q0RAyLdYsRUNZD44IinTkNWWPjU7iswWs3/UAuWQZCDRFiC0KUEQ6?=
 =?us-ascii?Q?bTiIb/vkQqnITq9jaJfLCCbiBR4EC7Hli11LUf1qJtp/N10/Sun4+gcM5AWS?=
 =?us-ascii?Q?C6G1+zZOD9IM1HSdA6HC89rJNmSfKSU9eUV64Me9mFaAiws2xJ59AZyhRhcQ?=
 =?us-ascii?Q?xQKpX7In4FIymN6YAy35LKnjjTrGyS72uThi3WTiJjkZ2byb5YFt6eWaEwBL?=
 =?us-ascii?Q?gTvXh7NtMzsJOitS2N2Jt2MyMkf6qLEIFhD75Zjj/bIAah6A1D3YJf/Rx10i?=
 =?us-ascii?Q?H3FDv/HDGpgfISpZl9eDoL7UcpFLNb0yibFFqWZE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3c5947-f3a4-401f-5b40-08db875c58aa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 06:58:10.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I0BslkB0y19lT+LAy3AIC1QbdOI2ArG0yOT0n6WRciRkVwvpbqwkeW7EHjr81k6/QAR3e/iRrNuh/No4vgWaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses the following Coverity report, fix it by casting
sport->port.frame_time to type u64.

CID 32305660: Unintentional integer overflow (OVERFLOW_BEFORE_WIDEN)
Potentially overflowing expression sport->port.frame_time * 8U with type
unsigned int (32 bits, unsigned) is evaluated using 32-bit arithmetic,
and then used in a context that expects an expression of type u64 (64
bits, unsigned).

Fixes: cf9aa72d2f91 ("tty: serial: fsl_lpuart: optimize the timer based EOP logic")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c1980ea52666..07b3b26732db 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1373,7 +1373,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 
 	sport->last_residue = 0;
 	sport->dma_rx_timeout = max(nsecs_to_jiffies(
-		sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
+		(u64)sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
 
 	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
 	if (!ring->buf)
-- 
2.17.1

