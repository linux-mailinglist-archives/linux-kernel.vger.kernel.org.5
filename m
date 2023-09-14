Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A779FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjINHHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjINHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:07:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3D5CF1;
        Thu, 14 Sep 2023 00:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCay/xLTiyQJim7XlVBSc3zmxwyz1LF4QrvixYAI1G+EjWka63i2N9F3C+gKACZIsPsaYGTHvO0ep1yTvCvyR5sfg0Xg5Cq/8L1n+2g5Mgb6BZVZxa+Tyn56+FgR0+e/k7InVrMGHtGkFSr2aILiHnk2lStNbUvjc2WbIYbIi2RnDNETyNHmqWpH1DEMq8l9EvMp3IbpedgvxZooJ6fdj7K18Gepg/qbnMWm1WDugDVRLHPqeNsfy9kUvUhtFKxB7UqH2GBA8vA5hDfLilFDCx6c3xBMeq4YKHikpxzKgWlT6VHu+zfUKgml7aAgboj37Eyxp41YHczJkTWsZPVRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7GEJdMLv02qYPHlPu72P2aoCKLzhVJHSZH0rJYBNuo=;
 b=LVGuHXUmpfR+9xMkluuqTHsu/uYFn9xEjhJdvG0h98dvDcqNM6kd6X4ciOSP/784RnfOgDoGQ4cPq8wwbGfQv05hXlJxI743fF9pD830AHZOEzFWBrgW17ASR1j+iLemfBx4BV5uX0bdF8xXTLkeBPS8ERSrzY67wfAhVdWpIk0FvNCXN179Jkb010zt5q7XKNKzkqGH8hItQQjD3YpsT4MJN0mAVmfsQwgZ/KfrKmiqUwmcKgmCHjuLyGaWh4kYzpLO5rkcFQ0qTkU40FWUzUY/61CsuoUlNZ31wmgxARc3qOzZwIQ1FT/DCxGbzg8x+yqT6G/Gs3VSHm6RSejtdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7GEJdMLv02qYPHlPu72P2aoCKLzhVJHSZH0rJYBNuo=;
 b=NdfpAtKAyXUvzANEgxnpuexVNisvgEtknXLBSUwt1iyzjeuiL1EKv8+3zNl1LS8LH4J8+/hsCXvNvrF84qso9dNdvteOA8tyV3slm+SX2gekeZSOvvQnOzA4V13oIulXLR5vYAW6UQBjj2/41/61WvC0cQ2NlYhXoLGYiN5lsfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:07:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 07:07:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Thu, 14 Sep 2023 15:12:12 +0800
Subject: [PATCH 2/2] clk: scmi: add set/get_parent support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-scmi-clock-v1-2-bf8edfb0546e@nxp.com>
References: <20230914-scmi-clock-v1-0-bf8edfb0546e@nxp.com>
In-Reply-To: <20230914-scmi-clock-v1-0-bf8edfb0546e@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694675547; l=3053;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tW+XZs/tR9PEWaSz3puVeFpnietDoPGkVjeloq9GITw=;
 b=Ax+yBfSWa11SzVDs/heYDKiepBbFStf7urPfAE+rjkvm/stcdPlIeTc9SY8phyCutXXBVST6C
 U63AVGPPh0cCkKnJNC8LwrbcGbT0aS9pvLzXTMRTPTgKJhOt6Y1LdCA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: f00893ca-e024-4ce1-2289-08dbb4f14928
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d02kAO7Qvel8L+PNl9XR1xdsf3VCacsb3H4ZbfC5W4hN4/0Wa21JT/p0tkook7E/sfcaXd6laS8ZUOYw3n7K85cITWUrWe+Xq0plVFG0UMOx8hGgom2EcAOIi51UngqzzXcAXL0t+CpeHi63wsCBkmay3Hn1vpKm7h13fShL5g8rKX/s3PK0R61eYICz6igjLGXJ0n4dOu0FaLUqbS5w/t5plCO+sKfnoMFrHpWl/BS0DWSV6N1x1iozNpWTsKkPAonLh4T8hRcOC1BDmY3lEva4NbI2KmBe0onKJze8fZPMulUIJa+wBYjAH2RaFS8vuocl+LlzmzoWf0e1Tj+hWO15wgMa/XkSb6hEIyRS5HySJFb+yitYtrQKdR8G9hT2DHFkVmHcbbmr/6VEXNoB8XD84HkXu2S7TGAoEY9DlTkDpvQiZft5IO/hEzu2oMcbuPCpAotHDKDGm7zTl3wS+caAy+HzeywSoFE1IhT13l7d7KorCDU8MHqUYgep0kTxKcyKCJYxZmlcPApRZxklOP+81e+NkxCBIo+E9VjuSjd0eBaYidt0yMvGDHB+u57KtZycAUmLA9UWuZ/ASNB/wVO69vCztMmQyTlTqLPE+AXhtZMiemjyI5Q7Xk/P4hzl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(186009)(1800799009)(451199024)(316002)(54906003)(110136005)(66556008)(66946007)(66476007)(41300700001)(478600001)(38100700002)(38350700002)(86362001)(36756003)(2906002)(5660300002)(8936002)(8676002)(26005)(4326008)(83380400001)(6666004)(6506007)(6512007)(9686003)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hnVWZ6SWpvMlROOEZsVUZLdEpldXNOR3hwUWR6QVZnWGdpb3RBb2FxblBo?=
 =?utf-8?B?Tk9GOTZ5NWpwTnpNRXZvYXVuY0dMOG1PTnMrTkZkU2w1OHZhZHBjeTdEVVVV?=
 =?utf-8?B?RFpWM3JxY01MTURXeDZZd0ZyZi8vazdPbWQ5aWd1OHk3L2pQRWwvZ01yYVJT?=
 =?utf-8?B?MGtqVDZ4SVZ0c05XU0lxQUpLMkJ4bXpxY3VsZlJtMFRnMkpWck1hOXg5emxF?=
 =?utf-8?B?eUlpNkNNSVkvcndGRFprU1puSGlsTytKWFhwdE14NGc0OE9BcmFMcTFaR2FY?=
 =?utf-8?B?ZWVpMml3ejV5WUdvVXJwOU1meDJhRXJZM20zUVV6bSs2aCtJRE5EaXR6M25T?=
 =?utf-8?B?ZWc2blVhWXhDNW5zMnZRbVNlY0ZUb3YzcDEyNElEdzVyYnJvSE1FY01mQzRL?=
 =?utf-8?B?Sm5xdExLVEpJVk9TWVlQSjAxQzdYUmtyVVVGTi9zdG1rUkVGWDl2aVVBZ3or?=
 =?utf-8?B?OVlIT0duQmszcWVqM284djZFaEVpR0MrWEtQTFJjMGNZQ1IyS2dtNDlHa1Vi?=
 =?utf-8?B?cXpheDB1VmViOXE3SHJIcFVmTmtqTmg0TVJyQzZoYlZ4SHExVE5QWDNqTnYv?=
 =?utf-8?B?Nm04WUVvNHI4cHRBOGE4MDBIT1lqQlpOTXdXdk9zRmxwWkI2bHptS2ZGditO?=
 =?utf-8?B?NktRZUdsc3AvdVJhMUk3VmtQMGpqcU1rMGJsNk1Ja2ZvRFpZUlQ3RUdzR1h4?=
 =?utf-8?B?cDl4eVpGRGpuWGtGY3I1cTFkUllZY1dUSkVnZ3VMcEFYaS9Va1EyWHBSSHNY?=
 =?utf-8?B?cnJ2ZkhnVkN2enM2L0FDemxsTGg5WkVMYmFENnRROHlVdnkyaWh4eG0xNkUv?=
 =?utf-8?B?TWZ5SFJ2bTdmRElMODFEY3o4VEc5WDVLQVFQTGdBOVo1TmNtL05JY1ZDc1Bj?=
 =?utf-8?B?YU43NFg4YnFkVnluK2VIYURZSTNBOE1mZHBmV29tdGo2UE9CbjBTbU9lbSs5?=
 =?utf-8?B?VGJpT3ExZmR2aTRickVlR1RiWWJxVkJTQ1g3eEFTZ3ZZWkVxT3I0RHpJdCtV?=
 =?utf-8?B?TFk5Z3EyYzBMMUpndm9MeVR6MkZZQ3BLNHlTdWY1QlQ0OGd3NkRBL21qdXRZ?=
 =?utf-8?B?bVBpRHBNaXVONWUzSmdrbnRIb3RPaDVDSSt2UVZ1RVkrVi8zZUl0OGxEUVRI?=
 =?utf-8?B?UHNPNTYxSXNYQ0ZUUG9UKzI3K0tFVkQzS0IxREhOV3VVa0p1eTd6ZDJ6NzlB?=
 =?utf-8?B?b1E4M04vYXNpWm9iSTJxdDhhMk9RYS9rcG5xUTFxR2g0Z251LzBOSHZSMkxj?=
 =?utf-8?B?TW45RDVieUI4NkhpM21hdVJ3U2ppQWMxYlQxSnhWelVNYnNYQmR4UFFIQmZa?=
 =?utf-8?B?cmNnMzZCRXU4aTVyRmpyMGprazE3Tk1qdlRlOXdwUzlaK2g5STlFQUJxRllG?=
 =?utf-8?B?NlJNNHZmT2MrS3pxZVZKQldyRjY2MkFraGU1eEoraitkWVNWb2FmZXdaNHB2?=
 =?utf-8?B?QmF2a01zdDlPbUpsNGM3Q0JDU0YxZWtPUjUzK0hJMDVZZmNPZHNDekNnMlV0?=
 =?utf-8?B?OFFKTTQ3R2YrZDhvbHFOYm1ja2tDa25aMTlUSEtrWk5GanZSMFhsT0cvRlZ3?=
 =?utf-8?B?d25tKy90SFhVV1hPT3lGamxyUThqQVRSL2xvU21HRUdoNTJrc1pGQ3liMTN5?=
 =?utf-8?B?TDllVmpyaE1ZVjVpTi9HU1hqQ0ZEUVRaeHVOV3piWFR3WjJlZVlyaVA2ZWM3?=
 =?utf-8?B?aTZaZTJnVG9VWW9ud0dySU5OWE5kenJoRjZHN3BOOWFQN2k0NUppaWpFb0tX?=
 =?utf-8?B?cS9QOGV2WHUrQ1NrMUJtczV3RDdOS201cG5MbEtsR1RLek00a1BCV2tSSGNm?=
 =?utf-8?B?SlhFSHhQR3VkSDU5SXlJeGxWMUZ4TE9kQTNzY3M3STVyOXN1YlRSSDR2T3R0?=
 =?utf-8?B?S0NSRlVaTmVSSEFKRWl5RmU2V0dpb3l0RHlBSlgyRTRuWkpVc21RN3crd1Zv?=
 =?utf-8?B?azhNMFY3c1ZmYnBqSk85OUVwNmhuSS9iYm12cWtvS001NGhOYXNVUzVXZTlj?=
 =?utf-8?B?YzR6QkNUMFFxdVVkNUtiL1dkSlpMeFRwUlkveS95Q3lxL1JLczRzd3VZclU4?=
 =?utf-8?B?Qm5WUVhDS2RMdmtsRTNrN2JOVlNyTldsa1E2V3p5emF6b0w3NitrZ2hkMkw4?=
 =?utf-8?Q?JzM+DeBQOb03qwwzPE9fko70T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00893ca-e024-4ce1-2289-08dbb4f14928
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:07:41.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcc45MvB7BhLll18PrZWilqR6qucjyJ+M1WlMymVuCXhHromEDjxP/kfMD4ETaWh4JOPZCmks9uFBqwmkhJqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SCMI v3.2 adds set/get parent clock commands, so update the clk driver
to support them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-scmi.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2e1337b511eb..6a283020cbde 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -24,6 +24,7 @@ struct scmi_clk {
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
 	const struct scmi_protocol_handle *ph;
+	struct clk_parent_data *parent_data;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -78,6 +79,26 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
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
+	u32 parent_id;
+	int ret;
+
+	ret = scmi_proto_clk_ops->parent_get(clk->ph, clk->id, &parent_id);
+	if (ret)
+		return 0;
+
+	return parent_id;
+}
+
 static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
@@ -139,6 +160,8 @@ static const struct clk_ops scmi_clk_ops = {
 	.set_rate = scmi_clk_set_rate,
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
 };
 
 static const struct clk_ops scmi_atomic_clk_ops = {
@@ -148,6 +171,8 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.enable = scmi_clk_atomic_enable,
 	.disable = scmi_clk_atomic_disable,
 	.is_enabled = scmi_clk_atomic_is_enabled,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
 };
 
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
@@ -158,9 +183,10 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
-		.num_parents = 0,
+		.num_parents = sclk->info->num_parents,
 		.ops = scmi_ops,
 		.name = sclk->info->name,
+		.parent_data = sclk->parent_data,
 	};
 
 	sclk->hw.init = &init;
@@ -250,6 +276,17 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		else
 			scmi_ops = &scmi_clk_ops;
 
+		/* Initialize clock parent data. */
+		if (sclk->info->num_parents > 0) {
+			sclk->parent_data = devm_kcalloc(dev, sclk->info->num_parents,
+							 sizeof(*sclk->parent_data), GFP_KERNEL);
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

