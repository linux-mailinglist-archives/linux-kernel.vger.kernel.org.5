Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9306E7BCD28
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjJHIGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjJHIGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:06:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C780D6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjudyW7Jm5me+TAAZ4n400IiQEcjQ6O+1z7Bd2O6iBlXShuAab5DCou7nFnxe3Nx8IDVmsJmDQUZuD7MU8l/iZK00WKw0HbgubXw9VqIQbIgYqyPozJ7Qv2b3iiRErYvT3Ed05Ay0fUHwDCWv6Q3q+KtQ4lnAJFwSUw0C6PQ03GcGhSVeLsQ3QQkxgVGA4QUiMqCmaX8P0vg7ErXdBQhyA2yRDNmHPOKFqibLUoIWFO19SWxie+GZpSpfGO5S/jBnPWJBYMW8CO1JGxcn6y1CVWCsvMcy+Xg01LBZxnpZgfVzFGq9gD7hmd7SuRhse085TOEv6d6vZrHB/V1EFWyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MPeIXj135oObDnJyhiM1sFnOmihdwdn8qYsSM5rdWI=;
 b=DuD0CJ7bVl/mE4Dwy//4qwN1BfS6guvZOkwJ/RuR4Wb/J3De1adRbJrCzs5HPbYgBzE5illZT1LzDVAswduBbHuU5kUES0QO7NyA50ZDBg6bYlkKVKB1wcR9NGXfrm0H3w/pdJ4bXlDYxNPDMrYzG6r1jbVkFozrY159ZHpNaDtHSt+xPfiP9eeiWgAGvypiZGVr6uDXlCvhbHv9vMqA2YkcPiC+0cUlb/OIEym9dM/u1wWP6/uQM7a+1UUOlLcxOoPQmYrNYVa/6EP2zPScP8ipeWQ84WUgRDCfFwAI06dB6lcfT3LHSFhPF6XywACZW9fFDZSEPy4Dtd3uYGo/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MPeIXj135oObDnJyhiM1sFnOmihdwdn8qYsSM5rdWI=;
 b=f7FfD+u8CGlags/JrmpVIZk5dFidYWB5jGK09Kla7+gqc/8RBG+9jNLVtAKh62kwwnsaeNM/ZyyuAfapddEAMr5EMZP0sZjsmDobyElKlnOts5sCRVeTzjSLGMH1CytHOl5C8P/v9WXBCsEVshYE8Q/7A2O+9k2tT2YwgrpLoq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6873.eurprd04.prod.outlook.com (2603:10a6:10:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 08:05:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 08:05:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Sun, 08 Oct 2023 16:10:20 +0800
Subject: [PATCH 1/3] nvmem: imx: correct nregs for i.MX6SLL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231008-nvmem-imx-v1-1-cabeb18ab676@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696752640; l=733;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=frDGjFGomAmE6x/Iwks1RA/HaV9Q/r8Ir++Umhi7pVo=;
 b=vKCAJsxUKPM0KVFt/fX/7SKX9fW4doU9cUZWab/yiaHySK8JhNpQmQ3JpFFodFaGnyG5sGSDX
 1jaBUfeUMAnD4avpHn4NpF7B6yeUavX668CXlDmGj4aV001U3qaiOkZ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 420ac7de-27c4-4fe9-aab3-08dbc7d56708
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6wFb+wuNxU3jAgDbxzWvE03DfARJ1yYCrMN05LXIm1gSGXdfj2xvMUxJfg0bZxF8eSN1c+X1blvNIDxDhHdURzh5UMnki93Oz4+fM7oJndLA+EWiVd1XGCFR9OLZQ7OsXyuqu3oSOKatVsBIiKQkwkk6pPxcZ6nR6Mvahc5gbzbSNAOP8nSRrq9gpZzuIJVbvjWZSDLjHcZ219pP9+oHw+ZwPPmu40SoU64xIWPVjhhlcRB7oB4nJEEFG9diIl8VzMZasD7Lscubjdg/fbbOZGKcJ4SDgeRey/NB/Ed0wHsnSN2r7vdjxkYUmUcCyzEe3SmAcR80ouQ55wWIFTc3pBSJxGaKn2OPBq0JzpkWNe5jMM3idpe1qUcq1n7MwEUDQkkczkgS9ZfMCWXmrAVwk0r5eJpE9q9s8cCLLQKNxbtwkptbYbYNaYho957TE9u5Dvn+YFY7iqhM5DAfXK7r4bqId3wLGXyi1flDvbjhfzkvUJkFcOqEfr2qA84EjgNUwm3RGXhA6clJ22FSMNJDgw5ALzpfebG6ziPZ5a81iv4jzXK+pKbEGkZWwjv+03Z4FbBSdE2l9ahEXzXWo6Ki8WBVfVguKdaaOjThAjieQFJ0iD2LMT29gwuRpMe81C2MrWn3fENkN04rocQQ7U0Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(66476007)(66556008)(66946007)(110136005)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(9686003)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhqSkVCVnQyNUdpY1dKWkpNRDdwcFdhT1FONEVBOXE5SzFHUmlUd1Bpdkpi?=
 =?utf-8?B?WGlvSW5OT24vK2pObGNSNzZpaG1VeHZHN01PT1lsU0dKTVU4bHM4NHJCNVpO?=
 =?utf-8?B?T0JldEZxaTRGTjNPZmZpTHk2aVphTHFXUDhZZ2ovakpYM0M1ODUzL0h4SVps?=
 =?utf-8?B?bXQvWjBqcUlvTmF5dkYzdGdlaGQxRVdtVHkrVlF6UDR1QjYrNFh5S2NQc2ZW?=
 =?utf-8?B?cnBoVFhURmlISm5OL3ZuRWxrYktkUlBSRXV6UnpNZ2tsZkIrWnlCNHArMHZi?=
 =?utf-8?B?ZmtjVk5nTmYzS3NmWkNvQlU0REpZTHhqalBJVEMyK0phVUdNRitMaTlnWmY3?=
 =?utf-8?B?c2xwMjA0NEVLTVNtaEhyTlczbVgyUFZFRDU1Q05NVnVkQVhBTG92aDl4aitz?=
 =?utf-8?B?MEx4VmtGK2RrR2QreDB5czBJclp3c1RFa3B3S1FHNjBUdWFmY2d4bjhjOVcy?=
 =?utf-8?B?VzJlMmJlbExWT2U4KzdlUFlEdUlmSmZVblNkOE9ac0ZDQm03T2cxVC9CYXRD?=
 =?utf-8?B?a2x2aEg2ZnZjVTNjcWZvQ0VmVUFjaVhMOTBJc3lidXpibVVLdGJJSThta0ZS?=
 =?utf-8?B?eEVieldzSk1zRWY3M0ZMZ1J2VTBsaVpxak9HallVb3RYbnZiamZpRytYMXVa?=
 =?utf-8?B?RHhxaGRLVU5TRVhXbWhuRVM0ZGdpNkpCRi9vMGRHNDJwWkZ1aUFCSVpDTWtt?=
 =?utf-8?B?RGhPUXRFalZtMU5nK1FTTlhhQkRhVmV5TkRxQVczNE1uRURuRVFqSHYzOW9C?=
 =?utf-8?B?UUVLLy9ad0cyblU2Y3ZTQW9ZZG5DYkhQbE12K0Z3aGlGelVVSng1MnJDaGlq?=
 =?utf-8?B?QlVNcXRTSFgvbHREbDFVaXZDMW5xZHlBOEZSV3Y4bVFsajlEMW10U05hbGhQ?=
 =?utf-8?B?bEVrV0FPdVZ4MHZ5S2ZJbG4weXNpUSt3TEFja3A3NG13cjR4OWxQVTVsY0s2?=
 =?utf-8?B?MCtPQlpqay9HRTRDTi84NnN0ZmFFMFZrcDdhTk01NXFBWGx0RGM3dzkzOTBU?=
 =?utf-8?B?ZFMyUzYwUkZuMlhTM2sveENUSFpUM05PMEV3Z000d1pQcTFva1htQWMrT2tj?=
 =?utf-8?B?VTBOb055MTNFbFdTV0NnOVNPS29CK0U3YXgzdVFUS2k5NFpmMDlwS29RUUVx?=
 =?utf-8?B?NmZWMFZaTWIxWGRnM2NXQU5GWlBsTlhOSVF5ZGsvSmp4WDNuTGFsd2lIZ21V?=
 =?utf-8?B?anJUTmFKM0V2RWxRSzk4ZUZieGEyRkVjWWFaSUhKZ1dEWmVQSDIxOUltUC8y?=
 =?utf-8?B?U2txYk94L3U4QTFSZ3VwYllES3B6NzhpRWNEYnV4aTd4azZRZjN5TTBxUjVO?=
 =?utf-8?B?YzZIZjNiYlNMeklTZU85NmRoeUZ2T3d4enhBUU9iNGUvYnMvMHd1cXpZSGIw?=
 =?utf-8?B?WGFmUnV4dlV6clBNTHFtdXpscFpMNzRLTEFKUFpFZy81MlBWT2Rqc2l1K1dq?=
 =?utf-8?B?bHM2OHJSU3BSNXdHVmVvd0Q0Rjg1UEM4R1J5ZGx6NEpLbjJLZWQzSkdTVXF2?=
 =?utf-8?B?S0t1TCtad1dEK0RJQ1puNEtqcEtkSzlLR0hIRnFBdXpwQi84Q0hMYllaOEtC?=
 =?utf-8?B?Y3NMYnRpbDRWb2VPbG5URU1EV25KV1IrVVVqejlmQWVaTmtCLzE1NkZ6b09l?=
 =?utf-8?B?cmdhL0dDWnpidUtmVVY3TFRYQmgyV1ZyZW52bUFvWTcyN213d0svKzl0Qm9T?=
 =?utf-8?B?Rmlsb1ZvNGF0NmpxWmFNWlhwd3VlS3BuOThoQ3Z3cExYQmUwMEhxckF4dEw5?=
 =?utf-8?B?YkttU2ZyNWxUNUpzV1A2WnVoV2c2ZHl3T1dGNmlWbEJKUncvS2FlVXRXcHB0?=
 =?utf-8?B?eitsbWpKeUJpcVQ4dk5kK2kyVjNURGkwQjJsUHJKL1BhUVU4TGgyTXU2RnZI?=
 =?utf-8?B?YnYybXVNOHU5T2U0Tm81S1JxSnBEQStDaEg3N0ZQNmdqLzhyb1hhMWQrMThJ?=
 =?utf-8?B?eEVqaFlEUkxPY0R3ZThIN2dFaFhjVjBXU3AvNFVMeUtSekQ2alMzUTU3UVls?=
 =?utf-8?B?eVFqSitveWZEOW40ZHlOaldkelhXM3cvRS9HdFU1aGJETGhQN1BWSjMrRlJO?=
 =?utf-8?B?MjVwMkZFdjIzUGw2QmpBb0pwMnhPeHdCSFRTZ1pEMVhQSjViaXY3N2YrVE80?=
 =?utf-8?Q?VxF2UuhacZkkKEs5c9y4ZbKSy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420ac7de-27c4-4fe9-aab3-08dbc7d56708
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 08:05:57.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPxZKzc8vS+XtSB8nYF9K3iQvl3JrX4uO++ukuVBqVpeDjJuHJFZsHS1q7DWwZJ1JIoTLxooXm64utsnRI9Nhw==
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

The nregs for i.MX6SLL should be 80 per fuse map, correct it.

Fixes: 6da27821a6f5 ("nvmem: imx-ocotp: add support for imx6sll")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 434f197e27bf..c59cfe13a5f8 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -498,7 +498,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

-- 
2.37.1

