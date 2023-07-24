Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE075EB93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjGXGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGXGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC0E66
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIoFYXagIsjefFOPc9TUMncfL0Xi2QrirpVlXnVl8u5kxS33HT2gM8B5VyvkOmWMYI/KFShEIeZ/b6VSGmeTIUFcbY0PqS2732ChnXmXvxuTnO7AxhkA7dd+q3dFlCMwaUTMMJtx0y1i5Fj7tHgmHZcRbGJA9rhvF3KbXIHq+VLc6E0oZcYhxGLaQ63aYWi1uveHIdCL1zMvje/9ZMfe0EjgOciMNca4ZFLNUpDQYVppcIBK5VKvpIv4r24tuQkE1bQbYLufQj4z1GVqYYUmcXpquU7sIQRblhR1SpF8iQNx1DsoFDb5WV8YNSF/RWFUyuRv1Wk96sAvSk6UfEsceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GpVS0DBdtzxJ0HJlN7id8Akhzy2X00btYXvE8XYKH0=;
 b=mzH4OEubEdQVlg7C3Pe52KZM7z3a/zUb60hF1NPOL7oZMaY89WD+aiklNr4Y0Zxa6/Ky0SVzDJ1NH2oYY1J/ySHo6HZMyTjLxPUEdiQnAvNVqMT5Qv676U9/V6Zpxu8o1objMV1aX8Tah98cSv0tbSJ/1QoltPeIjOFNk4rtVnWRBlHl2cidKjEBoVlyRCxKmgt3kk7rL3vHGA++suELU01Wr63p5MAh7bHreAJvOIHGaAvkbN3uVJi+v3X1xzrRXsJPcTfF8HbsMXT1FpqIOJBa9yK0dKyLT247WsoO3cMkXIYnMUPaKnBzpsn2srnDYdkfVlHbSteSlPJ9S9sHGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GpVS0DBdtzxJ0HJlN7id8Akhzy2X00btYXvE8XYKH0=;
 b=mROSN7vwW+OjxF8TGyHSA8OXwpSlBE8HwNWJnrKzAw0mqw6dvmH7kDdjl9VogukpFlBtw31n3ZDYZ0idVb5ELsH3y7m6pT5xQX8DKtGs4WaT9/l3cXePOWOJhVdMAwxuLspOJWZXfkdgqt8gNmiRFpk1+aDws/A2FEfOQvB7JOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
Date:   Mon, 24 Jul 2023 14:38:50 +0800
Message-Id: <20230724063852.2666930-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 912eb343-32b1-4860-60c1-08db8c1006f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnoGGIQSiiEbaMtovxIwyMgR843mw+t5Zza1MVBzc/0m23XlX1l23Ty/6JzKj4pB+a9Rdo145KIArLcbLIzeHuBD6nsKSttEfvhI43dQiQuYpAKkH0WeIDFeIqhIgzW2yCFscaXzqCyiRlrYSCR9YYgcR3BrHFMJpCc6+LXCMVk0OMWCO/LnCrh7L4iokcDo8mk6FjKxNnOIdLeClPXSewvSfmoCDOQ1sN3NqBSrIUDrIyMmepcaybxFpZsk3qgJ3vg2xdyuF/Pm+PxxkzwebNyKHVNLWjeI9tGfEu0tAQU64yiaLvISSRZlqqi8IoHn8yPe/8AFtwdaANaGV3Z7pmN+h8TuZb6x+UPrm8FrLl3W5sOKV/mlVxweylLgYumP9LWzr5u1kZHZoRWYujXD7wC6SRSDOw+1WSgsFS6eQ1r4LE5tyVOWzreoMFENxEOeqZe6CpJu7KcnYki3I3GlAPb3uFP/K6+6KqIA/+k3kCxnKkSIfGd7qwYui7Wy0YQfkz1O5oJnTK/kgs61oGHZpdJCBsdyDqa0ITDdHgqH+qziAeh5w5SNRKmsbQbFcwUWsO0S4Ih/BbXbENyZJcI1VzsX7SishYbp/MklK99qhhA7GypK2rgtweRYgwePMTST
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwXvnl9X/FPcwRS4YiNJ2Vb0vYRyLN59UwPKqcueTooBG4IKn0ttws6wBV7e?=
 =?us-ascii?Q?fWHD0mBNJZe97QeHX2PHppPfDPEw9/UGi2dq7tdpR12iLqiNogVCAZT/R3RF?=
 =?us-ascii?Q?PslywtGkHMcvylRR9MtFOqEWGH4D+eXrLorNldx+xgDJ4E/B/Zxs8MLK1RlS?=
 =?us-ascii?Q?+fw7M8Ywoq8Sg9EOiZIYQE8wFG9J5abyiSPiFmOFP/aOctS3uwketob0pqCF?=
 =?us-ascii?Q?ou7HwtETSopZaX3smhh7mQbWzVmHaDR1YtCM5HC0rFDI7YfA34EqcuQzDqhT?=
 =?us-ascii?Q?e4j6pX78zQZ1FCjaut6/uvA5HtROYwmorrL7bMiFUsGeJbk+1C5NI/Tf512j?=
 =?us-ascii?Q?b2TdzfjjTcuz9tEb8sKWVfYWE4JaQ/x4D9eUedMJQCFFOgsjhNpkULA7BWC0?=
 =?us-ascii?Q?B8iDDTtrDi74maB0lSQyXyK3P273vhEM5pKsB/Cz1rGTmT/fT8qeeQJL40Ks?=
 =?us-ascii?Q?5H1PPrBT6aPKAuC7Fvxoz9rfpVjkk1ObexKBGriMyOtuUR7SlCdUhv0N2TjA?=
 =?us-ascii?Q?ZVyDxiWUmxNbHGmOE+WLOaXXtRcTCPiHeqJusrA6xa5HFIXSS4AFAurEeD3K?=
 =?us-ascii?Q?leXXdfEBGi4rJTqfTSJMR4m1tUM98DKLEle2GNzlhZheuYuvoM55aq8W2FR6?=
 =?us-ascii?Q?Gi53A7pzvvSYgXfZO9eX3ggbRni65BB+YbW6BIqv/hCXkrMO3aZIxaWzTT+l?=
 =?us-ascii?Q?NImFwgdNWMJvWSA7n922iwnv30Qhe6tRQZ2hSSltps03SZCsDAdBC5e7/ESB?=
 =?us-ascii?Q?JOdgq/k2Jtn/Fc610ofmdMAP5jkC6Z+E8gsp7JlzINJkbt8KLqAQ5TWPzqbK?=
 =?us-ascii?Q?xiZYIDgWzinjdAVS/WUVUAosaxy3HmcBli/a/g9ASstlidhUrRZCQyQ6oKxP?=
 =?us-ascii?Q?oNipLBmuK683F5vvf87mBGwzeLss9GPlZtT8UnooDG41sQKij0kUYaePdiXr?=
 =?us-ascii?Q?yUWSR/finmcw12ds+vdPZV8M9axzxexojsSMfzrB6L7mxkuTagP/7y1rNNkS?=
 =?us-ascii?Q?mmNGD14aocJ+77jkbFDQwuMTr+EN8UJ0P1wtb/UAmXsW5CJZDgoJdmUFfWoQ?=
 =?us-ascii?Q?/u+86/mXujqLQzqKr7ImAkHIaftgcI3RlRuNVw7qhNE6UqvRbygcDEgTcsDl?=
 =?us-ascii?Q?8/Cmj45WJ936Un6DQ/la3UQyCyURYj0n+cD+1RltvV4/XpKVq+HmqNk91tBa?=
 =?us-ascii?Q?G/6YQGmJqVrB43g7HVHFa5Ku00zK3iEwZ4QQH0cXmFw3nMB9FLYCsSiDaBJn?=
 =?us-ascii?Q?7JQ/PgpW1Ara3bMHCK1OUe3wmHdGCJYR4G7mRmUxR9N7Mpn7yEKhhwJTv+ER?=
 =?us-ascii?Q?p52k8CnpCpwX9iqvhS09QCY3LluIoahHuluTrfI4LZNv4h2k9frESSPlOcfn?=
 =?us-ascii?Q?R+/b3RdbqQRT9JyNPqtMbvU+PvpqIHT88Evn9+E87z67GXSV7wOZvcINl8c3?=
 =?us-ascii?Q?Jwd8Oq/L2PbbjTYpwSHks5cwWnzI24MPziv0lWXIFYiA8NTScHCpedAwb/Cd?=
 =?us-ascii?Q?sL+uxafI74HGfTcdH2wy9Pj5lU1lzu88XLQKrjgvFK4vrdy084kpJ1gi7Qn7?=
 =?us-ascii?Q?r475deGLCt7CFrNwmiR0u0VQW1laFKGq8UmMzdMy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912eb343-32b1-4860-60c1-08db8c1006f0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:26.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YggvQKjNpMISh98G1N10Ix9LDzZ4NBiXgLK/XA4EYzs0/Wa++A6kI7Q5LuErTzCJXwT/kCPswbYkIMSEziEEXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Cleanup code to export imx_scu_irq_get_status API to make it could
be used by others, such as SECO.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 40 ++++++++++++++++++++----------
 include/linux/firmware/imx/sci.h   |  6 +++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 4408f150b3d5..6549f3792a0f 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2019 NXP
+ * Copyright 2019,2023 NXP
  *
  * Implementation of the SCU IRQ functions using MU.
  *
@@ -66,29 +66,18 @@ static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 
 static void imx_scu_irq_work_handler(struct work_struct *work)
 {
-	struct imx_sc_msg_irq_get_status msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	u32 irq_status;
 	int ret;
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
-		hdr->ver = IMX_SC_RPC_VERSION;
-		hdr->svc = IMX_SC_RPC_SVC_IRQ;
-		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
-		hdr->size = 2;
-
-		msg.data.req.resource = mu_resource_id;
-		msg.data.req.group = i;
-
-		ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
 			pr_err("get irq group %d status failed, ret %d\n",
 			       i, ret);
 			return;
 		}
 
-		irq_status = msg.data.resp.status;
 		if (!irq_status)
 			continue;
 
@@ -97,6 +86,31 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	}
 }
 
+int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_IRQ;
+	hdr->func = IMX_SC_IRQ_FUNC_STATUS;
+	hdr->size = 2;
+
+	msg.data.req.resource = mu_resource_id;
+	msg.data.req.group = group;
+
+	ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	if (irq_status)
+		*irq_status = msg.data.resp.status;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_irq_get_status);
+
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	struct imx_sc_msg_irq_enable msg;
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 5cc63fe7e84d..47adb9f4d90b 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -21,6 +21,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 int imx_scu_soc_init(struct device *dev);
 #else
 static inline int imx_scu_soc_init(struct device *dev)
@@ -47,5 +48,10 @@ static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	return -ENOTSUPP;
 }
+
+static inline int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

