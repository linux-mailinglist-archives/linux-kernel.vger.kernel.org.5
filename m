Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F077E645A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjKIHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjKIHbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:31:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809592582
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:31:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOjZRhEQijlMAlpUZPUvQidG0fPXdH+wpiLqgRvQRUGstf1AY4e+XQWcz5ucAmRtn0JWCMyBueLH+TKPjFN/odOD/yDGjwoy0fSc0TTjiD4IWZksJPaB1iJgOv5CeP7g/agDBxrViBe/ICX6muiTQ9EmFgpOZelsTBpzHJLfLs4ieDrxtLwD8VabP2f433TmT04S/JsW6x5SDuivYYLZCWjcwBwSa0aTA0CM5StAtC/R8YOqQIdqAb+rdadHxNIcpx0mEo5nPVLve3DvexYs2Up6+9uAmIMHDIKjKS1DW/Psx/JVFFxL75Bmqg8bcPSTP8fOZRwQcGD8fD4OkLv6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLJUZqO0wkBfRI5tWq/EbvA+6ceM75bugAlYQzeQXzg=;
 b=OOJGJM103DpWtj1ko5/kZO+VWQ5nSH9e7CCEb4FKZUZRlKqxkO+uRVT0IYSWQ23omTA1GoV6/KQnHBtdqlROifTGyQ6cMBXVNHxnmnU6ZO4DpCnVW2/D3dHoh9ypqRQYJmriGJCJSayBuk1AjzWgVzAnsb/R7P2g/a+hdc9BZmnd5pdzN49wwB1TsxzKXsypZQEx0nY3PD9VKFJRhIhY44LTknfopx5ZS9cu6X4ar029iSd07bctxgDdg/6r+y8EfTTr6+55g0RSW447uPHRvXca43HluOgodb6ivwsBlHcx/pSFnXzsb6Pt+RLXlwLPrqw4xqNJ/Mbh4kpWSpL08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLJUZqO0wkBfRI5tWq/EbvA+6ceM75bugAlYQzeQXzg=;
 b=gRRPwP4QgNI3Ri+O3tDS5apOfqBe+S18W7GX8TEKs/DmJkwTMX9kIzK22ydSX8Dx1N43L8Yl6ZYIpvzJCSDwQ0tFI1+aWVo3TCddSzc4zukeGpwYVMaEOCy6RTNNb2Bh/NzFjy9upe/PcaIJS1Slvq8z9d3a2yyZcJhV14IsXANPnsUWYbCaozTU4kAM7z4bJpuAaEIctiLZn5Vbv/ximf9s3cgf77w7LF2JS2S1pg+4aVWhziq3uinN7ipaxIIwIY7AIAXl9pDBxAZnQdjjHBqgZ8gLQNNfBhhzKY1n1Qb/36gicDHKZkYPQ4us4uejZQ4FpBmphbrmsKcuImGcLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PUZPR06MB5933.apcprd06.prod.outlook.com (2603:1096:301:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:31:43 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 07:31:43 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 1/1] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Thu,  9 Nov 2023 15:31:33 +0800
Message-ID: <20231109073133.792-2-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20231109073133.792-1-justinjiang@vivo.com>
References: <20231109073133.792-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PUZPR06MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: eba322d7-08c8-4bf7-0690-08dbe0f5eb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iw2M49gfK1SDxOKSiGKJxyCCU/iUQL7JKnS7az65DHnSTNJzr4BEwCtkG6m/CfdLAp4L7IMZuRoHL7NsrIyEN0ZnZMsqxrBxZwDDNBNxMmoNFuwfRezp574ZsDaEbhtTdoE/MZygKN5HjDFjU5brSu/qeJ+GP7lpGpMp9yzMh7TZIIjGY55VsT3hAS5824kHZdIt9/ufFvCBTU2fZlfVdF3CYcf8ZqDRkZQvEBONLCKOOY7ov8MVsTp4rGBq1MBJcBTrv1T8R7cBv8dSwC1V6ytpaC+4D/fC+i6R9DQqPkmy4i2dLyUjAR+2ZRzq12D0+ced96QGNYQg4M0M776M8d35EHJR6YhPdQBbwMsDdufUDgDGtkzV6ZI8SpWprxDhGDdANoaM4L3P2ohhH6Z2jN3QYUZmA74hnqK/SJBTAvegl+JnIDIP3K/IuvSnXvjsuO8vVHCWH+3zmWc7n8yoQ3hH73xY+OcDMGsxmN2eQ0s7UgZwtnfUbhq9MdCDtpkGw78/DeA0wOQEoS3KREeM4U1RcSx6dwvdDhq0xLu0IHbZPegjatpwaPfP0KlmfdOCAde7ksqqLyQRegrjuPhffHJyBgN6GpzN4iReoh+3RWzFG8TTABFSdv7f30yMidrs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(107886003)(41300700001)(6486002)(6506007)(52116002)(6512007)(2616005)(316002)(8676002)(4326008)(83380400001)(8936002)(26005)(5660300002)(6666004)(54906003)(66556008)(66476007)(66946007)(38100700002)(2906002)(86362001)(1076003)(36756003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uaThiQEL6Z7hEzoSRHgs9w+rTCFyK6Z5Q7hsMZ9ayWF6GEG7DajqDxGfv6yq?=
 =?us-ascii?Q?KDk3tQRFjYRJ71TE+taWkdcO4o4wTSqnvsi5QyXJ7KCOLR2QdtxyBXxeufLi?=
 =?us-ascii?Q?M9YB6DBNEW2fxLTgmiosOz7L603quktjClvMk+SZRm4sTIGDUFQd7fJ86C5g?=
 =?us-ascii?Q?iFjgC32u34iVTPa2CIyIgnqw/Vdvh4XRN2JPdzFb3BqMIUyRxP9AcPHVuX5/?=
 =?us-ascii?Q?qfvhrZE1Y7kp5iN0oRA+xvhT8HKqw8sx92JRQ5iuOaVMamOKabiwFStOr61o?=
 =?us-ascii?Q?RSb/0GZRYP+F+hH32+Rb+9QspRjZdK5RjnrcEcdTbgpecCAyWmwVOzNYSl8z?=
 =?us-ascii?Q?IZbgQp4Nc5omU0Na5MbzSIbUly90b5LA0wwLs51fR4dsOqw6CuGLMXPGl5Ok?=
 =?us-ascii?Q?Yjre/m/q7OhsQddmrabNHzj87ub2m9rGQyN0D8LLfrTGc2sSKb5foB2izVWS?=
 =?us-ascii?Q?9UUaPs1RFBBmdXjvlPZzhrHHDEDAr945sS33P+h/qQPSDID/1oKy1BcbZrm/?=
 =?us-ascii?Q?isuZ5RtFlp4lhsxsCvSauKLlBtGHar7CwBF1dmzoLwF8gG0ZU30TGcUj8Kvj?=
 =?us-ascii?Q?mdp9HBvn06YxWJazvDUnKiYdzHP65tSBzPXDmPS/n9eCbl65VxN/p9yvL4Jg?=
 =?us-ascii?Q?vTRiHu5pvWGvq+cjT87xkSxUdUnwtZ5OahKYZkxigr/RcBNDmbFvU8eD4R1o?=
 =?us-ascii?Q?YYsiljRNk7R7IYSbdF3CGafbXVwub6vnCU0AN/p+LO+i6QgdaZxzJk5lqYv7?=
 =?us-ascii?Q?T6mJdtujAYOb5ufaLNVtkwxyytXqpFMrgL6ReELBLzctGVG0y1NVR/KJ90xL?=
 =?us-ascii?Q?kw3Zb7G6d2m3zpzs+VEquW8AtJVV+U25dCrzqJroqGcrVZkVeLvUHqlAyRdp?=
 =?us-ascii?Q?0VZp4x6Ijtjb0Etm6T+2kMn6UJt4QHQDT6sWxmHCtgr876b8DvbZcrIPAva3?=
 =?us-ascii?Q?NmyXjpdersQ6xWgrkPdlJqsCb1EQ83tU+YrDPjCp/fOiV1YKH/yX4y/+TbdL?=
 =?us-ascii?Q?RdxPjFkXi6SQR8RLiBP2iec8oynm6N3ewrhXeou/29HnH0LbnT75Dntut5S9?=
 =?us-ascii?Q?h1S9CAps1q4fFftOD5GYwz74eZk+PDh09e4DPzw0Ti39t/gZ5f8cMMm4MuMM?=
 =?us-ascii?Q?+urk9marhit9NOsVgzAJgVWBrWJHd2VW63YVw5PqNGErqZIgpCFM5ZX38gHa?=
 =?us-ascii?Q?F1W6gGigjGqdGgdtMo2rAtr2etjFq3qEsdUNlVGOSO/qunCUK/KXjzztTinA?=
 =?us-ascii?Q?YYCujynBHkZ82eZnafhbLBIsuyUX4LmgncbidRdfeRIu1cHSf13mickhRymL?=
 =?us-ascii?Q?7M9TH1DqemF5HYP6Prepk20aps6uegE4bGp27abOYtkGZUTrT9h7E5Rfm9JR?=
 =?us-ascii?Q?m8CBBEujrgHo/jeEfi27sak2p+6fZCuF5ITZti0Ei/0Z6grtIpAA/MpVTurG?=
 =?us-ascii?Q?77IfKxmt96e5h0VsS7cn+t0u8Z7n4jVypqMkj3c0pMzvOVKGD0iK42/pVrGA?=
 =?us-ascii?Q?bkQnuCieGVfWnEdp2GhW0+SrVn4PXUSOvzabHEDYjZEIVl4iLG84R+Nffw36?=
 =?us-ascii?Q?NloPuE2wxYAwKB19ywEnDlPZstKMWICQYlVC1d45?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba322d7-08c8-4bf7-0690-08dbe0f5eb9a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:31:42.8710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcI/yR5Y/KTeHVH1nCD2ksRhMgvNwQn2BJjDT8LbnKgV++x7tH5VZkDrw0RSa8mxvx+U0c94BSRl+3PxgWJuYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5933
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new bool* argument to pass return flag instead of *alloc_flags
and add the related comments.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---

Changelog:
v1->v2:
1. Delete ALLOC_PCPLIST macro.
2. In rmqueue() add a new bool* argument to pass return flag
   instead of alloc_flags.
3. Add comments for reader understanding.

 mm/internal.h   |  1 -
 mm/page_alloc.c | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 98c14b16ce81..1d67c141902d 100755
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -905,7 +905,6 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
-#define ALLOC_PCPLIST		0x1000 /* Allocations from pcplist */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 67cec88164b1..3c84c3e3eeb0 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2854,6 +2854,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
+			 * it should alloc from buddy highatomic migrate freelist firstly
+			 * to ensure quick and successful allocation.
+			 */
 			if (alloc_flags & ALLOC_HIGHATOMIC)
 				goto out;
 
@@ -2925,8 +2930,8 @@ __no_sanitize_memory
 static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
-			gfp_t gfp_flags, unsigned int *alloc_flags,
-			int migratetype)
+			gfp_t gfp_flags, unsigned int alloc_flags,
+			int migratetype, bool *highatomc_allocation)
 {
 	struct page *page;
 
@@ -2938,19 +2943,33 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, *alloc_flags);
-		if (likely(page)) {
-			*alloc_flags |= ALLOC_PCPLIST;
+				       migratetype, alloc_flags);
+		if (likely(page))
 			goto out;
-		}
 	}
 
-	page = rmqueue_buddy(preferred_zone, zone, order, *alloc_flags,
+	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
 
+	/*
+	 * The high-order atomic allocation pageblock reserved conditions:
+	 *
+	 * If the high-order atomic allocation page is alloced from pcplist,
+	 * the highatomic pageblock does not need to be reserved, which can
+	 * void to migrate an increasing number of pages into buddy
+	 * MIGRATE_HIGHATOMIC freelist and lead to an increasing risk of
+	 * allocation failure on other buddy migrate freelists.
+	 *
+	 * If the high-order atomic allocation page is alloced from buddy
+	 * highatomic migrate freelist, regardless of whether the allocation
+	 * is successful or not, the highatomic pageblock can try to be
+	 * reserved.
+	 */
+	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+		*highatomc_allocation = true;
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
-	if ((*alloc_flags & ALLOC_KSWAPD) &&
+	if ((alloc_flags & ALLOC_KSWAPD) &&
 	    unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
@@ -3218,6 +3237,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomc_allocation = false;
 
 retry:
 	/*
@@ -3349,7 +3369,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, &alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomc_allocation);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3357,8 +3377,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC) &&
-				unlikely(!(alloc_flags & ALLOC_PCPLIST)))
+			if (unlikely(highatomc_allocation))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

