Return-Path: <linux-kernel+bounces-9436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FCD81C573
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC262828F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11958C15B;
	Fri, 22 Dec 2023 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r41kLtfL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2DC127
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD59BC433C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703229418;
	bh=AmoDXVpNKvbg5N7cc7yKcoH92BR12IIZfapYIlltAxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r41kLtfL2hUb62E5S89CzuSkDgNBkc+vJTswBnfqlC5irF1AGpf+wGsJkxuB6laRj
	 /eTPhOtHY47mL+aHWJ8ro+yzHPUFwsZ/X2ODKYXuERhN9UTig7w/atzKeCI0FZBb11
	 8RMGSUXpzbfvgL0EpmJrwQuBlQ2T4K91711aSsWWD9IWN/CIdfonSL5PEJm8p+Dzfg
	 eAYy15r/a/dyuCYQ4MnmZX+Wwzj845GiJqDCtCfahHx3BsA4VCo4Zac/8ZmrBS5gNT
	 hpcb0UI7iF6gwVab5+6IeiTq8ucnQiGCeHyfkH4zb9dZxUvezOqX6p4eRwRJa0/44H
	 hMu5mRBga9X7A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55436c4a65eso822816a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:16:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yw4RncWBGd1NMJO8z3rh9VFYhrjzhkYg3YVMZGwita1Mwml6Tqs
	cbmYX4HgRIXZErLQRZzbTrtd88QWM4ZqgIWEdn0=
X-Google-Smtp-Source: AGHT+IE3X2hSqss34/czMpkaTKnKCVy0/FHIwAHVJCTsdbIbrat3pjm8jzKzm4gX63iuDvkMwzARuTOeG2GDH67Wt0I=
X-Received: by 2002:a50:934d:0:b0:553:6b21:6c6 with SMTP id
 n13-20020a50934d000000b005536b2106c6mr450284eda.2.1703229417320; Thu, 21 Dec
 2023 23:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221154702.2267684-1-guoren@kernel.org> <20231221154702.2267684-4-guoren@kernel.org>
 <ZYUVTFqvIIqv7D9O@LeoBras>
In-Reply-To: <ZYUVTFqvIIqv7D9O@LeoBras>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 22 Dec 2023 15:16:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQSZSWJ7qZQckuALHkcJb8kEGTnb8wJQ9H2wgODkN56Lw@mail.gmail.com>
Message-ID: <CAJF2gTQSZSWJ7qZQckuALHkcJb8kEGTnb8wJQ9H2wgODkN56Lw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alexghiti@rivosinc.com, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	david@redhat.com, panqinglin2020@iscas.ac.cn, rick.p.edgecombe@intel.com, 
	willy@infradead.org, bjorn@rivosinc.com, conor.dooley@microchip.com, 
	cleger@rivosinc.com, linux-riscv@lists.infradead.org, 
	Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:49=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
>
> On Thu, Dec 21, 2023 at 10:47:00AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Remove TASK_SIZE_MIN because it's not used anymore.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/pgtable.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 74ffb2178f54..e415582276ec 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
> >   */
> >  #ifdef CONFIG_64BIT
> >  #define TASK_SIZE_64 (PGDIR_SIZE * PTRS_PER_PGD / 2)
> > -#define TASK_SIZE_MIN        (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> >
> >  #ifdef CONFIG_COMPAT
> >  #define TASK_SIZE_32 (_AC(0x80000000, UL))
> > @@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t p=
te)
> >
> >  #else
> >  #define TASK_SIZE    FIXADDR_START
> > -#define TASK_SIZE_MIN        TASK_SIZE
> >  #endif
> >
> >  #else /* CONFIG_MMU */
> > --
> > 2.40.1
> >
>
> On torvalds/master:
>
> $git grep TASK_SIZE_MIN
> arch/loongarch/include/asm/processor.h:23:#define TASK_SIZE_MIN TASK_SIZE
> arch/loongarch/include/asm/processor.h:36:#define TASK_SIZE_MIN TASK_SIZE=
32
> arch/riscv/include/asm/pgtable.h:881:#define TASK_SIZE_MIN      (PGDIR_SI=
ZE_L3 * PTRS_PER_PGD / 2)
> arch/riscv/include/asm/pgtable.h:893:#define TASK_SIZE_MIN      TASK_SIZE
>
> I can only see definitions, without any usage, so agreed on removing them=
.
>
> FWIW:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
Thx

>
> I would also send a patch for loongarch, since they are in the same boat =
:)
Eh... I've sent one yesterday together.

https://lore.kernel.org/loongarch/20231221054624.2208019-1-guoren@kernel.or=
g/

>
> Thanks!
> Leo
>


--=20
Best Regards
 Guo Ren

