Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2357B6831
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjJCLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbjJCLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:28 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D195BA3;
        Tue,  3 Oct 2023 04:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXLmMHT6OVxFYfRxwc3x5aYXe6x7qevIas4wgOymcsazjSOamV20vr1o1CEgdfP9nOQhytIvPrPmoNxNfuxTdIWOEcaFJX0wUWK3HJet1huGYZy2AkW/jVvMPK5ypZplTjdAMphz473S68I8iTnZ1UJDREp7r4lQ+49Hl2Ob1G6xnO/RQuyp3Tp2zYb+OmBxWoAIqdzERTCAI38/zgoe8gGe3JqgKt9/nin8v4U6x7OsURTF4IWT83hxHBAvXJ+YSxlKxtVrTipJULw539vW9uIfVfnVsNoxeITZheUy5SuQw7P8tXcA3XiC150QJazXaOvhr6Q0UDCAnXAPVfuRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDaMTsSdyXwdGgx/APFq6ktvOfPiHQM8TN3MqsyHXZc=;
 b=Ca7GMSoSluJdzDhePrLTTJuYuFhzklhfR2pnK1eps3FDnIUL5Gur66fDiIIMhs6NedEl3UMOBOWVSAnX/bVeM9yh8B162tjCBW54ZRWLxkiVv1WH771726BP4TXmOjehR8xM1KXBJ291w3d+uBUdNzpVx7e6vNUL2x6v95dSy8C50+EJn0z2ai6zRt1KuzAM1Y4Z9x2+CGxAP7pmj5DyJv0s6vZgRLgwA76ym1YF6euAdpF6FyvoxB8tK8EgHPJYtegih6bwE0gS5k4W/1QlXU951DW/4zSemufSK0RzD5vjGs2kivGnLElBx91t4VoVeM9mMVGAGfSW4RdtRqNxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDaMTsSdyXwdGgx/APFq6ktvOfPiHQM8TN3MqsyHXZc=;
 b=Ks7UL1kbI7s1xtjLnV8byCI+Im/9xG3m+Ku4CqEcEOtdIpyLxO7AUdbZQcq14zAwTzVFIpJe3TYkXrfj9z8Qc0ci0N5dSvSdtX5XxAA5LIPaacv+TGXf636nRYHw1FwjlWug3umMpcCLB7TuTWq4in8/kFuGBHojqPnBStWaO2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10067.eurprd04.prod.outlook.com (2603:10a6:10:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 11:44:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 11:44:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 03 Oct 2023 19:48:48 +0800
Subject: [PATCH v4 1/2] firmware: arm_scmi: clock: support clock parents
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-scmi-clock-v3-v4-1-358d7f916a05@nxp.com>
References: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
In-Reply-To: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696333746; l=8554;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=c/OXxmNAJsNthHXSHkouIaDUXrqUc8uJxtJutrOHMO0=;
 b=3AJQzEVipLlguU+PHpnE3usfcokTObd5HPnPS9gjV3j+IGTIg3AYtVKQjvv14vzgFJcOg8v1a
 RVLFVN2eD3WBi932Ura0K/fx8wQnqaYJ4cPWyRhj6p9jVx8aPcmdtdx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB10067:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b7be88-1a46-4cb5-36f6-08dbc40614b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a52m+Iof117uijwyam+EiOjFxjHWApbOBt/IqvdPLx+i8m35IiU5GL2ab04COx80rP3+0Id5m7QdsO84bTCgrZrlTDojf4SmmgTGYH6vC+CjzuU295y+RNLhKk30IGcUEsKLllf02m8dnrWiSmdjJ/Nyhbo6BfvTv2kQi025HGxiK7k80siNQ5XGnsiFRpiTt8EG7yBKutrOvwoCr3G+T5wsFtzJyQTDvQO3cqs80BfgGIA57ZpUEKlYbPE+PhuBh2IiaMkU8m4GjdKlIXf4bJHC8Mm+1ooEteUtzPjI4MceFau3lp0yOoZxmGiLbx9gLiwr3HLLKSDG8E365RCP282xHAPWYIpdg0n6jDT0iKtoVr2t50ZALUg92kdQY9G/NLqPStn4JwKinRZicklp+dwlrdq9H74OFCRvMXT/gRdnG1IQo8zog8s0Rbaab6B3WuTnx0VB+XD1+7AOzpv3KbKS9m/ARdXYrqTwRSiyvRYQQedANVAT060jGoWF61Amc+gJ/CVJ2NOGY2vJaJgJZgOMgqVOvAmsOboWPMf28QIUGJTnQ+jsXGGfEitGj1cS0Sw5hLZ7HHh6dDXdPH9xdGxmUODhT3kgN71LZxu5AGb0swZE7SJVPqZCE5nouWxb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(8936002)(316002)(66556008)(478600001)(66476007)(83380400001)(9686003)(66946007)(4326008)(26005)(36756003)(41300700001)(8676002)(6486002)(6506007)(6666004)(86362001)(52116002)(38100700002)(6512007)(38350700002)(110136005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFjMXd6NGRuZ01HclVlTWdtMzFMSlRGbEl3K0lDbjdGeG92czcwTnBYcjlo?=
 =?utf-8?B?b0drejJQdnEyemk2cjV5VXVXLytIZkJzL2VoMnJRY2U4a1RXMFJkNjhUUFVo?=
 =?utf-8?B?eURzSlZMQmk5Sk5PMEJPOXBSYjVUVGJJUmpjUVR2TG5TM05XVklnTHNTWVhF?=
 =?utf-8?B?NTRocTBNdStyOG5BUVVHWXFvcVNnUzE0SWQ0bEFpemVscG9oWjdYb3lrOWc5?=
 =?utf-8?B?c3BLZDYrMTVtanRZQXhhS2g2SUhIQjNyaFRyaHQ4amRJK3hkcGZEZVNmVW55?=
 =?utf-8?B?VURrYkpSbldEcVpCbm5tRGZOSkV3YlFvaGdpdm1OV01aYjZpWFhIRVUzdkFI?=
 =?utf-8?B?MkZ6alViSW5PbkdLZjd6OU9oQmU1QmgzeTJLbUFLWnltMDBlajd1R0xWUzZw?=
 =?utf-8?B?a0k0YjVuMWxsQVpnVDJBVzJ0VkpYMWpSZzVLN3MvR3lYRG1oalUzcjMzZ0h1?=
 =?utf-8?B?c3JnM0VCM1U4RlVraSt5K0J4YTVXNFhnSk9tQmhYWjBvTFd6RU45Z3E2TDE4?=
 =?utf-8?B?Vit4Y3B2d2E1dDkxVHJSNlEyMXFGaWRveHp0RkpsM0dZSUsxZTB2UW91Y2VV?=
 =?utf-8?B?THdEeVdES1dZancyaXRDY3NtUUVPbnVRTTROc2UyTXord3g5SjNTN2ZKQ2cz?=
 =?utf-8?B?dXllZTY2SnhLd05yNTdQM0Y4a1dGL1ZOY2QyT3NjdjQ3aEJ4RHEzUkVNYkpw?=
 =?utf-8?B?c0lRZDBKQUNFMW5xZ2pheFBvZGh3ZjNtQ0lPd3c5NG1kU3o5K0lOeGxJbjBH?=
 =?utf-8?B?TlFoMEFpS0xSUDEyMEFSR28xSVhVeUN4MGh0S2JFQkZZekhIeWxIRERsc3d1?=
 =?utf-8?B?Ti9CdHF3M000ZWdERjhWZGgzR28ya0plODN4eFlQUzQrMEswdXA5QURVRG1s?=
 =?utf-8?B?TmE4bVQ1UlZ2NkU0NXVzK1Vic2tGbERZcEdZcHVXN1BSdWhDZjFNSTB1a005?=
 =?utf-8?B?cDNnV2Znd3J0VklYMnlYbExQb1lsSnpkZkF0alBhNHdBVVFuNE1rUFQrYy9V?=
 =?utf-8?B?bXh3YjhUQWZVRzg2ZjB3M08xeTN3emlVcWtKY0NOcHVxdzA0alhRY1FibGdv?=
 =?utf-8?B?NktNYnZjc3RveUJhamhYYlFLNkszUVAxZ1NCOGNpRDB4aWtSdFlTbUZQbVRN?=
 =?utf-8?B?cVNRL2pqTUtQUmN4QUpBSlRSRGtUQ053YzhmNWdzWERzVlE0MUlCSVlxK3J4?=
 =?utf-8?B?RGNTWlliOXRWbDJDYTBGZXI4WXBoNEJwQlFyMFVVM0ZkRFg0L0ZxWXRtY1Yv?=
 =?utf-8?B?Qnh4TFhINHBmekUzYi90RnhOTjNGZzlsaVFlaFlTNFFGWXJxTmVmbm1xRVIy?=
 =?utf-8?B?emtKbnBtVjVMV0srR2ZHRjB6VkZHQzNNdysxSVZJMWR2eWg5Q2hxY0huTWg4?=
 =?utf-8?B?ODY0L3lqdE8vUFRnTFVnR3BDNjU2NDVjZmo3d1dFRUQyeEVWT1F1UDhDWm5Z?=
 =?utf-8?B?S1dKQ20xT0RnOXF2NDRNbnZhaUYza05mdWFCakxOeFlFNWxDWXBWVno2MnNp?=
 =?utf-8?B?eXhialc3b2ZvT3V1Z3NVeEs2TjRVa1FsNFVmRjdxOXM3eEk3VkFxVnNoSVZY?=
 =?utf-8?B?dkNrcDBEOUlMVVpLaUZwdDZZZndsNWRaMHhleXdWYTdEQjhvNDhIaFJDZnI2?=
 =?utf-8?B?T0Y1V0tVa1cyMWRYQnFrQm9FZVdGWXdxZWhrODAyUnlmbjFpZ3VZVkZKN09h?=
 =?utf-8?B?NHdDUEhCb2tENE4vb0JNWFc3SitIZGxPWlQ4NENLQ3U4Q1BwdnJ6VXFVKy9p?=
 =?utf-8?B?YThtejJyUjdIV1hISWxXcUdtWEJQbVArMUtWb01uWkdVOWltanY0eUc1UE1M?=
 =?utf-8?B?SXp2ZVhrODBBaUlwVEZIWGxwZXVEdUpudjhIQ2krWUdaaFB1bzZJeUo0L25R?=
 =?utf-8?B?N2FyaDV2NTdtVnF2MGd4VjhRVEF2UGNPSC80VXNSbEcrS2RrVTdSdG1kVHRC?=
 =?utf-8?B?M0pZaFpMTlJyTmE2VmZQck9wSk1EaFdWZGdxb2NQUUJEZlRxM3VhVExUWEll?=
 =?utf-8?B?a3lFcWtTeS8vci8va1Q0amMvYzlOYi83SWZqNVMvMTM3WEZIZ1QrMTZIL1Jr?=
 =?utf-8?B?bHBQWC9LYys3WExwL05LdUQzaTJ3OWR6SW05ZUo0VVBMblAraWQ5WDQ2cjMx?=
 =?utf-8?Q?Jpw3DlCA2AOCHEO6LKgQ4kCyX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b7be88-1a46-4cb5-36f6-08dbc40614b4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:44:20.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSTku0kcwphQ/hdYL9hAum8oKeaoVQDFbCXDIbyUDc7JHcURYXXQ+5xpSW/kriGDOU0FDIV7BGkR9Nmbpjfjlg==
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

SCMI v3.2 spec introduces CLOCK_POSSIBLE_PARENTS_GET, CLOCK_PARENT_SET
and CLOCK_PARENT_GET. This patch is to add the upper three new
commands.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   6 ++
 2 files changed, 182 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 9c0e33c1efab..ddaef34cd88b 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -22,6 +22,9 @@ enum scmi_clock_protocol_cmd {
 	CLOCK_RATE_NOTIFY = 0x9,
 	CLOCK_RATE_CHANGE_REQUESTED_NOTIFY = 0xA,
 	CLOCK_CONFIG_GET = 0xB,
+	CLOCK_POSSIBLE_PARENTS_GET = 0xC,
+	CLOCK_PARENT_SET = 0xD,
+	CLOCK_PARENT_GET = 0xE,
 };
 
 enum clk_state {
@@ -42,10 +45,28 @@ struct scmi_msg_resp_clock_attributes {
 #define SUPPORTS_RATE_CHANGED_NOTIF(x)		((x) & BIT(31))
 #define SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(x)	((x) & BIT(30))
 #define SUPPORTS_EXTENDED_NAMES(x)		((x) & BIT(29))
+#define SUPPORTS_PARENT_CLOCK(x)		((x) & BIT(28))
 	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
 	__le32 clock_enable_latency;
 };
 
+struct scmi_msg_clock_possible_parents {
+	__le32 id;
+	__le32 skip_parents;
+};
+
+struct scmi_msg_resp_clock_possible_parents {
+	__le32 num_parent_flags;
+#define NUM_PARENTS_RETURNED(x)		((x) & 0xff)
+#define NUM_PARENTS_REMAINING(x)	((x) >> 24)
+	u32 possible_parents[];
+};
+
+struct scmi_msg_clock_set_parent {
+	__le32 id;
+	__le32 parent_id;
+};
+
 struct scmi_msg_clock_config_set {
 	__le32 id;
 	__le32 attributes;
@@ -168,6 +189,99 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+struct scmi_clk_ipriv {
+	struct device *dev;
+	u32 clk_id;
+	struct scmi_clock_info *clk;
+};
+
+static void iter_clk_possible_parents_prepare_message(void *message, unsigned int desc_index,
+						      const void *priv)
+{
+	struct scmi_msg_clock_possible_parents *msg = message;
+	const struct scmi_clk_ipriv *p = priv;
+
+	msg->id = cpu_to_le32(p->clk_id);
+	/* Set the number of OPPs to be skipped/already read */
+	msg->skip_parents = cpu_to_le32(desc_index);
+}
+
+static int iter_clk_possible_parents_update_state(struct scmi_iterator_state *st,
+						  const void *response, void *priv)
+{
+	const struct scmi_msg_resp_clock_possible_parents *r = response;
+	struct scmi_clk_ipriv *p = priv;
+	struct device *dev = ((struct scmi_clk_ipriv *)p)->dev;
+	u32 flags;
+
+	flags = le32_to_cpu(r->num_parent_flags);
+	st->num_returned = NUM_PARENTS_RETURNED(flags);
+	st->num_remaining = NUM_PARENTS_REMAINING(flags);
+
+	/*
+	 * num parents is not declared previously anywhere so we
+	 * assume it's returned+remaining on first call.
+	 */
+	if (!st->max_resources) {
+		p->clk->num_parents = st->num_returned + st->num_remaining;
+		p->clk->parents = devm_kcalloc(dev, p->clk->num_parents,
+					       sizeof(*p->clk->parents),
+					       GFP_KERNEL);
+		if (!p->clk->parents) {
+			p->clk->num_parents = 0;
+			return -ENOMEM;
+		}
+
+		st->max_resources = st->num_returned + st->num_remaining;
+	};
+
+	return 0;
+}
+
+static int iter_clk_possible_parents_process_response(const struct scmi_protocol_handle *ph,
+						      const void *response,
+						      struct scmi_iterator_state *st,
+						      void *priv)
+{
+	const struct scmi_msg_resp_clock_possible_parents *r = response;
+	struct scmi_clk_ipriv *p = priv;
+
+	u32 *parent = &p->clk->parents[st->desc_index + st->loop_idx];
+
+	*parent = le32_to_cpu(r->possible_parents[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_clock_possible_parents(const struct scmi_protocol_handle *ph, u32 clk_id,
+				       struct scmi_clock_info *clk)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_clk_possible_parents_prepare_message,
+		.update_state = iter_clk_possible_parents_update_state,
+		.process_response = iter_clk_possible_parents_process_response,
+	};
+
+	struct scmi_clk_ipriv ppriv = {
+		.clk_id = clk_id,
+		.clk = clk,
+		.dev = ph->dev,
+	};
+	void *iter;
+	int ret;
+
+	iter = ph->hops->iter_response_init(ph, &ops, 0,
+					    CLOCK_POSSIBLE_PARENTS_GET,
+					    sizeof(struct scmi_msg_clock_possible_parents),
+					    &ppriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	ret = ph->hops->iter_response_run(iter);
+
+	return ret;
+}
+
 static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 				     u32 clk_id, struct scmi_clock_info *clk,
 				     u32 version)
@@ -212,6 +326,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_changed_notifications = true;
 		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
+		if (SUPPORTS_PARENT_CLOCK(attributes))
+			scmi_clock_possible_parents(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -229,12 +345,6 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
 		return 1;
 }
 
-struct scmi_clk_ipriv {
-	struct device *dev;
-	u32 clk_id;
-	struct scmi_clock_info *clk;
-};
-
 static void iter_clk_describe_prepare_message(void *message,
 					      const unsigned int desc_index,
 					      const void *priv)
@@ -458,6 +568,64 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
+static int
+scmi_clock_set_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 parent_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_set_parent *cfg;
+	struct clock_info *ci = ph->get_priv(ph);
+	struct scmi_clock_info *clk;
+
+	if (clk_id >= ci->num_clocks)
+		return -EINVAL;
+
+	clk = ci->clk + clk_id;
+
+	if (parent_id >= clk->num_parents)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_SET,
+				      sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	t->hdr.poll_completion = false;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->parent_id = cpu_to_le32(clk->parents[parent_id]);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int
+scmi_clock_get_parent(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      u32 *parent_id)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = ph->xops->xfer_get_init(ph, CLOCK_PARENT_GET,
+				      sizeof(__le32), sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(clk_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*parent_id = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
 /* For SCMI clock v2.1 and onwards */
 static int
 scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
@@ -650,6 +818,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.state_get = scmi_clock_state_get,
 	.config_oem_get = scmi_clock_config_oem_get,
 	.config_oem_set = scmi_clock_config_oem_set,
+	.parent_set = scmi_clock_set_parent,
+	.parent_get = scmi_clock_get_parent,
 };
 
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 27bfa5a65b45..f2f05fb42d28 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -58,6 +58,8 @@ struct scmi_clock_info {
 			u64 step_size;
 		} range;
 	};
+	int num_parents;
+	u32 *parents;
 };
 
 enum scmi_power_scale {
@@ -83,6 +85,8 @@ struct scmi_protocol_handle;
  * @state_get: get the status of the specified clock
  * @config_oem_get: get the value of an OEM specific clock config
  * @config_oem_set: set the value of an OEM specific clock config
+ * @parent_get: get the parent id of a clk
+ * @parent_set: set the parent of a clock
  */
 struct scmi_clk_proto_ops {
 	int (*count_get)(const struct scmi_protocol_handle *ph);
@@ -104,6 +108,8 @@ struct scmi_clk_proto_ops {
 			      bool atomic);
 	int (*config_oem_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			      u8 oem_type, u32 oem_val, bool atomic);
+	int (*parent_get)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 *parent_id);
+	int (*parent_set)(const struct scmi_protocol_handle *ph, u32 clk_id, u32 parent_id);
 };
 
 struct scmi_perf_domain_info {

-- 
2.37.1

