Return-Path: <linux-kernel+bounces-69718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F77858DB3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE582830C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BB1D527;
	Sat, 17 Feb 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HixjXUQy"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC71CD2A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155162; cv=none; b=Hq4Bb5vQmVrJfiMw+apWoU/FgxY+VhWPhob3ZyVJEjUYlTgN384A7svL3gQM9jBf4dxw1I7EylcDQOvSmriaaEPT8nHuHo1lKPOpZbJfPWLw6srfOXLLJ1ilHpsikvS2AP3lW3C2ipDGVaQ/XzjeH8enCja/VkZRDAkx1YF65Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155162; c=relaxed/simple;
	bh=syzmM7eUW3w//SDCJMEcCcBIvXx2NkPHU3sbMpurQzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9EjVtrs054TPLDoG0WAb8tWBLDf7jKmbvK8SzjvXCkOt2KoAcbcRsw+YSCYUrzeCNSHd/l46rYJwlPsgUYkxnJVBaumpNqiXi3aHS7mKmla43BuNDeoZkgimyIdN3Ljo7cN994YSUXXNuA2Qq5pnAw3sivs67BIYotiPPmg9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HixjXUQy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41H7AiHE020961;
	Sat, 17 Feb 2024 07:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=JMT3nuMNp6lUin7O78tqTAkdQ8dhNushNKvFxaKIJGA=;
 b=HixjXUQyKmHu24W/4DHsxhCHLYc/8h9qS3qNDFTbYmNNTm2gYc+dMzVk8q5zHTSdSkVl
 uSN5Bg/Hui39aiOklBpz/fC+NIchMhpNqMWXimJsGInUlpxwDm7D4b8buwKg8P3luPvT
 6o9dO60g8+2Tc+hiKeChPN02e/Ximz3hR1kCJmqLGdOHUGzk4ex1qFt97nIatHyEqh9r
 6KnEpPibprbboseZ2E0PKOG6kddssOV2LvOSlkNukyyZQATJN6Uz+Jt/3E3Vh3dlseeh
 4R8E5haMZ1gBoqm2SUYNbsvUA23BHFs+JAFQ573JVnVQjIVxS4mIVseyU2PFEZ7MqPdg 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waq8h0s0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:46 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41H7U7ia027144;
	Sat, 17 Feb 2024 07:31:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waq8h0ryy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:45 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41H623IR004247;
	Sat, 17 Feb 2024 07:31:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv10tun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 07:31:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41H7Vdn423986786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Feb 2024 07:31:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65542004E;
	Sat, 17 Feb 2024 07:31:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B043420040;
	Sat, 17 Feb 2024 07:31:36 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.53.171.174])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Feb 2024 07:31:36 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Aneesh Kumar <aneesh.kumar@kernel.org>, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
        Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/3] mm/mempolicy: Use the already fetched local variable
Date: Sat, 17 Feb 2024 01:31:33 -0600
Message-Id: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DMqtCxbRPBcpizXWL_iXGokDYCRMYDlh
X-Proofpoint-ORIG-GUID: ALbNl9CNixSrLoK-j4d-SrAX7YQwG9Md
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_04,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402170058

Avoid doing a per cpu read and use the local variable thisnid. IMHO
this also makes the code more readable.

Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..8478574c000c 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2526,7 +2526,7 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		if (node_isset(curnid, pol->nodes))
 			goto out;
 		z = first_zones_zonelist(
-				node_zonelist(numa_node_id(), GFP_HIGHUSER),
+				node_zonelist(thisnid, GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->nodes);
 		polnid = zone_to_nid(z->zone);
-- 
2.39.3


