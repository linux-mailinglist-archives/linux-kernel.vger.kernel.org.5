Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AD37BCD2A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjJHIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjJHIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:06:10 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36541F4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:06:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F11eZ8FgVYwDgDcXAkibF9GOvFznvykrR9vYXkYyv6ffG8Lsb7c5sQngvZZQqmRXQ68/Msbk4mrNcPRln13e16A4CCYfp3SrK14kuRC3njVAxhW0vOBbIZ7b4BY6VQvtJ8gTYdoWepbnBqJiabDqt6/LltbFGVfcW6naqrLuCDH3fH0vRIfocJ3YdEYBfg0Y7oMx9orFI0Z0ip6S0h1aJGlC4O8tNoNYSJd7kcjFf/gtSVFXbEC2ilLsD5dCjfm9Cuvibr1bH/7hxKa3pD6ld6m5hPiEtHBqlK6d6IGb+eWHNzO7cGGlp9GzP4FCOL4XYUIZQB3gWTOOO2Za1Dz0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wimk54EpZVga5ll/Fe0x3FjFg/urypMyGbmd2rAMZ/8=;
 b=HYGyo5FRv0mMPKPRvTF7NmNesJ0PqDHCw8MD9VuRS8rZuPc61xKb+cVeV6BbRaYuBv2akIMNXeOVmS3r3hEaG76+JQU3Q69KZdRqZLT8ALgPBS10iQ/Kg5lrtOedzkZtA68I9nMLZR7ftLpGzcQV7mQxGQWIoYGc+eNYukOndA2NVcwUFISmB6OVn/FDlSZbwSivwAYEq065k3r9Wt8kdmgO1Vzwei6PB5IHNpPsIOzhyHL+Bll/0aDiqw90BImHIR3YDgQod9T++3MuD+qmHA5AuI6/4kgkZT4+I5200riTIxnuer3i0AFJAlM3/E7MZHXWh9Pxjy83riVefEruVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wimk54EpZVga5ll/Fe0x3FjFg/urypMyGbmd2rAMZ/8=;
 b=WxlqUfcAzoptzch4eWzNTXZ2Sj7ZzwRCIytmoB1BYNLcAj2nef5wvAx4jSlMWEMNl3QnnWNg2yLWkf8EmsGY+3UXd7ZjjDbWMCk7s+wo+qKNQucDwd8SFsYgU3uArGbHquPD/UjBCVPms1qFxS1lUmU1IHF2ZIZp/lp9SeXWUxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 08:06:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 08:06:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 08 Oct 2023 16:10:22 +0800
Subject: [PATCH 3/3] nvmem: imx: correct nregs for i.MX6ULL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231008-nvmem-imx-v1-3-cabeb18ab676@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696752640; l=739;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7+Q3/+BN8SG/XjZUsduh/RkRRpK/SnMT+GEVy1ZV0cg=;
 b=ubkqyMNzokZ32Sc49Olwy87tZciiHmRBWmvvTdSY4wtP3euPG3jccZC39g5N22/i/sf3CTBGc
 JMjJlB3KeQ6BGKL5UTCxJXy609FKtyir93DQURCWJM3mrhQNfna3bxh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b708ad3-7c91-480b-9dc8-08dbc7d56bc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58OtXT60NOt1pVHJqudh6TcvtuxjZZIHQ8hgU/8e5DkRQLwt9vSOXRagWUujaKwxlioTnhn0ywfBW75RfTyMQo8vCaVUGKqt3PuL/P0qmf7h+JWaTJ4SzR4ESlVtYcnDzSrfwvVoDl3f/Z0g/GfYZFRgOWKhPLuU8RTuA/eBLJM0yPnTrJaLIc4JaTiwxp1Rd0EnDEOOmoxhzH/NP+Cn/qp6AAXiQSIOpfIhUgA1P8FZv/EgCsF3U7cV0VbHZMdNJJWTR977cNhQWpEwOswLbwLQYCwjDucNZXiYza93aQWvRK3yEwD3t1VQKTSjXf15REVic2JXf4MbeqIVkA2D1CwGIfgnU+NGkLFgK0cMvz1EEJmZBgShmFZ5ZUKs5omqu5bwRJOEHcjRbf8ZfVNgzlDt3T6hcI7essOBbtEDj0GRh85eSw2ubu+9e2BodyTMb1CkxTaVmw0uK/0K+RnBnLYZkApyDxh/1p0xwbdRXxKxjQORSCVNmEcQDUDJl2oT1z33z8XwFXIKRkz5wq4TlX8ebaTp5utGsPcQW2QdqSCOoMz+7TBXW0uB9+3lsyYBldskehK137d29JXT1T6q6vWyszEiSDyTiJA1kq0HEeGGzQGwYvSFwYzn4CIJvLsl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(66476007)(66556008)(66946007)(110136005)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(9686003)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpSRDJwRjNvbXBWMmZ2UVFqek9JSUxudnBRUHJVMlhndS9RdXo3RlRMTk5O?=
 =?utf-8?B?aFBDRWFVRVdKWHRwTFVBY25zTW9JK2RRb284TDRGMlFiQUgwaStkTXJFRzhi?=
 =?utf-8?B?S3JSdUcwQXVEd2lVQzVLaU9iVjlYdjNWRm1nZXlha1ovRXVwc0Vyd1l5OW1o?=
 =?utf-8?B?T1ZaanA2QnFoM05mdGJrbEVkdnYzdHFSeGI1MWdRTlB0NmJiRm40MTA0TXVR?=
 =?utf-8?B?RkFxdGZ2ZVB5NDBzaE5wSXBmZy9sWVh3aHhCSVF5d29JNjM2dWVpY3diSUhx?=
 =?utf-8?B?eEhxVXoyVzFkSFl6TmVDNHl3bjJ6TEhOQ21FMngzVmdLbjVIY0NUdVFOcFp4?=
 =?utf-8?B?ajdMMi9wMDRFb2lJR3Jhd0l4eVVZQlJDbDJ1enhTNDh0MmZZaHZJWDUvY3BJ?=
 =?utf-8?B?MTVqTnVTZm5jTHpkWDRrV2oyZGhtRlM5R0tNbjNZc2dha2FjeXhUb1p1QzhL?=
 =?utf-8?B?NDdzNjhBQkdrcnZ1ay92Wit3UGd1UEJwMUR2U2RVVlBGcEU2aWF5Ykk5Y3Fy?=
 =?utf-8?B?L0tGREFFVWZIWHR4eThqZlpMZ0tSV3hSOUoxS0VFRC9kOWV4MWpDc1ZCNk9s?=
 =?utf-8?B?UmdYTWpZVDl5Rm1uRW8zRFFtNkNBeXNBSFhVMVRESjVaTXVCc3ZCVEtPQU5T?=
 =?utf-8?B?UTY1Z0JtV1ZKU2QvNllmWXJibFFlQWZqSWl4T1psSlVFamU3L25sNU96M2ND?=
 =?utf-8?B?UklYZ01YRldrYmdPTjBiWnlPS2RsZGs4ZU5RR2J3dlUwdGhuV2hXMUhUWW85?=
 =?utf-8?B?d1NWTWd1a2tuUzhlQU9hc1NJemFlblQ4SUltRWxqck1DNTljQ21wTjBtZGRY?=
 =?utf-8?B?WkJCRzFjeTA2QkJxWjVXRDZNbzdkU05UNGc1WWJkSjhxbHRHZlQ0Y1UyNFg2?=
 =?utf-8?B?Y21iNmNTei9ZaFpreEdZbmdnL3BoNWkxOWlBcmRNckJ4NStEcTlJWGZqQXZS?=
 =?utf-8?B?YVhRSFJ6emNZVFkzNjNxOFZKZ0wxUFhvRW5GMis0S2VES29hVWQzMWpxamgw?=
 =?utf-8?B?b1dHWTVWUzBDQThiNkRjaFcvbVZrVXA4VGk5dU5xaGtMWG1HZDVGMitLYy9D?=
 =?utf-8?B?cWkwSGNwZFZucDNOWVIrVC9UOXRJTG1PTEhJSFRNVnhLQXAwZUFKNFd0ZzJI?=
 =?utf-8?B?b21URXV0U1hSbEdZcmJaT2hBU21nRUpiTCtjZUJycy9rbC8zLzRLQjlOSlJl?=
 =?utf-8?B?VnFUUCtwV0hac1Y1SFV4eWNLR01oMGVTK3ZPSnVsZm8vWkpJSVhZVXVUdGhQ?=
 =?utf-8?B?S3VWT2tZbGQxZUk3L3E2TktQcUlaV2Z2TWhUU2NmQkdzcVhScmd4YWFRTXJY?=
 =?utf-8?B?bmNuQ3BlY1g2MXREb3RmYmpNbGRlTXFnRXRQaklQUFp0MTBQTlI3RSt1R1lN?=
 =?utf-8?B?SDV1WURsYXpEdjRCcEUxcldvRnFCMVYrMitiL2lUNGtjcHlVTC8wRVN2ZkRC?=
 =?utf-8?B?NVRBWDlKbW1OOHlVcHBiT3o1YkZlK1lta2RHNzZhSm11R1pEZjBDT0xNM1NX?=
 =?utf-8?B?cDVhY1pLZDV2YUZXU2FQYTFNZm5RdzdiTU0vODlYRUNHbjFxNldDNnZmVTVl?=
 =?utf-8?B?TVRZMGtTU2Vab2k0SVEvL01XMldLTkVPcUx5WW15bG9LTEp3THNyQTZQZ0Mw?=
 =?utf-8?B?S2ZKU0JPWmhTWU4wRnp1YUhOaElHY0tsUkw5NEhsUm1DWm5FQkFGSTBOcElP?=
 =?utf-8?B?bXg3eVBHanhHTWFuYmI3eWw3YWdyQlByMXUrS3FlSE83M3I2WFdkcTBxMVNM?=
 =?utf-8?B?NkNnbWliRkpHUTBnYXpoVE1WZjk5NytmMXZCeTlDVmc1YzJsRVVJQVhrc04x?=
 =?utf-8?B?NjcxcUtGT2ZvZEY2blM3a2ZrSkdGa25PcnFTWkoxbWdoanNwTSsyWU5zUnFs?=
 =?utf-8?B?VXVWZGE0TlBGcE1YY3FON0lzYnZMY0xGdjFVbjVDMHl0K0tIM3lyZ1VjOTds?=
 =?utf-8?B?eDFYaVFtOEczam1wZGg0VmFwcVFlSnpYK1NFbSt4akpwUFh2dDZHeDBzNHgy?=
 =?utf-8?B?TDFPM2VSKzNFZWpTUFlOLy8wWEVFdEpZQWxmM0FvaHBZM3E2NHArSDZvcVdX?=
 =?utf-8?B?QlFkOUkvV25HN25LVi9PYVd4cjUxVCtBeStmL1l5dklLV0xjNmhpeHREeXlK?=
 =?utf-8?Q?zEv8sabbCeCSDErXxG40IMrO1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b708ad3-7c91-480b-9dc8-08dbc7d56bc3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 08:06:05.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: betVosy2leCgLs0AHleEU1SxB58Kc9s32CNt5uCHa5ResOR5+zjCTUh2tezMQJ3SpIjr4GfCDwawJhLnJdypSw==
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

The nregs for i.MX6ULL should be 80 per fuse map, correct it.

Fixes: ffbc34bf0e9c ("nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 8d30c8bfdbcf..f1e202efaa49 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -519,7 +519,7 @@ static const struct ocotp_params imx6ul_params = {
 };
 
 static const struct ocotp_params imx6ull_params = {
-	.nregs = 64,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

-- 
2.37.1

