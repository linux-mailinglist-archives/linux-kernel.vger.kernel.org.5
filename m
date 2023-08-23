Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6A7851C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjHWHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjHWHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:37:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4110C9;
        Wed, 23 Aug 2023 00:36:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO3z12b9jZFJnTjFepMzH4zOpNr8L5PGwbN9Lrv863ZDcTqzitjRWlBw1mJ0BqX25CuUK9HLQxjHrywjt3dLT/LQacfkkz/J9TJsdYAGwWJ4aFXfb/ayWoMAMPOpOFizlgKcYbqT+o5jtS5uncsNUoD2qJkGVTH73WoTXBkpxpjms/yfn7dARI8M8PeiWjMhvXo3x5FtLKFqfigwqIvGBPCJOJI+PO4cILlmK1C3/NB5i2xCyxyI2FlfLuoK7cyuRLhuLQFBdNis0y35EFIACF6dNLuHP/8ubJOgY/YXkIad0WJOCRFbw2goxxVj0pZib4eJ6LSyXpOdLnwipPD56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeL0Qexxw6ojyZCrgjl1e/l4TON6jlduREtJC7RhjaI=;
 b=mTbiTp/dGJAIcaDcKQtilAS81R+ICF1sM+Ng6Zxb7/wUQyOIF6RTYIJBJX+CxT9mUHynUzRggfoqZKxvvHiGG2mJna/IgFdRo2N7XVjCQazh0bUWeXUl5ndRrDbOj2s5haMPIaaTiq3OU+FEtAY394ZZfSqgLik6c8U0bd7UF7gHngnvrgTHIjTYGcNFe3W5e+h0v4cfCqY26TMqcqDDZ1KaNk30GK0GevGdyHvFC7XcAQH2ScGFAKid/YUbICU0VcKFJWcycm92S82BtDWho//pd1BKplrtDhtX6z8x0cWwYbAM6GS/mb5Ft0DzhpsbIMqj+YT2C8GKkINlaKATfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeL0Qexxw6ojyZCrgjl1e/l4TON6jlduREtJC7RhjaI=;
 b=gKBdqXhhRVwaS5n9rnw8oDBgI66XgrE5Fzzz2r5JVELcyJkKkvQCY59muUqnV5sDC60FX1hoEHduAq1+66tsug6s7UWNr+hTvZWWm03LOpYNRdnkNCLnOjl4CCA/TvN940KKEq9FzdyttFjXE9FJdA+am6ff7AsvlB0RRH4GIQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:36:02 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:36:01 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 11/11] MAINTAINERS: Added maintainer details
Date:   Wed, 23 Aug 2023 13:03:30 +0530
Message-Id: <20230823073330.1712721-12-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: ca72bc4c-2e7e-4b94-b30a-08dba3ab9991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: df4J2IQBb7hVDgzjndpRVYGYe1qi3P16i4S5QnGQD2QH6v16loqbqWUFeW4hbhM3lR9kjYHOY9YxC/mmSNtGpV12tp6dvOXVKn/lgCwjT7weTAUBGVK4FDtujbSKc/IJLUlkE3UI3aCCcPYZIrid5dwfse0D+Sl063lgYTEc3YgnJ9fm68NejvKp4KXMvec01PMGYr+8KnKPGvEuqrJRN/72M0cowIKUNVi9PSJdupxczvNfpEWT3XD9wE73fdd94ScYFdJrI6pvr5DLiryxsnGfB6LGZebmVqOG+nFMdVJekI0CpYKc3RcJ+sftbo4pQ/P/PdZN1f593Z+MefKMHozHUM1GzSily20WfhMiPNVGHTrh2c5IR4xnjo96iSg4OXJ3Jy14/JKNuKEDQIlepcP9f7+UoPzE/WvFMmjmrAagVWyLjUS3C5ASA1irhiwqNs//ptUE814kZPFVUWFdJXkoElCcYpzTeNLePgvvdbnBrWfY9hVnzGGyzrrWfvBgKIg8/RqBFFEMxUFud9KmF/ZNrKE9S78c0pDs/kyNZfhS4JcdeUmwbG00L42VAvC9tOpD/gFdgEMkwAa/KfZ5Qy7bnX6YCCHlefrW3IhoIky4g40xyqy2B3e2okBTQkN53/dIKZ3fgimUBuZIy+CfEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(4744005)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ilpji/pDSwJiIsKqu5/oyC0oLoANHZEy4bxDBMdf2q4XwPaCT5gxo0Mh6hx2?=
 =?us-ascii?Q?Gbj2ik+ex5muF2fI+4dLD/g2t3XJlF1ri1ADWr5np7b5Nhw/gAeeSJdUFCLN?=
 =?us-ascii?Q?lvXhO8Q3sph2hNdGbuQwtgkcF/Q3DiQHf895CmcZY5kk1cdxyzJv5xjC5u9Q?=
 =?us-ascii?Q?WAPqr8QprCQe8iWfoJ7OvrhMjRCN4+I5C1NzDvbD+t+ecCqlo8W82QOHhLNb?=
 =?us-ascii?Q?kfNmr0s7+3W9ZyV2yv8z+mHFGMBXipafW8IGzyx5dPPXs0uOsKiniMEkiON7?=
 =?us-ascii?Q?ioW1RG1Xo6JZJOX9rTxU81c2oRyU11wbXssngcmKItEnPDcqSzTGL0mYYJyn?=
 =?us-ascii?Q?qeR0NZfyKoUOI4HTW0KrbTAVZEarC71KtNm003bYWN5biSxF++6d8XVhwk7h?=
 =?us-ascii?Q?pxO7GiMEd3RzsyHDT9PwcSEqfQ9PMx9lEnlsmnKdvrvCsM5mpmIrMBRg+3J4?=
 =?us-ascii?Q?a4qwo/v88MlKASf6BmRgDR0ytdZ4N0vDYA9F2QLCjEJMWRSSoraDnGdn0dGt?=
 =?us-ascii?Q?Jn/Gj9xFQr8zsO8EEFGK5K8ZtJ0MJXfwna7wDOkeuDbogmWor7kUDuswcWSu?=
 =?us-ascii?Q?Z2snKPCxSzg6/6QuCoWhtiPE3bmDtfaN5r7Lwm9OUqKDDmDg+zmeL9TbwDaU?=
 =?us-ascii?Q?3XnEcPGLzZ3oXFCMQqO6DC2ccm9iHHWuO6guhw0SVM/Wf5CY6Vfk3p9aNsJJ?=
 =?us-ascii?Q?anCIgznjVWhg1/IBHnD4udi8KGjBH41UlfpYP2ZmTntONXe0l52tB/6I/0xX?=
 =?us-ascii?Q?7MRrqHkwmtyxaadLrglvd6gpBP5Y6KcZLBhoRX1yuedIIVy1U3gxCkHh8a6q?=
 =?us-ascii?Q?Dbs+KYzjk038Frda6nz+GGCV1PsSUW30Zcj4SoJ4JsvaRhKJAm2MK8jYwFn+?=
 =?us-ascii?Q?PyFTOM/OtbQf0LqMeIa2naRDLw26tiO84AXiI6aSqOfT5GQXouW+bXon8LGF?=
 =?us-ascii?Q?wnO8EGiVMKHIPLsjbrYE6SqVVZOvAf07PCoQ8sRASZSSzau3KrQXHet4NoYV?=
 =?us-ascii?Q?+ZUcilQVV7R4dP9KH5GjMzXFv7Yc9wPnKDhoQLKFe7WRFmmnpMcXmdw4G+JA?=
 =?us-ascii?Q?rUq9v5I7ZxJvwVhYgyuyu/iuigVnwDjrHz+bJwSy2LLFV1LZIUUriYUbb/m+?=
 =?us-ascii?Q?XI4cild1q6h7W7sd4Ii4toRc7yt9RVytdATv2JmfCT1b7aJcJ0XSyFLh6wFX?=
 =?us-ascii?Q?FASMZxjy0BsZ1Q8t+OVGc1Z/g0DMtBmU/m8hZ4CkSU8JvRkff611bdJhQBxa?=
 =?us-ascii?Q?vC/IAkARYOhfjj6WmcYQj0RhT8th6gLtXauhqPZRhsI+/nFsMcPRMVU8jCaz?=
 =?us-ascii?Q?H1TXED7vXYYO65x19RrGo8tY2MsmsbUgR4vloigrGLnrl49ufk3wnG+micHq?=
 =?us-ascii?Q?20cUSHociUbMGRr/cveNr8xZNulVE3ckLWdXBfmF+k/qdD9THlTFKl+oH1is?=
 =?us-ascii?Q?lWLwK3REgF/qhh7w91uqIFhPNIbpSPXqeSUeEzCSkjK4zh2ZBBWc6yONDP57?=
 =?us-ascii?Q?FNF5VudmJ4qec/jF5wJp9Mi01TTq8WYhUFA/FuQhrYjP18ihPZClazDBLSsL?=
 =?us-ascii?Q?e2HY+prGF/4WiBLwVxLYlp9u7BfWBv0ZLR5f692c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca72bc4c-2e7e-4b94-b30a-08dba3ab9991
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:36:01.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1fUtr1Og+UX/6pV2Edq2GejUoDfEx1Fm1frwh6Ong20Hh5SzQAC/sqHyepdk992anXHWVJJ4Y/0Oi90KZC8Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS: Added maintainer details for se-fw driver.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..654c1628417d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13620,6 +13620,16 @@ F:	mm/
 F:	tools/mm/
 F:	tools/testing/selftests/mm/
 
+NXP EDGELOCK(SECURE) ENCLAVE FIRMWARE DRIVER
+M:	Pankaj Gupta <pankaj.gupta@nxp.com>
+R:	NXP Linux Team <linux-imx@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/freescale/fsl,se-fw.yaml
+F:	drivers/firmware/imx/ele*.*
+F:	drivers/firmware/imx/se*.*
+F:	include/linux/firmware/imx/ele*.*
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.34.1

