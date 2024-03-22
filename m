Return-Path: <linux-kernel+bounces-111728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B34F88700C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7DA1C22952
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88354FB0;
	Fri, 22 Mar 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KTdt25yJ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1C353E2E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122659; cv=none; b=WVBOUrgGzh+Rzg4HOAGJj1EK3A/kTYBgQFpu/fdjMfAEsU6xHaI85c256d/Mu5KYwpjAdI4uE3jso9oMgQz5UCeRydRnLvzXkyIcz4vRRMiC/o/MYBLkmW3Xhg8+lqLcx0psKRHCOPsdhm/t6GYVw7cZAdB0DelYRy9Oyg0+KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122659; c=relaxed/simple;
	bh=atngU9HDK4iRm17Wd+Olqq7llfAiBnT5riZoMD/tHvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US3YUW8rEhkrhHDYDLGfAyKIR6t3UMcfUIt3K7gQ1AWQ4r/1xRZihexqgDzHnieGEIz+DzoQJdfbq0wqaZNdVPcOJJCZF2zFWmNWHkEOoa2H+Ny6F0AFxnTjX62xUzVjFlHIQ0zQzPFE8iOo5vNxKFS8BcV/FxHSRhZ4M1EuZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KTdt25yJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3222600a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711122656; x=1711727456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymH0isND2p2l6PY2xAiE9bsR6I1sbj8UtQEUd2/RRag=;
        b=KTdt25yJMdwfaERQgyEW33SB4G/YP02X7tp8D5kVA3PvqeM5PuJK+WucjXUZsNhsaa
         NA8reHtrrF77YEv4ML5ahuhb+M6HSznL6TvxkEIxjC0nNyrWuMkG+pvmax8wN8A5B+x9
         Uk31bpm8lu2w/xjyHuY2zSZJ3XZZKTdD+ZTEWQGIoktlHwGAYtwGmklBkzoKZSeiukUB
         v3VdIVJJ8FGLFi3LJq+P6oLTqKk+Zl5WUCz4jKO8FR1Anrwt8XZXmPpcOuK+Ax+9ujWB
         fepV614nieW/GDs0+MK67C6zR1Yivx6oYGuqYAku7NbET/tL6Wnll2ul3+gMwcGciH0N
         Z8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122656; x=1711727456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymH0isND2p2l6PY2xAiE9bsR6I1sbj8UtQEUd2/RRag=;
        b=n3sD5dvMo+zoXacdGfhKSAnHUV1AHOlTD9yISuCGtrDEpqZm7zu5Kwh8JVv6l9aXmx
         APQQtGGjLUJA9KNb5PGi8ICjnAVWmbC1aGH24aXOsFxzM7DjkLm9uqyjih2KdrHgpXES
         AYbwZ95sXWB1us0yDbybH9W8kTltDVAm7PfaRrS99tLEgiYB1NVvLYyWNqOdY8sR1L2g
         1xK/2VReve9cLM2lnndbe7urceC3pj4yPWeo/MulJp5Wdxpt9di875J1ETcJqVyUcRO0
         sUxzPGB1vQxubx8JuxmjnGF1pXNAGDRnoFRkfbv/L7SHxWnPr2QF+0G8TglKc3IQf/tG
         Jhug==
X-Forwarded-Encrypted: i=1; AJvYcCXJGtF1EMFVeJwdDYL2AtOS0oHjvGDO1e3PRwEAcDfsFiiZTwCgkfWkTeUUkiRVOAYJb2RyhMao+GsP4AJE3dzLcr9FaxIVWWYf1YrN
X-Gm-Message-State: AOJu0Yzb7VHh25M29Vrph8yJd+a67LHJ45mcmK88cRLz68bgD2YGKzxp
	135Iu5i+mB+1xcBEhXveVPZknbzBuvVUgDdtjxLa7vbenO36zzGl1CTc/JKoXhXOe7J5aIBJub6
	+tdTw0mAwTO2ci59gxvkNSyg49LEwFOCv0a2Rg+XPRIKoby8AiNU=
X-Google-Smtp-Source: AGHT+IGoGdY72aObM/cAbKff/8OaaVeRHOEWoCy27OSLuSued6Nc21UBKLW6w2cjyaK3f6fVjFszEGmEJ44oYiAqXj8=
X-Received: by 2002:a17:906:817:b0:a47:2ec5:57dd with SMTP id
 e23-20020a170906081700b00a472ec557ddmr101474ejd.72.1711122655848; Fri, 22 Mar
 2024 08:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_6D851035F6F2FD0B5A69FB391AE39AC6300A@qq.com> <mhng-3e79924e-d965-4156-836d-19cc8fb8cafe@palmer-ri-x1c9a>
In-Reply-To: <mhng-3e79924e-d965-4156-836d-19cc8fb8cafe@palmer-ri-x1c9a>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 22 Mar 2024 16:50:44 +0100
Message-ID: <CAHVXubiosOMnUghsaG_zDyX4wPQ3QGY_UhsUO+PGWQ8v2tDbFw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: only flush icache when it has VM_EXEC set
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: cyy@cyyself.name, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>, jszhang@kernel.org, 
	Andrew Waterman <andrew@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:48=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Tue, 09 Jan 2024 10:48:59 PST (-0800), cyy@cyyself.name wrote:
> > As I-Cache flush on current RISC-V needs to send IPIs to every CPU core=
s
> > in the system is very costly, limiting flush_icache_mm to be called onl=
y
> > when vma->vm_flags has VM_EXEC can help minimize the frequency of these
> > operations. It improves performance and reduces disturbances when
> > copy_from_user_page is needed such as profiling with perf.
> >
> > For I-D coherence concerns, it will not fail if such a page adds VM_EXE=
C
> > flags in the future since we have checked it in the __set_pte_at functi=
on.
> >
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> > ---
> >  arch/riscv/include/asm/cacheflush.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/a=
sm/cacheflush.h
> > index 3cb53c4df27c..915f532dc336 100644
> > --- a/arch/riscv/include/asm/cacheflush.h
> > +++ b/arch/riscv/include/asm/cacheflush.h
> > @@ -33,8 +33,11 @@ static inline void flush_dcache_page(struct page *pa=
ge)
> >   * so instead we just flush the whole thing.
> >   */
> >  #define flush_icache_range(start, end) flush_icache_all()
> > -#define flush_icache_user_page(vma, pg, addr, len) \
> > -     flush_icache_mm(vma->vm_mm, 0)
> > +#define flush_icache_user_page(vma, pg, addr, len)   \
> > +do {                                                 \
> > +     if (vma->vm_flags & VM_EXEC)                    \
> > +             flush_icache_mm(vma->vm_mm, 0);         \
> > +} while (0)
> >
> >  #ifdef CONFIG_64BIT
> >  #define flush_cache_vmap(start, end) flush_tlb_kernel_range(start, end=
)
>
> I'm not super worried about the benchmarks, I think we can just
> open-loop assume this is faster by avoiding the flushes.  I do think we
> need a hook into at least tlb_update_vma_flags(), though, to insert the
> fence.i when upgrading a mapping to include VM_EXEC.

I'd say Yangyu is right when he mentions in the commit log: "For I-D
coherence concerns, it will not fail if such a page adds VM_EXEC flags
in the future since we have checked it in the __set_pte_at function.".
If a region indeed becomes executable, the page table will be modified
to reflect that and then will pass in __set_pte_at() which, as Yangyu
mentions, does the right thing. Or am I missing something?

Thanks,

Alex

