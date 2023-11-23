Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C17F6234
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjKWPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345976AbjKWPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:00:43 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD5CD4F;
        Thu, 23 Nov 2023 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS+B9jCqp0d+Lz1Gm8ZbW4aZU/qUGnZE7bgi30p/y59tA/8CPI0829Lq7hljyKnLqsE/BnFLCaecGtk5i96hzzgB3vliRcQKMAf18nyAmihQ5flNj1EL0uISrzDK1lzFHtnktJuPiylBsqqyvLSnnjRtmVNaE5CPG1QIJpvksdFs0Dsc0ckwvUKtUW/DAzNldTse2K5bnAL3y3/kkQB/CSvUdH4oQDvu7p2r9Zr5FlUt6p8LxZGk6jJ/aatnxDQAMihr1i2V/HMqZYh/Wxdf5pLtI9R+7rZ/DnGqs+qbK76qA36TorMmpO6kEdILkUI/5hGFxOw7mscSsXh7HTo1kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=empYRnMbJvreOnSrmQknKcd8rvwklzlUIKeqT3Jv/rg=;
 b=Ts9fvcXhh/+6ucJTACIiC4coFn0PTRQKlHaAAfkgg5FG3kWRPrp8QRzx+aUqnBqWLJAdZg/JMT0aLu2ukBzEYhk0gEWQVmzB9LzDki/75z4bsVCeh1eK1QeXnuYm0ZMLrAIiUcdZuJY0hjWKs86UZGv1l6ScNJ17ie7Q2AfgPXPLPbfBfl2xF11TcOk5c4sPqX5lgIjY4TXG1CRATIg517FKXu1Jq5eaxdlh9n92d9EbiZdG4jgkt6CBqtgvV/j3FVfmtrxkdgDfoqIMRCJEFGut/oInJNCG/bIatpLOyB5Z8PUq9l7ZHYTRZsXrn+Njk36pP4rH6rx6r8ZJvQKbSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=empYRnMbJvreOnSrmQknKcd8rvwklzlUIKeqT3Jv/rg=;
 b=EbR+E9AZBYfRpj/mUn0IoC7GBLR9UpTJKMjLtpQKSgVKyOKnMDNRjTJqED0uQJjPdOI01uphk5udHOL9YIVDe+QqkdSK6Rom/zVXRwxz4cFSosDW7b6tTDEfIIOh/jIkDA4/k3Xi1jmZqbAC6GXWtaHnAlAxS9pPMNiAvaGcZbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:00:46 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:00:46 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: [PATCH v2 1/2] ASoC: audio-graph-card2: Introduce playback-only/capture only DAI link flags
Date:   Thu, 23 Nov 2023 17:00:11 +0200
Message-Id: <20231123150012.154096-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123150012.154096-1-daniel.baluta@oss.nxp.com>
References: <20231123150012.154096-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ce55fb-2fce-4038-513f-08dbec34f8bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3CVaYL36QAqUHwYyLZg1pHih0kxoeW7vR5DGDphOxTDhft1v0lzeJ8NC/hby/M916I8XjUp8G0ES40743Iaq94xHDC5LEygJcj35WgecPgwsSDA7t4hV3w/n+mwGLzt1VnzByg4PQ4EsfiWeIX8vOuYD7ba9WZGHT5j7hJUAIP9ETNymaXojnTNZW3uh7/cJHRvR8izhDOHaNh2Lb7m+tDPKs5DLHLFOn5ZqeBTDcst01y8oOfF6dvkhPPF/D/XLuWebQnhexd7Ac2ePiAxFK61of+H8x0fst0QPGYC61NoOaiNhd7+met7II4VT8Wg90V1A3UZpN134Q7xulmSpByiw46GEuz6lTzjF0ip6eEMCdO8Jw+9keLtqeB7PxyLG/9Yw/id9hV25EfLsxK+fTc4DWBEQkb8KVd5wxdiQFy9J6eIbCRlgT+YEYvgciwajFPYH7Jie2H/CAcVKluC8kmNCHccRB7+AzQFg87T7IFgT44re5Y+VRllHugjVt/SUu/+8/UU+MwQvO517JuNvuSse2c9UKKRPzMUuPmQo5ymh/Spbwca4D/fzDhURtgjLioownbKmwczAH4diGsmF2RVJw/BinLkcmRpoFUyTKcFP/mImiWFa6BleD09Bpq4ibbLqUuTQjffDD1GSbiU2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(38350700005)(2013699003)(2906002)(5660300002)(86362001)(83380400001)(2616005)(1076003)(26005)(66946007)(316002)(66556008)(66476007)(44832011)(478600001)(52116002)(6506007)(41300700001)(6666004)(4326008)(6512007)(8676002)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kGi4xRb65qs09VK64GT8pKSuWm7KG438+LsNO7jD8Mgk59hXkuencyajGGR?=
 =?us-ascii?Q?HiIZLKL/cI07R3QbFMXJtmVEXwT7vFds5sF+OsOQyF/azon1OfvetZNc/IsH?=
 =?us-ascii?Q?j892d9izkJlqCk5tQkHK8hVy4v0pvPtg/Vjgi2AzupU3+ii3+6YuwGKxZd2z?=
 =?us-ascii?Q?O7TE1h8Og9Uw2oMut4NqApYuaNR7RTGoQp7LtxiJm5zAyiONIgiNN35iUm3m?=
 =?us-ascii?Q?cwNDtOXpvf9lewt8QxyL13nADu2che4xIf4yVfgqhx+oWXzqD7W0o/Z0639C?=
 =?us-ascii?Q?VK7Vni9KWcIuT7BCS/NFh0JnJRt6HBPTEVJisxm1w359UVQlhKMQCXw8wngf?=
 =?us-ascii?Q?XirhHGWj+xDCwMLWeiHU6eCrz/4XJtQxSXw61N945Stvi30wir40UXPwd4ao?=
 =?us-ascii?Q?us9Utto/eUmfENc7HzH2sGKh3aD10I2ADQ1lPB4emNZ74LhIwS6h/nBanGeS?=
 =?us-ascii?Q?ZSTvyMtgoLI9hS5Zl1qPeN8kGsGIPH2nWkurnPT/UqFFnPCZ3G7v9aTn/ubE?=
 =?us-ascii?Q?x58Ji/bIFg3jt8SMkSy6EM2arWrucRtFEzB4KFYQlyDNg9nS7qAwYjA52TEn?=
 =?us-ascii?Q?wF6AllcL9WBuxQNjn1EdrRbbQSVQHZ62PjKC5M/gTt6DnhQqweD78GK72rzy?=
 =?us-ascii?Q?KsreZn9kTe7k/xbJ/SFC25mizdRljHSCG2637eP0/B4ZpbzUDm1HSzq7Ua48?=
 =?us-ascii?Q?AOB5VfBVfZtLfnehCfaqoGVWw7WTWCgs5JAjT9eMlMRbbz3J0Uctd6TsI73K?=
 =?us-ascii?Q?vuIL27RFS9Cd88Q5jmWnlgMEG3WQgiplcJoIWaUTWC7CAYDUvvfQphevYbu2?=
 =?us-ascii?Q?jb/M2qnj/C0tyCVtRU0KhMv9CQL9Vd9oikPZ5IpIMh1T/aJPs9vu/FOzXHVS?=
 =?us-ascii?Q?WI4ggE6enOTh6oS8698NsG5PiuKs6s+oato5aO2vKO613Ochqh9gS+vcK7eI?=
 =?us-ascii?Q?S7cJb7jIPDqVCm7UKtZM8hORR/gMk+VdpsceooN1f2jAPwv/ntbpQzh0pfjN?=
 =?us-ascii?Q?xdD5bTqzKkjrgOBlXtgFqiO6ZhMpxbD/n+KsWAfFZXel6rXTUsxJtILFZuIT?=
 =?us-ascii?Q?OB4bS4eBztsfRftO+XLrNblA3NlRvXG1zqQgQKhOeqXHiG4QV5eWl5TOnueJ?=
 =?us-ascii?Q?jNax19sRq/lsygq+eveQXyi+W6ovfHf+fvsPsDLAq33iIk0xB1hoaaeqxCKE?=
 =?us-ascii?Q?U6tJ603SEskX9OaYa2IikwK1GWvvnzY49MYO95pbMZvRzZxmo8tmCcfWbO/e?=
 =?us-ascii?Q?0imai76/4tTgBYatcwOFp2RaLjqpbGUxJppIIK4wFDIVuT72H8oV8290XUWK?=
 =?us-ascii?Q?p4fPvv/Wohs9DOnvvLAmw09gFpY/6YL/Mp9txTHvoHDsoR9+Ct+c8lIZws/7?=
 =?us-ascii?Q?3Kgw9whrXp0eL4TB0ijYqIjl3sD6dqaI66QBNDr1j3gO4R39fm4eDXt700Dk?=
 =?us-ascii?Q?0v71r8Qi+TcoB9EiZO5dBNx50JEYA01urN6kkTysVBQXYkk3L9T5y2PRy0tZ?=
 =?us-ascii?Q?FPz+/6UlEQOnoUZbA+8N/wq5aASkic6/242LSpkPUQoGkCK2WSjNu1aoNvKy?=
 =?us-ascii?Q?gD3dRvK/W8CZ9pdTLYlvrNOgCUg3a9hKHJjfXyxv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ce55fb-2fce-4038-513f-08dbec34f8bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:00:46.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKCrXIrQFrFzJsE4qVQnMviwmJkghEcXiKRcO6MEZoL2laLacnWKcuqZaEpWOXE3Z96pxpioXbIgPiCpylGTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We need this to signal that DAI link supports only one direction that
can only be either playback or capture.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/simple_card_utils.h     |  3 +++
 sound/soc/generic/audio-graph-card2.c |  6 ++++++
 sound/soc/generic/simple-card-utils.c | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index e5da10b4c43b..ad67957b7b48 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -195,6 +195,9 @@ int graph_util_is_ports0(struct device_node *port);
 int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 			 struct snd_soc_dai_link_component *dlc, int *is_single_link);
 
+int graph_util_parse_link_direction(struct device_node *np,
+				    bool *is_playback_only, bool *is_capture_only);
+
 #ifdef DEBUG
 static inline void simple_util_debug_dai(struct simple_util_priv *priv,
 					 char *name,
diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index 7146611df730..04c2eac881c2 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -597,6 +597,7 @@ static void graph_link_init(struct simple_util_priv *priv,
 	struct device_node *ep;
 	struct device_node *ports;
 	unsigned int daifmt = 0, daiclk = 0;
+	bool playback_only = 0, capture_only = 0;
 	unsigned int bit_frame = 0;
 
 	if (graph_lnk_is_multi(port)) {
@@ -635,6 +636,11 @@ static void graph_link_init(struct simple_util_priv *priv,
 	if (is_cpu_node)
 		daiclk = snd_soc_daifmt_clock_provider_flipped(daiclk);
 
+	graph_util_parse_link_direction(port, &playback_only, &capture_only);
+
+	dai_link->playback_only = playback_only;
+	dai_link->capture_only = capture_only;
+
 	dai_link->dai_fmt	= daifmt | daiclk;
 	dai_link->init		= simple_util_dai_init;
 	dai_link->ops		= &graph_ops;
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index cfa70a56ff0f..9006ef5e95f5 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1129,6 +1129,25 @@ int graph_util_parse_dai(struct device *dev, struct device_node *ep,
 }
 EXPORT_SYMBOL_GPL(graph_util_parse_dai);
 
+int graph_util_parse_link_direction(struct device_node *np,
+				    bool *playback_only, bool *capture_only)
+{
+	bool is_playback_only = false;
+	bool is_capture_only = false;
+
+	is_playback_only = of_property_read_bool(np, "playback-only");
+	is_capture_only = of_property_read_bool(np, "capture-only");
+
+	if (is_playback_only && is_capture_only)
+		return -EINVAL;
+
+	*playback_only = is_playback_only;
+	*capture_only = is_capture_only;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(graph_util_parse_link_direction);
+
 /* Module information */
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_DESCRIPTION("ALSA SoC Simple Card Utils");
-- 
2.25.1

