Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C2D7BD4B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjJIHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbjJIHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:53:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66AB8F;
        Mon,  9 Oct 2023 00:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrLv2O6EG9wCDEr/m7i8UZn3svubcF+eSHt64X/kfKWzE5VrGNmor8CVGkNyEbMppsFJVn3xHxo8qdLsTM4z7iFDGyJd75AAOETDlHTcjAJbmbjRkYT8rTL0KoyhJlRWtZWjgqT9S3I+ZxDuxYYgAAVw79Ph6FO6FDDfCxEwrUN1YyjupQig8lQjSwUHD+eqWPx/VgQIk6YsnfqplBNY0qOxRk03GcgF9lMH8kK6WLZTg6J6nseUxcXkcoSep+AQpZyew1PiSPuWKYnM4S7mUfmRN2+KC5cEGK+h4xwhFTI9i+wm0RjAZ8Sg7oiujSuvBylBawRSU8GFUiF2YmgtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eyQH223fUqN2StGXuecgcNrqIdqKFZqrqefxOHkW4Q=;
 b=OJumJUFSotnNFdTqERJ7L8PBk20MijtqP2ov06Sv3Kc7sYW11dVGVQfnqetg3Y4uoLh9oibRQCdSDyzBbeSVqCuCe4sKGFxwJ6mG/FBLYS5zGwIrI2Ro1C7YObbFdgA7uCFfkAA9nz5sGK762OqktTBwcssEZdh49pftAnJ+w8aAI0cmA6K5X9nuSyYf6dUkJH/TGRZeTbujucWTXNlsDCDeomGRPs+YxuwAed8JNiGSHPJetQmgmdFYiG9VqLRpE03AL+9y4YTLUtXwG70OrLF5kZ+L2OITidN9ejXMX8e0YOex+BxOYO4r7NOVbzHSLc73iyJ/X/5Ni2vlvSVzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eyQH223fUqN2StGXuecgcNrqIdqKFZqrqefxOHkW4Q=;
 b=JPi8dkZfMSHBuZ5k2VzfhZZwWaznx2jI71FUsMEk3me1EHOIigscFdAvCbIIK0j67pJ2sm5f/izHVrZs1MNTzStPQacpGm6KVX74osT4bOGJHQjvW8w3QVJCiSqc6f2IgdKl4oi4jDRksBrp4V35Z5nCyKONbJGM1Xd4Aq2QoLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 07:52:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:52:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 09 Oct 2023 15:57:28 +0800
Subject: [PATCH v2 2/3] nvmem: imx: correct nregs for i.MX6UL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-nvmem-imx-v2-2-86cb135c20a4@nxp.com>
References: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
In-Reply-To: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696838258; l=758;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=cBTLcwVAYeCFUreh8z9dOXIrE0cAtT9tCrBbSgDRgB4=;
 b=+7zmxe9Q2gG7Wz7DpYBrUOLsiGdC33S9ZRazYZ8Lnx13us7B9qrW7ysUgXQgbGPMQh5smRpEV
 eqlm9UlwpuUBqOkMt8C5XIZZCUUIYroScj2jWbe3Yx/1bAs+hwfhhcm
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 394103e6-5859-4fc2-d65d-08dbc89cc192
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PN0zNvuXucjXtbAcGA0WVGeDQbEpBOgMwUMDR8ozyxxXiQ4Rteh7deqTvaNvyx0d7HblJwE0U3nA7mlsq/ZRGsH0USwSUCXifhHYQcTm6ACw/AaHFsGi6eKN6xgo4QYhyDLQGnnXaN0y1kPRqJVT453M/d1gQy9dfNF8Ne/e+B2TKmNGHXXFjIUaZP31bZkMpvnj+9GeYqSrP5MgIQqgiDASJdo1L+OPflkCCE4ZdVAJZikK56X2ENPJjGe05/vtnycP4lH1rc0HCWvUy1EcZXM3YznyGoTgIixVk7WFbyRUHlc8Z9EglN2GqwVHQBvItWbaQexI4lU/B9lCqqBYIo3dXrFsF4VzCCkxa58lQZpQKBKae/dCUkOGF0EFDn74B5RIl6bezTX+owZhFMYr4IIbTfIbAcFWYXYNGda1cn/ZwEmP9v/IFxNJDzoElfxWJjRPaQfkFa0jM8NNjJUppKVgMH0cORuTqHTXEQcaDH/YZtnqIWY/P+kCuDG2VVIJ01rZlJOqJTa1Gf8J5ZCaJh2kW0q8awideRiuCAlv+6BwJJt5mqweizwJpgJ5KgmoW9uhaBYW1OvLzOuSFzaHMJjgeoKNZOm4GN6wFZ/Su/nVa2ADCLd19BgPBDCEkzoU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(6506007)(9686003)(6512007)(52116002)(86362001)(38350700002)(38100700002)(36756003)(26005)(83380400001)(5660300002)(4326008)(8676002)(8936002)(6486002)(478600001)(316002)(41300700001)(66556008)(110136005)(66476007)(66946007)(54906003)(6666004)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVtcVJtMTdVZGl0RGh1SWJ4aFB3M3Z6MTdjYlkxYnN3SjBGdVI0bHVRZGZ6?=
 =?utf-8?B?UEc3Ti80M3BicXhqRWNmeDkzLzhTSDBhVDZuYSsrMm5CdW04amkyQzYxWE8y?=
 =?utf-8?B?T0pUVzVkMWo4VjVYK05zNThmQXEvRFl5K3RsNFptNERkMWtiMWtNd1dDTDlo?=
 =?utf-8?B?MEZocmsyZ3kycTVhMk5ZTEFnYXAvZDIwRkhFN3JPSUh0cUo2VUs1ZUMreStK?=
 =?utf-8?B?M3hIeXBIc0Iwbnh6ZnZjWXgvc2c4WCtIQ1JoRFBBVmd6VlJCbU9vcUVzR0RU?=
 =?utf-8?B?MEp3K2tBc1VwQzRMQWxXTnJsODEzNEROaStRL29CL0xsNGZCOGZLUHd3Y1Ru?=
 =?utf-8?B?Q0JPMXNtUjhUa3R5V3BlQk95SjhiaXdSVEp0Y3NpU3YxbmlGcTA2N0M2STYx?=
 =?utf-8?B?aFc2TGpKNVh4UkpiWmN2MDAvWDRsckc0QmFKSFd5NjY2c1ByWUEzRDhOR3RI?=
 =?utf-8?B?VTJ3WkRTa0Yyb2pRa1ErZ3hHbkxRdXpmVG9velNrZEJsTllSWmZVbU14UXgy?=
 =?utf-8?B?TFRDbWJ0Nkk2S2xuVlN4MnBVbS9SZXlRREM3VFZUT2wwMEc1WElqTkxmbW5s?=
 =?utf-8?B?eEU0b0FyTHNEM1cvd2p1NmJveE1RejRSc29UVHFNUXNNQkllKzlpVExCYlR2?=
 =?utf-8?B?cWRVTXZwTjRKSmxHREppQWNVQkF1NlVLUUdoZDJuRlNXeWg2c3FkZ3hER09I?=
 =?utf-8?B?b0lnRWpFZjhhSTFTTDJVQU9XZTAwQWdhSkxPeWNVeUZGMXFVTEY1dUF6WCsv?=
 =?utf-8?B?NHl4VXZtdHM0cVJvSWlXWVczdHlQVjNVbHU0d2pYWTQ0RlN3VHJPVWhCR1hi?=
 =?utf-8?B?cVlVdlZyVUhjOEdDTXdYa0NPZHdQTGFTZ3dpWHFVbkxPK1NsMVVWYXBWQ25u?=
 =?utf-8?B?WXBHMWVBakI4N3A2b0JuTGdFaERUV2tucXh2RjJzaC9aUmpsRFpiMDFFWWMw?=
 =?utf-8?B?MzU2d05FaGtpU2ljRStSS0R2YWNzbkF3YXdXZ2R4R2JEcHpVU0dBalJicC9t?=
 =?utf-8?B?cW1hTnBHUE1xaWoydEJVTkdndE4zSWUrMlVvQ1JoRWNYZHF4VEprRG5NcWkv?=
 =?utf-8?B?OWxvb1R0aG83Nk5DbjRLeDM3WVZWRjBURSsrendVRmFzclhNcVNRR2ZjM0NV?=
 =?utf-8?B?WnV3YU1QRWRpdldpM1hESTFmdzlQc283ZXZBMEZFMXFVUWd3OGZBOFRvN0oz?=
 =?utf-8?B?bkxSclE2RlloVGJSSFpYUmVOTjl6UWF1V09hWU5hRFZ1WkJvOWFGTlgzSXY2?=
 =?utf-8?B?TW1oMzZZSklybnE4RTdySklzUnRkWW4yYVZVMXMwcVFGdjl6UE5RZnAyZlpm?=
 =?utf-8?B?aW05WTRyQ3NHYUVtUi9keVhnTmpDZmFzRElsdmxHd0M2bEdORHBpblQva1R5?=
 =?utf-8?B?TU81NVc5Q2Z3NUJJZjVlYWlmVlNXNnF6cWl2S3ZnSmp3ZXRqVldvRCt5RGc3?=
 =?utf-8?B?WVlIMUlpN011emg3NVBxN0Y2MEFIbjBNc2IyRDNQTE0zNWFmM1E3ajVoUng2?=
 =?utf-8?B?dVpkdFFjVzNiZml0S3FOcFNaN0V1eGN0RE1SaEEyVGwwaFE5b3dMNlRhZ2E4?=
 =?utf-8?B?amRQeGVqNHJiRkFWanhHNFhmSEQ1SjlRQjFQQjZFOFA2ZHVNTXJtcDV1Zitm?=
 =?utf-8?B?dEdnN1JWQnB6cWNldjlXTVl0NmhXaGFPQ2k2azRXcXlwS1hEdFBuaVBuUSsx?=
 =?utf-8?B?RFp6TWR1TGpOVlhQakQzcHpEclJzdW52UklXNTc5RDIvSG9pQWgxOU5vVlFX?=
 =?utf-8?B?RGdZVHlobGpXOHg0b1M4cTZibXZ1RUtoY1BEZ0RXcDFPLzBXYWdrbGRLL0pD?=
 =?utf-8?B?NmtZSExrUnNTcGdyODFSWDcxU2lFdGg0ODRVZW9HeGltSHFpdkJRWHh4UkFJ?=
 =?utf-8?B?VklzejRCSTdqbm5ManRzeGQ4Wm5Wd1FrdUVyQVZCbjBkV3M5WFhNNnlNbmkv?=
 =?utf-8?B?TndlWlpFamQxWnZuTmQwUWlYZEZqdGRydk9HSDlCaUJrRGI0MTRJSjc0UW9k?=
 =?utf-8?B?aG5OQ2R2NERKWjE3ZkQ4N21kMHlxbEZSTk1PV2E5dEtrc05scGNNaTV3UVUw?=
 =?utf-8?B?dUEzNks2UEpvK2JiUjRvb0VGYlNFZ2NHb3UrcEhkVUM1NmZXa1B2bGF2cHMr?=
 =?utf-8?Q?Y2WjvL4ByXGfK+UZ3tO3YJfnr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394103e6-5859-4fc2-d65d-08dbc89cc192
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 07:52:59.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x87EHwR2sT9XJXwJNFBU22EZ7w3T7TS2PPOKGlZZ4KHDN9de8FDuBLWbzqibPm3Ey5FGZhFLX0X08FqVBFXX0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6UL should be 144 per fuse map, correct it.

Fixes: 4aa2b4802046 ("nvmem: octop: Add support for imx6ul")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index c59cfe13a5f8..8d30c8bfdbcf 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -512,7 +512,7 @@ static const struct ocotp_params imx6sx_params = {
 };
 
 static const struct ocotp_params imx6ul_params = {
-	.nregs = 128,
+	.nregs = 144,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

-- 
2.37.1

