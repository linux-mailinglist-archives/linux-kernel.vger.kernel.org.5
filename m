Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5F7B752E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbjJCXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjJCXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:37:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD135B8;
        Tue,  3 Oct 2023 16:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AROiA1GTDZwYoc2YlJIdFrE9/BT9SQB5LQCJIBrny98+uqyMwT3SzlH0iKvMLJhcfzTxp1UnDaMWVM/Y9kiXGpzVQC1+7HSn5NGiT2Y1OJ+oacpnTA8HfFfCRtqDOZrmddzvNzyZyLbCjNg5jIKHpFkAGhME0QgZqwHIDL3MXJ0uU+xFxiM6Ye6dYymeJztXLMSy6lmRygbVjlEJu6/zX0ylA3WKvARzoSHvP0Esb4Sp5XdlmuzYchHYtULqgCm3+7tOgURjZS5Hc+oJCyMtkzH9p1BPNSKApQomwlW0nygUd8k5IsbXSDz68fA5e8cvNGAD4p7PNJZVFniZkq2J/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDaMTsSdyXwdGgx/APFq6ktvOfPiHQM8TN3MqsyHXZc=;
 b=J/ybqINsTCwYghVxNPQgNJUGWaY6CVVsFxuTNtGt573ekHTqOo7wW9L+qsb3eNi9xlqMRcmf+8fXMoTm86oLVaUAv6c/tqkq/MWYvL7+TVvHPhbIEnAQ3t7PvkY7bp+u7zBzM7YEHrEt0n/Y1g+H2XRzARy1z0SKyPoT+W7EIDjf+Q0dq3H9W4g/AKnSexIcSHrO+oRWlaWPMbLUzluQfl+g61BwnvkkYHFw85TBSsNgrAAp+96SGlqqjecnR9sECk04VkwCWsNMdhUQGU5Yr4J7MCNKNxLGI2MZv1tgw5SdWDQdMlAXgfF7NKXIwiV8v6GGtN9rElpI5Mil8F1IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDaMTsSdyXwdGgx/APFq6ktvOfPiHQM8TN3MqsyHXZc=;
 b=mdPEH8CKCiQGGSVaVqRtdq80YnsaigpjMpcUL8lRpDm7sJ4toij1JYinni0R0QmPsYaoEe+DpNwwsoTa55u1RXK/DsBcXLWj1wO510d5k6FhSDQ52iEGX7TEL4MgghNeY4GxFR5jsfNm3IYTSXSY1ZHvQGJJRfDofZb5dgPwitk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8754.eurprd04.prod.outlook.com (2603:10a6:20b:42d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 23:37:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 23:37:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Wed, 04 Oct 2023 07:42:23 +0800
Subject: [PATCH v5 1/2] firmware: arm_scmi: clock: support clock parents
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-scmi-clock-v3-v5-1-1b8a1435673e@nxp.com>
References: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com>
In-Reply-To: <20231004-scmi-clock-v3-v5-0-1b8a1435673e@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696376552; l=8554;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=c/OXxmNAJsNthHXSHkouIaDUXrqUc8uJxtJutrOHMO0=;
 b=eOTvYWlg3imR37GXpil+xZ9ye8wZAWHXGAk0QoRzTEY6C/FcuTXC/ZmqtKa93XtoaQqNrhHDK
 vEyg4TNbzs5CdkoiE/XGYgVFRjvDqyrBx6J2czp7Sdi0f4DRJb1v6f2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 519e3ce4-fa99-4bc9-8817-08dbc469bf28
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ah+B6VA2LBJ63S3D5IznIcclvxYTbB0h8fj+huHFKebeVDc/WJSozN0nOYMT4IvZN9brmQrhKyWr6bFRVGzclU4GqJaPPqRVBMYiXi55Tn7iHs46IXxBjxduxw+k9RC44caKjPINTufSCmANY8cmvch4+fvMWYlXZtTFb8GSOUYwZsiiFD9XW71ui8icEvZm0WlNQ8xm4quFubKh5whcFv4gcA1gdKuM63QtgSepmfJSrnNNuR5hL5iA5ML4dN1oZMvCTU4PlPDkwI7LG/Yx98m4CMFZTLXMl5GFQyVAzyKS1NhgYwTvnh/FBCtenrA0pdsFzayc6fHlNXBDhwvtA1H6ILaBEDWdoqJvnbDtoPjFW4JHwa5VdYnQHXH+1Or6JIRSEWOJ5QHh+r9J89RThlXFfDempEomQR1fUGcUohmCkQbm1WivYZLfdHdN/ZLQC66oX+y/VsXH8WDmNuB6j4oY3oMAOfsmXMSKrSm6urv6qGJm1oZxOXioDnnaFdiTbA1/GfZHDx8NH/zuCH4H5abMkpe7XHt66QNJz0eqf1NoAdgexwWYCvWElIwmaftN4Qk7+sZk4nTcsK3IyTV6Nt6c8khvZv5FXU4sgP8xO4PNwI7bFBVxfuERekuVuP8w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6506007)(6512007)(6666004)(6486002)(9686003)(52116002)(478600001)(83380400001)(26005)(2906002)(4326008)(110136005)(41300700001)(66946007)(66556008)(66476007)(8936002)(5660300002)(8676002)(316002)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9rbCs2SHdpd3FXcDZHWm1LTDFKaGJkb3BDcUYxZXA0QXU4QjU4dlVieDdy?=
 =?utf-8?B?aEdiRGNsWTN1VWt5amVzOVRWbVhQUWVqUzJZcTZJRkRIaUVSWlpPWkx3TVVk?=
 =?utf-8?B?RGdQZHRNZmtyR2QwMDNDMm52UnhMbzhudDFodlFMRmpnVVc0eHFkUWxHQS9j?=
 =?utf-8?B?QmRFbmNUNk1UUVJrajRKY05FVWFQaDlMSDV0RDEwYjA3K1U1YzNpWWhwM3k0?=
 =?utf-8?B?VXgvZHY0NGphV3NaYnUveGNYUDhpUkowZ0FLSFZGbW9qcC96M295cnFRZFZJ?=
 =?utf-8?B?M2pBTHo3SmR1ZCtzRTlCbW5xbGtMdXJ0WFlvbVVXMGlkRU1xc3lSN0RwMXFk?=
 =?utf-8?B?OC94Q0xBcDlsQWlJSWgwdDJWLzYyUjhmUXhCc3F3SGtmZnM5TG9GZCtPdGky?=
 =?utf-8?B?UjJmQ0x3YWlGMkxnZHdTODdSejhBbnN1MHZ6YkY3eXQxbW9vU0RTN1N1NEJ3?=
 =?utf-8?B?ZXhYcUtaUnlpUjVSdGNaM3g2eFZlRXF3ZS9HTC90aVd3RjE0ai9PdnRHc1pR?=
 =?utf-8?B?L2xvSFVtV0NRZGViekU3aENXZ2lSbVBzd01rVUtqMlg4eVB0eDA4L1YyL0Qz?=
 =?utf-8?B?Q2k4NERidm5yc01aMzdDaElIZmNVM2luQTJoMCtrQXNkSnliWWZOYzlRMXVY?=
 =?utf-8?B?dTZjaVpkWU9FYlZFUHhZK1dlWlBETExFQnJDbFVYQ0NrRGV2THdjc2RMcWdK?=
 =?utf-8?B?RmVFRzFZZG1HQ1B2MXh6MExvcnZVeXdqOFpyeit3WnNuSWs1Yzh3S3BpWVRu?=
 =?utf-8?B?azNQaEIxeld4c0JyTkRaUWZSbHZ5Q0xtT003dFFja1YxYWtmc0RwditnSHdz?=
 =?utf-8?B?WGkyR3loODJ0ZlF0dkZUTFd2VEdLaFZrdEw5RDdLSVc1bU4rcEN6VXpoSUNj?=
 =?utf-8?B?d0xHSVJndEZFakJGbTljUGZya2V1elZ2N1ZpQWNJQ0R1QW1BTEZQa0dId1NJ?=
 =?utf-8?B?d2lGNDBuS2V2dFowdHp4SjkxVW9paForNitsaEZ0ZU55NmhhN21jY0VhcHVO?=
 =?utf-8?B?STE2ekd4cHJtcTRCWjM0M1JYWWxuVFZZdUlUelFTMmdpaTVlTFMxODgwajdF?=
 =?utf-8?B?RWVCWWZnYldWcEIzeC9HTXc3YWduRSsvL3ZDUWFla1Z0Q0tWUkZCN01JVER2?=
 =?utf-8?B?NjBjN3c4REYvNVJOZG5xdjJkWEpaMmxhR1VhajNrVXZnempnb0NiTWNQZGlN?=
 =?utf-8?B?NTNudUdlTnYvZ2poSmd3NnRtVjFhSnZSc01OL0lJYVlYR3h3R0VoNTB6ak8z?=
 =?utf-8?B?VTV5US83Z3VWczMrWWhWNlpYM1I1TXRoT2g5WmV0UmowaWdIRUtDWUUyVGt1?=
 =?utf-8?B?bXprOUxZRE5BTEgwc2VZTUZxWmtPQ3N2Q3oxa0dJU1RneldPbUZvL0ZYczQw?=
 =?utf-8?B?ZzdPM0lrcmgrUXVlU285VU9PZzdxZGdVTVpVWW1OdFpMaUtSbXcvNWFraEgv?=
 =?utf-8?B?MnZuell1SWxUUjR2ZXBmRlRha08ySGtOc3lBWlQ5bzJDN1FTai9pQWkwY1Fk?=
 =?utf-8?B?NXBsZjZFZ3V5VUxac1AwTm9IV1RQMzhpNHdUakExS2c1UGFaNHVNYWxNNnJh?=
 =?utf-8?B?bXptNmp4bUoraWZQU0w5NzFENFVQVndZR0o4SnVYODBkc1BTZzZ2MDR4U1BS?=
 =?utf-8?B?dGVjWXVYR3dWZnNobU5iVkJLdFpHN1hrU1hFQ0FPZEtxVWxtcXpURkN1Sy90?=
 =?utf-8?B?WVpJaG10QnRVZWhrMzI5WGtML3RaOGJUT2w0SUVTQWZOMU44ZlB3L0dxMjNR?=
 =?utf-8?B?MDhhOXRQaDBGblg3SmtPU1RhNlE0S0R4UWZmaWF0L2tHQlhYOUloem5iWkN4?=
 =?utf-8?B?aFkrd25kaFpzdVlUUXNvc0pWM21GWVFLbzliNmNocXhvQ3hFOVRqSHBpaHZn?=
 =?utf-8?B?aWtpY0FvZjVkZXB0TFdmSjBWWmVnaHkzandUWDMrelN6YStKMTNJUXNsaWZ0?=
 =?utf-8?B?d1RQYURSZk9CM3FMVUpLL0djMlhrUW5rUWFvaDhhZno2MTJ2UE05Yi9VOUwz?=
 =?utf-8?B?emRqUkZFMmh5b0RwRWYvWXNPQWdFcWdoa09QR084NmFGT0Q4Uis1U2tMTWxH?=
 =?utf-8?B?NFU2NjJDK0o2KzNhbXZIM1BHYWdaY0EvM1hvNlBQNExDL2RVdkVlRmpEQUgz?=
 =?utf-8?Q?g8rOwboZhSlqID1HozvH5r8ng?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519e3ce4-fa99-4bc9-8817-08dbc469bf28
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:37:46.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoiK9zPqVd7Pama8ivtD/QfWWaG+2ggat3mjHWqeQ19kBbSkdaMyw7rQewPOMXvxX8TM9/3FwFPVbsMZFi4Vzw==
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

