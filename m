Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDB7FE75F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbjK3Cps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3Cpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:45:45 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8124A98
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:45:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ew82PnDCcOFMzi++1imtaWRXjxSFN6hMA++gG799b8PUpQbRhnGdpk+FGMXwkJ+SihW5SIAmOWO+QiT/BqnKxOzOBOS12gPEGJMl6as1yfCWebnvSxgcGn23qW1Y6Vm6LZXj41Gn6QZroPnw7D147C7BONjig7plGB9xspEi2jV21gKXdlKj9y7DhTk4oXQpIobtTRYYNrdw2/N036sTdnZRjRcD9oJDIVhQa7kcf6qJg4rU2t0a5rJ3OVfUCa+bDFcPy7nA6LOc60gm7yj+j/HoFS4QMNJiuc+pAZnpCdumbZfmH1MSGsqNGN1U7vRPjlnetmXJvZ6vhj0xAUphVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEQBD5cr2ycjbhXEdl5wbiP60KFmlUctUSQrnqiddJM=;
 b=cbNpDeCqzaeL6c5mXMN8DRLlNH8CGQNDbiwEw0NG9exj4oS6ZvGzrUqDf50Wc6douRdB9k2LbLAqX9y9TGm3I7xlG27xoatj0V+L0qu+DMic98ocoDN3dWmKZ0iG9nZwRlp1eKQS8fp/Aj+Q5r1zRw+g0cTnmi9BN+YXHjsbs8gnCzpqSXK+73QCNfPAAdksG43VBGifyL9iuzTiioeznbSzTpHPRMdlZ3iYF3ZY6wrD/NN5AGU2ynT/LyoGi6vdYyL6ujQITjKtZNPdN7WLooC4CA4jtj0f6zLcS1BC3IxtgPQaj7fsKR8tE0gIjzKb0DhRDX0bcrw0nfDNEv19vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEQBD5cr2ycjbhXEdl5wbiP60KFmlUctUSQrnqiddJM=;
 b=W8rJzdmq5S/34MsDHB0IDEXOoAV650JPPYIDpZ2kzZz2AmbO9A61SO2fZexTna+QmwmiILm6o8lzg/tqZEh6kmwwseL0LQZ47JMXcH1d0Wew/N1TbJZhsHdyro4KMxsbUjRHUj6OTyt/d6QaHVT1W3CnT921hxPrsQgxLduNfKj4E9i7XJXsHRRgwQXhvQHEBqr3oQ9mAFNeBkjCOCs/98j59WvLe4C4KrtDw74mlfcustj3/6lh0ukV3Rp4FLBAnBukh9n+6moGCUlodoBvbjIjzvpPRaslpkd/XO3yD79qOuRALeT7ZuZgGjk+TLNMXhckZcdz/1Eyh7gro69SfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5000.apcprd06.prod.outlook.com (2603:1096:101:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 02:45:40 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 02:45:40 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm:vmscan: fix shrink sc->nr.immediate counter issue
Date:   Thu, 30 Nov 2023 10:45:28 +0800
Message-ID: <20231130024528.2178-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b9d5b7-d192-48d1-3adb-08dbf14e707a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbRz08DLr3hJsIaN5V7q1lf/3x4DPyIF+GeHhOu8tQ+1ll7PxpnCoCYwyc4DYw/WwT+HfmlFo9hBtyFUOAZr7IEIaDm4J36vx6LyKhXtpbSSd81Snn8n+VwaPwoQhaqJn8t6G2HsLNTJVUEnFJAX6XJctLU2uquIBjDGBo9ClAP4PGnPG34Fm1qxYP8VusdoJKqY6GvMKoU9t1MXJxafDT+UQT+pq7Ao81KZi6LZkRMBjU2w2ZS8g6u54YpVviXI0JtT5u9BrhhDszjh8hUQmYljHyurjrVx9L8yVhaFXB52R7dOi4M0d5ivlPaSO3LYN+in+BPNQpWER8n1xkAnRaI2WhlD+VTswxwRoElfcl93COabohphDgKUaqm1TrX35sVZyeH9pNDG4ODiKTmcffni4oSd5VgqjhSJKAB3dJEFY4v93OARuSr4AekRCbGk8AnP76y+qwh69gyjWOweYynj2mDGbEokpsn09EhOkdJ+Wo+n5sBHRyabl3JghkOrHiBPGAPS6zFQabrlLnsWbQbFU7+qylSKkVUG9tmTDY9X1/dINm5IhKVEkeXbj3pwgu4VxPoJiuFm2Tqv1WldU4ero+a8zTWhYC2OU3xXN6zckh/S8M3INBb9F3bOOKy28yDxHTCEFVUJrXPRlu5J4pOdfdXaUy6e/w/b/70+zRv8/yM6CWu4WeciCbY98HKG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(54906003)(66946007)(66556008)(66476007)(83380400001)(4326008)(38100700002)(8676002)(478600001)(6486002)(2906002)(5660300002)(316002)(8936002)(86362001)(202311291699003)(6666004)(52116002)(6506007)(36756003)(6512007)(2616005)(107886003)(1076003)(26005)(14773004)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZM8jreaXczerq4uugC66HBBLkLuA1FvPEQELS/L0KX1A0xTw/LH61G1/cDHO?=
 =?us-ascii?Q?dtlq104Slybgytpo6uY5EicZgrXG5JL5aGRbx2RYtmUxcTjZcUWucsf493SK?=
 =?us-ascii?Q?f8DN6JNp3zS2gqBeuIf5nzYernePfm6hOTVVscGHx/J5B6+nDGo5Ay0MzR0J?=
 =?us-ascii?Q?QV2waLasRJdEU6oh3dhPlc+u2UNbqnvQ98iP/2q0HL0kcsJmjwCL8qwI2CiD?=
 =?us-ascii?Q?07m5XjNwJKdIYraYXWuVcpLW91cKiWoMn3d5rcsKieTaYPW6ubKXvtgbd2we?=
 =?us-ascii?Q?xmSiLCInRl67e4piKLw+AcJ156rFnhMbWsAH9orouxrKwTA+rKwsp8e3Pe3X?=
 =?us-ascii?Q?iEPru9rARvPwTwUk7vMlkA+fF/7oHC1eqCAQfLMmkdyPjZcr2hcpN6t9sWfS?=
 =?us-ascii?Q?KQzbFMh5CEtFDJv5H6XUAh4tECI1Sfki1qk6FVqiPBVNBwdDl8C5nk2hlyvG?=
 =?us-ascii?Q?Jc1LmjQay5AlMEibQp3fKy6xN6AEsheEEX4J04wlnEOaR1kjHv4EF5kz5rvm?=
 =?us-ascii?Q?FnE+HjdloRqQ4Y+OkfPonnmjHHNz0giehiXBOttijYndwn/rWqLTilfZtTFp?=
 =?us-ascii?Q?oZ1HH+SVqLnQWp1Gs1wijW4iyy3hSuERrSPreZI0/8gJVvB2wf3suheBYVSO?=
 =?us-ascii?Q?cxTZ4hlEo81pRqgBDXwTecfz8IyOF7MwH/i5uufzCTwtgyKsMAjq0OHwfOE8?=
 =?us-ascii?Q?ejLrVr0NmNue6J1xCLwrWqndLco0zKQ32J7JDnKgqTKokSmXcuzVjXbuugHv?=
 =?us-ascii?Q?4J3ADIBLV9uWZRUIZlODdFGL6jKXGrgh9CWGZVjZoGYfb8MhVN3EPLhA9jXu?=
 =?us-ascii?Q?xE4bh0TvJpYUOUtcWEgIcQEpXXhpbUgiSMw1rN4bB2rKVrXwK2pydguJhA0r?=
 =?us-ascii?Q?Q1O2si4omS2G0QMIAe/kpd8UQOTFKYYJCrRWECLj+hg9l6dinQYkVZorDYiy?=
 =?us-ascii?Q?HP0RJejKqsPSuxvwqiSbMOw2Bcd2laduZnQNPiSK+Y6dALAGFZD0rqkZTnkC?=
 =?us-ascii?Q?OyN+cETrCjZq9vhOuN5+TqNbD1nOE17tkIczBdhSG5G1PXNPJwyWSs6EiffZ?=
 =?us-ascii?Q?dkI2Qxs6hW4j0lbue9/ji0LdK/9b400D7op6zIi75NwCGraBKgA7C4+XFQ+F?=
 =?us-ascii?Q?N+ybvXEMtqyz6GhJcUFWUk9sPXuYIFVLKNEvav9dMUn4RF3/OsOgamnmBRb9?=
 =?us-ascii?Q?s1o6EumC2s5IJf3CmoAPvzzTXwurTv9tbryieuEKwTcJCQJr7KdCf1B76ZmZ?=
 =?us-ascii?Q?ZvH3IMCZ1Lf210/fIHd17TEtNNEeNhb5IJP96mR53WUr0QHd1QjtEEHr1fD9?=
 =?us-ascii?Q?r56D8EkMMrnf4d3fyi+6RpL3dY+NP5InkPoyacQE4np5J99RbiRFPXLcsQPw?=
 =?us-ascii?Q?YNnUkOjNhMi2ltqOsMGx6TZhn6/Mkj4cMgJmXaYj8LUIRN9nD8E5jdaot8J+?=
 =?us-ascii?Q?23oKb5slyQNL/cBsDziPp7H/RolNv8TjW3B/ZnvAC+tlUiKBpQU2vRE7QxEh?=
 =?us-ascii?Q?CBWwqA+DueEup7jexLutIkN2BosRQSuhXcGFodBIRiYgAnsp+2ov9zpkxqqY?=
 =?us-ascii?Q?vK5o29jkcpCoCp7ZAOPUEVFOkDg0fz/q1ib4qUk4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b9d5b7-d192-48d1-3adb-08dbf14e707a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 02:45:40.8363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QLCMXkFiOCzj2bMpWrFV/jEKLD/mkC9MP+j3SUwqTqrPGmMuQwkbyynZJg3J2Hj25+ErYMMi0upm8gkZOTbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can't be guaranteed for the PGDAT_WRITEBACK flag that there is only
one type of page marked for immediate reclaim on evictable LRUs in the
following shrink processes of the same kswapd shrink recycling. So for
the siuation that if there are only a small number of pages or even only
one page marked for immediate reclaim on evictable LRUs, and at the same
time there are a large number of pages unmarked for immediate reclaim on
evictable LRUs, kswapd is also throttled, which will increase kswapd
shrink consumption.

It can be fixed to throttle kswapd shrink when sc->nr.immediate is equal
to sc->nr.file_taken. And when there are both pages marked and unmarked
for immediate reclaim on evictable LRUs at the same time, kswapd will be
not throttled, and kswapd will first reclaim pages unmarked for immediate
reclaim on evictable LRUs quickly.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 mm/vmscan.c

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8c3338fee0f..af2b6906171a
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5919,13 +5919,13 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
 
 		/*
-		 * If kswapd scans pages marked for immediate
+		 * If kswapd scans massive pages marked for immediate
 		 * reclaim and under writeback (nr_immediate), it
 		 * implies that pages are cycling through the LRU
 		 * faster than they are written so forcibly stall
 		 * until some pages complete writeback.
 		 */
-		if (sc->nr.immediate)
+		if (sc->nr.immediate && sc->nr.immediate == sc->nr.file_taken)
 			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
 	}
 
-- 
2.39.0

