Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126B76AADF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjHAIZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjHAIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:24:58 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087918D;
        Tue,  1 Aug 2023 01:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbyxoOEeGEK3z0sllu3AXiOcL3iNNqGJt8zVhAsRLMrLNvfm8rD+59FUq2CrXiHcmwGAlF9oT8tkDqOfdZRbkB/FkkljQa6itgJIhSxz/Fcq/kf4EN5YR4EYzWZn4KU+GMbRkUL7BMVORLN89ega3CWsRRoJLi7N81mfutBEVvE7ww05hFl3Lx7qemyM9oFrNKeSZ0cUG7egDW4C64ssCQ6osnzFbUC0L0To0aNjcBuOiu7vPT8WkRO1jfFWWtyngtxfFL1xo2PLJPYFs7UMeAS1FbkMNReag3oLgWcbdPEpTmbbSev9aZGWhiMkVgfwEzf/ZhqyT3BIDKqUsrP5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzdrC/N/XUfpTl+MgYHVXrTh7R+x9io3qAlXC9s1b9A=;
 b=Yra3Uf86HFT0eGFYQF6SmfESR9L+zI5GvwOWEv1TpA6/9v29Z4VQV8tC6lRnHknJDKpoFLvC7lnyqDaUAJ4nMWg/+jT2yLZ1Bilui2MoRqqEVtlVOjKzFV7Nd2O4jMq6dMO5uKuyhkNYiQxC8cdI0MpN4hlObnToif3hR/bc2mX7sB2R25ZC9ZL31/6lWGz474rHaLUfEsSYkO7cgzoO/FtUqlhTpxQSHwJr9SGb+a1Stc5FPKDF4w92TpjJUN8fzeRUSeVq1lvXbtbTqS0z/S3c7WEOj+DThvOXwekaCLAZ2hqiRE7rsPGk+Mw1odmbjyWyxNj/RY+eDfwLkcsEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzdrC/N/XUfpTl+MgYHVXrTh7R+x9io3qAlXC9s1b9A=;
 b=SjrqChg1iDuhQ2TK6H6Qe+nF8rhIylieIhOIpo2pEkn45pSyxheJv1IlHxIwajdLoTV3QToXp+qp2ZgWYbq+bgSu5co23T26OaNhTn4scf7rj4+KR61DXMKoqzyoTAJdsBxSdBruohYG+4gjd3+4Ow01nkpknfYUVngl1mUTPN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PA4PR04MB7917.eurprd04.prod.outlook.com (2603:10a6:102:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 1 Aug
 2023 08:24:51 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::d4e4:973a:b085:de93]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::d4e4:973a:b085:de93%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 08:24:50 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, spujar@nvidia.com,
        tiwai@suse.com, perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        daniel.baluta@gmail.com
Subject: [PATCH 1/2] ASoC: simple-card: Introduce playback-only/capture only DAI link flags
Date:   Tue,  1 Aug 2023 11:24:32 +0300
Message-Id: <20230801082433.548206-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
References: <20230801082433.548206-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0057.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::21) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PA4PR04MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1f5e8b-66ab-4479-c01c-08db9268c666
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXu15soKIga136cHmoKy6voMNXMkAsdPpP1c28U2nxChBJ8q7F3qoxaLls8tTkMN0WWKtgDxj2AM0UHfzxNClQm4ekAXQtUqTDPls5usVFdZqVUWEm3DXge721bCGKTLm3rKPjwxlW1GG6o5EjE0itktRTJGYbV5nGrO7pJ7OWgTiUPd3LsQO1jkeWuwtTAliExs/Eh33Vl7pz4LDLBKnSt2p1t8cNGHKrOL1g/lA+KkZWtZ1B2iDHe8XPYxWY+zAE/5dxz+mNQ63y50iQun1kSniiZo95foQjOnBE5KEJfuZOf5P8gC3nrQI+JAsDYdespOO5D2aVSw6ckKKB+DZI76+TZhEFqrf0yKaXt9Kvi7Mo35EJg6tpF/L0VI8vPAB7/lF63+LSRNLsY0ck6WdkPiaw+GbLQbY0xtACPHJhCRhi5slH5IRVkfwRmmX0fNCknEn6jchZwOGVKmMN/b1Xv1jwu0AQ3bPpT/QdZw8BMxWdHmwro6HCQYUGlZQpBWpxMXbuYjrDjTXvdb+rQ1UE6Pqdjy1Tq3sx3yxbkwY4CfDNgAXUo8AAqE/6Zn8uRaTBrJSp4OdUQU01lFFaV18vlZ/uimoJblP+tf9SWSqE8RwznRpHO33cmvaMrQ7+5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199021)(66556008)(66476007)(66946007)(52116002)(2616005)(6512007)(6486002)(86362001)(38350700002)(38100700002)(26005)(478600001)(1076003)(186003)(6666004)(6506007)(316002)(41300700001)(2906002)(8936002)(5660300002)(7416002)(4326008)(44832011)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efaMxjDBs6xh0s96MRHLSjy01kGo2WtqEVJ+MwCKfkHUZ6QmvTUKaD1b1ZNI?=
 =?us-ascii?Q?Wv4IhotEu59Xon23r1yh+9A9Xa2jIzVL/gsa5sSMJ/IU9TDzReZ1mRR/dI1u?=
 =?us-ascii?Q?Y0FSBaPvK9tOZImpQjLulPWOf4WISdwzDqYTWtzbFHYf5O+HRKkarC3LPfPz?=
 =?us-ascii?Q?mbfaMHgqKjBY8JVKuPn+KIGBWoOU8E/jsaA/r9KFhnJeSukXsOQsqlX4xeun?=
 =?us-ascii?Q?E6Vd4y8MF1SGO1YCClkW86GbarCRK5xRgpPbasFn0rNoAIQjQMJvK0MaM1pX?=
 =?us-ascii?Q?QfRTYIZLeFkMPPylKfS7JeOGMh1KfBi29AdzS8luBJvuBkxuPsyGr/QhkUqq?=
 =?us-ascii?Q?UUS3ufIvZk+De22xR05DonWgIaxDP0/8sXBoy4U7Z7hZZ/wj8CQFJeeEGGTl?=
 =?us-ascii?Q?LDK0IT3jEKYqe4D24yQAbWvzBjkw82G2aSma7X/LVh4DXBzs1TA5zBq7QJXx?=
 =?us-ascii?Q?iGc9f/DruoLVwUAalKGYu1TJFxHxAB7hyiKh2qNc29OK+cdgMCgyZDb+VQ+Z?=
 =?us-ascii?Q?RlsFJhNwM2bUSHF9G76rjzdGB/GrdbucNCUP+7IvYbaujGZ3kENPdLREhHal?=
 =?us-ascii?Q?GeUOHTug9TwtBWjFmUZ5u6WmddOL+LqH1KzQrn1cx1709392qa5eok+vhPsi?=
 =?us-ascii?Q?rCet91M7C+5HjbMbpPWEgmy+pze84E1H8D+IYijTKI/l/o2zzhBvlptMoQ/L?=
 =?us-ascii?Q?zCbYXg+MxYz7iXRdXEpShvvqgdqmXFDnjyEnBs7RaJpJD2An5HSanxImBYtC?=
 =?us-ascii?Q?pz2vLx/oFMBOGj1mOAFHSSXKzrX7Uy+dDCyU8/TLZBXkEjr2spubu4dJ6oZr?=
 =?us-ascii?Q?EYme6dToJ6b4WwWd53YdIUJ0s4urVZypBIUyV8PXMLRyjAbjFV9heOHdndUv?=
 =?us-ascii?Q?bvYmEk3Rjr4zCI+vvCtWRcd/RrUb74XKIizUJZ31joTEObl783yklQ0Exnqs?=
 =?us-ascii?Q?+oI2tK9gUyX4j/SZADS/efsNwcxBriHUl305JVp8vHioMWo69ds9oxlcAZZO?=
 =?us-ascii?Q?0guJV6cybWwYMgyTZ5UffG7//9Bij1f5+sXrARWZ0xTeP8/GHWN9nbefPPxk?=
 =?us-ascii?Q?QULWDmU+PdqV23SxnK/ZUi16DG+4gThOG4XGGpgKANgCprkEp6fQqnIHM5PE?=
 =?us-ascii?Q?He42IAkOtdNFflGz/6jvh3qt8Jvgu/NovP2oJzNba2H9AU4+HgJKjks/+3kq?=
 =?us-ascii?Q?17CG3/ybFjEy7/ds0X9Q8oUpNU01/KFyg4r/KCn8jatweetLVIJ17rv4NQRS?=
 =?us-ascii?Q?wQ6mk5gxov4NcdqhyQfocycjtYa6hScHWPO7HEDHp3Ang3e6DLONXkIfMFnJ?=
 =?us-ascii?Q?TuGjA3+Sz7Q65SKWhi5uZ4v45Ai9RK1po8FYk/WbU7v6gUFUtq5vAn5lGZlE?=
 =?us-ascii?Q?6f3H89Lv9It8rA4DSSANJXlQE7HEJa4Wbzzso8gAvL5yQtlZ90Q7d2Ptx7Zv?=
 =?us-ascii?Q?EkFdmVljPZMWVeW8TNVqkVQURKqoDpcczSFGHS84m73zr/HEmx3ARR7ggJiw?=
 =?us-ascii?Q?sEsyF0aFGpt/ej8dQMOok6eS63F6lscs9Q0n2SZzFhlbaFmOth+Z7AKYMmns?=
 =?us-ascii?Q?s5Gd5Ax+hUPAp2WGEbO2DpP1KuzIFvRCz74RJt5U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f5e8b-66ab-4479-c01c-08db9268c666
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 08:24:50.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFeXTCMmah/9ZFyapxJzfnaAG87OEjKG+lRMQjhQC99dYIl0u6PfeE4xgBkL7RMVbRrLU/MXyWPDx/zmbU2dLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7917
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

We need this to signal that DAI link supports only 1 direction that
can only be either playback or capture.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/simple_card_utils.h     |  5 +++++
 sound/soc/generic/simple-card-utils.c | 27 +++++++++++++++++++++++++++
 sound/soc/generic/simple-card.c       | 10 ++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index d1a95bc33c56..47d90edaf6fe 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -135,6 +135,11 @@ int asoc_simple_parse_daifmt(struct device *dev,
 			     struct device_node *codec,
 			     char *prefix,
 			     unsigned int *retfmt);
+int asoc_simple_parse_link_direction(struct device *dev,
+				     struct device_node *node,
+				     char *prefix,
+				     bool *is_playback_only,
+				     bool *is_capture_only);
 int asoc_simple_parse_tdm_width_map(struct device *dev, struct device_node *np,
 				    struct asoc_simple_dai *dai);
 
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 5b18a4af022f..e04d2995cf0b 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -115,6 +115,33 @@ int asoc_simple_parse_daifmt(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_daifmt);
 
+int asoc_simple_parse_link_direction(struct device *dev, struct device_node *node, char *prefix,
+				     bool *playback_only, bool *capture_only)
+{
+	bool is_playback_only = false;
+	bool is_capture_only = false;
+
+	if (!prefix)
+		prefix = "";
+
+	if (of_property_read_bool(node, "playback-only"))
+		is_playback_only = true;
+
+	if (of_property_read_bool(node, "capture-only"))
+		is_capture_only = true;
+
+	if (is_playback_only && is_capture_only) {
+		dev_err(dev, "Invalid configuration, both playback-only / capture-only are set\n");
+		return -EINVAL;
+	}
+
+	*playback_only = is_playback_only;
+	*capture_only = is_capture_only;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_parse_link_direction);
+
 int asoc_simple_parse_tdm_width_map(struct device *dev, struct device_node *np,
 				    struct asoc_simple_dai *dai)
 {
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 190f11366e84..1fb34a51636d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -195,6 +195,7 @@ static int simple_link_init(struct asoc_simple_priv *priv,
 {
 	struct device *dev = simple_priv_to_dev(priv);
 	struct snd_soc_dai_link *dai_link = simple_priv_to_link(priv, li->link);
+	bool is_playback_only, is_capture_only;
 	int ret;
 
 	ret = asoc_simple_parse_daifmt(dev, node, codec,
@@ -202,6 +203,15 @@ static int simple_link_init(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		return 0;
 
+	ret = asoc_simple_parse_link_direction(dev, node, prefix,
+					       &is_playback_only,
+					       &is_capture_only);
+	if (ret < 0)
+		return 0;
+
+	dai_link->playback_only = is_playback_only;
+	dai_link->capture_only = is_capture_only;
+
 	dai_link->init			= asoc_simple_dai_init;
 	dai_link->ops			= &simple_ops;
 
-- 
2.25.1

