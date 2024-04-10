Return-Path: <linux-kernel+bounces-139375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9B8A022D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0841C2180D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE8184103;
	Wed, 10 Apr 2024 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="jVUjLN+A"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3E1181CFA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784854; cv=none; b=kj0uxKhpcFTQip23hZA/4VxLQvSG4jPgPLinhkfewOBmgDO/YKnbS2UN22uZIOYnZSlSLTIr993s2YyKCP2qXU+rVMd0qe+4/gBJdWclSY3e99XOR1ioDOI1eJElq5/Sqp+4Yj2EUEm6zNjXbn2F1XWEZzhvpZqBREDg+ZhT9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784854; c=relaxed/simple;
	bh=cYW5LhbXUuaoKwEE8fqgAMeJi8JDDt+22q45/CtTucA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W1NAV+TDj7DZz/Dh/o8bAeCf0MB2SAnoaizAVOMl1Z8oXKV4exy9LTklFdUumDcaw1OFfVv0z4bJC0deIEsn4khJd3LGV50SS/I3gj5PsDreEkR7NhCSMjfhzSoz67J/fV75Ww7O57MPw+qNiEmRnzAnvQqPuxrV0qDSF/8tUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=jVUjLN+A; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AIDK1R014663;
	Wed, 10 Apr 2024 21:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=7JgzJN5VPRlEEQ5ycPOt47gziQCIQby+jN6Pm9OLEUc=;
 b=jVUjLN+AI002JiL4jT3xNBe7bq9shTGFF/AKz0yboDUc6niS8gaI2uDJ2R1qWIlI/BV8
 ieYbEd+Ofs2eawlrt+KBpSrjdmpTlFoqfuhMoly9dszypKLxhrCMaIcw9+jDgptrnJCX
 UkuQwyhtNkdQRhzPDorDmoFrARus9/9+JMRRfPUoDlb15II7monjHymdOTHCq5MKqv7f
 bKue/pp+gFpRG5E+cRkMOHkzSN8sHzJXZCoZWJ3qwNw3LfCTpKml211Jv3nNPDcvvU/L
 WVz5pLRToSobWx5hc5LT5j2m8jIoPeD6Eh3WMoYdW6vk8eWPiWqj/cyL6CEzy/pHY39s Yw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3xdyuth6dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 21:33:52 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id A35CD8005D6;
	Wed, 10 Apr 2024 21:33:41 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id CA5D6806B73;
	Wed, 10 Apr 2024 21:33:35 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
	id 4856F300009F6; Wed, 10 Apr 2024 16:33:32 -0500 (CDT)
From: Kyle Meyer <kyle.meyer@hpe.com>
To: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc: russ.anderson@hpe.com, dimitri.sivanich@hpe.com, steve.wahl@hpe.com,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2 2/2] sched/topology: Optimize topology_span_sane()
Date: Wed, 10 Apr 2024 16:33:11 -0500
Message-Id: <20240410213311.511470-3-kyle.meyer@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240410213311.511470-1-kyle.meyer@hpe.com>
References: <20240410213311.511470-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UEBJbjYY5Wctao-tAbrvrZIizgwfqnlQ
X-Proofpoint-ORIG-GUID: UEBJbjYY5Wctao-tAbrvrZIizgwfqnlQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=869
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100158

Optimize topology_span_sane() by removing duplicate comparisons.

Since topology_span_sane() is called inside of for_each_cpu(), each
pervious CPU has already been compared against every other CPU. The
current CPU only needs to be compared against higher-numbered CPUs.

The total number of comparisons is reduced from N * (N - 1) to
N * (N - 1) / 2 on each non-NUMA scheduling domain level.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..b6bcafc09969 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2347,7 +2347,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
-	int i;
+	int i = cpu + 1;
 
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
@@ -2359,9 +2359,7 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	 * breaking the sched_group lists - i.e. a later get_group() pass
 	 * breaks the linking done for an earlier span.
 	 */
-	for_each_cpu(i, cpu_map) {
-		if (i == cpu)
-			continue;
+	for_each_cpu_from(i, cpu_map) {
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
 		 * match the topology we're about to build, but that can only
-- 
2.44.0


