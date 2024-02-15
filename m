Return-Path: <linux-kernel+bounces-67510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B2856CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F00F28EB44
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6F13A274;
	Thu, 15 Feb 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwT+J4GX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200A13B2A3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021690; cv=none; b=Ml6Svou8mz8F9xa6vs9lqT44dubp20QLShrbapL68tasteNmo06mRLPNBxkwDlzz9Vej8TQqDtEg+4T1GtBkqpWJQ4TizIGZwvo9j4VR7GKG8Vq3E0rz8rHq7s93SEHPQxSFE8xTmqdPbrmZF50xVsfR8NzjpgJOK4e/HDDbBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021690; c=relaxed/simple;
	bh=nNGc3YyQXElexLUGrc+3m/8OAMzKkLYSwGDhBduK42Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cVon61BDFyV+hk4lcEq2cdOnC56dp1GCJZpTf2spDqFGJImkCy/oLvbxwetELXECyXH3HH/j90lBjerwsmzRy/XKXttICLdCxlagfeV1XXyz17dFK2IYo8IXhFVJgklNpuvcS6I8xwA3Ca2eNuX1U0RZGAFNgn6Cu0RU6W4Hvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwT+J4GX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e8e8c2f1so7897977b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708021688; x=1708626488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5cbuDEXa8QTGGs1n7HGsrPiyXLYVHOGomxNSFL6n5w4=;
        b=QwT+J4GXwnmtbNpk/JZGMHj9kzc1RZw7CJx7uSBjlazHJgevB0Nhx6J0TsFKT/aMkq
         z82TXttOHel3unZlcHU5Ba7i6rAKhPBWnRqiOl4cO6i7U3rgzPjNG6coIxoIpBZNcaRa
         7N7cw6Jf2ylN7l27M5qR9MoOWMwMMmWlsr/ntBoGttHjTDxgaiekf5hzOywyQyRy7OzX
         4rkN8eteL1XKdW1JmSeA/wFOtToISVgg6Ykl/D4J1ctTEeptwvPPSxS2pz3F65+lgucq
         f0+Gtam6hX048xc6KGbkp3gXZs8IsytuFbOcpESJTXLA1KnJqEIQPvjKdxh+4JFHGUAQ
         vbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021688; x=1708626488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cbuDEXa8QTGGs1n7HGsrPiyXLYVHOGomxNSFL6n5w4=;
        b=wdHaosL8XCUd/FDi+DQPooV5CngrZnsnLZAQ/S/QYD2v0oOjWEkHprISclecFtkbzZ
         52qVDE/A94PAJgykEJJRL7kLL9dK9a4HCvKkSnaI3teJy4fIdsBXA+jEAyxpxB9KQpLK
         8LToxXXILXok1RdhPNpm3sPzSGnob8tKtSxfQrUALZaaPyJiQq8SG6rrby+PBskfl+Dc
         2gnFhuJLYD3KDM1oV58TPtkej2D8Fkh+ItBt9a3jyCzMIA5casjouligJI1YuYX9DUkR
         STEI8z9nYT+cSYNY6WZrAx2Jnjk4nTLbRKUczOKIO83M8mSjAlf/eTMCb/h32CbEy5K9
         q+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfppaEVwJGJ/ZC4QJCqK1F6udMJQlIQfxwgZA1wLb9S4FkOeEZsg7VsJckhi/ubcosJmUXRzHkb/76txGUhZ6rEp70sSKwpch/Fu+G
X-Gm-Message-State: AOJu0YztJherS3POR0FAhKVyIfO5CuZTmyOEGhvs0axtZeBV1xveLAAH
	tGAedGTqyBmKIBp+MEtej/wbfBsx+HTKYEYeebLovCauy9uskCiVQWvDJzGBGO9bsKSusDcjg7N
	cNUjArovy2mQ604lhg0am+Q==
X-Google-Smtp-Source: AGHT+IFoSxUj0h7pmQA5FIMJN97d9ehxVLMzVkeTM8DW2EgWfz6IM+wxmqAeUPLJQroCUpYaH6l2iNmG6v8GKXpIhA==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:6186:87a3:6b94:9b81])
 (user=lokeshgidra job=sendgmr) by 2002:a05:690c:24e:b0:607:9e9a:cba6 with
 SMTP id ba14-20020a05690c024e00b006079e9acba6mr430728ywb.8.1708021688055;
 Thu, 15 Feb 2024 10:28:08 -0800 (PST)
Date: Thu, 15 Feb 2024 10:27:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215182756.3448972-1-lokeshgidra@google.com>
Subject: [PATCH v7 0/4] per-vma locks in userfaultfd
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) causes significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently. We can use per-vma locks instead to significantly reduce
the contention issue.

Android runtime's Garbage Collector uses userfaultfd for concurrent
compaction. mmap-lock contention during compaction potentially causes
jittery experience for the user. During one such reproducible scenario,
we observed the following improvements with this patch-set:

- Wall clock time of compaction phase came down from ~3s to <500ms
- Uninterruptible sleep time (across all threads in the process) was
  ~10ms (none in mmap_lock) during compaction, instead of >20s

Changes since v6 [6]:
- Added a patch to add vma_assert_locked() for !CONFIG_PER_VMA_LOCK, per
  Suren Baghdasaryan
- Replaced mmap_assert_locked() with vma_assert_locked() in
  move_pages_huge_pmd(), per Suren Baghdasaryan

Changes since v5 [5]:
- Use abstract function names (like uffd_mfill_lock/uffd_mfill_unlock)
  to avoid using too many #ifdef's, per Suren Baghdasaryan and Liam
  Howlett
- Use 'unlikely' (as earlier) to anon_vma related checks, per Liam Howlett
- Eliminate redundant ptr->err->ptr conversion, per Liam Howlett
- Use 'int' instead of 'long' for error return type, per Liam Howlett

Changes since v4 [4]:
- Fix possible deadlock in find_and_lock_vmas() which may arise if
  lock_vma() is used for both src and dst vmas.
- Ensure we lock vma only once if src and dst vmas are same.
- Fix error handling in move_pages() after successfully locking vmas.
- Introduce helper function for finding dst vma and preparing its
  anon_vma when done in mmap_lock critical section, per Liam Howlett.
- Introduce helper function for finding dst and src vmas when done in
  mmap_lock critical section.

Changes since v3 [3]:
- Rename function names to clearly reflect which lock is being taken,
  per Liam Howlett.
- Have separate functions and abstractions in mm/userfaultfd.c to avoid
  confusion around which lock is being acquired/released, per Liam Howlett.
- Prepare anon_vma for all private vmas, anonymous or file-backed,
  per Jann Horn.

Changes since v2 [2]:
- Implement and use lock_vma() which uses mmap_lock critical section
  to lock the VMA using per-vma lock if lock_vma_under_rcu() fails,
  per Liam R. Howlett. This helps simplify the code and also avoids
  performing the entire userfaultfd operation under mmap_lock.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
[2] https://lore.kernel.org/all/20240129193512.123145-1-lokeshgidra@google.com/
[3] https://lore.kernel.org/all/20240206010919.1109005-1-lokeshgidra@google.com/
[4] https://lore.kernel.org/all/20240208212204.2043140-1-lokeshgidra@google.com/
[5] https://lore.kernel.org/all/20240213001920.3551772-1-lokeshgidra@google.com/
[6] https://lore.kernel.org/all/20240213215741.3816570-1-lokeshgidra@google.com/

Lokesh Gidra (4):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  mm: add vma_assert_locked() for !CONFIG_PER_VMA_LOCK
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++-----
 include/linux/mm.h            |   5 +
 include/linux/userfaultfd_k.h |  75 ++++--
 mm/huge_memory.c              |   5 +-
 mm/userfaultfd.c              | 438 +++++++++++++++++++++++++---------
 5 files changed, 413 insertions(+), 196 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


