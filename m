Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAC75AAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjGTJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGTJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B719B270F;
        Thu, 20 Jul 2023 02:12:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKiNUSoc0xrcInj3h0XcxeVd9cTE1B6fW1TUinvImYdNvt3jf+/1VqG6pgagI3VVnZTMp1ROX4BktoJ4+aeaOSXV7hHn8mbC5l/ET2yX6Je7rdfH5xIlP4lUKBT6d/76iJBfk7x9hpIUkm56MGkCf5F5U1rWhX1itbQLkeHl83YdiOaBbtlKZnfsOGIotPCFkGUCfS9Ylakx7VY12qTK2LMvNWy0A5g2ezUAEtlPm56PbzMdZ3JaTSZwzEiZwIEV0UGfJ/SGYp41AVVqVDBma5VSIQ/Y45aUBf88OV7lYyAhhmvt3TuV7P9w0uQShj10yqpzlLK0hZNIZrhWcxH2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORzNhWeeNhvkI0mNLRqcgjIfNcSqGQffHhzG9ffl5Ik=;
 b=AP7LxgwDKfCThmkRDCirYQZxuDiDDtwEHza/2BQsJ+cnk9FRnrGtiWhlntDx2NJoceT6NtwUmfaPxi6bRaz06xweI+g10Rl7ojaeaNdFmOEuj7xfzfnS4gvWaumi6bh8M4xMBrVaLkaTYlAfXlALfqzOzgt1Yt0b6V63D5mj438a0mgm1id/hWQfpmfJ5arxnt5BZpU9BiLzCESwEeEYrCfQLexelXx7gx6A6VvnNOAZpZNyUy61yku1GvK6XZEGXy37+gvfiQH1HZHFJsjRg264tHzFnE8E2jswlpAOBABOaLRpa/d0dhEvpY8XKVWQNLC9rrFrtzQcteN+zsBBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORzNhWeeNhvkI0mNLRqcgjIfNcSqGQffHhzG9ffl5Ik=;
 b=GTHGMReHkHtsYImOVM1AP2KFXvgm7USWd2kYYP+ox/RDb1d/Zi3K4GOvGE82QyD+5g8PA38NdFp7+FQkQxtlEtHsA9ML7gMQDfht0iUar2sYSPmcdWg3iqCmSRVcFjyGZFuxLm4sdAKOhe/sChhogCM7jdTthlKP5c8MpG88DXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/8] genpd: imx: scu-pd: Suppress bind attrs
Date:   Thu, 20 Jul 2023 17:16:58 +0800
Message-Id: <20230720091701.517197-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720091701.517197-1-peng.fan@oss.nxp.com>
References: <20230720091701.517197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f8dc64-0764-4b16-4cf1-08db89017407
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPQ6kgH1YEAdWJaoMTWQifCbrjAGZvQyRrmUPnQcwwOLYzuUe2r+EaHwPoBiifNG/HzBcOnCO0Xc69hPq7JUvJh+lYzPlhm6QB9/BNbtK9TEl+SV488jWXT2+M/GzVTJrkMCPhHL5DLX9Ldg5TV/F0vFm6x4gUcJsh4wd+WZwJo7F2qiTndyKxxODzFZ593o/Ft9CiAZz/LA+hD3/ubPNojn+pIjZz9ypX5Y8oxmzkwr89WU17mC2JJ64bpPwgJqk90sHsLt2kO6NiGfGC4fGM+IlZx+mVqPTxnaoXDPCykxeYqC9SKwCHvkS1+h6nMgm1dWp7L8hhd3PiPGIdi3eyN6b7vAI5xHLZ09jpZ748kcHdhr8+JyU1yyHyZzOtAy7XuNrJrtO1OkOaaogJ64wrVF3AVuWMT+oaad2Js1DfFjmg1sd60U+PjVOq0EDpCcn/kZgtNBAo3SB/E3YB5dJvPQH33ZgwplUuO9O4L1Ole06QYTsXVEWBJZhvrXlKk6FXQqmASpfZ+aTTIK4rNnJ7v4vwXHC7C+PZdU2ZVB781tEipgJHz30D2OZ7Dtg41I/NZ/fBqVbbUeNkKDTFg9NsVMTBxRYfCE91y5uRXc5Tbg8yBIqAyJiPWga66oq11j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(4744005)(2616005)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LC9ZpAyhf1GJrUgOHTeVTuYwWVn7sKWIrOiqqFqCoF4FyrJULafs0Ss9TSFQ?=
 =?us-ascii?Q?Zm8oajcfMl6yBuDXdFUtXTDrLdz8S6d+aZO4NV6GsHkeZForynw5dXRWzBis?=
 =?us-ascii?Q?t+MdYwZ3U7N9BpkMcn5x2T0tFXSkBTz4aFKYoUsMx/N1+kh0L3AnfBPGqs4S?=
 =?us-ascii?Q?c4YB2jF2uwct+fPo/mIjdcbiJAO5egWPC5q11fMnlApCUPHDqjyM1q/rqq5w?=
 =?us-ascii?Q?+W3VoHpSCK/lKp1YTfvjRSVVhb8RKVdu0I1MKTbmohkTHdDDhpcQkCF9/NGP?=
 =?us-ascii?Q?K3N8A7nXW6zuyeNKnW2Bk96FyavzhoQKkbH+TpICUgjpz34Jz5pbXhEUA5xj?=
 =?us-ascii?Q?8LcflMm8fmdmbUKIXu6wVArhOSaSTt1Cm56NkPmtzAmJRdP/zSAC7E5PSKSd?=
 =?us-ascii?Q?6y09CGWTdBFVzVJXJiiX2pYrCKaKR6CmPuAM7KHi/TB0h180a3d8LnTZMxGE?=
 =?us-ascii?Q?WzjeVUP79rXbl7Z38Dds4pvCJB2iThJs3gUnxw8jNUeAy4M4sow8jFcsILiC?=
 =?us-ascii?Q?haYMwkvIL9Kh5eQ0oYPN/64ADsG7TaJuyl2YzBDEPxhJxyPFvljvkVGq/yW7?=
 =?us-ascii?Q?VZDX7K/uMVP4lLOSdWl6579uZKW40Aahl/r1LNeMOoMqQdH+EE3rgovCZQ2K?=
 =?us-ascii?Q?m+zBrRPlc+NF8putt10YqdNTQAVCfXUbCAvA1/qTSgTqhxPeVnEdWSV+/7FW?=
 =?us-ascii?Q?MRFf/bL6ZXzM7+liKhevOggEI0+rdQ79oZJyvUI1zbh6z2/JMtnebbCGGlg2?=
 =?us-ascii?Q?/2qUfZPEoi6coR4+mBPGqD1zE46ptEjiL9bhx5Rnc5XlkQqVJkdYxfG0Pxm8?=
 =?us-ascii?Q?iOsq+SsGCXt4oZXllaDjX1ZoB7R71UE1aRc1PsGZ8fECTweEm6PnpERc4wNG?=
 =?us-ascii?Q?KttP0ige+rSJKsW2JnRTpWyrXz80Id+eT6AvreB67cBxKfCdlquHKcfpe2jN?=
 =?us-ascii?Q?lSHXdcgE5XCACUIX477o16A5TxMDXDlLJphiczUlefDPFzv1WbdfGWDF80an?=
 =?us-ascii?Q?ATKI2auXG/zuNQ26D3+vFI7sDau88ejb6HgK4SM6jYOfvQM7BS3113bwWX6D?=
 =?us-ascii?Q?TV1DcctlfZ+rFKcyYZIsUvddBD3UbaaDlZlvcYRoufbe0C2FFBjSs8Q3xXso?=
 =?us-ascii?Q?Uqc5wYA7Y2nY28BDcUuS23RytcXQiiuke4jsoEYHMQjxcTB0Du1MDsNHE6fm?=
 =?us-ascii?Q?Vme/anRdlISf3FM2CAB5Uah+WAKv0KYQJTsWN5d3IIBEYY1ledtdUn8PV8yw?=
 =?us-ascii?Q?UMF6ZE6zHgw+IYsXZihXOrUvvdKSoaMv89H/rkzwMNs1/sUXiTtx+M9Kauzy?=
 =?us-ascii?Q?31vrpcuEjwiol2qilwDPiCq1iBwo6kv54ny9S2Qj70lHhj7TE+7ajA+lovCF?=
 =?us-ascii?Q?oTZDQknUOH97EEtui7t3HGCHVq6ywQl+49lDByqk28v5eG+erllS0iUWmkf6?=
 =?us-ascii?Q?9jBHE6NsebW9W8rsHhBrXwNp3x3tpzWF+1H68p4/I6S6vUqmbTEfkKq4wJmM?=
 =?us-ascii?Q?sGnPdi9Y3o3AWPTP/4VXD8cL1DJZKcGB6zMvG67EI6Hi4aDji/TotH73YuZx?=
 =?us-ascii?Q?nCVjfl9dJKjKTC60BAkAq2Rtp8YcOOj4QH5UHQMb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f8dc64-0764-4b16-4cf1-08db89017407
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:34.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN4Z4gCBY5KnxQOfy+JV7ZOmPqp0XiGFcTICamt2bNrnjsz+zEdeot5KpOKWa0fBJPATIoIc1TLVCATeqGTJjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/genpd/imx/scu-pd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 6770be51d234..9f8dac7950fe 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
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

