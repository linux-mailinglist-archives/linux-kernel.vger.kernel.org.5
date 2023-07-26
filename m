Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050A763531
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjGZLiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjGZLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:44 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E12697;
        Wed, 26 Jul 2023 04:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQJkBWaYY4KKunvRvXhsxVDLBmpPTVz352RVUX1g5x9jZhtwWNDJqfsKyhCyxJUzEke/lVbKg3JFL0BHjCZRV9jbJT3zSeJZcULCjMxMaDQWNlRECrTQctmGB60jRGSei46E7Rz7Nn8wtIlGcFWEEZgrAbFdm6qPTG9Tsqswm0BSpQY6N8hOkfyUeeZfGPXmRojkudZPsy/pfhiLZ4qmejUgB9N1r1MylfLDSI7JaPZve+BgxtL8OIO8AaU/M3+kHt54ZfTldeStRR6yix2bz0G7KoyF21e0sbGHl2jzRzxGMSA25o3xO7aYONZXT5ZYRt5bvpa7vel6dDROjBRN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJp333eSbifWKcVL71AiHBl3VQerhjNYTq3qUNbvqNc=;
 b=G5iuMpS/PnyGVi1Mfv/bSzZkprfCDyz9DeSyG1Rlo7SnhDfjnabweB1RMWdBhWAc6UP4LuZLSqTpAtPlTMDgPr/yMdkGRWAUVzcXWG41jI759S19uVGU02AQV0V3O3OAX2e/lkD+csl/6J8xmKZPmSwwa/ElD35d+VuqekZtYzaB94ztdVxSTGbvMD9bRsXhoDeFlG2ZyAcLeiBbXi1M/MvbAGoAuOgb75fpu6p6ouPQNW0SzxyE1Tu1g7LioUdT2C7UjTsJrMlDVA87pEVOHe6SZsZJc1822pNXwM7p4nMJFqTHVFCsa22NfI7IbTnYQak9ssYCrNqDehpnuj2Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJp333eSbifWKcVL71AiHBl3VQerhjNYTq3qUNbvqNc=;
 b=RJx0EG6mMq+5E23UQL8+yfQzvPPSyoR15rTmq/4MpVPuaPkizz9clqPGuvJTsLVe/E/Wzl82vVozOkV4r6jqcb8CQsyMhXoDfA8hqMn1oRegvO++hKgAfhrn0A7SsH2yGo6seWAigF51D3GG3vBSsLQFri1W2Opmi+epa1OcHGuPCe4hY6Pj0Mcii34W5x5ney2ItofE3E7aRSljDqZZtSsxgboY8J0EQBFmAYUEDLFB37GNIEIsnaSUNhm77xxHMJzWLnkVrBvg4vH/2XQipedrQRQkMCpQSOU3Ija79OnKHG7TQC9PrcxASuUlPnBOvqlqrXTAvRgpvN5psrsDNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:32 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/30] usb: ohci-at91: Remove redundant msg at probe time
Date:   Wed, 26 Jul 2023 19:37:50 +0800
Message-Id: <20230726113816.888-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dcdcb5f-cade-4400-e516-08db8dccd6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqm/jozl8PVvCw+hbfeAfqdqgL/ysseRHuWimrjHb/0ee5HmgGxifGXbraVo1La2rujLFEyzFWrt/1GlZ9MFXJEGzzSQkc1eXf8iK5rQ7Vlo1HlPxgzpIlD9kLTRkVrfFhYr8bg3Xg31CFjyZ08sgCuEckDaMnZJT9ob4wPHFc1itfZT/suf0o/LBdHajGSbjhBF7op60j0ITpAkKaSaIME4YPJrNjCReUbQ5a4N6/2M8KYMaHKj9ZN/Not6xvR63MB8dXwPQ6AlzQqyyegxYVhn7yPMhLfZyZOO3HDx5uLDcPMlOpsJSarO8IIDH4EenKQ4ElWmfVuzal9dy3hR1WFMrS2d+EQcVo72Pt5QK3DgwZDUqZfpVoHKei27HJe5yxqxE2D1yOWgXWY85G3a3SGoFC3UlCQrlTnTKX9zJSnaE44HKuYtAUBGpT4gEB1AZywebiEHfPpq08EtWrlwctC6Gth9bZXUKquGrN1qSppjpHWCzrQADg6W+2DocoaXCmtM8//NJxBz6P23stBkP78JvE6T9mUnMbC2ElTQ62ZY/0x0pxRnODCcxtTXiDJrm3W9L6vGH1Gm6JSlqjM+DVdmphCo+ecIEGwDXMy3Yp9dtEaIM33cCDywIvslckkv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iWWBT/0ieNUl3nE2AuO1GgNu5shr0OtbIkuiakj3V5ZQiWEwstmcWRm6Pec5?=
 =?us-ascii?Q?K6Ht0W74Ogoxpye70AIBXk1NGFck/5bXeHeNSsaHFQLLmI4ktKOGN3uo9oO4?=
 =?us-ascii?Q?BKtxRQRkf5HtQapRKFhcfm0jciuy48lly/uZSSq7OQgwyl63l/3QDyOJKnGY?=
 =?us-ascii?Q?OlGLi39TMcu/HbMjQqGxBc4XkBYabM3G6/EgIyav99e7AcoETZyuuHGlkReb?=
 =?us-ascii?Q?ggtMGa4YPg0LvqJOfppODJ4Tohzs7YE9X6OIBMdamUmHoea8aekPRxpmLwDN?=
 =?us-ascii?Q?LDuwnOIXt5AWJ2UK1EN0l6Ys8y1Bog7sPeOoewSTOY81LCj2VxlGnUun10mc?=
 =?us-ascii?Q?3gUtnEJoCxb1OG03qy+ag6ogl0z1d/XoDhe1JMSm0h2KqstUy8FFaHfbMrkg?=
 =?us-ascii?Q?l0VBTPTGI3YpNYdeYhs3Bnd0NvEVvFtx7VpI+2Ntewtl0dx8S/F2PmVa+rRk?=
 =?us-ascii?Q?n7JrbDLwGOPM7/DMaFAUrhCKf9qV4eKBc9BWq577oKGB+QsOkelAvJAqplcd?=
 =?us-ascii?Q?Wfc3Gele7lt+RUtoESUMWk8rlgxRO3+jv7qsJMuZ1L2zWwd+tr//UlqS5/si?=
 =?us-ascii?Q?nQvcZlPhGcGRItf529MNbFKFNjAk6Vl1VQCA3M85wr0IMex2GNFOWcFlFDd0?=
 =?us-ascii?Q?4DUFoDekBt/HN6G3mT8belDuOyN9tk3JT+twaRaYa9gNCJ/Y6zhZbMntRJem?=
 =?us-ascii?Q?II3ssdsUEbUGJ1pttnFNtfkl01GXi9jtnx5Dk/xVWrlNvzxF9LwSc5lbC6PW?=
 =?us-ascii?Q?x4NqLwqGtmCjMaQh/8nXs96usyS9lM9mQoI3QzSXvvFIebBpvg4ucckDJRWj?=
 =?us-ascii?Q?FBrRszWCfAMziWpG6Lzfbdn8jQU5wScmPysL3NJzOWsY1IaMdqQDi5RE8UgR?=
 =?us-ascii?Q?eBmFWaFOkIWfgdIgk8WhXs9lm4ZzbaXP4xPdkgO6017Qqz7wslpE8Fq1zJo1?=
 =?us-ascii?Q?7DoU8dfcl442sDyEGh4r24TZSE0PSe2aSRTFiZiV+TGRKUuXQjWO+UfEkM9H?=
 =?us-ascii?Q?ZsfN0DxPDeCCYDShRUqp31PbtS0K1uXJ8jUCUIdP7xBRmQR0sw1wpRqmEM8+?=
 =?us-ascii?Q?lozDPBoCBVn3QPk8d5vmUM2PcLygBeM9Lhws0qVddllOwNyQ34QYyKLnDSPj?=
 =?us-ascii?Q?uFUitOIqxLm4VMfH1XITk2dMmsBkp/hL2JweNA17gYrqtTUhN+sor8O+8JtR?=
 =?us-ascii?Q?DnmdocyErSAeKo4BvRkAOwN7bRpkoZyfYzsMqmrE+t/7gGIMq1bkyhSzQ2tw?=
 =?us-ascii?Q?8AzsNycBHJx/CqejtttLiIx/GnXzQZhyygOA6bPYkUlBlofzA6Rdv0vKoBaB?=
 =?us-ascii?Q?7132vvQCiPdeFhVLTRAzM+d8PyIbl4F9RI8RBO9PURVYHuLVLv85DwY/RDNt?=
 =?us-ascii?Q?BA4DJyChrAfYP7SazBEvz1EG2XSBl4YvFKJonwLPY616RZQkwkwH3/H3FwVz?=
 =?us-ascii?Q?2bSYAxQCPfZS2qk4VI6vosoaZFem+dVu1FzGB7JKNA90cWE7bo1LYh2agHmp?=
 =?us-ascii?Q?+1MCtbCsNftIcF7ttw6NXgFO+EUtrtzDfSR4zGnkhuxxUP5H9+X7NV4unBaZ?=
 =?us-ascii?Q?uLu1FqKiW+EGCFAU9RKLqe3vjouuwOef9uTi+IJm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcdcb5f-cade-4400-e516-08db8dccd6c4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:32.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ktzBf6BIHeOzDgzak1/g8A1Ezzrq1kLiT+3hFeJQfYHQQoeIP3JprrfBP0xeUGiE4S3D+p1CUr8vGGjcrUYKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() directly prints error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/host/ohci-at91.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index f957d008f360..439d8a16d7c5 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -190,10 +190,8 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_dbg(dev, "hcd probe: missing irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(driver, dev, "at91");
 	if (!hcd)
-- 
2.39.0

