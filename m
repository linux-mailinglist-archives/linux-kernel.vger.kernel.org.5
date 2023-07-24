Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0ED75E974
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGXCD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjGXCDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:03:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C53C20
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 18:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKnKqa4PZr176b0QB1kt4O94+n2uKKa5pinS+c1JUxYX9p5WdZnIRj8aJZIgtC9gJDTR/aAmdL8odkIFtccMlFw+sYMC67R2GKcOpnUBBy+k/byLxZHqwNMfk+/qDi7bP6YXF5koBJdprAuQFb4drlgRF4XXD1qAeDAly13S7OLP+c6T3yBFdVx3WT/6jIw7jTNWB4863wZEyZGSEP/4YrjWZUrX2YlE7OqxeIxC6/phqBA8VfFG4Ox/vqceKecvcALRRvsLkE/J2zedsqkMznLqeb1bRIUm37DBL3lkbkAAEApxe+It+xhFuw12NggT6tT1oo/pc8hEnjkq+HOYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=QhsnK8Zf1joEBnt6eUHGvZ/I/me6SUOLL+OTklo4uZMbTX9GdInCcZ7/E/Xhp1ClWXsDfsEg4CI+Iap+KQgM2+HV9eJACdT6dgwqWLC2cZ6/6s7pnpeFswqVDPLKf7hRMypL3IBHdaBMaklNX4SW6XwdGEL+PZAwZPqOd48fXoB9jhlePnH8hk81h+R/Gt6YMeUHnD7z0ZxwN9TSgQThaCSupxvDRFtHt9zMcroFPJ/8dJOirvV8I+2URQ1f195w72rPtMNUsKwe82+KHdFlzjQfWngyIGhP45WPOmwfcPXRF+DeK2cUwpQ+tWJqllngNEifgEssJ0pSRPd8qN/BKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=WP/7a21sEZtjitEj9vRmv3rg7JOHd9zyDD92r9J7AHbNsNqN2k8fyYhXKVPeQC6IV+ssZkhglBPZnow1RRhYv6roClrAmuGh4Q1NJpMrAwKpYUTOoKy00gL7ZxJpEidrK+xFcVutCcjMS4B7JgHm7nBTd/3VrxsFQdBRUbmJQ5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/8] firmware: imx: scu: drop return value check
Date:   Mon, 24 Jul 2023 09:47:04 +0800
Message-Id: <20230724014711.2048958-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13417320-f716-485d-75c6-08db8be742de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLF490Vr5PHIQY0pGOOwu53SKp8ixvj3arZFagK/lmEXIwcXr29mf33/xGjFti4AmjBM9IgvUnrNEmhSNXGzSbEtaeSc4+hXsNY7luv8MfR7dQIGF6vvvaBkrG7JoJPV8+e0/cu5zOq30eczS8xScVRk91ONQaLBaLv9pS4fWe+LqWkZnJ9jSpY2hePN7PQ6R7ddCwriz5C2hM1RiyDBuaHtfoRSXcNrwhQalT8DR3gD7Tn44VLDGqu+lKSh5cS4CHoOt3f+lGA1RRoCQqRmGVgprOduUwuh+t50iE5bUwDgu7UeAiDqreKNNFIFRuN5ciMWmonRXXKVHHtB2kkKk2YAzTPiDfDdAvO9UTPxEMo5H21pN9aDcNJRNrEvaOFCs/tF0RKtcysKuI5F211RkYfp1edVbSfWdouel9WoS2j1hzRm+B0WRmS8+8wsBLLqqMhtQ5N0dlsLRddldmQz/eyP9iut7HM2uLDzG90asOLqa7YUUge8jDT2I4h0oKeh22rz4vjB8wVdnsuOjfgdea4ZcUNaIWaTfhaxewhbKYa2w+J1t9olskz7EeEKKLL45Qqleo+cznypptSRtzXcznNOBcAgU/zfmogTsoMjE6uWiIA9vPmSBgIil7NToOky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LOygtmRW/rc/KmDDX9LBSEbLi7r2moBqLjbsHzA9Hy/lNNoUStfHxzBYcn2q?=
 =?us-ascii?Q?quwOI7T/ZXgBxAQSMOldcrKfbXfLuIRRXxr2PtH01eB2QZtu1LZgDziGHuuz?=
 =?us-ascii?Q?uIVVuj22dDrd0xNuhXe88UJ7HLwery8UOP2yjoKKaRqREiLBoT61mRRSZ+jA?=
 =?us-ascii?Q?S5Wy0RFpOfD8SvrafboosEztwY8zUznMkshlE4j7R2qOCiMureYSvWcQXqzJ?=
 =?us-ascii?Q?i3As1aX0B7zQ7drZvuFXYOHvH30KqrSshQjeFdLSR+DZFJjWZFaooLhsRj2N?=
 =?us-ascii?Q?ePI9vZPoq7OR7G4Iv8eVDrghhtZ1kpZCNFuuINDtQvbCzeHn9uldGTsjW50X?=
 =?us-ascii?Q?k0Ri/jbGoq+UqoCBGVIhYVLuOZ+AaVrvNaVb+/7eWgmyq1dd0MOmV5DCB5AB?=
 =?us-ascii?Q?wzviOq94n5jI1Tq3CMYnLQcYIavcbkby9DczKMKgGX2YHws1fP5FyT/x1zi4?=
 =?us-ascii?Q?0ujO2jg/1u3r+w4B00MVhHMVrs/Nbs/rYBcwAy3H53uALMG0ZPkxh56ZK18g?=
 =?us-ascii?Q?L59hiUi8KTEeDSIHvPGVtsWzvTg5rvvT8eFBHp1p9OD9i59mb16wsESrjhCs?=
 =?us-ascii?Q?c1Xw3zEK/2nPQpteIkOuLt+21eP1W9+F0Y6AjcUsNacovc9btu5xvnB5JB8i?=
 =?us-ascii?Q?qH4D4T3gsph3DFFRrsXiZkhX1NTL4nE2f7xerX1AdBV5WxD2xRi9IjzN7NeG?=
 =?us-ascii?Q?w7H9znOXZ2SCCROh2mJxPeKTbybW1SbRUbpiZtJFf3Q/7Vv7LzFUfKc2+UiX?=
 =?us-ascii?Q?w0zdy3pgBi9U8goqX1qJWcBvVRg13ACD7Kqr7H0LrZWKQ6BHGeo0euIES7+K?=
 =?us-ascii?Q?yHWGn1V9BoQIsiE3H5iTM1AC/U4YEXBans6GmEij79F8+G1yBxp9k0F2LEEQ?=
 =?us-ascii?Q?q1KVRjHm1CEPzryl2qzqD6UIE8R/z8X8I98ZtLK6KLCDvYC6wGgdLhFgv7lG?=
 =?us-ascii?Q?qhoh8TAMRWxSvlCnzM/WZAsDGRgZWKRYwN96WGQ1E/W76Dz2StTMIu3cvM3+?=
 =?us-ascii?Q?O1DUFJsam7EJRevES4Fyza/zbJiDuEziCCsPF15h4yDra+l3a+QCODyGV92Y?=
 =?us-ascii?Q?56TdCHm2RLgiCni6qrggmEYd8nAGogFIXyOjE5kKkpm3P3AOmZxOm7f5rFYi?=
 =?us-ascii?Q?04tyX0c4c5htdqvGJVPWWzCclQMKxWIGZR3Yv7qBebC0iLPqnWan08aym8kO?=
 =?us-ascii?Q?iEMBt++M1gayXIS1PyhmstBZWGnal68mWM4e4f4IKqmVq5BVAyHiiYu1NLmc?=
 =?us-ascii?Q?P8ALyAfhB+ripVl8tWYmAlDhtt4rb/ZcoLRCI+9+dvUhqVUaEV2MvCxuBahu?=
 =?us-ascii?Q?m8WQQ+v0oVyDcl2CYvuX1Vit2H62LhtMxpbL/6Rhpz3J/N0LFEwq0Gv1Rerv?=
 =?us-ascii?Q?MM4m8qim1B+VX34QxGoVgoDMPtiWI3N7x/0frbhfP6d5uFvfLcODGeybN5Ky?=
 =?us-ascii?Q?pDaZz6m+hrR1575DYb2dFfZeoeYWGpz6fF8LIsnAM0h8W44WIQZXUUCwMMjH?=
 =?us-ascii?Q?LQdHpSBeh64PRAYnZPq5RyeK6nwVsYNWM3f8wWX4o59nWXS7FwL22WH6cS7Q?=
 =?us-ascii?Q?c7JJL/3VdXhaD7S7efIS9VZEyOw65RCgbnXroTuo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13417320-f716-485d-75c6-08db8be742de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:38.1593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgvhZIGFHSytICsufZGymQQn8n4mwr0rjjXoaypnE4EmjjtHveHI7XfvaWfFC3SMItA7PRUhBr5cokGuXvqaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
and the imx-scu always return 0. So drop the return value check.

BTW, also initialize msg to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..ef9103987e76 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
 
 static int imx_scu_soc_uid(u64 *soc_uid)
 {
-	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
 	hdr->svc = IMX_SC_RPC_SVC_MISC;
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
+	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
 
 	*soc_uid = msg.uid_high;
 	*soc_uid <<= 32;
-- 
2.37.1

