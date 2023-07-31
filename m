Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66D2768C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGaGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGaGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:45:24 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696610F9;
        Sun, 30 Jul 2023 23:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMzVwntcOuyQyOY7vPYwt7/q/8nFzOZWd6LH7AklugegoPlqykJu8pYbnDqWr2Wu9sauds4290007BiYZ+vTsH+Ln0IWs/99ba/6GUHPos/zyJqiFVtc1PMVO+n4Ebp+YxM3vsRUJg8hNE80eValTbgvnxAmajwexkRnyH8MEhwPfaPtIh0rZwxnUKPMsfELB4HCQhxB8Dni/S+n2D0InksV60DGiGoPCxYxi/ubTONnybWJ5cKfpCacaJUxW9Mxbth9G0BmAyjgqUMhzEm2McOAYRHGCjUtkaZ/LvDAAg/qu6WZzPIzjyYp6mLJo5+M9DQdozwKdePAyNp6XqKWiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6eZg2SXpnwBey6uGP5mOAlS2QAU13HzikrGZ4cybSU=;
 b=PFRf7asxvTFUszxY0fKO8+ch9/yJIyefvPOC6EVmhWFRrq26k9/uYVXTSMYXSIuRDAD3Thl6NWqyQGMfAfjsuXhKzJL2pdrHADC/vnw0aGWGVO+FrYyV0fU1iUO9EdZHZMt0JGxn54XAaWP2FJSysx4OpFGGmki6RdPhc/3WCl2gPaHft/UbqRlhtq9j/9kqT/8xSLp3VwGyzqTuOl433xuhyHJYW6EWe8cyXCW3YNH5XLGAk6RKVnp3OE19Dp2qohRWMPz58uKqABybZKYcqr1OI99hpT4/Wx+rqlkkFSedTIekTmGELYdlbeF9Q/Ps57cQ7jKtpzmF87NwsI0/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6eZg2SXpnwBey6uGP5mOAlS2QAU13HzikrGZ4cybSU=;
 b=Uts9sJf5npAbmtpfrTWI74gqT2b9BfDSwlCCmuh78TCsOS3K/5f9SfDOvCsUP0byOWUes4WWBKNyXaevqPsdQBhjT0RP7DNIJjV8gIGPKcLO2Z4IJvoJtrjAUW5H53J/lzdZ6ycnJRWDcPP3vc/4igFEe/c+73mUk6ouLUFtpkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 8/8] genpd: imx: scu-pd: change init level to subsys_initcall
Date:   Mon, 31 Jul 2023 14:47:46 +0800
Message-Id: <20230731064746.2717684-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23deccae-04c8-44c0-64fa-08db91917401
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o85uwYrncA9W4LHOF0mHB9u0/HgzLyU+RS8TqSZzYtSxHeQyIjVVHOMMZdDlY0ubeRXtvDn5DzHhgGCRdAa6lGRcLw7Pi0kbCPvPACyx2aX9qxVoU8TzQua/yMscv48SA7QC5EeM602AJVXiCPGdL0pK+VGONtfSxkN95QBPkyYQ5BZ3Wu5QcAiIN2lcKZLGDSMDxU9pebkZbdKt3BvJvum0E2KvfAYg6RZpobH/qo+Q6bee9TWeK1F2N1Xb9VSBX5h5/Ci+tJEmDC8xXEtl9XYra2SIFGCjtPFycCRaCODKybxIYmhpY0F2HTiPVCpMvNSHG7ExdUisd2VpfeevjoyNhfc6lZMv9brms+jSONEnb2nPLtEVI0x6Vvj0y3zFo4LJrwTEuSC3HkF8knVmVzJtM1xX5wec5rvAIQ5qq7VjF8lFf6rTGXsz1iVEcWbd7K/UqZRWXgTiWsJbnBTNHqfGkHD6qxGgYzKHdz0Cum14LnidymG9kSNX0D7xuzQSfsBsyUeF5W+Of5to++Eiq1Nl40Jnj+tKzIpRsNirro1TQnq39vJgG2am6DWCGS+cc7+jNjNWSyjq9XG3R5xV2CAzbs0KQGu6BhQUD+5Otra1jL4OqD7Xu8mHdADGtSm3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(4744005)(316002)(478600001)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upfguargHNyC6PH4SaIWPMy6cxzdw0dTxDN/EwOvhBsFFe3ATZlA2AZJK4SZ?=
 =?us-ascii?Q?brjhTSFmbOzNfOLGE74h1oXKWNNvtDVVRkOuSB+iN1QOwqfyOSUc3O9h5CQy?=
 =?us-ascii?Q?xAD7VN3s3b+83UwO4NGrERG+HUR3svNIE+263SVbUVWnO4ktY7D/L3Ivq5iW?=
 =?us-ascii?Q?hiaxCZVDuCpS6tuSR2ovOUGEA+1X8F8m4f+hmhmHqmhtxrMbvLYqsvsQaFra?=
 =?us-ascii?Q?ZXbVNzUD2EbV9e0NVL56RwSsYVhb/stzSeMluxeLFNdPyMEV5r55VE5nSTvj?=
 =?us-ascii?Q?dKRayc/EPhORMaYvacEwanmUrsOd5KJX9epQrPeHd3fJcTenUR43CtzNu4lu?=
 =?us-ascii?Q?pmJYQzb7lXy9Zf7hxWr2cijPW1nfLVjmsBBPfTMlSyaJa/qTxWGhfDqb/IfQ?=
 =?us-ascii?Q?oSxTiUamN/lF5WWmd548UHJBPwMIBwcIIjYGOJjVWj54SyUQitKvZ0YSqlNf?=
 =?us-ascii?Q?oymo9DIR6LKTSPI2peOfKalf8yg7kW7kfZ7a7QDfjfMtRmrsxtnsyHk0oS1k?=
 =?us-ascii?Q?5AcyezPttY4u+JXx1WYT2qh9MJQ690o6VuR5/pFQxN5JtISDh2zQLDFFsOf7?=
 =?us-ascii?Q?5wbMSSXReIFi2Spxpdow9N/UAbToxS013jClmd7KWuboq2UTe16fOh/zjiL0?=
 =?us-ascii?Q?/4aeHr2+Wk6db/tDCusIHXpYpgbMjSUMOyIG3zNUiEPvvFgt9b7FMxbnFp6A?=
 =?us-ascii?Q?VF0ypx8z6myPjWJLv2sO0/BZ7CGOrSVU48oa/7wGLg+YGjyGyKAj7EFcirQV?=
 =?us-ascii?Q?8ZMT6HZjbvAvr1oUyuk4leCsRfSW2JPxkDGwvYSIA3+HV46HHH0lnkZ8mNRo?=
 =?us-ascii?Q?rsnsIlFg6sMtPipd2l27yBcAXJ6nDnb8cd1dmUgiN+d0OU5pmHM443lCY7r2?=
 =?us-ascii?Q?1dNHDU/VL9ldqB6zq//SpuJYugMzHmuxO52/tX5yALsK8GXP7FUkH+Q1DZWQ?=
 =?us-ascii?Q?rSScjQIsgd6vrTODg0eDNo62HlnksWONm10um64+7/mEVVzX4z9x7101FFHb?=
 =?us-ascii?Q?Y4+onDNmgKCvgl6fqjhYJIImv9etx8ULAmdUtJYCdjvHpc7oxJARHbUSvHdP?=
 =?us-ascii?Q?aypm6ioY2FPNjcCvIB05EN6/YXSgvwLMffoIcX7oCHPThyolFwwTchvfTOuk?=
 =?us-ascii?Q?+dqfA6flne5er86ATOcSdli6yDNNL2ebm8RBMDKG2MET71xIlvjPjmc6idPf?=
 =?us-ascii?Q?Aw6YIIblh0GLK7zEu6WYsQSAI5xQAD0/X6+RuTn3/qT0zwNkqyaNZGjeMFIo?=
 =?us-ascii?Q?4BqwPL0hKOuVMgCDZ+b9hCcGiX6PQOtStPM21VKcFL6Fc3xmzplTTKD1u/TQ?=
 =?us-ascii?Q?Z19zthdL9FwuClv0l+uYpyisNuY45TjNX6JOxhu8sp+1mpy9uxo0Jl+OhAkS?=
 =?us-ascii?Q?1hMbzu2G7cN2Os/iLmFChzKLZRDCyY35P/KW9vQ+gi3rzD9yy4gdVD7p/zA9?=
 =?us-ascii?Q?sksqYEN7oqp9bbNtobQkBsjt9X5YLIHII+NndajMAvav7r2oi+wFn4Q+ToYn?=
 =?us-ascii?Q?6o2/JmRe90T2LwgdCiP6P6ocz/KVZZt+F0f/uzfKTZdjcxP5rGijxP3+FyKR?=
 =?us-ascii?Q?855XU7246cZKq7P7FbT1LZQ1pQFGj0CmMsVljY7n?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23deccae-04c8-44c0-64fa-08db91917401
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:30.8734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Cb5htWhZdjZgMZhIRTK6eXbhKHAHwgBswI41PPj7oxsSMq8LPmBCsRLx0DUzxQs2WLAtGJbgTx8ViiAE/GSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Change power domain init level to subsys_initcall to ensure it's probed
before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 30da101119eb..0cda0999a1f2 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -587,7 +587,12 @@ static struct platform_driver imx_sc_pd_driver = {
 	},
 	.probe = imx_sc_pd_probe,
 };
-builtin_platform_driver(imx_sc_pd_driver);
+
+static int __init imx_sc_pd_driver_init(void)
+{
+	return platform_driver_register(&imx_sc_pd_driver);
+}
+subsys_initcall(imx_sc_pd_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU Power Domain driver");
-- 
2.37.1

