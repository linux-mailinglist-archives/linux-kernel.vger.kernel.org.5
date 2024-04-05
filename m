Return-Path: <linux-kernel+bounces-133453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66089A3E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133E92898CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6CB171E73;
	Fri,  5 Apr 2024 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewAbd5Fm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CB171E40;
	Fri,  5 Apr 2024 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340655; cv=none; b=QT744Eufi7YTYB90l4IT1/qpJrZBYN6Za4JozEyMignVOSraNHahqX5BBQsrTKAWqLKnbX9KeAoJGrJ2nzFT/vT6zHSVkGbUobtZuMsZ3eoJHAr9KY0gKLIv6zhd4nbZ0+Et4NhdXXMuLVO5wmPTQxH3p06jJUmXtVmZguLeL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340655; c=relaxed/simple;
	bh=fWSrOr8f8fr5/BXZ8KkPYzpWRfdNWjXg2YH35wIn7nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq1KbRm6Tx/Poy2sMiZrJzhTvhVd1ITBAxEFUUhxck+qVh5FoF1CjNjPxX9376IyzJNRVJljMBku/w+wWcUkj5jQuGFnxhlPsuN2/ifOEjByyFCzt1/Hm8mjHdzpzSCB1FVIXwz7m6lAetSyMAt7PRYuOf4W5Lvm72fCIV5KhXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewAbd5Fm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2232e30f4so22475555ad.2;
        Fri, 05 Apr 2024 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712340653; x=1712945453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH6LfvKVj4QuobKK/trwqUlflVnFHEvHshhJj8bw+OQ=;
        b=ewAbd5FmGLP2by/UqDCtSwbwNwkc7RzC7dab7b9ktvZkIhFaSvRrmAGI+ooSiqOnTw
         Bf6EcSiqhBYK5qcoxvocLEAzQ2mFxqhAAwMu3lhENsiHwDP0cPAmmYv8vFVJN4w+fO9i
         eKLowYMV4v6JIN9H/RP+ho3HKRmhznWHnuvtE9Lp2IUI0l3ygkQq9pndWEhgkCV8mWau
         +TIbWij8fCLvUdpaMCxIBbARK8ajHk7cOxEpxxo/MNiCd3uCnU6LTg/JyG2jTpFO4unM
         nCtQUUdvGxnwpdOfaImdW0lqK2eHd7qPwaFH9vW6+wVT3/bu9Gmya20beVDfunJ6XWpE
         Eskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712340653; x=1712945453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH6LfvKVj4QuobKK/trwqUlflVnFHEvHshhJj8bw+OQ=;
        b=KKIBCM5uBDyJesI8iJ/SX+hcmFdgHDWeLnsKngbyO6/IjM3Hmtwks8cPis8f+yGxA5
         sSbbNvJCIhKCFo4uBquIZwVMr3mPUmR4bRbvjqUW95+GGUzcaZjTc3CWhrYi+LqfNAxg
         QYgydftgK3U7dqQSCV7pYC6RG/To1qor0Bz5xFfxU6daqv+lYcZCDHOn2WTPxrODx5es
         34C2lUB9h7g+lL0eV6MHNz28fwZxDayq+PVa94RpQAnXzFiirWvq6IoVACM+DB2BiIQI
         eyxSzIjBSDpbZqKaoOL56XaiSNY62OT/rpoykadnOs18eVvMKDNfzDJSRleAOmyq15LH
         6eyw==
X-Forwarded-Encrypted: i=1; AJvYcCUq/ujsScBqPrEzCmv/CTOOU6KJT7bopMpJjgwPpvbTfgMx4hdK/1cOG2O42trxA6zOtXpNuumQfY8QeCAllymXWwYrHBx0Xts3R2i3PG11X3VEsj9EtxioTBytFFjgfM8f
X-Gm-Message-State: AOJu0YwlOGm1Qcmk3ulanTeCSk5+aTdmHo3TAMq1yKMGo56QRC7CRMAs
	8MLnTreb8+J/ECzAuuafss64tw0m/D+uTH+Tz0/7V+rtJUJh5KhiiSg23kxuQWZ+bo5UV90T+9d
	jDrcCP6YF75r24HTByUuPcAvalQk=
X-Google-Smtp-Source: AGHT+IHSU/vlOnPJQfb+UGw+U4srnMxgFmGtFDHvbDJ9ofXUq0UTFVaUk/a03n129QN+iSWQwGqVUjSGWMF1OWGjPJ8=
X-Received: by 2002:a17:902:e751:b0:1de:ffbc:8d95 with SMTP id
 p17-20020a170902e75100b001deffbc8d95mr2548204plf.67.1712340652945; Fri, 05
 Apr 2024 11:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405091707.66675-1-puranjay12@gmail.com> <CAADnVQ+MRAg2hKJfG_QUjXu8WHLb+7tpPgMOQv8rfCSmKU2w5Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+MRAg2hKJfG_QUjXu8WHLb+7tpPgMOQv8rfCSmKU2w5Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Apr 2024 11:10:41 -0700
Message-ID: <CAEf4Bza3s4u5kX3AFDWd6-JGjfkhwfakc8_AKH52L7517Q8QGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] arm64, bpf: add internal-only MOV instruction to
 resolve per-CPU addrs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Florent Revest <revest@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 5, 2024 at 2:17=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.c=
om> wrote:
> >
> > Support an instruction for resolving absolute addresses of per-CPU
> > data from their per-CPU offsets. This instruction is internal-only and
> > users are not allowed to use them directly. They will only be used for
> > internal inlining optimizations for now between BPF verifier and BPF
> > JITs.
> >
> > Since commit 7158627686f0 ("arm64: percpu: implement optimised pcpu
> > access using tpidr_el1"), the per-cpu offset for the CPU is stored in
> > the tpidr_el1/2 register of that CPU.
> >
> > To support this BPF instruction in the ARM64 JIT, the following ARM64
> > instructions are emitted:
> >
> > mov dst, src            // Move src to dst, if src !=3D dst
> > mrs tmp, tpidr_el1/2    // Move per-cpu offset of the current cpu in tm=
p.
> > add dst, dst, tmp       // Add the per cpu offset to the dst.
> >
> > If CONFIG_SMP is not defined, then nothing is emitted if src =3D=3D dst=
, and
> > mov dst, src is emitted if dst !=3D src.
> >
> > To measure the performance improvement provided by this change, the
> > benchmark in [1] was used:
> >
> > Before:
> > glob-arr-inc   :   23.597 =C2=B1 0.012M/s
> > arr-inc        :   23.173 =C2=B1 0.019M/s
> > hash-inc       :   12.186 =C2=B1 0.028M/s
> >
> > After:
> > glob-arr-inc   :   23.819 =C2=B1 0.034M/s
> > arr-inc        :   23.285 =C2=B1 0.017M/s
> > hash-inc       :   12.419 =C2=B1 0.011M/s
> >
> > [1] https://github.com/anakryiko/linux/commit/8dec900975ef
>
> You don't see as big of a gain, because bpf_get_smp_processor_id()
> is not inlined yet on arm64.
>

yep, would be nice to add ARM64 and RISC-V support there as well.
Though it feels that supporting this in BPF JIT directly might be
actually easier for RISC-V/ARM64, not sure?

> But even without it I expected bigger gains.
> Could you do 'perf report' before/after ?
> Just want to see what's on top.

I also did `bpftool p d x id <progid>` and `bpftool p d j id <progid>`
to validate expected inlined BPF instructions and jitted code. So it
might be a good idea to do that as well.

Either way, thanks for working on this!

>
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > ---
> >  arch/arm64/include/asm/insn.h |  7 +++++++
> >  arch/arm64/lib/insn.c         | 11 +++++++++++
> >  arch/arm64/net/bpf_jit.h      |  6 ++++++
> >  arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
> >  4 files changed, 40 insertions(+)
> >

[...]

