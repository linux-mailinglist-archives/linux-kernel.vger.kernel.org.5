Return-Path: <linux-kernel+bounces-93669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712D873313
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E50B22FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B435EE70;
	Wed,  6 Mar 2024 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1zL/Ayf"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A505EE6D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718765; cv=none; b=Lk2IFAUfmcCmM4dYxZMccgF90W+PYDDm3L8Pm+RU7BOV+FN8yeSvC+GnzbYUppuONybd1eKf0tDrK+de+eP6Cw9WXnqz6RVyGr3lnpgbWZsNAP7yk3TWFXTWszIhO+8Far5K3cyLEqSKOVDCZ7CHOEBrVlI2B54ck5pG+5KyLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718765; c=relaxed/simple;
	bh=ZOF3B+ZvOLMqlUFPQNC6g75K+ciUHD24vQWBv4tLJyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jPKf7zE/mJG0ruXdqaNVHew3QiHELwvk3z1QongGUwWrWDZayaYZk+p5WeQr1u75KiB44pL9oeezfItFLaeP3azA/kqorDK44uo2zjVFC0XfeQvqZR85uhsEsXxjGHdW8SDYZZNFb/HlDSfUgSzrhayTgu5qJMCx4xpoeC6WFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1zL/Ayf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29a61872f4eso4766574a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 01:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709718763; x=1710323563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zubgQBhzmQBglHTVeH+hOy6HJUtzVF3pbAGw/V3QBpw=;
        b=I1zL/AyfVuXf8lVIQjOm2sbo9bFCbivHxbXIvqp9LMaeuLWpLu5g6KZoNQriPF25uM
         6rGzI317/gGe+85pnRw/e227J7zOqsmlao1UuOD6KbxLWdMS7yhxbDSFgA/SdtoCK2UP
         MI2m88MMm/GFNzTkcJ1CGsDbqxslThyjQf4RF61dYAvje5ETT6QS5FRLtsxuKr4asx74
         OYZZ0jzyvjcV0fHGnmTWhXQXq165+hORZlE5sYl9/gJPtQTFkxEvvun0Aw1+VdxG4VzV
         n7+n4cFc/SfodVUbXwzKZPVRGIqRA8SilRq+V+LTZ7xixJbbOSy0gXyrmARnUARJRcwH
         jkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709718763; x=1710323563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zubgQBhzmQBglHTVeH+hOy6HJUtzVF3pbAGw/V3QBpw=;
        b=wK5Y7DlT63mg2AM2M/A4CdxbNGwYXM4BhKpFI8WLLYSU41KSYZbZhl0l6oPR2hYTRG
         FN5ja6DRtvyxC12MSgun2x9jYErqXCHqnyuEoY9rWf+/4QSpKIZFRP2tDVIGupzWzyfA
         1cKhLGqlJrW504uontQ3pMxM0ms3RmsqwfAZ7qR5vpurV5s8S84/BLoxpYmMmFmUBjm8
         e8zldjKale6cMgSRFPzKpHdSofKawm/c/qh/zHoaXFE0Ia0zeoVyDhahzzqOVmN1Gfw2
         xV8L7+qnN7IY93CutWYZaG3XqBFdZcgVkY4u/Vy0dQFVYUq/26bC6OOrpUdwJmQV76Y2
         ls6w==
X-Forwarded-Encrypted: i=1; AJvYcCXQBkLPEMP5A+j/A2G6p75uGg2LUsElJghpNeIhCMFg2oZulAlL8wodv4+He8V5XdPuuwE3EVKT4jKT8R5OqyWwuk2DN7dn0fLI+sHH
X-Gm-Message-State: AOJu0YyRiFJFrgc559ThgRs3xg0M1JQqqRb3vzu9SBQegn/KFx0T0u3j
	t6OoKQawh9TfnhcM3aH0WoZwDUH4YExO1af/KWlQauda9jFdGGsX
X-Google-Smtp-Source: AGHT+IFAtV7h6EuOPK7Mwdi9iLAk9qFoL5TCAMjANfrYPXtTt1X0IrwtoFML2XrBPcYr8E+4p7CPmw==
X-Received: by 2002:a17:90a:948a:b0:29a:d01a:a32 with SMTP id s10-20020a17090a948a00b0029ad01a0a32mr13800145pjo.26.1709718762759;
        Wed, 06 Mar 2024 01:52:42 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ce17-20020a17090aff1100b0029b78a9a1desm818043pjb.32.2024.03.06.01.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:52:42 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	v-songbaohua@oppo.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com
Subject: [PATCH v2] mm: hold PTL from the first PTE while reclaiming a large folio
Date: Wed,  6 Mar 2024 22:52:19 +1300
Message-Id: <20240306095219.71086-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Within try_to_unmap_one(), page_vma_mapped_walk() races with other
PTE modifications preceded by pte clear. While iterating over PTEs
of a large folio, it only starts acquiring PTL from the first valid
(present) PTE. PTE modifications can temporarily set PTEs to
pte_none. Consequently, the initial PTEs of a large folio might
be skipped in try_to_unmap_one().
For example, for an anon folio, if we skip PTE0, we may have PTE0
which is still present, while PTE1 ~ PTE(nr_pages - 1) are swap
entries after try_to_unmap_one().
So folio will be still mapped, the folio fails to be reclaimed
and is put back to LRU in this round.
This also breaks up PTEs optimization such as CONT-PTE on this
large folio and may lead to accident folio_split() afterwards.
And since a part of PTEs are now swap entries, accessing those
parts will introduce overhead - do_swap_page.
Although the kernel can withstand all of the above issues, the
situation still seems quite awkward and warrants making it more
ideal.
The same race also occurs with small folios, but they have only
one PTE, thus, it won't be possible for them to be partially
unmapped.
This patch holds PTL from PTE0, allowing us to avoid reading PTE
values that are in the process of being transformed. With stable
PTE values, we can ensure that this large folio is either
completely reclaimed or that all PTEs remain untouched in this
round.
A corner case is that if we hold PTL from PTE0 and most initial
PTEs have been really unmapped before that, we may increase the
duration of holding PTL. Thus we only apply this optimization to
folios which are still entirely mapped (not in deferred_split
list).

Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 v2:
  * Refine commit message and code comment after reading all comments
    from Ryan and David, thanks!
  * Avoid increasing the duration of PTL by applying optimization
    on folios not in deferred_split_list with respect to Ying's
    comment, thanks!

 mm/vmscan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0b888a2afa58..7106741387e8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1270,6 +1270,18 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
+			/*
+			 * Without TTU_SYNC, try_to_unmap will only begin to hold PTL
+			 * from the first present PTE within a large folio. Some initial
+			 * PTEs might be skipped due to races with parallel PTE writes
+			 * in which PTEs can be cleared temporarily before being written
+			 * new present values. This will lead to a large folio is still
+			 * mapped while some subpages have been partially unmapped after
+			 * try_to_unmap; TTU_SYNC helps try_to_unmap acquire PTL from the
+			 * first PTE, eliminating the influence of temporary PTE values.
+			 */
+			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
+				flags |= TTU_SYNC;
 
 			try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
-- 
2.34.1


