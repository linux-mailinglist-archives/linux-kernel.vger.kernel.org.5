Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9275E986
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjGXCJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjGXCIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:08:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F6F5BAD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnfhEVAIiGGyVYzWby8IlM/jHk4/CHUS3GOKkWqsUYG0r9nWsxsK+Ulibh+bKn9F/UxyqnvXWNiN7+jxMuB1d/bPpjfa7b44IoN8yYOpT6J2FyKzb6+pnxRsKHoBEsqdue4fYunBKrJBKDiq1cw34c82oZSEtE3qM/y8wFBOAMAteIp1GbAnbcDb7+k3+BG4fB6Yk+kWIVVw5z8nJPK07+Vt0IDk7QJ7LYjvnAEU2zcCFsqUpt4oPXANncxxX0G7dwmg4/bzWYL4TZ+jNn3Hnr3m602cTh2H3WwJJ6E7RNPgSCamaCyFK/En7NHuZ7pGGZ5AxvpPUVSW+zmY9UDcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=O3XIZH6MX/qPbCaoc7UhC+BzO2xHT5k6NdFXMdtzdju9KAIlPYTyIOWoP0CZRc7dKBdSjG8JfJ5Gbfd8A8vN9ijWfLKIqUrkYLmH+qBUGgz5GZvB2+MmZTyj1RbQBcInyMkX7a0YJFEDIurcDnbWYZ5tbkK6oOydNxaODEtUKnn4VGqcZ6UMA1H3q+MqR4Dd2bmQqoVrN/q0Epht+mooJE0dcs8wSwt+EhcyMwnOM2+49743wjQ7x5Kg6ePvm4nF59aIl7D4G4CTBTRAz+oMCTof3G4qWxQ48mXZZiBJTcdCtyApQJ1fXN0g8H6JJf3t+E/XVsIVwLPyTgQjZLpxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=irc4LBEyQRdkIwhd22rbwjfZCrNmN6tqKBLcLcbgl5ldHN8YWhGFL57BXJnnLcoKFUT368USZR7MuVqxVH7L3xe9H9Mb1OASoPJReh82ZeiGWSAIsX/gmbMYWLDFmahXXWEHL5ilFeBzNpdnhPjSYIKOtgXv05tLdNH08uzxA5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Mon, 24 Jul 2023 09:47:08 +0800
Message-Id: <20230724014711.2048958-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c39922c2-e82b-49f7-8ff9-08db8be74b12
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z84gHEEeK9T01YHCOijrwY96HF/ZKLIyjQg/DO7SwRuWoucYXht/AlRn99pccUzK/Po7RkYIq02f9/UGbdAL/n5dkfJh1uhIW8qsJsd1TjE234JCSES0j8epXXFtLSRaY+DAYmPMOknq/I9K/13DiilSN+jR9E6geoi22qGNMYeqh/namXAfBJ0TiKIAKarNzYCDxcDcmRbJvMpvtsm4VJIMpu/puh5NEx+UhNO5wsNblzhBLgKtWd0jIUmXqF0+kG7HoRcNfo4VxSRmlM42E5tzhUxcX9lJJwbJpOKUBPLu4aWx9ZH324nEsWjV0/OQEIncttz9p8yhtaiishfG3BL5i1QngbkrhUJZ28DLZjS8U9lqD1OdyF/4Qso+a+z9J7aV1qwEsdjvpyeL/LXQUEcVH9lCFeJNJQCVkGJ5yzuu0hkKD05klXHJywlRyq6fbWtfaJkySVmgsvsIGF5uA1e9+vdPLJTCr9dMTX+RIxXQV2KIGI2AfnTzE+zhfwck4sO/xkOUXYSxDi/EhWzHILr5eo7fGoVaVTlPdcpFjL30qdXdHCNbC3UUjUsQebGYXVejbkklYX4sEn/GSU0sLITZOCKaj1lmaQ0OgnDWrGd6ENRsQSWOzciVHZ4ENYLX7hRXTwkUuVk/Y8jhb0LLUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uOLLiLAPSGaj5lse9Y/QThmd5FdtxboVBR9wWxgi95oFHoAJs/knEBx7vgpe?=
 =?us-ascii?Q?sW/8Fs5ROsAMFpbj93P5UWpvw4TX2pRZYzqK4xyYINK5o/xrRg84UdnnsNpC?=
 =?us-ascii?Q?kQr/557uAnZW0tbO/GShEpO758Y8XXn67jO1D7oSud7YPATYiSWO06qBQpnA?=
 =?us-ascii?Q?ctuUzVEuniwPDgLylZnrETX82uTRHmlUyukj9EzeAU05giRQxUWd0HZu5PTI?=
 =?us-ascii?Q?rQknpkB248ZZ3DFeh0xBj61c7PZnXfJuJrRM3a7SbCGcjQmDcGQdtUEj0MYW?=
 =?us-ascii?Q?IcqhoEYCXY8g/tnR3z/ShX/hC+da+IUchL0acdkZ8RXJV3ob/2MFG6e2sg/m?=
 =?us-ascii?Q?q06x2G9Wdjt5585yQBhuIbggDOz0CSkPOfLBhwWJCxl+ax+BpMnIAW/cuq3Y?=
 =?us-ascii?Q?ziW/UPlsicXkj53aWvaGvOhluvz4ByI7KbllLz01c+O41Fs74CaYG24uBEvB?=
 =?us-ascii?Q?UwFtKAENQcOVyzSmkTW/iaPrAU3aviaIv8GjqWaSVSnV4R/8YAAml43FY4kH?=
 =?us-ascii?Q?s2/oE8EQ772vsF8wLN1lqOeNlJXz0YxE/+Apk5aNYS1VLbJxBDBmIjR773tX?=
 =?us-ascii?Q?06L9F+gir0n0DfFhCbMw5H2Sy8MMuqbVrnE9tRC3VVzfOfxT7jFbCw/hfdOW?=
 =?us-ascii?Q?K7tbDrU+NzFZEKzj/cVchammjpq5u/jNbnkuDUBo1fJPW3+00Q3YLhMyIn9t?=
 =?us-ascii?Q?zVfuxdt8r5w//BIXLCu8JHxK78vzdz8FJzq+Pj5FlM32ylL6ZY9rs9fkH6LY?=
 =?us-ascii?Q?Sd0/S+vWulAESNs0G0SVlHv+o3yTCBeI5+JF6IX3MJVYPeCuE//UZfZo1z4K?=
 =?us-ascii?Q?jpPo3RIPbN7Xr7frDK1iuvN21PlpJwvSw8zi9s3bAhsL1R28D1TfsYRRUh2f?=
 =?us-ascii?Q?h7Mr4ulsjnUlRrVZfBOWhWfIMYsJas/67R0r4jY9qKUahb3Krqoiyr/Cxsr4?=
 =?us-ascii?Q?FwjxH+FP+QmZbUKm6wfPJY6gkIrYujNuYouMzXfrvB7HE6wurF9tkc//+vna?=
 =?us-ascii?Q?7REcgEhEkwCwGdgDl4ooS1smi5lWTX0aiMiWcT/oyspP4bMOUGE1REyCjTUI?=
 =?us-ascii?Q?HbZ0CyThOdE8zREr3uy1n0z2Mrd4c3X9qh+HQaYhbS8Qbs2qCfqn9B9nszLb?=
 =?us-ascii?Q?CMootOzu5Mt7yQni6W2uL/kB1oFfrJYXNv1SKEcbksHw2JJm/K0pqXelp6Gr?=
 =?us-ascii?Q?3x/hjqZz9ihK0H7khhYfex/AuPsnYK47MXtXEbWooOzWYBz4bonOsAb8zLDS?=
 =?us-ascii?Q?zCGaytOklfgF6wrDVTOacoCcDjez4+R31RPYbfl9SXKwkKkUpH0wleBBw4pP?=
 =?us-ascii?Q?YCKZyvhYUDvwRJhWNZNOFOYuLZuOEom/tKXPBHczl0wRc+vLDbADGllGPQLk?=
 =?us-ascii?Q?TqySJrVsUsTnTi91RQTZXH9ZmgBx4UTaGF2b4ttucwKPZM4PMvbY1frBUccf?=
 =?us-ascii?Q?ophBrOdk9bwrceqZ22lVJweXPR4Suu7VG5QlUK7j/uyzEjf7po6oLqr4ervX?=
 =?us-ascii?Q?8u00sTFk7XaGwvDY0YvwsxBOEBJcFY96YD1VJSMB5sBv70ZJdhl79NToP0Ln?=
 =?us-ascii?Q?R40V7aP9U0Sh2n580p95ppLpZMPKq46KKdRnzp4/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39922c2-e82b-49f7-8ff9-08db8be74b12
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:51.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIb8lZYas+b74SrTPeTmX6pJ+8+9w9ufaIL7NKjzucXML3Rp8sZgHYoIDeQVDMPuv5kQY0Gj/fFOzIT1YAjbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1

