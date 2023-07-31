Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB4476914C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjGaJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGaJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:43 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5F10B;
        Mon, 31 Jul 2023 02:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3FXyPTMnZd4r6tephN5hzJawASy9R3OJS9Dt/l82CaJpUdXJ/roWb5++UPRnkjKj3OESU2QqFTQGCxiMOlbfeJfGPx9xee/qajUydswx12nfZkm2vHLhMMblZ0CkQr2nMjP984la3hkXn1NNbpmPgLZ70ih+Cmv8Etju6KRuqDTO+zuRA+11xg7Hz1vOWa6mDnqcZFV2szDSoRcdEYwSNT6IUZJ5VFT67jZdWYlHM0+D6YqbcQ3LbrxbeUtaK4TW9KTcCHMihvIe4k0nIKHMHdF3zo3eK7scEgXA3bZUaCY/teAVXICEgSShHf3d8kU8LMYSPMrH1iWi2kZhubEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahR6OORX0bR/TMg6s9kmEstfA2BpgSYLSYaKkASJfx0=;
 b=nkaey90eG4H1VFKi47EeZUcZJAz7K4IdbIBIlgHBEd6NhR9/pl5NPTiUhQSurryVw2QckD0C7SHXQaI7U6DXeynPlsYpQ33/EbPbyPuq34jMWAfqK+duJzrp9C23HoXrqJE4WaF6AS7dww747bMaEcwbKBJF37ywPvIN/kc6SB+HMxQcApZhvbEcHnHbbW18/lKwg2isZyrmTgd4lhQknKQX8v3eWjif2/txRmQl637gEG6j0b03cyMYd9fkwMDaf4Za+cSonRSIg6kqKdbce1MWXa1iXFsQgPpoVq16onCutr+l/Dnbc0tKznb4UnrHMJFnKEa+sslYG1F9gh6fSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahR6OORX0bR/TMg6s9kmEstfA2BpgSYLSYaKkASJfx0=;
 b=M3atg5SumxDcyhzOtimQBlucr0JBr1eIPMPKT3iUmJi6A4nybYAAAU0PtEgmYPP5UJWHyN8MW3XkRrZP9yO4/zn5NLIBh2yVUUG+ep3EogWMQJfAUPwiGC5pfRcAZUMetj2JlK/CqVE5z9fZ9JgDg4O1SRxi6CW1KQFR/wFWFTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:39 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:39 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 02/11] net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
Date:   Mon, 31 Jul 2023 12:16:10 +0300
Message-Id: <20230731091619.77961-3-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: f153ba9f-3f1d-450f-bf8c-08db91a6d8c9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AueV8Ci/091W1uC/yw2o9DWEzli05TXto2G/VYwmjrKDXPq79L9teXVQWEuWMXdwhNm/72ZZg8PjSU2+PTQVsxNuFTJ6tEI+mTDSnlsAjoDlCaF8I9whkKpOvg/kovAH5vqC2+GN0Ob5veLycwKAQGuYMVce6/tQzj4X2f3l/W5VaFp53wxU9iyD6EeyYQg1xJBnHOmwsULGK013/t6w4c7cg8g/MHR703JcCDGT5LAPmh2drNPRsdYuLXd+n11nMb5A2C2CCTEm4aHXZhEEToC4PI65S6SCBQQ2pM4lx3gfCgTSZNGg2647ZdItOuA9Cyw7yvJPXiWDHC8kMvWltoGcE9blqi63REtzoKbQ3OQuQ0joclo5HtUAuz88DoZ8K3r4+lh1y0FwQARps/zCw40NRgMc0cstKi7Ya32kjHwBbl4HjtpjRgu+48229+UihjVYWQtXJHWX4Pb3NGouxEyMMXery4rEL+CEEI+1cOSyGaI7T0zk6yandmtayYTWGJg20umHKRvIiaBGHQ6aBhkNvWyHayfRbOPVqftohJX7nS1XMXnr1biG5CdzF/Ay9EZHulqY2Pvnvu6x6X6nOWOJ9HnHFQKSOfQze7BziRJiRECOQcVldJvHFKT/kKx4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(66946007)(66556008)(66476007)(2906002)(4326008)(7416002)(316002)(41300700001)(2616005)(6486002)(478600001)(6666004)(52116002)(8936002)(8676002)(1076003)(26005)(6506007)(186003)(83380400001)(38100700002)(38350700002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RlEXlzLK/hUqFe3v5u6ha9YxQpDG4g9swmXxJzZIz9TedbE/fZDsN4DMqSoF?=
 =?us-ascii?Q?+lHCV5oHG6qJqxxx4tV7G5ZtOt1Kt//Hu6FWJZRgXAB7BKCf2t64PGWTGzDf?=
 =?us-ascii?Q?xHekMZY0wT1cBfksrxpwBmN8Zf7xwEatY7gcFaMeXNzoWCS3t4ljntPJQuaj?=
 =?us-ascii?Q?9glKRfpGI36Y4a5jhEtjTXJV8K8vVodKoV/2QAKz2GmBo6rsBLNx6+U6OY9Q?=
 =?us-ascii?Q?JVAiMbqa4gDD/NLOb1Tkpm5/FruJhCbMyc77A/m8kRcgJb5NChjLepUGmMV1?=
 =?us-ascii?Q?/TyGgpJtju24LiDlicPLIxq3K/rwrA0VQiyGEOlxLZf5jNte8l4eGyQwL2qa?=
 =?us-ascii?Q?Nsr1CpYhvqCIacrbo14/mLIAqqJI7uojKd2t2HeZ7q9gitfPQdeVCoZvFLZV?=
 =?us-ascii?Q?Z6cMdPRFuAHIUxiy8qx7yzEAoq6TfSp7swSda/jPlCd9CeP7TMo/1NhKiOSV?=
 =?us-ascii?Q?NkVFhBO2wAbQp1voHqOlcJOMMHED9gwrmELS5noE6wVslOfHun/gn0DFyJ9K?=
 =?us-ascii?Q?y8EIoxWxilfuGB6jVuaaWvaTYXH/q1WJb0+wnTlcvq9MBGkLn60sgolWegE+?=
 =?us-ascii?Q?PWyzFcXJMAPKnP6n1rrWgabU5rMRcoipP/kJ+VQHkr5wTbfTTtkQiVSItStE?=
 =?us-ascii?Q?IY5C7JgZ5TBeRXkuGzaKZVsPLshM5Q3skWhLYRPdKsKhsejEHPDmPEmX3Tvi?=
 =?us-ascii?Q?PuqbIaEaZ/+c3N2P0jn36oEb0+ElmzmMm+NzHgudPV3EdJbeVakmzeLUlhhY?=
 =?us-ascii?Q?0SPKvHv4YYD0YN/jso4eN2FxF8ktGO8qyQKcsvBaOmkmlNP8pb36wOCJhK4s?=
 =?us-ascii?Q?fU1naGnufFn1k2Bur1HEryCDNQT7C/Ud/envhoWXezS9lGnC7WqUF9OW5xWJ?=
 =?us-ascii?Q?eETDkbHf55nfOufdUiwQqNJ6VyjARCzyAn2FoLDeAgzwg/IU4TPtuG7c9iGd?=
 =?us-ascii?Q?c+75IMzTHX+qEaNWmgAfB88RZCvkimfaMVG5p4Yn5yjcDjl33AZI3DWdtJdX?=
 =?us-ascii?Q?eHYYIBYKWH7/4ylQWPiUIJ3ptw/QUA96CaR/FLgZJm8vGiqmRqOgdUtyKS7c?=
 =?us-ascii?Q?+27ktEK/RdlTp9571+sYC7iWLPY+CRH2l50RnDgm14eaeWr6HyJouifsGvpz?=
 =?us-ascii?Q?ETxjrhzCdVZ12bIJ52z9FC4+JBrj3A1vRWPmQECGauxxRy1I7d4RvaMPD4Dj?=
 =?us-ascii?Q?fQb+fOjm3HUmnp5hLBAWdbygxDGGFESiuTVgxMIiKPppOK5c3PZmQNxqx/Rn?=
 =?us-ascii?Q?Fab5kA4eUsz7BMutcWnNOmTLiWyKzzJDM772Voq3A2Xf6nvmQhjtcKeHGPef?=
 =?us-ascii?Q?93OWZdxezBTo6pG4yXdFMPBPSK323/+c3D9V2KeYL0fEKyAFx0Nlp+M9ogVr?=
 =?us-ascii?Q?oOwbmmFkPxTifA2Y6oOwvo31GHrI2R2agRLqfG5p9ptK5Woeoxki5EQbUPsk?=
 =?us-ascii?Q?5a5jEskpjqtBnIgeLanUJde+h0UGZ15XyOBIc9iwLI3JOa5UPL/Koahy3bzO?=
 =?us-ascii?Q?egXBL0DEUEXuquwbCxvjJNm3R6ThllZDxmzn59fwSL4/2e2g8aZboxmcKCQZ?=
 =?us-ascii?Q?+SH5ZDr+7kyTPLiBiFIIJyP3XmwKNeBdQyj6IXKdg8/71R1IjoazCgxlcyzx?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f153ba9f-3f1d-450f-bf8c-08db91a6d8c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:39.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9AMMwcZpbNnWwfRePQW5+feFyfc0TKS+hWkJQViOwRc3PvkO2XHAuheOs3zwY2OtTCT47AxX/DTCkoNon901u1D+c1WpwBH05x5PGisblU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RX BIST frame counters from the PHY statistics.
In production mode, these counters are always read as 0.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 41b8af0547e4..f1f15a1b6cfc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -81,9 +81,6 @@
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
-#define VEND1_R_GOOD_FRAME_CNT		0xA950
-#define VEND1_R_BAD_FRAME_CNT		0xA952
-#define VEND1_R_RXER_FRAME_CNT		0xA954
 #define VEND1_RX_PREAMBLE_COUNT		0xAFCE
 #define VEND1_TX_PREAMBLE_COUNT		0xAFCF
 #define VEND1_RX_IPG_LENGTH		0xAFD0
@@ -809,12 +806,6 @@ static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
 		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
 	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
 		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "r_good_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_GOOD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_bad_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_BAD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_rxer_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_RXER_FRAME_CNT, 0, GENMASK(15, 0) },
 	{ "rx_preamble_count", MDIO_MMD_VEND1,
 		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
 	{ "tx_preamble_count", MDIO_MMD_VEND1,
-- 
2.34.1

