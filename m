Return-Path: <linux-kernel+bounces-125933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A07892E5F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC71282531
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 02:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249051396;
	Sun, 31 Mar 2024 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sSAxXW/v"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7A910E3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711853468; cv=none; b=S29mWpT0WAluwrCFYOg2SUL7rg20CutUt89aiDpgComxQoavtVcTuj4X2QCC6dtyy/n6wpDXcEEDmgd9lXtZhcfTYHOjxkMaPeRZ3ghlNU98niJEya0Wlf04vyFVu2/51CwgNOiBkxnpLH/R1q6q8c24ep8uLbwXHysUPqUkcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711853468; c=relaxed/simple;
	bh=BxD8Njt7gNZ1cuGYp6dNqZIZLAXLDATufHYVay932/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2E5oHSL/jIMzSIdFV3OKfpqnj1iLZQcIgIcv2vRLcsGLFAGMEv4GGW1ZGfR60hIPVoHbhiTZLF10E217tx4V05hPe6TZ2XZyUznioWriGHsb/RY6pwsCUZdwwPUDbDQyyMkrwiXQtYqkTlZyEhdqRcGa+ZvTK2KgR5CN5nk8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sSAxXW/v; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42V2ErUB022442;
	Sat, 30 Mar 2024 19:19:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=2+C0G4UMINVUvGYbirPlCl5FdouMdwjB+cfew6a5HSU=; b=
	sSAxXW/vj4FqFQfKPs3OceQDoGWqXNT7bQyhdW4uLTQlGimBtrWTjytPKSxvHgGh
	xniDw9B7CwYkFhvofNo8KXUT17xWwCREDsr+K4OaRV9e/JhncU1YUU4K2JrRdlGK
	8NigrGt9fmFh6oNH5yVjftVou64QX6jAiIrKOzjB2ZXb2laK0qlcVxSNVnPfDOWM
	n69Xf4M+A3HZDaTEsd7gGPTiFae9vKY32tkBjQEhL+wmlfSPq2uISk4k6V1xN9rW
	NYkfKgwnSKh+EJ/rdCgTR4wxJYVQ0PCSm24Y3kscBEdrXFXVduwlPLGzd8+gq6gR
	jj6YdQzqbQbnlrSuS9roxw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10gm3s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 30 Mar 2024 19:19:49 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 19:19:44 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 30 Mar 2024 19:19:42 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH 3/4] mm/slub: simplify get_partial_node()
Date: Sun, 31 Mar 2024 10:19:25 +0800
Message-ID: <20240331021926.2732572-4-xiongwei.song@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331021926.2732572-1-xiongwei.song@windriver.com>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: axzpVre-xU6I8oY8XQ3o9V6gU5HlFFCK
X-Proofpoint-GUID: axzpVre-xU6I8oY8XQ3o9V6gU5HlFFCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310017

From: Xiongwei Song <xiongwei.song@windriver.com>

The break conditions can be more readable and simple.

We can check if we need to fill cpu partial after getting the first
partial slab. If kmem_cache_has_cpu_partial() returns true, we fill
cpu partial from next iteration, or break up the loop.

Then we can remove the preprocessor condition of
CONFIG_SLUB_CPU_PARTIAL. Use dummy slub_get_cpu_partial() to make
compiler silent.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 590cc953895d..ec91c7435d4e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2614,18 +2614,20 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 		if (!partial) {
 			partial = slab;
 			stat(s, ALLOC_FROM_PARTIAL);
-		} else {
-			put_cpu_partial(s, slab, 0);
-			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
+
+			/* Fill cpu partial if needed from next iteration, or break */
+			if (kmem_cache_has_cpu_partial(s))
+				continue;
+			else
+				break;
 		}
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (partial_slabs > s->cpu_partial_slabs / 2)
-			break;
-#else
-		break;
-#endif
 
+		put_cpu_partial(s, slab, 0);
+		stat(s, CPU_PARTIAL_NODE);
+		partial_slabs++;
+
+		if (partial_slabs > slub_get_cpu_partial(s) / 2)
+			break;
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return partial;
-- 
2.27.0


