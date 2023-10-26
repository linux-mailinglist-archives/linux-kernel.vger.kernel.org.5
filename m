Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B09F7D7B50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 05:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJZDhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 23:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 23:37:06 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93C189;
        Wed, 25 Oct 2023 20:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BC/T854k1V0RZtNn5Thvwnu57/qPBtu0YuM7LHMRQo/X09HodDI1XNckD+oO9CEyKDnJ3vVeWcApITYyUNWM4ZETpPodI+MjKC+9ABZA5uwgA4E1ReeXaoWdgsqaMG+3O5tV1CSCNxnOZonIBgC/FqqMSzQ7XbZw2eGKVFe1K+zxkkY8HtdceJNZSeIgyBcCf8Ntu/9PSCWGATcrZMkivgs9aGXuuGk52YYq//uoesBS6dzsRcRTK6T+8+Fc1DLaf8kdOW/U8wFwHH+QaBYJsivReVLojVJ/1x0gUlgAWU/hWjpmyYYHhYK/C4IlNqOaQfHuiCXu872sjH2pRZxR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCzTvmbzfNIJCFVKxtysESVirhnlWl3Ik2F25wwpaww=;
 b=UmHxoloyJVM/158h7ahHzpfxElzxIx1s1kCk6CiYz7Bjt20K6Am7sYaaH4GSTIy0d6UwU8ldhB16MoljdqeUikpXv6Xv54GWtaUbbR6bJTwH57jARq12xRLP5cckvLu8X0LSzsW8ANPI6uO5vta5bj09Hy8WBxwrAZXySfiwcky2t8zrVB49x5g2wj6SWLbnXQSjmorv6ezwRMFSZOnzRZLjgaRkT4nhmpenMhpizVcnk6EaeFdpnl9y8kSK0OZuPevuU/V+0N6zxivZLoXompu26WhE5ik93DHouaUrawcBek+m4Grm3SiUCpoiL1CN5doR2dNIUigSXR0wpMSaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCzTvmbzfNIJCFVKxtysESVirhnlWl3Ik2F25wwpaww=;
 b=MDEsScN5LHeD9dZ/oBZL9WqjNgONl48k3SWdij/jF+n0XOgRHeyGzjZBj8gsPmcc8k5EmrzFqhqIMxP/+j2h3qdbFrp9l4OnPkVf6d0OWYUDpgZ2xmR8jb8eu0m+N2XDyBa4Y12mA2xo5iK5JDk8y5WGY2a3Ae6WWuYwtDtJcZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Thu, 26 Oct
 2023 03:37:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Thu, 26 Oct 2023
 03:37:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ranjani.vaidyanathan@nxp.com,
        glen.wienecke@nxp.com, nitin.garg@nxp.com, chuck.cannon@nxp.com,
        sboyd@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [RFC] firmware: arm_scmi: support clock denied attributes
Date:   Thu, 26 Oct 2023 11:41:25 +0800
Message-Id: <20231026034125.1823954-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 30768488-46c6-4ab9-c14e-08dbd5d4cfb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWVoqDYjYCxLMBizUazCSu8pUH6EEibWCYhxj8uwjG0sGxLjGLV9AaVIISBvp1xmFwWb+9oodBS5WL6PCCWppVxaUyo3YmWB+Fu9FN0YoGm78br40pxjSR+PYt7ku4S8n4aaIzln1Ex/DB68csMlYiwOf73JWIOMDaUpSKSw7JhAtXyazUOuLzHDRCOzE8HNyM/ndRx3azWrJkp2ALPOpWCPvoU4JSb4NugNXXBzZwtSQ0FIZkMxdX11UfMc2hwBkva+zcEIcVX931FLqcwrLGLry9e8qq8Ofemfo8FQT1N6tBx38/f6UhtjoiCoTrDbTPacfJmb+CPhtN4MeKAmdiuNV0k0fGLPajp7PT0crtFYmg4YwXAIMFKcGPwmD3UGThmj967OrmqdD4P7i3nVc1uV8A7S+umlfgo/dFraYdK4ypIMKfTyE+zKlU7ZaMG9Pvvhkt/HHOXvpbhx6tZS7PIeQVu+okI2o4f9BQ80qg5M7GIksdSh0qDbnGgpLlAQ1C678nJTzwQp3k8BuVCDeIJ+mKfu6yK6mYhg0tFYXwBIwH7PovrnqxAyukn/nFx7bbOP7O678KQx3D6j8l+4nHFbd0B88aPo1id/F7YJ0OsEsx7+ODjyAA5iCyJtU+yw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38350700005)(83380400001)(66556008)(86362001)(316002)(38100700002)(66946007)(66476007)(2616005)(8936002)(52116002)(2906002)(26005)(6512007)(1076003)(6666004)(478600001)(6486002)(5660300002)(41300700001)(8676002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4MG0ywf6JpbA12JY/e8BbkAkRc2N1fz1g3e8t8iCxfw6CxN/i1vIj0Yinp+?=
 =?us-ascii?Q?Wua8jLbFGXCLt6pYAubp7VWFKTPaEUypUGjBtoLjktPOIiBz4wpz+azCilrp?=
 =?us-ascii?Q?Hfvo9os3THfPqfhtbLW4vIrKebstwmaTnPK5BF68i5d9xUg8y+BaEi+WOENy?=
 =?us-ascii?Q?WgQjNO8HMpNuA48v7cien13N4M0Oim7Z7rYyGFbPMpQklPx9NeX4btSPpKwB?=
 =?us-ascii?Q?i6i34Pe2AyOn00ZXzjn7p1xp/p4uR3pyvEgx+tECX+yYzrwqHs5ngIDFDm82?=
 =?us-ascii?Q?HSz3kfRJfbXRYeSZ9lx1g8FCyBv/ft2EOpDaXII/IpO77eiIYbUytUeRYfGD?=
 =?us-ascii?Q?Q/755OkgKOGs+99z+dSgmTQq+dO9xqzEO8bcKwNuxlxgCGymBUntZmOPKkCl?=
 =?us-ascii?Q?kEx3BsdwHYywLlvmN8N0F64PGgtRWV4PEuQIRb6cXRXLaSmz1Io8ztJ9wzYm?=
 =?us-ascii?Q?Q7W9Fwqd0EE0EQlriU/aqTR3LIo45WT0noY4Sc3KWez5guTB2OOV1WUc1nos?=
 =?us-ascii?Q?fvxgCP3eDl2yYmCPdt2bA3iPwoyepCz1f7U+mza+Os0Xj4ZLZZNULsqaOgwK?=
 =?us-ascii?Q?TO7jenKlbj55SeXNdHZILQ0OQogbTGarafOZ+E3/K7tS9l4k5YiowIasn1Um?=
 =?us-ascii?Q?27Kj67whX602V+8qmhxFp2vqRAOxjvKkzgmYBis5TiKOYMQyNwY8ooMwDWtJ?=
 =?us-ascii?Q?Bbfy7VoPjWjaqo9TN+stnzw77m3N0CwSd8riYyG9tuwgaqx2O8/ocbhCNqFE?=
 =?us-ascii?Q?O7v01Q/LVGnjz9EVwgWPMXn8M1p0ceeeAlfM1QKtPrHs1qqkfEZH3lk9ENtp?=
 =?us-ascii?Q?jYJjNDeTqk066sC1/KNHXSwt9JMjL42OwlYd2FD5CQaRqLyxAmY0eQYeXFB3?=
 =?us-ascii?Q?Tk53e3m9iE7coBWZ57ujIK5M2jDHjwcittfi4bnKQSiRFrF+cZyvQozRQxvc?=
 =?us-ascii?Q?lsz16C+Mhau7U9RRrGNCPtMvLcIdn60t9pa13pWCXCdlWh0DWT+e5QZIgj1i?=
 =?us-ascii?Q?OvG0hMBexWIYwQenxIF/FC7DRkI7fdS47PhRe9Q4bGc8wlqt2EHzT0nIZObW?=
 =?us-ascii?Q?tHFKU+y9FVqZWQ1brRClS/qfLUt7qfveBglkwKTjpB83LJSeXJVJRL6bZs2O?=
 =?us-ascii?Q?nzt3l8r+jBnrow3Uk56iRB9MafaLAjtX/VWJOKnPvA6FwANoMEuX4089Yvn8?=
 =?us-ascii?Q?yqI7tQop3tKqk/hrzrViY/h6iQSOM7iJo53I0w02kdH/XVffqORhiuj7m6fB?=
 =?us-ascii?Q?q0gRNAlOBMqBggtOeKC6DQ4qPlstgZzPEK/Y+DBgBPrAxzzt7Oe5EFbR82VY?=
 =?us-ascii?Q?9HwylaJON5NGhJ9JIUxeNfD8fa8JU0DC9JAoDxZlstPtkGPdMdp/bvfDb5u0?=
 =?us-ascii?Q?hLGvz0uqwVsHlxCmN5P+eSmdU20h8TyBSb+kIa4hgt627GrT851yJFhzNpZo?=
 =?us-ascii?Q?EE+q5VHRLxrD3GH2kUWX1jdPQVLEzaLzSFDBU+ZcsQr6t49GJa2ZwBBoOb7Y?=
 =?us-ascii?Q?0Fu5rQ8yypj0ByzwuHbb6CeLGxA5nYMawQI/50qoEjW8Qqx2Tyh1KLAz0bWy?=
 =?us-ascii?Q?fytstwJobtTGzrvg7JuyNmDV/LfuJRDk3NxrcOM7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30768488-46c6-4ab9-c14e-08dbd5d4cfb2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 03:37:00.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQDp3bPIPTDHnfD5k4Q7f4YMQXIoLYs0OOiJShYkCgtN6Kohe5QxyZ1pvJDwcDYZIxxjt2f55DJTRJ1zhju8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is not in SPEC and is just defined by NXP. This patch is
to start the discussion to start include them in SPEC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c            | 39 +++++++++++++++++++++++++------
 drivers/firmware/arm_scmi/clock.c |  9 +++++++
 include/linux/scmi_protocol.h     |  4 ++++
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 8cbe24789c24..303f8a8ec8e0 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -75,15 +75,13 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 			     unsigned long parent_rate)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+	u64 rate1 = 0;
 
-	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
-}
-
-static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
-{
-	struct scmi_clk *clk = to_scmi_clk(hw);
+	if (info->flags & SCMI_CLOCK_SET_RATE_DENIED)
+		return -EACCES;
 
-	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
+	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
 }
 
 static u8 scmi_clk_get_parent(struct clk_hw *hw)
@@ -107,6 +105,17 @@ static u8 scmi_clk_get_parent(struct clk_hw *hw)
 	return p_idx;
 }
 
+static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+
+	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return -EACCES;
+
+	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
+}
+
 static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	/*
@@ -119,6 +128,10 @@ static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *r
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+
+	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return 0;
 
 	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
 }
@@ -126,6 +139,10 @@ static int scmi_clk_enable(struct clk_hw *hw)
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+
+	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return;
 
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);
 }
@@ -133,6 +150,10 @@ static void scmi_clk_disable(struct clk_hw *hw)
 static int scmi_clk_atomic_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+
+	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return 0;
 
 	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
 }
@@ -140,6 +161,10 @@ static int scmi_clk_atomic_enable(struct clk_hw *hw)
 static void scmi_clk_atomic_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
+	const struct scmi_clock_info *info = clk->info;
+
+	if (info->flags & SCMI_CLOCK_SET_ENABLE_DENIED)
+		return;
 
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
 }
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 42b81c181d68..1a62e3b82d34 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -46,6 +46,9 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SETS_ENABLE_DENIED(x)			((x) & BIT(15))
+#define SETS_RATE_DENIED(x)			((x) & BIT(14))
+#define SETS_PARENT_DENIED(x)			((x) & BIT(13))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -327,6 +330,12 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
+		if (SETS_PARENT_DENIED(attributes))
+			clk->flags |= SCMI_CLOCK_SET_PARENT_DENIED;
+		if (SETS_RATE_DENIED(attributes))
+			clk->flags |= SCMI_CLOCK_SET_RATE_DENIED;
+		if (SETS_ENABLE_DENIED(attributes))
+			clk->flags |= SCMI_CLOCK_SET_ENABLE_DENIED;
 	}
 
 	return ret;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..71911dcd8117 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -41,12 +41,16 @@ struct scmi_revision_info {
 	char sub_vendor_id[SCMI_SHORT_NAME_MAX_SIZE];
 };
 
+#define SCMI_CLOCK_SET_PARENT_DENIED	BIT(13)
+#define SCMI_CLOCK_SET_RATE_DENIED	BIT(14)
+#define SCMI_CLOCK_SET_ENABLE_DENIED	BIT(15)
 struct scmi_clock_info {
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int enable_latency;
 	bool rate_discrete;
 	bool rate_changed_notifications;
 	bool rate_change_requested_notifications;
+	unsigned int flags;
 	union {
 		struct {
 			int num_rates;
-- 
2.37.1

