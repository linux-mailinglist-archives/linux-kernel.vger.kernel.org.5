Return-Path: <linux-kernel+bounces-24208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A682B916
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC921F228C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FCE139F;
	Fri, 12 Jan 2024 01:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XNPHDmfb"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2093.outbound.protection.outlook.com [40.107.215.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDB136B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU1Q4XlL39SSi/SzmWPU4Wz8w1jdYdX2zCBhcPJ6FXLv6JexXKYLoImBiAGO5JOzelzlK+JUZRppy/4FcGF/NRthvej7LgIduWQ/Fa3Rm9KUzrIRd0fkaVG3w68uvJ1JSvt+YOBoqA8waEaF2FUOtdhNqh4lp38bhDxkwluVywfsQCA59BIRNFnCxChjwFzgLax8sWLmxdEpvLX1b2Vzeh78BqqPahyQkysjQURCs9bGwHansnd/EFN6OSHVr9aMyuPSa+aoO1X688RZs75FQMkziZYQXQU9HBPRFzkZnnSTYq//rRfu0j4lA9pVlWshToJjBnq8Q+LLCSDOP4Sx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj5AV5yhLvp46POzyszmbG3Zw2mh0SoZGg7ohwwMVPI=;
 b=QoAxaUM+hl6aKmxx7taTRpkHKI2Ij4FJEbwj0Ih8e3Gy+PPmzp2NNzdWXTo0YMzqdHL96VpY6GBnV8PU55D4MLKRKedsdlb0+pdTU1SNVIbyLkb9h5NNeLXVlJXfL1A/ORYK03h10Cw2Qpp0evycbtGolOc5VpUFBeSBGnUByiYzDMcLIOnkbwjIGtNVx9hl6toIQ8b5J/LCQi8felJ0wz+ZhJFEwueOcjTKDNwRASz0w8iZWw/g/UnXcmwsT1BFm6Hxks/jrF6qQ6GWYz6tC6hM4jTH5EOpCWQQlYJbt3A51IGM7cuCXu13u1p/iSrTZBzSvwV3HDrsah2ughhycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj5AV5yhLvp46POzyszmbG3Zw2mh0SoZGg7ohwwMVPI=;
 b=XNPHDmfbMdSY0xZq1KhqTDH/WBkjut5E6rO4ZN2Fb1uDILXYVLmXNKRX+sgpaX8OBJAycMitfUQYNHHnyOg4yNXZGxKRfNR/SkuUclZ4gRyMb/w+eKe6iNjT8V99st2leiCVq7fZCrNvytuTit18NluPfltfd/EvFIRppJIjEYRRkOBez9RhEPfokcPkPHJeSb2nCtutMNeUyxMxaVP2QxpLTTiHXmI7H0hqMv/yhVtyYLcNqAi9hZ37UiGqT2l0gxxEgOxPtDsaK/BrA0VmBcyEw68Th2uGV62Lj+tu4CSjj/vW7RlfY4rn0vaCshIsNcPLD7ckipcPLXBq9XmuGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6598.apcprd06.prod.outlook.com (2603:1096:101:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 01:24:01 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 01:24:01 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: fix shrink nr.unqueued_dirty counter issue
Date: Fri, 12 Jan 2024 09:23:52 +0800
Message-ID: <20240112012353.1387-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e6ab72-a756-4aca-68a1-08dc130d2872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zCD65CI4UscfqfeOY9mXgWl/n8ORKX+WapqeAuEiPKFSPV92JeG0kag5K5B4TnpleBq+dugZHGXWH7+BQpewRiC4DFgaxLxjDo8WeyoIP9pWBIiwK5lvUO2cGoSL0cmdhBMKdHuyiAl8auBy7mp8RGMRpa0NQliFLmw64WyhUKU9/vcyWUMzwAOYmMZGgTwwQQ8IMO+hoVXmpRWXIn1iT1e1MrkhbRwTwnHtdhfXNHnphQHngXLu3sQaBbur5Q5vpsBJuQedgfW2cmheMYAyeUDEdJmSv8NdFOkanH2em9JX/QyvYXKsyMEt/b5GtZ71ZWMwsIG0k56sKyCY10jpsa5WpX5+Ge0HlL1JoFEAzGBgZVSvFkUMiyoMPp26gOMTjF361fV8UYS+Y9iUf+uwtBwIS+oMPWaSnb6H00uDzVj/Kfdig/DQZYMnld5VitASPAzERGTsLUkkFyQxrFLsfNqoBwX5nQatO4xX3C3pBOITE3Y34Kn5N0wg/kHUfIa7kX3yw1EugJiX1jxc8KCPLyDxNJTDwmEeQkPObEf+PBxXS12SzUmLAcdY9/euuD/qMW0yAYekO5+1YoYvYYAKRu/2+85rD9wsZdLf+wTxs4p0DTv4PL9bYpa/VzYJZFLSPRJ//Yij4AnX/oJaa32bDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6512007)(6506007)(107886003)(38350700005)(52116002)(1076003)(2616005)(26005)(38100700002)(86362001)(36756003)(2906002)(8676002)(41300700001)(4326008)(8936002)(4744005)(5660300002)(83380400001)(66556008)(478600001)(66476007)(316002)(6486002)(66946007)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHBhe6hIee+uPIpL2L12/dKGsgElbsdAfLeKMtiJQg0TyCJ0f1tesydN/DSx?=
 =?us-ascii?Q?WyhderPugKJtVkkUuVrZ0YP9nmjm+d2mGdGqR4XixHmkP6n/jiaHVMJ6TTGA?=
 =?us-ascii?Q?PsrrXuxIaelemWQNuJQJVi1Rjzg6z67nOCLGA+7uhd8drX4/eS2440G/JNr/?=
 =?us-ascii?Q?gjwcuaPesbcB7QHww2KdDMGMAk4l6LXLkcApGporYKXWCuGI5U6WjuNEfoMp?=
 =?us-ascii?Q?tzm7Ho45X3hZfVpqTp4L3ZPMmNxn12kLPssSz6dn/61R8+qdOTQpN5wS+35W?=
 =?us-ascii?Q?qrCi6ySdbsMhy+lWfx99PZCw1YmMpBaVMaUrwRs43hDLf3oxTtULo+vWJKq5?=
 =?us-ascii?Q?xURIN+Sw9N1txQO1YzOMMO2e51+miSiNLtxWdjg2QG/XGO3FBH9LubqhFfmh?=
 =?us-ascii?Q?YiU5KzXCqt4P3ZcZPJjWnhcBd7khL4CW94fTIEkVEXcPRrc1innzxipVEd6i?=
 =?us-ascii?Q?OCPvDqnZtmnik3igf/ngA0YmQYDuHuT39pewx4SJl+hs6gRslvKUSOg6n8Uj?=
 =?us-ascii?Q?JKVVWZRKAmlVdvtmQYftoFuHNN8xAUpXpY3UkFJ/eG8/aaxdTEI9/r6ZS/C3?=
 =?us-ascii?Q?LzEKTZDE0tBY5T4cH+ADkoXBbgRVmKP1lvMW5bD/iGn3dfASSXoKcHRz/zB1?=
 =?us-ascii?Q?1mmFTxYJeHl8lV/h9CkCmWEdJiQThJBNsB8ZKVPDbBlFw9RA3wPOdhnSvO6a?=
 =?us-ascii?Q?p8iuHY278l2TiAEyD7vL+koaIKx0ZGbhEbXGeoPyXW4gRV3MpQmept5HywPO?=
 =?us-ascii?Q?xHap3Yh4I5rTN7xn5FsjL6mBWr3yc2ezUhkM1Bsf07Yy8G1XsJrZ9SdjZa49?=
 =?us-ascii?Q?XylYogbyPz2bxqJTxhprEMJc1BHLeoqYCstboETJ/WQdiKFcUFT6fkgIJILz?=
 =?us-ascii?Q?cuVsGda0kUNuqs7yhvqhyC1HMFxh7Op8v0JEbS00US49WeQZtJ1sP6u4zRNm?=
 =?us-ascii?Q?0YVhGstYQiGgfs7XEh/bFIcOitiLZH0KJfQsFX0illC5stpK7sZWKPqkYnr6?=
 =?us-ascii?Q?Zws2Y5gUT1M1r9gHZnG3wAprYrs0uQXirT4ihDZTUMU0iCLU3yVtE21urHud?=
 =?us-ascii?Q?+nrHqysaolAmaqslENo+9RVNDJy5iFvw8RTu7Y6dxMsgDmbMqglVGL/MpiBb?=
 =?us-ascii?Q?YhIMm2FLYdPT2PeLFS/OCxwMdb6wGfRGpJwX5mVeDkctCs73t2RlkZ/vq83k?=
 =?us-ascii?Q?6P6ZPRSzKoMmuvFFi8lN8tmj4djxCey4DFSWQwOiHd/z1TuD/pErViMjKzYG?=
 =?us-ascii?Q?UWzDvOvfb0CFMOI+lF90e0GsnrWdP7cY6i8f2zzIza3fvJuJJNb0j3xowpPT?=
 =?us-ascii?Q?vD64AEaSR+Yh3tjn+w6wcq3b+/S4FtV8PnJhfUUp2OA4VKSarB0Wgk4TX06X?=
 =?us-ascii?Q?mPjFqt07kSl4j41ylvwcFYSC6j6LOOtJNA4FLwTc+4zVZ4Xk8ODelmQHWcTp?=
 =?us-ascii?Q?EW1gMtB0hEbqVAAMVDBl8MuecYQlelCL15kEWtEWgDy0HNDsKW4yMVFm4ao8?=
 =?us-ascii?Q?TxheixfTbRWXTjDkIN/r32Id+AVID/V13+Fue8DeGHGNkfGEOD0+0T+mdREF?=
 =?us-ascii?Q?BAZLYv/vt2OR9L7fWWiYx6hl0M3FP6Xa+knGDevH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e6ab72-a756-4aca-68a1-08dc130d2872
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 01:24:01.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfL0iQRmE4B71HE22yj9SBpBXV6MlH2Dv8HuThwbog+1cPgkS2mPaJK4/J2fzorJlhHjTWXLI4b4Bdv60hD4Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6598

It is needed to ensure sc->nr.unqueued_dirty > 0, which can avoid to
set PGDAT_DIRTY flag when sc->nr.unqueued_dirty and sc->nr.file_taken
are both zero at the same time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91e7d334a7ca..7c0cd7ecdfab
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5957,7 +5957,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
 		/* Allow kswapd to start writing pages during reclaim.*/
-		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
+		if (sc->nr.unqueued_dirty &&
+			sc->nr.unqueued_dirty == sc->nr.file_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-- 
2.39.0


