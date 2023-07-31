Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17C7690F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGaJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjGaJAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CFB7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2O21rf3mq1RhW8uQ7eVLMTzpBQN1Rce66IPRWVICzEGQ++A3ibNPOTyTn4syxPcWBbLMdreGzk9ReIoLKlrfIkOtR/LIL8SBNSWAYyuRucqkcDTS0SXPfEvzgQ7mQY8mkTknUKko8ugV3d2vbkaGFqnbOdAVdZ4awKPO4qL2ZDX3QCFl4Tnblu/4lTZhOPKCf3r+WnPkgfnBSs+Bo/MT4cH2B1kNnRnsZBl1CNC/7TsuRDEUON8mKK7a7nW3YtNnceCswy0/9F4IGaD2q9/QBIG9vAHHaytDYDnFdK9NnRPNY3Nhxh7iQxXf4a+BCqXMKs7D9ojOllINsqCIHUyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=f5EuG5TbIG0B3TTQdv/qFRgWwZ8Z26R6jgy7YMFwq6JVnWG5ypv5zeVV0QP1pIhATdkNEbSX3h2IDWIS5zVkD5iqa0n8rUw7wGwlpTykE59qC42MIMBDCmgeQOdhP0HySHDswrmKKPa/8fCmSXgC6ZJZQLlOW84asLj6bNKBO85F8scrk4KvByLzFZWMO0gPx5ItNRnwRnNvtz5ZgA8pES1vgTI3/qaqQrtn1mopdsCZ9Xlysw9fAoQoLE+8CutSvPtxrk4MeE5Z3qqR/Go88J5dqtdHIvnTt9ipuYrmm5O8D2Jvx50PTDcEnxmp1HloZ8k3hFNien0OxAfStl9kNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=hJGPSNLcbzMcrecUPnw4XcbeBHp/7Fpx8NWP5zDo67TdD2T8QkdRvbmZHDRKqqp1MAkiMHUCHe30obB8RBMFAbxp1tTIPBqK+Re7qM6XxR+uBMHjk9niBvpUXz8TORXoK7RjwJQK3e2qGTjP5PwgmKwVGfhKpJVMIl8oj6GG2sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 1/9] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Mon, 31 Jul 2023 17:04:41 +0800
Message-Id: <20230731090449.2845997-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: f431d2ea-569e-4454-b767-08db91a48943
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8K5uVdMBqS6487sE2Nc371n5kl7TgzxuKHkcuizZ12iCwNLkx5Yfty+6NTvm9oULtLDrDUJWO1YyLl9jC+L5dgMZvIcruhVilWaZ7SX+TBYyD67UwTz99GWCqfinRJ6ZhCUz/nCRzo45WN1yyuV2/mJjnM65Qz6fWXwvJ90caz5sZnCXVgZlIlhpt4csC1RlWEb9asuik+TacVCgJ3b983udLvNgvPGGHnU/JzfYhM01X/UBxco5SN+5k96objwOAFwGjx5oys1WY9doeIG9Kwy97GaM/cCs6TDWD2W4FSCJbVo/O6MyEVVzYJxKy45Gag+4pEFamuB5lAsEwlSwrUn7BBFbGrDiNboElJm48vYrpp8XJgek2HxEdws5YE0DMKWlSO4k6cfoNywfskTnZj+B9Ytnp492cIDFTyj88pXkZkYUhvgEz98XXKgiZ85bDB9GZPygZc0RMKeNUQc1w+PMdRSnX8qJETt3mINhkWa4HBqsc4drL1jeCvpalxMS/o7I4JSSQUbD0FCyy6tLYnh4pZX4Flfan2SVKhTmCF9t8UwQjy3N+ZpsrugJkzUI1KdHqEQYLKu0bbuM5GLWqsWf84NIHAJ9pBYY+53vkeq1+ZDvgUC/kqXXo5RycR2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jW8u3CF0c0Nl5tXFpPm4DZphYEHO/9vGxiixir3/0naUUVHZSuhrdDo8PDNT?=
 =?us-ascii?Q?yKBIjcNc7Si1HMQJa53fY9Wli/Ro0TkCCjCdp8bm/Jy1eFrx3KFdnZIhqnHJ?=
 =?us-ascii?Q?p+bFiB0zgzZei9TUBHyIL1p6lvWGPfG4q/69t578cwi8ddjyKsBaVS9bEfF5?=
 =?us-ascii?Q?7dvJKHVAVQxtk36/DhUUGwJMQqae3Xzo/VA89YOX01OsUoeg+i7JM9860vHS?=
 =?us-ascii?Q?X2uorypqSu8t13K4eWZ4x9vVZrQ8bDiwrnJjCUJqQ3SaLSjSwF1uwASOl3G/?=
 =?us-ascii?Q?sfTeme8JB4Yl3SG5K7OCEfehS5uWmhTH6ILILjbIDWEk2DQBwXvYQtZJCzL9?=
 =?us-ascii?Q?vBDEx7ofZ+vEl+rE40wTjLxwZWCvv0gqITJ9TRVArkzT/LcNonaSxXLBkUgi?=
 =?us-ascii?Q?DLPW+EoH9yTjKsJIGuRdvR5Or0BWoFHKhCfKfRTJjW+EnArQTgqz+erRCeAh?=
 =?us-ascii?Q?O8h+h+vEX/1ARCcAzCxAz2f3AX8pE0lzAgs/Xf4uAmz88x4NAYMzDWcADoKk?=
 =?us-ascii?Q?5z/EdsjUG8JxlrM+qYLk//zf4Eszv4pqhpUTyvUQYmsbJsP+Pj6GIW91CdEe?=
 =?us-ascii?Q?BXoj6zzHc4vKSBmed5AWN7aOjvKvZGrMZkeZBTJTxKAed0aVd6GprPpL1KFQ?=
 =?us-ascii?Q?57XdDYJFLw3mMXcZ+BFJE+6xA9cATDeMO/bp1dN790LzbB/J7PPm9HvBGl0i?=
 =?us-ascii?Q?NvJLdLpCjb4Kw/4wXt+cR4w2eX1RuiZtoITuPN6aI/sevv0kqXM8xGzwx7te?=
 =?us-ascii?Q?xbuzw0RReyEAbCHOBNwLk7X6TXwgv073nKZYKBChwAMPhqrlUahhnNO4CeFa?=
 =?us-ascii?Q?tvh5PNMJt6msyT6TTQXALvHJK3yIP2YF9H4v2woOYzQVDClZg/upQPQfambj?=
 =?us-ascii?Q?3Tv6kPEa/xMgWyvhSfZfStrFlu9yBcs0xCjAt+liriZvwdScaV1tyl5SG/MG?=
 =?us-ascii?Q?W7frEQ81xmTTGRlqMFa1SyAWFIo/l3UIWHunAuKiGwj03j/Tsx7BFFv2Zq0T?=
 =?us-ascii?Q?KxbywA7lelc7dS3O4S3cESSGs+0bAP2+aioi6bcElKurjsET3iAez/lnscuy?=
 =?us-ascii?Q?MGbQxfftmPq1uEvr9sRsa7uea6ba6sXZ/iyJRPgsUosKeFudRGPnUX9rtk2q?=
 =?us-ascii?Q?66n1w50zdki4MjdYush7MSLyaxI6sUqe/sfmrwjulCQUtJ/twJpJ4BLLBoNN?=
 =?us-ascii?Q?eVaYdC8n+EjnHrYJrhci3PD80sdqENTTTFU1B8Mv6nhGrQ0AoVrkvUXPG5mO?=
 =?us-ascii?Q?WmX/qPR4WXQZtMyZmarwXWqV2EaNEKrTSQ9qOLaijkTNLI1cKpwgyICZ8csx?=
 =?us-ascii?Q?BpjIkof8LF6JvkMsRUHXSpk+Fc/CneE5cIWdjm9gnBtRubn1yK2pAQakU4hV?=
 =?us-ascii?Q?8xZWWHliy/3EC1EdJLVdxaYu5mXIXnB8ieWpnMDnag9217qJl8ipbsZxxtWa?=
 =?us-ascii?Q?veZYtYdue8BXzoQqnd3VYqKcNKoVNrncmMwX0lRDBJ20/diNtOWrAdPMs2hr?=
 =?us-ascii?Q?ARXXtuW+niN+kVfIZmm5EZmqIErdHLqm/+7xpVmnXhI4qwMbZ0f28ylaAJWT?=
 =?us-ascii?Q?r6iq1TRDZn9aQQ0v1GyknwtNMrbmcntYaygE4Lt8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f431d2ea-569e-4454-b767-08db91a48943
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:07.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WES/0+ICOqiUd82YunqQ5slJDeFuJDryC3zxkJuBu7GmwBe5VWBBZLfnXyW/nilYqw89aEfPK9/q5lVWn9Sobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
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

Change firmware init level to subsys_initcall_sync to ensure it's
probed before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2d24359420d8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -353,7 +353,12 @@ static struct platform_driver imx_scu_driver = {
 	},
 	.probe = imx_scu_probe,
 };
-builtin_platform_driver(imx_scu_driver);
+
+static int __init imx_scu_driver_init(void)
+{
+	return platform_driver_register(&imx_scu_driver);
+}
+subsys_initcall_sync(imx_scu_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-- 
2.37.1

