Return-Path: <linux-kernel+bounces-149096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948C8A8BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D278F1F21549
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81041381BA;
	Wed, 17 Apr 2024 19:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mI0r/4up"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A856383AC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713380403; cv=none; b=Lni3EaMGzFpqkbGCTfnbp2nqDQnsnlTks2ENptaisZtP33wXZtQyVuzgyJaLIKChEFN6DTSOxGh5+SsWPwhsZswFItl/twNrWjIIXOCsPKRPXO2najW7UzeMMztan6QGuUE8byWHc4ReTkJAi6RdGbSZjCe/+q8TpdmBHnZTT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713380403; c=relaxed/simple;
	bh=tuV+qPoXQpGm4H3YRj7CO/TxtGIzN2KTYn38mOU54hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvXXLVYVw30wlnSf+L18MmawYX9GUjqwbqmSuC+y+Igi5fXif252MESWpBbWvezKWodXG2GRpW7zRX8n3TJSQ0Jn6w6n0XteAlZAA3OOOeMFkJrGZ6VgEFGGCP8r+a1X+9DBp9ryn7454X56TvPVl3H4FbJs/paDZdqGEAGsEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mI0r/4up; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HHiM9Y005952;
	Wed, 17 Apr 2024 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=9v67SsM86RHd+fq1rQ349Md4AubcsHfvAyQsA3MVFJM=;
 b=mI0r/4up/xr2QNH8dwUyZLCnu1R4MSJh0AJkbntUZCyCbfBojepeT/Zf+snMF1aHjOze
 F/ilLS91wus6BeNIstW/DWGkt9tI6a+u5Xvj1z0faMQyVznEqH9oAfeWT+4mgUczC3d8
 68H0Cm521xUDy7Q0GKID0TBPqaaeT7A4DdLQJlQKlk+zAUdnb7d9KMO33k47aN8CIflI
 lPL8XPzFn/kibEDUL5J9V/m4GFeJoIyR4Kc0RMSWDuaEQNa7Y6JWlbJiHZRZKxkmwKL4
 J8x/2B0uo43PcksMl63/F5S5QJYgL/cTuCzi8cl1Q7YKTjSBv89plNap6IblYvk1K5HJ ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfhxbrjx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:59:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43HIZmGN012528;
	Wed, 17 Apr 2024 18:59:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwhbxj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 18:59:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43HIxdmp026239;
	Wed, 17 Apr 2024 18:59:39 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-65-140-165.vpn.oracle.com [10.65.140.165])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xgkwhbxhc-1;
	Wed, 17 Apr 2024 18:59:39 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, vbabka@suse.cz,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        junxiao.bi@oracle.com
Subject: [PATCH v2 0/1] slub: limit number of slabs to scan in count_partial()
Date: Wed, 17 Apr 2024 11:59:37 -0700
Message-ID: <20240417185938.5237-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
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
X-Proofpoint-ORIG-GUID: OGG2cmFhFCqRvHMNTfKVATP0M2zuI7z7
X-Proofpoint-GUID: OGG2cmFhFCqRvHMNTfKVATP0M2zuI7z7

This patch fixes a known issue in get_slabinfo() which relies on
count_partial() to get the exact count of free objects in a
kmem_cache_node's partial list. For some slub caches, their per-node
partial list can be extremely long. The current version of
count_partial() traverses the partial list to get the exact count of
objects while holding the kmem_cache_node's spinlock. This process
may take a long time, during which slab allocations are blocked and
IRQs are disabled. In production workloads, even NMI watchdog can be
triggered due to this matter. Moreover, getting the exact count of
objects may not be useful as well: the count may change right after
the spinlock is released and re-captured by others.

The proposed fix is to limit the number of slabs to scan, and output
an approximated object count for a long partial list. The v1 patch
counts N slabs from the list's head and then uses it to approximate
the total object count in the list. As suggested by Vlastimil, an
alternative method, i.e., counting N/2 from both the list's head and
tail, produces a more accurate approximation after the partial list
is sorted by kmem_cache_shrink().

---
Changes since v1 [1]
 - Update the approximation method by counting from the list's head and tail
 - Cap the approximation by the total object count
 - Update the commit message to add benchmark results and explain the choice

[1] https://lore.kernel.org/linux-mm/20240411164023.99368-1-jianfeng.w.wang@oracle.com/

Thanks,
--Jianfeng

Jianfeng Wang (1):
  slub: limit number of slabs to scan in count_partial()

 mm/slub.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

-- 
2.42.1


