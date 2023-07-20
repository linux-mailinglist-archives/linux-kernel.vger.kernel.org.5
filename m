Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4602E75AB20
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGTJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGTJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158453AAD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lO6OxfoWDgToZkniyuwpms22kMAnLgW0Z9nttDLDcd90F7xpk+fzDp0Doy/lhhw1kLvz5OZ/a2dKhJxfnybu/gNvi1hygv1vm4zgj0aK7WRrREU2tMawaco3En+vN9d4qVMVutHJmbHRIcIJ0GG2N1UPvLwiYbsIz5vFfFndCBrKWX16UsvxR83s+Gp4YsqZfXq2ntv3B2XguA4N7CrX8BsoNrV/ILuFjM1d5IQGboxe4nBCi/1pKamJnUkz+fq89Kw4DNb6AzLN1Z139rzhyrQm7nOLp8KmeOCT6dtHxRJ+M5NGgaEey9BtUCyrRT4Xjv49ZEPr4Acn5qI2tS69dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=hU6bx3NpYnjgApc9KEtcLL6D0yw4r+tOPDdK0CCh+jZzuVeTprE2qAwv5bRlUjegCPGZzPVobD5FjCvCLEXtwHIBsiSuwvbVDz4n8EFnrNgpttoWGA0hjU385PZAlcgacrop3dnqnUOFv2eFI/pnINm64rSgdh/I7Tn11vFDovG3+O+T90SR9W2QoMF3bl5n/XFaBR6qlhRRM6IvWSJXHrR2/jeGozYgdozd9HU4fh2U4krcdd6R/FsVZMQDbbGt1M5rhZM1NC1DyxYE+946MBWbBrWt30SpLMU8KWjax5NjkntqAjH0FyWe7+m91nEsFpTB7vjxEb/TCGkezmeheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=O9F+xHZglmF2WAiRPP7TkGFkBAsBW4B4SNRyUO3vKFXxsZc8je8cCpx1Rd21C7uAq3xzbUKizRgrjGURlr2uva1LO0zoz+6lwXOdtvxiO+MFhiBYBDa568tP1aQVw8WAbnZhFA1lNcsjR6ENG5oYZanGRo9w+HwX491IWdf93Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:37:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:37:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/8] firmware: imx: scu-irq: fix RCU complains after M4 partition reset
Date:   Thu, 20 Jul 2023 17:41:25 +0800
Message-Id: <20230720094128.536388-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7a0347-bdbe-47e6-5bc3-08db8904df5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8JEoG7BM0xzInG0xQaDzPJPkz1/KHvRvidsqSDxIte8+sRVob/PfEJcF1thxq4Z81BhQSPHG9n1P34mBjEybN+smk/MUUHSGbIDXdOHdoc6S+x5QydNRiD9EIq69xoriXg8/gz6ZdaD6IjyoHTmuigBqMh4zeBKsPNgYKhyQkqrdRDZuxFTejyTOoXZeYrBZ9+KUMzV0Ml0CMdC7PNRn9evIUYcOm/Onv2Q6ERb9AWX4p2TQ02V0f4xxbEKy834R8rlIavOhzjnoCQYvdHcA+vnGPJu2tFkHCkkMtBOFwELPzX8n7H/X2BG2SUUEb/ls/gg8hQctNFJw6JIyPiwjiBZvhvkX9r2Jv0iY5A9DI9fT/3227Sug1iFJ8zRuQRrPjVo+kfZgHSalxCFxunQnuTrduQJ01wnLNBku4L8eKSYm7rLHlDu08lxaqY2g3abI/yr9z2T7x0nD67q21nc7OECzybCbdtdvaEP2WSr7P3snryWFW6jKZ+alOny0XGvQEHfP21tKyQTbn70lklVpDgYlwX7MTE8mnydacTLuQG4GI0zjL0I5PN4Qq4nx0D3XzqaSD6flgDVYVsnQCG+cL9UNYn7SRQenv7sxUU0adS9x4McZBoI4QMW07S3HLRn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(45080400002)(54906003)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FuxwsEwY0bwXpTuvFfXn4eRa9VUpj8qoFNgHYqGDzH4fUIf+X2W4slqKU8S?=
 =?us-ascii?Q?9sDJxCap8GifQIvffQFSQRb07QJ00UqHsJpDtwnY4mlh9MzjtWV38o0D++vo?=
 =?us-ascii?Q?NcYiEe73/poS5b441+DwZ8A5ywMbQYLysqIscXBDUE45wVlWZYvT26l97hlK?=
 =?us-ascii?Q?zJjMRr8Q8QUjLcy8xgi50TIiD+0Q9HEDFPoPfDd13QqwsJqyPDsA4dyU/d+d?=
 =?us-ascii?Q?oYIe0TUIUWGXpyXPgkEfDDQK3z0JKHKNoTY6WwM7jMn96C6E2x3tMB1H28en?=
 =?us-ascii?Q?6pd5BD5JRqNVE2xygRYPUsx1XR3AtQdfvrzCcPMPSYQU0IqK+oTV7lxhLkRr?=
 =?us-ascii?Q?Cpqn2v6B0fzHLrFAXx/W3JokzaB87oyx9zUMBq6Iugrb0katBqkbDHWZTEgx?=
 =?us-ascii?Q?cWrQPJiZ5XeLSc4K8CE4yRMPAgSk4cThVkRF7lOhZB4lnhmpQgKu+8+qpsAy?=
 =?us-ascii?Q?5sHtFYzClTV6kbIvxuMtwRH/O/Y6EOEKbdHFEMWrZ/cwDBMc/xwtu7PZeF8a?=
 =?us-ascii?Q?3Kh1Bg4A8W6R0M6iRAH0MtQhlr2nGJjQHw00BcuWmf2J+b/AJhwCxrc5VXk7?=
 =?us-ascii?Q?nKeimeDFUmuZJfkajOMI95V0L2a6fIDXE/e6U/unNJ1iOxLikKcfbwth5Ru4?=
 =?us-ascii?Q?jkLVL9Rr2+FDqhlVPowkuYN+zVjsxaCuhjTjXJw9YIIGUgRXMdvxHL+nz6QX?=
 =?us-ascii?Q?8lb3Jvrs7EURH2sbVQaTUbICqCpUPP/Sdu+ml2rND1QToycUb44YuxK/j2lD?=
 =?us-ascii?Q?0MSDmRly/055ARCxjRUMoOOQHdnrjflviKa67X4Cq15dYFIX7oFZ7DW4sgZZ?=
 =?us-ascii?Q?slZOJMLRhzed40X5Ku42XbT5VwiAzmpjmfyZOECeCfMYjL/YvVmPySZ52zsr?=
 =?us-ascii?Q?H5vnc7gz48IiaANEO8zXWegQAvtDbV0SLaCFBPG5xuWim+sDiGOFsuxQhVpz?=
 =?us-ascii?Q?8UYb+SgcEb3kOTWijyqf5FEEbWHfEyJgnqkn9JZCcEj8uI4YWZ6pbFoejHk0?=
 =?us-ascii?Q?8I7Vch8RpHdMpo/gjTSjn6bPLc6xRhR/fLj6sEbmFVaa7k7sBZHz8RdDP1CJ?=
 =?us-ascii?Q?eOQOgZTAVmf7V1myK1cZ2BqKncM7/0C0fei4Trb57FyOYguOfZAYYQtvcNNP?=
 =?us-ascii?Q?eSxqZxOkINSDE/2vuk09FcrsyhqRBcht3MMWAM2nIgFe3cwFJ97MAX/jA+u+?=
 =?us-ascii?Q?+0+raNog2AtTU8LzBfoMUz13t0Recf9UauwkXOC7daq1XxiQjXwF+kD9i6M+?=
 =?us-ascii?Q?lhj2VUO+NWcz+B1Eaar0nomvSSajQ+458HkhmV3wUwfJEQVYgK1ctIbPJnMm?=
 =?us-ascii?Q?eBTVzcuhQDlTrLydB6XsjQI/8irw0YO1uW2PZuoIrBMcTM7zhZuSXK43vFzZ?=
 =?us-ascii?Q?djxmeEHD7jBMKaNio3nhCHe1sZcthKkuTJBmUzQGsplBQlZQOuNVHMpT2tYt?=
 =?us-ascii?Q?mXUQXVxo/UVet4JJcZkCW4EO3YdGei9LcvYWemKlKoLMdmrzdShhenzMSWRL?=
 =?us-ascii?Q?qyQBTmGaCEtnUw2voqOSdeI7kzg/5ndZGNLKZRcMfCtOrCDOc7C0ax6z7d/+?=
 =?us-ascii?Q?qbshAW3DU98V12aDEnL9IcovwAIdNLhjLGL7ErJh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7a0347-bdbe-47e6-5bc3-08db8904df5a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:37:02.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O+3hk8LifBJB8CrfwSysbbxXi2DN5Krjj/N0ujvV08YLyGDsCp4oIsZITzWvFT4fP/iKaYopRMV9FtSotSMBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
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

