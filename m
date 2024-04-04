Return-Path: <linux-kernel+bounces-130958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B68898120
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B210E1F22F86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B0845942;
	Thu,  4 Apr 2024 05:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="MOLy/vTn"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F717991
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210359; cv=none; b=BGvvxYT42nj+u8hCdi217weALNUFqEFvjX6DYOdkcVm33heNSkXSLMhCyeVC19NIqaBte4GmssFk5tLp71Kj0WrJyzw+LB5cRPGEADdcuV7Iui3N6IXB+FOP6bVRiucPbBGimjgDTQyj8xovkhEhi4o5drkNebdhR/u4Cu3zGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210359; c=relaxed/simple;
	bh=67kxMxBFVgKuDFsm3/aONhz4o7hUjpdqmsftgI1S7cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deHDGSGyzeYRZc19DclWVzWwWzxzE/8y56nthJxsr4t4tWhevt2Nfn+NEVrpmCGhQv6rcq6nYA4kgpTFmjccUH303gaBNWSY5phH2YNNVK5mvBWH0NUkmTTxZg+Y35SS9dww4H6SVtsN3BLeC6B7sgc/P0TkQmio+i4BJhIWKlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=MOLy/vTn; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4345pCBe000392;
	Wed, 3 Apr 2024 22:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=yRxDl0C91mFi8jNJ4adnSczKE9V9/dpVGwj8Nv3DPtw=; b=
	MOLy/vTnWdi4Ev0bU9R08m5bbCKnjCW/Rhh4hBW8IglLPXzQ8lyEvWq8S4xiGYTf
	oIPAIlUJS3M+3WRa1LF/7E/8GV8X8TMUSuHDfQVqxjkGskWhMHjtxpaB/4ewgbhs
	oSABaRZ550NPU1nwOladPWALO6WZOj4FocC9Gnubo5lVu9BTkWgKaVElFEvyQ5Hg
	Y+PrHwxQ2UHeN1IVo3BteCLhEYRkQ2KB/QvdB0mq8szhlDRfg3E5vHwlq73v6e9j
	CqAxOBsm+1NrS4D28j/UniuW8LEdWcoK1ivxROekhhiNFug3WJRMzYhMfSDKdWv4
	Q9sSmdstNEeRiMTL7iE80Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x9eqeg9gs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 03 Apr 2024 22:58:40 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 3 Apr 2024 22:58:39 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Wed, 3 Apr 2024 22:58:36 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH v2 1/3] mm/slub: remove the check of !kmem_cache_has_cpu_partial()
Date: Thu, 4 Apr 2024 13:58:24 +0800
Message-ID: <20240404055826.1469415-2-xiongwei.song@windriver.com>
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
X-Proofpoint-ORIG-GUID: NjyypOTjHp702Ozz0uySYQA1ADPV3hsD
X-Proofpoint-GUID: NjyypOTjHp702Ozz0uySYQA1ADPV3hsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_02,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040037

From: Xiongwei Song <xiongwei.song@windriver.com>

The check of !kmem_cache_has_cpu_partial(s) with
CONFIG_SLUB_CPU_PARTIAL enabled here is always false.

We have already checked kmem_cache_debug() earlier and if it was true,
then we either continued or broke from the loop so we can't reach this
code in that case and don't need to check kmem_cache_debug() as part of
kmem_cache_has_cpu_partial() again. Here we can remove it.

Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
---
 mm/slub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..059922044a4f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2610,8 +2610,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 			partial_slabs++;
 		}
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-		if (!kmem_cache_has_cpu_partial(s)
-			|| partial_slabs > s->cpu_partial_slabs / 2)
+		if (partial_slabs > s->cpu_partial_slabs / 2)
 			break;
 #else
 		break;
-- 
2.34.1


