Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED747BCD29
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjJHIGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjJHIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:06:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8A9D8
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgWWr+ZuzRgGYGzLqA2205R6caJnPTEoqx9d+vPEhjNcOiXfwE3AGgV5T9S0v9gBKV5OjP43gAkSHPTphcGYEnFweWUWJ03N00zFpoQo0C1BUiEK0vex3AZRI0yl7WWJVfp8PEmZnQ5DBTOzBDBS2ocdziJK4V7isj159RWkCYenU1hApQOMpaDeAzmjWfqeDgFihsZLxBepnUkYjFlR6EJ7Kgl20HeSYR366yY3q+7XlTdr2FBF/jbshmGm5CXYVsUoDAJRbwLcURGNuiNTxobhWYb8xpaccjDlHanaA6ZjnmNzTtEQBWjSEbNnTCcNBvI2PjjZ6B4vmakJ4AYlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuHk5yQFLkF5ctZSYieCeQgh8m9OCaOYK0A/Qvvd80Q=;
 b=U+uEGMRJjyaXbIhcsx6K0LFIm5h/yXsW8NbxwsRwyWPBwCeCYyi0hdvC9REsgFLdND/tAAjDtgts3SyKPITwIdGnRE1stS6H5jG3uvW8gcasVndKL2wadv86oIBza4IsnuE85Zu8jXgILO7XCOpc9AgZLhmMg8+wSZP8h6k60UrdJiPZnZy8qdEndNYRPwvh+nVMiJ1EmqKe/6Vszek/7goiBnpq9k2PcruPO/Mq30sqc8GluB231dWdTnbkccT/UbDPVxNLdtSvgXsCNYnpK1YbVS1znXm2J8m3yBptOKLB4EL82j+23lS6noZHHIag6a/YiRj8ZAXeqLY2JiHVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuHk5yQFLkF5ctZSYieCeQgh8m9OCaOYK0A/Qvvd80Q=;
 b=LMpg5oei/me/V1nADLOPYQFqFuAoD84VUtnYb+Uo94sGnqjU6JvQQgkYd4QizEnXwHmPZY1WQsGB1d9nnvka2O9nmKqhUJHgOW5ampZxzjhLhMJu0+63MtUdUbUpeEn1Vn87R8lfizoFjl52qVv+CtEcn+wOQ6uqegkdCaiONu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 08:06:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 08:06:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 08 Oct 2023 16:10:21 +0800
Subject: [PATCH 2/3] nvmem: imx: correct nregs for i.MX6UL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231008-nvmem-imx-v1-2-cabeb18ab676@nxp.com>
References: <20231008-nvmem-imx-v1-0-cabeb18ab676@nxp.com>
In-Reply-To: <20231008-nvmem-imx-v1-0-cabeb18ab676@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bai Ping <ping.bai@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696752640; l=728;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=t1P/FFVDtfGvUUlhnnQarthIxTxadP0c4DLu+Gzpyk4=;
 b=vJIMe1hL68K542pblDE0JXNSZF/eouXWISesty7T58hKpf1Hy1Q9e8cj9DKwa3QbY3ac1t39c
 Wkuht27hygqApx3cNllPTbkgWECgBZ6zQGpqvIuYdz5k2VjIURcqrCu
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: ec636683-9f24-4620-e8c6-08dbc7d5696a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XO/dEaETer34a2llbnYdFgdhw1Ncwp3eXsYw4/yig8rTvyxNfZ7GD/H92C7kJ12cmz5LdLylh06BEx2ibrkHFlKPpKpmTD8N5tsBrcXZ5eGaUD/gG7LdUd1ylQGtT+pA5GC1FzwOGw1BHSsWyu0BOSOeGcGH8tlUZcekAceUIEg+UwxtnSjUGz7e68Os0rk01avkneEdlfY/IhrohTkcBh5OxfPcnpf7+unTPftY38rXIE7WnIoxvNZfXs0kjCp/8IQBrNNTE6ISlzRBG1tNX0yb36dQWow1gCgM1dWbV+BqcRqel+Lp78WO89GLjGe5h40jYp02YBczTpPfb23g6dmp87bhdsjRdoFCsUESZHqHTu6XRm3Ue2p6bnj89NZY6fPwiilPH5v56kx1nn+tXKMrEniXYCML80Y67Zr84FVcqZPHHJR2XpfrMTbh6JPU9kIbm4GYXYHn0fFvb5vvgC5yG3+wiVW75VfKtAeow1xg43refi1PD3STMeq0CG69NDLPtWrwmtC8OZ43lOjZTOo0zs9hW8wWbX6xcqmmnD1Duuwf1k2c5d+buZfhd7LjH1yRpVzag7mlKIuYvhVhw2OtqgHnB/H9tTguL+4VpWdMyeGTZYyGGEXnWBCpTKV2QKgSQBgSHyR1mIR0MW4dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(66476007)(66556008)(66946007)(110136005)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(9686003)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFLZjMyU01sOVV1RDZMZExFUktCbWZXTWlQcDhocVN1Z3Zld3FkcWlidEVP?=
 =?utf-8?B?OUE2MmJjTHZvWEdXWnRGaGU2Q1UwbkI4NFlLTGxCU2MzcVpzdi9INkJaUHEr?=
 =?utf-8?B?OENmaDU5MkhxdDBFbVpFUzNmTFN3SjV3ZUZDWUwzc0dFa0VTMllWcS9wdVYz?=
 =?utf-8?B?Q0szczBxdkY2YUJZamFmbHB3YVlnTTBrZ3JkZ1JpdEYrMGlyRjhoc2xsQjlo?=
 =?utf-8?B?eEZyMERkWlpIcVh6NFBmVzJaZ1JsZFh3aDRTTE1HNUNMVytlVy9HV0QySjlr?=
 =?utf-8?B?ajRJNzlROS95T0VhUlRmWlZXL2FCWFVZeDdkeFcxRW96d3JxNm1QRDF3bkhG?=
 =?utf-8?B?N2NZM084anc0ZDloN1A0SEEzY25teE5wZW50TnNUNHZkZVhsMG9vOURldFd5?=
 =?utf-8?B?V0xCbXJ5T0psY05jYWRhQlRrTXVqVXFPWFRUTTYzRmVibFlvUjVDVi9GaHpT?=
 =?utf-8?B?bDBkVG5OdDVVM0w0TTI5dTdINVpsekxEbjRyN0pMNmpVeWRQQUFNMmF5SEVT?=
 =?utf-8?B?TnU4Um9ZUGhIaCtvZWIyb1ZodEUvUnV5a1NySmZjSTRtT3RVMXhBbloxMnUw?=
 =?utf-8?B?eEN1MmFvTlcyLzBSQ1VYZXpEME8vME92VnViU0RncDRJN3p1aDROUjhvc0dV?=
 =?utf-8?B?YXBRL2FabnRvUE5TODNSVTRWVHEwQ01oRFEzaUtNUWNyQUUxSU5iWUhVdldE?=
 =?utf-8?B?eEtEczVPMWd2VlQvNm5PSXNnOGZmTDdvUGhwQXB1YmJUTlBZSXdRVkFyWXNn?=
 =?utf-8?B?am0rVWl5U0d5SzBKS1ozWFBVbHNnSHNXdHQ2WlE5QjJscFE0dzdia0V5WG9o?=
 =?utf-8?B?K0h5NHpwekgrSHlzOHRKZWpyMm1LNDhTeEY0bzVkTnQyUW5IYjE5UTF0WVhT?=
 =?utf-8?B?TWkwUTNjWkdLQjhZYi9CUFpsbVh6aG9ESUJTQUZLNzd5aWVQdmgzaGhlamZX?=
 =?utf-8?B?bEtMc2Zna0pLbW1yV3hHMndyZ2xCU3VuTkxLaFNqNEd2Yi9haDYvSlk5ZXIy?=
 =?utf-8?B?WDRVaXIxQjl6TjRKZFRka09lbjRCbkpHelQ0RGY0YzUyOG5zbHdxWCtqVHhx?=
 =?utf-8?B?bWNRMHljdG1qODZFdHlmTjRFV1V6Qk4vSjQyVjNoY3U0Q1NZQi9PRE9ubFJL?=
 =?utf-8?B?Z2Z2UEJnWk8rSEFoM1ZTWHVyMnR5cTUwU051RVdUQ1dnVFMxc1hJM2Mrejhk?=
 =?utf-8?B?emNiY09paTNRNklOMnNsWjMvNTFHNWhuZVdCNmdWQTFsTHJrQnV5WkNpbVV1?=
 =?utf-8?B?TkRubzlaQ09IZ2ZRc1RJVHV5K3c1eVNvWC8zSGJKeXdJOXFLSENSNFFCWGFI?=
 =?utf-8?B?aktPd0ZDNm1kY2dHNXhWM251WXR4QnhnajVrUURFWG95NEFudW15Y2Y3ckRy?=
 =?utf-8?B?Z3FGOG1tWUdVMnQySGU2VGVxdzRFM1RZS1lCREtuYXZBSDNJUXJVaXFRY1Bz?=
 =?utf-8?B?RGdQVFF6N3l3R3JMY3Q1bzgvS3pLUkFXNVlVTUNYTGtUcXdPL0xrWmVJcGhs?=
 =?utf-8?B?VlUxVzFqU05nellaQUdZQTFxRkpkMlRHQ1hjTWpUWXR2SnRSMGRaTnJZNWw2?=
 =?utf-8?B?a0M3U0Z6UDdDRUhJTFhPN1MvZTZsUHVzaHZ6Rnllc0RlUE1OOENFejBHR3A0?=
 =?utf-8?B?SUxRMmF1dVBpQWZkdnBBcmVuNmxRRXRBSVAyZGZacG5Ha3gyZlhhVnJ6Tmtj?=
 =?utf-8?B?SnpCSFlUcllWWUlhbUhnQUJlbGxsNStoNWVYeHlDS2NGbC9wckNQSlZGMUhD?=
 =?utf-8?B?ZFRsR0JuSkZSSUNROTRaRDlKMjUvdlgxOUlyM24wVGNpQ3ZKSzBPajFyV1NW?=
 =?utf-8?B?dEw0OTljYlU5dFNjZ1Z2WHkxYVNWUmRONHRRalZHQzBmb0tCTldHUENvT0xR?=
 =?utf-8?B?aWtMcFpEaTZPUERaR0h4OExCNmZOeGtOT0YzQVNQc2ExUVF0VitPa1ZJMDdp?=
 =?utf-8?B?cTNBUitwZEppek1pdTNuRC9TVTVlM3Y1dDFwNFpBZ1ZYelpNQ2h3d0U2TWpy?=
 =?utf-8?B?dUM3QzU4OXIvYjBLZ1hSMGZGRnZNYTBwb2dvQzF3QVlDdVZuS3NsZWNIb3M4?=
 =?utf-8?B?N3RqRTRZU2JaRGg3K3MwRzlSaEVmT0o3aTNPSkt1aGFWZG8wYXdJWUNDOXFw?=
 =?utf-8?Q?cSzy32et773Rd5n6+5lu+nUuq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec636683-9f24-4620-e8c6-08dbc7d5696a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 08:06:01.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iboZ7/PBs6O8ON03FLBsbeFontkO8ZhvhgnJRZa/hb0w0jUdqB/j7PYB3PzZCupAJyFJcvycU4Hsak/lR56ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6873
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

