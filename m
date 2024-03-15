Return-Path: <linux-kernel+bounces-104269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D587CB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102181C21064
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C448199BC;
	Fri, 15 Mar 2024 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAFEdedN"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806841C2AF;
	Fri, 15 Mar 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498719; cv=none; b=THFr87eVoGoUAbEZLGXSdlJU1alFxCjza+laYuWRgWl96TUr/1Wwnv3Qj/gldcBAVkT4tO/nwMOa4+YXw6vE++pBgIXcnFr24MZAV5gLRpaNOkJC92xSpjV8N5RvqTUqv4VsAjlkrF7ci/FOZJ4sWvTzgfSUAXchV1hX48lQsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498719; c=relaxed/simple;
	bh=zfiUBLeK+PtZG4A+qL9jArSHbLnJbmxDpCXiIS0qrUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4jPWADaJJxPCP4McoW2P3BzsQjosSfLKcod/etbC+/J3xnNgZp8/GC7rNGNlPjjYiO1/C5AykIWRsFTyDa3ydAP6KUG+kjiP9c9nmMJxLk/+ElNwG0CJiqLS6sqFK8wt7xxFfPZeK78RKjdV9M0ZyeEN+IDEbbigukuerm9AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAFEdedN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d48ba4d5ecso3671741fa.1;
        Fri, 15 Mar 2024 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710498716; x=1711103516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkgvVj4VQnM0U5OLYxoLZxYfZKzb6GHR+JPP7Dvj7ys=;
        b=mAFEdedNPm2iIYUyQmSqU+j5sg5ops36pys5XuegzilsQ3BUawDfADBSfqWtWqTGcL
         hYnhWHXQLVyLg76n6JhetfQaNGpNrS+1SsJtVs7eLNJ8BwNpk0YoUhjtlv1wYauL/v0z
         KujjuSXnOw8V7ZzVZo34Hu5Ll7ueTGZ0Zz/Sj2B1b5lUzm2D2KCiHukNbqHSDtq0T4UK
         xf/wSWVjGPpI0QEsuNCR+vN4cMwMpAQmhPNtE3qPsMHHKqdIgfsbviaqwbdEKLaRMWZi
         UhMRpyrPDpc8p0f6hNgFjYY/3bOM7qgy5FCTrbMc6NYUTzJCYBhWbuchgghcrNd7cKB5
         b0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710498716; x=1711103516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkgvVj4VQnM0U5OLYxoLZxYfZKzb6GHR+JPP7Dvj7ys=;
        b=vIkX6eXQLkLryOrFspdLcAfjTXvDvfHapZJQFFWBdr96S8bzsgCAq5MnkrHU0Bb61m
         0tpCicTpQobUI/WnmRbD00zrsPdogCQ2bGbCzg045uk37cAOP/jg4VsItcPfijFVjEVC
         o2N3nrgGF8naLocRVLbAO8TOWbWzI/yBb97XklaxiABsA3l65dRxSn/Xkp0gIB9J3kPs
         JPmUNvhXls/oI+c6J1iefI7xcmCsSdQPGeHP/dN3wbTIME9Itr4hZgncfpGwLGijcnPS
         7fQGADGZc5Goe4Tfxh4MszIXDTqpnm7zewmBQQkY4bE04sU2CIjC3q1RhpXBdONugK/5
         YU8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9HCDb43hhWwhOtvF/QZGLBpdZuGw4XOzXLhJvBLshgCqMryDN+mcwLsx9+JiF3aF9pAxWy/gErQKz4GFmbCsjG4dfeeiHocxPm0KZ+paGCV5hD3RJhwa9559Qlztbe0z3
X-Gm-Message-State: AOJu0YyXsAMeuNF4nsLpYhJ7wfk4ou5hrFSDO9KEjMPDgiGAS1kjOHV1
	zjHoxo9VhCTYHTo9G6/xoD/Vq9e3iS1BysgvybGuKE5XMoBjSJKuJo3gGlpHossGsnX7BqlLeAE
	i+FTG5NztHtGwPsQeGSFEQOf1HuE=
X-Google-Smtp-Source: AGHT+IFoe+KXjZBP9/D8N3JpUzEHl/Z5odV3mFyPV9Zy3sD3yWRo9tM+wc9McbZUNoKbgm7mMP8EYEvEMzIK16e3ZO4=
X-Received: by 2002:a2e:8904:0:b0:2d4:8a62:bd4f with SMTP id
 d4-20020a2e8904000000b002d48a62bd4fmr491248lji.3.1710498715148; Fri, 15 Mar
 2024 03:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314150003.123020-1-puranjay12@gmail.com> <20240314150003.123020-2-puranjay12@gmail.com>
 <CAP01T75tG5tXqRJsMn6iU1xvmEqeuTg=ja=LUPqqXkrJiYL2XQ@mail.gmail.com>
 <mb61pfrwsohx5.fsf@gmail.com> <CAADnVQ+vAuP1UuFf6tY64AmHBqk4FjRY7DwEjKXwWUaczubDcg@mail.gmail.com>
In-Reply-To: <CAADnVQ+vAuP1UuFf6tY64AmHBqk4FjRY7DwEjKXwWUaczubDcg@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 15 Mar 2024 11:31:44 +0100
Message-ID: <CANk7y0g0i=9U89kdpZARKgf5MnKy4dM1m5zDjo=3LSAwaDEcYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add arm64 JIT support for PROBE_MEM32
 pseudo instructions.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 6:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 14, 2024 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
com> wrote:
> >
> > Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
> >
> > > On Thu, 14 Mar 2024 at 16:00, Puranjay Mohan <puranjay12@gmail.com> w=
rote:
> > >>
> > >> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> > >> instructions.  They are similar to PROBE_MEM instructions with the
> > >> following differences:
> > >> - PROBE_MEM32 supports store.
> > >> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
> > >>   src/dst register
> > >> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in =
R28
> > >>   in the prologue). Due to bpf_arena constructions such R28 + reg +
> > >>   off16 access is guaranteed to be within arena virtual range, so no
> > >>   address check at run-time.
> > >> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. W=
hen
> > >>   LDX faults the destination register is zeroed.
> > >>
> > >> To support these on arm64, we do tmp2 =3D R28 + src/dst reg and then=
 use
> > >> tmp2 as the new src/dst register. This allows us to reuse most of th=
e
> > >> code for normal [LDX | STX | ST].
> > >>
> > >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > >> ---
> > >
> > > Hi Alexei,
> > > Puranjay and I were discussing this stuff off list and noticed that
> > > atomic instructions are not handled.
> > > It turns out that will cause a kernel crash right now because the
> > > 32-bit offset into arena will be dereferenced directly.
> > >
> > > e.g. something like this:
> > >
> > > @@ -55,6 +56,7 @@ int arena_list_add(void *ctx)
> > >                 test_val++;
> > >                 n->value =3D i;
> > >                 arena_sum +=3D i;
> > > +               __sync_fetch_and_add(&arena_sum, 0);
> > >                 list_add_head(&n->node, list_head);
> > >         }
> > >  #else
> > >
> > > I will try to prepare a fix for the x86 JIT. Puranjay will do the sam=
e
> > > for his set.
> >
> > Yes, testing the change mentioned by Kumar on ARM64 causes a crashes as=
 well:
> >
> > bpf_testmod: loading out-of-tree module taints kernel.
> >  bpf_testmod: module verification failed: signature and/or required key=
 missing - tainting kernel
> >  Unable to handle kernel NULL pointer dereference at virtual address 00=
00000000000010
> >  Mem abort info:
> >    ESR =3D 0x0000000096000006
> >    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >    SET =3D 0, FnV =3D 0
> >    EA =3D 0, S1PTW =3D 0
> >    FSC =3D 0x06: level 2 translation fault
> >  Data abort info:
> >    ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
> >    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> >    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> >  user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000004043cc000
> >  [0000000000000010] pgd=3D0800000410d8f003, p4d=3D0800000410d8f003, pud=
=3D0800000405972003, pmd=3D0000000000000000
> >  Internal error: Oops: 0000000096000006 [#1] SMP
> >  Modules linked in: bpf_testmod(OE) nls_ascii nls_cp437 sunrpc vfat fat=
 aes_ce_blk aes_ce_cipher ghash_ce sha1_ce button sch_fq_codel dm_mod dax c=
onfigfs dmi_sysfs sha2_ce sha256_arm64 efivarfs
> >  CPU: 8 PID: 5631 Comm: test_progs Tainted: G           OE      6.8.0+ =
#2
> >  Hardware name: Amazon EC2 c6g.16xlarge/, BIOS 1.0 11/1/2018
> >  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >  pc : bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
> >  lr : bpf_prog_8771c336cb6a18eb_arena_list_add+0x144/0x2b8
> >  sp : ffff80008b84bc30
> >  x29: ffff80008b84bca0 x28: ffff8000a5008000 x27: ffff80008b84bc38
> >  x26: 0000000000000000 x25: ffff80008b84bc60 x24: 0000000000000000
> >  x23: 0000000000000000 x22: 0000000000000058 x21: 0000000000000838
> >  x20: 0000000000000000 x19: 0000000100001fe0 x18: 0000000000000000
> >  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffcc66d2c8
> >  x14: 0000000000000000 x13: 0000000000000000 x12: 000000000004058c
> >  x11: ffff8000a5008010 x10: 00000000ffffffff x9 : 00000000000002cf
> >  x8 : ffff800082ff4ab8 x7 : 0000000100001000 x6 : 0000000000000001
> >  x5 : 0000000010e5e3fd x4 : 000000003619b978 x3 : 0000000000000010
> >  x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000001fe0
> >  Call trace:
> >   bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
> >   bpf_prog_test_run_syscall+0x100/0x340
> >   __sys_bpf+0x8e8/0xa20
> >   __arm64_sys_bpf+0x2c/0x48
> >   invoke_syscall+0x50/0x128
> >   el0_svc_common.constprop.0+0x48/0xf8
> >   do_el0_svc+0x28/0x40
> >   el0_svc+0x58/0x190
> >   el0t_64_sync_handler+0x13c/0x158
> >   el0t_64_sync+0x1a8/0x1b0
> >  Code: 8b010042 8b1c006b f9000162 d2800001 (f821307f)
> >  ---[ end trace 0000000000000000 ]---
> >  Kernel panic - not syncing: Oops: Fatal exception
> >  SMP: stopping secondary CPUs
> >  Kernel Offset: disabled
> >  CPU features: 0x0,00000120,7002014a,21407a0b
> >  Memory Limit: none
> >  Rebooting in 5 seconds..
> >
> > I will send v2 with the arm64 JIT fix, but I guess verifier has to be m=
odified
> > as well to add BPF_PROBE_MEM32 to atomic instructions.
>
> The JIT and the verifier changes for atomics might be too big.
> Let's disable atomics in arena in the verifier for now.
> Pls send a patch.

As atomics are disabled in the Arena now, this series will not require
any changes.
Looking forward to the reviews.

Thanks,
Puranjay

