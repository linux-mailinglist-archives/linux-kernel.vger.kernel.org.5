Return-Path: <linux-kernel+bounces-125934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE71892E60
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D7F1F218C9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3F15A5;
	Sun, 31 Mar 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="gwfOb1zE"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B110E3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711854078; cv=none; b=ZUwSh5gDYM1iCDjy/3YCTp11WB92ck5M57IeFGhZW1Wp9DtHwmUzF0nwDS9a+UjWeiMxaj8ued+UHrgl9oLUyr0Sfps7IVy4umtce8QL8a+QOcLx+bccOJWoKdLlijbxLU4qkvquidlB4NsPTbYod8h28iLVW5F2yzuO/1PqUr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711854078; c=relaxed/simple;
	bh=KhXvF+KAdr/td4fs1u9s6Yt+uWESzDKG4g2Pe6ecijE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5+yhEaNh8ADLcHXuwnv1NVNwS3V0x/gZg9T4iu5aHAMWRpr7qlgPXpPbpwePQvX4xgA658BJ45/FHQKdl/lt4A0MURVQHyGhS+VXn3snf0agUH1FPU5xYb3IP64SBRZR37tjiz7NUvfnJAExN3uoSd/iFt5H9PguCW22cyO6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=gwfOb1zE; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 42V2ErU9022442;
	Sat, 30 Mar 2024 19:19:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=WVlSUo49HtpAFry+bBylUU9Uqkodhn8z8Pc9shjqA/4=; b=
	gwfOb1zEbPwsYph/XKE+HxCVPc6biFJuwXO1NJvv0XW4Xaqz2qxqJJ8qLhKeySL1
	k/g+bwYNXBqO2UsKzK/vOlEh1X747O3Cw791Yq9EUB5FK3cyqvc/3waZ3ekQTLGL
	2zxR29OuCmU2SGnwr7Z7JtlE1510xuRh2mlLKfCe1i4RGhSX0E866vwn0/h012ue
	UoBMqQW+OrdKI5eAv4MGcE8Cdfe/pZ2WdP5Mk6DB/IIFC+26LeM0SdK+zkO6ogSk
	fSo2DlV7aNyUxPN9YBwL1k7aoF5tMa1cytc7fhrJRJT1G3LFpyAHPko7Ze4HxaYz
	QtzIDYpXGkTfiPQEGFVr3g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3x6e10gm3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 30 Mar 2024 19:19:49 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 19:19:38 -0700
Received: from pek-lpd-ccm5.wrs.com (147.11.1.11) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37 via Frontend Transport; Sat, 30 Mar 2024 19:19:36 -0700
From: <xiongwei.song@windriver.com>
To: <vbabka@suse.cz>, <rientjes@google.com>, <cl@linux.com>,
        <penberg@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <akpm@linux-foundation.org>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>
Subject: [PATCH 1/4] mm/slub: remove the check of !kmem_cache_has_cpu_partial()
Date: Sun, 31 Mar 2024 10:19:23 +0800
Message-ID: <20240331021926.2732572-2-xiongwei.song@windriver.com>
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
X-Proofpoint-ORIG-GUID: 1uqYCL0NLvDL19Ws2dkU89gAZ7AjMDv1
X-Proofpoint-GUID: 1uqYCL0NLvDL19Ws2dkU89gAZ7AjMDv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403310017

From: Xiongwei Song <xiongwei.song@windriver.com>

The check of !kmem_cache_has_cpu_partial(s) with
CONFIG_SLUB_CPU_PARTIAL enabled here is always false. We have known the
result by calling kmem_cacke_debug(). Here we can remove it.

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
2.27.0


