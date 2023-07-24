Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD1B75E988
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGXCJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjGXCJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:09:18 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC274228
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL7ZpvJevDzZ8YvQi7NVuz4kORS9yqrWwOn2KhD9OhIVxuxXu59ichICX2oszYZ8gSQlEDFNqvv3YFj0ckHDER8UWMWD8jgL7ur7q2hOx3G4XbX2/P4+J9JeM7zoo++hlyfoa2kWfjzWvPBqZ1Guzh/KSQ//TB6iJDXSW9nIVQegBCKQp3wqouysX1nVsyW8Du+dsc84Y4QbG14NHppyKj+gC/ltB1X3OCgjxmWi6IB4S7BwjuZSrhm/XjLckAn3Dbe6hpFe25aLhwnny41EfOJ83KXwXkeQ9JdzE0eeUXzlG+RPsa8Z9b7DfSzOHLycSN0h9Dp5t0RvQhevOTrB4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPFrMGdocAYftzR6NYjRuybUXNm7u//BVCHc/B1LQTM=;
 b=doGQTLNfnhgTEudKw76XYWw34Apj4L3amy5v84P8IT8ucYvlm16douuVbZAdB4pWfr4le0w/K3Q1jNTrFKVA7P3aZ9inwd5CfYJyGtORCCyeRbxCkOLVweAjHEbeu/DU43lYlsahkz5Y+kYQYHGsq6bwVIRktuCN2o4QI/7GjybpjCzGNeyrSMPPRwhqiuh45qNU2pm6ue806E/IeBtZkWk97U3UK9Eap3MQfDY5FdKWXFEr5QbbOT4sROn+DXXXXogtk6c+fxLGTmynVtV3WkaN/V2norXvthlVw+r+8c4ZipwQ6m0W+gG7/2oSe8w2ypOAg5WvqX5oD+7we/ffvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPFrMGdocAYftzR6NYjRuybUXNm7u//BVCHc/B1LQTM=;
 b=TqJRMszCJpU89Ni9AHZEmz/j84yTjyng+9IkYp/ItxiRJm9n4ZYVHoJVF3GQlP6qFifHjmS+kL6YN8gw5ge/QK3OF70/C2/0o/OAUKYqktlYm8yIPp6sA9pI78FC6Lv5B9R3pnyXVx/LlvoMAePYBPZ0ndx+ae/Z8gHEamHLaDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:43:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:43:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/10] arm64: dts: imx8dxl: update scu-pd compatible
Date:   Mon, 24 Jul 2023 09:47:11 +0800
Message-Id: <20230724014711.2048958-11-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fda4eb31-f8fd-47e7-c898-08db8be75143
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzSCNtWSz4eidgpUxTBTcshRfanqeI0IG73tsbQoU3DNO3u9uxiEw3cBy5k+uiNGk+dkfd7Ymbvni/Vxi695lfli95ohcV8M7lVRB5NPvcyfudr77ZwP6KIW7OGmlk5ux9wpl+dkn+FRlBBNs41ycx8SdvptjlDOM7v6QUMb701BK95V/fUUolMrzZwhbCM2MNe0LcS4cV/FroW8a/+qt5hRzY7R9rnXTT+VmuCe7Vz+AFd7j4Em/xSQvbtMnk/mg9xuuPspXaILGTQ9wnzoytWCUeqMx3xkMlsJ4mYRwjfANsecW1fukJOejP/UYPNfNwNcc9FKeDs4umU79WssS/E0p3kZchn2d5VNQ1AqtJAp57Se3ncomdnDeoi7bEirG+6j9xsoi0cgYMugIxNoJBrGt9OlzOF3DA4pCzOmoYFiNsP62IZEPuXluaoW/jsH4HKGBFST9cyCLozV7Zfgu0HSlMgdZHaMMlt5zbBnIEDo4LscBBc8divzlYdKIy4d4v1eh6+cODk1T1tbUjyldzi8pN8DC2vOkumS2xP4Q3QyaEe6HgxUWi7KAvw0ft6dyVwY+GU3n6rNrsMZUiqeTK8F9ggP8jy6AmmfAa0aZZ/j3i5sAV7qUJInbcwpKe6zjjkEhGk63yVNtE/1z5ovFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m8dukGR3m8vMvJEl0fFBmtnAP4tJfJHrTycc5+vdsFZSKBokPl++N144O+6P?=
 =?us-ascii?Q?+9PvfRyITE3RbpNMch7jd5aL1ehbwunXhUH92ifucQZCbyzxy4DQnd0iLufw?=
 =?us-ascii?Q?pquhYibrFwJj8JRjmWSUUYNxXiFPc87m4Zo2+u4Ii3qhzNkPRQK6/giPiGX+?=
 =?us-ascii?Q?HNKXpG7dgq2qj+Lijpex6FV/o4k7ru3WPOiUY5q0rMIUCTI6lsendmAiA4fm?=
 =?us-ascii?Q?P/+Hqe1S+V38LL8nLHrP8rDAGsutBYdUTiBOMc1PoggUFd2MOgb6cvfAewBA?=
 =?us-ascii?Q?jfm/MXFdbI0KLnrIRT56hexOoUC9b/RwGglC0ppk6zX1LR/rJm665WWlSGtT?=
 =?us-ascii?Q?yJYim6Ha+Xp5fY1N99U9vWztEO++MVrfPO08LBQ+XolV2k6nuu0fbqF4e2ra?=
 =?us-ascii?Q?4I9BUAwK9nki18P51yOiK+KkMoIeUULG9JiDwBoW+J5VqPjTIuXY1ffRbTgS?=
 =?us-ascii?Q?5PZX9QH3BtSfsoMT29HSiaE/fnElC5I958Yg3h0kSDC2qwI76xLXZFcicIEE?=
 =?us-ascii?Q?PlcLduCp5i1rZXVa9vdHfxQeT/+7Bgfob997KR4NYlkG9xcy0qJ3tP1g1/iw?=
 =?us-ascii?Q?kzuJCsKkxisjDHHHuoFYCC+iN3Zpb8ESpNZU+XHgeRB4TXpuJgD+L9AZMOFv?=
 =?us-ascii?Q?ZT73MMpA2Hs7sLKFUw+g+p4y+HBVQRmlGyLuYUZgucF6DTCKi7MbuQeLgVCg?=
 =?us-ascii?Q?NZVrb7hTpJDtCd9FurrV9ulUr7ZWgJvDIoxmZuto0Sh0k9x5z/snIBcrw/9O?=
 =?us-ascii?Q?QX6cg3YvcuUEIxsBc8oQNet/eqdc3eaJwKWBxqCKu82vVO/yeOcN1fEj7gGY?=
 =?us-ascii?Q?oKs4nh6mzMaiUiWdrPX3d+LuPZhEsVa4OSluOAiGL6lgGTVssJVb2boOzhMZ?=
 =?us-ascii?Q?jW1aYfCFZaIcwGbtbQTDi/EPK+NTFPLNe3rZwEwKgtD+eZNBAUPMM14LdAN6?=
 =?us-ascii?Q?+s2n+62lKwQzkSuAoEiRHZScJoXRA8BKu8Oa4tEvVzZBe+wrjNSdHDh7XJVM?=
 =?us-ascii?Q?bFDmHPxtMFHXubASDVwWuZOgZ1mF+xwL1QYnEOSwTewiRTVCExY1B80XCItc?=
 =?us-ascii?Q?7sF9kI/kwYxx41gQRR23qnkL4SncBXL+RzYTm1gRBwzUxG800gGbhlycpAKh?=
 =?us-ascii?Q?KqCYVyuihwZRcSMeAwSpGm8EJUFKCDAowd7Q/dDTxMQGEYLX4eK0JKpsJCgs?=
 =?us-ascii?Q?2ulkaH1zuuASKmEnnFakdxAHi1qHqSlo6BbtHFF1DNEhwe2NqOvUyqeGDzCG?=
 =?us-ascii?Q?0yZyj87XjWaFAsQjMUaljkBiId2iKBq8YLIOnPbtu2Ayx7yjKnQlzCDdWwV8?=
 =?us-ascii?Q?6O4fn/A99/V1a1vYerp+6/g26Rqx7k9m1GidTG7AHYPLV8C3M5j3UChvqU+Y?=
 =?us-ascii?Q?CNBTWAS1lPoPYHuzu40V1zqUKbSvfvVl4HCIAAccabtdG7fMg1l3nGjudJ/+?=
 =?us-ascii?Q?nn6QaOVFUvpQol6j8bDwl0w2Y6oeiDNsu3DaNbuGf9JC65WYmJYybamtDAcW?=
 =?us-ascii?Q?Ml5yalnypJkIpFOXgMzJakHOJyZMKeg1LNg2uVBd7GgokxVUjk1NN9Dk3sLv?=
 =?us-ascii?Q?CEpqz1CAtaTyF/u5ke/1De2zcHHVxksd1D0hu/F5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda4eb31-f8fd-47e7-c898-08db8be75143
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:43:02.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgY5JhMo+rwnT8d+AdB1P8LFaTagj48MMxbgXdVWavcGSTxItawNoZX+vgtKZKCCIoy1klo2txBOjbEymJZK2A==
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

Per dt-bindings, add "fsl,imx8dxl-scu-pd" compatible string for scu-pd
node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 792b7224ca5b..32c69619f22b 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -122,7 +122,7 @@ &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
 		pd: power-controller {
-			compatible = "fsl,scu-pd";
+			compatible = "fsl,imx8dxl-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 			wakeup-irq = <160 163 235 236 237 228 229 230 231 238
 				     239 240 166 169>;
-- 
2.37.1

