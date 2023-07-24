Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58075E983
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGXCIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjGXCIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:08:05 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D53C13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Popn7ARYYZQsmj/clLRNFvRpKG+fIev6xMrPudBn1gTqSJjgyo74bhGc9RIlZHDSBdagxJDPQ88Mou3f67/zThWC1QmZVdbHCnC0FwKHP/YNRPJek7xRL8FZHsR5z9J4CQI077lUJCum2k/KTvhRHN3OvCc/9d+smh0h57Ubw2aL+gc1lOV60ZDOepSbDw6BufKJyP+ISq+77MqrWRD9YPvtQkPH1nzBGYx4pxh2nX5SI0SQwoffwuJaGCJroild38/UW2478dSBvP9Ns2khxi/Z2mntSozwjdoywBt6HUD6EFAogXF4OwIT1TRx1co1rvk/UoVD1EdOqS/3sSLF7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=VKEG0uYEN4SnpkHivU2w5F0XuVSt3SqRTvKD/IbLHYKIuZhAgsvmvCCz4YNM+XxOXZq/9qWufsmJArXqnb8SrOUeTjWMNtyGO75Z4/9gN+A53SewSpnlrfWTJvSy5FuYfMWrDv1uLGi1e4QBlQSchm8ttxz9AEeQ/K/8rE2wccKGN52ppnJ5j2pZPfCGq3Zf3knq4hxLFddePk6i0nQDfUCTP50baqdPbRCGuPN/YA1qRhGDO8HhDQ4rL6V5Xgua8EjANXpYlGMU/5ZKQ0s778Xwat05A/nzzqIFqMm0j0sC2S1Cb2/Y4P285A2YxBqp7lLSagWOt9ZIbscVU87W9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=mLZ1qA5QwMPXTzatd3lWG4KnBINsGmqwZfDlV2ae6KIWdalBiaXik+AHG1GZclLh/4JiuY2HQLOqTb5fw/xoJ2diSY6g7RzIc42rAVc/mhfGwC6aqAxZH5fHxXGIZ8b2UbxwXTRkdnv9LZLLPsXLTvHRkqXGzM86ZcVfXkoINBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/8] firmware: imx: scu-irq: fix RCU complains after M4 partition reset
Date:   Mon, 24 Jul 2023 09:47:06 +0800
Message-Id: <20230724014711.2048958-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 43917c05-1c57-4d73-aff5-08db8be74718
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIYpjFcLPUg2L4ntnFgFOFZLhwYfm0LnX9YqxSOhdPLlEiSJF+6SkVjfvw17SXN+J00gOGhkCdLlCzR9Wp6m9A/Q7MnWbMusr/IBmA94ibgVCj7kkKpGhW5RJHjajjrIKsV74eL/FDo9iElL5WhNNt5YTYtxnOdRdB6tP9ye1QnP+dPdCmkdpw01OGylG/yJp/8YMJjuqwkKlcboRwrh0e1F0DA3O5l+21lYft+yp2haj3TaP0Z8bpdHVbXvy/VmqOTOJLnp0HEsOI7Xb81AvhMDnEQS+OlMaNmk/KpLu62eN4kKuCuhy+ZaTyBOE7Vjvh7FTFwM/3RXtfvjwBMFvyddO8zz/yMRaW9rqDRMq3cOh2cpaTyZYxwUP//0w90vB4K1ylIHo25YpWR2ZgWJFpEPRc0fec5KEqqB/GFzoJR5vr6hJlIDbcvFMzseQM5moQPCW64FEOMDx+6nPzCciMOq7rrMPHrN8CSInLspuBxSXL8k5J/35JLgI8z9/Ek2N1cifgoLKLYBNUNLX0GwwhUxH+30WWz0W/Abk1aWdB/E2pJU0hZiQhE1kTPb/ZoLAs5irT30lk41ch2vfXHl3V7J6B/hrwg/eYcGI917O0ozOXUgE/qIIPXLqV1PL9Dv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(45080400002)(54906003)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mIJF2ZPKbdTTCt2iPvCOXGTm9Xfc4HTb77SYZyK5xK0rD4p6/Vv8JkDwhapA?=
 =?us-ascii?Q?NVpZ2gyPgwC7G2fDV0zKtapu8x8LWrx9xczdbGOpFnZ2p0F5dTgfdssoMdK1?=
 =?us-ascii?Q?pv4VV/jggE3hOmH1cn2TjQ9i1SIsDTbRR9sLqslYqapQsYst2HRojgiBjVRf?=
 =?us-ascii?Q?a9jdcmF6NfHis7jSDxnQilEgA0kb7gvKvZ4tQBO7nPUWGdjT9Ll8If1KDs1l?=
 =?us-ascii?Q?ikNZ/eMINqSsqDGWrPVwTC9RP1DOnbChKOA25nzcn584Wb8TA53kP9CWC+o4?=
 =?us-ascii?Q?h2RDTIby1v5eSIddgnARJ4ZyJ36TRzApYVFwa0Vervnu1O/Ov7crZD1PLEIu?=
 =?us-ascii?Q?ezJlYvjdFJ+qo1ZyuoFqx3WLeZhE8gNpZ7LV90yUrRzz1H0dMrCG4CaR5Elq?=
 =?us-ascii?Q?PzMGGfRT1xNAWKi2jEp7a/T8Xrwt+Qa9PKQ04fBJ4Z+Eke/wU0akZe3V5wOR?=
 =?us-ascii?Q?Enz0kZJGCmpFwqN4ngniEnJXCSMYaBM1S0xy3RdU4AgdwIOsab009CDh+7yk?=
 =?us-ascii?Q?WkLZBffJPHW/HXXkbHosqjCyKXBLELXwuNp0bf2Gqb6icCq2leLjTbu8kf+C?=
 =?us-ascii?Q?SKwK5ZQe9mSx4NdmaFCdxnQ2X1rc+FpbEsbXNe/dsXTgbnvYBgcbRoFztbhl?=
 =?us-ascii?Q?eK8ihIx1lqp/TI8epIOMsvJgGjg/+oHDyeuIjJL3qegeHpHeD6cq6T2m20xo?=
 =?us-ascii?Q?7RI0bC+FHo4PpeB8Q1J6RLIbsg/BYjBFiPuM13TgenOGQJKC443AlEDQyJzb?=
 =?us-ascii?Q?M1BgcEt6FJGMD3bwa9Xst7MXVMNOTZRgB5Ega2NEAQoVAhAN4YSaWiVObQVU?=
 =?us-ascii?Q?vmK4NNxAefkmMdP7g4hQekf5iklOdnFyLM+eKIjlIYwl+UorWRupgX9x5h69?=
 =?us-ascii?Q?mL+TvtDTt0FDYADw5pXYfJDHiprDWZnNZiqNqPmj+TU2aJK+mu2pSPVJynhS?=
 =?us-ascii?Q?jwlH5/p8GYsQtM2aKelnrV+Ey5vBoPtx8XjuNA1qFrlEn6jgx3CXWyD1pJ7C?=
 =?us-ascii?Q?+orK0VWTuSDz7ZT2mRiJCM/D1El8yGYo2OFjKapJ0WZ5bViKklu7E42RS1vj?=
 =?us-ascii?Q?HhL+t5R+NAXOggd3FdpfKhkBjaaSnFqbNs/oomkdOBU1PZpLPFqFSmREpaor?=
 =?us-ascii?Q?7Y7EFlkDvFdMQRTTsmYrDECBJhALlEugi7Fu5DB4pNZWOv5T73LVGDSWhOVD?=
 =?us-ascii?Q?RWl/j4TKWFsXfiNC4EKio8nOE3mxKUo+sA/gzu9CA0AQNFscHEGSnFJu/rSp?=
 =?us-ascii?Q?PvxOeLlwihv/GVk9QLlUKjpWT64I3u/O2F7UabFjS+IowjBMYLlyvMMxHNLG?=
 =?us-ascii?Q?uGb6la0tqUv+BkLzDuRRVnLDnYTZIJw4HK5U7fBd62S+PaKU5YvaxLSuVUAA?=
 =?us-ascii?Q?aKMio4cqtw9vma8OxUV7f2P4iUIqdeGka2CvDx+VQtSxDQEX92wAdMI7gz0R?=
 =?us-ascii?Q?RQA3uiuu0DK7O0/T5GiA9r5o4eGxcv2v8/9LKQUEUvXt/BSm3hYX9XI3rJQv?=
 =?us-ascii?Q?vIsPryQ87tQT3vGicCqPxRl201F/99PMfUQaR2nm6pMVI0Aql2nt89Le9VF+?=
 =?us-ascii?Q?qcS29DT7Hlq7Pcl62YszBlB2sad4flX7FKWVgj6g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43917c05-1c57-4d73-aff5-08db8be74718
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:45.2028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLihSpWZG39BZ33nfWtBw59c7qoA9JR/K3NlTnO7mUQ79HkSuJ0T2f4hJayBxZly5s5myrBOkoRJr0U0m1oNJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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

