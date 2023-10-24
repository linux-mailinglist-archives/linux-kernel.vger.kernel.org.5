Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3F07D5454
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343674AbjJXOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343664AbjJXOtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:49:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7110E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTUypjs5ro2LV4AvEoNIMCs04z1tPjBDdoHwLcH3qzOHMJlN8WSKF+GbEXCxZeIAvO1puqHhs96yCh8nH9+Zl+JTM8TEng7FYXpqocq7aoPuNxf/xu+Othadsoe047Onjathc3ebLuOcGObbBBxweByAMHkrOuAfw9t7KxaPvmlftIHdyArsNg3x9QsAZ3vVhZ/A7uBXRn7YnMWF7XZ8vRyZS3Lqsewpp7IU0iaN3Aq4qx4L5bpaiuI4HOIix5lj6wrhNQO+LpqagSBZARHJpqCjrjib0Ise+UNfpeVFv1En2BObntwGgylH36K5erhvQhF4yyhN8yS0RwzakKpZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBe3biSwq/g8Py8TGQTypNQHK2W9dqAaIRXgdU6MEo0=;
 b=bfCzSU7VsXsf48t/82wRQwVHCwppZio+0pj42kkSk0LPaWaP9CHrC+vu4XO2EkIksod0LlsSPRiOKS8NR96L3RqjQuwNY+EwY2t7EmhQXzXE09VLMbEZHdnHNmfymRuZkyzbAI6gV4MUrTnHwYzD/LFFyeRf7oaIZGjNUfQm5IrXcInvQxhdY9ITo4guRBv8v8qfIeFZTR17sGDkRu8OMw5PHLY2LHzWCMGFaxCNP5NyLBpOqM4p2xHgSCu1ajjhQhBAUIbi8ZXZnsjoaq+MJB8ELWXg3zulcqX61XtLedZtlQmDE+N84PuUSEBFqxaRgvxj3ZhnIILDwqDGHD9Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBe3biSwq/g8Py8TGQTypNQHK2W9dqAaIRXgdU6MEo0=;
 b=WB9tilSc73gx/u2a4Tbiv6hEaKzoolSJhUFC7AXIrp3LFFAycnSmmtbQ8hOjqbjOyPnZy1BuT2P1DTJqks++M3KUOHwHwaDRs0pXb3GJIhn7lHLrVtGmBnPTSzNgOiOGxdOrwOf75JqDAAI04pprVk/La8IMjxxD8UsIX3rCe558V0sfqHQgPOSSdr9G6JgfRLI3Hg5vyQCTfg38ILqKbQNT6kbERhq/g9Pe17EDWlUnIfPXTbqUuJE6EiDeQT7pj//UiN0B/iy8W76cKFa9809oISewXJeuGHbULYpwt+Lx8KNHtFfja53VSfJYojNDz4zb6XtVxDR5g+TwcNyJhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4405.apcprd06.prod.outlook.com (2603:1096:301:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 14:49:22 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:49:22 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
Date:   Tue, 24 Oct 2023 22:49:12 +0800
Message-ID: <20231024144913.421-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f433359-562e-44bf-167b-08dbd4a06872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgorZcR5DtH39ATUKa8+NIPR66zYVk+9exuYTCWbA8A7Xq5/Lg4tzYTSibhEfthze2u1kNlVzYnCQq6S5PI4JCGjvw23pKFTbmcDwDUVrrgvHbPCkvq5wRWumAvHxQt6vUUirVo9wfCdcBbvj9aQa9Rex7Q4jT6iOrAP3QiVI2ASHAGOnkwbtKF1l2sVeVxQ9vKWFJw636/22Cn8gmg4LW777UyyFbgVEuGFfGqoNaMnImeMBxrigNSPasRYvct5PIOnLa1LaA1etsCAplbwhNQTR0q39fcDZ8NSL8RaBJLuE2Pjd+JSglUA1RIkBE7XdCe/O6pRSW+oNBu4ArE3HTMwoudaZP38irnDc+VC5nzlWebX21POiRZhmaioPPs5mT9/Zr40QERUcwnDIn/ElpCjMb6nO0uv6nsTWVsTpS7B4C8uqzsjusY2mvLM0euDaY0q+HpnpRUSQ/neYm151eSeCdJIyWqWJm1acH9q83Jsna1GVfH0cuKbS/lRRQ2L6Tv74FzhwD46XBv2aQeDgx+jF9dhjQqPwmCzvSpCfU9/VIsvLTYl9BfbKLpFXYe4hh2GskCf/FBBt8wFYuk4dzq1G2riCrJ0OB831ie8HZEfcV+bmEwOSTs6SWkTvMC9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6512007)(107886003)(2616005)(1076003)(26005)(38100700002)(36756003)(86362001)(38350700005)(83380400001)(8676002)(4326008)(8936002)(316002)(66476007)(66556008)(66946007)(5660300002)(4744005)(2906002)(41300700001)(6666004)(6506007)(52116002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fh5J0CybLbq5JZW4MrMN8RUPpdZ2RxgccoLWLY7jZwyeJYcoClG+hVN4fd1Z?=
 =?us-ascii?Q?VsP0dLb+bkphe5LtWYh5LewQv+P76i81CTSoDyEFoxLAX/Oqe4jPdU5/m+sE?=
 =?us-ascii?Q?zZKdUs60DKez0meMxEO12iUV9tfddzK8KrF0/S0ZEXPOUU08lCx8RbpSlHzJ?=
 =?us-ascii?Q?KYI7DDUZ7xjb/uPmJ0oaeWZGydUGxnKXmZ5I1n3k2XaEmHvsCHle6Ik+javK?=
 =?us-ascii?Q?gH6XVRMJTBC79R2B/tpmWP1xeOmlB7HodrRYoTVFiTUve5f/QHXqtO+HIRy3?=
 =?us-ascii?Q?hhm5P7uuLLOltpxrAVqkF0yD38rYCBQJMktId55WvD5kbA/ydHc8ra+izmK2?=
 =?us-ascii?Q?XEFbJFdlviTyO7T1Oss+9L9evQ1tRaw3NFk9QoIuoAnmc86J0NBUDsQeLkVV?=
 =?us-ascii?Q?AMxShEFMSP5mSshuKcJeV7EEGSU6SA7pcLJ0s35ux9P0WzI+BcYqzvucbwqn?=
 =?us-ascii?Q?uHdN752GeAg+uccdOMk6wIf/6eh0sQ+jIsn/BRombdPsB3fcrs74j5QQkL/Z?=
 =?us-ascii?Q?am16ohMFxtuI8KG/i31i+sKJaXkrJ7UaUS6fKEOsaZHxIHbc4oGdSE+hJ7UZ?=
 =?us-ascii?Q?fAOedPpBqGp3A8FWpYCAKLitW0TQhJmYkLFah0cUCq7TbbLnzfIY5SnK+hXg?=
 =?us-ascii?Q?ox+Dr5ww6zCcIjqH94kzG54RWdn7CZlYXSSbzHIrt8+GBUDdhout9+sL3f8Z?=
 =?us-ascii?Q?z/au/X5EapEx/9hFx09ZDZQMCtmS63Vf3sl/rf6k9B4JhnmI5GiOvregG9Ai?=
 =?us-ascii?Q?eSqvZlsWE13MIYlp3TUNzTeVX4VgscugZGWuSs02UdrUgBNf72zSVYDHX9t4?=
 =?us-ascii?Q?Fu7PrAEOWqzetD7ddoAz7PVQg4NJkHAoE8vRBMN874rCKiZpYliqCFpTK6CY?=
 =?us-ascii?Q?aTHl+FteiV6kMloTJegdru5hbgLzOPJG3SKJnZjBN8xhBruQr/ermHfkbtJX?=
 =?us-ascii?Q?zzLMhinW1qnve8BJaHQflxUL88z0m7tWRa9uBTkV8QczDQx90EpwDhI+m0Hj?=
 =?us-ascii?Q?KtB9FoibeM+CvekSoyQNae5R73WV4n5mgz0QoiM3UlxGI3l52kCZjBZ4siac?=
 =?us-ascii?Q?XALePvy7AtsMO+dy6u57epUBlvM/tbR6PRv3foeEUr5mTySvYS46Hxi4yLC1?=
 =?us-ascii?Q?c+9PH+0flLBKPAZJh4NgZNI8oV8pnCKupPZD38HAM7rJ+usTOXRrexLDRQv8?=
 =?us-ascii?Q?0rPKfCNzLjSH5L1tWYE1DlDFR84ugGGffOewKK+/ZjuuzdwtQCFED3NkV7k9?=
 =?us-ascii?Q?OgFr7LpJp/CQ9QKRWWC4vUro2j/jDd0HW+bTG/ZoMF4x9xWsuQajvRCOuihq?=
 =?us-ascii?Q?zB4f7MjFzGf0v3BTXptYtTecXfQCwl1VpDyIafcin8fAg8Nh8yRYmM7dAkjX?=
 =?us-ascii?Q?sFdkJkhoOfo0hr3a12vEkB1B2Y60U90JcqqN5SPZSNSwK21lXJRUI3gif4yX?=
 =?us-ascii?Q?vD331FfrIfd34QvhE7WD+d7oIkUaoOw2DlU8k4+qjUrgQPOsXGzoZQAwMU64?=
 =?us-ascii?Q?1DkhELyoId9kWCRmonr7eReWFMZX9CRalT4+ufBn1H5dbsU7x8T9pYe3LuXb?=
 =?us-ascii?Q?QshbGqBoOWroaltmVrO5Jlt0dQ7xTSBoun9qL2NR?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f433359-562e-44bf-167b-08dbd4a06872
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:21.6986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33Bhr7xODsbYO8PvxqbkZTq0xJ6C1BX7sIhS3py0Dm0AU7CXbKzI82qpadns4VDCz0zvu0kmN7Ba7b+c9cIFfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pra->vm_flags include VM_EXEC flag and folio is file detected in
folio_referenced_one(), the folio referenced traversal process can be
exited timely to reduce the detecting folio referenced time.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/rmap.c | 2 ++
 1 file changed, 2 insertions(+)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 7a27a2b41802..932f3b7e8521
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio *folio,
 	if (referenced) {
 		pra->referenced++;
 		pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
+		if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
+			return false;
 	}
 
 	if (!pra->mapcount)
-- 
2.39.0

