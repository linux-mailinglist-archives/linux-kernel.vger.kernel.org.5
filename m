Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0687B453C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 06:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjJAEeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 00:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAEeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 00:34:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B15A6;
        Sat, 30 Sep 2023 21:34:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4HnPup76t5wa6iMN+KfwmTAQ4joRyIz3Wov04CFSMh/Ctmco/rvuVvGnpN1jKdNB935sEQvEvdAEDNFVFUeD99q+NORrAx65r8f+YC+xMeWtGR0nkHEl2exVQEod54uat8cweZXx2I/Zyb0QuI4AOrv2rkkLhRKRZvc+z13n7HzGnXHbKmXNYNfXpAyXbZU15StkHuN2TET2LaXKKhkbxe3DZ2Z1+IA8kNMKn/KnFNc40uQxZjpNn7F7q6pzqdVuIzFvgsd3gSQFgWx+wbWTZ5VyA8hvjgTolJYHVwzVhZHhaGi1R8wNcAyKQMGuM52i6aSc7fVY+/Wz/YQvd4jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDWZg28iU11kqaOdvitaddmih8kAAzFRpfJyWHUBXt4=;
 b=Jh6KQIFgt6g7+FPnfKASkxFcs9xzGzg08ZzzGQUkxwo0/o8+ayHXI38UpEmNCFBnHmniEd7n6BL9gPFp1oxXPkaPVF31/YdyuPlAXUGymOThvZk4TGgybzsqnPj/vmPnKHgzQ0v0+StcInZkGe69zJXCOyQRH/JW5UBwgnYXmDY4bbYwJiFLyzwc4bPBAozfKGTNc2c6AbBfM1IrkiWsMeCqFbIFBVM04ibc955MIiK7zftlk/pEd2U8cd3sEIE0KxhQ7VX1uFeCOhUhZt3atAnQZOytYjpTh2S38NhtMSlPcwrk76+tFK8FkApq4tqS1ksSKKFXY+CsXTTDOKJogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDWZg28iU11kqaOdvitaddmih8kAAzFRpfJyWHUBXt4=;
 b=AqKrlXHkpX9XupJP6XVfQuM6J+sZ0mcQzaseDcfAc60xEtcRwGyMdHgNUnM/dkSZD81vV1SjZlx75AqNP3MXSZBreHnljxj2IHtxJ/Dg4N0REFvTABo0tEzoamhLQyQaMC+P/Zh/r8ZJaNFxEjzf/nmsqphDZLz1ibJqg4fa6vI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 04:34:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 04:34:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 01 Oct 2023 12:38:43 +0800
Subject: [PATCH v3 1/2] firmware: arm_scmi: clock: support clock parents
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231001-scmi-clock-v2-v3-1-898bd92d8939@nxp.com>
References: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
In-Reply-To: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696135135; l=8518;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=SDllrj0vZP8gvMNHNp2vykuCQP3J0H324haZC9h1guw=;
 b=+ycFZW71Hi3Kgq9gmDsztR7zkDjiSP7UMTocQjuNsuOac06lXWlwLKcgSSuS8K9cdT1QEasTD
 MNhn0xGnSF9AkwcH3VxFT/j3dlYviQUsb0VbMl+eOXHYN55m4rEZxPT
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f225a5-3c89-447f-ac78-08dbc237a76a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E0tvRZoe5udtJiD4FO9QZN7FHn79pOGGXhnnIbCon7iIFI6BlTOzdrSkmBUMojigkRpd9lknBuBSt57VVOJRtlrYKy88n2AXNdwTJZMAMDyqQg8aViZb4HmJfnktCo1+Fa/Z3gi7TJwjqBM/RQUA4eEwAmI4Ib65BmCqr1pc3KENmMQz2S0Rf3K9R1NMQOyVVUFn71iEHtOEYOXxjJDcYBqjOOFcwdu8DrLAybdZ4C+NjQ3sfuj99LIkExC0qRazfY4/xrtqTsiAXNFnX2QbPhLtwa8RFOiDtRiSjvOAZqDXGhJgI00nlzhG8MtcLfgLOCPwqCUDR8eLRI07F2v6+0dVmRSKMnHvdDUNVb9LOu8atQRICo1Vrh6Powqe6tw+dbIvpGTbipNkjncQfCur3X+JpjN6P9RZIMDq6GYHiEBfCiNudSTxnP1hoHRFn1rolVXMmZVpeGF6Tsqw3p4+aZBsbvoNQ6IY08pzasWHOepxkaep271XHm6VUM2sZ/nHZ1lmtgVYvuTLWyDTk5ET7CX0Ma4s+uhrqXCArJxrwmphd1nSD79AM0073JAIlXea6OZc/ZOCNAaCnj/F8jcPWXBpXU7C6HJI1P7iPkAtvpbr2AonCoxohIbw5KNKz9M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(38100700002)(86362001)(38350700002)(36756003)(83380400001)(316002)(4326008)(8936002)(8676002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(110136005)(2906002)(6506007)(6666004)(52116002)(9686003)(6512007)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hiNExVYm1rWWxwSUFIVm5odzZyaU1rYkwzK2d0bVhuWVVyUS9BQWRESEZh?=
 =?utf-8?B?VmV5RWVVYmVVK0swNjR4clJmYkNVU3VqaU1tMDJER1VWbitwYVdGQ0VJdytS?=
 =?utf-8?B?ZWl1eUJZNmIvbFY3UzdoTzZXYWppcExINnYvWUFqNThTS1hBZjlxZzkyOTJj?=
 =?utf-8?B?Um9ydk82a2dDMW5HeithM2x2UGJjeUE3NERWYWpZS1YwS0g5UjFPdG8yQmZT?=
 =?utf-8?B?d3grVnE5RUZITUREbTJZL216N1ZET2RlWGVrc0NsNzV0QVVEWG5DTm56dm8v?=
 =?utf-8?B?UUNYZ1EyWG5mcC9pV3EyanJhWml2SUNIby91NlZQbUM2djYxT3ZhbGIzT0x3?=
 =?utf-8?B?T1hzaGp1QmpCbzVyclc1V1kvSTdqOWhRd0t2TmVPVFY0N2h6KzMxUkovdW8y?=
 =?utf-8?B?S0tBQkVDQ0JFaWptTWlYZkplTzhRUlc4MmREUTRDU3lMai9YeXpZL3FoMTB3?=
 =?utf-8?B?ZHJYbSs0bjN2bnNkVjBkTjVUNU45MUg0OHpKUVRGbEs4L2E5b3AzSnFpazhI?=
 =?utf-8?B?aEdZUkdnMEQ0OUxOZHJsTVJxWnVDUDBEL1p4SUdlN3pub1Uza2JGcWxyVlV4?=
 =?utf-8?B?eU93TUNIVC94K24rRkdnVGl3eS8xMlNlYy93d2Z6blZPMFdlajZlNVg4bWEv?=
 =?utf-8?B?M2kxY2J1ZWpEM05DRk91QVM1dndscDk1YjQrbDZyS0ErQVpoYjZpaGdVV2JE?=
 =?utf-8?B?SmhWczRiRTdnSGVvcXdTQ3c4Q1RFc3FqdCs0Q3dWdFVNOTBTRFQyMUxYQldO?=
 =?utf-8?B?R2s1ZkpySlNia3hNRW1sd1BSQk9nekRCc3NQZm1YcVJxdktkbC9hUjMzOGlq?=
 =?utf-8?B?ajYwdGVRU0xQQk5SUi9pMElPZXkxd3Q3TGxIaTcwb2hXcnh4c0wzKzJhQVBV?=
 =?utf-8?B?Ti8yRnh4Zi95c3VLdVhSSm5Tck5jTERWSkt5YnhlcjluTzQ2MVJ3cDdHNkFo?=
 =?utf-8?B?Qy9acE1JbE5FdmtyNGxDNjJLalAxN0txZWVrTlYvRTE5bCtrK0dHck93c2t3?=
 =?utf-8?B?aUFqRnA5V1h1TDJjTFgxZlZkWC80UGVQaG9BU29LRnBTV1RYWno1bHhqU0p1?=
 =?utf-8?B?SlJ6Z0h6TzFrbGc2REpGS1JrQmpqRjc5Njd2U2VPaHlnS2JDdzNyU3NUTzUw?=
 =?utf-8?B?M2tibHNaREdxakx5NDV0WmVqOGhjUCtmVS9UMzZUaU12dUZkcjduQ0hKMSty?=
 =?utf-8?B?S2hHcUtsaExad2xVcGk3N09nTUJwL3JCQ25sRVZ4c2RVMHI0OGFtcmorL0J5?=
 =?utf-8?B?L1dJNU5TTWg0WHJnTlJqZVVpWFFCaTBUakpVWGtoYXJoMHFwU2RGd2YzNDZY?=
 =?utf-8?B?SnBaQkkxVitPUTczOXRSVGVYRkVPem5rdnIxdzBSUzJrRGlFU2pweGErRnMw?=
 =?utf-8?B?VTNHMGVzYXhlM1RObFJWQ2x3YXRTZ3lpa09qamNoK25BMFB1b3IvSEpvL09B?=
 =?utf-8?B?bWVJMCtzWUs5dldJRzVyeDFvY0pwa0lKelRFa1lZOG9RNmY3dHozZiszMXZp?=
 =?utf-8?B?djM0bkJYOWFqVEFWU2pLcVpXU3pQZEtqZ2hXOFBTRGQ2ZnlqUzI1Wk9ONjRi?=
 =?utf-8?B?MGhNc2hJeU9COVpmZXlkYTd4ekJ2aWZ4WmJlWUlicjNiZk9JSUhLcXlhTk1O?=
 =?utf-8?B?THJvQjkzWVBNU1FxeGUxbW9hdkgxZ1FySHFzeEcwRm92ZWFLaHRwajUzZ20x?=
 =?utf-8?B?Z1F5L0Jkc1ltY1RkZFoyZHU0dG81ZmdSMks0Mk8yWEtuK0V6Z2o0ZnNDeU9O?=
 =?utf-8?B?V2FEbTVHeXowa3F3OHFWb0hnelJSVnFMVDZ3a3ZlSU1RcDdjdnJ4RnJFMVJR?=
 =?utf-8?B?UGVxT3J6N0hTUTdNeUszZVQ0c24yZjZsMC9ROHcvdmVCc0tEdFZEa2h0M3hP?=
 =?utf-8?B?TERVSlFWYVJHdWdDeitKc1FlaHZQcW44UFBORDhMMmowZFdnL2JSU01BSVBK?=
 =?utf-8?B?VThyRWd2ck9CNnpQK3pacUZKUVRkUGluZXQ5ZWdRazdrblZ5c0JjalpzWDdp?=
 =?utf-8?B?MmVSWmdXQUFlNHBjQjkrejZyVFU2MDhvNytJSDVKL3JrUlNONDFZVG1odG9S?=
 =?utf-8?B?amZFL0FrUGJ6eHNSNjc0YWwvZml1WCtLT0RDV1lYSFY3L3JaYVlmRUlpank3?=
 =?utf-8?Q?nkOy/xXnO/g1eWK0R6cDM+TPm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f225a5-3c89-447f-ac78-08dbc237a76a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 04:34:09.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPYZ/Dur/b5gmdCnEAztJvy7RcZ5DHDcPf4S8TkSk25N6XFovTBo5oRYU+/ko7OIMx7Da4J6R19UKFIcEd/CPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   6 ++
 2 files changed, 182 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index d18bf789fc24..9b95239d63ae 100644
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
 struct scmi_msg_clock_config_set_v2 {
 	__le32 id;
 	__le32 attributes;
@@ -167,6 +188,99 @@ scmi_clock_protocol_attributes_get(const struct scmi_protocol_handle *ph,
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
@@ -211,6 +325,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 			clk->rate_changed_notifications = true;
 		if (SUPPORTS_RATE_CHANGE_REQUESTED_NOTIF(attributes))
 			clk->rate_change_requested_notifications = true;
+		if (SUPPORTS_PARENT_CLOCK(attributes))
+			scmi_clock_possible_parents(ph, clk_id, clk);
 	}
 
 	return ret;
@@ -228,12 +344,6 @@ static int rate_cmp_func(const void *_r1, const void *_r2)
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
@@ -457,6 +567,64 @@ scmi_clock_config_set_v2(const struct scmi_protocol_handle *ph, u32 clk_id,
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
 static int
 scmi_clock_config_set_v21(const struct scmi_protocol_handle *ph, u32 clk_id,
 			  enum clk_state state, u8 oem_type, u32 oem_val,
@@ -647,6 +815,8 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
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

