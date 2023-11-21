Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334567F26AA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjKUHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKUHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:51:52 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA141C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma/r2WpG/p2BgocPVKS/l07J7rXa6lXsqlKcSc5x9Ty1f2v7B9+Dp/Rne128iFajVJoh1jk2gv25qYpO5PU+xePhcFEMbYABobeGq1VhFFdF1EnPYGP+0q3DQQf5jcGEEp+eCKRVK0YMrsui9F/5uaNPEZrklbOtQu/ZyGMZOQfcLprVfef5/OphalUlfVS0WSWcdmPVSGrTaT5ud270JyGaHPL/P0HoeF5B4bjf4El55UI8PPTMGFz/Ypsjg6ZKk7Lm6jbuZ0ZS1fbNecxDwW7YJ3wgHXvmk40wH4/jJgwAXDRIWRqwnBFCzzHYbrJgk6g8tqcPWMH+Y61ECRBNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqzKcYNIn8Nxi7uzfnlcZAemNTobvxLPiCHuepzsLfg=;
 b=Jsbr26j2Aa5LkyBadvRS1AlOA1Gv/HRZh0Ch1QCygtBXabEGoaUAIVoGNRq6PcZ5GaSKvDc7HnN02aoxQMJ1buxR+3Mraks4+WJsMR3ib9G1dn6MgIFVL1jeTHTRSqKmgcJQAhBXjCku8RP+Rud0+gkos/w+NKPfKRNQxdV+YwWr3aar7Vj4B+2KvvQfKGug1SCNILorSsC4MiPXlEw/BgbTOW5V6RyTsL9SREe7+E3LF6RkzlT8SBbSTHh7s7qs73OsU9Nw9nFBu+H6IckqfpGjo4TbUaTcFQWUArCe7nn4CBwZvME6dlE1Gev+WvTIStp913g/KN1aOTl1HNtuFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqzKcYNIn8Nxi7uzfnlcZAemNTobvxLPiCHuepzsLfg=;
 b=nn8OhxV4qLZ1gaGiG9nvd68u1m+Mm7KjvU4K5rDkk1hWl0msJGKqu9MDr7ACRWHKJHp8kZdZAOiPvWUTMdH8by2KPb+ajEHCI5ycgqEFl5QKIDAEmCbEhQa8vyuuSe3xQT/VM8JcEt4/80WfTAxG1R6XbffCss8X5hGzSHmJDuLiUmIbrwtw4IlWh2UpAScZu9+KIdzSsLkQ0yk0DEJrZj9qm7BGALwzJ1c50f70Qsd+Vn1VW+B1Q79nIalKzAAPkS7nYtmHQUZ3CW4xxFVUDtqipmcKPZZeEaOxK3tseWrLC7oJnl6Mo2TcxaDqYF2uECH5LW8PzE8WGUlFgG+X0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5900.apcprd06.prod.outlook.com (2603:1096:101:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:51:40 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 07:51:40 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Tue, 21 Nov 2023 15:51:29 +0800
Message-ID: <20231121075129.1530-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 1556c464-b33d-4575-1ba7-08dbea66b1a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0tNYNdUgHpe8w+KKjPpfyVnYgLTkxB69X3MPxFQ55mRhd84jG8PrkJgNpw60YmC9XNrpS/XWsXsZVa9Qg+cvFqoDjE6+EBiUN65n8v7oFh4OfEtxXIgpRTNfO8J5aqdzZEyBcceGuWq1SsaXfUmlV13HOeqKU8KRxYi3leDWpz7OcgQtPYwAN/+dvc4JLXzNZLSTOkFEZvGjcRagYfpZFi9g3imnS+LtfqH8cLIp0AE/gdCzJ2eWzKhYZDSFtbMWLvEq+5cfZHoMjq0qykTksVgSGWNBYc1k+DUdmp0T+r1HSkXq37iiE1ElekmSJtkJO9xn1bSDaH0qWC6a3mRuArJ1etFtSWa8kYWRV6gSAPlT7cPX0NvVy5EJm/JIhqHoue7wNPcos0Fdel0d67w7+yoCDgctIDZs4AWJAFXV2qnaErZ0GsJ8JVFyNm4n6gkD7MZRto570Ge4rQOeisDMOiA1Gr0YqUPr8tPOm32bERz1P4aCK5Dx30FwR+9Z74E+OCZfvHsUHEkdth+jYJdJvs+q6Mr2cJ8DUHhrfZpmymSkdS8d1D70o5i6IARQZTpnRpoZK7OmMtpYnrm3ghovfOa9CxdwLS6R7/PtMnLPCRJN+2YtvLMonQbKWIhfNQS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(8936002)(41300700001)(4326008)(8676002)(5660300002)(316002)(66946007)(66556008)(66476007)(54906003)(86362001)(478600001)(6486002)(107886003)(26005)(1076003)(6512007)(6666004)(36756003)(52116002)(2616005)(6506007)(83380400001)(38100700002)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tf1YPDzWKgtdYWuQnOtQj54I0+fCRTBAqmvYRfcGDDn69iYqtIkbQtRqZO8m?=
 =?us-ascii?Q?RREtw2cj2FR8/jzR7L/UnkDFYMvVmSPu1ClesRo5toyNgXolCL7IJEqC6Ajo?=
 =?us-ascii?Q?U7vdTu8OEpfTUv/NLlN8CImvKwVZwb4/MbM8CHcLwIOBP06aSczd7KsBX7ua?=
 =?us-ascii?Q?I1jogD64TX3gOUIAMvLkBpDHPYUcefjBP1zPaM0SWAs6xwdoSwGHxdVFd887?=
 =?us-ascii?Q?UU34SqtkF7LE1RVMPe1gJmARXyOZA/Tn8k9GSxOwDiuOUzcN6Q2IbB9sCU4i?=
 =?us-ascii?Q?hEfu1LOwYUvQZ6izY+iL1KNZ6qwgjNZgX7cZi4rOdiEgKwnWUugAz0ZwyE0D?=
 =?us-ascii?Q?z1ENVUxtSoHuNQE/x0RKDHzooOFTKmbHonek0O5I4lDI2owwDVA8XgElPysi?=
 =?us-ascii?Q?7txoTDeQ0XvL1XpbSc86TDwPq25AebiGdr4lfMXg6PEB0cbTUORtalEqjQRs?=
 =?us-ascii?Q?Zu9pS+MiB/jyjKOHPcfYukNQ9aUw3UUHIppp0mfZ4BEyyLVjBru3gXQJFGqJ?=
 =?us-ascii?Q?gcRvKW6o6kTdeEQ9lvcRtgjkE034rmQmqaXspsZmXnuO3NPhfrGG5Osx54/b?=
 =?us-ascii?Q?eaMF2YurAWiDqT0JWff1tAOxvoGhyhBt1DJytLxrIQ5YBZGvCPD9h+JTb/SY?=
 =?us-ascii?Q?6aJbV2PHuaIKuJWYJAft5OIkOQHZpMUAu4cp/jjo0ptzaSqvit+dDIugf8Yk?=
 =?us-ascii?Q?7e+m72lB9g4mA1qsVKmpR3htRNjSB7PYM6kDjt20vFec5El3AYmXNHP7t+vn?=
 =?us-ascii?Q?fxaRHDVKDQGeY8bXEAJbPR8blQpNt4vRBY/vvU8Hg+0m3yYslIJ0DJI6dDG5?=
 =?us-ascii?Q?bfcntgPQTdTgTzo9NVOw2fqgDCVFPBcZTUEd0N2ljU4fNVya+jLN/aBkJCMk?=
 =?us-ascii?Q?H327QUGBzq3T7y/YWH7RNZAef3bazUKqe/SkAqP1ynSqzvVMW4j+po7xKQFC?=
 =?us-ascii?Q?mqsUhRV8N7hL2tbTpY7LDjiHTiDtCYtA0sKrU4C7Udecf6lJqVeDiNyDTZ/8?=
 =?us-ascii?Q?ysIb25mC/ceY2eMorZIWQjAPVD7xSeJengSwUSDHmBGMp9hltlKgOmyesJHC?=
 =?us-ascii?Q?PE2/maLDJkyVIKK4DcsGkQzzj+30lrKHUbLgf0ZppQ1zouVVB9dkpXIfS45C?=
 =?us-ascii?Q?c1v98SFMGDvsYKvCvW9EWbLvsBMWcXo+PKmIp3RG/lqRgXAzCdlMOmgjN6nX?=
 =?us-ascii?Q?dX5f3C9IXUoxNHq4h2etECzcdhbTl3NJkS8wOy4kWwqS9FiGLUje6JtdX8U2?=
 =?us-ascii?Q?8BBtBnj7jZ8exrmEd8t55ZBpADvEA4UA2/TVntNS7nY+0grlQHrzM/Z//IQc?=
 =?us-ascii?Q?oielwOO+KUYT07zIz6paGLG7fVeWbM9YSohc5ABFIEiVtuLTnjwOx6QxG/ib?=
 =?us-ascii?Q?MAbq/g6Igd2IdjScLnueBOGClqxtb1pnDj/8ACg21LtKOe0LKClXyY7qhxV6?=
 =?us-ascii?Q?vzGePtnEel4X79xjuoOLVtbsULOF+ggBHzGHGQ7gacnV9AqNGKb6AV9sZjmd?=
 =?us-ascii?Q?M82cbnq4fFq/FK1YrEYH4zphW/GtPtt8FYmC7Hp0yIEDPwfDKsvw3q3syx3a?=
 =?us-ascii?Q?WJV29wAEy+HyJ3fG/4HUl2CpewyTfwd6whBCifIx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1556c464-b33d-4575-1ba7-08dbea66b1a3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:51:39.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5DwRm6VAK+Fl0tFWLzSQdBBQxqInj/6i3+BTmq3OPIK1NZ/hR7QEd7p4nAniZ0JDNvSBo+h0Y9tGb/8XGURzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5900
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update comments and modify variable highatomic_allocation to highatomic.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1:
In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
is order1/2/3/10 in rmqueue(), if pages are alloced successfully
from pcplist, a free pageblock will be also moved from the alloced
migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
alloc from MIGRATE_HIGHATOMIC freelist firstly, so this will result
in an increasing number of pages on the MIGRATE_HIGHATOMIC freelist,
pages in other migratetype freelist are reduced and more likely to
allocation failure.

Currently the sequence of ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC
--> rmqueue_buddy() allocation migratetype.

Due to the fact that requesting pages from the pcplist is faster than
buddy, the sequence of modifying the ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
allocation migratetype.

This patch can solve the failure problem of allocating other types of
pages due to excessive MIGRATE_HIGHATOMIC freelist reservations.

In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
freelist size is:
Test without this patch:
Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
Test with this patch:
Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0

 mm/page_alloc.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 49890d00cc3c..8e192c21e199 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2851,9 +2851,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int alloced;
 
 			/*
-			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
-			 * it should alloc from buddy highatomic migrate freelist firstly
-			 * to ensure quick and successful allocation.
+			 * If pcplist is empty and alloc_flags contains
+			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
+			 * freelist first.
 			 */
 			if (alloc_flags & ALLOC_HIGHATOMIC)
 				goto out;
@@ -2927,7 +2927,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype, bool *highatomc_allocation)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2950,19 +2950,18 @@ struct page *rmqueue(struct zone *preferred_zone,
 	/*
 	 * The high-order atomic allocation pageblock reserved conditions:
 	 *
-	 * If the high-order atomic allocation page is alloced from pcplist,
+	 * If the high-order atomic allocation page is allocated from pcplist,
 	 * the highatomic pageblock does not need to be reserved, which can
-	 * void to migrate an increasing number of pages into buddy
-	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
-	 * allocation failure on other buddy migrate freelists.
+	 * avoid migrating an increasing number of pages into buddy highatomic
+	 * freelist and leading to an increased risk of allocation failure on
+	 * other migrate freelists in buddy.
 	 *
-	 * If the high-order atomic allocation page is alloced from buddy
-	 * highatomic migrate freelist, regardless of whether the allocation
-	 * is successful or not, the highatomic pageblock can try to be
-	 * reserved.
+	 * If the high-order atomic allocation page is allocated from buddy
+	 * highatomic freelist, regardless of whether the allocation is
+	 * successful or not, the highatomic pageblock can try to be reserved.
 	 */
 	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
-		*highatomc_allocation = true;
+		*highatomic = true;
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -3234,7 +3233,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
-	bool highatomc_allocation = false;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3366,7 +3365,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3374,7 +3373,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(highatomc_allocation))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

