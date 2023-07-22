Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0B75DC80
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGVM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGVM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:26:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5FAE71
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibp/LJKjpYYDnPKt4xc+r/mNLfXZuuJDXJSQ3PtwnH2Mb2kne8mSASYBfi+Gk/Xb9Qx7x075NBD9r8MxyxACBHQRyLJYR2HfxLza6PpNgS7LTmcPPVB4Ka+AWCOklCCYkrXtCNroZXtkcfmep3dkmcmr0eI2COHaHz9wF47+YZioVpL8hN53h0x5mBZCu/dvwOukV00tD/88bzkXh2/pxV37+Htb2wDfa7gQ4bhoyHp/btmED6QTNSjODkROrIfRTsdmNAM+7T2P0Tr3Os/iTRwCo17jegscCezXSqoZ2j8vz416zyk/l90qLQk3uuQGWKYUVvFrodY9JWACuY61Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=KzCeFzfy7jIoOgQiZBpa2HQA7zCrE6ZW63l7eL14awsNAVmoBbCZUfmiBvqVd4aNpCtPhVsQDtg+nOqjGLG4xL/3UheHLBlKGzPm3EIZeBRABuX+jAc18C3wpl3pNmSpuZM8f7sHhUa9dee06t/HLAIeGPo7xYtRlMvBXNi8Xza+E1XTxLBC+61Cnt8lXHa0Iy1br9lwelRF88vp+gxMmyXYzMALKKbqPCAGX2dpEoQgshhXmYq7UDviZi/zD6pqSzU9DBAnDIvpO2Lj4wYrE9L8eJACj0nF3JWOfZu0/+6IAaZLPlrfHZXAk+H2muBYCYU+2tUOo9cvBsvByawPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=Dig0Xafyp/fVBSHOScUtlxMCrOZ0PxDYlFTOpu/5qiuzF3OJ3//n6tab3OtfWhpvExl/1kW8ypkR61PW43LOiWYkEpvBhxtK1pXq6mwRzZgUpS/DMpVOt2q9WJAuEM0VLSI2ZqWMlR9tyFvpmztZq31TdwMnwqeBF28y7F8vTkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/8] firmware: imx: scu: increase RPC timeout
Date:   Sat, 22 Jul 2023 20:31:13 +0800
Message-Id: <20230722123119.1966998-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a8b51c-daf6-4c44-ea21-08db8aaee838
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ve0/grBC8ic12rmIiS3W2fdfrdX6wYcVNO6KOuXj7u7jg1SeUT4vfLFhIfdoLb7tORY0UIQualT3WYVzXgYQbs1BhnV0dN5Y/eJcu6RYJTnZvg+nL6kz33zZ2NS1GxSi0wHUmHky0tkIDsHgg+MxPLVfTexi9p9550Cnl3/6YZinVpCz5LsIE3WBoVvTUimdohzDpiNke2n2PEzdM1x0X6P9RvdaGOSLEKHHVZxgs3pb/mCJ6SbAA2u1gVvvPkks2TLKXxNk6kkLeqa+PhAj1wqv0QInnMSH7RJtDn73OiXE4gLqw3e3l+WnCsPZtiasM/CYXAIuRNu1Kb3WRaK8+lPyduJdo0RYGonYECEDKWRJGZfniOgXZCYuWg0iR45eJ1N3sYQlX9uPPS+ilH7O+3lBvbJjZKZA2CySjQblsXhuUQdV6euhZDItWbDGGXG6pLAB25SXMROKK5vTCMFruvuxGp6+KK4i1JA8tD/VW3CbO+NPlPPCGMcPPQEm86wMsjBYax8xmnAuTM5GaEY2Nc+6xA3PlOOiYSk4Iz9dUfZZQL/bPdJ8WLjSdFc0gsH3frDMDZFBjMMhyD+9KEU73A/qF7+lyCyBK8U1eu+pHszOlPdPEJucNvrOfGfWVREH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(4744005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3cNrbZzHKSS3WJ0Q4PoVBZKoHRbN/MoW7/d45lk/VcqeA4bmCeJZWW4xK7j?=
 =?us-ascii?Q?mAekHDeBDXdwFuQlvYlEWIG33sgGchmD52e7xF85vOutRqViOaMNdpz5up6r?=
 =?us-ascii?Q?H2PXd+V0dfmtgzqVTTz62lrYg563euI93C/PfmP6N2HPUZBFHdiBER52yi2u?=
 =?us-ascii?Q?Pn/Q44KLltxcbV09AbT3a5A28+7DwtkFlsz5c9/kVLqLUX2Lk5wkJ2WrLeTY?=
 =?us-ascii?Q?xfF9YmHhq25ZCqK73rsO2YJKpzQ16GN0V/dJxXFlmlnfieMxyAqU1ejx0Ijs?=
 =?us-ascii?Q?g3hz9kSGSljOaG7uWdNulKE5JRC0wdsMOnHKEEGVqadIHgoOQRZzkA+T65y3?=
 =?us-ascii?Q?zWUWAh84OKEN/nhZKXUtaFgg3T2EvxASO/BZ7bhgtHKqY893Mi2LGj91XI8d?=
 =?us-ascii?Q?hN7GfALgxpT9O4tt5M8aP+PdpMznTViutrCCPXttz/rTkzgCidhfW0fsSX6o?=
 =?us-ascii?Q?383NkfvMabBCh5YoiT1d5NsjB08Csnrk+jVdsZRz+SKwmISuiiSz5dhYem1R?=
 =?us-ascii?Q?cCG0gMXsdsByLNSSAlyWJWwskAxfYKME5zFR+hiFtiuvuy/nhGCs2w/OLrB+?=
 =?us-ascii?Q?aFnOg9s8KPdGLf/iFQji3d5oKnyuOzGCH8kOfwqBzgg9XRzr18RcGpi2WCnN?=
 =?us-ascii?Q?LDv5fygnLYmPiJBoyJ3RbWyvVP4eh6JWjA4iLkzp1ujAXu7qFOYIPxAmV+ZL?=
 =?us-ascii?Q?9LQ1nHQtRtN8W9EGIi4Ex2jCICFjmo460RKyND+F1IzYr10Yrk/Vx4YNqDxG?=
 =?us-ascii?Q?ZvpSmyUBps8Ona6oaEhRhvb10882lNJsgB5HEQDTajCCIux+qNoO/mNgEzMP?=
 =?us-ascii?Q?VbDEGx01aeuVOR/ffpKn4jO796rku1fxFFWw2dkEuqV03dXBZ1DPgWW47PdP?=
 =?us-ascii?Q?Y9lD/XcgcRLolPwSYCtVy1HwHWNag472iSRAktbAD7i7515eJj9InXf+YpgI?=
 =?us-ascii?Q?FK298qpprS5Kb31EdG1pD2MAfGaoCCryh4WO2fxRfXomBn+zA5tDI5fxGj2O?=
 =?us-ascii?Q?ShG4uYvVMqlkPzxo9wnvpA8QM6vDKGgmQ81yr7ZIATLl0zL0F/Pv8XSFdDXq?=
 =?us-ascii?Q?ozx75ZySdZpDZ4Wvv7i/UH3RkWfqWPsoaJ92ejMThIG1CtseOL+ZkqjEjsOu?=
 =?us-ascii?Q?SbZmYIgkGrvSIXnBafFzXohB5S7yGpON1b1oBc1RFBlZavBW9uc5LymbyOR+?=
 =?us-ascii?Q?52H1ZWb5uYl/PutCAu97sOb0DHfJb4F5J1I2PI8vmQ/dc9tCfktwoITUJJmj?=
 =?us-ascii?Q?kWwi5IkHouaaHndsx/QeBvUnj1wJOx3dgqX6bmZzLKIh9cQhzth0Dbykj0KQ?=
 =?us-ascii?Q?I9wlvCjG42v5tJzm79OD8NpXYi0c0AvT6tXGT2WSFKFXomp9zQ31+s2FCOA+?=
 =?us-ascii?Q?7IUfMVsQXUQAPhchpLAIwHrxnt+ava0qnpBH99MMohAdCAi3U4wPuaK764NG?=
 =?us-ascii?Q?eAzXAnh/7DJSyiT6Oxf9qXihztbcKk8kYloMEPscJcjb9awjbEoUL05ipNDe?=
 =?us-ascii?Q?lfqbJ1pOArZp4uyiNb8+lYBXWYCXqLd1HcUUFtuh4eRhsXXw51mmzsRQ8a4Y?=
 =?us-ascii?Q?z2FWxKP/d1PZxw433EDDjifd1Rl8UqfgHUGu1A67?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a8b51c-daf6-4c44-ea21-08db8aaee838
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:43.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja+bIdDABu8HTM4nkWZP4PNj+Eu2cOlw2C0KzUHwuaXDZbUvsGBzXhgaH90hvEo7LPB8GjkRF0Pj1Ak8JtmuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
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

When system loading is high, we can met some command timeout
issue occasionaly, so increase the timeout to a more safe value.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2d24359420d8..14ff9d3504bf 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 
 #define SCU_MU_CHAN_NUM		8
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(3000))
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
-- 
2.37.1

