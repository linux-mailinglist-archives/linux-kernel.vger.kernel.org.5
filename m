Return-Path: <linux-kernel+bounces-90440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0292886FF33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801011C21F43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FDD36B1E;
	Mon,  4 Mar 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErcpOEPx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145322615
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548735; cv=none; b=Z9WJDoAP7GOrEB0j9H7FBWOdzli2mSplt1pDT4qx+7kNd6shbAtd80TLGanvOWVcpFT+YLd6jNXsaPVrrgJXuawK6xk8YePzGZd0Qm5O2ALbhWxNdJVJiuqeGDNQ2RoFma0F3sjKr86zx7v9FGpZ3EGb2tXhbP+YsFi3nBp5XRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548735; c=relaxed/simple;
	bh=Mju5/GnHzcWO7zcnCuf4LaHAlV+7GUDHNxZW9EM5gbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=am+VKyRD6FriTuhwbPIVM2CQgDg6QEfE+8VeJutB9PRzIl8TD1RzYMw3yiJqaDDehsVQarEQZ+c7rmVdafo96cYeyuK06vD+fg0wbiK0XVX0Zp8qdqqRenosrYKZ/Lkt5RetEhA4TnIHAsemoPyklLtdsZIx/o0FuxchIaXljM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErcpOEPx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc139ed11fso41044395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709548733; x=1710153533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u9xib0zn6DxdjtfkNrv9JmBdK0ttpN1YNsPL7qmo/GU=;
        b=ErcpOEPxZjMOoM/B/WTmMHSPEk0lIPLoE9obchuJg0n9zLtG33HuJ916QNC/ar6tpG
         sNI7lmgSZO2rOiONNqZRq/xnoPp5vfO7f5OaqMMrDl25z+lKCkhrfLAyEjiz47uMKLZD
         7XOT1zIrE4htWunj/rQ32/whPPKOeRKpzElTf6TPnlu/UcDP+BywhcQgtexp8fH5vGkx
         SqFx700QNw5VZE1zsFRpRfK1rJqUVsGYKWGVqGVRE7f4dkXh8gcl03HUdrSvTH8GuXrR
         zl/sM9/EgpyGcKK261jKFOVVIIegmMjIy2JX6eNmsk1RVdff42BjxGCwmNUa1w5AV96r
         hz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548733; x=1710153533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9xib0zn6DxdjtfkNrv9JmBdK0ttpN1YNsPL7qmo/GU=;
        b=fpx3QvypM8vNyqTLwCfL5DApNpc/mvq4zZINPtNdwl6v+b1vhNjZNzMOMhFuirYtBn
         xsEmMvWoIDQYffahu51NHqMLvrwZZuSOZoLYLbDrtHChUv1NB6keDW9/vtNybiW9f1Nu
         6fiHN7peBGBDlUmNC7iGKuAKuGGMca+kHxlkYHZjZepLZeT8H15/NZBV653n25B5BWSk
         w05R/nqvAUoxxRRvJC9OqbF1p3EOcBoBlIrCxtgjoSnQxbV1Qm2HzQS1IYCyORMobVwP
         1Qz8/1UolEnhtD113fW3EUX5nB4NuTb57ArOikcZQbIheqY925W9TZimiBQOjghuBsrg
         wxRg==
X-Forwarded-Encrypted: i=1; AJvYcCWYVdeO49H0Im4qYb9+m7YbTmVYfXa6RNzoXmH3bZTfuIoz8pPs/aI8zhcQMURMFyRVUUKdAcz84AD9kbbW7f+NouHWgCNKQFrAWFo0
X-Gm-Message-State: AOJu0YxmUDHmxPyVHObPZyENv+3C3Yc7N+X/oZsbjbn2efrU0Xr/Szyj
	SOreo/ZefoEhlaC6gvRshzT/VqH7yZY2mmkJ3hVmNcPtXUeNynMR
X-Google-Smtp-Source: AGHT+IFmoKVAtF+GXy5ODBZzD42hce3IaMAp4LlRX2Yzk0I94KqRWvyUY7YAzw9qGGvI48UNdNdKag==
X-Received: by 2002:a17:902:e54a:b0:1dd:4cb:cc57 with SMTP id n10-20020a170902e54a00b001dd04cbcc57mr6344173plf.0.1709548733322;
        Mon, 04 Mar 2024 02:38:53 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id lh6-20020a170903290600b001dc23e877c1sm8201654plb.265.2024.03.04.02.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:38:26 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: david@redhat.com,
	ryan.roberts@arm.com,
	chrisl@kernel.org,
	yuzhao@google.com,
	hanchuanhua@oppo.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	ying.huang@intel.com,
	xiang@kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>
Subject: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a large folio
Date: Mon,  4 Mar 2024 23:37:57 +1300
Message-Id: <20240304103757.235352-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

page_vma_mapped_walk() within try_to_unmap_one() races with other
PTEs modification such as break-before-make, while iterating PTEs
of a large folio, it will only begin to acquire PTL after it gets
a valid(present) PTE. break-before-make intermediately sets PTEs
to pte_none. Thus, a large folio's PTEs might be partially skipped
in try_to_unmap_one().
For example, for an anon folio, after try_to_unmap_one(), we may
have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
So folio will be still mapped, the folio fails to be reclaimed.
What’s even more worrying is, its PTEs are no longer in a unified
state. This might lead to accident folio_split() afterwards. And
since a part of PTEs are now swap entries, accessing them will
incur page fault - do_swap_page.
It creates both anxiety and more expense. While we can't avoid
userspace's unmap to break up unified PTEs such as CONT-PTE for
a large folio, we can indeed keep away from kernel's breaking up
them due to its code design.
This patch is holding PTL from PTE0, thus, the folio will either
be entirely reclaimed or entirely kept. On the other hand, this
approach doesn't increase PTL contention. Even w/o the patch,
page_vma_mapped_walk() will always get PTL after it sometimes
skips one or two PTEs because intermediate break-before-makes
are short, according to test. Of course, even w/o this patch,
the vast majority of try_to_unmap_one still can get PTL from
PTE0. This patch makes the number 100%.
The other option is that we can give up in try_to_unmap_one
once we find PTE0 is not the first entry we get PTL, we call
page_vma_mapped_walk_done() to end the iteration at this case.
This will keep the unified PTEs while the folio isn't reclaimed.
The result is quite similar with small folios with one PTE -
either entirely reclaimed or entirely kept.
Reclaiming large folios by holding PTL from PTE0 seems a better
option comparing to giving up after detecting PTL begins from
non-PTE0.

Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/vmscan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0b888a2afa58..e4722fbbcd0c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
+			/*
+			 * if page table lock is not held from the first PTE of
+			 * a large folio, some PTEs might be skipped because of
+			 * races with break-before-make, for example, PTEs can
+			 * be pte_none intermediately, thus one or more PTEs
+			 * might be skipped in try_to_unmap_one, we might result
+			 * in a large folio is partially mapped and partially
+			 * unmapped after try_to_unmap
+			 */
+			if (folio_test_large(folio))
+				flags |= TTU_SYNC;
 
 			try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
-- 
2.34.1


