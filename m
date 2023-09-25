Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE67AD3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjIYInZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjIYInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:43:20 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598BD3;
        Mon, 25 Sep 2023 01:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP/39DtxXKmUPvHTBcAQipmSBJCmkT11XgYVkp2Be96MmWh9q3uh+fmAQp5ZOKj8H7sLSkLy4E/uD1wMgRBEEtmiDwbcR8ey5hpvpZI7TRabFJ7jfyypq+RpZ5dQsJQT0W38TsSVIWk1k2iv4OMeoyMbmznvb//k5PXENjjYrZTjRT6mJ/5j4P3xOgE+PzCdjLe7DbH4U0ZHPtmSUX7NY/aMSeHh1SrhK48DYEj98AqiQy3+FMTS0uEDRgWVn9AxR0iNp5pFUHg9/RTDysvBc1ImVs0WYx7ecfmhr9HPwp/AWZjEOmxJFMaMMgyLuX4kG93nvGqVaJrP8wEaOEinLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix9KVBYwnHweBcpYqs+IfJUUWkaBBJmN8RTU5DV6tWM=;
 b=Yni15Pwh4BuwC6QVng0kR+1/g3Or0fyqUc2hbt2rdWzBc7N3daMEpqPQ8Uezi2BdsKUcYg1xm0yfEELf+GQFCGd0g6yXpyLNp0vJ84Gjuprzmt/QOkNNHOYYCV/oxEkGBUyogtSYpEGjEhzxL7nUnMpySkuC1xdiBYz4XXzauJHAePwZZqlG6LQcbh5xyx6+oXRqozkRIVqmSSd4JJXGRHbjd1QOQPf0eMjiN7hw6HG8W1sfYCXQI0Nm+Wh+VDEmLglgxLK8T09ZETar3P19urXiHr5dC84WgMVx2xkDTPzvb/QSOm7SUDTFuXZzZ8tli6exXOPvaKek9OSwXmWePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix9KVBYwnHweBcpYqs+IfJUUWkaBBJmN8RTU5DV6tWM=;
 b=jel6tHn8dNZtX/4OgKnW/awm97X7VOzLiI2vdWgE0fwmBeGrzHVASm0utRCNh2I4BUR9lL0GNusL9nY28Y4GqR0MNuGHJzaGtJvZvC1Lj+Re53gNtzJ/zHfRsBE4YyVWxM94B9XyTHjTZys3ZSFdZNz3t9b+1ugw6S2hQQcFQJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 25 Sep 2023 16:47:43 +0800
Subject: [PATCH v2 2/2] clk: scmi: add set/get_parent support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-scmi-clock-v2-v2-2-2d4d7127ebc1@nxp.com>
References: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
In-Reply-To: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695631674; l=3380;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=GEoaMPEKFPMe5D3pfktJgZun60qYQRSSGhLzuwR/Q7I=;
 b=0OkVcU5hD3ZSvop2QEm6JW84xrIleREJijHZAkYOf+F37wOodCw3x5TOunCQjZxE3YUogJo5V
 iHXfqsFvxxqDR5ES4aaJvpozEiLq3TCoBQQk9Ag7x0FEXKEgNG629NG
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: b28b8c7e-3d97-46a2-64df-08dbbda371fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddU3B4xGbTyvo332nRT7KshUCDzLvlyFByEdzdHigrGO58MQmWpS2HtFLHoQA1gj7llrcKpXqQ0GDOXQpsH3BbaYeM/RNCQrZg32aMb8Yr+BzomV3+vfB1X3p06lTlceQ/kjEKrES5xsMow6bqxSLwqKUZ4uqAE/bSjz2sKy9hZDqkna2CbSf3yQOFaygalU1TXkvyfJiIw72ik0jxivSMDuVMi3M/UcJIgKS23MkR2tON5UQUcHSMFsuHodeSge7FO55ldSyDxqwcxY6VmHjng/b64umLm8avqtMRlHuZScUUWiVRdipjCeW5adH3kAAmT4EP7cJzVV4wdn0L/RvIMucIXZbZ4HqDWxqvuVPsEPraaNEelRGx7OWFYuG8va+QUts3LNhuRKYzXyOpatqcW46OXADP96PM7dvQdGZ+YP/KQmti+K0ks1OaBw0coZVhwrAt7jzT+sMmRz49+SI2vo2/qnV2u/BAhTbbRzFlU/wsaU+vMBr0G5ks6ZhaLJ/vkOR1/Wev1V81eIe7bvYsCi1Y6bz8rguMRLuhMDw6/rF8GdvvaMxg/cL0L1HpjqHzx0eoej7Q8kZEXJZJmvi7ztbhOCLzy4ZTq6RidxJI+wf2yJt85aO/cB8+BCuH3A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(83380400001)(478600001)(52116002)(9686003)(6512007)(66946007)(66556008)(66476007)(110136005)(6666004)(6486002)(6506007)(5660300002)(26005)(41300700001)(316002)(8936002)(8676002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjk5eDZqUlpVZHJhZGRpUzdreE5YZ0NDcjRTcWlwUnkzOE41cFI5VmVBYmJv?=
 =?utf-8?B?dWlUUUU2a0ZCVFVYMlkram5FNkhvUk01WFNpRmFYV2JSY0ozeHRkamRCUUt4?=
 =?utf-8?B?ZWlvc0d1MnA0UmpTZ0Y2ZWxrRk9CdVdEQ1RibFBDcHNLT3VFY2JkRTladGJB?=
 =?utf-8?B?SWp6MDU1ZFA1b1plUHppTmtLak9CcmFIaWUwTnRUNkhqQTlFdHpmeGhCU1Iw?=
 =?utf-8?B?S3ZLeStsb3pxZkk5b255c3hRTmlhTzZzZGEvSzVMRUpnZm1DeW9FVEowLzVt?=
 =?utf-8?B?cXNTajVjelN3WkJiWFk1RE5wMEpYOC9QMkEvOXpEaTdYMnJ6Q01hM2cwNmJs?=
 =?utf-8?B?L1NLUTdFTUl1NnlRcFdmeld4cmY2NmdyUGZlMHUxWHFSVVJja0J0VGdWZ1Ju?=
 =?utf-8?B?Wlk0bFVYZEFWTTdOT0hkcmVtdWxHV1paZUo1a0dqTTBZMTNUa05JQVFSc1F5?=
 =?utf-8?B?R01BSlczUXZSZEU5Y3hOS0phR3Z6RGNqUkJVcFgrWHRYaE5ZVUd4czQvSjRq?=
 =?utf-8?B?cEtpVHRGS3VBRHFtUWRPTEJIOWtNQng0bk15eU56TTdzeTlLeEt2QnJNWEQv?=
 =?utf-8?B?c2pUekx2TEZwOEsxaWhUSGdQTk5TL3FqaURxcVBPNURkMGlqTElKWXRYYVBs?=
 =?utf-8?B?TDdVcEFWcEdyMERUdzA0NU52TDYvZEE0S0EzaDF4a2h3Qmt1RjNIVm12Tlhx?=
 =?utf-8?B?RlNoMVpWQW50OXNjSEMyRVQzTTQ2QnJ2bTJPdkRBVVFqM2x6ZVJwRnU1YWt4?=
 =?utf-8?B?ZXFGQ3hRYnIzaW1CVUt5eDdkNWE0YThsTncxeDg1U2R4by9oaFJ6ZTRpcVJh?=
 =?utf-8?B?dkZkY1VJU0FDVm04WGVEc0IvN2VDYjRHcGJtVG9aZzIxK1JITmhxcGdNdTY1?=
 =?utf-8?B?Yk5uUzd1MUtOUGh6OGV3QVdGbG9DbVVwYUdrRXJxa2g3SWRqZVFqRm5ReDRJ?=
 =?utf-8?B?TjhVM0l5ZlViSVYvcEJ1QWtTNlZodnFNLzVZQ1RTNVVUWFpwQnU5OVRLRXYz?=
 =?utf-8?B?RTczZmNhREdQVzlITFpIZnhSN2s0U1VnUzNrNlhzSVN2TDNhdjRWSjRtaDYy?=
 =?utf-8?B?VWZ2dEVscGdrMTBPUDhUNGVzbTk4eFFXYmxSYjkzZ2sreGdISzBsR3NjajNP?=
 =?utf-8?B?djQ1NFpxRjMwOGh1cDl6UUZaU3pOMC81SHg1V09UMXBYMmpoRzNUUXViTUVw?=
 =?utf-8?B?djl6V05uT2NpZjVoM0RQdXFwQVlZNDMydFlWZnNQaEs2cEk5TnBtL3ltNVNE?=
 =?utf-8?B?Q215b1N1T1g0eExReU9aUm1YQWNqRmVrTC9aSVh0Z28vaThsRjRKb3AySjZM?=
 =?utf-8?B?emhhdk1HYm1pcmFCTkNuTXo5YnE4QjBkNzNxZjBUOXNGYUdKcXhYMDdlUGJq?=
 =?utf-8?B?RG1DSWNqeU8vaDMxWkVyZ2k2bWtaWGNEL0dldXRMVC9LSTh0Mno4N3libGJ4?=
 =?utf-8?B?V3ZNUG5DQzhaQ0Q5dHpFUG9xRm81TExuNGNuczErYnJGU3BjNCs5UHQwRVRT?=
 =?utf-8?B?NlFtdTZ0Nm5NZmRGS1R0SGoyWnBtaEl3RFBVbG1jMFZkZHZqOVFhZUVIOTlQ?=
 =?utf-8?B?anc1QVVuaU5HTE43WEZlcWNZbGZTTFR1Qy8yZUtlNGdwVTUrRWx1b2Jkdm1I?=
 =?utf-8?B?TnpKY1A3a0lScEpITFNpQkRmanBZaThrSDdXRUwxamc0Wlpxalg1SlpwMFA4?=
 =?utf-8?B?a0FDdVJzVW15cC93UTluL21hb1FyOFN0d1hsS2pwR2lWTVJ4Ryt2WFk3QlRx?=
 =?utf-8?B?TVZwcE9MQWU3MHh5SE5qOXR2WjB4VDY5K2xUTUV6VVFYeEdBWlhRQTI4TndE?=
 =?utf-8?B?V2xjVnY4V20wSzdYL2VHK0s0dzZUQU5WUnI0RURXQ0ZUQWF5T0dGcHJkUjBu?=
 =?utf-8?B?S0hPOExnczZzSWZnc3NKQnJzV1UvSVovczk1VVBFSWhGKy9sdGFjQlJBSFQ3?=
 =?utf-8?B?aGp6MkZBMldHS0lKSGp3emppZWFZUXBJbmh2dGxqTjd4MUF2QkxTcmR4VXlU?=
 =?utf-8?B?eFJMUmJIZ1piY0VXQVhJMDFrazhhVDJ0bkRLU0tmSmY4VTlGR0d2ZXdDWnFv?=
 =?utf-8?B?dW00eW9lMkNVbVU3RVFpM2pabWkzVy9qZ0lyQTFEeHMzbzJzSTJSLzJtVG1i?=
 =?utf-8?Q?/TwmFupyIzx3Wzdgjs3hcwHIw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28b8c7e-3d97-46a2-64df-08dbbda371fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:09.4115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H20hnQ16iTdHQ2xX4gpkmM9mUaFygz+q+T3FIcRW3xOVDAx212HSLlalxdIoK3RLacAI1cjnNgyLS8pdQQbGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
 drivers/clk/clk-scmi.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2e1337b511eb..5aaca674830f 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -24,6 +24,7 @@ struct scmi_clk {
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
 	const struct scmi_protocol_handle *ph;
+	struct clk_parent_data *parent_data;
 };
 
 #define to_scmi_clk(clk) container_of(clk, struct scmi_clk, hw)
@@ -78,6 +79,35 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
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
@@ -139,6 +169,9 @@ static const struct clk_ops scmi_clk_ops = {
 	.set_rate = scmi_clk_set_rate,
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static const struct clk_ops scmi_atomic_clk_ops = {
@@ -148,6 +181,9 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.enable = scmi_clk_atomic_enable,
 	.disable = scmi_clk_atomic_disable,
 	.is_enabled = scmi_clk_atomic_is_enabled,
+	.set_parent = scmi_clk_set_parent,
+	.get_parent = scmi_clk_get_parent,
+	.determine_rate = scmi_clk_determine_rate,
 };
 
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
@@ -158,9 +194,10 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
-		.num_parents = 0,
+		.num_parents = sclk->info->num_parents,
 		.ops = scmi_ops,
 		.name = sclk->info->name,
+		.parent_data = sclk->parent_data,
 	};
 
 	sclk->hw.init = &init;
@@ -250,6 +287,17 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
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

