Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930977CFB76
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbjJSNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbjJSNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:42:34 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5925B11F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcrs/d76aOAhqTymJexkJEItYyIIGasWl2yjNO6/61G/iFatmaVRs+RKPH7poV0zDWgHcpWJYdGhJ8KpCLhajgeZ7zooTNyU47pfSOZ5TB3lklW0ijUCzJqcLM8ReZyiFo3pkDevuXvv9zadlRRDVadtE3fWnaLXVWrwOeuLpxXGPKRBOGvozsF4V05o7cKsaN8xGWQCI8yMdacW/hd6AqcZWqvnxtzM5ZV1qRS/t8qt2crLjdFLpjFItyQH+nNJMDGuZLdnwBKUMRGIbdW/KmK8sfzMRC8MM2oww3VLrM1GcbhKeKViFzzkMk7iRgmZYY2RIK7ijZoNoqP39GNUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttDMeAdBaYDkoUPkHds/V8WB5XZWoJlIeSsk8KlPZP8=;
 b=mYGVI1xQczR5Tri1w5JXfjSgPgVooS7+c+QNir5/d8HF38lKFQ3xdGDqanNZqnPV8PQzGYiPXtyuh2M0rTwC4h/yn9dS9m66ddI9U+R7f+V3Ee+19CQMHdG090i14d7fNxpt4Wp/nI+RzenBPuCv4Az2gVb5mGPlcztTA/uUSj6Ra0iDpwy23edzIuVFGHQX7+QKBcaM/enpgHs4jgnyTRp2PNOYGEQt7B0qBaTmML9v6EgTlfZViWbUA7cU0/5zWQyBTiBwtl8CeUipo4O5SfqJAyBYMrhm1MXhle1LRDdsL6TrUPGAQXBkv3nzr0lUvg3fKRdpYPaWJ9zH1H1UNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttDMeAdBaYDkoUPkHds/V8WB5XZWoJlIeSsk8KlPZP8=;
 b=Jx7usrdSLRwsWRq7VkVdifBVWP3guDAVZNdVv7HZiTru/3ySANOgc2ndyNIpo6oofAQEqTsoQ7TGysXTY3znTbnid2Qij86Vxm1CGbw1X5pCD2uwlFsl6IfSWngShYC3xnI9ZeXo2tbStgnB7oeZGY7IXMOWNTGZk1hQLcvEt/KYGrJFN7NioHxryVtjuUcjuFgCYfwNDCcXRc/XZKmJm46NQOJeb6AVgORjM3xIXK4scBSI6Xdd8Ug0AKOyduwLFD14RI/0rMNJZppeU1Zr8K/bvejkmXV4Pb5iKI5Fka8VwKAP4PCwF8+QmWgkDZELQu5iYsKf70hdimFeMLAX2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:42:25 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:42:25 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 0/2] mm: the dirty folio unmap redundantly
Date:   Thu, 19 Oct 2023 21:42:09 +0800
Message-ID: <20231019134211.329-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 72baf0a7-5cef-4892-0c72-08dbd0a93994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HExBZEv7rcmXZvk4RP6OZl0doq/qFMUFLPYTp3F4z8CtG0sBst1Fpw7Dn9TqqCtraMi7YpIzLRqpS2ku5+vjYTymOdKSkrYWsEzxv8LuIT3BwjnQJMDvGRyDsLP98J9FcnDqyI5dz9RWh+EKBfSrxM5EBGa9WHNGubd/OztscLh8zahgR9ErOcaB6GQSiHV9ISjtPb2/swpLcu/7zKDvoz3ch9fLfh6a6pyZ/6hXblL0dsBaDFaWvEke4TCCmtt8BH3ej0m6c8x/5LI/zN6IdTBgIMfC7MH9TN/CueNpRyYx37g3aQw+Bfo+XOAxWwoVYSci8kxHS5xSyL18npvT/X3HbXLy8I/07ZYmlYihRzAjQFJ7+rGHZVAyMU8tbKS0COLT0WKEnMGG0xotF9g9n/T/QzNdduR0D/f4iLPEvp/Xs+vdGsX7ALxbvTK00pANJ6vJCgWXCSFb0tNZJxyh6FpIkynvQwS6uxGoQIfYI/POGv+wRrpIyxS9MyxPyF0IB/2GHH4jpFKUUQAmWddUykoOv1bBgKCaekRPQPXPt0ONaTRFX1GuqAnYLvBx01ClZYWvUIo7Sqp3KL1wSHf0/NdZln+on3LqOdVmbPHoNKFRuFQtZqh3Nsfv3utpErEhJ5Onktj0sfhmyjqNXqPwTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(52116002)(6666004)(2616005)(1076003)(6506007)(107886003)(26005)(66476007)(478600001)(316002)(66946007)(8936002)(4326008)(66556008)(6486002)(83380400001)(38100700002)(6512007)(2906002)(86362001)(558084003)(41300700001)(5660300002)(38350700005)(36756003)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxJuSSvJtUue6WJqyZgVOrWYTQEP8AwdXpfDDOgMIaBLgC2iQ7MOVlsqihTA?=
 =?us-ascii?Q?u6nKxFrXzyROf5D/54L4BbPdMcXmm8SHcYJuCSSzxT1JGVxcnIk/Sc835Co6?=
 =?us-ascii?Q?tNfadZFLRdhRrPKFpKkS8+7TLmbCkYiID0X0VEHhEBMCal0LPddz8yXCcnlj?=
 =?us-ascii?Q?SjGmIlRnFllipehM8mVkOooYpSGMfXQf8HidGHYrUISZk5Kxi2C7Fny4VGgG?=
 =?us-ascii?Q?fk4de+ENXiL5ZnsYB6SZuhizeeaqrikegiMcsz1lgmXkKQTlu/7XGbfa2dhz?=
 =?us-ascii?Q?ASjFPejLiCDOoUXONt3O/ll2QRCeimGGo0Hs/REs0frOGYlqZV+3DfbZF3Yg?=
 =?us-ascii?Q?e35FTGlmRQFoMqx4vvgcwTWlaAMER8v7mQLNSIbuw/pucX7Mlb1DOQ/wBawO?=
 =?us-ascii?Q?tk/8JsGO+BQssvt0QamOsVTMGGQiX92ZtZhvKFjfY00JtKvUdU+cTTLYTtfZ?=
 =?us-ascii?Q?TBv+BLm9vKThADuYHPsT4J8feOfcAFGxdyDHm7bDG/0jETUHRyy3LT4i7d+N?=
 =?us-ascii?Q?EeUbis27mXf1UMIuzX7Wio38RtqtrCdUoMWESMbW9S0PuOdUfh3RFxY8VLue?=
 =?us-ascii?Q?gfh9O9+a2b8j9mctSOav6nCp1i/GKnfn4lFjQ4DKpjg8FAxldvmG4NThrBls?=
 =?us-ascii?Q?xjLeseyYcbKcrscOCYH4Ef05M0t0XRrHnI14pBKcbKZZXty6i/+AUBjgqO/Q?=
 =?us-ascii?Q?7ROkcRq0U3lAqHx1+2vcJsZ6WLJJGmoxhVc+/dsvRj5eq0jYO1GApDxRhqvK?=
 =?us-ascii?Q?DcRa9Ddr9zFn++1ufiIVmc8nT1WP1NPVwDgVx1Gypb7v1L2wPN1p9+9+XXNW?=
 =?us-ascii?Q?xZL6r7s+UJBlikweSxxFKHyTzgC63TGO9SbhGKDd17HCs9dIJq6H4XpsMN40?=
 =?us-ascii?Q?PmPiWhIX9/iD4ZwkXRWro9h5AhsIXH88qgmqXMv46Fy/5RbZPicEQqmlVsLY?=
 =?us-ascii?Q?H2ElZYIrXiVues5sL0TFlGc6yylwkMX8d0ECC/CICPSw+56NwY/PrhPWBQ4A?=
 =?us-ascii?Q?x9CFT70ADUqwsPj/VKKNOUCNOXY5l/w0EHU4htW25MyxtzHJmusmn2/w7KKs?=
 =?us-ascii?Q?GlofFFNutvrFvtncDkPqlc5nneappGlOACkQ+tFBInRLGWJbL8c1hp+Z0KQk?=
 =?us-ascii?Q?LFdVl2Mx106bbawctLOZ0sUXXa5irKvWojhk6FlSF6QT8BY3FjADbxg4h9es?=
 =?us-ascii?Q?Za0EKKAj3Ukr/MszSkYXbxtv7fH+qgZb5JVTThUYJwVvtCfKnxT/tZA+HOtA?=
 =?us-ascii?Q?idLNMQx549gE9QKEOZdZvGMqjg/jQectPFF5U5QnLu71OeeKs/pZaDPH6pZg?=
 =?us-ascii?Q?UgNRo+jrwHi1HvS3oRpYA9hBzoeDb81fzRPemHXeMsd97Wut/EbmBIQy3QBN?=
 =?us-ascii?Q?yhBNZMuZCA5YSnbXbd8vTGlPNYd0PzJXXca3KnwpJ+z5s19LCZMdErvjM7gq?=
 =?us-ascii?Q?jKuMvjZauvPKb8w/Kc+ogAGiHRDnUAhT74hD12mnZp1J/ccLbiEV3U1gRD7K?=
 =?us-ascii?Q?VEW2oLsgAIZj+HpdTx2tWaTOqLENO3v77Lyc/2E2rbAO2n2ksQRH6KvvXC50?=
 =?us-ascii?Q?Cpn89+Oy/Fl4ybS67xLDPKm/TK23pNatM+W9GCvl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72baf0a7-5cef-4892-0c72-08dbd0a93994
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:42:24.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8YJLU1P6F0SrrijanAzAZB99XcBiP7lHo2q2jtRFJ/CnSrT5B7jfx3Cj6QC9EFELF9O3/5XwnweVoG5x5IJKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Zhiguo Jiang (2):
  mm:vmscan: the dirty folio in folio list skip unmap
  mm:vmscan: the ref clean dirty folio skip unmap

 mm/vmscan.c | 106 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 37 deletions(-)

-- 
2.39.0

