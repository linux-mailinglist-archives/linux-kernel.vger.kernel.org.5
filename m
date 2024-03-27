Return-Path: <linux-kernel+bounces-122026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29B88F0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41C71F28593
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FA5153822;
	Wed, 27 Mar 2024 21:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4etqny1"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7A015359B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575094; cv=none; b=e6vcqdBs0h6c+KVsKQZiyhlNKRFK2TsGdIE8XnXgbN7P5NuMLBOSg/c7id54PNTtzYA7pLGaqFhL0C3k6Rs645zSRgWCyKDE5yZsJCbMP0umYmxw5jszXN+OBNAuDFY399BDLYOynjCUdZxKg2q2FfnvHgVXWxZVqqyrc6H4fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575094; c=relaxed/simple;
	bh=NB7Q6As5LCuC5IWAkmAIMr9K7a1mke7uPnTHkJnbklI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7fwZCZM41QwxfC12BMYcy168hu2cpfl6hDTzE1bpRAXiDiXKE007wpBPzhfrk2pvrmOvXTq5PeIPepY9ZNmQX+JgpTf+Ry82HKMlMBSYfzpWUhRGiAhLcE47rSG+4DVoUp5MdEX1nL1zt+KhHopGYT456f6ukd7dqRnDCU4MCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4etqny1; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so308081276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575090; x=1712179890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=S4etqny1LdnIfyfzpyk2YSUzXWSmvUC7xsEss2xNipHRbf/fhB/MCe/OMJWvfy+lIS
         /9QIldAWBdbcSLKYDwoADXt2CnhpwjcJ3h1WxbtY49Sbh97kIb4J9aeMHEJltDGhucQO
         ijKZcONCUZGSKvajoGqrYL4hh0Cw4lD+h0WsZet/KD514cF7eF/0CNl97pNB9TAkdRKT
         bJ9LKWeqwVThDGUEI9vuqUpgb+SWx9dJHMRdtcvswfNn7GiUwfzp4U/DyfseM7FYwkBw
         kzPdPKJ4U+NjoIfEOzZuOjcj7BoPzIPd7pC/aq43X/1lgxtXGGLqmVAfCvZfYD/5kFjR
         tCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575090; x=1712179890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Eobqr0LFBQ4KWjEX1Ii2cj/j9a00dqkQu19UHFfuM=;
        b=TRgQrQxMsYU2vpKQgZVL2nl0Cmv4+xXorcKD5QR/Cf3+Ui1inlcsiiYfHPydR0wlGX
         aJhWvN/piON/ov3StlSqSDu5rNbcyEmZ4Uys/Kivp+rUeJZAhr5l4eJQ5o9j4tpXIQ+N
         jzCw90qpadlVPHO7g381VcRYw2UfFvPFi33ZnRK7ohm3gPiBob6/fodxclqgdFibVRwi
         EXPJKOvhUAFFodFBHg/0IGFx9uv+rrL6eKuMO+pDG+0hdl8DxD6oQJ5HZYSwK8xXXPmG
         0U0BuZqMwJa/qoqyGlV8Ob3NbHzaWeKUIX1c3JYM1ZxAZUPi3E3oJvk1SGtiyMfbFSci
         F7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUkjeBmFuNAq/PF9h975xoHZOvJD8i8IcVaNVo6UcUf6kg8Mu8LbPgmIHPJqXHttNS+iKvchkg1epN9aABQyLvy5flJGPsxI6B4Shas
X-Gm-Message-State: AOJu0YyBzbFpzB+GSp6Q8tzaBLDOQjYl/Ginh3t0w3zecxBHjzFlHKeb
	2Y3+N8B9nlIe4ebIQLLv+pCEyQWSi63KZhnwfEMfrtiBJ9fyDhnfKHQPXuLGLKLf/OPuNvMb/6z
	bZduU1A==
X-Google-Smtp-Source: AGHT+IEtjKFm0aB/GkGE7TLyxEpzw6bgXLiicKkfzUR/Ki0/1kiBkWenomFbSpLy63KHaGIYhCLu0OSP/VuU
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:2311:b0:dbe:d0a9:2be8 with SMTP
 id do17-20020a056902231100b00dbed0a92be8mr116972ybb.0.1711575090119; Wed, 27
 Mar 2024 14:31:30 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:31:00 -0700
In-Reply-To: <20240327213108.2384666-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327213108.2384666-1-yuanchu@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-2-yuanchu@google.com>
Subject: [RFC PATCH v3 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the accessed bit and promptly ignore the accessed bit on the
pte because it's on a different node, so the walk does not update the
generation of said page. When the next scan comes around on the right
node, the non-leaf pmd accessed bit might remain cleared and the pte
accessed bits won't be checked. While this is sufficient for
reclaim-driven aging, where the goal is to select a reasonably cold
page, the access can be missed when aging proactively for measuring the
working set size of a node/memcg.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..1a7c7d537db6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3522,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.44.0.396.g6e790dbe36-goog


