Return-Path: <linux-kernel+bounces-64118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C733853A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421131C22DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FC60BBE;
	Tue, 13 Feb 2024 18:49:09 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD060BB6;
	Tue, 13 Feb 2024 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850148; cv=none; b=B9bZ9soJYyncy6j1iHs7aSlXofNLjf/ciYBZEdcLsLuGXQ3af5N1SgJilnknw/F6tCoLh56QubV2vho4ctMOnoSs1hKDcvfr7MA4/wUJF+bjuB9GaMMg0EpLSyEsMtBuMAMK1d9Hi0DZgm4WqkH4Uz7PXNtXBe9dLHGV3dH4EO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850148; c=relaxed/simple;
	bh=ePfBqnMY7g041J1LiUVXprEqQZe9Slt4ncaJ/PtpmbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk3cPv7OMImF9yZsdaC8Msfr2r7jiUcV1kcpvWTtkIJxbhzF2m6DjHwjhuA3p2AqE8O66pL5f/SimCNZsM8f+ZY/kTuCu3Ef6NU2RVMsRIr/HRbXuXDJu3so5VmjJGHr303bs9mcbsIpjxtw9tXTXilRdwqbFqyNqdrWLObFQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4c0819c604cso482019e0c.2;
        Tue, 13 Feb 2024 10:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850146; x=1708454946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXLJHoa2vhCu44dDFGcocGPGteAYTMOAGH0dmFHydLs=;
        b=dxonKOFhlTpJtsj3imQC6qNzif3PRdnDEMBJ2yL3esFXVPSvWwhRKBfqJ9hBEnjROF
         0pCkX9gmkAL0jY9x08nce0V0KEl5d9QNzFD1tB91gcPQs4skVqHobqKRvPklvE/NFCgc
         n6N0dqsmNadtv6uBy8jz4cO6x1hkOS41O63XoHBLkXsXUiyXY0f8fPuQtZSF+YcZTD3l
         7qAnKtnQyo+vK+F7Ak8VK4Vgj/PXTeH9qNxk8MGzSGKqCxqXDndidOcs//fuobhYjFaM
         ej1bw/ypA8MwDrpUxR/BUeGRtK+vqbTCPeF4B3cFlM+Ld8lvq5db/UbR1Da2axIViyb6
         qKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrMEf5r3439LNm6XWlVtrKPqgg3EPy5knit15klj/rSOaooJX8dT7T0vCTuKQXIJ9d7Is2rOnrzaF7OvzCMHPJf/d1RZ88eeAmVNvAWwcfBuoKxlNelRsgwTH6wx1TNeSdxM2Di/Z0xWRLdTn4rA==
X-Gm-Message-State: AOJu0YwraVY7vAXqf3YN6zmFRKm1sDkprKIqLe5b/H3s99X5sAye7gho
	YKSGG+mw24rILcOs9vjAd7aGrgiqm9rHcICTl8nuSE056+vPHF08LDnRLs1qRcx+49KNUjq/+i8
	D+q4zC2zZNC1ogNKj8E9a/fdt3pw=
X-Google-Smtp-Source: AGHT+IFpWNGtmgroego7DusKSBmq3elwGvdkc7GAE2O1NgyzHZEdsgj1BXwffYzpzXnm/qhUfIXRfGCALUUmIGbYcJE=
X-Received: by 2002:a1f:c7c5:0:b0:4c0:1918:27de with SMTP id
 x188-20020a1fc7c5000000b004c0191827demr513195vkf.16.1707850145639; Tue, 13
 Feb 2024 10:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212233322.1855161-1-namhyung@kernel.org> <20240213033954.GB81405@debian-dev>
In-Reply-To: <20240213033954.GB81405@debian-dev>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 13 Feb 2024 10:48:53 -0800
Message-ID: <CAM9d7ciTwYAgry-nW9z+_VMj+BJ7ZNZnkKH_t_AHvV5joNuWQQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
To: Leo Yan <leo.yan@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,

Thanks for your review!

On Mon, Feb 12, 2024 at 7:40=E2=80=AFPM Leo Yan <leo.yan@linux.dev> wrote:
>
> On Mon, Feb 12, 2024 at 03:33:22PM -0800, Namhyung Kim wrote:
> > I got a strange error on ARM to fail on processing FINISHED_ROUND
> > record.  It turned out that it was failing in symbol__alloc_hist()
> > because the symbol size is too big.
> >
> > When a sample is captured on a specific BPF program, it failed.  I've
> > added a debug code and found the end address of the symbol is from
> > the next module which is placed far way.
> >
> >   ffff800008795778-ffff80000879d6d8: bpf_prog_1bac53b8aac4bc58_netcg_so=
ck    [bpf]
> >   ffff80000879d6d8-ffff80000ad656b4: bpf_prog_76867454b5944e15_netcg_ge=
tsockopt      [bpf]
> >   ffff80000ad656b4-ffffd69b7af74048: bpf_prog_1d50286d2eb1be85_hn_egres=
s     [bpf]   <---------- here
> >   ffffd69b7af74048-ffffd69b7af74048: $x.5    [sha3_generic]
> >   ffffd69b7af74048-ffffd69b7af740b8: crypto_sha3_init        [sha3_gene=
ric]
> >   ffffd69b7af740b8-ffffd69b7af741e0: crypto_sha3_update      [sha3_gene=
ric]
> >
> > The logic in symbols__fixup_end() just uses curr->start to update the
> > prev->end.  But in this case, it won't work as it's too different.
> >
> > I think ARM has a different kernel memory layout for modules and BPF
> > than on x86.  Actually there's a logic to handle kernel and module
> > boundary.  Let's do the same for symbols between different modules.
>
> Even Arm32 and Arm64 kernel have different memory layout for modules
> and kernel image.
>
> eBPF program (JITed) should be allocated from the vmalloc region, for
> Arm64, see bpf_jit_alloc_exec() in arch/arm64/net/bpf_jit_comp.c.

Ok, so chances are they can fall out far away right?

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/symbol.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index 35975189999b..9ebdb8e13c0b 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -248,14 +248,31 @@ void symbols__fixup_end(struct rb_root_cached *sy=
mbols, bool is_kallsyms)
> >                * segment is very big.  Therefore do not fill this gap a=
nd do
> >                * not assign it to the kernel dso map (kallsyms).
> >                *
> > +              * Also BPF code can be allocated separately from text se=
gments
> > +              * and modules.  So the last entry in a module should not=
 fill
> > +              * the gap too.
> > +              *
> >                * In kallsyms, it determines module symbols using '[' ch=
aracter
> >                * like in:
> >                *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_=
hdmi]
> >                */
> >               if (prev->end =3D=3D prev->start) {
> > +                     const char *prev_mod;
> > +                     const char *curr_mod;
> > +
> > +                     if (!is_kallsyms) {
> > +                             prev->end =3D curr->start;
> > +                             continue;
> > +                     }
> > +
> > +                     prev_mod =3D strchr(prev->name, '[');
> > +                     curr_mod =3D strchr(curr->name, '[');
> > +
> >                       /* Last kernel/module symbol mapped to end of pag=
e */
> > -                     if (is_kallsyms && (!strchr(prev->name, '[') !=3D
> > -                                         !strchr(curr->name, '[')))
> > +                     if (!prev_mod !=3D !curr_mod)
> > +                             prev->end =3D roundup(prev->end + 4096, 4=
096);
> > +                     /* Last symbol in the previous module */
> > +                     else if (prev_mod && strcmp(prev_mod, curr_mod))
>
> Should two consecutive moudles fall into this case? I think we need to as=
sign
> 'prev->end =3D curr->start' for two two consecutive moudles.

Yeah I thought about that case but I believe they would be on
separate pages (hopefully there's a page gap between them).
So I think it should not overlap.  But if you really care we can
check it explicitly like this:

    prev->end =3D min(roundup(...), curr->start);

>
> If so, we should use a specific checking for eBPF program, e.g.:
>
>                         else if (prev_mod && strcmp(prev_mod, curr_mod) &=
&
>                                  (!strcmp(prev->name, "bpf") ||
>                                   !strcmp(curr->name, "bpf")))

I suspect it can happen on any module boundary so better
to handle it in a more general way.

Thanks,
Namhyung

>
> >                               prev->end =3D roundup(prev->end + 4096, 4=
096);
> >                       else
> >                               prev->end =3D curr->start;
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

