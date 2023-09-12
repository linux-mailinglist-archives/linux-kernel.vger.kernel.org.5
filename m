Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1079CB54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjILJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjILJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:15:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6C173E;
        Tue, 12 Sep 2023 02:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTRiNrN6Z51O9TvHzQvfEdqS9vjYaD9wABlbEE9u17nM2S2grsBvyhOYQzf59oc5iFiEZMZkR8eV+c8TQemYC3jDoQHw/6+BxGG7+Umy3+vv7HdUwgfQTRAOzwEa8AxSLMA97WAZ/IJDMG6tCud2BIdXPsRD6CY3HsW8utoVwiRVgFJnTwXbD4IPrBERjhsjHv1rl04bS87OuL5tvMuBv2LRCkNzyNZt7q4dKMEPEmvjy3kD3m6MscrLbAUpC0sTcocgnKYn0mWDtmrILISA468w09gZ51W3StKgqBcqjqFC6QLtVMhzS7mBigVZXiv5p95GZe8OS3DHk36jKUxifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfsC8MEzULGQZV38YPuv106MVBSjBgDYtneqmY8F6oI=;
 b=Ix545zN9tnu86akJpoG1Wh5wjIuFF0f3UvA9zVP7gcFvTMULoMftSanWEtHWWPnbS9vR9vqW3Ir6KogJ2aQb1hG3qujhNo3ug0HXxAlmSJ+r7finHbv1pOQWTuutCpbiH1jbSTn8Yrj4eAS9Gw0FgkgfWzer6lL2rKcq9NKu5k68hgb3nC9w8jymnlo3RuXeTOOm2/AR45Q7kQdUj4gfRAwAIcFjiEyOI8NXe8fNIqOehcyZU8LJqsyuRAyVcD7cansEvg0CA9MOnqIzduF4ULNGqNC6V6tcB/d1Hv1l0+iMH7Wfb1FoUfI2CqTrU6Ug1T0MoMM4SKOTDqDijvgKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfsC8MEzULGQZV38YPuv106MVBSjBgDYtneqmY8F6oI=;
 b=Qp2iJaaXsg3V2a5wGUNXCxkuNDFaSPfJ4ub/XSOiMgCaiSyWmq0xC85boe7p+KGM7B4RqU3p4y2vGLxeGDjd6zqkdfCQqkyu9aPxaHY/AkmQtKqfle5HpIiykns4r226qVmroOUmIUoK535EqtfCkP/fK8PdF2nGkzvVDuk7pBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:15:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:15:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:05 +0800
Subject: [PATCH 7/7] clk: imx: imx8qm/qxp: add more resources to whitelist
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-7-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=1280;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=JzVsxHSliJ+8+mkqHOx1O7ZdaS1GjwoTEQ7ca9cgwUw=;
 b=UG2u83ud0nK9LJI55Tjyq+riN+T5//I6DJWtv9WUhoY+WCkXm5TFMwP4nv4HC+PQgnRxJdbIg
 Xpfw02SdpoEAS6NlTssCvnmcfO1IHQYnblR2yRBiJpG6SvLnL/vzIOx
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f92fdc-f6f2-4d2e-2061-08dbb370c127
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ay8VOgCXRIatCIcUqK25Tnaike8kyPsC2/7mxModTDHYSR34DmV5qjsg00KQYQi9ayU51aNPtVM7qkfqS+D6TiKFQwo5MmB52Ic+Mve7GDAUzgmpoNCTe4gUYPfcSiHqTOzWfgJZeKLOYCUct8AefINdlVKv74v5CfmxPt2dp+32o46G84gVnqp3YhhtGmMr+1SbIDR+y3MjzIz4FP5KoYvOMoNJLqAinQi7TnbBlinbywFEfX2vKdcXxWIAcOSljDqVqZNccIYvDvY0HwE3Jx4LSjyikqbF7RdKJCPmo4Q38OY2Pb6o3aS08TvmMRenK+YBQd/YrWdi5Gk/6MgcPW8aI5CIG24tPasVtHVqx2LpFRkRRdjf999xE5+rattNpokqXfEuG4VdP04ktiy9+/QXvlz6TCrzPvFykjYMQMBTmrz7MUHaRcol3vP4NBS7NUimrm6/H+WlrFTxKJdIm9o24uJBHYfzjd3KUa2LEI5RIocxEg2nV9wLzZWYvONPlgtscnfmDTn/VR/QHk7cyAITVUAhWAYORTFPcRGeT6SARiq0N0KcFGWg1/sQObzU1ldQ6cCJ+p+FebtSD849R/nTsZtCofJBy6PeLCmmSPlfo669RslifCrR3LsXyDcgPPB/stQaDzU+18RC4HSP1+ghh7lxgHpRedims4a8pSE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8676002)(8936002)(4326008)(6486002)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(38350700002)(38100700002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNMZU1HSHdhR2hlY3JsSUpuanpjLzl5RWxkNXQzSmZHMDl5bEIvaFM0cEZC?=
 =?utf-8?B?ckFhb3FIekxFYWIyb3piVDV0dUNCTjEzUjhRUXpELy9WSy9BTG5zTnZIMyt4?=
 =?utf-8?B?OTlCU1UxWjh6dkI3ZlJUSTBabjgrcjBvOG05ejhYUzNyaHdqTHB4d0E1cmZu?=
 =?utf-8?B?dzNYOXZibENmdFAwRU4wZSs3cTBRNlI1c1V6MjdYOHljVS91RmhOM1ZSbVhv?=
 =?utf-8?B?NDljSzNYZ1pYYmJxWEZtZGo1bjR2RE5mL1Rtb212L01YZHdoOEJFS2pNSU5M?=
 =?utf-8?B?OG1WQ0s3RklXcThVTUJYK2dweSsrRGh3U1dRaENaVmp0Q01Yc05KaGs4bGR1?=
 =?utf-8?B?VXhzTi82eVJCODNHamV3akY5NFZsNGk4MTNUcTNVdHFEa1dGZVorWTQyZFd1?=
 =?utf-8?B?UzIxaU1ZSjhLS2FEaTZ1K3FhbEtCWkxOdEkvUU9yMjFSK01TbnhqTitIZGNx?=
 =?utf-8?B?RlZGWVUrcXJ4NFZqc3N4TDNCdHNFRnJGanF0T2YyblNLNk14dWRTaHpya1U4?=
 =?utf-8?B?VHFxQUtBQUtISk5JVCszODdObHVCb1ZNTlIwLzhldkEwSjF6VWdRUUlmWGZS?=
 =?utf-8?B?TGhXanNVc0FqOHpkSk90cnI2b0plcEN2ZVNGNGZuWXNnRnZKeWNPZVJZbTN1?=
 =?utf-8?B?MExCblBicElxUEwvNWlFYjZKSWpKTVI0a2hqWU1PRDg4bThxTWc5TFlRWE8y?=
 =?utf-8?B?ZmV3SG41eTVuc3hNbHNMNFdNRUlZM1dXREdDY204dTBxUzUxQjFubEVrekp1?=
 =?utf-8?B?VTl6eWRWNGhkZTNaWjNndFVoTDhtYURiZFF2MFNZdDVlaXA4Tzh0U1BwbkdE?=
 =?utf-8?B?UW9wSjVadXlmV1NndmtiSVVadndpUitIbkgxSER1MWhLQVdzTHZDN01Zcnd6?=
 =?utf-8?B?dk81dmlhVVRrOENNT3h0V2VxWDZrY0NEUXVTYnF4WmYybGpwKzJKSVBlb3JI?=
 =?utf-8?B?cWhJZnJ4blYvTG9pNHB0bk4wQ0N3NUlpQmY1aGdHWWN5Ym9BY0RYZ096NDZ4?=
 =?utf-8?B?VjQ4VnRLRkR4QWVLaFFxK0Z0bnI2SjR1NkI5RG9jOWRVV3dSakhaU0piNDhj?=
 =?utf-8?B?aTI3amZKVzdQcW1UZmJVU3ppTzBRYnVWcUlLM3AvTmFIb0dVYnBRN1lBUlFr?=
 =?utf-8?B?TTJqUTM3eUsrVG05dXN4NFpSK3NyQk50aDdHZkNuTnZidE1ZaFpBTko3ckg3?=
 =?utf-8?B?VUJTK1g4emlXN3ZsYUFhZmZCSFpiSkovVnZObmkraTkveEhvdkxJNVdibDJ6?=
 =?utf-8?B?SUprUFVWWFMzakpEUkJUZlpENll3VTU3VGdFTGRETFBDdUQrQ3lhRmlLcTQw?=
 =?utf-8?B?ZWNFUmxJMElBeWI5YXUrR1o2bXFKQmNxUGJucDZkS2hlNUx5d3AwbnNoQ1cy?=
 =?utf-8?B?SUFaK2JpTTVJRXBnOFU5WmJrY3ZOWXVoZ1d0Si82V1dldE1wa3NrUTNEb1Js?=
 =?utf-8?B?RHlPamNtaFVaZnh4bC80dE1XekVRVGQveWZtTnFtM2VJVHNsSVNPSlJYRVdI?=
 =?utf-8?B?ZEtFcDczeHppSUtVYk9lM3lRSThyblk0RHpTRy94eHo1WEhNTGpEWmdWMU9h?=
 =?utf-8?B?NTZYT1dWQWhuczRhRkhGdG9vRENDTGZ0dWtQV0pZdTdYSkxjU2dJYXlveE5T?=
 =?utf-8?B?c2I2NjF0TnFuekRmckRVOFhpc0ZvRFMvNFd3NzJhUTJ1ZGhUT3dlSjJQVnlG?=
 =?utf-8?B?TGVibmJwWmNzcWwxODlNYUI0Mlg3YnEyTE12aGZJMkw1RjFVaW4vQ1cxOWNq?=
 =?utf-8?B?RVh2cWtmeVNFMlNCcGlJcjJtMHFiZktlcmdmMUJnSUFRMHVaM1pnemw5TTNB?=
 =?utf-8?B?dE1TZHNXNG5uVTBQWlBZQUVmSmZUaXF0YUJISloyYnFpTkxtS0Q2dkdFWGhi?=
 =?utf-8?B?WTVwM0Z2Z0ZBd0FXSWp5cGZKME8rNGo0U2o0ZTdmN3dLTVZVTGZsVEF1QURZ?=
 =?utf-8?B?Mll0empwaFA5RzRvNzFXOHVZMk9xajJ1M1N4OEVvMTFEdUszaHVlckdSNURZ?=
 =?utf-8?B?amdUNWxMT2ZTc2VSbTA2RWhpOXV0VS9iQkg0alNqM2Y1blhRd2JmbVo2ejJ1?=
 =?utf-8?B?ejgveEhzREJ5TDNkREp6T3pUNXVOMEtTUUgzaFlwZEQ1YzJhVHJwanlkYVZl?=
 =?utf-8?Q?NRxzN5XMIBDrf0IFdBsMUJnAN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f92fdc-f6f2-4d2e-2061-08dbb370c127
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:15:06.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pac3VdMg/d/bogmWvHy0nR15mPRlrsa7orizprcQHJedKaJJhNT3MRLk12GzrzHBVDSrr4RjNEnNPEg3YWcx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add CAN_1/2 support for i.MX8QM
Add M4_0, PI_0_PWM_0 and PI_0_I2C_0 for i.MX8QXP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qm-rsrc.c  | 2 ++
 drivers/clk/imx/clk-imx8qxp-rsrc.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8qm-rsrc.c b/drivers/clk/imx/clk-imx8qm-rsrc.c
index 634bc3058657..dadfdd9a4541 100644
--- a/drivers/clk/imx/clk-imx8qm-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qm-rsrc.c
@@ -43,6 +43,8 @@ static const u32 imx8qm_clk_scu_rsrc_table[] = {
 	IMX_SC_R_FTM_0,
 	IMX_SC_R_FTM_1,
 	IMX_SC_R_CAN_0,
+	IMX_SC_R_CAN_1,
+	IMX_SC_R_CAN_2,
 	IMX_SC_R_GPU_0_PID0,
 	IMX_SC_R_GPU_1_PID0,
 	IMX_SC_R_PWM_0,
diff --git a/drivers/clk/imx/clk-imx8qxp-rsrc.c b/drivers/clk/imx/clk-imx8qxp-rsrc.c
index 29868e686921..585c425524a4 100644
--- a/drivers/clk/imx/clk-imx8qxp-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qxp-rsrc.c
@@ -58,10 +58,13 @@ static const u32 imx8qxp_clk_scu_rsrc_table[] = {
 	IMX_SC_R_NAND,
 	IMX_SC_R_LVDS_0,
 	IMX_SC_R_LVDS_1,
+	IMX_SC_R_M4_0_UART,
 	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_ELCDIF_PLL,
 	IMX_SC_R_AUDIO_PLL_0,
 	IMX_SC_R_PI_0,
+	IMX_SC_R_PI_0_PWM_0,
+	IMX_SC_R_PI_0_I2C_0,
 	IMX_SC_R_PI_0_PLL,
 	IMX_SC_R_MIPI_0,
 	IMX_SC_R_MIPI_0_PWM_0,

-- 
2.37.1

