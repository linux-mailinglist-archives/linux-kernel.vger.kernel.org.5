Return-Path: <linux-kernel+bounces-13831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541D2821320
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 06:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA01C218CB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 05:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB791375;
	Mon,  1 Jan 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0744g7a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87F10F4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 05:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb53e20a43so7178017b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704088101; x=1704692901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoeN/wallNqAjTrVPXrekUmsFGaDmiKdrBCmOUXBXAE=;
        b=i0744g7avM0f90t1cErH+yXuqD5ziB2ecNvUYxSQ4ZKYvhYCavGagn6L+AfEeP5yWC
         je3LkKqKIZw5h5ItcylTINne0EqrkXsnVpoeSfwPkSdRh/8SvX/u4uXHgoeia52Jg42M
         gSIc0fZzBDxD66m7Hp0651RgMpyGPOgp9syYk2Hd8BGddEh0ofsdyqMg3fjl8qVmrRYj
         YvljTwRSqtw26nen1/xDPbdyxKeNAJzfp3GiUoGDQMMl7oZermm/XK6NLLRCXibfLNQf
         BRksdaaJIlbAJZWlSlsscmn1t5HlnkU943JAugsFC95hrSiZ7k0LkV6MJD7DZO2hjfDF
         7sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704088101; x=1704692901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoeN/wallNqAjTrVPXrekUmsFGaDmiKdrBCmOUXBXAE=;
        b=kRElhDBGhGVOYcCYDPZ4q79KbzMYJOxKYNxX29/OYpXGjo2UJ5v8teOv3ociTzctO2
         9NwdhMy243duF9LIjvLgGbR1B81RaIMCOvdNiroY0amZdCzJlMNKV3LqZV3cTBnWOZ05
         A/srUQ0kJpBZ4lblBPoAEkvjIR88jFaE08wMkmrGfRBcWocUDt3xQbJHY2yiYme6zgRF
         19f4mtQM/xpuK5xBNXDW1VQO9Im6GYuyz9z3OK0NrI8txrsj18tfX2M4vUDDFGyCkNPR
         9F/5UorqCg07SMHkVKht7RyiZojfN04SKPhPD+l5PYv7dHgwBn7N2XOCZOFcHSi+hrSx
         pVwQ==
X-Gm-Message-State: AOJu0YySpgPcrnve3y1+2SaXmq7zmDYkw/halUm7uGQ8n4i+8imenBrA
	kVnY/dVrCGANu4cU9QGytP5tHWcCZdOXJE/mczk=
X-Google-Smtp-Source: AGHT+IE1YCiX2j5flpIdd4w5SC2C6VgtO7Of+6jEBi2HdJ7inwttk7Ho9Ezkl1YsKxjMLn0PpQ7ukPrsp5kTNLUhnTE=
X-Received: by 2002:a05:6808:1411:b0:3bb:e219:3884 with SMTP id
 w17-20020a056808141100b003bbe2193884mr5640075oiv.97.1704088101199; Sun, 31
 Dec 2023 21:48:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whbyHgacqfOJ0VU_GxB-p=Cz+xsQ6XWrAEx=gT_QO9ERg@mail.gmail.com>
In-Reply-To: <CAHk-=whbyHgacqfOJ0VU_GxB-p=Cz+xsQ6XWrAEx=gT_QO9ERg@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Mon, 1 Jan 2024 05:48:08 +0000
Message-ID: <CADo9pHhD9ip1wggwmVmBXLT+YK_zywTUOFq5x891X-UL=D3Jow@mail.gmail.com>
Subject: Re: Linux 6.7-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Running this rc8 and before that ran rc7 from Arch Linux AUR:
https://aur.archlinux.org/packages/linux-mainline
on my refurbed Dell laptop i got from my boyfriend in xmas present
with a model name    : Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz

Tested by: Luna Jernberg <droidbittin@gmail.com>

Den s=C3=B6n 31 dec. 2023 kl 21:21 skrev Linus Torvalds
<torvalds@linux-foundation.org>:
>
> So as expected, pretty much nothing happened over the holiday week.
> We've got literally just 45 files changed, and almost a third of those
> files aren't even kernel code (ie things like selftests, scripting,
> Kconfig and maintainer file updates). And some of the rest is
> prep-work and cleanups for future (real) changes.
>
> But we do have a couple of real fixes in there, and I suspect we'll
> get a few more next week as people come back from their food-induced
> torpor.
>
> So rc8 is mostly just a placeholder, and a "I do rc's each week,
> whether they matter or not". Shortlog appended for completeness.
>
> And hey, regardless of whether all you peeps are interested in testing
> another rc or not, here's to hoping you all had a good 2023, and
> wishes for an even better 2024!
>
>                      Linus
>
> ---
>
> Alvin =C5=A0ipraga (2):
>       get_maintainer: correctly parse UTF-8 encoded names in files
>       get_maintainer: remove stray punctuation when cleaning file emails
>
> Andy Shevchenko (2):
>       MAINTAINERS: Remove Andy from GPIO maintainers
>       MAINTAINERS: Add a missing file to the INTEL GPIO section
>
> Arnd Bergmann (2):
>       kexec: fix KEXEC_FILE dependencies
>       kexec: select CRYPTO from KEXEC_FILE instead of depending on it
>
> Baokun Li (1):
>       mm/filemap: avoid buffered read/write race to read inconsistent dat=
a
>
> Bartosz Golaszewski (1):
>       MAINTAINERS: split out the uAPI into a new section
>
> Charan Teja Kalla (1):
>       mm: migrate high-order folios in swap cache correctly
>
> Christoph Hellwig (1):
>       block: renumber QUEUE_FLAG_HW_WC
>
> Coly Li (1):
>       badblocks: avoid checking invalid range in badblocks_check()
>
> David E. Box (3):
>       platform/x86/intel/pmc: Add suspend callback
>       platform/x86/intel/pmc: Allow reenabling LTRs
>       platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback
>
> David Laight (3):
>       locking/osq_lock: Move the definition of optimistic_spin_node
> into osq_lock.c
>       locking/osq_lock: Clarify osq_wait_next() calling convention
>       locking/osq_lock: Clarify osq_wait_next()
>
> Edward Adam Davis (1):
>       keys, dns: Fix missing size check of V1 server-list header
>
> Helge Deller (2):
>       linux/export: Fix alignment for 64-bit ksymtab entries
>       linux/export: Ensure natural alignment of kcrctab array
>
> Jialu Xu (1):
>       gen_compile_commands.py: fix path resolve with symlinks in it
>
> Kent Overstreet (4):
>       bcachefs: fix BCH_FSCK_ERR enum
>       bcachefs: Fix insufficient disk reservation with compression + snap=
shots
>       bcachefs: Fix leakage of internal error code
>       bcachefs: Fix promotes
>
> Linus Torvalds (1):
>       Linux 6.7-rc8
>
> Masahiro Yamada (1):
>       kbuild: fix build ID symlinks to installed debug VDSO files
>
> Matthew Wilcox (Oracle) (4):
>       mm/memory-failure: pass the folio and the page to collect_procs()
>       mm/memory-failure: check the mapcount of the precise page
>       mm/memory-failure: cast index to loff_t before shifting it
>       mailmap: add an old address for Naoya Horiguchi
>
> Muhammad Usama Anjum (1):
>       selftests: secretmem: floor the memory size to the multiple of page=
_size
>
> Namjae Jeon (1):
>       ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
>
> Nathan Chancellor (1):
>       MAINTAINERS: Add scripts/clang-tools to Kbuild section
>
> Nico Pache (1):
>       kunit: kasan_test: disable fortify string checker on kmalloc_oob_me=
mset
>
> Shin'ichiro Kawasaki (1):
>       platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
>
> Sidhartha Kumar (1):
>       maple_tree: do not preallocate nodes for slot stores
>
> Stefan Hajnoczi (1):
>       virtio_blk: fix snprintf truncation compiler warning
>
> Steven Rostedt (Google) (4):
>       eventfs: Fix file and directory uid and gid ownership
>       ring-buffer: Fix wake ups when buffer_percent is set to 100
>       tracing: Fix blocked reader of snapshot buffer
>       ftrace: Fix modification of direct_function hash while in use
>
> Xuan Zhuo (1):
>       virtio_ring: fix syncs DMA memory with different direction
>

