Return-Path: <linux-kernel+bounces-103624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433287C213
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D48D1F22004
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82944745FA;
	Thu, 14 Mar 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7PRhRH0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980C74C0C;
	Thu, 14 Mar 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436921; cv=none; b=SI6Lk3AO4Pf/vFwcuIUFWcTGH47Qihl0XlnrqFLRxO5Fy7JO2UBf4J5cuYcRArxapleyqU4ZRZ4JrtSWfR9rqgjeG056X6yEyxIf7g9TS8Qdy8xbUnPYdjEHrXJo9FNLGXZst0e1Y8/zckJItnkrsWrT8N5FmFQ5GtoP57U5OKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436921; c=relaxed/simple;
	bh=FXrEH3M/IH7IFRkcj9qjFyB/CEQVFKIX7HcLdf3KbvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaW7sDPK3IDAPKx9z4XgytDVSZwB1UOJCTExnT1IED+7DdhpsEtTL5uVyq+afT9RCUFXwZuS2iGaI2EA0ghsX+6FNj5kvb2q3jUEgGILr37nKR1wHpRXHAjXvafePTowuRj8ddQlnwinJ91eBlx+li9e9ah3MTQrQnbxqOITCuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7PRhRH0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ececeb19eso164029f8f.3;
        Thu, 14 Mar 2024 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436918; x=1711041718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8omIJiDvHxyK3b+awxgLaasQCN8eMR86h8WDGSeQ4XU=;
        b=D7PRhRH08TFcJCarG9Z+Hd0WsJtv2GMr67TU741nwRxChyqXyr5SmaQk3KOjenGKTs
         S5yIK0/6REu02lsSfN46jnamx/34ZJH4KpW0qpcOc/cqFO2PddeYI6o9PDF3stvxdugT
         IbmdOKjvvsv5FAUQy/qpkjmX/xVG/BRv9aMGJ/AliK3CTJhNdfi3/GaalVUEFMnYY1iv
         L9Wytoxpzr+qi7KIOnm759A0o4YVSyTDUc8qWsr/3YOnk0zc2sauA3jCpWDMitbEKer0
         NzezVpgFWmpqsNcu8vYlYWlg+BpM0Ps1IgfcQM2s+fUl++kL2AeTEOhzvg+7HbnmH0aV
         gsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436918; x=1711041718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8omIJiDvHxyK3b+awxgLaasQCN8eMR86h8WDGSeQ4XU=;
        b=lnK/EKFRyA1pQs7/KeH0LEnjsTnt3o4HF38WbUWesQe4Ao7GRqPU26tRYBpj/PxYQh
         q+SC575ivbr0ybAU/BXqYuNiWURA1NKqx9NjaCU9S4SYScm82aUPEBUm5xBjw/mZqph0
         0o+OW6yxH8tC2WEevLLBVh39DX7f0eke45mEJN4y9+hQVThCoELKAJRI7aYdJ/OzXJ+8
         RBvYwQUbFDw/MQjWQZNLW4lM3ghFLicrevADKkj3IOPEowkCtk8f4r4JFa3G/lxHJVqx
         8+kT1hi77nknPQOdHQ2+Ez4HW5/oyKSk9VI78Y5PYQNd5NuQyfGBaWkf+xzB4IACf+sX
         UiOw==
X-Forwarded-Encrypted: i=1; AJvYcCVeCQXvhmVaWLjyY35+5ZtJBaaR4BKDnVVL7Yxm1WAeBBkvbmxYe+ZszhrGxmW03aDpB1mL6kT48fJkHwUSArVANnofgDxiULkJbqCdylDbUhr7wkU/eaOpRQCMp1xESPeC
X-Gm-Message-State: AOJu0Ywa2ihrM5wEP/fw/FhZ28wjIbWqnMWcEPgyi3ik8PTFhtfMyB4T
	b1PiTtufM6xxKwfdwuiPuRPzOGpLTMlVLTsV9NPzldMDXZ2FkLR9J5Zo/e8gVRhrn+gQ8CP3gI+
	4d3QLPoAGKGBQ4NVa3LRGTQqTZic=
X-Google-Smtp-Source: AGHT+IH5Wj3qmhCmgyAnPRU2qa9YAai8utdty4Z5Aaesw86Y4yqXNAQ5VygwN2khRUy5Jab9ygrwy8EvX0zK+aX6HWE=
X-Received: by 2002:a5d:4577:0:b0:33e:9116:bef4 with SMTP id
 a23-20020a5d4577000000b0033e9116bef4mr627661wrc.14.1710436917857; Thu, 14 Mar
 2024 10:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314150003.123020-1-puranjay12@gmail.com> <20240314150003.123020-2-puranjay12@gmail.com>
 <CAP01T75tG5tXqRJsMn6iU1xvmEqeuTg=ja=LUPqqXkrJiYL2XQ@mail.gmail.com> <mb61pfrwsohx5.fsf@gmail.com>
In-Reply-To: <mb61pfrwsohx5.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 10:21:46 -0700
Message-ID: <CAADnVQ+vAuP1UuFf6tY64AmHBqk4FjRY7DwEjKXwWUaczubDcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add arm64 JIT support for PROBE_MEM32
 pseudo instructions.
To: Puranjay Mohan <puranjay12@gmail.com>
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

On Thu, Mar 14, 2024 at 10:13=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Thu, 14 Mar 2024 at 16:00, Puranjay Mohan <puranjay12@gmail.com> wro=
te:
> >>
> >> Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> >> instructions.  They are similar to PROBE_MEM instructions with the
> >> following differences:
> >> - PROBE_MEM32 supports store.
> >> - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
> >>   src/dst register
> >> - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in R2=
8
> >>   in the prologue). Due to bpf_arena constructions such R28 + reg +
> >>   off16 access is guaranteed to be within arena virtual range, so no
> >>   address check at run-time.
> >> - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. Whe=
n
> >>   LDX faults the destination register is zeroed.
> >>
> >> To support these on arm64, we do tmp2 =3D R28 + src/dst reg and then u=
se
> >> tmp2 as the new src/dst register. This allows us to reuse most of the
> >> code for normal [LDX | STX | ST].
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> >> ---
> >
> > Hi Alexei,
> > Puranjay and I were discussing this stuff off list and noticed that
> > atomic instructions are not handled.
> > It turns out that will cause a kernel crash right now because the
> > 32-bit offset into arena will be dereferenced directly.
> >
> > e.g. something like this:
> >
> > @@ -55,6 +56,7 @@ int arena_list_add(void *ctx)
> >                 test_val++;
> >                 n->value =3D i;
> >                 arena_sum +=3D i;
> > +               __sync_fetch_and_add(&arena_sum, 0);
> >                 list_add_head(&n->node, list_head);
> >         }
> >  #else
> >
> > I will try to prepare a fix for the x86 JIT. Puranjay will do the same
> > for his set.
>
> Yes, testing the change mentioned by Kumar on ARM64 causes a crashes as w=
ell:
>
> bpf_testmod: loading out-of-tree module taints kernel.
>  bpf_testmod: module verification failed: signature and/or required key m=
issing - tainting kernel
>  Unable to handle kernel NULL pointer dereference at virtual address 0000=
000000000010
>  Mem abort info:
>    ESR =3D 0x0000000096000006
>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>    FSC =3D 0x06: level 2 translation fault
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
>    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000004043cc000
>  [0000000000000010] pgd=3D0800000410d8f003, p4d=3D0800000410d8f003, pud=
=3D0800000405972003, pmd=3D0000000000000000
>  Internal error: Oops: 0000000096000006 [#1] SMP
>  Modules linked in: bpf_testmod(OE) nls_ascii nls_cp437 sunrpc vfat fat a=
es_ce_blk aes_ce_cipher ghash_ce sha1_ce button sch_fq_codel dm_mod dax con=
figfs dmi_sysfs sha2_ce sha256_arm64 efivarfs
>  CPU: 8 PID: 5631 Comm: test_progs Tainted: G           OE      6.8.0+ #2
>  Hardware name: Amazon EC2 c6g.16xlarge/, BIOS 1.0 11/1/2018
>  pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
>  lr : bpf_prog_8771c336cb6a18eb_arena_list_add+0x144/0x2b8
>  sp : ffff80008b84bc30
>  x29: ffff80008b84bca0 x28: ffff8000a5008000 x27: ffff80008b84bc38
>  x26: 0000000000000000 x25: ffff80008b84bc60 x24: 0000000000000000
>  x23: 0000000000000000 x22: 0000000000000058 x21: 0000000000000838
>  x20: 0000000000000000 x19: 0000000100001fe0 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffcc66d2c8
>  x14: 0000000000000000 x13: 0000000000000000 x12: 000000000004058c
>  x11: ffff8000a5008010 x10: 00000000ffffffff x9 : 00000000000002cf
>  x8 : ffff800082ff4ab8 x7 : 0000000100001000 x6 : 0000000000000001
>  x5 : 0000000010e5e3fd x4 : 000000003619b978 x3 : 0000000000000010
>  x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000001fe0
>  Call trace:
>   bpf_prog_8771c336cb6a18eb_arena_list_add+0x204/0x2b8
>   bpf_prog_test_run_syscall+0x100/0x340
>   __sys_bpf+0x8e8/0xa20
>   __arm64_sys_bpf+0x2c/0x48
>   invoke_syscall+0x50/0x128
>   el0_svc_common.constprop.0+0x48/0xf8
>   do_el0_svc+0x28/0x40
>   el0_svc+0x58/0x190
>   el0t_64_sync_handler+0x13c/0x158
>   el0t_64_sync+0x1a8/0x1b0
>  Code: 8b010042 8b1c006b f9000162 d2800001 (f821307f)
>  ---[ end trace 0000000000000000 ]---
>  Kernel panic - not syncing: Oops: Fatal exception
>  SMP: stopping secondary CPUs
>  Kernel Offset: disabled
>  CPU features: 0x0,00000120,7002014a,21407a0b
>  Memory Limit: none
>  Rebooting in 5 seconds..
>
> I will send v2 with the arm64 JIT fix, but I guess verifier has to be mod=
ified
> as well to add BPF_PROBE_MEM32 to atomic instructions.

The JIT and the verifier changes for atomics might be too big.
Let's disable atomics in arena in the verifier for now.
Pls send a patch.

