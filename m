Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58805753603
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjGNJFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjGNJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF32D41
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhOtgbWH7dhpyEPsgyjqiIyugJZp1khOR+g0nYc3UZ09y8iV7Waq/W2E/+WpfPr8CirXozjl3ga6eCHknNP/SytGaawikfpKwEjlRDVbXxSjmGgGBAULVf5ilaXnFI7vWnRbd9ThR2hpGAtDZxDKj34Sb07c/6m9CgjKgpi5v1ZEwteZC6ZUbHlWiWLpo8yeLoekipztVxE3gFtsy222T/UcLE2Y9Kjg0kvXLFI7IVcSKTf0YmpSy9KpR1OrDjgMgDBMGUOcLXHuJJnQ0o47zslghurWqBe1B2MiDO+IG3apiUmdIGh0w3Ka2nAaQeziPfCIIEAgGN1XMV5zW144Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhMUA/3kwyFtyWc2Di3YyLCvbO10EfC9w0+lLrTbzvY=;
 b=Fo82jrNeS4XdNheDZLHKkg9UhpRhU4QM2ChY0yqkuV3dbIKEEHp/ReTwwKsk/iHMqyBa+5Pg1zTrcT/aCpPmN15yfl9uHp1xorBccf5QErHCn7WqSTRR+eWqSj1oKuzpAbia5Twt2UN6a4aZ5mgRFvAeikxF3JP6Mrq9ygRGyd0p1qODFD51ZM10XztJuZQZSj5DevCqLzFxvz3Ctgyo2e50XbUnK5KvimgyQACWPaA8JLub7NuUHqRMUqVuJFxOadUehsCFH8PDznJS8BtM6rZeUef0YPqymQ4m/Mv+ZoDEPT2SfRa//hRvGh7odetx6CPabI/tLmnuLfN34tmQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhMUA/3kwyFtyWc2Di3YyLCvbO10EfC9w0+lLrTbzvY=;
 b=VBe1WVm8ni73Roh+lTi81N+a4/fJ7Nmo/l9+p8VJk/u7W9+GxKpcws773bjj4U1U/lOWLw4lb6LPqxwVT1uxKqtST70yFRwuRILtKUfxswZI2Sr05yLEKVXdr7D9Y/6GS+nWfTtS+hELQqK2Hu9tKK4EpeZQJPI4T1laSi0KMlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8069.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 09:05:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:05:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/7] firmware: imx: scu-pd: Suppress bind attrs
Date:   Fri, 14 Jul 2023 17:09:33 +0800
Message-Id: <20230714090936.937344-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfd2cff-08d4-4c62-e4a1-08db84496a9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zjjokvb8A1DTt3PHd0rgYX7ZWoBXmrpU6TZBf1EWLB/mRmdL6sCZ8XwCjugTY+A7LqFOCVPEz/CuisXceJFmkkQaijQqpzVt1JZLS//ckAV5fq1wjg8pH3vkiJuBBnwdH4cjhnDdNVhUdx6GwKMtrc8PZStl04MLVZBub00tKIuJvoHjxsHgPJZvwdkgcyJHbEILyWoeh1+Yg61IR0d5xFwx1aE9nrTQT6oYpr8ZqbX+437aGL2YqkoT5lUEDh/0jqifAefgUZiej85uW/RU7Uhtpo5ZBHoMKIm/dGn8PK+0Pt1W0GhmYAIkGPN3OBWXOgcpeiEjDG4tSvCfBg0Yb9Ml10/0UekX8+mYmSNGPoDmaW5Ji+jepkRLYaoKh8PdQn5Io0Wnz3d880IgB1sKA5318gUUxFPAIVwdZscMN+LvEN7aq/pkUeH7ttA/Fnw3/beUgX1DNgC0FrL6UfL6OYR2lO69m2XFPl+J4kIxegOrHKPEU9NwWmM5cEgzNKIGELls6tiYt1I/GSyisIqgZ1LIsb9Nb1P+E1y/wnURvMBwPYTvNnEEF3EjiFPlBOLV55s6zOjMS9I77m5ZVpDEdWoVQPrmge38eqW/kSOWqUl6IHhILb5hOMO4aGFHz20k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(2616005)(186003)(26005)(1076003)(6506007)(5660300002)(86362001)(8676002)(8936002)(4744005)(478600001)(41300700001)(6486002)(52116002)(6666004)(316002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2tRWHEiiNgh2+/mh/jV+XbtZyeqE8gDkFm3zeJOLZ65YrmhuKWk2KWWyR67?=
 =?us-ascii?Q?9YwbZuYX+fTsQXoQ+vO9t8Ae1VAZ6XZRPYfFWOmuEEWc4bc8PkPyz0Imaca0?=
 =?us-ascii?Q?iNNMQPisb2NeALSXY99Was3A17JRdgvxW2rbm2QK/7EwEhtwv99JY79q+C2i?=
 =?us-ascii?Q?3tEQNV6yMzDYTR98b3ZMU2at5PJR53pCsDPjGVvRwzLjdFrtmJ7Fjc8YI1S+?=
 =?us-ascii?Q?Au59TSRutJ2mvkreRi5D9jrTC6R2QxdHbiO2/51r332hlwqefngbh35J3ohp?=
 =?us-ascii?Q?rwt/4yc0W9+bCV2SVc0lE5JmskNXfYL0bJBe+HRz6/cqePi7Gjn6sPvNrG8/?=
 =?us-ascii?Q?RwB3wkMftUUqc5Im2svIstVHwrx04sJA+3QyUJqYNge0rhlGmL4xbc1PBoPg?=
 =?us-ascii?Q?vV2NwwME7A+C0OF5rZXQRVlN3++iLSgiWG56X8pulDCZL6rVJiby2KBoS1YJ?=
 =?us-ascii?Q?29fVOfsQIB1jPMAZ4pgBIm4LzQTvbK9N9KegzcdSDo1D+krbG8VSfcMx9goH?=
 =?us-ascii?Q?1Wv9ffzj6ape+Yx+OUviSK+kS5o/lWk0UR8ZeVdo2ukHwWUn6pBRvtOMAhdL?=
 =?us-ascii?Q?d71TkCh1svdIHWPCCzxXxGL70qW5pP9Hms893eyM6ot8j+wywME4OGHMnGMo?=
 =?us-ascii?Q?M6mwEnizNUZjBJjlRlikzx28tbfOy5V/uhk4uIU9czEQVxV0vBld2OTOpNGV?=
 =?us-ascii?Q?i89LTDp47RsPz3Xr01DJAlsQw3+egmqW0Ji/IXt/skHVwmbWRj4y1Y1GSqwf?=
 =?us-ascii?Q?9iP/vxLUpyiSaaiWBKW3coE3UYSaoyWlLdGNiNs3IXGMCFe5TUpLZnFhK3qe?=
 =?us-ascii?Q?s+MRP98mJuXg55qL1SzNBOuqX+4FNNsrY9YJ19fzFvg3oIKUyqe7AZ0P8CvT?=
 =?us-ascii?Q?CoZzl7wathym6w266AbnzcSt0F7f7iZ71iXS/ZLwM9dIoZBRSGX+VL2+GewU?=
 =?us-ascii?Q?QEqRzfD4Hpxs1AMFsVKHdmYB7C3NTqD+H7hEo62835+h8SsLDBeU2qc43gvv?=
 =?us-ascii?Q?8i71T3pGa3813ctI1rzA+dSNEe7+ypYO+cWSDOdo7WmgfCBRffkGzxXXpAqD?=
 =?us-ascii?Q?VdwTQ+QMNpHSAp3S3SDeZesxZCr2aNmF8PJJ0aV+744aZVNdE7yPVg6a7U7N?=
 =?us-ascii?Q?RJPWHk4Cq4Nshk26JrAqG25SVokUkvfIh1lhBwo54vIzZqct5B052UAkyZAz?=
 =?us-ascii?Q?G3Tlw+rHkD9+LU03IrN6vrO2551aJm89n7Y8ik27+KamDQNPBsRIKPm/KX7t?=
 =?us-ascii?Q?PlW/vA8HzudtjVWK83lH5vDkd9tX9m0OY3hn+3J7yJRaE/g7dXcc2iph8kHe?=
 =?us-ascii?Q?6yROntksSN6nzzd8EwPtSrmcZiJ7MhwAokFN1W4VG3WIFNfvDZA7bk6hmgT1?=
 =?us-ascii?Q?on8C/+/cZ0fGGVM0uiRaiM59fZA8b6jT8HB1w8IQiKOZ3QduViEfVvT+ZBlm?=
 =?us-ascii?Q?EYc+dsP0Lzg0DYmUbrjfVQKOQ6yQ4l+pE77xqB+2HPEtYRXvc2i6WVIcPBHj?=
 =?us-ascii?Q?aGh8tr0+AorWEoQlTgNFTZIB5do5Zhs6lCtXhuY2Ct79tfQpSRS+Z0q9NKdR?=
 =?us-ascii?Q?WqgE7Xt9xL3z21MSmTDTWyFrgdINvOs0xDv0HQit?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd2cff-08d4-4c62-e4a1-08db84496a9a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:05:06.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2BeYgnkPh3x9UUfPuNbj5SKyjEt7lH5lzWszdrFHAQ86pnoOxjsnRXf/cmIhz7vupcoaHtjp0kkf8pHAXmFdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8069
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
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
 drivers/firmware/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 6770be51d234..9f8dac7950fe 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
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

