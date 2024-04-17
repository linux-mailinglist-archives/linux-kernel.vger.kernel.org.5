Return-Path: <linux-kernel+bounces-149095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD788A8BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5133DB262AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175136AE4;
	Wed, 17 Apr 2024 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cVuaG39E"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A82561D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380400; cv=none; b=cqF5MTFzPSvbF1pUEKk/0u3BGhT2uuzFRqpgqMEL7cB+CbBdtR7Wp5YH3e0F78JHKgJvgtJdFAImwpoB7ym9438Vw2XQ73wdrQZTv3ibgiFP8ptKq9pIUQ296Xq7FMRwJPSSxVXT1HG6LHDL7uSiKB3p4HgjLw6O7teboRQiQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380400; c=relaxed/simple;
	bh=/SqZqkJiNVuQuM+lltDEKIAs6D3ZqX8ZrKENy7eUmMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psWpB16J2s2hx3bqmYFSoTeP3Hl/Q9EGysKTOfmZbCs5O307N4foQ6x8UXGzUR+rcPVq9Osj13ITG4nkqN/sILe/h0oeHXxYFOxLhFrz1x1M5CDR16v1Z8UjLt/FjF6/tj/Ij7tvECq784r0BwUa2BCEU1CLVNdaPLWiOlL/39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cVuaG39E; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HHiViW019610;
	Wed, 17 Apr 2024 18:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=vz/MWxuYKbCjC1t4MkPCHPpvqr4U9WONMklYCJ0rdMU=;
 b=cVuaG39EMK+RqJdvzopoz5AuVvT4sTmM0ah1F9NfMEonqEAFNxThirWFkqA88guAyOji
 wNi+1mkwEaYXv2hysb6eB59PzDDiWZZXSRK/cL/SvoghmVUDM4Sk2eBlz4swfP9zE/aM
 i9mxRQtOWbqR4Ye6FwWMj1xplLk2zU37GDcdiTuG9S/9LndLUhTMCV22ceY7YsKGl9B6
 +/DOe2p9UCSg/tasX21Wr2ZsoR7NC8v7U0PRrT/69jYdoc0viBa97Smt32r4uEhBK0H6
 6WLcCI82VMX7pono3HGDx/6o4mZk9oPIyZBfjD/dtl3DqzCY/wmORsr33fli3lI598z0 uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkv8mmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:59:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HI0GIn012573;
	Wed, 17 Apr 2024 18:59:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwhbxjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:59:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HIxdmr026239;
	Wed, 17 Apr 2024 18:59:40 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-65-140-165.vpn.oracle.com [10.65.140.165])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xgkwhbxhc-2;
	Wed, 17 Apr 2024 18:59:40 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, vbabka@suse.cz,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        junxiao.bi@oracle.com
Subject: [PATCH v2 1/1] slub: limit number of slabs to scan in count_partial()
Date: Wed, 17 Apr 2024 11:59:38 -0700
Message-ID: <20240417185938.5237-2-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240417185938.5237-1-jianfeng.w.wang@oracle.com>
References: <20240417185938.5237-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_16,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404170136
X-Proofpoint-ORIG-GUID: jdvXbnSCRn9YRfbIdXYvMB6viwMeTQjb
X-Proofpoint-GUID: jdvXbnSCRn9YRfbIdXYvMB6viwMeTQjb

When reading "/proc/slabinfo", the kernel needs to report the number
of free objects for each kmem_cache. The current implementation uses
count_partial() to count the number of free objects by scanning each
kmem_cache_node's list of partial slabs and summing free objects
from every partial slab in the list. This process must hold per
kmem_cache_node spinlock and disable IRQ, and may take a long time.
Consequently, it can block slab allocations on other CPU cores and
cause timeouts for network devices and so on, when the partial list
is long. In production, even NMI watchdog can be triggered due to this
matter: e.g., for "buffer_head", the number of partial slabs was
observed to be ~1M in one kmem_cache_node. This problem was also
confirmed by several others [1-3].

Iterating a partial list to get the exact count of objects can cause
soft lockups for a long list with or without the lock (e.g., if
preemption is disabled), and is not very useful too: the object
count can change right after the lock is released. The approach of
maintaining free-object counters requires atomic operations on the
fast path [3].

So, the fix is to limit the number of slabs to scan in count_partial().
Suppose the limit is N. If the list's length is not greater than N,
output the exact count by traversing the whole list; if its length is
greater than N, then output an approximated count by traversing a
subset of the list. The proposed method is to scan N/2 slabs from the
list's head and the other N/2 slabs from the tail. For a partial list
with ~280K slabs, benchmarks show that this approach performs better
than just counting from the list's head, after slabs get sorted by
kmem_cache_shrink(). Default the limit to 10000, as it produces an
approximation within 1% of the exact count for both scenarios.

Benchmarks: Diff = (exact - approximated) / exact
* Normal case (w/o kmem_cache_shrink()):
| MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
| 1000        |  0.43  %              |  1.09  %              |
| 5000        |  0.06  %              |  0.37  %              |
| 10000       |  0.02  %              |  0.16  %              |
| 20000       |  0.009 %              | -0.003 %              |

* Skewed case (w/ kmem_cache_shrink()):
| MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
| 1000        |  12.46 %              |  6.75  %              |
| 5000        |  5.38  %              |  1.27  %              |
| 10000       |  4.99  %              |  0.22  %              |
| 20000       |  4.86  %              | -0.06  %              |

[1] https://lore.kernel.org/linux-mm/
alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
[2] https://lore.kernel.org/lkml/
alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
[3] https://lore.kernel.org/lkml/
1e01092b-140d-2bab-aeba-321a74a194ee@linux.com/T/

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/slub.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..7e34f2f0ba85 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3213,6 +3213,8 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
+#define MAX_PARTIAL_TO_SCAN 10000
+
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
@@ -3221,8 +3223,30 @@ static unsigned long count_partial(struct kmem_cache_node *n,
 	struct slab *slab;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(slab, &n->partial, slab_list)
-		x += get_count(slab);
+	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
+		list_for_each_entry(slab, &n->partial, slab_list)
+			x += get_count(slab);
+	} else {
+		/*
+		 * For a long list, approximate the total count of objects in
+		 * it to meet the limit on the number of slabs to scan.
+		 * Scan from both the list's head and tail for better accuracy.
+		 */
+		unsigned long scanned = 0;
+
+		list_for_each_entry(slab, &n->partial, slab_list) {
+			x += get_count(slab);
+			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
+				break;
+		}
+		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
+			x += get_count(slab);
+			if (++scanned == MAX_PARTIAL_TO_SCAN)
+				break;
+		}
+		x = mult_frac(x, n->nr_partial, scanned);
+		x = min(x, node_nr_objs(n));
+	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
-- 
2.42.1


