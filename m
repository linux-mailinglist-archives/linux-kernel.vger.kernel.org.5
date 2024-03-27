Return-Path: <linux-kernel+bounces-121166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76288E30A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A563E297A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1517A923;
	Wed, 27 Mar 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyn+UApI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E017A911;
	Wed, 27 Mar 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542251; cv=none; b=Lhao6yi2d6JJXetG3m+wDiQvakHF7qOX99qEm7VwuR1PD4mUYbuZy9V3/Zx7lV35Lswc7zmK0RfMc/LmtlDofxbQzG3aQ9mh8U+d2d1GxMKt1IWn+E6cobpMtWCJrJPFkBaYYsOHusrOhAt1XmkQLOUkL20ZcW9WRxeVaeSO9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542251; c=relaxed/simple;
	bh=aILctM/4IaWB0TVDutDw4QQqKI+aELVY+YewBrIQIbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkVau4HwsmcDN7Pfdot3W4Q1YUZ6wYISuIocDjFjpe4D+T+8V8icUIQpZ+Qij64vluRZTZ6wDClNq9P9ZxTmsSQQkHm62XzNwb2/plbwyf8iOHak2DZ1oVKLwi8U+jRWHMWFrjkChaeMtq5okcMB7eluEc7UBCcyuAkLm/NicDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyn+UApI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D0C433B1;
	Wed, 27 Mar 2024 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542251;
	bh=aILctM/4IaWB0TVDutDw4QQqKI+aELVY+YewBrIQIbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lyn+UApI7G6jvuwj8RDzwBHEzsxkiild9br+8R95OBWE/hoE6C6D83/Y11m+WRbax
	 5KNcaLV6FEYOUcAvTRJBppcRwUBWDq1KWNwGDGRXartaesCMMvPxHsGEmwMvOzg9Tp
	 Tm9mTKX0Vm0TPkhTDgxVv965YljQs+jwcNsLWIeJhZUXQ5Pw9Lgk4fe/MF4509rKyH
	 brQ3hFBFhwzTjnMtGN02oY2Uotft08nHbJdKjTdqcJr+wH0n4aa23LH/LxD7zTbRX/
	 wEJycNoT6XNubPIZdTcxwZnMxYMws24voL9XGQXwb3DvEJE3HoWgPjw6riY04U0mse
	 GZqYHLV+YfcYQ==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4a39ab1a10so441487666b.1;
        Wed, 27 Mar 2024 05:24:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/ub6RndJuhGQxC4OCQbHens+xLo2vJ+VCNfqvB9Xa8LrWay5Y+d3WZPMGpyfbuDH08DrG9tYR0Iw1vqoMGvt3wfV3CZ2gwDx1OXwnbRwwLkPeLFG67BlnE1WJ2QzlBcg4
X-Gm-Message-State: AOJu0Yz+rp5vZQN4sBrDVHF0q78/kNDmCw68f7tLDMjg5XpbMD8kBcyb
	QoBI2T8jURdQrFVkKAmNkBQz6G4iejlK+oDZtmpk/yjrUYJDHs79HO2kH/MgDH18OD8GZPPBBOY
	HhX4KUm1GP+w5ZO1eiJ3Aagmsc30=
X-Google-Smtp-Source: AGHT+IH5QG4gK2oTVi3ncpzY0t5JIQmgvy6v0aZwbtRBomJdCe823Y8g9QFMk8+duWZLnOUiQv1hA8IKlQ37EBfGEDU=
X-Received: by 2002:a17:906:3610:b0:a47:ae0:160 with SMTP id
 q16-20020a170906361000b00a470ae00160mr1774953ejb.73.1711542250005; Wed, 27
 Mar 2024 05:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326224943.86912-1-puranjay12@gmail.com>
In-Reply-To: <20240326224943.86912-1-puranjay12@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 27 Mar 2024 13:23:58 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNgi=nB1qneuAGkpEb7GihGoegVJFVp5ZN8o-m2v3UG1yw@mail.gmail.com>
Message-ID: <CAJ+HfNgi=nB1qneuAGkpEb7GihGoegVJFVp5ZN8o-m2v3UG1yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf,riscv: Add support for BPF Arena
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, bpf@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pu Lehui <pulehui@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 at 23:49, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Changes in V3
> V2: https://lore.kernel.org/bpf/20240325155434.65589-1-puranjay12@gmail.c=
om/
> - Use REG_DONT_CLEAR_MARKER in place of DONT_CLEAR as the name.
> - Use RV_REG_ZERO for the above as it is guaranteed to be never used in a=
s
>   dst/src register in BPF LDX/STX/ST instructions.
> - Use #define RV_REG_ARENA for RV_REG_S7
>
> Changes in V2
> V1: https://lore.kernel.org/bpf/20240323154652.54572-1-puranjay12@gmail.c=
om/
> - Used S7 in place of S11 for storing the kernel_vm_start
> - Used 17 in place of 16 for DONT_CLEAR marker
> - Remove an unused variable
> - Removed some misleading information from the commit message.
>
> This series adds the support for PROBE_MEM32 and bpf_addr_space_cast
> instructions to the RISCV BPF JIT. These two instructions allow the
> enablement of BPF Arena.
>
> All arena related selftests are passing:
>
>   root@rv-tester:~/bpf# uname -p
>   riscv64
>   root@rv-tester:~/bpf# ./test_progs -a "*arena*"
>   #3/1     arena_htab/arena_htab_llvm:OK
>   #3/2     arena_htab/arena_htab_asm:OK
>   #3       arena_htab:OK
>   #4/1     arena_list/arena_list_1:OK
>   #4/2     arena_list/arena_list_1000:OK
>   #4       arena_list:OK
>   #434/1   verifier_arena/basic_alloc1:OK
>   #434/2   verifier_arena/basic_alloc2:OK
>   #434/3   verifier_arena/basic_alloc3:OK
>   #434/4   verifier_arena/iter_maps1:OK
>   #434/5   verifier_arena/iter_maps2:OK
>   #434/6   verifier_arena/iter_maps3:OK
>   #434     verifier_arena:OK
>   Summary: 3/10 PASSED, 0 SKIPPED, 0 FAILED
>
> This feature needs the following two fixes in the bpf/bpf.git to work
> properly:
>
> f7f5d1808b1b6 ("bpf: verifier: fix addr_space_cast from as(1) to as(0)")
> 443574b033876 ("riscv, bpf: Fix kfunc parameters incompatibility between =
bpf and riscv abi")
>
> There is a lot of code repetition for LDX, STX, and ST. I will be sending=
 a
> follow-up patch to refactor these.

Thank you, and please address Lehui's remarks as well.

For the series:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

