Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A1792C08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352693AbjIERFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354894AbjIEPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 11:32:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E59133
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:32:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdkKX1aOz6+syfWNpBc8W7D0w585otIoCvzN1N1/9+a73waJzDUgztS2MHccuLBsCjUigXnWoRUoy0PRclKI/45D6jS6aZhgjn6NacAcTvN/EsWCS5ZFG78AZIpk7izCexnsVjFg3zyJ3rrVWKb50ghcNDN4QIWTbsJqdFZNhLaSErIdRR4rTL/Guj7b+vJI33PvLY2uhL7ZilgHmxGsO/Wh9Qa5ArPlhNxQ1cpfsP7jxBW/UvRFJaDc45iP2Bze3F8Oc5fjuIXnhg4XO1verV0YBsdN5uFfIk85JNbcR58wJd2EW4ilz8xpnwOLz7FiWK5Aj5D1AUVtTWDnbC/1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twHlCeM3dnAe+HvNVRTTveVWZyZpck98tJZfZ6eK69w=;
 b=aABajT33ViJ32X/bQCEROm4ih+JEJgQ6lzn5ADpo5FcVIzsEKDbROaEI1dUy0Ddm2M9uDpR3kfzbU6xq8PJaMgOTv29lVtNPUHUN+nnpSMLxcAcgtPuN1FfWDcCgKNpm31ifbZYOkunU10viJFtWsSgsJJfv48snyp3lAjgAPPyZnRwuZ/tJcxS685k9nrMY9FSG+7cq44GJyfhlZRPxUUNc266w//EAVoRzNIeuhN5wog0dDDgmFxVm8fYxrRDtvpIHO6f2yJ7mJsEFMZLZBoo/8vEXawzH5tLNFhvwW5OhbPROFAhXN7MkXg2TNNhHQJ4zl7R3JhfDRLj5xby1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twHlCeM3dnAe+HvNVRTTveVWZyZpck98tJZfZ6eK69w=;
 b=nFPPrOiC0E/IL3RQC2YkjzhNJ007kTUxAoFtFcY31b6npdG87JqYbf2n2axi9JG4HXMChEQo7S+tCzpsSNBVus+jute1lBF1s6OPfC6YTvPGeIqfGV7U+VMnO1/Ummb4l4mrAN0YWS9nTV0bxHyMCX8I5SARcswB62tW2YTPDvX3sTLscuU4+IVbzo6os9dzf56s/oHICBgWJ22xcr0rvs+NwkdXvGQIJ+8NXlWKuZ71NuvkJBUp3Iwmgbuxo0TRaBApGoJAnncKj6skRmg8aFFoi33rRL2e4NNfYesumtX0oA2W+0fEUEQI52tCFsayXrFN/kFw5uoUyYhSLDr/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5864.apcprd06.prod.outlook.com (2603:1096:820:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 15:32:41 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::832:19a2:2f83:1cfc%4]) with mapi id 15.20.6745.034; Tue, 5 Sep 2023
 15:32:41 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: page_alloc: remove MIGRATE_HIGHATOMIC order0 page
Date:   Tue,  5 Sep 2023 23:32:30 +0800
Message-ID: <20230905153230.1291-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: ea812e3b-3175-4a7a-ace9-08dbae25576c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OY74F2PnK80M8J5RKwmAqXhKb6rDxnfL7Li4CJLUo8I+SAMvtZrdxXH44p7IiklsN+8FPgjns4qp31K5iTpUzGtqC1PJyjns4ScfdbbbMzP91GNB0RZoCSV8LgZsOUedQL3G4ovl0bsi2gB7ZlY9KyGDNuPKkekScfY0gDS9ARmYHMHJBrmy9Er34ILhmXUZ1jGUxq+oD55tAA+MRyKc2vphzM1ze2GrE98LE9gNXbHtA2lNyzLMTRtALDdmqRJ9ph0mIg4P5leBj29om+GJtykh8DTJEa0vyF0FahPPCwXfUwefy7LGxu+K7KrBITQxXA70p7iStjTrV9oBck1K7poVGomRr70w0hdIrJ1k+bmBZYvmwlsdooIqrwICzeeNXM3PyjJQbJ3vQWk2Wxu3fHPU6YefGzNYv3gLAM7tnbXYLvQB6m7iM3LtljF+raRYa+E1VNb1v+uncrOxL+6i2/25Td6V51zHP4hKqAsCiPNx/ZT6DctMKx+N6QUF4qEnjdTk8kHbAkTgadPu8BBOVGVF+DkxLkxUjZAzEF7JztGAAK9WrDrBTzqvFU/+PQvAGK0IwMRRwC2zFZuOrp0AAuxj7c1siByE+oOYcXvdcoCjd3ExCViwXRz4Kwe4wQkx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199024)(1800799009)(186009)(66476007)(36756003)(66946007)(2906002)(316002)(86362001)(66556008)(5660300002)(8936002)(4326008)(8676002)(41300700001)(1076003)(6512007)(2616005)(83380400001)(26005)(107886003)(38350700002)(38100700002)(478600001)(52116002)(6486002)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I5pXT4YjO9okdubAY5o/KMbXMB1uaAtFpiT85WcRW8QCSLTb+7Wue5pwzNPt?=
 =?us-ascii?Q?6O20lralrejL2sgZpejGn0j6CuMyWaczScXDHuxsUqdm30FpE9wueEGtqQwH?=
 =?us-ascii?Q?26LTtkQlpxbJTdfRJ18lHhg3VwZ4nhdEo18+1V40kOf6MhM6yfwWDOp6ywij?=
 =?us-ascii?Q?MlsKRNNIUzpT432we84+oR7On7fLGBxGHfOYtJLpmw6zQ27W5dQYwc4fEx89?=
 =?us-ascii?Q?7JRWia+kUx79leW1mxUvPd1baZbMffbVYl8b3b0O2vFWdzh5P6S0uDzJdrJU?=
 =?us-ascii?Q?SqpTDVFqaUpA+qYBqpyE8xqmSd2FKb4mCxoGiw8YlxPrDty+k3GRW5Hplkmt?=
 =?us-ascii?Q?T9jdzFGFD6gGnmQjcVKUqwta0ybqNtQkpgLEoYJm8ap73KOVowo+Eu0U9QQa?=
 =?us-ascii?Q?+5JntdzY9r+eMzkfM8I32y7fukMyyqdZHdEO9SAaBgJfiPW+kQmR6OcBh3N9?=
 =?us-ascii?Q?cxbRIfXDArNld7HZ4z/db6Vq3upVFLK043l30K127CdeIw9z4n5o5aXdJf4Y?=
 =?us-ascii?Q?FD6v8YnhpyKdTQwi1yQt4i5UfnjG1kES078WOAvfLPyDMgAW17qwcJw331YA?=
 =?us-ascii?Q?TYCvwlXW42/7hyqSO8FLJAVaP7Mrb0JFKmczRZidR1v2Nj98DI3NxK8BaBIy?=
 =?us-ascii?Q?f6kKb/9mSzs8ULft6vmHMFtE5d92HW3emkftAO40pw86HpUDjmeve2yTCd66?=
 =?us-ascii?Q?fb9y+8a+KyYh0VpNlDePCsAK1DWOx2XM4iKhjSRGmvD7PKRBSHNzkixbI0MK?=
 =?us-ascii?Q?jlZY61Rl70rlUyPIAIaUaQHoTQsabT7GJl0lgRF5weEcuZneCzf2s5i6LCkK?=
 =?us-ascii?Q?xml8RpC6ZbjdQs/6egfOK8FrEtaEu1f+wHEKCzYjhuL/Hn93gCNj09sxwsTi?=
 =?us-ascii?Q?hKLWtHP+dGYIGhjFcQ6lplHDfPJYZhrW3rg6AIUk1Ght28r8dEUrAR8oHN+g?=
 =?us-ascii?Q?3pxrC+dGFaZYSWexybkRruJQz/iP4ZtKxxMm/fHQwG0sW7cYM7XUuwZYx1g6?=
 =?us-ascii?Q?jSr+KitLJU7DSJrBMCZ+DpRTw806yNi/mivCD8pJ1KA3OuqKu64A5HlvtUef?=
 =?us-ascii?Q?z2MK+XBex1M4ig447zm/8mXJhQ9VWFJ0a4a43gOHZ9BStfS+WSaBupA1kCRo?=
 =?us-ascii?Q?r31D3SF/pJVtos5jtA7nZ8cPHQmi9oyLChn0IF+bQzlZyT91yGCdP5kIL4hw?=
 =?us-ascii?Q?VL82JMK0NdZdY4L81G40GWkYH0KlSgQP0fUfA3yOdpwfvpUFDzDWfyDB5aY7?=
 =?us-ascii?Q?nCa9zAIAgpglqSX+R2Nsfc9bBwWU+Z+IzsetXItO6W7JHUwHlSabGedwDgqN?=
 =?us-ascii?Q?SGP6GE+tyHyxmGCXXrTAWIJxHIZoW9tCnTo3zb6GGSrtKt6mkcAYI2/32Wuw?=
 =?us-ascii?Q?TeghlgLrAlmzySQCm6bIqGc9w/zon2TeGU83SdRLZ1H1V76QT6exXPRKuJa7?=
 =?us-ascii?Q?bl2tOndCVL18xvkM+U1vRBiN4M2uDnh83fWhN8IQA/CTLoqdaSrbBRRBpN2E?=
 =?us-ascii?Q?Ge6OVuLZe/27N+Ifn5HP4TBImZAZoq2LaOj+dZwfxoWhXLRaM7WWRRI4el9T?=
 =?us-ascii?Q?NgOaG4YqQs7Wn3fHtCi71JemO9bLXRQUkusAvyuh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea812e3b-3175-4a7a-ace9-08dbae25576c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:32:40.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPxlIZ8c2Cv1uJJrp5QyzKjaCsB7qQrfzXFeGmz7engTPlKFwfc3VdbZ3T2EM2omCuP+GLWbkmOfJNYsDwtBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIGRATE_HIGHATOMIC pages are used for order > 0 allocation,
so pages in MIGRATE_HIGHATOMIC order0 freelist are invalid.

This patch can solve the allocation failure from buddy, due to
the reserved MIGRATE_HIGHATOMIC order0 pages.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/page_alloc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14b51d1ef4c3..10c5b053bedf 100755
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -831,6 +831,9 @@ static inline void __free_one_page(struct page *page,
 	else
 		to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
 
+	if (unlikely(!order && is_migrate_highatomic(migratetype)))
+		migratetype = MIGRATE_MOVABLE;
+
 	if (to_tail)
 		add_to_free_list_tail(page, zone, order, migratetype);
 	else
@@ -1639,9 +1642,13 @@ static int move_freepages(struct zone *zone,
 		VM_BUG_ON_PAGE(page_zone(page) != zone, page);
 
 		order = buddy_order(page);
-		move_to_free_list(page, zone, order, migratetype);
+		if (unlikely(!order && is_migrate_highatomic(migratetype)))
+			move_to_free_list(page, zone, order, MIGRATE_MOVABLE);
+		else {
+			move_to_free_list(page, zone, order, migratetype);
+			pages_moved += 1 << order;
+		}
 		pfn += 1 << order;
-		pages_moved += 1 << order;
 	}
 
 	return pages_moved;
-- 
2.39.0

