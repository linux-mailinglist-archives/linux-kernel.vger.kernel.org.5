Return-Path: <linux-kernel+bounces-128077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B08955DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28726B291B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918D84A52;
	Tue,  2 Apr 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSPlsexI"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A933D1;
	Tue,  2 Apr 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065657; cv=none; b=pPt3npkwxxeIWg+Kv526p+Scq5XpNiRsuUQ8FTBFMAva+x6hExenaJNqsrDIovaKtZTKDuPoQVP14ZU7VXDKtyhpRV2eT3csmUzfsnooPgVlAi5qhbg/4HZrtm9RA3vybuh4AA3YQPN1VpcoGL/mq/6uu4SxnTZWCUo0JvpTuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065657; c=relaxed/simple;
	bh=vGn66XkpBDDZFkr8QUJL1l6IKJXYOGPf9g22hUi8pRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZpSLbfxH8qt1+xzVGwpAIA4lSsVOMtAsvz+1o7LFEUaQGwG0qwGFjIvOdOw4QEs1ifv6EzckpwurTFfrbd1xv32330c2L3UB/rVoc+/GD7cz3mXzwd03BKkqehkXcWUBiH8NQd5K9AciTFzR3h3uIdhgUvUcGc8jWGvs6MU2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSPlsexI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4327hqKL020065;
	Tue, 2 Apr 2024 13:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=2VVY6Eqd01Tnl+nUtZiZ06ERpIzu3oNa0E/idaAnNtw=;
 b=RSPlsexIHr4h3ZvtmydsX/wJdfqSpgJXZ/IMbRresyAWC+shDaBocKWy358u8uo+MimY
 xt6FhfzLiQmle22lpUmRXhHrCCNUJSd/PSettbiLjP9ipVAQ2hHaUFX2G94371IRc39O
 t9A7vj3McAiZVUUEM2DVKtEfDUmWA5SqYO9DLp/Wj31MryivB/ySk1Pv4KHLraFq8Zw3
 thlkJHth6NumjR8LO+ne+BnVlZQ8Oj3uGylw6qJ63zOr8Dy+zS2o4rgPudLWxM/Gq3R9
 /yJUUGfSLgHT4+LurfzjsROt+3DDrHSOUZkQ/1JAPmt+wEYb5GMMdfbvelEvAqrUWXAl tQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9tpxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 13:47:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 432Cu6so015463;
	Tue, 2 Apr 2024 13:47:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6966tswv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 13:47:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432DlCFe004519;
	Tue, 2 Apr 2024 13:47:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x6966tswc-1;
	Tue, 02 Apr 2024 13:47:12 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
        Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Grant Likely <grant.likely@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, harshit.m.mogalapalli@oracle.com
Subject: [PATCH v2] drm/panthor: Fix couple of NULL vs IS_ERR() bugs
Date: Tue,  2 Apr 2024 06:47:08 -0700
Message-ID: <20240402134709.1706323-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_07,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020101
X-Proofpoint-GUID: K5O4oPvkf_P70AWbgGnCTEuzg9lQhAJy
X-Proofpoint-ORIG-GUID: K5O4oPvkf_P70AWbgGnCTEuzg9lQhAJy

1. The devm_drm_dev_alloc() function returns error pointers.
   Update the error handling to check for error pointers instead of NULL.
2. Currently panthor_vm_get_heap_pool() returns both ERR_PTR() and
   NULL(when create is false and if there is no poool attached to the
   VM)
	- Change the function to return error pointers, when pool is
	  NULL return -ENOENT
	- Also handle the callers to check for IS_ERR() on failure.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
This is spotted by smatch and the patch is only compile tested

v1->v2: Fix the function panthor_vm_get_heap_pool() to only return error
pointers and handle the caller sites [Suggested by Boris Brezillon]
	- Also merge these IS_ERR() vs NULL bugs into same patch
---
 drivers/gpu/drm/panthor/panthor_drv.c   | 6 +++---
 drivers/gpu/drm/panthor/panthor_mmu.c   | 2 ++
 drivers/gpu/drm/panthor/panthor_sched.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 11b3ccd58f85..c8374cd4a30d 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1090,8 +1090,8 @@ static int panthor_ioctl_tiler_heap_destroy(struct drm_device *ddev, void *data,
 		return -EINVAL;
 
 	pool = panthor_vm_get_heap_pool(vm, false);
-	if (!pool) {
-		ret = -EINVAL;
+	if (IS_ERR(pool)) {
+		ret = PTR_ERR(pool);
 		goto out_put_vm;
 	}
 
@@ -1385,7 +1385,7 @@ static int panthor_probe(struct platform_device *pdev)
 
 	ptdev = devm_drm_dev_alloc(&pdev->dev, &panthor_drm_driver,
 				   struct panthor_device, base);
-	if (!ptdev)
+	if (IS_ERR(ptdev))
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fdd35249169f..e1285cdb09ff 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1893,6 +1893,8 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
 			vm->heaps.pool = panthor_heap_pool_get(pool);
 	} else {
 		pool = panthor_heap_pool_get(vm->heaps.pool);
+		if (!pool)
+			pool = ERR_PTR(-ENOENT);
 	}
 	mutex_unlock(&vm->heaps.lock);
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5f7803b6fc48..617df2b980d0 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1343,7 +1343,7 @@ static int group_process_tiler_oom(struct panthor_group *group, u32 cs_id)
 	if (unlikely(csg_id < 0))
 		return 0;
 
-	if (!heaps || frag_end > vt_end || vt_end >= vt_start) {
+	if (IS_ERR(heaps) || frag_end > vt_end || vt_end >= vt_start) {
 		ret = -EINVAL;
 	} else {
 		/* We do the allocation without holding the scheduler lock to avoid
-- 
2.39.3


