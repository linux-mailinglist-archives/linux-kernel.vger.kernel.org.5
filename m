Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724F8768C34
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGaGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjGaGnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:46 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C9170A;
        Sun, 30 Jul 2023 23:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkdwFl4jFCEAY0yki29OQSr/xL0Ef1L6eL8cKZDN/RnR4RKe6Dhxji5H6XEVBbTj5XTfIyecDJ5zc/Q3pcE3Ujnt0RQnJ2L2TItJPo/Y7/pOZh29VuV8nn8Qqona6DCFz+/acvIYLbcUTlwp++qMVtt7Xgy0UM3eQrwzHOUDRrUoyvfQIhJAkENPBSh0VM6iJSA1zc4OLAcQMYbI+ivVKMMPGgkC0l3GCIa0P1s0yEJrrxgOxelSxOrTrtRnVLc+1Vh3BQ5E2paMYFI7QuV9MjNXrNFdqmnFG1icB31531MhqxulfGvrkfbwmOS84tbXU/btytChsTBnnlAjPqyfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egD3H43VB+M29WT3I9pdzG/iYCx3+8lbdwgTclArnN4=;
 b=EfARvx4kmGAnZxw6iYG1VSDwjHDo47gRk48psj3o6Kvpp5nOedJdvKT7+gdSysreR5lkZnUgi+F+YTZSMpaudVkHxpgOSCa+kMBCb24YJY2D8i3PVHUG+zky3tcBfyABvaHavXp7EEXxmWErVeaFWINPqlh4ShR7ZNpS7QJTgbRo4evqh/MjnMlnk7eNB1J6HmKJUgpi7oSXA2mKKL6j/RQ2uXH4Wp6Mc4bmpbgE+A/eMAEskwyBnZcjnvBj7D4qCEsWJN1aQFv5Da4dvaAcoWgw7T5qBsPuuJJZ8gU7UB/NjaW2FNN2CPSMhKkEEH9Q1BQfi/d6UrllFK1Z5vOZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egD3H43VB+M29WT3I9pdzG/iYCx3+8lbdwgTclArnN4=;
 b=P1d0RD2HoYVXEarUS7JnxokpuDF+nZZQSrtrGZldBsKbwyAy/MsckUJgBBkSNCtpe/eAbxpBUO+O64P0wvnpK0SBln1i+7W07kYGSuzeGc26U7MS+aEG/txjws1YnlqUFlNK5k2epFwsFj2tVrGo3L7YG2Zw8aSVv300mFczutU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/8] genpd: imx: scu-pd: Suppress bind attrs
Date:   Mon, 31 Jul 2023 14:47:43 +0800
Message-Id: <20230731064746.2717684-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9bc8a9-b8d5-47d8-4b9d-08db91916da5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymYHFIOe7dbV/wiQ2DbGHiGtX510TfrfdCJgXPF+/wwwwHC9bZviUt40+dKcFBRG0/xD7R4efVwD7YilHh+PGJyhlUImjaNFXumqk0nq1+rEwdTnws71ZB79nJ+z6Xf6ER3bGxfyBsC3s1RrDnVxgeeR9FWG4KqJCzuHYeiiSIuTQTPAUPMQiM8gusp7/p0kUZj1tZt7FQgrp+wmrCMp8jNKQtEsiqyICKiCP7FIAIRr1wCM0dDt64p504zKsRLklx3Do1O5jQRRV+pyigbO2PDdqU2aWnss2aqKOM1Oca3FmUGPqSI0FV2pISZ53JpeMZsaeKdmZ4QpMcPUpZAl3CF2XghD+uv6PVu6VWPmF40eVczFUnd+65CkvnOha1v3NgsVa9YQZUapO/bSU8K3iZBA7xRWvWMe0gxtfECOj097aSIRj5Cj35Y8xkld7fGyLRE10ahN9a2UII33KFGpqdGwDxaf1UD07JyUqwoTTY8DO9/ugUSezHH79szRGcCkwUFhC0f3RaB4bhPuVd33KsTAz28f08DMgy3Qy9jifWRtWxirMP1v2qJ6MkPVKhbvi7j4RSwu3P5UzqCinsBK7Pb7p0CB2WuOu5R5NF7U1JL0RoLUi6Lf9nWXmZ31n74y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(4744005)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V91Dc3l6FPznSUC8vwOO13KGaoxPogHbf83Xf1X4jbJsh9yUQUO/8y1eShO1?=
 =?us-ascii?Q?hJ/ibeK++h8RGXEF6Q3Yzoh6KV+ch82HOCSuYZoGlQxOF2H0ENbJ4+w4AJbu?=
 =?us-ascii?Q?8R35Ap2TqCISO0epqpvzlPsq72rlH/Y9moq04Sf6LGOOYiWL/xQ8HkPuXs4U?=
 =?us-ascii?Q?fr4XhxSgv9MHYIfZPZ+h9WfVtiQ3sxA3bCRHGKSxxArPrMin/N5vTQ1x2E6i?=
 =?us-ascii?Q?5rG0FswawGLewggyxYzeMMNvg1xbrEq3IEi2nVBtR2VCqH8Ao0gLmTCJ3CnO?=
 =?us-ascii?Q?pDO+9OQl+D34UI13kgVW7omU8/g6fdW4ycy4Zs2Ew5nOS0dEomjlr1G2dO8Z?=
 =?us-ascii?Q?69POSfVlGQWsxmEIOeQgUhxSnbE3hRE0KfE+aCFdZSlXx3RwfxKxNUTwI43B?=
 =?us-ascii?Q?H3WHoO6mqlkNIO/M88rLO4Zmtgxv6+m3ZRvTbUVOXH/SU+60EwThxrpn3FfU?=
 =?us-ascii?Q?dghHUISOdhI/7H1ZTERG36kjAtSazDa6gWX//CSn7ZF7Hq3a/6oPZnYZW8+U?=
 =?us-ascii?Q?mv1J0HW1jgXMsNDTxLfUx7px1fJuFaH9M8HLiNvGUBAXhZSqKQ0kxhQqW6hT?=
 =?us-ascii?Q?1Fh1kh8WaVxsTEOnMKJRBbjHA8ruZezeLPSsEVOoGyMX6NnK7N6q2pEJEWWN?=
 =?us-ascii?Q?kN0MTI1/+pyJwsRvDVXKnmPh8hlUtwmOIl91z9vdk16S97AMGYd8+UTmhGoU?=
 =?us-ascii?Q?Y9d/mzsYW9V0utTAF15NiL8YwY2W51YuspE3pO2vihzaFf1AK4gl0+mJ5bMZ?=
 =?us-ascii?Q?WttpEC+7Sb5BrdgdF2YwV4N5lKuT8D/xcV4PyuYxPIH3FRuiwjdeT47m7nBi?=
 =?us-ascii?Q?nOpGDKij1ArA50n53UGjY0t6kWGvbWnGyUlAI7vWl7XpLXWcuZUxWX8XrV9W?=
 =?us-ascii?Q?jOxTHTqzESI6eG5W0j9iSDNw4Xv0UFbKiJroaujTy86vfi722mywdYWStHFn?=
 =?us-ascii?Q?YS7+b9DfcOnllcP+DYv/GbyJFNwHJxr+5FHITWrjQojoGfKyQEv/vUVdgkWn?=
 =?us-ascii?Q?JK2WyElJwwkMTBIkKBJPr3oBUqNIPLlJpXsO1PNWaLHvgylRVRGBjP9ly8ot?=
 =?us-ascii?Q?3mMtFynEgL8Ta41YUi3zN7D6FeAWF+ideIjqNX4CvFfRA0LCB6Ha5gNEubqy?=
 =?us-ascii?Q?gcGOVMPbh/HrNG9G+wbKISduHdnhDdvHWQ/yEbkdSPphQBKmrrXeRiG7KS5F?=
 =?us-ascii?Q?t8auNEVB6dfzBRYdFsgOFdI5ME8AcOJUk5RN7RxEi86CShDE7uv2gxEU1HGu?=
 =?us-ascii?Q?PVQJTPV8ANdoZeXWCHVDLzRQOFOGkYoOZQRkihzWlI1ihtpSDaIeu3LERrIM?=
 =?us-ascii?Q?rYMXpA3pWW5tpXPDO+30FUdK61Gaseh15zGS+j1IkkJmmInbPBpfSVgqg9/+?=
 =?us-ascii?Q?lmxrmz+UyAgBvYyhOZcsrNQri+acufuUrNgPy5394tc/uee6YCoeKKrZQ+cm?=
 =?us-ascii?Q?+8x3HU5opOD3FUaWz0lxJI2iacSvoQUlApG98rWqY8xg/6cLqlnyxf/8njWg?=
 =?us-ascii?Q?w9difFbNLbzFGI0FCoG5FzCyTr8oefRNWohwxdOXoHDx0NlnwYsFPmR4tp54?=
 =?us-ascii?Q?k0w+CDGWGYE1AhhnhdAGsUI9R9BDKH7CSBPagzyJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9bc8a9-b8d5-47d8-4b9d-08db91916da5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:20.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bhdvxsx89bl8iQi2JwgYmH1gfDhrm8u3+SSsE2JV7ZtMPMgfPF9r0A8L8a8qnHYbv2zBjoLFGbZy7RzQqV3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This driver is registered as platform driver, but removing and binding
again would cause system not workable. So suppress bind attrs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index d69da79d3130..fa840ebe38c5 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -488,6 +488,7 @@ static struct platform_driver imx_sc_pd_driver = {
 	.driver = {
 		.name = "imx-scu-pd",
 		.of_match_table = imx_sc_pd_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = imx_sc_pd_probe,
 };
-- 
2.37.1

