Return-Path: <linux-kernel+bounces-144711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C48A4991
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D5281F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971732D051;
	Mon, 15 Apr 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i27odoLe"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA80364A5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167926; cv=none; b=JPY4JYDDjWJE1sJpyrMcZX2akbuWGjmFzNR4NDHghi4VdTb72814JgSmNSxnOGEjh6sjnKHDQ1xtZlppJfZD4gBrpFKa02div4T8WVLoI2Nj+7P+Us/mMWvzrV5uqgvWHmNGgnEW5XEB/6VzNpfp2Z0TX6g4nUa5WPEZRmfba2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167926; c=relaxed/simple;
	bh=AaOEJmAesxHkCrpa7wm9hW8XplE/i3Ygw2sfhbRJ8i4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hyHOpNlVrb8RC4Vd0B6zZQxQLfrWBvTRVVNDwGq9VV0LdbKv2bnhHmTJj//yMyRGfYS6tt6EzFoJvgIFMWi5xckRY/Kzc5jk3bkde2eEG72Z5SGTmGQbBvzicrxXiC9FX7bjyjIb8UMP9pL0zQzno5SQO+Mjb/+OFNJeT45UwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i27odoLe; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-416e58bdc0eso12590325e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713167924; x=1713772724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fVltvWd3i2k+Cq0VFQS9D3dwHDvzmZCXT49WSh27v1A=;
        b=i27odoLe7V90W5Pz5VCIjf9It7Bi9kCYB52rwswStpxzfoNLFK7DGnQ9Whmjdpg21e
         2vtqnPeNfGRfH4+b1ZXeZtEN7zseRTcYCEKxaecLTwRb9Lf1TTmi4KqxaHIl5k1For9R
         8DeiO/kbXk7+XeRLo97m/DUiBMdVg2mT0SHLJZgev1J8rHW+p7a+sZaLx4tSMuePc5cQ
         O3lnr3rnAB7TaCYXp1GO6De9WGynmXWrJ85hWaYYC2L1yqt5KhKL3UNANDPxkie5QGhT
         z3x1kY/fhEVRwJS2rkRMP0iWbcAPSK9zQ240KUb3/tyFHuKbDdQ4Rw00zZmqC0YRtbJg
         r7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167924; x=1713772724;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVltvWd3i2k+Cq0VFQS9D3dwHDvzmZCXT49WSh27v1A=;
        b=T2OP7//+gKcKKgZqd9Op6mFLVTdXQUzlIs4fS6AwcZR9OC/zd9rqHe9YrqLmdJkDoM
         4eunted1J9mjtg2QitjRj039GVjMRaCT9wV0zCOh4yfGZZ+br5SA9imfD9Qyk5y52G8M
         SyW2DvgZpjdYWhixUES5U9/2+cVuxHnTNzdlzbcLNFlPntdnYasqdWC2mAKlUBfU7A+L
         rTBnWmJN5T2LytbAFMt/JxUJaHBVmMTK1XhgHrTYQH284nhsDeAI2LyWuByzCx7ldsXp
         1hmtZOrbKV/1ZCnOfsacQcIT8DgNPfUsHV+UvvfsFw9TTasHM3yHFnX12zPOwHtn5kTi
         N1Pw==
X-Gm-Message-State: AOJu0YySGJX87pb6QidqxJpo48KfWxTQAEKuQdofb7ckcRCqohpK6yac
	HIQLZQRSI0pWw7mkn4hNJUSTVikuMmx0YvOQMDtFXlEoVL09YaTmkrzAPnHOZ375NFAQFlx5Pee
	rtUm9ge7/Kb1XU+SUeS+PxXdqFkdY4sud01Gy8UNJpR6ttu8sSrBIutDtE/Nt77YsxgpLbpfPII
	smwqxXJ+xwWlaV1vdtnat8eR5IvU2gyw==
X-Google-Smtp-Source: AGHT+IGkWKcVCCQxlHp+FuowlJwsRPk61JubA1nRMZgo8wS592ZlQTbvD4F+g823HOmT3UKPLtn2m5Bh
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:35cf:b0:418:2b36:91a2 with SMTP id
 r15-20020a05600c35cf00b004182b3691a2mr211190wmq.3.1713167923708; Mon, 15 Apr
 2024 00:58:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:58:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=ardb@kernel.org;
 h=from:subject; bh=wWpMCnM5h853IHZhxEFlnMrbX7tmMSr5ixfw0ic0NDc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3mnt45mb65d4MaoySjbwqwXNkyeU1ZTtSLab6rPy2L7
 FRr9JHqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABM5PpeR4eAS+ScrZktfn/74
 lvsrznzJkPhwoe7Wu/om1bHvNy7+oMDwP8udm7/g6KoN4urM84x9Nx0r17d+dTvga3fijn7nhU9 yOQE=
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415075837.2349766-5-ardb+git@google.com>
Subject: [PATCH v3 0/3] kbuild: Avoid weak external linkage where possible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Weak external linkage is intended for cases where a symbol reference
can remain unsatisfied in the final link. Taking the address of such a
symbol should yield NULL if the reference was not satisfied.

Given that ordinary RIP or PC relative references cannot produce NULL,
some kind of indirection is always needed in such cases, and in position
independent code, this results in a GOT entry. In ordinary code, it is
arch specific but amounts to the same thing.

While unavoidable in some cases, weak references are currently also used
to declare symbols that are always defined in the final link, but not in
the first linker pass. This means we end up with worse codegen for no
good reason. So let's clean this up, by providing preliminary
definitions that are only used as a fallback.

Changes since v2:
- fix build issue in patch #3 reported by Jiri
- add Arnd's acks

Changes since v1:
- update second occurrence of BTF start/end markers
- drop NULL check of __start_BTF[] which is no longer meaningful
- avoid the preliminary BTF symbols if CONFIG_DEBUG_INFO_BTF is not set
- add Andrii's ack to patch #3
- patches #1 and #2 unchanged

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>

Ard Biesheuvel (3):
  kallsyms: Avoid weak references for kallsyms symbols
  vmlinux: Avoid weak reference to notes section
  btf: Avoid weak external references

 include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++
 kernel/bpf/btf.c                  |  7 +++--
 kernel/bpf/sysfs_btf.c            |  6 ++--
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 kernel/ksysfs.c                   |  4 +--
 lib/buildid.c                     |  4 +--
 7 files changed, 52 insertions(+), 33 deletions(-)

-- 
2.44.0.683.g7961c838ac-goog


