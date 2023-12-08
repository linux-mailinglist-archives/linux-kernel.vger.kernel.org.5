Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7D80A1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573522AbjLHLQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbjLHLQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:16:12 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2112123
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AshlrKZk8NjsV7QCOjbvOFN3IjEwJZGNT5L0tQQdWpI/BlqmdBlrPCuwAkYHQ6TR2KuH+uOTSWAkFs7bj9/kT40kRg8GWFotUE1Qwss0KAZeh3VRXr0FgNFB+632AHQ98119vDCtJ0rH4W5NnYQngd3HYEKgrQyPqvnvKI5EwHIGM2IB7ruJ7PqHOo33T9vSk9dk5hX1OIqOy0XdM1/xSWspVzZX4DAWOu53aHr82Zdd83UwdYrlBT3iM6HX9kzNmyvXSTM0Sl0+bMzJogF02HyuUQLdqzZ4D8fe+1lu+MksLDRdy9Ki7RE6e+EV8y+xiAfJGGLYJyANJAJSGvbFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjKQu/7lNE4rKrOINmqB8XcW9N/gk2V3fc6oJGqkQp8=;
 b=OEBfnlFqmM+nxD/ffVKk3RwHGRiBDn1x5howSMoAM0EFhh8VGXWUMlk6EMazEAQ1hj8dwS6kRwXVrOk/a6Kk6UZ5N7wr0rQr8+eM7VUikfVVxoJxO9tuFOpVwFIgyoduuVEUOV+I8wRAvkOa/eEmhCLxeOBySYzaIG0Ux36+X+BUyzWlUSux9XriYr5j9ZolWG8hSKmJ64+GVH/UKqAX8ZmPpue5m4oDz0X6PnlmIn3pv50fpGz+uvzqORlaGhpYPGMZ2ttP+6dCtJPfrhAJ/UfZyDDBkF7LDbKjamPUyNiPhsGtVptbGpsobF8ImeM3FatXOATtBJBZcuBlz5VVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjKQu/7lNE4rKrOINmqB8XcW9N/gk2V3fc6oJGqkQp8=;
 b=ibDXPEVmssQAZ+NqsqY6Jiv/zGfKQLkURmyctGjYY8SazmphosqBhTm9WpncxQ4JW2QITK+le5I/ZqbyDgFqSsZLQmLAv2mF7cSNGzAQ+eWu+GeoF6Jq96iel4QOQOweAAd/SZRqYoY58dBqYiryCBYtPIJCjQRF9h+C3PXVrzqxN/CYaXTQABnsG66HY5feSf0OP91SCNOd9NWyT+SMbKi5IL5JiqaCJBYZrvHbA3b6UdZzwk0DohpkAsN8d3EJayPZf5m0J2av5uDsG0/M5lbBQZXJ0R4MJd5eHm08YBsWpy1+9CGZgNR/P9O6pXsAxg4Hp05+U4KlTOp+KwatmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6846.apcprd06.prod.outlook.com (2603:1096:820:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 11:16:13 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 11:16:13 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: fix high-order atomic alloc_flags issue
Date:   Fri,  8 Dec 2023 19:16:03 +0800
Message-ID: <20231208111603.1331-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 90363205-dcf8-4c6e-9b3a-08dbf7df15e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jIz3I5cxfINkMW5DJHP7PZHFaDzbg+7zbyPxmiERi6OuzT7GBXiQPyVwqBbKKz/2R+zgp1jbyhas0QSvPzsDKjB/Z95D+F9/NjeuoUvkQV/zHcaVs7gzzB7xHTEwp7fhBqy2O4pwG9sVv2M9pXEfo8cDH1Gg3C8+PRWK+ESKDDCjQFFafR1ATWvJ1tuipkOC0omtHqsB6hIV1iBjSm5spFPy49scuRDxj+OcdSDT1BYz+anB++zbAsvVej9r904zkrXy+U49xAv89FJ4RsRbkSTG0CYLXGh2r8/aJyKAztdPWUSXxV8YmtzNFAXch7qZcyfl8NPZwrxDUucGU35ZTFxMPF4qDXArlqU6MX5zXUkP431LAaSyU+08ndI/RM54B7vUH6juwo575xxiOEwYDOREDmVMafXDkNo80S1Yz6WFLsnMZAGtRDDR2JN78Rx4RUKyT0BJhDzkZxKVoJTygI8L+8i5thBBMiY78U1E5HOfhOefoi+6jVdfjFphnole0Jzt2ifJE6zjI1lGEEk73D6hGqQPP8Y/fbXHTshvbZN9q2uQr/poTGPSMZEaJnx4KzZichb5XDpH8C1IhDvyY+QeF8Y0/f96hvSbrtWB38m8f/ckPn488Y29gliD2Nu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(2906002)(4326008)(8676002)(36756003)(86362001)(41300700001)(8936002)(38350700005)(83380400001)(6512007)(26005)(2616005)(107886003)(1076003)(66946007)(66476007)(66556008)(316002)(38100700002)(6666004)(6506007)(52116002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?82OQphvqG8DISY4Vukfw3eaiuGGTVq+kssF9sEqPJs9TgU7IJMsXm6J7n9aZ?=
 =?us-ascii?Q?cPfXkTPzt9ujsMn2ZF6Ui2tfL2cGBmarUN99DcI0UA3EHAxKY26PNxShVYrD?=
 =?us-ascii?Q?OgYSI/aWw/EbSTymqnQbgMe/X5MrjaNqfxwub8d0VN/24fMOCL5tmPvnno4t?=
 =?us-ascii?Q?p5y5FakCVIRCr9tLujYclWZ9Vkpvy61tMdm24+K2VV+0sAweZSapfCooBCES?=
 =?us-ascii?Q?nTagUWQvc8MI6exb3pi+KtjKzdUMICtF9ed6+WHvaEVZFRnFTLIyumAz0ce/?=
 =?us-ascii?Q?xqU47IMRiKdajcoW1v93E/Hx1ZDEkhQNzgEReqE2DYvy5/OoIkaqr+u56H8M?=
 =?us-ascii?Q?zWX990rY8Du1NVhGKVY87IVtDcrAfaXj4I2p2vPYOXobLcxMPcO9O+wx6HVL?=
 =?us-ascii?Q?Pp72R/aHnLVkDApHURRqNzOFFht+nTqAKpQtWamUZjO/ykJL5Y+5BwsTyfZB?=
 =?us-ascii?Q?sBNhR+z6yrqKB1aHfsvoDBb999LubXy1sZjwKsp80j6ChTIoPOIXmQfJ+WFN?=
 =?us-ascii?Q?pHbidNa0xBwaC5kQQv4kA5fP/NDWonGS2QPPJ7W+hu0jB+fvSV94DpKUqPqF?=
 =?us-ascii?Q?4mRPxB5OPiBgmJPnTqDg63vz/o9fkH4hnwyGWSLWnp5G/to2Ww2sidz7lR1h?=
 =?us-ascii?Q?mzhTmi/S42HU4G/arG6uy3VGC2NwUbn/K+72555MIcKclhBaWAfr5tJPa78H?=
 =?us-ascii?Q?1Fn8WzCC9rHA8UcRTHYqq+I1YXU2EQ9sNS1o5LkjFvFSjxTypUZCoJVWQa+i?=
 =?us-ascii?Q?LS0uDlZSb2KahC/VvSIg9FrpbP3g2TGOnnaT/MBR/ifrEMtgXGJH15C0tnxa?=
 =?us-ascii?Q?F8xFZu3eiDZ7jOc/b1JOjzcjB+bQR+N+zTLAoPMthy4cORwu0/BTxQYknIRm?=
 =?us-ascii?Q?KzqPvWP3cbAZ+Qt/xjBp0Gu4lgHFTOJqZYIg4M7TzbQDfLKTUSrTWE9uI7RA?=
 =?us-ascii?Q?bM2pTrmxJNrpywIPDqM/whLGKWZhDV9XIB1bPi+GHjkRDU0dwc1B3uLN6pA3?=
 =?us-ascii?Q?W+rnko4Maz0TxTHN5cbEOnQ7f9fCa0DC8dMCEXinBBiYjNhy3Ma9oSQSHkNj?=
 =?us-ascii?Q?cPVYyLFc5drahr0jviaccU2kHLm+oIXODpFcYJgr5sUlXVzBk9WAQNCK/TUU?=
 =?us-ascii?Q?/lLlknbrY88GzogwHq9SecLU+fnb5RDcCAkXxTM5SmybL2Bs+J9sX3zbjbud?=
 =?us-ascii?Q?uwmyDxbc9ZHyBrTNnicMe1BluFodsxIzyoE4CsyREUrRkUACNDTJyZAP5wHt?=
 =?us-ascii?Q?wiXpWfYzmwplUzhWqcqGAm/lQEKlcjpY6H8qoVCXuNHOqeWFLcYec+A2rQFH?=
 =?us-ascii?Q?L321BijtkG9eyVZyQYo8TGYPHv+Q9/o3KYaKc4wk9lxzyjVVqgPIoFlZJJcB?=
 =?us-ascii?Q?r1yhXjsDBsrj1a5PAdtiffdJFZqECFSCKKykLrMvzmFZbvcPUrVOyLmxT4d9?=
 =?us-ascii?Q?uWcL3hOUqK5L9w7PrBB+im3ASB8fX+q0L1LhGyuqEDIHe3xgL4qZng9vYHnW?=
 =?us-ascii?Q?tnf4I4QLTmbF5lyeOH3mWlomrNaoMp/kMxHUddDE6hosH6rBRnmqWBeGk4K/?=
 =?us-ascii?Q?geC/8hLf62xM28Ew058o5Vqr4T0n09ba1VYC9W4Q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90363205-dcf8-4c6e-9b3a-08dbf7df15e7
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 11:16:12.9261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajCwRMzy+EZyMfc7pwonN20qK/FyPF0q5dE4z1hROeRu/tXfZh2yqqtYJEPjhURdARG76nmCZZI5c/d7xWzm/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6846
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case that alloc_flags contains ALLOC_HIGHATOMIC and alloc order
is order1/2/3/10 in rmqueue(), if pages are allocated from pcplist
successfully, a free pageblock will be also moved from the allocated
migratetype freelist to MIGRATE_HIGHATOMIC freelist, rather than
alloc from MIGRATE_HIGHATOMIC freelist first. So this will result
in an increasing number of pages on the buddy highatomic freelist
and an increased risk of allocation failure on other migrate freelists
in buddy.

Currently the sequence of ALLOC_HIGHATOMIC allocation is:
pcplist --> rmqueue_bulk() --> rmqueue_buddy() MIGRATE_HIGHATOMIC -->
rmqueue_buddy() allocated migratetype.

Due to the fact that requesting pages from the pcplist is faster than
buddy, the sequence of the ALLOC_HIGHATOMIC allocation is modified:
pcplist --> rmqueue_buddy() MIGRATE_HIGHATOMIC --> rmqueue_buddy()
allocation migratetype.

This patch can solve the failure problem of allocating other migrate
type pages due to the excessive MIGRATE_HIGHATOMIC freelist reserved
pages.

In comparative testing, cat /proc/pagetypeinfo and the HighAtomic
freelist size is:
Test without this patch:
Node 0, zone Normal, type HighAtomic 2369 771 138 15 0 0 0 0 0 0 0
Test with this patch:
Node 0, zone Normal, type HighAtomic 206 82 4 2 1 0 0 0 0 0 0

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 mm/page_alloc.c

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64d26b723a18..90be557170cf
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2861,11 +2861,20 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
+			/*
+			 * If pcplist is empty and alloc_flags
+			 * contains ALLOC_HIGHATOMIC, alloc from
+			 * buddy highatomic freelist first.
+			 */
+			if (alloc_flags & ALLOC_HIGHATOMIC)
+				goto out;
+
 			alloced = rmqueue_bulk(zone, order,
 					batch, list,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
+out:
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
@@ -2929,7 +2938,7 @@ static inline
 struct page *rmqueue(struct zone *preferred_zone,
 			struct zone *zone, unsigned int order,
 			gfp_t gfp_flags, unsigned int alloc_flags,
-			int migratetype)
+			int migratetype, bool *highatomic)
 {
 	struct page *page;
 
@@ -2949,6 +2958,24 @@ struct page *rmqueue(struct zone *preferred_zone,
 	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
 							migratetype);
 
+	/*
+	 * The high-order atomic allocation pageblock reserved:
+	 *
+	 * If the high-order atomic page is allocated from pcplist,
+	 * the highatomic pageblock does not need to be reserved,
+	 * which can avoid migrating an increasing number of pages
+	 * into buddy highatomic freelist and leading to an increased
+	 * risk of allocation failure on other migrate freelists in
+	 * buddy.
+	 *
+	 * If the high-order atomic page is allocated from buddy
+	 * highatomic freelist, regardless of whether the allocation
+	 * is successful or not, the highatomic pageblock can try to
+	 * be reserved.
+	 */
+	if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+		*highatomic = true;
+
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
 	if ((alloc_flags & ALLOC_KSWAPD) &&
@@ -3219,6 +3246,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
+	bool highatomic = false;
 
 retry:
 	/*
@@ -3350,7 +3378,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 try_this_zone:
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
-				gfp_mask, alloc_flags, ac->migratetype);
+				gfp_mask, alloc_flags, ac->migratetype, &highatomic);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
 
@@ -3358,7 +3386,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
+			if (unlikely(highatomic))
 				reserve_highatomic_pageblock(page, zone);
 
 			return page;
-- 
2.39.0

