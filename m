Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD8975E984
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGXCJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjGXCIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:08:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5D57D98
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU+COSLD4RYsG6aMQTDIjX8kvWa0ZOhioOOSiDkLmqDFK9apP/1MBgYj1CsXPWAcjpIow2A09Nx8SqlYZ3FJ2l6mGK+MtpcV65iC9EB2p/tJOLlT3UMQlwSm2HI4l1p9GJgEK5xtuSL+ILd4Fdcb9gU6Ale6plCMcrjaSwRN/gqHP1oMO0R9DRguTKYGjY4YbNhkXe+5nEyRV5946tLgP58tJZXbkalcgy/luPN3qLyyHjUfNKC1MvKDWHqwZfNTuATcd5XbbSSTiyjq0xVFG7lSYkctVPISM47wXwczLF0VoBpwVpJUSvNtBY/1pO8v/QdkTcyup5ewwTNRh379EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=N11ygMynKkmjeJifHtiBvpU0c7AKGBc14d0/vyGHdi3K0+kceeSjtQVOxC+ivM3dUVKQvuntI4PCMYpbqcTLvL4fudn7DOUyb0UdwcTcrSHOiWaO11g6lUNxdlWuH9KxaD9HrS33dkH64wQel0d9ahp0r/jMghDXdUdmPHp8zy1CQDZOz/ftKQ6MRkWfGk6xOV7mQy23Mw9lmxNV1XUKzH68rtjN7wSbCqVcmJ9E8McUzq/a0AI/LZj3oc1w2y6fsKw3+8N3BZpm4aCwZmFWURRXsozlj6xdr2iqtQADD+vPpRHP1oKp3GtaYMUIKULtGdHGQq3H8aAEs5Pd7YziDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=YdHcsnoU+EYIWb0/PrHnqBC3liyHT/WVQ+v+qhoXG9ibGHf/803BFB5xB4Uni/JvBsrG/UvdLRQc8jeEVfVmLK8VsL+9JlCd1Md49CMSnEDK66SaPizsGUOpBREfIGLym1jtoOV6+HoyMWDwQK0ZN9bLiWrLIfAj2W2IWu7mUkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/8] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Mon, 24 Jul 2023 09:47:02 +0800
Message-Id: <20230724014711.2048958-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 01512a0c-460c-4dd5-3335-08db8be73ec3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33xNPzL/Y9DtwbRQC5mR4deg3yjJL2FN54hW0aRFk4YSMUo/xKDjVMnsqlufLrKwpx3ys0WIJ+5jSXjsG2ZdKo3ZB9aXdk9g6lQzLNPqbZQbonvqr8epAQJvs3BWU1Xxp7HJjcrQ5RsUMiCyCQTljFnE0Dgt/AsfHLBJZnDy3yqfV9kq8dfB/0I9n4iyzggBmlge4owfMzLR/N3SfCuQ2CJqulwgOhps5l2aF8DGg71rnc2YcFdSAKlSnwBv3/BAAWhzYKCs6oD27/Ac5B6pSi6c5PYdelz3nR0zaQiUz2PC5h86KHUCVxcd4Febiftzzkl6tuD1myh9xFbd5hp/7zDM2dTe6SMg4WRLfzmCCMhl1jOy06o4wJ5H91ycNJNuuPpmkYKeSSWVclbf+efBqHOCZIHtwx/UEwsYIwngdcKMhuTIDjzNxRACCA81MnvO+UlGS3X5d6FNTgTaHrJ59+4no/B8NDatPVaqTfWIXqwEV1awNYmMZWV2BscDnmApXI2g2Pkrd0CZoVL4yGOQSrxXz0HmWaIS+hK9gPZGjr5u6TLV1o3QLQueeD6dnk7AWnFN5slkqQRKQUOtgpMJlwuYeEKYcZakn4QNMMT96tr6J6Y53sWw9ISQxBUE/QgK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t2GH/lRdYKp62iJV7M8ciZ5xZ2gvR1UKCBRwGLHKsY9psjzn6mrMaiJtJIDY?=
 =?us-ascii?Q?JCpjsjTYRHPa+ZjYlGl82lemuDcI25Xqu2igrCJiqNvZ9gysC1Raz7yOAGW8?=
 =?us-ascii?Q?OFb4Zbj9iE1CPEUydxPPTIw0dVqhytvj4jYAhDGHAiSPiy3DvwnDBo85Ew5q?=
 =?us-ascii?Q?MYe/dTyGJ4ljRDG4Dkc6r0u6kpdqhBceSb9lJrM3SAa4+sujHJSD7JtDZrun?=
 =?us-ascii?Q?pQYU5ezUAkPEIHalNICDD8EOYalMh5GGqwAXAb6iwp2bzU3lmTsE6oA2YWnv?=
 =?us-ascii?Q?UCpxx65nW9fHutqswm84XDd2zOrToCATQjEOZu98d462YzW3nTJYQ7jAKcev?=
 =?us-ascii?Q?7LnaJ+Tiq+OHemwfIFM79abL9u0SwxTfW9++un/JB0QPfWGCpv5/SWTFsh91?=
 =?us-ascii?Q?ffS0E2wjynO+70wlF7wkwirRsEjEHqTYk5w4SG9xi6KVkcrJ1NT60iO9L2sU?=
 =?us-ascii?Q?5D5W1faB+A6Uy7HHL9vkH1HYjGS8oi4+IwxgO5BYq9CkneL2WI3LHtKEz+p+?=
 =?us-ascii?Q?luQOHcKvazEZBM5IFvirB9zQoWfECK7CfOXpQ8dVTbmF5pRhOpZBrHEHpnJN?=
 =?us-ascii?Q?iQXbRpSd3LZGaj18jQmi2tIS1FHXUDRGUMWO4qJIv40EuHK9HdkVBLm+NKML?=
 =?us-ascii?Q?XbZpHCoZCEOEWzZn/fQeUIEueiEEdDGqB2mxBBCAqUG0hx82ZihVHqsOgg8g?=
 =?us-ascii?Q?XH8M8z9GNQf7laVaHkEMvNdIMiMZBr4GpVoCyUfNyBhIwzem3lkx2ZYk1zfm?=
 =?us-ascii?Q?7bIYfEc3MW0Q0SNqINoHHP+RPZqbrGlwkss3msycT1nfvXZQunAevaGzTdi8?=
 =?us-ascii?Q?2IMbaoDSQVdhCx5K6bcI6yneO0TLBfnEbkyqNRuutemWGhgI0lI/IhAO9Ygv?=
 =?us-ascii?Q?9ay1b76lfR/fvLc3mQBUiqlleRdD+62zXInp0+bW7P6ncSgEaKqtzQ762bx/?=
 =?us-ascii?Q?GA6cysnOj2MUrjV/r91FK/bdhaxrH+bxLEVahBZpaXd0YJT4qKxEBbFXCjuc?=
 =?us-ascii?Q?nBBaTnWw5Ow5Z+Ohti3ztHBhAtjwxwMEN+sHOwpCtssuQ8T467aQk4QAy0Je?=
 =?us-ascii?Q?5zet/ivJTZKhqCZONaljMlo/KKrIB7jkdlOpFDjH+0NstiBHGO0QMU4MZ2IU?=
 =?us-ascii?Q?FqxniJlGavgXCWUQB6JViRfuPDQ2dqNEONY3ImduUERRi1WaAjV6jFUqXp1U?=
 =?us-ascii?Q?ozo21PUFJCMc34ZnTIlwvjIIQyd95C+yXFocaYKAhQMF6bCRfLXADqoxaC34?=
 =?us-ascii?Q?+xspubGkdx+5HaFGnqie7oyKAj8YataZGFxSX80aqUODkWQyaUlZuxTg9w+e?=
 =?us-ascii?Q?She9yfC5XZTBHk469NXkGJK/uxiUj4Z+ix63zm3lguwiBsdhyzZaCXRR3HYS?=
 =?us-ascii?Q?hZCm0GRLzN04/lfm8sFWD3nMm54gDSgiDV7cci4c9l/AzdP4Eva6adF8ACk+?=
 =?us-ascii?Q?mRMiSffi9Z5SleFJfGfDDRxVoXpGWADh6DzbsflYsKHJLmrcWV1dLjI486v1?=
 =?us-ascii?Q?gNPiA+xM/ahPnKIA7O0lC9U7BIhRiCc6lDUTmpubddVzDuhg/QVIOTGg/9IN?=
 =?us-ascii?Q?VbaT1B5HmQ9qAV0xEEpdlYFjPQYc37KkXv90+hcl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01512a0c-460c-4dd5-3335-08db8be73ec3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:31.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7I/pseSZafhsHrFPeHjHUYlYUXapksQbRwnQ/UyqXEVJC8VoswruWNMz6eIA+4T41j20ADc3vpl6mX2oY8dgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
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

