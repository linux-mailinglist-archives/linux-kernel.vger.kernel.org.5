Return-Path: <linux-kernel+bounces-52478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67628498B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D83F283061
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5318E1A;
	Mon,  5 Feb 2024 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="O7mYyMTj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296218E06
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132155; cv=none; b=mpy74ml64YFZcJOHyWeR2PFpF9iGpYdLgLnZ56NimYxmJF04D4mAVXGx0Z9OlQnHIIyvOGssa3NpQrkv4arjw1fXDIijpQbMcyqy/VcUyAdNV0m8Lt3dBTxAuOed7OQ+trrL1vyzmizJC6acEJsNkLs3jcfePrWElQ11TIbHqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132155; c=relaxed/simple;
	bh=efHLLQ4wLSdn/bsJSgY6fzeQm0FPQgih4sngH+cC5b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM42xlA9rZuVZfjaKVx53swKUcQ69uQ62e6xLHtSBETn2E9ivrB1xBAYktjmY30DaRoJpOviHSTviuDi00gkyZEU5y32KPMPAg6Mvzmm0SPB741w1ZCDN/NmjrLxaq+NDD9btk89eEgWUID78+pCMhe1KbFXCEDRa4+DkunLsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=O7mYyMTj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51142b5b76dso2816707e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1707132151; x=1707736951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7imZCnAB2BRzpFq0lQpC3tiKdvRf86B/0eG5F0Tr2c=;
        b=O7mYyMTjMEek3YHYVEpbKZpSmvertfF417wwJAQHQQBHOap9xjL5Lzuc+sySCt5nSR
         RPh/JDZxW1tydDD8HTwP9i1AJGru3YQHF4tg3WgkiSc6abZUpXXExXxTHW30sxPinJZ5
         OJ/nwOF3wlsvfSM2Lp2rYW5NHM1chZbSTZCwaQ0MPOA70Gz2pH9wx/5OU7Lx6gxsKrEd
         EJ/ZW37kjuSEjHpnm8a0biQ7e0+ZxX87bDeVqnCF9xO/JGjAismnH9L2p5GIXSthMaKa
         6CpqGYTmbbJ+AYy0A+5B7bxctXIpprtN2ATtfbe/bPvuv4eZzUWsg1mO4ZO9f9x9FHKp
         LYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707132151; x=1707736951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7imZCnAB2BRzpFq0lQpC3tiKdvRf86B/0eG5F0Tr2c=;
        b=AhkLotNglasFLTIEu7sfxFui1D6VqFUkak56yNKAyfILXflNMA0kvKRzGiyhgh/tEZ
         oqWp68WKUKloiJNbRCTAv8GVRTeq9TjbIbbQDfv45HRws8eK03DbbEFaxBhxgxltgATU
         4Plp/81KdIvvq9Ab/wPIt4jWpzWJgzmvUvgqedMWq+bHvC2pIwI2uSgVfzB31gsAQCro
         T3SpqufFEKdMd1dU+in7u+Ay38+yhAneMpUjPXcXi7Icv7S2dvF8oHt7wG4SXbV25R9t
         3sN7tvjdKJdR+5m/bqX5n8VZ30lB/7cJwKoUgfuLcXCHJbX9rENdI+ENCkE6OA6XFZER
         KHTg==
X-Gm-Message-State: AOJu0YwQ6W1bQ+7syM2/XAIxFL02HT1lMB3fVBTg/l2fRG4hdeWykysI
	bAZCJxte/txyqxPnvwA0p7TogIBk10TAQaN4Q2+/NqzuPY4KAkRW0fEV7o6FGBXCFUQv3djWeEE
	6imZhY3uFM5HvfXIiFCIbUh477ft1Fz+LBQZrUg==
X-Google-Smtp-Source: AGHT+IFoGGjXGqAu16JDDCqGU3bjaj/m5eJUYjXRJM01WedE3gsJ3YD96S1TQxXofJKgEMZ7A5dhrTAmreEdlMB5YrE=
X-Received: by 2002:a05:6512:3d0a:b0:511:548f:8eef with SMTP id
 d10-20020a0565123d0a00b00511548f8eefmr968517lfv.49.1707132150834; Mon, 05 Feb
 2024 03:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205042955.833752-1-apatel@ventanamicro.com>
 <d5e21238-89f4-444e-9c35-f4a28e01052e@ghiti.fr> <CAK9=C2XEmFBDB6R5f+L9++7ojhWb8rJK-e-vgFrDmsi2=DMOBw@mail.gmail.com>
 <87y1bzch0u.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87y1bzch0u.fsf@all.your.base.are.belong.to.us>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 5 Feb 2024 16:52:18 +0530
Message-ID: <CAK9=C2U9K+u2r8xNcguqpROKeDhKSBoQCrDW1Y_Qa_MU-SBqnw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Don't use IPIs in flush_icache_all() when
 patching text
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:30=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > On Mon, Feb 5, 2024 at 11:52=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >>
> >> Hi Anup,
> >>
> >> On 05/02/2024 05:29, Anup Patel wrote:
> >> > If some of the HARTs are parked by stop machine then IPI-based
> >> > flushing in flush_icache_all() will hang. This hang is observed
> >> > when text patching is invoked by various debug and BPF features.
> >> >
> >> > To avoid this hang, we force use of SBI-based icache flushing
> >> > when patching text.
> >> >
> >> > Fixes: 627922843235 ("RISC-V: Use IPIs for remote icache flush when =
possible")
> >> > Reported-by: Bjorn Topel <bjorn@kernel.org>
> >> > Closes: https://gist.github.com/bjoto/04a580568378f3b5483af07cd9d225=
01
> >> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >> > ---
> >> >   arch/riscv/include/asm/cacheflush.h | 7 ++++---
> >> >   arch/riscv/kernel/hibernate.c       | 2 +-
> >> >   arch/riscv/kernel/patch.c           | 4 ++--
> >> >   arch/riscv/mm/cacheflush.c          | 7 ++++---
> >> >   4 files changed, 11 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/includ=
e/asm/cacheflush.h
> >> > index a129dac4521d..561e079f34af 100644
> >> > --- a/arch/riscv/include/asm/cacheflush.h
> >> > +++ b/arch/riscv/include/asm/cacheflush.h
> >> > @@ -32,7 +32,8 @@ static inline void flush_dcache_page(struct page *=
page)
> >> >    * RISC-V doesn't have an instruction to flush parts of the instru=
ction cache,
> >> >    * so instead we just flush the whole thing.
> >> >    */
> >> > -#define flush_icache_range(start, end) flush_icache_all()
> >> > +#define flush_icache_range(start, end) flush_icache_all(true)
> >> > +#define flush_icache_patch_range(start, end) flush_icache_all(false=
)
> >> >   #define flush_icache_user_page(vma, pg, addr, len) \
> >> >       flush_icache_mm(vma->vm_mm, 0)
> >> >
> >> > @@ -43,12 +44,12 @@ static inline void flush_dcache_page(struct page=
 *page)
> >> >
> >> >   #ifndef CONFIG_SMP
> >> >
> >> > -#define flush_icache_all() local_flush_icache_all()
> >> > +#define flush_icache_all(want_ipi) local_flush_icache_all()
> >> >   #define flush_icache_mm(mm, local) flush_icache_all()
> >> >
> >> >   #else /* CONFIG_SMP */
> >> >
> >> > -void flush_icache_all(void);
> >> > +void flush_icache_all(bool want_ipi);
> >> >   void flush_icache_mm(struct mm_struct *mm, bool local);
> >> >
> >> >   #endif /* CONFIG_SMP */
> >> > diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hiber=
nate.c
> >> > index 671b686c0158..388f10e187ba 100644
> >> > --- a/arch/riscv/kernel/hibernate.c
> >> > +++ b/arch/riscv/kernel/hibernate.c
> >> > @@ -153,7 +153,7 @@ int swsusp_arch_suspend(void)
> >> >       } else {
> >> >               suspend_restore_csrs(hibernate_cpu_context);
> >> >               flush_tlb_all();
> >> > -             flush_icache_all();
> >> > +             flush_icache_all(true);
> >> >
> >> >               /*
> >> >                * Tell the hibernation core that we've just restored =
the memory.
> >> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> >> > index 37e87fdcf6a0..721e144a7847 100644
> >> > --- a/arch/riscv/kernel/patch.c
> >> > +++ b/arch/riscv/kernel/patch.c
> >> > @@ -182,7 +182,7 @@ int patch_text_set_nosync(void *addr, u8 c, size=
_t len)
> >> >       ret =3D patch_insn_set(tp, c, len);
> >> >
> >> >       if (!ret)
> >> > -             flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len)=
;
> >> > +             flush_icache_patch_range((uintptr_t)tp, (uintptr_t)tp =
+ len);
> >> >
> >> >       return ret;
> >> >   }
> >> > @@ -217,7 +217,7 @@ int patch_text_nosync(void *addr, const void *in=
sns, size_t len)
> >> >       ret =3D patch_insn_write(tp, insns, len);
> >> >
> >> >       if (!ret)
> >> > -             flush_icache_range((uintptr_t) tp, (uintptr_t) tp + le=
n);
> >> > +             flush_icache_patch_range((uintptr_t) tp, (uintptr_t) t=
p + len);
> >> >
> >> >       return ret;
> >> >   }
> >> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> >> > index 55a34f2020a8..03cd3d4831ef 100644
> >> > --- a/arch/riscv/mm/cacheflush.c
> >> > +++ b/arch/riscv/mm/cacheflush.c
> >> > @@ -17,11 +17,12 @@ static void ipi_remote_fence_i(void *info)
> >> >       return local_flush_icache_all();
> >> >   }
> >> >
> >> > -void flush_icache_all(void)
> >> > +void flush_icache_all(bool want_ipi)
> >> >   {
> >> >       local_flush_icache_all();
> >> >
> >> > -     if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence(=
))
> >> > +     if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> >> > +         (!want_ipi || !riscv_use_ipi_for_rfence()))
> >> >               sbi_remote_fence_i(NULL);
> >> >       else
> >> >               on_each_cpu(ipi_remote_fence_i, NULL, 1);
> >> > @@ -87,7 +88,7 @@ void flush_icache_pte(pte_t pte)
> >> >       struct folio *folio =3D page_folio(pte_page(pte));
> >> >
> >> >       if (!test_bit(PG_dcache_clean, &folio->flags)) {
> >> > -             flush_icache_all();
> >> > +             flush_icache_all(true);
> >> >               set_bit(PG_dcache_clean, &folio->flags);
> >> >       }
> >> >   }
> >>
> >>
> >> Since patch_text_cb() is run on all cpus, couldn't we completely avoid
> >> any remote icache flush by slightly changing patch_text_cb() instead a=
s
> >> follows?
> >
> > Unfortunately patch_text_cb() is not the only user of patch_text_nosync
> > since patch_text_nosync() and patch_text_set_nosync() are called direct=
ly
> > from other places as well.
>
> Yeah. There is one more stop_machine() text patching user, and that's
> ftrace. ftrace is using stop_machine() with the last argument set to
> NULL, so only patching on *any* hart. Continuing on Alex' idea would be
> to place an IPI flush in ftrace_arch_code_modify_post_process(),
> unfortately that's too late since we're already moved on from
> stop_machine().
>
> > We have to update all users of patch_text_nosync() and
> > patch_text_set_nosync() to move to local icache flushes which
> > is a much bigger change.
>
> Only the ftrace stop_machine() user, right? Alex solution is sufficient
> for patch_text(). I'm not a super fan of conditionally calling into SBI
> and passing around boolean context flags as a workaround... :-( Any
> other alternatives?

I was seeing hang because of patch_text_nosync() getting called from
the BPF path in my debug sessions.

I am certainly not a fan of the approach taken by this patch but this is
the smallest amount of change I could come-up as FIXUP. We should
certainly have a separate patch to do this in a proper way.

>
> The obvious fixing text patching not to be completly useless on RISC-V,
> but that's an even bigger patch...
>

I agree.

Regards,
Anup

