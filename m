Return-Path: <linux-kernel+bounces-105042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33D287D81F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB4F1F21A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18529A0;
	Sat, 16 Mar 2024 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b="xjP0N31B"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238B1FDD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710558863; cv=none; b=anq2Ts6B/sl8fB15G3i0fHSf9Gjzh85YvGJgeWRx7LLbFLfAvrA15yxoUJzDj6ScKsL5s8WfQy+GAqZXEvE4blU2qH7pmdYm5vW9cF2kM6vd3sZJnoEJEjOIZw42daq3fFoFBeP9Fgs7s1y+C+F8F/bALV3sTYYBbe+xXgm4rig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710558863; c=relaxed/simple;
	bh=6eLdmh8za8M9SlO1/FdsHENEjex9kkHmDzLpfZLWkEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUB4YHPCT6vi+9LqmJ057BsqELVkGB4vIA4oMc+Krr6g5z7GBDJYA1Y6fnbK+r8fu9lnrX5Stbq5jRsoYhhikRdHdYKSeK59qHGWyXGPdlUHBD5+9J2rTzIbwuRG7x/gckJoLKZcME+Zj43EruYvsrgStpQ+18B+SgLNLlznpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sempervictus.com; spf=pass smtp.mailfrom=sempervictus.com; dkim=pass (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b=xjP0N31B; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sempervictus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sempervictus.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2521202276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sempervictus-com.20230601.gappssmtp.com; s=20230601; t=1710558860; x=1711163660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE8ReMJXOBRMOJPX+O2xrNy0SwcxcCJ3CQ8iZfhs2B0=;
        b=xjP0N31BkJwoKbJEJt0kWT/kayz9V6eWPX0oORv4CR3MVspQgOCP/n9FrRvXwO1QWI
         MC2rZh9x8GWjdROgsozPc/dtajhrFCfW8XS1904C41whGnxljMwyIPs0m7PC3TrUkfSS
         xcNx558/luvYipEuPvzdCdr6ZGBc9jpcrrY1M2vtuto8cc3Bm8htuqCLQbyie5Rhi5iW
         noyeIKz2KJR1OZd/bjw++JXxGjTALnA753LvJrV09HDRWzLNVj1noFWkEjn83NgWfZaX
         icw+mRck1J/Fqrnk4hsKW2A1ktjw50FuxhCVJLml2OP8cQzXfauUQNM5onLTxPWsxr3B
         Q22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710558860; x=1711163660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE8ReMJXOBRMOJPX+O2xrNy0SwcxcCJ3CQ8iZfhs2B0=;
        b=Z70DSTmd6VS9RhPmsWU79ghy+6ujCfe1Ak18/HBm55bZ6eGJCIsKD+OCUcYytoKtln
         a8oQEyw6v1//8oPIvDwWTHkcdEi5RNjhk/1MDljHTBE9BUKMS+4qgjgnOReC5aO6grmW
         03XDvEzER7rjnuqFiFl+6v9gbd02Fyh8CgrIF2RppEpzIrF/8mgia2ReXigwXuAgdWcP
         LojEwJgzPnDpu/OoiNu8chJ6unrF1gbCij19rGtrj1vXvN+/q8Fm795wboRvuBLKbfsI
         jG1R6kL0JnqbmjyaW2tPPopSzrsphPVkPywb5GxQTCKYcx+tNjvz8RQvEeTzjrf+0IO6
         WeWg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5I22K+HTfGgzMwo9yy1s6yNQ5cQs6FZ5KfmV+k9fTWUrQKEgU4CGY9v77zrXiVAzBBsxZYkG9igh8tl6K6l1IT8QKkPvbULhGFsN
X-Gm-Message-State: AOJu0Yxgjd4GSFLjcoqEa6EQ+SEjJ2CKAHPMIdoy08TBAoBYmGqdF/De
	QFVzrBB018klM6CuCVZ5mxt+a4GKhZELOaI12PZspKfIR9g35v6ydWwMoZuHzUfoQqHNbgl9Id8
	Pixwns0v4YQBhhgvhT4YJUftI4FSG4J9XarKYdQ==
X-Google-Smtp-Source: AGHT+IFyhoPSc7JGdV+oe6psqd2uVvvZN4Som/ELZ4Ld8+Wk1xchMqIF+Bg6WUGCWLR3cdz5i24uA4aJxYVCqEJ29MI=
X-Received: by 2002:a5b:a90:0:b0:dcc:84ae:9469 with SMTP id
 h16-20020a5b0a90000000b00dcc84ae9469mr5780484ybq.64.1710558860175; Fri, 15
 Mar 2024 20:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
From: Boris Lukashev <blukashev@sempervictus.com>
Date: Fri, 15 Mar 2024 23:14:09 -0400
Message-ID: <CAFUG7Cfy6nmWk9xmTD4rp80i4_RA12V7SA6851BvD=JaWRZeyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/19] PKS write protected page tables
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org, 
	x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org, 
	shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

IIRC shoot-downs are one of the reasons for using per-cpu PGDs, which
can in-turn enable/underpin other hardening functions... presuming the
churn of recent years has softened attitudes toward such core MM
changes.
https://forum.osdev.org/viewtopic.php?f=3D15&t=3D29661

-Boris


On Mon, Aug 30, 2021 at 8:02=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> Hi,
>
> This is a second RFC for the PKS write protected tables concept. I'm shar=
ing to
> show the progress to interested people. I'd also appreciate any comments,
> especially on the direct map page table protection solution (patch 17).
>
> Since v1[1], the improvements are:
>  - Fully handle direct map page tables, and handle hotplug/unplug path.
>  - Create a debug time checker that scans page tables and verifies
>    their protection.
>  - Fix odds-and-ends kernel page tables that showed up with debug
>    checker. At this point all of the typical normal page tables should be
>    protected.
>  - Fix toggling of writablility for odds-and-ends page table modification=
s found
>    that don't use the normal helpers.
>  - Create atomic context grouped page allocator, after finding some page =
table
>    allocations that are passing GFP_ATOMIC.
>  - Create "soft" mode that warns and disables protection on violation ins=
tead
>    of oopsing.
>  - Boot parameters for disabling pks tables
>  - Change PageTable set clear to ctor/dtor (peterz)
>  - Remove VM_BUG_ON_PAGE in alloc_table() (Shakeel Butt)
>  - PeterZ/Vlastimil had suggested to also build a non-PKS mode for use in
>    debugging. I skipped it for now because the series was too big.
>  - Rebased to latest PKS core v7 [2]
>
> Also, Mike Rapoport has been experimenting[3] with this usage to work on =
how to
> share caches of permissioned/broken pages between use cases. This RFCv2 s=
till
> uses the "grouped pages" concept, where each usage would maintain its own
> cache, but should be able to integrate with a central solution if somethi=
ng is
> developed.
>
> Next I was planning to look into characterizing/tuning the performance, a=
lthough
> what page allocation scheme is ultimately used will probably impact that.
>
> This applies on top of the PKS core v7 series[2] and this patch[4]. Testi=
ng is
> still pretty light.
>
> This RFC has been acked by Dave Hansen.
>
> [1] https://lore.kernel.org/lkml/20210505003032.489164-1-rick.p.edgecombe=
@intel.com/
> [2] https://lore.kernel.org/lkml/20210804043231.2655537-1-ira.weiny@intel=
com/
> [3] https://lore.kernel.org/lkml/20210823132513.15836-1-rppt@kernel.org/
> [4] https://lore.kernel.org/lkml/20210818221026.10794-1-rick.p.edgecombe@=
intel.com/
>
> Rick Edgecombe (19):
>   list: Support getting most recent element in list_lru
>   list: Support list head not in object for list_lru
>   x86/mm/cpa: Add grouped page allocations
>   mm: Explicitly zero page table lock ptr
>   x86, mm: Use cache of page tables
>   x86/mm/cpa: Add perm callbacks to grouped pages
>   x86/cpufeatures: Add feature for pks tables
>   x86/mm/cpa: Add get_grouped_page_atomic()
>   x86/mm: Support GFP_ATOMIC in alloc_table_node()
>   x86/mm: Use alloc_table() for fill_pte(), etc
>   mm/sparsemem: Use alloc_table() for table allocations
>   x86/mm: Use free_table in unmap path
>   mm/debug_vm_page_table: Use setters instead of WRITE_ONCE
>   x86/efi: Toggle table protections when copying
>   x86/mm/cpa: Add set_memory_pks()
>   x86/mm: Protect page tables with PKS
>   x86/mm/cpa: PKS protect direct map page tables
>   x86/mm: Add PKS table soft mode
>   x86/mm: Add PKS table debug checking
>
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  arch/x86/boot/compressed/ident_map_64.c       |   5 +
>  arch/x86/include/asm/cpufeatures.h            |   2 +-
>  arch/x86/include/asm/pgalloc.h                |   6 +-
>  arch/x86/include/asm/pgtable.h                |  31 +-
>  arch/x86/include/asm/pgtable_64.h             |  33 +-
>  arch/x86/include/asm/pkeys_common.h           |   1 -
>  arch/x86/include/asm/set_memory.h             |  24 +
>  arch/x86/mm/init.c                            |  90 +++
>  arch/x86/mm/init_64.c                         |  29 +-
>  arch/x86/mm/pat/set_memory.c                  | 527 +++++++++++++++++-
>  arch/x86/mm/pgtable.c                         | 183 +++++-
>  arch/x86/mm/pkeys.c                           |   4 +
>  arch/x86/platform/efi/efi_64.c                |   8 +
>  include/asm-generic/pgalloc.h                 |  46 +-
>  include/linux/list_lru.h                      |  26 +
>  include/linux/mm.h                            |  16 +-
>  include/linux/pkeys.h                         |   1 +
>  mm/Kconfig                                    |  23 +
>  mm/debug_vm_pgtable.c                         |  36 +-
>  mm/list_lru.c                                 |  38 +-
>  mm/memory.c                                   |   1 +
>  mm/sparse-vmemmap.c                           |  22 +-
>  mm/swap.c                                     |   6 +
>  mm/swap_state.c                               |   5 +
>  .../arch/x86/include/asm/disabled-features.h  |   8 +-
>  26 files changed, 1123 insertions(+), 52 deletions(-)
>
> --
> 2.17.1
>


--=20
Boris Lukashev
Systems Architect
Semper Victus

