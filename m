Return-Path: <linux-kernel+bounces-65182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA1854904
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4B8B259BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231FC1B966;
	Wed, 14 Feb 2024 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SSqUaCbY"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08111B818
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707913005; cv=none; b=CRlIo808g7c7sZy+TlGsY/racAnF1gJXW+z3FHvM7UfDAr4888Y8LvTo9T9RStcHgjRPdCgdIC6vxr9Vpwsa07GM9syEw6HIe/3CeXolUeHHFGkAi7NWzQ8aa6QW3nRqAP/9VVlh7CKiHJVVsc1bPfJmr0xh4oaaKFXN+IelO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707913005; c=relaxed/simple;
	bh=7TA3LfAbCdnQRIGZnXgtNshvZpZ2o4/w7KMIbm92kIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/pZneYETDbYtbQr/y2x85aFcJbCjwD+HtrRHzAsFBc7TxUKWt8i+DUhDYV89Eb3pCro/N/AzcfbW5bbf1QETqS7Ui+DVQlVsUKlSMeelaZEQJMRNPMijkAn5YuVsEyVnmoo+s0Gk24dm/pDyaiyqos95y9p6S66n3q+uqJMPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SSqUaCbY; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561f8b8c058so1401511a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707913001; x=1708517801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq56mU3kzs0YZfavPzE3ppk//dLjqXu5kzMLeRDlQkc=;
        b=SSqUaCbYKv4FaIrlkTt44K6rpntyX5/oS453xBwWe1niB2dBHjIVw9YBZB+WhwBz5m
         1IhnEeHWPRjCdMb846ICXqpY9ahFscJUc3xiREeIRnOmiMJYzCX2cKH3kP/ChNHCAKKk
         Z1yluJwnz72+ikxwNdXwZlv39WETxQZyTLcNQZdrKK+/EGD/RIAedfTNLSQ50d6iCSBs
         Ewzt7y4feLDwwnYxEGn0nJPgNmBwooBC6AXHfbSjesmpP40ZggncI4+k4vKC8MAmIs8/
         kOV+40nH+h+8Lv47/0hRisgVFVsMPE42uRKY2RuXNQTv7MwaizeBQfK7WVuJ9bWlpgU1
         +3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707913001; x=1708517801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq56mU3kzs0YZfavPzE3ppk//dLjqXu5kzMLeRDlQkc=;
        b=mLv0QIOaDAB6vy10k4Y0NXFqXEWWEKuvkdQ7QGOLd2TsAcFa7WFPrrlmTW7On59jsM
         wN9hwLzfAu6s8g1sCJKAdkckeY6EncaGkp1On7Tf6pz62+VHUuah/nhOspCu+Fqw2t99
         kKGxCSGCBdwRmVyutk69OJxc95GwiLlXhABSVEQNHpCF6qsrfC6UQGQx0LobnB1JbYDx
         fJ0UK97EpqDdO5jbGJbIx3P+bpDO6lCwrI9m/86VKUiY8hVQRNWghad9Z1iJ8HZGhQEa
         0ZJ4O1Wa7W4GfiFjNsIqVz2VWqjG4Favi7cxlgZiUsQTI5CeuizxkfcJL2a11jaa53vA
         TkIA==
X-Forwarded-Encrypted: i=1; AJvYcCWBIUn+KzxTBhL4MGavRsF6Is4leRG9L429X2C0spgkbCAAXG+zrKLFTUysk/YI2g+6Zk8yx0IfaBYAsDN8+TeFRRJi8f7zA2Q/Dzel
X-Gm-Message-State: AOJu0YwYGLLiPUmt7RU3YzkFnUklNfGD0R9Ewf7caEnStHltQTxJzvsq
	i1yY9CDrcE97avQgsxMCBmUc4mSRpISIy+qK16odIVK1NY9Hq4ObFv5DRf7yXigkUmws1Qx614B
	j92ai15KA0uNe9WGCHBIvZyclI0yJX5maUUDwQw==
X-Google-Smtp-Source: AGHT+IFT3kXJCupIXjFyOzJiZDZsYOWuAxsQAIVhl5i/hEZMgBhxRnVxH0NkHYxB8Gi8J6Snm2qRBO9F2hQAQm0UjZM=
X-Received: by 2002:a17:906:2485:b0:a3c:ce03:5d45 with SMTP id
 e5-20020a170906248500b00a3cce035d45mr1667371ejb.11.1707913000805; Wed, 14 Feb
 2024 04:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202402142035.Aq7hibAu-lkp@intel.com>
In-Reply-To: <202402142035.Aq7hibAu-lkp@intel.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 14 Feb 2024 13:16:29 +0100
Message-ID: <CAHVXubh2JAzKnOwyTMcR2zCPKeGVYduCzq+iqMLA6HnYcXT1yg@mail.gmail.com>
Subject: Re: include/linux/hugetlb.h:916:20: error: static declaration of
 'arch_hugetlb_migration_supported' follows non-static declaration
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 1:09=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   7e90b5c295ec1e47c8ad865429f046970c549a66
> commit: ce68c035457bdd025a9961e0ba2157323090c581 riscv: Fix arch_hugetlb_=
migration_supported() for NAPOT
> date:   7 days ago
> config: riscv-randconfig-r064-20240214 (https://download.01.org/0day-ci/a=
rchive/20240214/202402142035.Aq7hibAu-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c=
08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240214/202402142035.Aq7hibAu-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402142035.Aq7hibAu-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from kernel/fork.c:52:
> >> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hug=
etlb_migration_supported' follows non-static declaration
>      916 | static inline bool arch_hugetlb_migration_supported(struct hst=
ate *h)
>          |                    ^
>    arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arc=
h_hugetlb_migration_supported'
>       15 | #define arch_hugetlb_migration_supported arch_hugetlb_migratio=
n_supported
>          |                                          ^
>    arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is h=
ere
>       14 | bool arch_hugetlb_migration_supported(struct hstate *h);
>          |      ^
>    1 error generated.
> --
>    In file included from kernel/sysctl.c:45:
> >> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hug=
etlb_migration_supported' follows non-static declaration
>      916 | static inline bool arch_hugetlb_migration_supported(struct hst=
ate *h)
>          |                    ^
>    arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arc=
h_hugetlb_migration_supported'
>       15 | #define arch_hugetlb_migration_supported arch_hugetlb_migratio=
n_supported
>          |                                          ^
>    arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is h=
ere
>       14 | bool arch_hugetlb_migration_supported(struct hstate *h);
>          |      ^
>    In file included from kernel/sysctl.c:53:
>    In file included from include/linux/nfs_fs.h:31:
>    In file included from include/linux/sunrpc/auth.h:13:
>    In file included from include/linux/sunrpc/sched.h:19:
>    include/linux/sunrpc/xdr.h:782:46: warning: result of comparison of co=
nstant 4611686018427387903 with expression of type '__u32' (aka 'unsigned i=
nt') is always false [-Wtautological-constant-out-of-range-compare]
>      782 |         if (U32_MAX >=3D SIZE_MAX / sizeof(*p) && len > SIZE_M=
AX / sizeof(*p))
>          |                                                 ~~~ ^ ~~~~~~~~=
~~~~~~~~~~~~~
>    1 warning and 1 error generated.
> --
>    In file included from kernel/events/core.c:31:
> >> include/linux/hugetlb.h:916:20: error: static declaration of 'arch_hug=
etlb_migration_supported' follows non-static declaration
>      916 | static inline bool arch_hugetlb_migration_supported(struct hst=
ate *h)
>          |                    ^
>    arch/riscv/include/asm/hugetlb.h:15:42: note: expanded from macro 'arc=
h_hugetlb_migration_supported'
>       15 | #define arch_hugetlb_migration_supported arch_hugetlb_migratio=
n_supported
>          |                                          ^
>    arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration is h=
ere
>       14 | bool arch_hugetlb_migration_supported(struct hstate *h);
>          |      ^
>    In file included from kernel/events/core.c:43:
>    include/linux/mman.h:158:9: warning: division by zero is undefined [-W=
division-by-zero]
>      158 |                _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC  =
    ) |
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>    include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans=
'
>      136 |    : ((x) & (bit1)) / ((bit1) / (bit2))))
>          |                     ^ ~~~~~~~~~~~~~~~~~
>    1 warning and 1 error generated.
>
>
> vim +/arch_hugetlb_migration_supported +916 include/linux/hugetlb.h
>
> 161df60e9e8965 Naoya Horiguchi   2022-07-14  902
> c177c81e09e517 Naoya Horiguchi   2014-06-04  903  #ifdef CONFIG_ARCH_ENAB=
LE_HUGEPAGE_MIGRATION
> e693de186414ae Anshuman Khandual 2019-03-05  904  #ifndef arch_hugetlb_mi=
gration_supported
> e693de186414ae Anshuman Khandual 2019-03-05  905  static inline bool arch=
_hugetlb_migration_supported(struct hstate *h)
> e693de186414ae Anshuman Khandual 2019-03-05  906  {
> 94310cbcaa3c2b Anshuman Khandual 2017-07-06  907        if ((huge_page_sh=
ift(h) =3D=3D PMD_SHIFT) ||
> 9b553bf5eb99dd Anshuman Khandual 2019-03-05  908                (huge_pag=
e_shift(h) =3D=3D PUD_SHIFT) ||
> 94310cbcaa3c2b Anshuman Khandual 2017-07-06  909                        (=
huge_page_shift(h) =3D=3D PGDIR_SHIFT))
> 94310cbcaa3c2b Anshuman Khandual 2017-07-06  910                return tr=
ue;
> 94310cbcaa3c2b Anshuman Khandual 2017-07-06  911        else
> 94310cbcaa3c2b Anshuman Khandual 2017-07-06  912                return fa=
lse;
> e693de186414ae Anshuman Khandual 2019-03-05  913  }
> e693de186414ae Anshuman Khandual 2019-03-05  914  #endif
> c177c81e09e517 Naoya Horiguchi   2014-06-04  915  #else
> e693de186414ae Anshuman Khandual 2019-03-05 @916  static inline bool arch=
_hugetlb_migration_supported(struct hstate *h)
> e693de186414ae Anshuman Khandual 2019-03-05  917  {
> d70c17d436b3fb Chen Gang         2016-05-20  918        return false;
> e693de186414ae Anshuman Khandual 2019-03-05  919  }
> c177c81e09e517 Naoya Horiguchi   2014-06-04  920  #endif
> e693de186414ae Anshuman Khandual 2019-03-05  921
>
> :::::: The code at line 916 was first introduced by commit
> :::::: e693de186414ae66f2a316ff9befcd2b7a6d07b6 mm/hugetlb: enable arch s=
pecific huge page size support for migration
>
> :::::: TO: Anshuman Khandual <anshuman.khandual@arm.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

I sent a fix for this a few days ago here:
https://lore.kernel.org/linux-riscv/20240211083640.756583-1-alexghiti@rivos=
inc.com/T/#u

