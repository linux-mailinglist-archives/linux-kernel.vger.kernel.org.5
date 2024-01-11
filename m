Return-Path: <linux-kernel+bounces-23583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6E82AEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035D01F222EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EA215ADF;
	Thu, 11 Jan 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SLW4lEfQ"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B4156FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMB294uaVJbdMKiiHQCqTWFWzKjfhA3BeC9ukBiBcpFEBVgMlDnYG1OpZsA5YgOmZ0QhoG+2FTQgpyrBjqcL3TE3PkO5e6KBvNHyVcU22bMQ65mHImhMPURqK1I6QP7Azz8wZ60NJ4mB9zJmhgLyow12v9yPtDhs0EFEz0bgDVrcUkFA+NddfwyIIIT2QQ5nSK1WFQWtVulyVW5SWjcGexX9qn2xcW3MBjI2zePMsQ08T5JFqBNcxz5c8WfSebW+7cNGudIEu2XFMfcJO87AOqlN5Nv4NuwhvN1UKN8rNf3PhIkAuTqkzLZtonmNRyBrQ6TXAdUk0Pz0plCNI4ypEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/XbDFDyTHaoGg8tcaFHppYRuh89zfg9Wa5guHsA9GU=;
 b=ALNtkDSGeGFLEoi0KJ6KodENYTW0khla9pJrMRBckdacULrR4ShmmNerLdbsHjFZPIzqXVxgT9fkUDJP7s1jQiEZ8mDqD5EhbfylhcFENao8DBxfrC4bQD0uC0SOMiqdvA+YRkAhl5416Zw8Ue+Rpyaoq17rJuWZxIOezSBwFwYoXVEbWcc9JZ0yU6ZMqpXmSYSmLez7m089EjSTbvQnm9E+TZz+qUsfa7CG8zgWbkEVhGZ4cS9Pf1Zk906oAdN1dOPkJG7XhswIG7gEuv1Y9kUEEv7QGsoLyaUGwJ6AO5ppKmfWs3TCNwEG1m5imDuJp6Q9qZQd9Mz/zRodWf8Xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/XbDFDyTHaoGg8tcaFHppYRuh89zfg9Wa5guHsA9GU=;
 b=SLW4lEfQ2AyWqoC8kYHyFvIuoq/4bpE1Nr6NPWUQDw3LEMlLnsjfJ93hfjHN7H9V0nfJWW19kaGwXtUjwHLuSdmMacm/Jv6VERhKl5LRmOZi7X1ApsVQZYRIQY8dz5DnM0jSxIX9Ct24aPI6VdEyRgBprRda0XdDbE81WEwIdyzO84KUpCdyoWmMytUaVt6AruW2gdW4WIoV7mtWtot06zWV8fdP0VtTYzMyzwtfDI0336rCgO9G4ImoKhffMVzgkwf/OpzuNKgzIPEPHebEEm4uoiUKI5J2UdFSI1pzXnOHqRqq3eUV0DzsLn+/AHsSSihx5aPZT9JWLJoISf7mbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 by SEZPR06MB6958.apcprd06.prod.outlook.com (2603:1096:101:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 12:25:06 +0000
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81]) by SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 12:25:06 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v1 1/2] mm:vmscan: fix workingset eviction memcg issue
Date: Thu, 11 Jan 2024 20:24:50 +0800
Message-ID: <20240111122451.682-2-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
In-Reply-To: <20240111122451.682-1-justinjiang@vivo.com>
References: <20240111122451.682-1-justinjiang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6871:EE_|SEZPR06MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaeaa7e-a1f6-4b2c-a402-08dc12a05816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C50FQXUEcP3QtxSFLpavBuzKLqKZXo/92HwmLjMeZOedRIutzB4voMSO8NpV9zll1LMg7c6RDaxpakrZsjxkhobCeicK6dHcosFPdZtJzk3NSMKXMlbuED4hJdmpLOe5mUyPTaXjWNymTCs9TVbKaF43L93oSNR8g4etyihv0asQdVqPYo3Bqdjjcrn/l811Q2KSacrHQ35EQ0bQ+1zFPDCv+ouiyb/0zDYlJSBNzTzzKNLKh5LuiZ+6W3LL++XGxMW7QbPpCEKeadK8VHq4oeOsGTeE0FHSBTmbXCGnL3WLh+InVTs6OKMHaPMpV27M5v0qRgtz+bPgMDBCUbSbnLGP2n1+MroeECUlJ1pmDQzn8JIcvf72G1d7OKuDRYqAYRqKeB5KgtmuQgs6pPMQpk9VyalaBNlDhAqSLxI2o5V9rcjBXf/P9eZgIlZNqfVA9UUDuN4gy42ElY+zl1IVOpUC72oJxO5LaZ05pUeLDao2JKKK4i6M943a97vkxkWRdeRH96W3mWaXdlczsdDu6qh5HNmuOh0cErqVHwZca098B1Qib9AjrSoGAwxPmfTAeFNFHOFLrL91yJw9YP6s/IEYE7O90pfb5amNVnRuGqM4wR/vfRCkiTseu/QqFd6eByV88oOq9Jqa0Fr6gKovU61Dff9U1Eo/sgQu18Y2TYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6871.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(316002)(110136005)(6506007)(52116002)(8676002)(8936002)(6486002)(26005)(1076003)(41300700001)(107886003)(83380400001)(66476007)(66556008)(66946007)(4326008)(7416002)(478600001)(6512007)(2616005)(5660300002)(6666004)(2906002)(38100700002)(36756003)(86362001)(921011)(38350700005)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pp+CnS6+Zz9SrCfXqE7i8T9L57iJe0jlJbM9yLfE6PfnGxKwxmshAXtUE9yr?=
 =?us-ascii?Q?LjnJA7hDF0Q0KoT3shRReCE5ec2fV1FbgmjTouzp1oRK/PUY8MMkPcGhqF0D?=
 =?us-ascii?Q?eM4Y7iYcAwWHHRR+Oy1Hc6K0/hkCDKMo4mYv9hfReOMH/xlhjbBd/HSE6h50?=
 =?us-ascii?Q?aOzHoCYHI1WVClNMhg55KZAWbmU+w8pLPH7Tqic/+GMIYAehMk8lU5AkSe79?=
 =?us-ascii?Q?lGRjrCdHI48Yp2+ym6xqfTL23rMphQWY7g/V0dlU5L8NAKqktIYpE/XTtq0z?=
 =?us-ascii?Q?SqDHZIbuFJIwnPsK3ahTYox4T5mNaZ8fdkRoJoAFnuCorpdPJ21PHoIkjXzR?=
 =?us-ascii?Q?2Noi95G0AmqqwmpYL/uCWz3dTzZtuCnt8/Dg9gok//4o0+Lz/ScTKiKH1DOY?=
 =?us-ascii?Q?DdzLec3rEcH/rzAykJloPqj4IdX3XRq/jYHO0wkUtBzxpq/eQ+6AXa0xk+1g?=
 =?us-ascii?Q?0bHv1AVDXbbr8tLbhQhJRKuUweZEOoVQTnIZ4enXTAG+na9KW8CS/kHW2K3n?=
 =?us-ascii?Q?L7A/bq+pRyvduOEAcVpGxRK2LVs3n0I4967c34mR11tlpY75Kz4R+4Wu74UE?=
 =?us-ascii?Q?Pb1FxUY6sy0xF0OONu55k9WwAMgksdRRsZ+4cf3Bb8drsl0HOTvvLLqoNEf6?=
 =?us-ascii?Q?vPvGqpP+1FwnLM83VgDoB+OQy+BYg/klM7WrHUbq5Kcg86SnwhX6k62OLRuY?=
 =?us-ascii?Q?hhwpxM2MnbeGAhwBAucXgFyYLEeg3DIGHvI77+L+lkoPFv54ss+/Z6cFKYFg?=
 =?us-ascii?Q?ujedFpUMcnC0p9/crttAXo8QhIOUnS96vNVsXcj9VfAc2+ySyxvCoJuD5Ish?=
 =?us-ascii?Q?EFDXuNdO88r1EiF2q3FtoOINiFCKoHSBOslgWlv29G20XMg1IAmXMHpXu9Ui?=
 =?us-ascii?Q?F8drvZOav7HjEJ4kHEjZFCLlDJw1gA3ho/s4s6SEfYVeFmZZ3lCuJ8VHtG3D?=
 =?us-ascii?Q?5CE51gt2yyRrZXMNAqV1BhLAIUnCLK+w6mQvcCUg8pDlvadrDi7y26p/eQ+W?=
 =?us-ascii?Q?GxyVCw7XQMWJgkC3guvSe+/VDNdjhfpfjNcx9fYFU1mAoxl8GLxDljcK+eW0?=
 =?us-ascii?Q?bXvpj+6SBiTRlAyKw2zPGdKJfErMWZpD3VkEb56VSZRdpt/CpXTCcw+eUpkq?=
 =?us-ascii?Q?O/IZTIMgu5a2BuVjbzRFvmhGJPXM3GCo46Jc5KxGdsLqQ/eJfmurvzsNPOTj?=
 =?us-ascii?Q?0d2w9lJR/acK/fRdwy1EdLod6FXAcr/eVqGTiS9GV/Lnzg2wgq6Joo9D/3Ic?=
 =?us-ascii?Q?iSLs4ldGIF6q684u9CjXMx+BCJ2l1IaKuAbNXhknezua62OQGEYs8gUSxur8?=
 =?us-ascii?Q?ehA2qGmD+yN7LbevVS3SYsHExsttfTxKUmEd6/pzXTEkG2/eAHr7BgZLB0Ot?=
 =?us-ascii?Q?ariswYmv+oc+wjfat6OdKKutJgoj8lD1VnAiH8bWCva2mVvdKuF62//3zX/0?=
 =?us-ascii?Q?ZVx9vMposS4CVbIb7PJBsk1pFjjvsOeo5uH7n8g62pn3SdtiC3ofc6vAbgxF?=
 =?us-ascii?Q?yTW/8UrDIKd/vNGLEx5yp/bITUrR8Ptwwxp8OH2a2ZwJmXVJKYVdGcX1BJ9R?=
 =?us-ascii?Q?vx3mrTgRwdgsM673qQW311LOD4t9EsonC1dXCVjv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaeaa7e-a1f6-4b2c-a402-08dc12a05816
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6871.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:25:06.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFszcyK3Oyk52rIv0TWl2KOLetmwlyJXnnXY9f2w4SPTqS5fQa6TeakfhNDzMdv0Jmx49ZLdG2RZN4JH2ccWSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6958

The parameter of target_memcg is NULL in workingset_eviction(), and
the lruvec obtained by mem_cgroup_lruvec(target_memcg, pgdat) is always
root_mem_cgroup->lruvec, rather than the lruvec of mem_cgroup where
folio is actually located.

Fix target_memcg to the memcg obtained by folio_memcg(folio).

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 include/linux/swap.h |  2 +-
 mm/vmscan.c          | 11 +++++------
 mm/workingset.c      |  6 +++---
 3 files changed, 9 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 include/linux/swap.h
 mode change 100644 => 100755 mm/vmscan.c
 mode change 100644 => 100755 mm/workingset.c

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 41e4b484bc34..4de61f158903
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -346,7 +346,7 @@ static inline swp_entry_t page_swap_entry(struct page *page)
 /* linux/mm/workingset.c */
 bool workingset_test_recent(void *shadow, bool file, bool *workingset);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
-void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
+void *workingset_eviction(struct folio *folio);
 void workingset_refault(struct folio *folio, void *shadow);
 void workingset_activation(struct folio *folio);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91e7d334a7ca..8a1fbdaca042
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -693,7 +693,7 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
  * gets returned with a refcount of 0.
  */
 static int __remove_mapping(struct address_space *mapping, struct folio *folio,
-			    bool reclaimed, struct mem_cgroup *target_memcg)
+			    bool reclaimed)
 {
 	int refcount;
 	void *shadow = NULL;
@@ -742,7 +742,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		swp_entry_t swap = folio->swap;
 
 		if (reclaimed && !mapping_exiting(mapping))
-			shadow = workingset_eviction(folio, target_memcg);
+			shadow = workingset_eviction(folio);
 		__delete_from_swap_cache(folio, swap, shadow);
 		mem_cgroup_swapout(folio, swap);
 		xa_unlock_irq(&mapping->i_pages);
@@ -769,7 +769,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		 */
 		if (reclaimed && folio_is_file_lru(folio) &&
 		    !mapping_exiting(mapping) && !dax_mapping(mapping))
-			shadow = workingset_eviction(folio, target_memcg);
+			shadow = workingset_eviction(folio);
 		__filemap_remove_folio(folio, shadow);
 		xa_unlock_irq(&mapping->i_pages);
 		if (mapping_shrinkable(mapping))
@@ -803,7 +803,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
  */
 long remove_mapping(struct address_space *mapping, struct folio *folio)
 {
-	if (__remove_mapping(mapping, folio, false, NULL)) {
+	if (__remove_mapping(mapping, folio, false)) {
 		/*
 		 * Unfreezing the refcount with 1 effectively
 		 * drops the pagecache ref for us without requiring another
@@ -1417,8 +1417,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 */
 			count_vm_events(PGLAZYFREED, nr_pages);
 			count_memcg_folio_events(folio, PGLAZYFREED, nr_pages);
-		} else if (!mapping || !__remove_mapping(mapping, folio, true,
-							 sc->target_mem_cgroup))
+		} else if (!mapping || !__remove_mapping(mapping, folio, true))
 			goto keep_locked;
 
 		folio_unlock(folio);
diff --git a/mm/workingset.c b/mm/workingset.c
index 226012974328..f29396d4bf75
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -372,15 +372,15 @@ void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages)
 
 /**
  * workingset_eviction - note the eviction of a folio from memory
- * @target_memcg: the cgroup that is causing the reclaim
  * @folio: the folio being evicted
  *
  * Return: a shadow entry to be stored in @folio->mapping->i_pages in place
  * of the evicted @folio so that a later refault can be detected.
  */
-void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
+void *workingset_eviction(struct folio *folio)
 {
 	struct pglist_data *pgdat = folio_pgdat(folio);
+	struct mem_cgroup *memcg = folio_memcg(folio);
 	unsigned long eviction;
 	struct lruvec *lruvec;
 	int memcgid;
@@ -393,7 +393,7 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 	if (lru_gen_enabled())
 		return lru_gen_eviction(folio);
 
-	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */
 	memcgid = mem_cgroup_id(lruvec_memcg(lruvec));
 	eviction = atomic_long_read(&lruvec->nonresident_age);
-- 
2.39.0


