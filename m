Return-Path: <linux-kernel+bounces-52821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E5849D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B2C1F28E5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D32D04B;
	Mon,  5 Feb 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="NTBgmdZ/"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B602C87A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143294; cv=none; b=Mq8h6iPoftkeJYGiKcHakSfqu9PCVnKWqIqCtYKzCraxFsi2UVjA4yMsLPqxgc0SCHDhV1sPorjg8EzYn8ehlXBFXMAKAjxditAsKzzxyoRX3KocIKicXag/iiQ4CWGA+LpIyXSAyJC16kVVW1EhbCqp7CTYjve9KrU5eH+j0KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143294; c=relaxed/simple;
	bh=ELP7ZvpL5a3VMuGt7qpmgDMeNX3a7EjNAMEOWZ7a0zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edSR/no5UHdClT0v/a+c41JygytzPKysvILrM8Zoig6HOeUI+VhawomKMPyagkyNJP+I3fT7hysBn5x5t6k6lSvu+zwhM0JKk3WldIB9vp3i1OJskleOYHvbg+1xzAL6P5IjsM5k99gIsvBkmSGl3L5B683eqcbc1Hlrio1/tU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=NTBgmdZ/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-363b5bcec8fso10189605ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1707143290; x=1707748090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrsdpFQjE5KyYZTxQcyIEdvD1aDhzncxsu2p+vqbv2U=;
        b=NTBgmdZ/h8BQai7g0wv5m4E0sp+SZlRGKDVEYkFFtc3Dx2yheNxN2PMqyTPKtdF01q
         ii+fRt7oN/8YAjOlpeIWJoRPqfYYmWy4wY9TZW0IVuowlUkwXzj2YOJfwrti0TFMO8r9
         PIB2vGBd0e/3bAsTnX4A/OmPVkpPr0LUmIW+O50mDOgCKrjU/yDO8+fmjKGC94EXkRZE
         1WsZSRpx0OCi65Kpw2BjQXt8iZ9saX0dyQFh8P/LAefLcsGFIcA+PpIAyDI7hTAzqOKR
         WBhVdy52q1CTmCpXT8imQfXe/ZHicyCxlme4YWrGeAu+KwOrkEcse4oZ4K+2KM5R0P54
         H0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707143290; x=1707748090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrsdpFQjE5KyYZTxQcyIEdvD1aDhzncxsu2p+vqbv2U=;
        b=VVnEyTwU6GoUVcePRMHTPz8yym7dcVsbkFcDX42uCKcH4yjxk/7qC56DIY1tzh8PNW
         CFS869xg6VGz8Ebeyo0NrVuJ8mlIXilSNU8UcFPh7vy0VpvrHFesyOSyIwX2BK8uB4Jv
         XkmqmYkGElL7xOmhQiaG99vMxFF7/OjqVeUbZeIo9tUE6qslXrp2YhS2jWKUpp+K8t4I
         8wEVnbRpGWIdJbEXMXf81rGiHY7qHQhPZ9tSvpNkh2IL5DsIUgqcgGE2xR29p3znhKDY
         iHhjJKFeslHpXNNGEr2DaCH4zVDqlcR84Uhd/VaENyJgsiW66vk5V5/PqUd0IhYhGHK1
         lETg==
X-Gm-Message-State: AOJu0YwiAFIuprZ55AXrsZDRxH+6DWpzLF1OeicWPhWaM2mJA2Ex3Au4
	zFYEO3PVphKW/PQr17lXD2JlkxUbt4VhL/i+Jwellqq+h32vzj1V+7tukGNaR+lALQvx0I0Bbva
	OBYj+fQa8ZtAp/sPef8fuj/5q+c67k/XC/oXDi4k/YE5Vt7Ev
X-Google-Smtp-Source: AGHT+IFL70YI4Hq1H5VcaflfoZ5RmEQmBcVUWxZ9h75tftZAJkN+a6jXzQ22Ia0jXgLISdbfmPNFzwf814cS5UDzQs0=
X-Received: by 2002:a05:6e02:1288:b0:363:9d53:3cc7 with SMTP id
 y8-20020a056e02128800b003639d533cc7mr13655980ilq.30.1707143290288; Mon, 05
 Feb 2024 06:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205042955.833752-1-apatel@ventanamicro.com>
 <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr> <CAK9=C2XEmFBDB6R5f+L9++7ojhWb8rJK-e-vgFrDmsi2=DMOBw@mail.gmail.com>
 <87y1bzch0u.fsf@all.your.base.are.belong.to.us> <a3cb563b-5b41-4189-ac82-091d5cb3223e@ghiti.fr>
In-Reply-To: <a3cb563b-5b41-4189-ac82-091d5cb3223e@ghiti.fr>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 5 Feb 2024 19:57:58 +0530
Message-ID: <CAAhSdy08ocy2Ad96MdHdYN0fk5V0+0Kxc65m+mPQ6UnedFkckQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, linux-riscv@lists.infradead.org, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 7:38=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wrot=
e:
>
>
> On 05/02/2024 12:00, Bj=C3=B6rn T=C3=B6pel wrote:
> > Anup Patel <apatel@ventanamicro.com> writes:
> >
> >> On Mon, Feb 5, 2024 at 11:52=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr=
> wrote:
> >>> Hi Anup,
> >>>
> >>> On 05/02/2024 05:29, Anup Patel wrote:
> >>>> If some of the HARTs are parked by stop machine then IPI-based
> >>>> flushing in flush_icache_all() will hang. This hang is observed
> >>>> when text patching is invoked by various debug and BPF features.
> >>>>
> >>>> To avoid this hang, we force use of SBI-based icache flushing
> >>>> when patching text.
> >>>>
> >>>> Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when =
possible")
> >>>> Reported-by: Bjorn Topel <bjorn@kernel.org>
> >>>> Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d225=
01
> >>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>>> ---
> >>>>    arch/riscv/include/asm/cacheflush.h | 7 ++++---
> >>>>    arch/riscv/kernel/hibernate.c       | 2 +-
> >>>>    arch/riscv/kernel/patch.c           | 4 ++--
> >>>>    arch/riscv/mm/cacheflush.c          | 7 ++++---
> >>>>    4 files changed, 11 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/includ=
e/asm/cacheflush.h
> >>>> index a129dac4521d..561e079f34af 100644
> >>>> --- a/arch/riscv/include/asm/cacheflush.h
> >>>> +++ b/arch/riscv/include/asm/cacheflush.h
> >>>> @@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page *=
page)
> >>>>     * RISC-V doesn't have an instruction to flush parts of the instr=
uction cache,
> >>>>     * so instead we just flush the whole thing.
> >>>>     */
> >>>> -#define flush_icache_range(start, end) flush_icache_all()
> >>>> +#define flush_icache_range(start, end) flush_icache_all(true)
> >>>> +#define flush_icache_patch_range(start, end) flush_icache_all(false=
)
> >>>>    #define flush_icache_user_page(vma, pg, addr, len) \
> >>>>        flush_icache_mm(vma->vm_mm, 0)
> >>>>
> >>>> @@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct page=
 *page)
> >>>>
> >>>>    #ifndef CONFIG_SMP
> >>>>
> >>>> -#define flush_icache_all() local_flush_icache_all()
> >>>> +#define flush_icache_all(want_ipi) local_flush_icache_all()
> >>>>    #define flush_icache_mm(mm, local) flush_icache_all()
> >>>>
> >>>>    #else /* CONFIG_SMP */
> >>>>
> >>>> -void flush_icache_all(void);
> >>>> +void flush_icache_all(bool want_ipi);
> >>>>    void flush_icache_mm(struct mm_struct *mm, bool local);
> >>>>
> >>>>    #endif /* CONFIG_SMP */
> >>>> diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hiber=
nate.c
> >>>> index 671b686c0158..388f10e187ba 100644
> >>>> --- a/arch/riscv/kernel/hibernate.c
> >>>> +++ b/arch/riscv/kernel/hibernate.c
> >>>> @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
> >>>>        } else {
> >>>>                suspend_restore_csrs(hibernate_cpu_context);
> >>>>                flush_tlb_all();
> >>>> -             flush_icache_all();
> >>>> +             flush_icache_all(true);
> >>>>
> >>>>                /*
> >>>>                 * Tell the hibernation core that we've just restored=
 the memory.
> >>>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> >>>> index 37e87fdcf6a0..721e144a7847 100644
> >>>> --- a/arch/riscv/kernel/patch.c
> >>>> +++ b/arch/riscv/kernel/patch.c
> >>>> @@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, size=
_t len)
> >>>>        ret =3D patch_insn_set(tp, c, len);
> >>>>
> >>>>        if (!ret)
> >>>> -             flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len)=
;
> >>>> +             flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp =
+ len);
> >>>>
> >>>>        return ret;
> >>>>    }
> >>>> @@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *in=
sns, size_t len)
> >>>>        ret =3D patch_insn_write(tp, insns, len);
> >>>>
> >>>>        if (!ret)
> >>>> -             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + le=
n);
> >>>> +             flush_icache_patch_range((uintptr_t) tp, (uintptr_t) t=
p + len);
> >>>>
> >>>>        return ret;
> >>>>    }
> >>>> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> >>>> index 55a34f2020a8..03cd3d4831ef 100644
> >>>> --- a/arch/riscv/mm/cacheflush.c
> >>>> +++ b/arch/riscv/mm/cacheflush.c
> >>>> @@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
> >>>>        return local_flush_icache_all();
> >>>>    }
> >>>>
> >>>> -void flush_icache_all(void)
> >>>> +void flush_icache_all(bool want_ipi)
> >>>>    {
> >>>>        local_flush_icache_all();
> >>>>
> >>>> -     if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence(=
))
> >>>> +     if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> >>>> +         (!want_ipi || !riscv_use_ipi_for_rfence()))
> >>>>                sbi_remote_fence_i(NULL);
> >>>>        else
> >>>>                on_each_cpu(ipi_remote_fence_i, NULL, 1);
> >>>> @@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
> >>>>        struct folio *folio =3D page_folio(pte_page(pte));
> >>>>
> >>>>        if (!test_bit(PG_dcache_clean, &folio->flags)) {
> >>>> -             flush_icache_all();
> >>>> +             flush_icache_all(true);
> >>>>                set_bit(PG_dcache_clean, &folio->flags);
> >>>>        }
> >>>>    }
> >>>
> >>> Since patch_text_cb() is run on all cpus, couldn't we completely avoi=
d
> >>> any remote icache flush by slightly changing patch_text_cb() instead =
as
> >>> follows?
> >> Unfortunately patch_text_cb() is not the only user of patch_text_nosyn=
c
> >> since patch_text_nosync() and patch_text_set_nosync() are called direc=
tly
> >> from other places as well.
> > Yeah. There is one more stop_machine() text patching user, and that's
> > ftrace. ftrace is using stop_machine() with the last argument set to
> > NULL, so only patching on *any* hart. Continuing on Alex' idea would be
> > to place an IPI flush in ftrace_arch_code_modify_post_process(),
> > unfortately that's too late since we're already moved on from
> > stop_machine().
>
>
> After discussion with Bjorn, we think the solution would be to
> reimplement arch_ftrace_update_code() with stop_machine(...,
> cpu_online_mask) and use the same barrier as the one in patch_text_cb()
> (csky does just that
> https://elixir.bootlin.com/linux/latest/source/arch/csky/kernel/ftrace.c#=
L224).
> And then we can apply the same solution as I first proposed: no more
> remote icache flushes, only local ones.
>
> What do you think Anup? I can come up with this patch if you want.

Sounds good to me. You will need a special .config from Bjorn to test
your patch.

>
>
> >
> >> We have to update all users of patch_text_nosync() and
> >> patch_text_set_nosync() to move to local icache flushes which
> >> is a much bigger change.
> > Only the ftrace stop_machine() user, right? Alex solution is sufficient
> > for patch_text(). I'm not a super fan of conditionally calling into SBI
> > and passing around boolean context flags as a workaround... :-( Any
> > other alternatives?
> >
> > The obvious fixing text patching not to be completly useless on RISC-V,
> > but that's an even bigger patch...
> >
> >
> > Bj=C3=B6rn
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup

