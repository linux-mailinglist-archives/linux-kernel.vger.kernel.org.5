Return-Path: <linux-kernel+bounces-13785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C045820E46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85011C21903
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F88BA43;
	Sun, 31 Dec 2023 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a1pAEO7J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E8BA2E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5565067fcbbso211116a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704056707; x=1704661507; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6sCewcdjIkirA2iA/HRqx9fla0rvCRhR05Oa10U152M=;
        b=a1pAEO7J20WO4y4CWDZi4hZzKncgk6PEatlczLiwFlRYI8oW47oAwDNZZ8K4MyrVrq
         aMJw6tW4ITyS6Un3U08YfkI3Emgs9nRiAL+7Rk77iNG2eaWu11GYKWhPAZIB41CexF49
         G1LEMnt45+s8Q8WFyfP+rMruSO2RqUwNo3loI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704056707; x=1704661507;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sCewcdjIkirA2iA/HRqx9fla0rvCRhR05Oa10U152M=;
        b=gaEVVUn22gxP5oGU2sa3qsiZ8i6eJSfRWKo820clv9n78EUit5e3MMhpcccpbJ8FF9
         eJe6WkgbLDcxsnjvx2Cih381OOs/E9q5pBcpxX0jwpV6QU8ozit0VF2Ip3jOLYdttHlz
         rXFEYzRkeUyAHOsR8jva4ZQLGSvMFIhfjpktiEpBBrM/7QiSctu3rD0/zas9jNX7OLAe
         vVZJPkpBwyYOhHO1XIP3/IZHgoSwu4MwAL6foHJXCfyN0d+pbcdXmAkXsUmWP+eYnd7R
         csLxgSeUhzunAT0uLN0dzjTPZ47aIA+rhARHzh8I9fTaAUGPBKYJ4c+uOOI++MBXliwE
         VH9A==
X-Gm-Message-State: AOJu0YyV1BRFKoFXwG4lxlj76d8/wk78a/B/rVSkL+9cP/DveK4pM3qX
	XxR50knl5MUsdxEZHG0ng/dX29SyteH/oenv9DhrefHZMQdzfQ==
X-Google-Smtp-Source: AGHT+IEpTZHn60AsPdrToHDzK4ot0CyxdKcz85GHunqHtENONzUv3VVryQ6Xfm32dfzkTdp02liQxA==
X-Received: by 2002:a50:cd88:0:b0:553:5b1d:956e with SMTP id p8-20020a50cd88000000b005535b1d956emr7863550edi.82.1704056706679;
        Sun, 31 Dec 2023 13:05:06 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402320600b0055410f0d709sm13767470eda.19.2023.12.31.13.05.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Dec 2023 13:05:06 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2339262835so849503366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 13:05:06 -0800 (PST)
X-Received: by 2002:a17:906:7497:b0:a28:c22:bcb2 with SMTP id
 e23-20020a170906749700b00a280c22bcb2mr146825ejl.14.1704056705715; Sun, 31 Dec
 2023 13:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 31 Dec 2023 13:04:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=whbyHgacqfOJ0VU_GxB-p=Cz+xsQ6XWrAEx=gT_QO9ERg@mail.gmail.com>
Message-ID: <CAHk-=whbyHgacqfOJ0VU_GxB-p=Cz+xsQ6XWrAEx=gT_QO9ERg@mail.gmail.com>
Subject: Linux 6.7-rc8
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So as expected, pretty much nothing happened over the holiday week.
We've got literally just 45 files changed, and almost a third of those
files aren't even kernel code (ie things like selftests, scripting,
Kconfig and maintainer file updates). And some of the rest is
prep-work and cleanups for future (real) changes.

But we do have a couple of real fixes in there, and I suspect we'll
get a few more next week as people come back from their food-induced
torpor.

So rc8 is mostly just a placeholder, and a "I do rc's each week,
whether they matter or not". Shortlog appended for completeness.

And hey, regardless of whether all you peeps are interested in testing
another rc or not, here's to hoping you all had a good 2023, and
wishes for an even better 2024!

                     Linus

---

Alvin =C5=A0ipraga (2):
      get_maintainer: correctly parse UTF-8 encoded names in files
      get_maintainer: remove stray punctuation when cleaning file emails

Andy Shevchenko (2):
      MAINTAINERS: Remove Andy from GPIO maintainers
      MAINTAINERS: Add a missing file to the INTEL GPIO section

Arnd Bergmann (2):
      kexec: fix KEXEC_FILE dependencies
      kexec: select CRYPTO from KEXEC_FILE instead of depending on it

Baokun Li (1):
      mm/filemap: avoid buffered read/write race to read inconsistent data

Bartosz Golaszewski (1):
      MAINTAINERS: split out the uAPI into a new section

Charan Teja Kalla (1):
      mm: migrate high-order folios in swap cache correctly

Christoph Hellwig (1):
      block: renumber QUEUE_FLAG_HW_WC

Coly Li (1):
      badblocks: avoid checking invalid range in badblocks_check()

David E. Box (3):
      platform/x86/intel/pmc: Add suspend callback
      platform/x86/intel/pmc: Allow reenabling LTRs
      platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback

David Laight (3):
      locking/osq_lock: Move the definition of optimistic_spin_node
into osq_lock.c
      locking/osq_lock: Clarify osq_wait_next() calling convention
      locking/osq_lock: Clarify osq_wait_next()

Edward Adam Davis (1):
      keys, dns: Fix missing size check of V1 server-list header

Helge Deller (2):
      linux/export: Fix alignment for 64-bit ksymtab entries
      linux/export: Ensure natural alignment of kcrctab array

Jialu Xu (1):
      gen_compile_commands.py: fix path resolve with symlinks in it

Kent Overstreet (4):
      bcachefs: fix BCH_FSCK_ERR enum
      bcachefs: Fix insufficient disk reservation with compression + snapsh=
ots
      bcachefs: Fix leakage of internal error code
      bcachefs: Fix promotes

Linus Torvalds (1):
      Linux 6.7-rc8

Masahiro Yamada (1):
      kbuild: fix build ID symlinks to installed debug VDSO files

Matthew Wilcox (Oracle) (4):
      mm/memory-failure: pass the folio and the page to collect_procs()
      mm/memory-failure: check the mapcount of the precise page
      mm/memory-failure: cast index to loff_t before shifting it
      mailmap: add an old address for Naoya Horiguchi

Muhammad Usama Anjum (1):
      selftests: secretmem: floor the memory size to the multiple of page_s=
ize

Namjae Jeon (1):
      ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Nathan Chancellor (1):
      MAINTAINERS: Add scripts/clang-tools to Kbuild section

Nico Pache (1):
      kunit: kasan_test: disable fortify string checker on kmalloc_oob_mems=
et

Shin'ichiro Kawasaki (1):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Sidhartha Kumar (1):
      maple_tree: do not preallocate nodes for slot stores

Stefan Hajnoczi (1):
      virtio_blk: fix snprintf truncation compiler warning

Steven Rostedt (Google) (4):
      eventfs: Fix file and directory uid and gid ownership
      ring-buffer: Fix wake ups when buffer_percent is set to 100
      tracing: Fix blocked reader of snapshot buffer
      ftrace: Fix modification of direct_function hash while in use

Xuan Zhuo (1):
      virtio_ring: fix syncs DMA memory with different direction

