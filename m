Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260077B752F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbjJCXhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjJCXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:37:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B173BAF;
        Tue,  3 Oct 2023 16:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxHkjRS8QmJCDe4f6o6vTnE77a8W5MoHNDqXPu6L7xaVo4lLLQV8RB8q/Eq4lFy7Sv5LD/9FOtC+4C40O++WSDZ0et2uISZoVFTAhoyCjVQpDwRsLS/N5UB+bfo6g8hn6ZE3BRtIKbu82F6jSZdvZOE/mrFjFS4nDk05RjCpGBn82ccHsHQFEUhpOe2Atv4NMNV3aasoPFobhYinh9KcE8rpSS/yEuf+7wyNrxC0OCm/f80tY9jc/B/bnMI+OgL092nXX6v/DePFTBb1QsqGaWs6s8p/bBensjKY2FZ+KnVPbDDXLUyFcwljOEUvnxL0J4heW70jkVWcxcpPP31VAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZwkiVt1kHf5dCHQ0xr8jc9uETCAps2NFYI3l4uDMNQ=;
 b=YrmC7RkkZA1/cbFg6uGthGegsqVuWu37yIZ2J8LiTupJ/rMVaF8Pm89jsBm+wJ7EJdgOK71cMaKYQ/vVnhrn+tb47oPYwClPdgR06mujkS9hWRtht6JHNpm/e4GkbDSrxXMoZY6d1VkUAEC/rBL2Qh/RxPTw2Ra9ALXshUyKasoEbWaoOcthWGnLLZHLPSNRtHzgyURzJtzVPdGeWz6uMSC1fdoz1+U/ujW6sx+KVgpU+ZhBp/VrMGZeSgBciTCA0saas8XiqP1weFUQqp+SlsF2l9pYzAoUoEQCopHkSXMZI6gTept5gemI2uqvMtPpUVZlsY6+Qt6Ane/kTlD/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZwkiVt1kHf5dCHQ0xr8jc9uETCAps2NFYI3l4uDMNQ=;
 b=ImocjTt9B5RfSwUG5K+o0BuN2of9mFCE62+H5GQqDlLU0y7JBPksZt5jTqICHKZRpegiWqYaJTuyy+6nNv6TAoeeapxe02T5nym/YLGOmPOOELa9AJUwVwImGflLDOc4kpDBfb9f1juspYONXr2Mp8xNYkwsnjDgFS/HMdQ2tH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:37:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 23:37:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Wed, 04 Oct 2023 07:42:24 +0800
Subject: [PATCH v5 2/2] clk: scmi: add set/get_parent support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-scmi-clock-v3-v5-2-1b8a1435673e@nxp.com>
References: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com>
In-Reply-To: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696376552; l=3625;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7BvJQbtvanJoBfjUgYdcKhXHAOMYJ6zypk9Y8ZPFLnA=;
 b=3ukrCrulkg5MHNzFKFllUZ8R8GuKsudY2vBcjf7ruk8wFxoTx75xr3LIZbaH4K/JDF7ka1FCY
 dZyOibu1pTSAw1afNjvo/Te69hu/amJ9ivCwBdID3dbacFdsMNXB9jL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab63bc0-f47c-439b-fde9-08dbc469c0d7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgcWS7XHbgwBEgZmwdRfTpIG5OSD76RV0V9AzsPDQFx6mBqDe9SjShM3i5f45Dbo6xUMhLtprh+s/xzf2sNdKUEaVBPFzVYA3SWRSCrlNB1TQYj1iyQCUaevVM0Lw9xkgON7xuo3cqm5ERn+1Y65Znvwz+PXReI7JYEUNceQA8DmX1C87OpLaRJZUiAs7sqD6jp26GJHHmf4QnHhO1ELfpJVcDUbW7BhgJVd90e7YuYlQaMaY5LgCESpjSdPkumpQ+/EUp4qhwyzONTZFk1sv9XSNj+sZKlXUQvJxoolxdEkeuYId4Ir/oiuJ5sYXfsgebuRlv2hE0T7nBa2JB5+aK/2wizK5iUUVtvlR7KFwgnUGmHT3BAN2E4ABdLZZlGbtoZX+ub1fS+Bd9zWMlyR1IrZHgh3vJpHpKs3WNVSGKCN043vLDoe8ju0hKqMTlo+hM0PQBHYt/peR0lIT5rzXbxRLhvkJO7b2c3ZqGhPrlw2fUhcBhrAbq+UaPLTYEm4MeOxpSdUlHiIB8Vm/XLBUJFwOFmjL7dqYkaM4yLFO/0hRQXHhLGEz/SBV/CZalV2zTQqPj5aTrqGA+DsM0065OriUYLco2Y2tL1B4Bi8EIDED/yzTl0pJihcHqo1iuZU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(6512007)(6666004)(6486002)(9686003)(52116002)(478600001)(83380400001)(26005)(2906002)(4326008)(110136005)(41300700001)(66946007)(66556008)(66476007)(8936002)(5660300002)(8676002)(316002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2tTNVVIMEkybHRBUHZMRnp6eENOTG5FSG1sSVY5SllEbXZ5UDBodGwwWXpT?=
 =?utf-8?B?eU5Xc1B6Q1RTYmE4Tm9ScWlpQWdUOFRQcGdTNUN5eHRGaU9xbktaQW03YVRN?=
 =?utf-8?B?VmxvYTlaN2ErdDU2dGRnZnc3am1VNitpSjVmUW9McDQ4VWRKYVVHakZDb0FE?=
 =?utf-8?B?ZFVZM1JPbXRhOE16ekpWOEVzTFFBSTBrc2FyZmU3ck00SmJEODFHRFVpK1gr?=
 =?utf-8?B?bHd3QTR6STBGcnZKd3E0cngvZTRVZEw2bythN1ZaRERzS0plb0JDWGxQWmdk?=
 =?utf-8?B?UVpEejdhUW1kSTNSVUN3SXNVUGlOMkEzOGMvZldQSUYzbENhaklvWUhDZ215?=
 =?utf-8?B?OUIvYmJoQVJWSmFONGFrQlV1L0hLWW1CQjFCUE5WcG5tMzFod3Z5UEc4cjd0?=
 =?utf-8?B?UEZmeGQ5MWFyTVJVTmlqdndoVjFhUXdGbS9TK2VTbm5tME5KUERpanVPTUxp?=
 =?utf-8?B?YWZFaERPeG1IbTljK3Z5bUtRc0pXbTI0SGpZVWczK3VOZDE3b2ZqZ0hVYXdw?=
 =?utf-8?B?NTFjV3lUUWw5aTBKUzY5U2Y4TVpSeFd1d2Q1cDNoQ2xWZWFORlFzSFp0aE9l?=
 =?utf-8?B?TVY2NmlGWGlvanM5VlhqTFFFTHM2anZLVjFpZ3ZzMDl2dk5pQVhXSkZWdzRE?=
 =?utf-8?B?TktycHRJcndiUmtKbmo1aFFEZ0w0ZkJ0d0tBL0MybXlBQThQN1QyL2JveSt0?=
 =?utf-8?B?MGVJU0tISkVpMyt0WjE2ME5DSzY4TGphUXVQeG8veHRNMThjT2E3aFo0dDBk?=
 =?utf-8?B?N28zWXNRMzR4eE1DRlJxT3A5WUNwbkdQZGVrYkcwOWZUYzY2SlE5VTFNa29O?=
 =?utf-8?B?L2M4RGNaVUxOWTF0cXAwakZza1Vyd1l6dXJqdlVSMnZyNGcwQWhjOGY3TkpO?=
 =?utf-8?B?Y2tnS1ZnVlBpS0IwSDVMSGNsZEZWdkR0LzhtMkJETjVtazdLT21GNDdqdFhG?=
 =?utf-8?B?MGFuK3hDamtrdGpVRjhUUDQvYXV1UmNucDg3eW1sWWZteVJwejVscVVpb1dU?=
 =?utf-8?B?bm1vdTdLQVRkbnl6NUtFUnJ2elJBZStEdzBUVzZINlFIRzYxU3JhV2s0R1Ax?=
 =?utf-8?B?UTJDdWdwU2xtcE1wMVZuUTl6MVZsWHBSZlNuSGRwcitja2kxeldmYk85WG01?=
 =?utf-8?B?aEQwdGlYOHBrZmRsYng1cVZDUHFaQ3VyWnFQaHFsZDV6RDhlWkV0czQrem9X?=
 =?utf-8?B?QXptVkpVVjJ6UnRmSk5BVkNDK0tBZ1dCMFpNUXE2ZWMvMWlVRm8vMWFVUG13?=
 =?utf-8?B?bklKR2hFOEU5NDhIa2pKSjhIdGFqdy9naEJjQlArRFR2QkN3VVQxUEVtcEpG?=
 =?utf-8?B?ZlZKUGhJSW9nMTg3L01tRUswdk9DdmgwVmYrelRsa0Z5TDdTcEZRb0QvZnRj?=
 =?utf-8?B?MDlsbjNnRWZmUDgyWWNmUTc2T0pUaDJERDNUZVZHakVjMTBPdmFkcUkyNWYv?=
 =?utf-8?B?eFNJZ1BoQ0UrcmtZN29BZ0pYNTkwSFBxaEUwbGlNVVprYm5rSnEvcVc2YTZK?=
 =?utf-8?B?TkRxdFZEeUdrcmU1UE8vUUMrWFI0YWt1eTM1anZoMTl1VUdLOEZUSXA3RGZW?=
 =?utf-8?B?NmVPcjhudDNubUloOUFEUHdMOFNQclIwSFVobHMyazh6ZHF2dEVDaGJsWHNw?=
 =?utf-8?B?d2E0eGJKSERybTAyQUx3YXNscEIyOWplbkg1U3V1eWt5VGREMCtyQTdJSTcv?=
 =?utf-8?B?U1lWd0RITm5vQy9TTE85bGxyTWJUejladFJJQVdBWmxxTHJCaElnMCtwRXdG?=
 =?utf-8?B?RHF5N1orenkzR1MwVWt5UTBDbDV3NzVGa0xEVG5GWEhJbDlCanBQcGZibFJy?=
 =?utf-8?B?Tkt3YnV2b2lLY3I1Y0M4NU5LdzRybGlUZTlkSGpIemg2M3lHWE5lbDlFTHhk?=
 =?utf-8?B?NFdyU25HaXdiQmlWV1dkdFpRWksxWmJzOVBwSTlqNnhiaVY3Z2FKSDErcnR2?=
 =?utf-8?B?akpoWVZldFlSajJzTm40cURNVHpoclpHWDk1d0Vyd2E3YWRQZXdGczNLNXha?=
 =?utf-8?B?NVZRQ25pdHVScVZCL0F2ekJKRHNWMzE0UmRLTlNtWjRvcm8yb2FoTE9pZXA2?=
 =?utf-8?B?UHZyRWk0d0hERjlTYmFwM1pvMk0xMUNZR3c3ZDROSkxzdWNicGptM0pqWkN1?=
 =?utf-8?Q?OyKSL90FuFDVzeafvYQFYaJCF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab63bc0-f47c-439b-fde9-08dbc469c0d7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:37:49.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Z3WHJUVSjuCdUkCfKjt5gEpZMdOjcvTjNxEAnqoRe3u8J13LD2KhFKTjrpHyz5RUnwEKosJIdOhRmLW5KNyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8754
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI v3.2 adds set/get parent clock commands, so update the clk driver
to support them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2e1337b511eb..4163cacb65d4 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -24,6 +24,7 @@ struct scmi_clk {
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
 	const struct scmi_protocol_handle *ph;
+	struct clk_parent_data *parent_data;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -78,6 +79,43 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return scmi_proto_clk_ops->rate_set(clk->ph, clk->id, rate);
 }
 
+static int scmi_clk_set_parent(struct clk_hw *hw, u8 parent_index)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	return scmi_proto_clk_ops->parent_set(clk->ph, clk->id, parent_index);
+}
+
+static u8 scmi_clk_get_parent(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+	u32 parent_id, p_idx;
+	int ret;
+
+	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
+	if (ret)
+		return 0;
+
+	for (p_idx = 0; p_idx < clk->info->num_parents; p_idx++) {
+		if (clk->parent_data[p_idx].index == parent_id)
+			break;
+	}
+
+	if (p_idx == clk->info->num_parents)
+		return 0;
+
+	return p_idx;
+}
+
+static int scmi_clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	/*
+	 * Suppose all the requested rates are supported, and let firmware
+	 * to handle the left work.
+	 */
+	return 0;
+}
+
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -139,6 +177,9 @@ static const struct clk_ops scmi_clk_ops = {
 	.set_rate = scmi_clk_set_rate,
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static const struct clk_ops scmi_atomic_clk_ops = {
@@ -148,6 +189,9 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.enable = scmi_clk_atomic_enable,
 	.disable = scmi_clk_atomic_disable,
 	.is_enabled = scmi_clk_atomic_is_enabled,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
@@ -158,9 +202,10 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
-		.num_parents = 0,
+		.num_parents = sclk->info->num_parents,
 		.ops = scmi_ops,
 		.name = sclk->info->name,
+		.parent_data = sclk->parent_data,
 	};
 
 	sclk->hw.init = &init;
@@ -250,6 +295,19 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		else
 			scmi_ops = &scmi_clk_ops;
 
+		/* Initialize clock parent data. */
+		if (sclk->info->num_parents > 0) {
+			sclk->parent_data = devm_kcalloc(dev, sclk->info->num_parents,
+							 sizeof(*sclk->parent_data), GFP_KERNEL);
+			if (!sclk->parent_data)
+				return -ENOMEM;
+
+			for (int i = 0; i < sclk->info->num_parents; i++) {
+				sclk->parent_data[i].index = sclk->info->parents[i];
+				sclk->parent_data[i].hw = hws[sclk->info->parents[i]];
+			}
+		}
+
 		err = scmi_clk_ops_init(dev, sclk, scmi_ops);
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);

-- 
2.37.1

