Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0A75DC83
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGVM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGVM1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:27:24 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7D12D77
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxDgZMyy5qm3p0C4dluQZm+RK5K67VJHi3MUSxAyQdcx8209KIrevQiu46LiDFeiOc/y2kGsDq92I3K70xTxh1iZ/bxK1LLAokiPqorvkzD/brEPnjTKQtl+SOP1yi/XAQSfw/TUYO/H5LR3Lsii6bbljPC6/ISY0LQ1NY07VobiGhrsIwJJOlaU8GUq8moCCE7ErGahCcJ5I7AakK4lzYtQr4ZLPEX4Q0vTjg7jaE+m15FzpIB19qZW5Xuq/NfugxfwecU6IWMYxJZQLeSEOPTm/8gE+1iElUWo91PaRQfV7w7MqGXTP8MzmBSPPHPYlIsUT1GPs8fALkN/cXO5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=lo689X8JdvmguXy7iSenZpqT/wQ15c+V7LjAB7fHuC4gWxvjZ/JO4LSIq2sx6c9Er7bzuq0YkvtxZ7OnewAEWYwSuRtiPhV9unppraTaCJnQUTkgjr3FTvcLMqFH+1PLjAT4QO3JLxhGYJPq9+qLB7Szpp1aYZJWqw7XQ3N6Bh4WDHUEw2sM35upzkaEtRV3sDbpEVIDJME2yl03FGBH1wT4TLfrM3G+cBcrkkUYL+OtgWtt5VQGqz3F+3LVH4mk2mhqv+bnu6IGedxaLWcFT3TH/PkO87FXRYL3hJobyQpIvl0EKYmbyiqTKSoxrXGD1HoM0t9mgenHSCdHD+LQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=XKzpYB3/v8tiLYQykRyWEjMM9ZfLlrCOP3iF1frJLLw5oHvA3y5R3xrPY3obtjwX1O/cV6h4JDIbj2gNzjwXjVludzTUeE3CAACTZ9zzom0mm7y1IcknhX0nfyJ0k6s/Y4lX0Zw5LGKYcR+M1h6JzGxGa/RgmOyhQ7cNf3o8n2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/8] firmware: imx: scu-irq: fix RCU complains after M4 partition reset
Date:   Sat, 22 Jul 2023 20:31:16 +0800
Message-Id: <20230722123119.1966998-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b85a33-f8b6-411a-f176-08db8aaeee81
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdfCNvBXux37lpPU/wl+b21P7rPY3rxsNNApoJPSpAKRny5WBXYZ9Bmswitz5+TClEH7BiH587VxmB8DFpnAC5FH+KEtGpyIAQKmiXKjp+YwjhOuSXHY2aDZCeByCrAEc4QfiKGrqNURN0tl/aV6kmEgUYO7iXvGBBbYMHVGBDPTLQm4jt+bgU/ILmx0JmezyFpLqFhcIZKsEPUbnpN3HB4RRSPluVQSBfL7aNeDmNSuPkvi6ejxijrwq1ojaFNpvD/twJuS0D/eMb3Bf9q7901fuctJSr3OpCRV0Jj+VEttrqpWPRNdc8HTWVGdhl4YHzQDDhPlgg9nj39XwI7/kx9ts9ibpbNla9qNWgQJpG1eY0D8nseXJpyaZ5L6uN4775p9p2OiEeb4ijauDfEgof7D852X/a5xrM/pMdxRXyKf9e/n/YedCRiHdqxG21HR46NizzLpXh+Zmp24a/EmAo0hk53dpmdC1Xn8MhTtzkGAgHwow+zpUBXHN3BKoKsUd20I8l5upx9QiwaBnxMmGfrLrcyIyVFygHR/pQHwkJjBWkpqmVxLT7ZKZmXdLhTFxDBTXN/iSHjRHepMT2WeJg67XjMkdl2ITsuKxHIcQiGik0dyYjMBFyNpq9v1A51+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(54906003)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(45080400002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk53eHLUbzJWU/R5tVzqPBDa5LusdLxtRe5B7rPkWC6qD55YsnvmhTpEJGW4?=
 =?us-ascii?Q?SXmVJ+d+I/ybRMi5lPTKKyvPtuiDaretS/91ytaPpUr0N9TOK4ES6LoodByX?=
 =?us-ascii?Q?1pWe8QPCWCkep2pMYRj0qzgvRPC4yF+v2b5ajHRJFiyA4q8u4EOtFDu+iDTA?=
 =?us-ascii?Q?OHhpidMOlJYGcQNYYTKXFKlYlZ/8k+TeO5v1YCx80T0Mc+hcmBzhESf1heYK?=
 =?us-ascii?Q?nlsYCR8i/6Civ3YK+J+7/XV+T1WUr8vn/FZQV70/uvpzU3auLmUlUxcrn8j/?=
 =?us-ascii?Q?JBj9jdXMWWbAyzVpWX7pxNXj6bedXi/h/mpIPyQHyLJKnXxvX8EWYSow7edk?=
 =?us-ascii?Q?YbuK1l8jB9lCtNJVZn/rrDQFDRYGwzCh2Vi1V3aHYQNM9W32xKldO9DfhfsI?=
 =?us-ascii?Q?bJv9UXriczExvdelv5rbJUR7Ou/c9fs0wHNT97ASHZhN4bb089EiPcliVoWL?=
 =?us-ascii?Q?hjH4yi/aH3SRPJmhSHALtggdZliMWjPB5pdHPKNgOLlXKx0RlFVME49gajFC?=
 =?us-ascii?Q?jRagjrd/rGNarLRB1Pcw1MCEPvg6YSeE+HROgv6ETE7xWly0GBOnbUqYVkcR?=
 =?us-ascii?Q?w8hu0jrl6PXNiyC4ns0/VnyvVM1slnXjohe5H10fD92vJSPjQ3cmhYwkxRar?=
 =?us-ascii?Q?jZciR6X2dFnJSWQicNTbG9GFP3C0T45JnpdF8a3a5hpBtwUlOZsoG/149rAy?=
 =?us-ascii?Q?OHuNqzakrHz63bypKKEo7fzQrfB+ueUUzBUWvUbNyJBGtDUBOwSo/2LU3mB6?=
 =?us-ascii?Q?Gj/bI/GuXlVJePSRzSpmI6AcUzXEo1Acx1XdDBdzn8ptq9xIqJOiu/2ygftX?=
 =?us-ascii?Q?tXJR180OAc1ilAoJ50mcx06aEweXmgbg+BPK0vBFp7DafvWd8ailJ9QPyCgV?=
 =?us-ascii?Q?74aJXyfE4bezX0vFsVBKoykP3eWnOf3D3S+NK2fL4MJ0ovBG/kHMmG9jhmcb?=
 =?us-ascii?Q?qD/xEjPJqPr5AntW7OGIkVSSjshHXSaOUOu1zVkGWTB2tdObnUSx/LlWHxiQ?=
 =?us-ascii?Q?g1y0QZfcFOHNbVrCacr3bqugacKPMH47L78o1NdLsM9VBX/p4sTDQzwnnEV4?=
 =?us-ascii?Q?3Sv1BQ10ZHLpwHzVj+8243gFDSg12phYCQHEfuCSDMgeJqhquzdCfZOaGAMp?=
 =?us-ascii?Q?wokgw0zau0OYIvVmRIy+K0+QIqZ1ysKfqICUOWcR+1eF8ZtlQqgGwUiKlXEF?=
 =?us-ascii?Q?yfKsL3doQdlG5mNcHnvABUUD9te815BOlz32aP/4VpJ5NM7H5IR8k3x9LQhM?=
 =?us-ascii?Q?40p+F9GEIHXub103oeywDYV/t6eIloeROHmAZ+3J0kCe5Ajg2pxhhtdI3FMP?=
 =?us-ascii?Q?ZXfk8GAhiWQxAYl3GmjvF4qNbH9QUWp8Jq5ZgT3Yld7D+VDkU0xTa1OE4kW1?=
 =?us-ascii?Q?ImzfAVjtKzq+tXGniuD1dvo/I7oP35ak6P3O3j+TpI0qqvuwjEkjhrIZIUMj?=
 =?us-ascii?Q?Tn0SJfm1zn6yUej6aLUzowbsBMHh1PihqnCjBqbzkKAMQrndGVmGlYc1irNY?=
 =?us-ascii?Q?EKid/ZoMD7zp9CBKA/RiQAsnPBWGSX1hDsWCSmaKLGOGqA4jnPX0IizXoISV?=
 =?us-ascii?Q?8wZi6RbfOuNeSB4CGv+EE0AwstTgy/Ml4otp8+FE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b85a33-f8b6-411a-f176-08db8aaeee81
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:53.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiZ8Xy+LFPhcPQTkk4CPrp2nqX/JyN7BAIdytI5siSopBuOqPGAlCbKCJ3WvRG97yRe1qqoM0CsVnBxxfQnx1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Use blocking_notifier_chain instead of atomic_notifier_chain, otherwise
below RCU complains would come out since unregister/register_virtio_device
() will issue mbox message (mbox_send_message() is blocking) again after
received M4 partition reset. Actually, no need atomic for notifier which
is so tough for user since this notifier is called in worker instead of
interrupt handler directly.

[  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg driver is removed
[  389.767362] Wait for remote ready timeout, use first_notify.
[  389.774084] ------------[ cut here ]------------
[  389.778729] WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293 rcu_note_context_switch+0x34/0x338
[  389.788131] Modules linked in:
[  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted 5.4.0-rc5-02977-g08f78722f07b #26
[  389.799633] Hardware name: Freescale i.MX8DXL Phantom MEK (DT)
[  389.805481] Workqueue: events imx_scu_irq_work_handler

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20945c6..4408f150b3d5 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -42,25 +42,25 @@ struct imx_sc_msg_irq_enable {
 
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
-static ATOMIC_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
 
 int imx_scu_irq_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(
+	return blocking_notifier_chain_register(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_register_notifier);
 
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(
+	return blocking_notifier_chain_unregister(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
 
 static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 {
-	return atomic_notifier_call_chain(&imx_scu_irq_notifier_chain,
+	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
 		status, (void *)group);
 }
 
-- 
2.37.1

