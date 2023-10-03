Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D97B6833
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbjJCLoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbjJCLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD9B4;
        Tue,  3 Oct 2023 04:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd+gFAc1x+t0cVf5sVH/cvnbBOr5eQJDDGflzKP69ff9B4WhktTDG1GOBq5HeDX5dLdaRuqQ7DOe3JDsDG9fyl009V1XzftedHikUA1iyuI0JIozLGERLIA3xJB44T5NcilfOxC+rftxpS4Hf/o4HsDbdQh4swhIjituL4oPdZqCcwl8lGwZ8qTL9Opsj/sr9ehNvLBl/aa5jgaLSjB4wL+9b1Oncl6M6093qSa8P23Pqwxe9AJKplR7IborASddUjKB9c5f/J0bNOQ655UhKccBT2WdzHE4DWPzjlYNjmhvfMbo0Tw863C2cABVA/BRuBYfb9U9HpOPcOkyUJEHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhjNGsp4xwdX0P6o9i0kzlk25NllGv3UowCaiQQeSaI=;
 b=HRpEhwdJmyKijOPR9U215f9p3NTku3A2CocGdrTSxGXuABcoWpYl4SzPDlptjjAUdqOM7hNn+AIwOtA7BTSUCJv+USu/uRwOPEodEOudRraP8g9LMDbh7/ijErhwZvQPj1z+a64taxT+cSVpahXckdHfexiTdX0PdCfSUIvs86BVeX4Mw3yt8jjyBMU3mWsUm9ZySxKk9ertD09bw/BdQmX/zviuK0QiY8GZLy2ZE19ojFUX6Ja2TheaIIBNr7MSCMBnxUoEgj5uSwSul7xI6WRwjXnb61yANFXzoM/b1NQRNBD7Mw653ebUcsnC9H0XoOmdCRlmS84GR0i2kGnf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhjNGsp4xwdX0P6o9i0kzlk25NllGv3UowCaiQQeSaI=;
 b=b5xKnoyRq1Ff4KFSPYVEoe06W5qj6Cn4Y+/ww1+sKgiI8MTTLeJ0k1FQsff38bzq3zGAumW+w3lYuTbMNVkQH/wMDGDxx5ChnuyQFjAkXfkeWv2mcxtxqyyqcFkmeDTApOGhkCbZfPc0ngqVJ+tnI66Y/HK/DwAHB4avg8zwYRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10067.eurprd04.prod.outlook.com (2603:10a6:10:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 11:44:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 11:44:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 03 Oct 2023 19:48:49 +0800
Subject: [PATCH v4 2/2] clk: scmi: add set/get_parent support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-scmi-clock-v3-v4-2-358d7f916a05@nxp.com>
References: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
In-Reply-To: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696333746; l=3574;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=MEH6g0VX59/MRx44I4/IiR8vh5iZLuYSBdn2AKvC5sQ=;
 b=8p/C+mQjxnZ2Gh8BEQilCyIs73x2bWLnu6kce7+FocjU7sIvGvkGhDerfcKjqhZ+GHRVm1MJu
 q8PQMkulFtDDYPhQn+sNYWwEwm9O9rx87gxTfVSFIWSgQhShmbSEgvR
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB10067:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c1e95c-b098-42eb-85fd-08dbc406165c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfH1wF/EtXw+2KMQaKQs+eh+WwH64L85vd7Yui1HRNj55yMVkg593Coa5XDI2ku2VVBBdNR2RuFwrhJFfqFx/mXW025v24uiWKZa0SA5TEkuXo8MpoGceE5OQ0/UvCaRaHWxzXGQmqha6hy0OoQhvVE8P2iKNEFqMnPpFLfOhH9ojXY1jfKYGJQWjAeCdqph1Iz4LNcYzZmLzdTBZS/Jy3MoOom0ZSE2SaQ+kNJWZ3ClT4CglB+TCRDFWicqkIelgaiQzfQqliDSb7hIQ9kMB9T+8oa374lImXReGG2NzjUVHaZDmBMkUotJF5NRv7gl1y6WvWpSojntS8i/PX7Ff3jcVVqAL+ovtx610N7gDlsOfGvIbv0/w1IalQjIs7ligtl7qOC2sblmwMQT5/6I7Fls0Sr7wwBIIoThxWkbO4KFXGtxQQI+pHfqoB0G+PCl9poPyv9ahAAxVDLSFa2FXsHEP2GvqtuMkFzkEnZAGNfri5mZwSG5Y2nFs6C+5va+a1MWZB/8WlGwULwgtiAz0Basq55oNahdaykEgFdVKshqvFx133zaEHbWwI9TZ7fEDxj5+56fCcHa2cCndqGtvpQ3IyD8dhLijkNlBBxpWKK+27WHOuAoI5MbjIlfimls
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(316002)(66556008)(478600001)(66476007)(83380400001)(9686003)(66946007)(4326008)(26005)(36756003)(41300700001)(8676002)(6486002)(6506007)(6666004)(86362001)(52116002)(38100700002)(6512007)(38350700002)(110136005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BZSW00b3l5b2ZEakthb0NhZkFURTFvSHNGa2RTMTRQMEJyaDBpNU5WT1ZM?=
 =?utf-8?B?eWowcGRLWDh2V01OdzdtMUgzbXJmVkkwV212OU1Cb3RKcjQ4WnUwK092YXpq?=
 =?utf-8?B?aTAxeEs3Tk5pdDdLRzB0R1p2dHM4c3RNeXVVbVU2UTlpL21JY3c0TTArRVVT?=
 =?utf-8?B?TWdZdWk3OERpVUNyYmlYNkdkcWpnK05ka21OQlM5WEQyOXppSHVRN3c5bDIv?=
 =?utf-8?B?cU9qTEc0RXNwSkVnZHBzRm1ZQlpBZ2tZUDE3VmQ0UWtuNlZkenZSZXBiUFAz?=
 =?utf-8?B?a0t4N2NRdDlOOFhRQjQrMU9DWU9UWGU1dXZtSWExWVo2bWhDQXVFdk5BZitv?=
 =?utf-8?B?T1MzNmZ6R0xlVmtWZ0JhaEE1bzVDOGluV2FsYkkzLzRETUhIWnRkdW15eUgz?=
 =?utf-8?B?S1ljWlY0d3FoT1g3aUQ5SzVnZFJwL3VmRmM3VDE3L0RibTJ0eCtkczI4VWd2?=
 =?utf-8?B?OGpvQ1N5VnlJZlNpaThVYU5IZ0N6RG83T1Z4bllnYUlKeEhwNFN1R29kSkdC?=
 =?utf-8?B?dHAzTHlEV25HYU5scW9OOFRQcVNqZGU0KzkvWnFaMFEzbTBaKzJGZVZ4aGd0?=
 =?utf-8?B?SG5jK0RRUmFBNld3bUFxMUZyMm5GT1BKQWpvbEh6T1NTSVd4MSswb2ZSZWpW?=
 =?utf-8?B?VkpmNDdOcThrcDRHTGhxblptZkdUQjE0SXVMbkNKdGwweXJ0Zlp1YTdlaWd4?=
 =?utf-8?B?c0QrNGpNbG40V0h5ODJmdEFma2NLV3ZDZFg4NGphQm5MaEVSQlE3Z2RMeXZO?=
 =?utf-8?B?aHBRR1Y0UVROTDNLbnN6ZkE1aHRmVEovL1BEM252K25GMVUwMHdmZXhydFEv?=
 =?utf-8?B?UWJPcnZRSTFqWU9JdHZSMXN1NXVEblkwaWdOSzh4RVdING1rWlI4Y0MybUxz?=
 =?utf-8?B?eHhqbTJnS2ZrMDM5WkVJWXVqTk04VDA3LzZtbHB3dG9QVitxY2pCeWp2M25D?=
 =?utf-8?B?UzFJTXNieEhnOFFHNFpRVXhXRjA2WlJNZGd0Q0dyT2M0MG5DcTQrRXJNZHhm?=
 =?utf-8?B?Q01hdGdkRW9GeHEvdTlUL0hJWHhBRGkvSEtybmJ2UUNGRGM5OU9HdUdKT3dj?=
 =?utf-8?B?ZGs1SzJtK1Q1WUNrZHRsdTZsM3MzVjRmSFdRcWZWeUFGQjZzQU53YytOQmgy?=
 =?utf-8?B?ZVpZL0l3VDV2bURLTDl1OUN5bS8xeksyKzRibUF5WVNyQ09tTTFKVmlxWWM3?=
 =?utf-8?B?Y1VYcC9pS1RySEw2U1hIT1dXc2FUK1RzcmNMVG9GeHQ0WnBFRkRpeHRzSTJR?=
 =?utf-8?B?MjRQUUhFUVczUjkxcjdjV0xSa2pSZkEyOHp5dzByZitRUTlObHk0SlR4VmlH?=
 =?utf-8?B?RHFPNWZaSnk4eEtBcVRmckF6eEVQNS9kdVVLVjlZUFNNNk9UTmx4QWVvVHNn?=
 =?utf-8?B?bXU5KzNCRVRQMnZybUVJZXUrMjZ5QlZldTlaQUdPSDJaZCsrVWZEcExobS8x?=
 =?utf-8?B?eTBQVENqNFByb2Y3QUdVbXpvUlBKZTcrbS85MmdsSmZKYkZiajVNK0tFYkpF?=
 =?utf-8?B?MGh0Y2pUU1p2bkxna3daQThTWkxqUkp3dktJNjdXT0dzWnFVMDk2S2RvWE5l?=
 =?utf-8?B?cVdualdZRzI2UzJHSE5Xdzlob1VVN0dkU0lxR0hGZnpZRm1OdEMwZmpQK0tM?=
 =?utf-8?B?eFhZT1c0am02LzZyTFhiRUNodkgyR0hUdWw5dDRZNTM5b2N3SjZwODd5MVpF?=
 =?utf-8?B?bHUvVjlwajJKV2ViaXNhSU9pRUJMUHc1SXEzY2hpcko5aEFsdk9NdG52UVVL?=
 =?utf-8?B?SHlUc1NuR2tscmxrb1RkQVFkNzVOMWljZ0pCWmJnYUs0YjltdnArYW9FSHM0?=
 =?utf-8?B?dkQ5NU5BYWd0SEpLRkh4U21LY0s4TVhUREwwWWd0MlpHcWx0TUJhdC9ydDBx?=
 =?utf-8?B?OG8wNTV0eHBkMXR4eStkTC9Nbm1uY2VKNjFkQU5WaFVKbmxXNS9PSVh0ckdt?=
 =?utf-8?B?ZEFoVllMSEFsTEJJSzlRK1R2SEVTQkVFcnhKY3B0SFAya3FDL1c3VE9KeUI1?=
 =?utf-8?B?ZnhBNHZEWFdDdTRFZ2d1enQvNkNWS2JJZVpDOGkwcEhNV2lpVDlrcmpqUDM3?=
 =?utf-8?B?alVVejgwaWQvN0FwOXgzWFplTEs5WkxMclFqT01LeHYybTFRNHpDQ04wMFIz?=
 =?utf-8?Q?8y8t55G53K3FRNXf3F6lWLCO6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c1e95c-b098-42eb-85fd-08dbc406165c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:44:22.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t11JKuufYl0WYaDbxdnC3sh1wVn21etbsHfhBiagVGfv6npbpqTfRNeDtTpbjTAi3eLlXgnp5WXTozciZEPIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10067
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clk/clk-scmi.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2e1337b511eb..e7a27fda561b 100644
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
@@ -250,6 +295,17 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
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

