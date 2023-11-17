Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D307EF657
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbjKQQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:39:26 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E029A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGd7wOmHLQ7faflKx1p7Ro9UPQCBhLutCUI4hRJWU6oxfyaIGhjWQntAzQ/FXt+ecpNaLn2BuEf29Pzv5DQkk8SeYYSTsQ0EFVdFaa6VlOpmv1mIFPIv41x2uT8D1gZPMIboBfE2oxOU3F5Xe90XmaWeGV/nPczrdzIlbAYZQFjkcKzZJUxdApzG8BrmaktpdTTu+LeA05zU5jamjNL07WkW4RSqH6Pu0cgsfqESElC3zw6lLm7Ej3gztfPINvpBgSMcBsSWoQt5yGSiip0W1pwVhtbQn8s59ZZ4ybUoboCzZard3XGJRZOMMa2oV6Dg+yB9RfPgEISQ7CjWXnvlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nKdxCzXHWz8BBftbGmwHfjwfjGMNM0tq2K64G+Q2lo=;
 b=bYtPOvwwD7XH6GMX+Psuh//utb9GUJntVUwWIrj/4ZUGO5onO80meH4OJBL9s2jaIM6ND4wum+wDWEjgctALsw1B8Dc3MbxMbP7QQuVRm3odEaDN5BHVr0t9dMubnExuxInAMBlFdZsALIj5Q77+oFxUUwT49wuYlAf5rsvpGrKqI60SSrUS9sAiVi/CKuCvphrWstsJA8b1PzLE7JyrY0+vPmkjgZ1BIgh1b6woq68E8N7K6FN0yySRW6Qbv+701ypShz+MhWZBB8tCSJJ5dH4lVuo05ZMcv++rVWLVCGa3nGcXcOyxlTBT3YEsmHT5IHTO6qbCaO0bg7yxh5WLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nKdxCzXHWz8BBftbGmwHfjwfjGMNM0tq2K64G+Q2lo=;
 b=Eb/IhVd2aIyEkdC0QeOhOGSY6vDC3OFIj2b8OVpUTfebjpTJNLL/0Pf9pJZLQQpdlFmAwnYv1mS7ISkepRLhVul92cn6zFGPXsCqMkX9QmFR6Y/1he6Fw2idGbQ8IuX423hLP6z3jTFsgcUu3FYUJENB6RoKfCoUBdbQ0n7yYQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.9; Fri, 17 Nov
 2023 16:39:19 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.010; Fri, 17 Nov 2023
 16:39:18 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Subject: [RFC PATCH] ASoC: simple-card: Use dai_id from node description
Date:   Fri, 17 Nov 2023 18:39:00 +0200
Message-Id: <20231117163900.766996-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::7) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a9bd3b-728f-419f-1fdd-08dbe78bbdf6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcngCrALcZih/CLNUT+IV0XFHABrx+GnlmFrUYNfcge20G1WF8WXWHuW/IBMVu64VxcyNb8XJyeIM4wNcpiDHODQx9tQfWPKaXwJTuEAUvGwSWia+O/3ZzXPH6XfGqShP/3yf3dmTwHdrJc4sZYHWzBymBo6dWE/DFL3+HhcxJ0TEj6VKM1b+OVHvhVOWLiyyF7FZIVsPCKoaIwEYlmrklT06Q5cNwoOKNEX7OE4hN3PU837qwO+4h+cm4Mz3p/nbcUmQg7IwAVlBT5d+kVW3OTZa17sVQK/9C3S57ESWgE9E99aGIgzBPeXFBlxYJqpEDJzVjP199sy/pggEykw4TtcBVUi01tB2tKYtQtUK9N/eJip/CB6VbXYuUt8fm6UDyL/OkQy0vB1pa04YxuTDfZ0X2Q0Fbrw0vm7SdqjkG8SOPlF9NpEvY89WbRDEHmqhJ6KOjEIRAx7VAiMElifXwYSSxSxJarOP/DY/aOQGM06PpT4/tbG5tIwc1ndnTNu6pxxThyqCxmxUIWvO1LcRHVH7QQOxdyHK2qhZBfMKIcth0FeoNc6fIO5Zprkr+6hVRYTKgSwNvUZCFUkSudTrrnx8TXt2hGRdGtS0yaARK2iKKNE014VemMvaKSefU8c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(38100700002)(6916009)(316002)(66476007)(66556008)(66946007)(41300700001)(4326008)(8676002)(1076003)(8936002)(38350700005)(44832011)(6486002)(83380400001)(478600001)(26005)(86362001)(5660300002)(2906002)(4744005)(6666004)(6512007)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE1Rj7GYt4ridCvJyKF2tuB7X0ArHJ9bsq/BU2mgBDVkVENIcbeki1FrOFED?=
 =?us-ascii?Q?aWagGevkpL3ozkL95j4HIUyOoj/8eHrKZ6fSuHOLFPZemqFoiDTIPXF36obv?=
 =?us-ascii?Q?lhZiPR85rJJf6sf2FevLZEN/BrOUX2kejpLOVgtAxCjr+y8QD3tjHNcU5YHh?=
 =?us-ascii?Q?NaMr8CFUV1Wt3aecyr4/MO3SUpyx6JY895T9cn0XE5VRGEW688IOpgh/wep5?=
 =?us-ascii?Q?6qf4fETVnPN2aIGdXmg79WbCR94FdvhT8CGCEkNvA+a6hCROLhnYRlaNXu82?=
 =?us-ascii?Q?k61F9gWS92BYxYPcaEAp17bC2SpxB/39kCYkvRnzp2fT3YUGJ9KUSPVuONmB?=
 =?us-ascii?Q?OFUjfmoKD9+oKP+5BxY4tDKnqsgtpfFUyqk1UZoBH85O3CbVNaXKYFyeYr0R?=
 =?us-ascii?Q?pME/knwPVo9y/+RO/KRkZz5RN3zHdRDCYKm6NrpbGID43L2n0Hvw7DbJJ/KQ?=
 =?us-ascii?Q?sggJtFWlN+NUHmy+1yDqE3tvotEOENzxTtplYRY7AFA1Q17GuDjZL2o54Ihc?=
 =?us-ascii?Q?FIUfSSRlCHabGycunGSPCI2/6WJJkmrOj+7Ejr9J91puJnXEA7i/kfw2Ka+w?=
 =?us-ascii?Q?Eh3wVkiGtcpM+eMhv7fwAeXiN9xUx63bQi5agj+89YaviofA+cs3Iux0RK9d?=
 =?us-ascii?Q?bBBHv/kdBURGDSK33hpKsDu+AnA0ygLlBr0PwEBTTwrBpgeZg0W74joIqmTG?=
 =?us-ascii?Q?AqqT35yjcZ9mw63I6niffXq76Rh5Gh6WNeFDwwIP1G8F/luVH0YbFmbXD0cB?=
 =?us-ascii?Q?qMAm9692jAVQ7YRSjUDGoEPkVIWTuNRJPLg8ogKaRqfJ56MD2YUCRQ2ziwuh?=
 =?us-ascii?Q?bG3oOZUWHblUckOdV9G7CUTLcwHNMbMHluMpAaB8KO8WbkXk3F/3WKH+gmE4?=
 =?us-ascii?Q?8JAaJPVlbZfmjKKxMR6eVJQ4ooiVZ0cZYZs4Ys/qizCEUjh00XhNbiemEL8F?=
 =?us-ascii?Q?soU//kABhYIzJSaBWySKgAU+8kdGrWi0vwOrvHVx9f7CCBF6ilhCduOeW4pI?=
 =?us-ascii?Q?X8nxegv2jB/f3nEovej5L2yow2ujf3TiCqzZ2aKDasHqlKgN1YtB/tDqP/B8?=
 =?us-ascii?Q?e4jgN1wGiOg6truHIpu0Mhy2ecTKckkm28W9YEthWisHSU2u2xwHGJ/E0FQ8?=
 =?us-ascii?Q?1Q9vII0mOw90HZSgo3HSTS5DNGOBxXODw4skXvKy5kjPVMSKhVsok2LGGkhC?=
 =?us-ascii?Q?OlTPjngfXVBvnuM78RhlWsqti3iBVhiNBb6EFkKdYW2C/WGlti1WSLIeN+QZ?=
 =?us-ascii?Q?B1AxTOLVaTtALZynMCqSyr1eV5wzdQiSU6poNBJSGGjKxfWioHWVyoLdGKMT?=
 =?us-ascii?Q?fXevBtY+xh4b0iYeFLyyeL93EoeIF6IrZuVvVY/zniIXfgPsZ2v59duh6d5B?=
 =?us-ascii?Q?GwlRc9ANsCdmCloQnqwGOxoQ+xsn02V8KFA0m3R6xkw7esqjgRT2hMp77NY8?=
 =?us-ascii?Q?cDQNe3b/FZGNgWz/eU9T1EwxZ16IsgGmz8h9o7Qgg1uBiP9nfK+XlVgIy7GS?=
 =?us-ascii?Q?bk0N2QGSHkidoWudfSdnA1kV6X+W+gKmbQfC2AiLvagR69lBxxfdzuz+GACC?=
 =?us-ascii?Q?471y3LWhmz3oQPf6sELBeQUr/58kKpuQot/PFKVF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a9bd3b-728f-419f-1fdd-08dbe78bbdf6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 16:39:18.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LewyblOCJOyYoGugpG6VTDdviQxB6Ynua6OhSgOiMWul3KcK5Swg1ZKkNtM662c3Ob01LGOzA8F8fX6UU3Zyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

We can specify DAI id using reg property. When dts
node has only 1 DAI simple-card always assumes that DAI id is 0.

But this is not correct in the case of SOF for example which adds DAIs
staticaly (See definition of snd_soc_dai_driver in sound/soc/sof/imx/imx8m.c)

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/generic/simple-card-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 8ec5d413e8e60..739cb71593a88 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1121,7 +1121,7 @@ int asoc_graph_parse_dai(struct device *dev, struct device_node *ep,
 	/* Get dai->name */
 	args.np		= node;
 	args.args[0]	= graph_get_dai_id(ep);
-	args.args_count	= (of_graph_get_endpoint_count(node) > 1);
+	args.args_count	= (of_graph_get_endpoint_count(node) >= 1);
 
 	/*
 	 * FIXME
-- 
2.25.1

