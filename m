Return-Path: <linux-kernel+bounces-10290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C381D244
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731061C22653
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215F4A12;
	Sat, 23 Dec 2023 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvbmwT3o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570C3D71
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e7b49e15c1so35985597b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 20:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703307410; x=1703912210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4v/LYlLycZFodA3ctHFCW6YVtoXi+WcqMYLGsHPgX1s=;
        b=qvbmwT3okTcSzLpP1Gfg7+dSpuIn92hTISDSJrolA6J+O+AzlpBAV8zcTO+4WJd5mQ
         8seXEb9uPo2m7g2rhlfxdiOPJqHeoobmXWhR/Y99VYhgZMTBmm7MuY9dgTiHO1WEMzBw
         GH+F+bj9swy7BHfp6HBzbrbNfZcq9O1mPWq3h5XDVn/Cr8llrM6Qt+aIbOr9IEPis1Zd
         NsdoTX6/GKLpFT8goKioRrK2+w0Sl8h2SpXCzx3HoR3VveVEj8nn/JJKduhjAL/IUaqe
         KmUjcacQIZ/UE0y4PS2Sb6Q2bIEvztMXWCQS+DY10yP2vCJdr2Mj1agEdOQ0abfJ6QqM
         fVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703307410; x=1703912210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4v/LYlLycZFodA3ctHFCW6YVtoXi+WcqMYLGsHPgX1s=;
        b=kXQg0mJldj9bi2f/wuIkFkRfVURNJu32HxtFPXU5MuvU9nvGBl3VeWsjH/WuR3cF5I
         GWOhUUgUoOF23K1BH7BgZAE/kMNBJeYM0dndq9QQDuSDv5Vnl76uL22VxLYX0xtf3ivb
         PZHvWZbyRg29mBOJf0DY4NmZisKZo/rgc/pwmjVO3G+5EqReqeu6wrREUgYTONUXT1W6
         e928kGsxiCYvFKqW8VPzZyHtZrrNWWmonbk33OCA+8SCwjC6y5SU30A5ZodSQaGNwlAF
         gDWMgX6+UkKGXK0MpKbxJQ7yMMnYYbaVPREgUepJ1sXWicFkGYyZb1BsJPzLPTyDbOxo
         IVIQ==
X-Gm-Message-State: AOJu0YzeKc9fgkopKP6m+3IuJ9E+ZAaoJPEaAblrAUGI1bzYk0jv3nN9
	49iLcENzAog06X0OpmODrmfQ3/oo7VdH5U0ILA==
X-Google-Smtp-Source: AGHT+IFFhHVArPPblD2DVYdTOdpn3Q5otdg4xxc2KJoUGdqMYAFIdZ+AH5uKiJdNpnmvJkxUPXRcr431E2g=
X-Received: from yuzhao2.bld.corp.google.com ([100.64.188.49]) (user=yuzhao
 job=sendgmr) by 2002:a05:690c:3604:b0:5e3:c8e7:3bc3 with SMTP id
 ft4-20020a05690c360400b005e3c8e73bc3mr1104118ywb.1.1703307410447; Fri, 22 Dec
 2023 20:56:50 -0800 (PST)
Date: Fri, 22 Dec 2023 21:56:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231223045647.1566043-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1] mm/mglru: skip special VMAs in lru_gen_look_around()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, syzbot+03fd9b3f71641f0ebf2d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Special VMAs like VM_PFNMAP can contain anon pages from COW. There
isn't much profit in doing lookaround on them. Besides, they can
trigger the pte_special() warning in get_pte_pfn().

Skip them in lru_gen_look_around().

Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: syzbot+03fd9b3f71641f0ebf2d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/000000000000f9ff00060d14c256@google.com/
---
 mm/vmscan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b4ca3563bcf4..3cf7066d627f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3959,6 +3959,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	int young = 0;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
+	struct vm_area_struct *vma = pvmw->vma;
 	struct folio *folio = pfn_folio(pvmw->pfn);
 	bool can_swap = !folio_is_file_lru(folio);
 	struct mem_cgroup *memcg = folio_memcg(folio);
@@ -3973,11 +3974,15 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	if (spin_is_contended(pvmw->ptl))
 		return;
 
+	/* exclude special VMAs containing anon pages from COW */
+	if (vma->vm_flags & VM_SPECIAL)
+		return;
+
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
 
-	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
-	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
+	start = max(addr & PMD_MASK, vma->vm_start);
+	end = min(addr | ~PMD_MASK, vma->vm_end - 1) + 1;
 
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
@@ -4002,7 +4007,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		unsigned long pfn;
 		pte_t ptent = ptep_get(pte + i);
 
-		pfn = get_pte_pfn(ptent, pvmw->vma, addr);
+		pfn = get_pte_pfn(ptent, vma, addr);
 		if (pfn == -1)
 			continue;
 
@@ -4013,7 +4018,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		if (!folio)
 			continue;
 
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+		if (!ptep_test_and_clear_young(vma, addr, pte + i))
 			VM_WARN_ON_ONCE(true);
 
 		young++;
-- 
2.43.0.472.g3155946c3a-goog


