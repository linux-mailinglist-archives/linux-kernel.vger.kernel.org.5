Return-Path: <linux-kernel+bounces-151839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 102468AB492
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B337F1F20FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD413C3EF;
	Fri, 19 Apr 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7EnkUAx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BA13B59E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549390; cv=none; b=f2HznxrPiNfEiXUWVaNT+s6pCBVbCAyQ8WfJiCI94cm5keSpGnDUsQbLCHMeY+Mn/VScU/OilDexWv4U5trbI/IRiZRe0GyalxcHms9sm0T0twqS+3f5202jtnXCyZnPYj2NmEyV8ef5dK5DnJTZKAbNyh+3Xy/vzOYG2P69MzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549390; c=relaxed/simple;
	bh=KOoPPpNqh/95U3yEGbqqVgA5PPKwYYmBh41qdD18jAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQPQe6bz2//RKkooIuisG1SDz6DvSdt1ZgdakNyxVUQR+0jqEsm5swKhfNJtKX5B1ANJAN3Kjhfxu+pCzswt6QlI5NmNzU8jWkDajOYBYLL3mYyEn8RBAtVCVjDORFmXSvHrNzntZuBKa3jTQsJagMvtZ6wsjLBSFv4HSx03WzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7EnkUAx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JGi3x6030352;
	Fri, 19 Apr 2024 17:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=E4ycvTEE8d8tsFa3XEXhTzxsb88jl02QoN97F8t0DMs=;
 b=O7EnkUAxu6+JwaIdG+XQWmPC3YXCmvTnio0EzM4WV/mouFcJw9MuEmhRi5Qp6qfnpOEc
 9yALSY1fs8//YcBqvY9edw4JF0qaraCgKUFcxP1L6weQIm+MuNytl4Nd2uOLVu2gMb7o
 430vMzcnBL/esbGeQpyjCPiY3mjraiXpZSFWNSjPigQBfEVI4YpBfbzR9K+iJRyO24t+
 yVEmrSldDymURZlYUa1I+2oC+F+uKPLaSC2IA2embb9543K23EBI6DHP6liIzuK6BRAD
 WR3RDIiVfyJ/h8he3+QcEm8Dl9VpLMVwkC1xnB5p7sn8enV+FOwBHigZ/cK4fP9NcqYo FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujwjm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 17:56:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JH48SJ005568;
	Fri, 19 Apr 2024 17:56:13 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-230-131.vpn.oracle.com [10.159.230.131])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xkc7xd76r-3;
	Fri, 19 Apr 2024 17:56:13 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: vbabka@suse.cz, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com
Subject: [PATCH v3 2/2] slub: use count_partial_free_approx() in slab_out_of_memory()
Date: Fri, 19 Apr 2024 10:56:11 -0700
Message-ID: <20240419175611.47413-3-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
References: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_13,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190137
X-Proofpoint-ORIG-GUID: etvbRzFUFWO99kOfRwSYzVdQlvEBJIX2
X-Proofpoint-GUID: etvbRzFUFWO99kOfRwSYzVdQlvEBJIX2

slab_out_of_memory() uses count_partial() to get the exact count
of free objects for each node. As it may get called in the slab
allocation path, count_partial_free_approx() can be used to avoid
the risk and overhead of traversing a long partial slab list.

At the same time, show_slab_objects() still uses count_partial().
Thus, slub users can still have the option to access the exact
count of objects via sysfs if the overhead is acceptable to them.

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 993cbbdd2b6c..fa55699aa21a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3292,7 +3292,7 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 		unsigned long nr_objs;
 		unsigned long nr_free;
 
-		nr_free  = count_partial(n, count_free);
+		nr_free  = count_partial_free_approx(n);
 		nr_slabs = node_nr_slabs(n);
 		nr_objs  = node_nr_objs(n);
 
-- 
2.42.1


