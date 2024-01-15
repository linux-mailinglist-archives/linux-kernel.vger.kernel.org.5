Return-Path: <linux-kernel+bounces-25645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDCC82D404
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE6C281E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8C2568;
	Mon, 15 Jan 2024 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wmk3StbS"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998F923BE;
	Mon, 15 Jan 2024 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO0YmcVnylHSIyuFpdLL+Ti6/zhY9xdtf7AtzBDacMAmYqXWaX3HBP0m/4gKSTrG/u0JKPaU5s/pxFe9X53wcIKIj3nD5f2dPq3p42LgPWgkIvxf/pa0AeFJHlwEg8/edVwEFWNpCX2Bry72FXeVLR3rVPzpoF59jMOK7pDKF4bq+o0+0abAwR7w40g6HKJlP4dONINYt9+7IsiJqV4Rxdbg2Tb6lYwSIn3fQjJjjY+tWsQjyR6LELBwQI3x4o+WvUqCIS523VGPeqVDc8QCyEzK3UHrOA+2xb8jQ1NbHDJHlPe9l6pVkWMWfDhWd+x4zGw8PE6mSuA/mYajeopGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhna6nQS1Fwdad1EOQK3HDN07T4suKZDgJQXMRxBBBs=;
 b=khDXV5RLa+FBhx2d/Mo8us+Y7KY8T8oBn5nH3FaxRTdiUpBB1QYffSZiTK/73BpANLnEWEEnzX+BIiYHlYs3hcWup3UkdaicehdVl3rJ6+HS85+8CwnRVyEE016DjaMVZkH8DL3s6MnncC23/GBkap7WJnuLktGpG/em8uw1XUXlxFvIGIErOecnvw8OYg1BsNAObg/dz3gTK+JR8muSJAlU/JbX/52cvgWta0Jz/GtKMKDjJRoyv7Mtm2QXl25UE3dVTwVoUEvLT4Q8e0e2Yi5RSYbgjzrpLKvnjgix5hWbkMubVuZl0ImWN1WDhfwKnF6gUHdjX1ADvIjtR1fc4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhna6nQS1Fwdad1EOQK3HDN07T4suKZDgJQXMRxBBBs=;
 b=Wmk3StbSnSzTgP6Lok6HcKVm0obI7sqRrGf6WYpGxJm9zq2dVtiEJEOJVEdYCVOsc9MDLQPaLNNZ4I/OKU1fb2nNUYhQdw6wWVelHkqS/KakisfttSnGtSL64cIAJNDesNlUqunCGjCVBonT6zmVi1wh0UX+JlelIoeLQwWbNz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 05:57:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7181.022; Mon, 15 Jan 2024
 05:57:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] firmware: arm_scmi: Implement Clock get permissions
Date: Mon, 15 Jan 2024 14:02:02 +0800
Message-Id: <20240115060203.813168-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb91b8f-91ed-4df6-ab72-08dc158ee7c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U6mH3rGOAlzp00S14dgRpCJNhO+71EIRz8MZSphwoleg83FKO4Z1fHl2717US/XU/t7HuguU8VMKCR0gg+EYvc0Bh6KpAggtFdYEx8q/FMSi6PmrIqzKQh78Utf+Ifejk+sO5M2mW5used8KuAm5Ye5ZR9lBwX+0pOuVYSjvdPgyZsHMj8d3mlYm3UEcyOFc6nvvPd9SzLWXpTh1LCiKSxueyV3rz5m8sfeFiOfAUiEghIpGGa2tBmYaofKdgGSFsJLwBUGKMAD0gCzHl2fpE+fSIteJr7aqPqaOvyXLLyZ5dYEV226MBIE+1Qu3fns7pj0oKVVjMtMmFArcLSPWbnXskJO0MDb3uU1+A0ZahDzPz7HyBxhZzzbXMGY/BGArsKv87JDzAPvz8o1KsAVSinphzlUoyOZoU/Bg/DFEyqy9nwsafbqlnkrOmEaspltcoArrnzCeoTmbLqhUUdQgcekJ6mneRSXs+eI+ejqCKUy2QlgMjPImDP2jGm0iQ79Ji9Der0vgJtniRNZBXdfSnfPEZQ7V9gCVm9k3sBXy2iUwhjXcAHbk34FYeWH6/atOsFN+KqZLxgORwbHqOw5jF4ayaNPcAR9A+QQUrOo0UnxXJE1XIQfmPR98GbS5vaTeBcpriDt4mcTOQ19QQQSibw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(2616005)(1076003)(26005)(86362001)(83380400001)(38100700002)(52116002)(6512007)(6666004)(66946007)(66556008)(66476007)(316002)(5660300002)(8676002)(4326008)(8936002)(2906002)(6506007)(966005)(6486002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mlPcemFOnJJb3duf6CgDf4dNLouPVDdUdxrH7eXaCYNMKB2RJvu8bE7Ge7L/?=
 =?us-ascii?Q?cRFZnW3na9a5IrOEzn3xY13Shzd1U3cJIKyo8JnMG9PJy1q1E4x7j/awWYrl?=
 =?us-ascii?Q?gg7DXQPMOn3Pdy4agkYxWhXNG48YbcjOM9yDPbjC7145ztb7lRP9VDeM8ux5?=
 =?us-ascii?Q?f/SD95qU2wa3JzNBc7RcnaNPag6Yla+HNTuCucrwnNgtbHShFg1G3jWK+Eip?=
 =?us-ascii?Q?2/Xldal0xgGYnNwdTJTqm9c6MVa6FgHFjJIGa8E048ABQf7+hG1i900HkSn5?=
 =?us-ascii?Q?zBD1XH47tZnkbgS1WpfNdUz/EMvaqd7Muy2MAQ737hebpGVBgC6juDfaP+Ed?=
 =?us-ascii?Q?NdkTFHNqa1HvKsyZiHY8HxaZqnjH5iQaFZ4l6hSg4ZcUv+InxALjE5rwKxBP?=
 =?us-ascii?Q?25l5RgnXWQYhX2+1/D3fTVVvn53RD4tSjvLeI95lO7muimjN0r5yfV1anqJk?=
 =?us-ascii?Q?Q5PhVu7DLr/pQo37/UCGcy2EH4Pyzz0/XE2iHSYwNPsU0lPvw6rVKVuZCdIG?=
 =?us-ascii?Q?UO3maJiVKda81YL7KW3ywWFY/THVNMF1Ynxzv964ZeUEtSjrqakVtab6NXqN?=
 =?us-ascii?Q?Xll2QGVpBR8pjCOVGoFIiYnOWnF1qfzJzVT+KS3ETmCWRO4UGl83pwsQ0GYE?=
 =?us-ascii?Q?FkW+jrpEodWQBMXA6QT1W9+7N/yGNh07RIHfHNbA5Pu9lkdWdvjHLyjdg56v?=
 =?us-ascii?Q?WZzQV5qUROPtawckWrSj3/EU8jLHEUUjC3G8nPXrd38AroDxQCIH/NyT/xry?=
 =?us-ascii?Q?EKMbBW8UntFo4+PAaKZLu6W18XHk0eMitZHMSeRwUIU3BBOeCu8rKfa2/Q82?=
 =?us-ascii?Q?vVAv7w+c7z3DqfvNjcpHuO9Cw4b7pOsfAHHqVFvnf0u0MzO+3Z+yovwMHJMx?=
 =?us-ascii?Q?5s60u7PoPab1tqMFwIYVZPLEmFYlKbq8z3Zjsfv0PvbbN3lbqfUzXBxguToE?=
 =?us-ascii?Q?hcGWIRsHiFLJdZZowLTqn8H3jVj52iMPel5jq9Z6SXMZSMn7R4CdyFqYHfs8?=
 =?us-ascii?Q?mjFOweL1uMMKwozUZxZRnIFTEQKfeW2FM0F86FTONNnWFZXw00nxyiX7mG7C?=
 =?us-ascii?Q?6XndohvevliHgWEadOqAGNRyYK6pYGIkzmxHgISjBgkJIWxDEsSc0IwG/abZ?=
 =?us-ascii?Q?sdHaQuSAnG9+njGow1rKqA/SAy6uIr8RACDT7+QB77L3y8Do2iYGV21djInL?=
 =?us-ascii?Q?dqCHE+eTonRv78Ftkmj8CTmjaSBBpe2yQIrKGop2T+K+m5mcS2pHmIThesbI?=
 =?us-ascii?Q?Mjtx/00IoH8wbT7TXYrlP3LICLsUCoqF14p5QE/XMFBEaj54L/PiRLiaVZwf?=
 =?us-ascii?Q?imfD4ZNCW3P17n9vE+7RGHursXH+dKmdwGwh0rn4uUrfQYhHbwrFyttrPLSB?=
 =?us-ascii?Q?iE/gjt0qqv84tf3rfMd9D5hXb/P7vNU+QzLTNxXEE5vsOaIH5p1x5+6QBCsM?=
 =?us-ascii?Q?x5an4H7wYsfvFWWhGNZIEnIEeujV/mrBTP0x8QuAM0lGSyEZRg4hHMahLqWi?=
 =?us-ascii?Q?VuKABZRPWAVOomvHBoCDyQjUzvGO1rBGmQ/lX+BJoT0ZIFbOayImhJ0xt71W?=
 =?us-ascii?Q?WA/gcEiyB6A6s0NroSRBSwLrR+n9er2WCuba/ew2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb91b8f-91ed-4df6-ab72-08dc158ee7c5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 05:57:50.0230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcRSb2tF024u0aybD9FF5ynSnR8ytmS0Hp8WMJDGdIEreGpTUK6knfTiC5XGIS8/KRe218H+SCpEJsw5+a7Q0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

From: Peng Fan <peng.fan@nxp.com>

ARM SCMI Spec 3.2 introduces Clock Get Permission command. This patch
is to add the support. Add three bool entries to scmi_clock_info to
indicate the operation is forbidden or not. If the CLOCK_GET_PERMISSIONS
command is not supported, the three bool variables will default
set to false, otherwise they will be set according to the return result
of CLOCK_GET_PERMISSIONS.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Rebased on https://lore.kernel.org/linux-arm-kernel/20240110120916.2482603-1-cristian.marussi@arm.com/
 Drop attribute which is no needed
 Use scmi_clock_domain_lookup
 Update patch subject

V2:
 Take Cristian's suggestion, https://lore.kernel.org/all/ZWiqqfQ73tezFmSk@pluto/

 drivers/firmware/arm_scmi/clock.c | 64 +++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h     |  3 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 2e4d6479a639..959e48aba1b5 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -28,8 +28,13 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
 	CLOCK_PARENT_SET = 0xD,
 	CLOCK_PARENT_GET = 0xE,
+	CLOCK_GET_PERMISSIONS = 0xF,
 };
 
+#define CLOCK_STATE_CONTROL_ALLOWED	BIT(31)
+#define CLOCK_PARENT_CONTROL_ALLOWED	BIT(30)
+#define CLOCK_RATE_CONTROL_ALLOWED	BIT(29)
+
 enum clk_state {
 	CLK_STATE_DISABLE,
 	CLK_STATE_ENABLE,
@@ -49,6 +54,7 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
 #define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
+#define SUPPORTS_GET_PERMISSIONS(x)		((x) & BIT(1))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
@@ -293,6 +299,35 @@ static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u3
 	return ret;
 }
 
+static int
+scmi_clock_get_permissions(const struct scmi_protocol_handle *ph, u32 clk_id,
+			   struct scmi_clock_info *clk)
+{
+	struct scmi_xfer *t;
+	u32 perm;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_GET_PERMISSIONS,
+				      sizeof(clk_id), sizeof(perm), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		perm = get_unaligned_le32(t->rx.buf);
+
+		clk->state_ctrl_forbidden = !(perm & CLOCK_STATE_CONTROL_ALLOWED);
+		clk->rate_ctrl_forbidden = !(perm & CLOCK_RATE_CONTROL_ALLOWED);
+		clk->parent_ctrl_forbidden = !(perm & CLOCK_PARENT_CONTROL_ALLOWED);
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -339,6 +374,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_change_requested_notifications = true;
 		if (SUPPORTS_PARENT_CLOCK(attributes))
 			scmi_clock_possible_parents(ph, clk_id, clk);
+		if (SUPPORTS_GET_PERMISSIONS(attributes))
+			scmi_clock_get_permissions(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -511,6 +548,14 @@ static int scmi_clock_rate_set(const struct scmi_protocol_handle *ph,
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->rate_ctrl_forbidden)
+		return -EACCES;
 
 	ret = ph->xops->xfer_get_init(ph, CLOCK_RATE_SET, sizeof(*cfg), 0, &t);
 	if (ret)
@@ -596,6 +641,9 @@ scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
 	if (parent_id >= clk->num_parents)
 		return -EINVAL;
 
+	if (clk->parent_ctrl_forbidden)
+		return -EACCES;
+
 	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
 				      sizeof(*cfg), 0, &t);
 	if (ret)
@@ -679,6 +727,14 @@ static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			     bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_ENABLE,
 				    NULL_OEM_TYPE, 0, atomic);
@@ -688,6 +744,14 @@ static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      bool atomic)
 {
 	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	clk = scmi_clock_domain_lookup(ci, clk_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (clk->state_ctrl_forbidden)
+		return -EACCES;
 
 	return ci->clock_config_set(ph, clk_id, CLK_STATE_DISABLE,
 				    NULL_OEM_TYPE, 0, atomic);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index f2f05fb42d28..0cc40af5519a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -47,6 +47,9 @@ struct scmi_clock_info {
 	bool rate_discrete;
 	bool rate_changed_notifications;
 	bool rate_change_requested_notifications;
+	bool state_ctrl_forbidden;
+	bool rate_ctrl_forbidden;
+	bool parent_ctrl_forbidden;
 	union {
 		struct {
 			int num_rates;
-- 
2.37.1


