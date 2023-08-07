Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA01772373
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjHGMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:04 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298C7127
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awWUX7cg8X2efR6jc18fKkfTn/dn/N70eJgcO194AQ2bWnZsJKgs9UZih7HQ1PEYcfeFcl4eeZ3G6wXksgIXfixBbaF6WeJ4+AUYgQtAzadcIojaPg2kZ22Nirtx9rSg+ofnjclxGXnitztyhK7ESps6OZXVkRVF1cMZaL3FVMDhjV0KzA+Xky7q9qHvobSkP7EzEj0aqugysCGfHb8ZMakhqEvRPLXi82wRhgSLP30rEHnVPAWs6k7UaymGPz0WSQoAdx3BZlhqt+d0SdHcKUG9AfQoNxVoYAhAbXj/BkPMJMgSOxArtAleDp0pj+vMsgdloksjzAebU1Zq/W+QxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME3Xw/OV9Z+KNjrwzaHcMLZkNZPb8cybq+xZd6m1Wc0=;
 b=RPmSjAAHHiu7aUmTUnK/snzYm2GUpp6i7/neeZ4abImWKhR1wMTlTInDUN2H3CWOEhX13xz/7qaLojRMOmYIWyj8Uo1Vi+L/PuqfNp1UPbuVDKCzFzgS4tFzYIqaDCq6kTNtZ8Uc7mPrLYPwLKfeuHYqb4AIYJ901O4OOZ4s4x8yd0Duyiyoj8OndNZoKaNYO6De0nO54hFyx7L7UxzkPwcfBtpaxlDje+K80PD6nAVIEfy6NQ+xPiZCPLC+vw7YNFUt1NyMSgoS7Da2L3ZomX9itkV6krXHcYqOC5PVseY3ZK3168YMq4jHd3FyjNPl+fQ9UVq/VDkBv7NPzBaw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME3Xw/OV9Z+KNjrwzaHcMLZkNZPb8cybq+xZd6m1Wc0=;
 b=DvtYCD84gKz9Nc7hjv007pnwp1KMWnw4NLCUW/kljTwUTNqOhv+QoxloYPXj6mKRYFJXS1WwcK98KnvLtmErwEyYseLV0cfIKUykcb5ROP13RGQ3T65QPKVjJrknDYdRQyNn5bTwUxSiRtd/aRKUUzLfFADDfzTkFUehHXPNizs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 2/8] firmware: imx: scu: increase RPC timeout
Date:   Mon,  7 Aug 2023 20:14:26 +0800
Message-Id: <20230807121432.3970610-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: fc914c81-188c-47eb-06a9-08db973f39b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+RndDULDOT5dhTIATqE4ogvFH7FnAlXXxR042HeNuDGcUBBdQiyFJa7NJ2Ev0QCz7FfKGl9haiBwTHF9jEbSA+V2CfWlXKT4RrahHwMkzKANk7akR7tIhZw1IViRaCwKjiH+gbwsBebFzOD0BxWb/q1os04aUM7zq5NUwple5VZJLnzYzG0+1BZFrQE0WrtsfuYVIso25Ogib8pnGrVv+iffP/8hMXhF3/GUScccmMhOTZsuGxTbAuxcW3xITUKdhn7JPN0kRwDQ1K/CFGTi4gX+fuKxRWTRwmsm6DKeg0SCbFrRyUzCfb826uTw+nNOIMAvxGVlkBCcUnbv338/RldFIhhRejDBjOWmOzYmHmVnZtn/DA9c20gfTXtqq43KtfWduyAiVCDVVz9HPvm51mZv2JoAmrJ8pEf0Ex+Z1GNjgUdTJPq8yeBnim4HRJTFqgStHZcEXIdU3utv5OQBU9VfntMAaXMyjb6utfwRbZdpaPdmGkiUbN8wmP2N5WFldVp2TgoGolFfa5fyo0SYxqJ0ojN2iCBVmFp5rBKwqW6oU7Y+ELe8k0HaS5ZgAl60+cXl3bQxJuuJjX1kij0sCvEneUQ3nsmZcDWm/cHqW+Aw5ctcY6owjRzsw92d/XX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(86362001)(4744005)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iqml2CLz5GYg3tlFRpcER6TiCNwTrk8cqMXh9YddR/Hxq6nR74YCEPBr5hrm?=
 =?us-ascii?Q?rYl+k9rJ5o00cSs/ks6NJPGAbczZ5xtOPb96CMX7zOvpcJ4SX7jvw+heAedG?=
 =?us-ascii?Q?8yYqW+xXMrvUcNtsywuRf+ybWGd4GlrFkPOP6UzPVP9KEpbtlVPGs39QLNqU?=
 =?us-ascii?Q?YS6lUEGRjD+sfAXSDV4RhjlVxyDBiIdLO1lHqpZ0kWZfuwZ6msya/nwxDaeI?=
 =?us-ascii?Q?ZQdIyp1wtURMgHF80xG1DDTeEApGZkEv4rUK7GZWvPmvnk3HiiPl3+h3FKyA?=
 =?us-ascii?Q?17DbEjumdz3ngaNfmR8a1tjCBIVe52rNbwYltQKHMMehCKl91oNOV7SR1+Cr?=
 =?us-ascii?Q?6EICRnpafSXj+oMB8zYJgf4E9Wsgmu6zhHazzXVYifgQVtHUjM380++XHIhk?=
 =?us-ascii?Q?hixxrIwcAPY76x2uiStTvJnaAvw3d6SwA+twPVcfxvoLahvAW9qoqPag8PWn?=
 =?us-ascii?Q?YVQqwlN6HQa5DBt1da50cj0Hul65XNFFks97LdsAv4MRGznS2pRD0CnQEQUb?=
 =?us-ascii?Q?0eXyqOz3mR6Dv8pX8CP95TKdr1WlWkrSZkEL9GGzgaokWIhgkaWfC+clsJPN?=
 =?us-ascii?Q?Bl/BUz/40klAgyiFAFDkk0S68zQho0tZ/idTP5pen/k4ofCcHfGrs8ZwU1+c?=
 =?us-ascii?Q?SlLP6nQ1fuWDFL0K8cQyp35nRnUZkdaOl0MU2pDZwNVXDfI/qtTUC+Hj1Xyh?=
 =?us-ascii?Q?QEvSKKVD0qR/uVdTJ2zIUfXNvvKk5fQp/JzjTTxhov61MalNZrXoBpLDw7An?=
 =?us-ascii?Q?JPYOStUgtmllGC53/V+bt7pBWTaV6a3p0ZIN8mzGvNrqkAP/S7erUx+XXlMe?=
 =?us-ascii?Q?VeXe6uzc+30jxnW2G9BNgotH0sXUm7iDO7lMgDdse+RDgyCSU83iIpXz2nDR?=
 =?us-ascii?Q?9aYjspWA1RtNDnK1JRByxi9H/7/QsuUJeqxTzOqksg0zVgrzhpv6MaCmtsQ8?=
 =?us-ascii?Q?U6womXYfXFPvasdorJkSjrjBN+8z+KQ4H7PoQXjH+b+ZF+ueWbJ3d1WvEvNo?=
 =?us-ascii?Q?l9l62/hIPIbPPdJTjGhCvAWP3ww8buyCF5pITOoTbAmIT9CHiVQ+MMB46Gyu?=
 =?us-ascii?Q?50Nl9OeAxwbADFCbFIYFRV0fR0nsQ1s0up1x2LP8g+MsLC84TaM8lmdA4E6c?=
 =?us-ascii?Q?qCPT2WTrKIBvPB42qkkO+gErumaoxE1PCibnXvTrlfp2f88JmI2o5lKpA5s7?=
 =?us-ascii?Q?jjggiRPY8dxFWL5P7h6UTMtFM89wks0Y8pDYjs5sOjvveyNKpcRnS9FwUXxl?=
 =?us-ascii?Q?cBGkmKDeRhNgC6W17YrocHYrMZO+/MmtzqRd1s1V9vHBKkn88+OI7wXsWfF8?=
 =?us-ascii?Q?D1jT8fkxO3oQ0dR8hqHjqJzRlOQ6Ni2JrqwItatyI0DDXxgS78iPzFtTcF8y?=
 =?us-ascii?Q?KLU1c+PwT+kiU4xCi9LgcHcS3Du2pbKipDmJzC73ZFskh6ONYIYx8QKsZbqE?=
 =?us-ascii?Q?/+nWLlSrFyTI20Fgtro2rgafHH3mpQXp7e6lIDEBiIL6iLkIY/yJgJeybCNt?=
 =?us-ascii?Q?jd/gTg98AdrB/67LgEkaDrjhIfvEl3O0pg4gWKA/7em/e39Z0EJwLtgwjdFq?=
 =?us-ascii?Q?hM7sUdcLO1obTMiWoKiTUe4b2VzGCF5iYPketUzG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc914c81-188c-47eb-06a9-08db973f39b1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:01.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exCCyrro3UsXEmCZnaob/DPHX7BR+86vl6/yFqouqGssOo7mOVxTQ8wkmO02XzRzwUkxJguL1oEZrzrbEUnz8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

When system loading is high, we can meet some command timeout
issue occasionally, so increase the timeout to a safe value.

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

