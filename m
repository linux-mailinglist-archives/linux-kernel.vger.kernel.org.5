Return-Path: <linux-kernel+bounces-22792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE782A2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6E1C22E72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EC54F1F6;
	Wed, 10 Jan 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JW2UCcKX"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37C4EB5B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dbf2737bd48so1022307276.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704920326; x=1705525126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv9MH691+jo0u4+/ypKxuXp6hr+kgWjq9yWiPlvGr5E=;
        b=JW2UCcKXAZ9R+XpK22XHUf2dQbIw5Zj4aTvrWFRAazsBzltqheWdUuagvOD09mpQiv
         HCXFXu5mwqyX3M7al1k+HBAtJE3qcl/hHZERhyy1wgTw9yzIvNSkktNljTDgkKjOSGDp
         Re1bAwuldv3bpuSZOxK/ldFLjaGnW9qSOludMKk5ZwtgPPg6bbfiFPoMI0BNLP8j1Jik
         jiyrD7XUuCCgnm/Lj7u/FHXd2norJ7EzfNmkbVnKkWYIMxDIeLhZPv85V6zBQB7v7uji
         hxTa5ATZXVBGZHLkaKJgtUU0jU27Mj7BYN6w8RGfnihdiaD80iMGvIlxM0PaXQQ97qJn
         euEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920326; x=1705525126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv9MH691+jo0u4+/ypKxuXp6hr+kgWjq9yWiPlvGr5E=;
        b=rPL6OklUVsDrwGtW1V2gvh4sIm26Vn6/nxVKjj2gHQIW7V2D8cxGkBFT1TnF4ckHDV
         ZmLfDkILOAhGL3msTyouMdZplw4BXYXrKamVFXV4NhjrDaZbHnTTsSIJ82O+mci8qmgJ
         dFWcJYsItXl1ofrMCIf5UKQwhmRxLuKBZNjG6CdSEalhxrjDihPEk0sZkj96wSz7T84g
         BdxUkHj5Da9p8kzzy64HBb7d2K1P9hIBj+4WEnZa74QPi5d1LYxC+4jEXe7QK7hIZuOG
         fWkamm8f2p4PFggmybp9+WDxY4RS6MxWPcP6003laut+PMP7kb5zi2lghhwPNyoi2Mnr
         wNSw==
X-Gm-Message-State: AOJu0Yx/7VIe4VoTvRCihsmzItpe4rSKNxpLzoRH6SmjfPeyvUXzd4rh
	9oCWetNNhyCGI/YGitV+OmbflYdaH3p3VcQj6WviqIC2v+Ee
X-Google-Smtp-Source: AGHT+IG5fzfcYi/6mDr2n4Sh5/DMHH9uQP4qer0gcNiqc30VIYDckm7Pw6MvD3vzWcIC9Iv4fUWciCYnxf3Oh1p8Htk=
X-Received: by 2002:a05:6902:1d2:b0:dbe:8756:30ca with SMTP id
 u18-20020a05690201d200b00dbe875630camr208487ybh.76.1704920325834; Wed, 10 Jan
 2024 12:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
 <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
 <CAHC9VhRxG2jYayjpC=bLuBpfZsXnfYj_GoDBeK527sZWRe0ZrQ@mail.gmail.com> <CAHk-=winAVoX=u+uX1Cdf0ekmFHETumRr60rvC_z6jbno0ApPg@mail.gmail.com>
In-Reply-To: <CAHk-=winAVoX=u+uX1Cdf0ekmFHETumRr60rvC_z6jbno0ApPg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2024 15:58:35 -0500
Message-ID: <CAHC9VhQ6qcPZuL8jE0smNSeCfEbyk+6L0--t0iF4Awh7HHo1Jg@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 10 Jan 2024 at 11:54, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Thanks for pulling the changes, I'm sorry the syscall table entries
> > for the LSM syscalls were not how you want to see them, but I'm more
> > than a little confused as to what exactly we did wrong here.
>
> Look at commit 5f42375904b0 ("LSM: wireup Linux Security Module
> syscalls") and notice for example this:
>
>   --- a/arch/x86/entry/syscalls/syscall_64.tbl
>   +++ b/arch/x86/entry/syscalls/syscall_64.tbl
>   @@ -378,6 +378,9 @@
>    454    common  futex_wake              sys_futex_wake
>    455    common  futex_wait              sys_futex_wait
>    456    common  futex_requeue           sys_futex_requeue
>   +457    common  lsm_get_self_attr       sys_lsm_get_self_attr
>   +458    common  lsm_set_self_attr       sys_lsm_set_self_attr
>   +459    common  lsm_list_modules        sys_lsm_list_modules
>
> Ok, fine - you added your new system calls to the end of the table.
> Sure, I ended up having to fix them up because the "end of the table"
> was different by the time I merged your tree, but that wasn't the
> problem.
>
> The problem is here - in the same commit:
>
>   --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
>   +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
>   @@ -375,6 +375,9 @@
>    451    common  cachestat               sys_cachestat
>    452    common  fchmodat2               sys_fchmodat2
>    453    64      map_shadow_stack        sys_map_shadow_stack
>   +454    common  lsm_get_self_attr       sys_lsm_get_self_attr
>   +455    common  lsm_set_self_attr       sys_lsm_set_self_attr
>   +456    common  lsm_list_modules        sys_lsm_list_modules
>
> note how you updated the tools copy WITH THE WRONG NUMBERS!
>
> You just added them at the end of the table again, and just
> incremented the numbers, but that was complete nonsense, because the
> numbers didn't actually match the real system call numbers, because
> that tools table hadn't been updated for new system calls - because it
> hadn't needed them.
>
> Yeah, our tooling header duplication is annoying, but the old
> situation where the tooling just used various kernel headers directly
> and would randomly break when kernel changes were made was even worse.
>
> End result: avoid touching the tooling headers - and if you have to,
> you need to *think* about it.

Thanks for the explanation, when I read your comment about "tools" I
was thinking of whatever tooling transforms the arch/**/*.tbl file and
not the tools/perf directory.  I should have caught the tools/perf
mismatch when reviewing the patches from Casey, but I didn't, I'm
sorry.  My guess is that my mind was just in the "use the next three
numbers" due to the lack of syscall number sync across architectures,
but who knows.  My mistake, I'll make sure it doesn't happen again.

--=20
paul-moore.com

