Return-Path: <linux-kernel+bounces-146179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED68A61BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988951F21157
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7111804A;
	Tue, 16 Apr 2024 03:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVT9egr0"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C815AF6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713238511; cv=none; b=qVckSiHtwvNT/gkGOvADZo2qQALYLw+MvgiRbFo8AEsd+4Ls+sgCw9PSqyQXUPQVO05RiEqnwAGcEULGgxH0WsvYJ+uTsyGwf/JOklULouqZCJK144pkAsk1XQpw7tlLD4EHk3viT4FNJM8d7tKKuqDV20SMEYlDovVHdrWHRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713238511; c=relaxed/simple;
	bh=NF5wzNt+q6YxFLOzJMqGPX2hi2Bmf02eXOm5k+JwGww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nK9a0cdE8CEc7A/QmX1cKeJi+qAe9C9iBZlRfGslQCmklCzrYIf1YnoS0+4/6rb7JR+P5cg4YQolJIzr9fffDg6yjiAUt3pAm2IezehR9Zky9MZwaNSW6vReulIhPjsIuWKhwOwTsslkQvkGI1HfFumL+7twf40XWHNDjydafm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVT9egr0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecff9df447so4007551b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713238509; x=1713843309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjN0nEuCNdhZqfr9jbPn+Tu2kvqYDx3m99uXEZwJL3o=;
        b=KVT9egr01Nbn9nvKJUlk13+D/4tCFFP3EBeAcxGG9Zil3i7i4myoxQvwcEOULjdd5F
         7dDIq+7KvhJ9rqofnjs3LOj8Mke/VxiZTYfVOQLLnqv4RsN5YCWHR09ivoQNwi85oCNH
         AW0HXfu287LCcR+bTHEsXIkMo1NlxlGkgQq4sqv2QLijIFZPyzYz1pmq8/S9y7JdT99N
         1dHIcauKMsAXRxQ5GKByYkZbunbFJmM4aFa1lgpbgBecvQTSoA/1t+0ffFAEZNxRB8mK
         t08UqIQpzgm+3QFbOqWUuzozkujjksIqqPEQbJF5J8/vv9ebqd164g4gBsHFAu+xfHb0
         L+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713238509; x=1713843309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjN0nEuCNdhZqfr9jbPn+Tu2kvqYDx3m99uXEZwJL3o=;
        b=T4fLNe/TZbjYxybID1KZ35/YImvVScoP1ZyrWcUC+G7tNzGNwOhudx9mvnvMMhe6QY
         oBTzEocdcb5HQXt7fzcS0AvZXZH+ec9F5WHB+6CScHV/Se8VxE9Rdavp+HbTbid/gqti
         s0VHxCxyzXjD7RfQSK9egMruxgtOFCxQsSC4Duhxr6pVQF+OqBWi3fFpKvTWjh6h1egg
         KSdNrXnDgNxXnenWb2c4cuCYOOfyk1hFHplEJ39oYwuL2jAjzY41oBhDKuyzI97bYmML
         iRGfzz5F+bMYuW6/j9zXP2twsS2yEIqwyn4sUkDP9Ny6tc+eoHDnqj4KXJexs6cHVqVT
         d7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVPKBSLhZHCy19l/srA1j23D8v61QFcW2su9I2iwN3gpvGoTIAulR07WbHp8f4pZPD37YLGJBOY6LK8KwYZ35al2Oat4jN4QlP+luMq
X-Gm-Message-State: AOJu0YyGnP0MZPEOcCU8zx379NrG0hHj8KlyGJ5rhX5FI8j+2RWzO80A
	9X0CawL+mHfcxKGgVPgBDXY2vH6/bW0oRMHUM5yiWF9eUB4KRMW+
X-Google-Smtp-Source: AGHT+IHurkClch6FM5hxvUFrUajtAvIvdqPYxjE9XSaOZa03kXjqn5uOlh4k6emQasjAJPbR+XdJzQ==
X-Received: by 2002:a05:6a00:928e:b0:6ec:e785:98b9 with SMTP id jw14-20020a056a00928e00b006ece78598b9mr15255924pfb.27.1713238509085;
        Mon, 15 Apr 2024 20:35:09 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm7906737pfb.8.2024.04.15.20.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:35:08 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v7 0/3] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Tue, 16 Apr 2024 11:34:54 +0800
Message-Id: <20240416033457.32154-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This patchset adds support for lazyfreeing multi-size THP (mTHP) without
needing to first split the large folio via split_folio(). However, we
still need to split a large folio that is not fully mapped within the
target range.

If a large folio is locked or shared, or if we fail to split it, we just
leave it in place and advance to the next PTE in the range. But note that
the behavior is changed; previously, any failure of this sort would cause
the entire operation to give up. As large folios become more common,
sticking to the old way could result in wasted opportunities.

Performance Testing
===================

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
the same size results in the following runtimes for madvise(MADV_FREE)
in seconds (shorter is better):

Folio Size |   Old    |   New    | Change
------------------------------------------
      4KiB | 0.590251 | 0.590259 |    0%
     16KiB | 2.990447 | 0.185655 |  -94%
     32KiB | 2.547831 | 0.104870 |  -95%
     64KiB | 2.457796 | 0.052812 |  -97%
    128KiB | 2.281034 | 0.032777 |  -99%
    256KiB | 2.230387 | 0.017496 |  -99%
    512KiB | 2.189106 | 0.010781 |  -99%
   1024KiB | 2.183949 | 0.007753 |  -99%
   2048KiB | 0.002799 | 0.002804 |    0%

---
This patchset applies against mm-unstable (3aec6b2b34e2). 

The performance numbers are from v2. I did a quick benchmark run of v7 and
nothing significantly changed.

Changes since v6 [6]
====================
 - Fix a bug with incorrect bitwise operations (Thanks to Ryan Roberts)
 - Use a cmpxchg loop to only clear one of the flags to prevent race with
   the HW (per Ryan Roberts)

Changes since v5 [5]
====================
 - Convert mkold_ptes() to clear_young_dirty_ptes() (per Ryan Roberts)
 - Use the __bitwise flags as the input for clear_young_dirty_ptes()
   (per David Hildenbrand)
 - Follow the pattern already established by the original code
   (per Ryan Roberts)

Changes since v4 [4]
====================
 - The first patch implements the MADV_FREE change and introduces
   mkold_clean_ptes() with a generic implementation. The second patch
   specializes mkold_clean_ptes() for arm64, providing a performance boost
   specific to arm64 (per Ryan Roberts)
 - Drop the full parameter and call ptep_get_and_clear() in mkold_clean_ptes()
   (per Ryan Roberts)
 - Keep the previous behavior that avoids locking the folio if it wasn't in the
   swapcache or if it wasn't dirty (per Ryan Roberts)

Changes since v3 [3]
====================
 - Rename refresh_full_ptes -> mkold_clean_ptes (per Ryan Roberts)
 - Override mkold_clean_ptes() for arm64 to make it faster (per Ryan Roberts)
 - Update the changelog

Changes since v2 [2]
====================
 - Only skip all the PTEs for nr_pages when the number of batched PTEs matches
   nr_pages (per Barry Song)
 - Change folio_pte_batch() to consume an optional *any_dirty and *any_young
   function (per David Hildenbrand)
 - Move the ptep_get_and_clear_full() loop into refresh_full_ptes() (per
   David Hildenbrand)
 - Follow a similar pattern for madvise_free_pte_range() (per Ryan Roberts)

Changes since v1 [1]
====================
 - Update the performance numbers
 - Update the changelog (per Ryan Roberts)
 - Check the COW folio (per Yin Fengwei)
 - Check if we are mapping all subpages (per Barry Song, David Hildenbrand,
   Ryan Roberts)

[1] https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240307061425.21013-1-ioworker0@gmail.com
[3] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail.com
[4] https://lore.kernel.org/linux-mm/20240402124029.47846-1-ioworker0@gmail.com
[5] https://lore.kernel.org/linux-mm/20240408042437.10951-1-ioworker0@gmail.com
[6] https://lore.kernel.org/linux-mm/20240413002219.71246-1-ioworker0@gmail.com

Thanks,
Lance

Lance Yang (3):
 mm/madvise: introduce clear_young_dirty_ptes() batch helper
 mm/arm64: override clear_young_dirty_ptes() batch helper
 mm/madvise: optimize lazyfreeing with mTHP in madvise_free

 arch/arm64/include/asm/pgtable.h |  55 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/contpte.c          |  29 +++++++++++++++++
 include/linux/mm_types.h         |   9 ++++++
 include/linux/pgtable.h          |  74 +++++++++++++++++++++++++--------------
 mm/internal.h                    |  12 +++++--
 mm/madvise.c                     | 147 ++++++++++++++++++++++++++++++---------
 mm/memory.c                      |   4 +--
 7 files changed, 233 insertions(+), 97 deletions(-)

-- 
2.33.1


