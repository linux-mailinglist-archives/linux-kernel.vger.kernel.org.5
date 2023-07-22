Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6399075DC84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjGVM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGVM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:27:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DC6E74
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pc5zN7OaBIMNSqcUqOvwy1+KW20VROA1vAOHT8Vb1cm2mz9mzXfwcm5VEAK77icGStWsjWLRUZMSEjELzhXGiLSLMpDxy/yZF1CMu1BF4+lmrbMd5bXC+jxqVNVQqKvZrPGx5kEteNOCT/Fwgfi8cSOf2UTU0zZSg5d808jJXMuLJPvI+kectfm5rOqYDvqdFcJoSGgVSHo2AmZNzzb6mTh03uP0T7prSXpmvwjIlrY6cSEYDfVbfkBXe8+JwsKksAg6Cvz52kden8CYAIg6X+Iu4Dwyf03FR4fuotTAwVmfibA3nKxVMHyHTgjXIFgdq6OZeaoKLicGAQDa91Rxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usntcsf9jSPDXtSzDmufPBCJAQO95nl0cPYHpk6bmPs=;
 b=ARu1rgc9Jo7MXqx4F3oIyPauPWdk3/T/F5emFQQtckhiyNCRkEkIQ71tT8ul+q9/EL3c1x6l9ufHiNuA/M0G40LoQkfMyZsACzdH2FMJRc6Ys7bMcItFwARt7UcvWTiwKAI4icnsHYsZFPST5goi9iy0P3UleRZJiGCIySxDgycjhBv0ujaQpR8nOBSzHh6Nn08WV3V9v9ccedo7ENpOHdH9oVVXq6HFJdthpr9CceT6HZsjubKaLu/rZitUP/FrCBpU6JOVhvhquLV6z0gxACNCV7SNDuJ4oRFj3K5TKQqbntVkKkE4uPPPcz06QF9D6k7Pn/531PF+WuKwSf692g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usntcsf9jSPDXtSzDmufPBCJAQO95nl0cPYHpk6bmPs=;
 b=Kflfshuj0X8Wi2r/0vrko8DtGbZDDdrtcYRedoQjd4Fq7Z4+Vrxu7kczoDrdsmzl46v7CgD18s5NSBMaryMOvjTVyth+sIdiT5mZWwGe37zjOaEL9zNLlLg//HlMrg6+SDtqmWZxzfO1Zmun4iQrR6Xkv1MDJFRunR2hL/iMzBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
Date:   Sat, 22 Jul 2023 20:31:17 +0800
Message-Id: <20230722123119.1966998-7-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bacb19be-be09-480d-9a30-08db8aaef089
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCch5sxdL6Q0/UZ8RC3xIKwbSb2+PxXRzXfaBSnZ3j/Hxg6BQC9OPLh7bj9vUTdo5r8/Xow0U2mxxIWQoxn7A0GxWslBt88WHl9/gXH77vRrHnp1ANoOFF6LIQwHvu0Tk6ONWVJpu0Aa+bMiR+gT+/BTvYz7qI4OqkEXH/59glcOM2iosQzQtJat0yQTHE8ezALld9baMqT1NltS7VHpA6x2BkBL+fpP/SQXlcLVtDf0tHDoOKgF2IKyZylLk9tTKnIQfJ9FilQa0lwR7rodwJ4+byid9H3rPqXEd5RVgINf4u2SxMy0z1Zz5ueN3BQENPBBtaUf+mpHKfKpjNnUqUKDnwFNL1XLBGVRIlFLcCAnDEQ2eLiKK2CkO+BliMiiqatn8TFP5u7/aIAk0PHGFzV/M1iimVLuSQmwsH8uLO9/CO1oTEYfxfHiofYNnfRX/1L/fgHMN3Ky8SBncwpCB1/zfcjz8oCSBnp6JwNvsXLFTeDitgMmLRLX2cuPS/3nZpUIra4997fsjKWCQjto7p2GGVGtHz9ulVCmGVedh1PKVcEmJL1ndiSWqc8h9zwkPxjeZW6GhTbFglVuJA0r0k9ZgqgdCUNZBiiUwlTDG6y2fJSDxBtzS8bJNoDMGQbE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7G+bUOu5dybaXle4DdYeG3KZAAy2Ss5Yg/5QNmjOOSE28xfW+GAtrWBmTzY?=
 =?us-ascii?Q?c0rD594cMxPwjA1tOkGmdWIQHuAixk5Xgre4lxaYk3nYtQ+A4r+nsIbqgnqw?=
 =?us-ascii?Q?5fKyayM5OrgWJh+7SVSTTZa/HbCyhQya3qIiI9aq+DKXsmtPvWI8lbqWCUsh?=
 =?us-ascii?Q?Qh2bcX9EP2BJSVC3WNyRl3C9aXy5YzhrXnf+kXspcbWtQvEzbB1OVVnjACWT?=
 =?us-ascii?Q?Xf+bgR0hRsWGtAF9GWlm3d9Dv7GHVFNtZcmPr4FxDeFMaeEjsxxn2I6ZIcQi?=
 =?us-ascii?Q?PtgqRqye09dtv+Tx+XqNfn4l9SWU6CZWKcqO82l81Gcqd46dcA05Q0UQm/2N?=
 =?us-ascii?Q?p5GR5q1TQomoPuQ900CW1ZmQLBXozN73lw7h0BCQAJ1pjHscnG0UgHBtLGtR?=
 =?us-ascii?Q?a7IsAWG1BaXGcsr62Ebm9h3GwQc9GxS/8fHRBMHe5UexCULNgFeJX70OcVnJ?=
 =?us-ascii?Q?XX5Gg3qXHLo4eEnKXNqd8bvnnwPIzDp7xeV6hsRcAcKA+jXVU9CTz+6Jo+oI?=
 =?us-ascii?Q?SZd2Q+qiASCDkr/HS2t7e+5ZsKFdIbbWEfF2VZoU+kFiV4otNQoN+mqUNmdT?=
 =?us-ascii?Q?utZ7m0GF9VSgE4Eg2c84RnaMsYfdr6Q5gqxSvPV5eIVUZXb3hn5oC48CrSJz?=
 =?us-ascii?Q?stpo2mPwRfDu8oGRcqyLqqpY+tRO3AEuqibWvs6THs/uJDZG6F8uTSmhEquq?=
 =?us-ascii?Q?c+67ru+yGaANOUTKwAx6Lxv7uqRwAb3PhLXR922A/1smdgGAUGwMs3Y/RcUF?=
 =?us-ascii?Q?tQ3GDY0X4W6ezf9qJjRe5AabbALKlfBWis72Mek8YMkHSmtHzKNZ/s0aJuvd?=
 =?us-ascii?Q?tysx+TnVbgRiOJ4C+zLxVf9GZf0tseJgoFrcr7xWPfaJiotCPu704WAT/7Il?=
 =?us-ascii?Q?RinV2JqHbckrEI8NLvZrVsExSs+RKWySTgIRqKUTQE2rqnXlaIGMTzVQVIj+?=
 =?us-ascii?Q?ZQywZJszLMyFKHPz2WXSJeOIs5zbMrDJPz12cwEIDngdhNnI3FLyh7hjkjN4?=
 =?us-ascii?Q?H8cP0qhKqPbTzLQL9Ylu+Ss/zhYjK5M9AA1UQpy2kBbaU+QRPi+6rW/s+tkx?=
 =?us-ascii?Q?U0dCP/tEEEOXk6TOdoizE8jTG/p3fR8JaziNs/qxTrr1os6Cvlzf4ILZGHrQ?=
 =?us-ascii?Q?nIbblvSOXJwkVx457G7v6GqUowLihREzKN080KPB8mccFOLfx2L9mdwWQPjk?=
 =?us-ascii?Q?uIQlMkhhDJLj7dRuZzb3qmhglyFQies3EZJaIfKIgxmCN3/wzLrWRewsiyGY?=
 =?us-ascii?Q?EAIAQ7NGbiOStu4vettXbpc4Mzpllosxh1i1E7ci64o3HVEHzZLXNRsNO/dX?=
 =?us-ascii?Q?5ExdUdob1eyMXASCAbFk2+JAq7wAoVkSi5JGqfBaLqv6/Xwu79Uu/3dCnHpR?=
 =?us-ascii?Q?RGNLkWGRVx55NbladQsdwZ9AYVKxqI3ogRRbSLWEj4qrIWpo1DrXhq3ZPzKN?=
 =?us-ascii?Q?Ix95TCAxuFuYP1B+yLc0/PfdE/+zlT6urXYNJzWsCzlem68P1fGE/hugtYOI?=
 =?us-ascii?Q?NAZ51n8w4PwAj4prdTIps8m+ilJmSfp2qEEYbRyfnIpKkuVmhqGCxWvKdlfr?=
 =?us-ascii?Q?MEVqmeOmnHs13SUld76Sgd6gYYUfavPINVulvgDm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bacb19be-be09-480d-9a30-08db8aaef089
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:56.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi+DOHEwOZaf5Q7ux7Isbkp7lKRudC3wYvVrGmxV6EcXlLXq8+CbbLZ5lsWb9nwQKvnJUyRY8Szv/7foT8Vt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5cc63fe7e84d..08346f312c51 100644
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
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

