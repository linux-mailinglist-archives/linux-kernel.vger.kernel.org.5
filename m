Return-Path: <linux-kernel+bounces-62611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81C8523A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC31C281FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AAC55C32;
	Tue, 13 Feb 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQRjbjOy"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9655799
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783586; cv=none; b=p596j6TIXuuZQugYqAu7PYks7Trst2FFWD2ul6zvDS6RQEAxRA+DJq2+0A7CPUrmGjkGa+WRBya1fLSU1hWHLpvXx0rA7gkuB7AqtEDwERoXJdMAzeTC7XUZC/E0edob1x9AUmjhFcW49JouxCYfzgb0QylCHOOt1AeEPtFgk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783586; c=relaxed/simple;
	bh=vIwOtGsDzqC6GvHsB1Ywa4a3VYOkSPAQAcBcMttGK5E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tNrlB7B0rP6O0RalUg1SQ+XAQr2qKkNDHjtsIK44V1ty38qPAw+eNmPOgJZOAktTFFaEuQS0NaM/wWANcUHDJuOQiTwZPqBMDHwwUYbKMOoM0C3jjr5QgbbJQnXg8Al3eOiXUq1pirl4Dua2h8jnxcXhMdBGHdvVT+/PKU6VLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQRjbjOy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60784cf4109so2064557b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783583; x=1708388383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYp0cW/LgWI9ONT8F6R5Ej86mgi7Qlg0RXGsGKtpVus=;
        b=wQRjbjOyJfTEUsqjAXLbp1F3qm8rGErGNXUpRjjc9JLWYgwjx7dfqxMIzEpzAXJera
         wKUV3jipe4utWjwAg3ZGXPkRCnKjne39/B89hOUzLZw5EZsiAMcZVLs5D/8jdN7TdngO
         rM7RLQJpXLtRO3EjEIZP/YKb3dFVEiohyXPqVdkOvFg0wpWxPnM+WH6vTmEPbYacS8CV
         wYPhBjTmIBhQxKOx5rX7NYzsnM4prxsL0R5i0GXO3hqQqePbO4xFtGPkNxjgA+Fg1+0l
         1vMJbnyU8KgqElowPmYrB/4XvA00ocTVw+bWXbNc1M7/HJykq64FEyp3zp+DhfpytXqh
         fvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783583; x=1708388383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wYp0cW/LgWI9ONT8F6R5Ej86mgi7Qlg0RXGsGKtpVus=;
        b=bCiOjgbkyezBgDuU4mBcRzbks9qOtWT3qc1gjOyMzmVsUvPhqalbIbOAl9xIouqjcM
         qOGatdsc8OTYon68YHsBXd1BLIhtNJHr44PwpTh5ZndAbILpF9Zl/NMSA9OydsehYEgB
         a9PPZ4Z6a0bD7Pwz5mp1ty7nG/MmaZm8iWpCByk+xf1JZtJXT9mgb7Hvqo+GR34Z33CQ
         r/jGMbhK6q0o1WL1/rhXav+A48/MsdD3kLX+Il93DB49N6FMHGlJh8Mgrjt/T/I7irvn
         xAXUA8YY0B7kUwuS/IRnd2wpdTt57R5hoD2QUrpLphklkKqIPv5vCofmT7BvZ6Acjgeb
         cALA==
X-Forwarded-Encrypted: i=1; AJvYcCUwVDbvrwxZsvrD8dix2O/GzOAdZWFAgAjcaYIj0nBwpJ0/rRI0auq+y4N6aA/dFhfy3Igsn2TdnqMxAduLZuYEA+uR4RQx6SYH13ms
X-Gm-Message-State: AOJu0YzDcRlpm4CtpGp0VTjM282dQ4ecvgqrUqYVs49jRRnTvbJaFNk9
	jKBZ1HLEfvjvLlJmlcRLocCht4aRDVgaEEbI6wHV9oso8hfyhDVWOInO9SIqnA7kuGE59wO7jo8
	KwL7EL1IyF5+eCyElAzA3vg==
X-Google-Smtp-Source: AGHT+IETpVKlK4W4ES+O6uH9bAYT9eFgcT5Mcr7AWYf1RXBnBN+OIklD/nT02bdob/BzELYAfud81u94YEZ4Zw50uQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:fd80:ef0f:6359:fc4c])
 (user=lokeshgidra job=sendgmr) by 2002:a81:a107:0:b0:604:228:7e with SMTP id
 y7-20020a81a107000000b006040228007emr2397004ywg.8.1707783583386; Mon, 12 Feb
 2024 16:19:43 -0800 (PST)
Date: Mon, 12 Feb 2024 16:19:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213001920.3551772-1-lokeshgidra@google.com>
Subject: [PATCH v5 0/3] per-vma locks in userfaultfd
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
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

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++-----
 include/linux/userfaultfd_k.h |  75 ++++--
 mm/userfaultfd.c              | 450 ++++++++++++++++++++++++++--------
 3 files changed, 421 insertions(+), 190 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


