Return-Path: <linux-kernel+bounces-130959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B2898121
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0131F21D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6C6495FD;
	Thu,  4 Apr 2024 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DK16AvjF"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C048788
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210371; cv=none; b=btFl4ZP+uNAxFcp9DatcPjykY9myqMmu/0VHtEf6XdfZwCLyhO+4F1Lm4t7rMcsS/WwylrkeJ8w09MtfoBOuMeMc3rtUWOVaFhOTqd3YO59NQwQWcGbreLz5epTnE0zdPllWnbRC3KaYYcs5vMrKgP/Y6dudmUiY1ry1eb2jMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210371; c=relaxed/simple;
	bh=NQ+BfK4nleuI2Do9g/iZmGss/EFlpHre9fcaunDLuek=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2ozUxYD3lI26BW/2C1wRqzK8sn4bL47C3Hh0H51wSWNG2pgF2encQuf89dOLLMjqNe2EoNZj1z2GsIvlFIw7flciM64zOawnT3jTu+AkEsaAoVVhFiPCocpufJzgFlfqtmXiWw5l4nsDcNMP4XS/feKShXLyWS+zZFPi0dIoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DK16AvjF; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4344vEJ5006418;
	Thu, 4 Apr 2024 05:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=/rH/4dIIFl0tP0DZ8KBYwKtVJ20Qari0JGnwd0w4aJA=; b=
	DK16AvjFscZbHJfWB3SOOHjr7Yax33Mv64mMZqqHthRLfqi02cOn086ofAxfuDAv
	BHRa9/64buMKJWrGm1zJoZHegHBh7Mq7cuSORoXIwpHBfBKJgpGyrsrVrKsl3JKb
	u6DQOric5Bi+s73hvdxWAr/eVix587befoksPj11jEukxowZ54Oqde+aOfeZDWTu
	dmVdHSKZclKirlZxPa2s9gag/m+3BxTpmmMWFPEExYtMjFjDwepl1u07wX74x7lF
	ZV23UNuae87o013Qfgjap/9jqcytoj7dsVImzdcmXNxVa6uowkPDijafP/lr8cRs
	tlur3KKB9SIAo6CruK5ybQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x9epk89h3-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 04 Apr 2024 05:58:55 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 3 Apr 2024 22:58:46 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 3 Apr 2024 22:58:43 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH v2 3/3] mm/slub: simplify get_partial_node()
Date: Thu, 4 Apr 2024 13:58:26 +0800
Message-ID: <20240404055826.1469415-4-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240404055826.1469415-1-xiongwei.song@windriver.com>
References: <20240404055826.1469415-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: iScp0TsPV-TMjLRsoPJ93q7ds1TOZWuW
X-Proofpoint-ORIG-GUID: iScp0TsPV-TMjLRsoPJ93q7ds1TOZWuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040036

From: Xiongwei Song <xiongwei.song@windriver.com>

The break conditions for filling cpu partial can be more readable and
simple.

If slub_get_cpu_partial() returns 0, we can confirm that we don't need
to fill cpu partial, then we should break from the loop. On the other
hand, we also should break from the loop if we have added enough cpu
partial slabs.

Meanwhile, the logic above gets rid of the #ifdef and also fixes a weird
corner case that if we set cpu_partial_slabs to 0 from sysfs, we still
allocate at least one here.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---

The measurement below is to compare the performance effects when checking
if we need to break from the filling cpu partial loop with the following
either-or condition:

Condition 1:
When the count of added cpu slabs is greater than cpu_partial_slabs/2:
(partial_slabs > slub_get_cpu_partial(s) / 2)

Condition 2:
When the count of added cpu slabs is greater than or equal to
cpu_partial_slabs/2:
(partial_slabs >= slub_get_cpu_partial(s) / 2)

The change of breaking condition can effect how many cpu partial slabs
would be put on the cpu partial list.

Run the test with a "Intel(R) Core(TM) i7-10700 CPU @ 2.90GHz" cpu with
16 cores. The OS is Ubuntu 22.04.

hackbench-process-pipes
                  6.9-rc2(with ">")      6.9.0-rc2(with ">=")
Amean     1       0.0373 (   0.00%)      0.0356 *   4.60%*
Amean     4       0.0984 (   0.00%)      0.1014 *  -3.05%*
Amean     7       0.1803 (   0.00%)      0.1851 *  -2.69%*
Amean     12      0.2947 (   0.00%)      0.3141 *  -6.59%*
Amean     21      0.4577 (   0.00%)      0.4927 *  -7.65%*
Amean     30      0.6326 (   0.00%)      0.6649 *  -5.10%*
Amean     48      0.9396 (   0.00%)      0.9884 *  -5.20%*
Amean     64      1.2321 (   0.00%)      1.3004 *  -5.54%*

hackbench-process-sockets
                  6.9-rc2(with ">")      6.9.0-rc2(with ">=")
Amean     1       0.0609 (   0.00%)      0.0623 *  -2.35%*
Amean     4       0.2107 (   0.00%)      0.2140 *  -1.56%*
Amean     7       0.3754 (   0.00%)      0.3966 *  -5.63%*
Amean     12      0.6456 (   0.00%)      0.6734 *  -4.32%*
Amean     21      1.1440 (   0.00%)      1.1769 *  -2.87%*
Amean     30      1.6629 (   0.00%)      1.7031 *  -2.42%*
Amean     48      2.7321 (   0.00%)      2.7897 *  -2.11%*
Amean     64      3.7397 (   0.00%)      3.7640 *  -0.65%*

It seems there is a bit performance penalty when using ">=" to break up
the loop. Hence, we should still use ">" here.
---
 mm/slub.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 590cc953895d..6beff3b1e22c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2619,13 +2619,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 			stat(s, CPU_PARTIAL_NODE);
 			partial_slabs++;
 		}
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (partial_slabs > s->cpu_partial_slabs / 2)
-			break;
-#else
-		break;
-#endif
 
+		if ((slub_get_cpu_partial(s) == 0) ||
+		    (partial_slabs > slub_get_cpu_partial(s) / 2))
+			break;
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return partial;
-- 
2.34.1


