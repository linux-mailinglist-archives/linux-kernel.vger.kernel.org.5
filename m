Return-Path: <linux-kernel+bounces-13164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB179820093
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB821C22DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605712B6B;
	Fri, 29 Dec 2023 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G9gyE6VI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5A125CA;
	Fri, 29 Dec 2023 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTEWtUh001144;
	Fri, 29 Dec 2023 16:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=d0Fg/CG2aVSyzap3VszlPZ/VtlmbTzg19haLKXNvSTg=;
 b=G9gyE6VIWAXXglPfaXjhhXg1T3qE6D3lJTshO1yt1kA+FescTWYrUs1AwEquJldSLenl
 0YbfQ2XE9728Gz/CjFF1anBPxixy65CIK6l0Gv/3riiCGHdFs8b6XNdWtgYff88aE9PF
 sL8ptje0dqScwYpr3BrJuYOQh7SMwePDCKeAnq2PD0jgKSY6MXjbwWp+74d6Nf8t/W7c
 rj80TfK4cLiRsFphMU1AYC/UbnGPjEFnS0hFycf5ONK1macPNMLvrwTc3G+IKwSDX6Bx
 6iFPjEiTaEEqShDPDTbbDK+/BXDXvCaJT8GiVi67PsqtNe8FyNjrz6rBip8lzC1vpWbB Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9yyfjjfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:42:07 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BTGU8OF014559;
	Fri, 29 Dec 2023 16:42:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v9yyfjjfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:42:06 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTDUbFb008395;
	Fri, 29 Dec 2023 16:42:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v69vt6pn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 16:42:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BTGg3D712452490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 16:42:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B4820043;
	Fri, 29 Dec 2023 16:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF5520040;
	Fri, 29 Dec 2023 16:42:00 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com.com (unknown [9.43.75.69])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Dec 2023 16:41:59 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: axboe@kernel.dk, kch@nvidia.com, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, zhouchengming@bytedance.com,
        nj.shetty@samsung.com, akinobu.mita@gmail.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com
Subject: [PATCH] drivers/block/null_blk: Switch from radix tree api to xarrays
Date: Fri, 29 Dec 2023 22:11:51 +0530
Message-ID: <20231229164155.73541-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: enLUks_CD3bgzJcsG5kCbMZkeUwb_DJW
X-Proofpoint-GUID: Na3aoFY1hK166LgVTJQTIDL7W8FB6GLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_06,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=821 impostorscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312290133

Convert the null_blk driver to use the xarray API instead of radix tree 
API.

Testing:
Used blktests test suite (block and zbd suites) to test the current 
null_blk driver and null_blk driver with this patch applied. The tests 
results in both the instances were the same.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 drivers/block/null_blk/main.c     | 81 ++++++++++++++-----------------
 drivers/block/null_blk/null_blk.h |  5 +-
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3021d58ca51c..692c39479abf 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -705,8 +705,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->init_hctx_fault_config.attr = null_init_hctx_attr;
 #endif
 
-	INIT_RADIX_TREE(&dev->data, GFP_ATOMIC);
-	INIT_RADIX_TREE(&dev->cache, GFP_ATOMIC);
+	xa_init(&dev->data);
+	xa_init(&dev->cache);
 	if (badblocks_init(&dev->badblocks, 0)) {
 		kfree(dev);
 		return NULL;
@@ -899,18 +899,18 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page, *ret;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	t_page = radix_tree_lookup(root, idx);
+	t_page = xa_load(xa, idx);
 	if (t_page) {
 		__clear_bit(sector_bit, t_page->bitmap);
 
 		if (null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(root, idx, t_page);
+			ret = xa_erase(xa, idx);
 			WARN_ON(ret != t_page);
 			null_free_page(ret);
 			if (is_cache)
@@ -919,16 +919,18 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	}
 }
 
-static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
+static struct nullb_page *null_xarray_insert(struct nullb *nullb, u64 idx,
 	struct nullb_page *t_page, bool is_cache)
 {
-	struct radix_tree_root *root;
+	struct xarray *xa;
+	void *ret;
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 
-	if (radix_tree_insert(root, idx, t_page)) {
+	ret = xa_store(xa, idx, t_page, GFP_ATOMIC);
+	if (xa_is_err(ret)) {
 		null_free_page(t_page);
-		t_page = radix_tree_lookup(root, idx);
+		t_page = xa_load(xa, idx);
 		WARN_ON(!t_page || t_page->page->index != idx);
 	} else if (is_cache)
 		nullb->dev->curr_cache += PAGE_SIZE;
@@ -938,28 +940,16 @@ static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
 
 static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
 {
-	unsigned long pos = 0;
-	int nr_pages;
-	struct nullb_page *ret, *t_pages[FREE_BATCH];
-	struct radix_tree_root *root;
-
-	root = is_cache ? &dev->cache : &dev->data;
-
-	do {
-		int i;
-
-		nr_pages = radix_tree_gang_lookup(root,
-				(void **)t_pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			pos = t_pages[i]->page->index;
-			ret = radix_tree_delete_item(root, pos, t_pages[i]);
-			WARN_ON(ret != t_pages[i]);
-			null_free_page(ret);
-		}
+	unsigned long idx;
+	struct nullb_page *t_page, *ret;
+	struct xarray *xa;
 
-		pos++;
-	} while (nr_pages == FREE_BATCH);
+	xa = is_cache ? &dev->cache : &dev->data;
+	xa_for_each(xa, idx, t_page) {
+		ret = xa_erase(xa, idx);
+		WARN_ON(ret != t_page);
+		null_free_page(t_page);
+	}
 
 	if (is_cache)
 		dev->curr_cache = 0;
@@ -971,13 +961,13 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	t_page = radix_tree_lookup(root, idx);
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	t_page = xa_load(xa, idx);
 	WARN_ON(t_page && t_page->page->index != idx);
 
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
@@ -1005,6 +995,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 {
 	u64 idx;
 	struct nullb_page *t_page;
+	struct xarray *xa;
 
 	t_page = null_lookup_page(nullb, sector, true, ignore_cache);
 	if (t_page)
@@ -1016,14 +1007,14 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	if (!t_page)
 		goto out_lock;
 
-	if (radix_tree_preload(GFP_NOIO))
+	xa = ignore_cache ? &nullb->dev->data : &nullb->dev->cache;
+	idx = sector >> PAGE_SECTORS_SHIFT;
+	if (xa_is_err(xa_store(xa, idx, NULL, GFP_NOIO)))
 		goto out_freepage;
 
 	spin_lock_irq(&nullb->lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
 	t_page->page->index = idx;
-	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
-	radix_tree_preload_end();
+	t_page = null_xarray_insert(nullb, idx, t_page, !ignore_cache);
 
 	return t_page;
 out_freepage:
@@ -1049,8 +1040,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
 		null_free_page(c_page);
 		if (t_page && null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(&nullb->dev->data,
-				idx, t_page);
+			ret = xa_erase(&nullb->dev->data, idx);
+			WARN_ON(ret != t_page);
 			null_free_page(t_page);
 		}
 		return 0;
@@ -1075,7 +1066,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	kunmap_local(dst);
 	kunmap_local(src);
 
-	ret = radix_tree_delete_item(&nullb->dev->cache, idx, c_page);
+	ret = xa_erase(&nullb->dev->cache, idx);
 	null_free_page(ret);
 	nullb->dev->curr_cache -= PAGE_SIZE;
 
@@ -1093,8 +1084,8 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	     nullb->dev->curr_cache + n || nullb->dev->curr_cache == 0)
 		return 0;
 
-	nr_pages = radix_tree_gang_lookup(&nullb->dev->cache,
-			(void **)c_pages, nullb->cache_flush_pos, FREE_BATCH);
+	nr_pages = xa_extract(&nullb->dev->cache, (void **)c_pages,
+			nullb->cache_flush_pos, ULONG_MAX, FREE_BATCH, XA_PRESENT);
 	/*
 	 * nullb_flush_cache_page could unlock before using the c_pages. To
 	 * avoid race, we don't allow page free
@@ -1235,7 +1226,7 @@ static int null_handle_flush(struct nullb *nullb)
 			break;
 	}
 
-	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
+	WARN_ON(!xa_empty(&nullb->dev->cache));
 	spin_unlock_irq(&nullb->lock);
 	return err;
 }
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..cc871981edef 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -14,6 +14,7 @@
 #include <linux/fault-inject.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/xarray.h>
 
 struct nullb_cmd {
 	union {
@@ -75,8 +76,8 @@ struct nullb_device {
 	struct fault_config requeue_config;
 	struct fault_config init_hctx_fault_config;
 #endif
-	struct radix_tree_root data; /* data stored in the disk */
-	struct radix_tree_root cache; /* disk cache data */
+	struct xarray data; /* data stored in the disk */
+	struct xarray cache; /* disk cache data */
 	unsigned long flags; /* device flags */
 	unsigned int curr_cache;
 	struct badblocks badblocks;
-- 
2.39.2


