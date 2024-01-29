Return-Path: <linux-kernel+bounces-43417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D1841396
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CE8284123
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF57603A;
	Mon, 29 Jan 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmdf6gNZ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC45644E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556923; cv=none; b=QA8TryDHYcF+s2WCpJkfGFVQCCkf8GiEQnp/Q5zhWpIGilsDKvNfZORnVKgWmSZYvi6X7Lt9BO+2kTTNE7ux1nvK6ImGgsuEPSyou85amy2Do42AZKR33Jd3PT8VFnkwMm1pNBYjzJQeAGDBYqaRUJoAicgud0NcbvCiCq4+WWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556923; c=relaxed/simple;
	bh=q+KxZnv5oof9XIDGvhACsh+/6ErV1CKpfDTSXHD8Zwg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQZcjDx3LjPSPXQ4V+9jX0A8rIux8A18a/1ts1RRnqBNpY/a6iE+0i03Pm1ZB+sH6nL2DVSPSb83BfkCUwUrNXHGk6+BT81Nkh4KcNBIGdvkor9nZxEWx19kLVg19MgTxwKPaSR9qh+MAsOScugeluHJJ1uN/QP2OAIbkuAU8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fmdf6gNZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso5057090276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706556920; x=1707161720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y47b8IapUuQ52NiyXedK/xqkWWUKqV6XNeLrQIpcJlU=;
        b=fmdf6gNZHX7z0Kc7CKU6VCNGXOPXl47CUTZNGuw7r3jdBbxiLAjYQ6vf1qNqOoby4v
         QRuvEZyIJELteL5xl01G8+KvfBmjBwwDFEDDaIiIzzHiWXrsQcvBxnWaJb0TbW4/+5EO
         a3ZbEoDvUUPYJwv/7YBSjzLUoTRlbh9EV9bQBN0xTkhV85qH2oAp44AO9awf+QkCR6Sf
         MZPW8D12Wml+WUe6hSv3Wcm9loIg2d2rgQ6jzXZ/iegS6Dy/c4gSNIW/yQIfzXulSylw
         pQr6X/mN3md9LmPX8RwXkfepcYbpcr17HrMCh/wt2Rldy18fIyKre1q+osPcQG+ZuL56
         +LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556920; x=1707161720;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y47b8IapUuQ52NiyXedK/xqkWWUKqV6XNeLrQIpcJlU=;
        b=tGTz2uBhxpAByStzNQM0H1AvjWJvLCe7X8NKFw3pBzh3UTArA2lDxfhl7ETyJeV50Q
         03vKed6l0Px5AyXaVeqsNzQLbvZ45JeukvLdlCgZRz3l1IcNrKQ8WjKd0qrnQy94ooJQ
         eq6u58AO00W6JgMgPbcmVGVBTrZIZf5xZ/1+Wpfiior2v7fyKId+xYQAmK/aafdidLHT
         rZV0C4lE54k5xUGv83Hk1AgTjwkeYsIVfuURdUvFTblzsM4NEh4TJaYnk8BIMpY+z03W
         5YV1uhg0l6Gx+SYRmim6s8CrESJRNJj1ctjystzi9U+w4pfHtwuU3EWcGeABaU1CI/At
         GqCQ==
X-Gm-Message-State: AOJu0YyFu8GKllyEJkp5Wwof1ugYklBMupdm4QNl0tyVflCx0mTmb4/3
	ci20gRM8fzf24wteVrgzF7Q7fyzwsvNLkcaio6irPvH2sdiyOvwyQ/CAePYDM4lT/1y+ivCkrC3
	OaArRx/wFVJJ9z+Sgu/slrg==
X-Google-Smtp-Source: AGHT+IFpUlsNWwzEIDjzWN6N56lWLkRvPKg+4gqK1HK7WRmXRpoMLHM95bZ5V0i0zZbH36vyMnKU3/xtEdcui8mBFg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9b1d:f1ee:f750:93f1])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:2604:b0:dc2:23db:1bc8 with
 SMTP id dw4-20020a056902260400b00dc223db1bc8mr443578ybb.3.1706556920762; Mon,
 29 Jan 2024 11:35:20 -0800 (PST)
Date: Mon, 29 Jan 2024 11:35:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129193512.123145-1-lokeshgidra@google.com>
Subject: [PATCH v2 0/3] per-vma locks in userfaultfd
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"

Performing userfaultfd operations (like copy/move etc.) in critical
section of mmap_lock (read-mode) causes significant contention on the
lock when operations requiring the lock in write-mode are taking place
concurrently. We can use per-vma locks instead to significantly reduce
the contention issue.

Changes since v1 [1]:
- rebase patches on 'mm-unstable' branch

[1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/

Lokesh Gidra (3):
  userfaultfd: move userfaultfd_ctx struct to header file
  userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
  userfaultfd: use per-vma locks in userfaultfd operations

 fs/userfaultfd.c              |  86 ++++---------
 include/linux/userfaultfd_k.h |  75 ++++++++---
 mm/userfaultfd.c              | 229 ++++++++++++++++++++++------------
 3 files changed, 229 insertions(+), 161 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


