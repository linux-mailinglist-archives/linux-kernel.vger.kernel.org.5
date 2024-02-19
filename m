Return-Path: <linux-kernel+bounces-71501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDB85A643
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0651D2853E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFD436AF8;
	Mon, 19 Feb 2024 14:43:05 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530541E891
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353785; cv=none; b=NUf6IP2fRiBvvVWS/TUpCpVKo8683UfjKdI9b5K39DSJJbXtmv21zZ0VaCeLwviEoBQI/7riv5xNI7vOoFwxhGY9b64nAHl4gCGsfNxEJlfQVGTJLwB13G2ycvPFNg+wZ7pyfU/QxXbDa2M57KNBendTh8J6bCzD+SLpf0NIg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353785; c=relaxed/simple;
	bh=i7OIpG5Lwqe1/605B4rc6ae/IYBYtY7+WMLTv6YkkX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeZVSbfv00HHHd31Tt8UoANsjosXxaL5beUdS7ncVJQYrpD+sZJCeGNcqt4NP9iyMX4fVA+lpBfTmuJ397XsRTbjhAf62AQWZb2IUlmRufyfBfyRwrRHim4J83WEXUjPeyeIm5xgytKatwDgquzztAAPheXeoOBWP9cBDj2o40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so4604091276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708353781; x=1708958581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiRAs6xXCSmrDwwJyZxglQDdKkrV0mexeOrnsuvFlYU=;
        b=FqETnUUw6CdmvfSP16eAbbuz9r9tNKRJdnAfkZErUMN4EAxpnOrRSUWOi+nWIhzYKz
         Ji1VX5rZkAcM4ugaT2G4VXMoPNsuzGs7N6EOdAJ4NuzV5T3iyUbpFXuHtWZnB5BjnojO
         9xD6k1WBeMuw0NOD/uzXS1gbYm6gpIef1KMHQIzkkMEwxpivPMtC5vSsnu4tn/ws5gSI
         39hX+Lmwa2G6wJFnwDJq3e3N7dvKsFE5E8B8RSYd6p3vrqRpX7t9dDwjiJrLPgVcTICq
         GK3Vf98zHyBmAhHBeXW32R9Qio3FjmJm/w4ZSA31wkoXv1uBAkAq5geGX8TSQg2xZWqZ
         m9oA==
X-Forwarded-Encrypted: i=1; AJvYcCX4E7xZhmZQkxZ2rWNAf+2e/T6772TRGDq9JOny1li8oLTrBGFrmlEyTVoN3lyOZ1rDVX+hAWJx4xCL0R3mrWtxawXFD4fUgYzAn1Qp
X-Gm-Message-State: AOJu0YxkZo42dE2HiH6PdTV8SDLJZdntB9w48ttQzU5uIXvavN/nyHs1
	R91ekkAMFOAitFOj8PlT+8Hytbd2NOMVL/glQ9iQBwnc3T4kqfH49WR+btPzZVE=
X-Google-Smtp-Source: AGHT+IEttYQ6oTZLqNrPLPLjy+ry4ghrSQXE5tzOfQnZQQ5rqL7zOt7ZQT47tBgMaY0Z5xWGIXhXzg==
X-Received: by 2002:a25:838c:0:b0:dcc:fe98:368 with SMTP id t12-20020a25838c000000b00dccfe980368mr6981816ybk.19.1708353781428;
        Mon, 19 Feb 2024 06:43:01 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 8-20020a250f08000000b00dc6d51c8555sm1561687ybp.17.2024.02.19.06.43.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 06:43:01 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-607eefeea90so30074147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:43:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZXB3h1djM+4+8wMSDl4NVHQ95mQYsCoYpfnR4ZyyX0WP6r6oBYD8ueVdRFVMoh49kcj0ibMgrqx1OKVyVft7cVwgO/P/tv1JYisij
X-Received: by 2002:a05:690c:16:b0:608:b86:7c9f with SMTP id
 bc22-20020a05690c001600b006080b867c9fmr4682001ywb.7.1708353780740; Mon, 19
 Feb 2024 06:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206074552.541154-1-maskray@google.com> <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com> <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
In-Reply-To: <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2024 15:42:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
Message-ID: <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Dave Martin <Dave.Martin@arm.com>, 
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ard,

On Mon, Feb 19, 2024 at 11:57=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
> On Mon, 19 Feb 2024 at 11:56, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 19 Feb 2024 at 11:03, Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> > > On Tue, Feb 6, 2024 at 8:46=E2=80=AFAM Fangrui Song <maskray@google.c=
om> wrote:
> > > > The generic constraint "i" seems to be copied from x86 or arm (and =
with
> > > > a redundant generic operand modifier "c"). It works with -fno-PIE b=
ut
> > > > not with -fPIE/-fPIC in GCC's aarch64 port.
> > >
> > > Thanks for your patch, which is now commit f9daab0ad01cf9d1 ("arm64:
> > > jump_label: use constraints "Si" instead of "i"") in v6.8-rc5.
> > >
> > > > The machine constraint "S", which denotes a symbol or label referen=
ce
> > > > with a constant offset, supports PIC and has been available in GCC =
since
> > > > 2012 and in Clang since 7.0. However, Clang before 19 does not supp=
ort
> > > > "S" on a symbol with a constant offset [1] (e.g.
> > > > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > > > include/linux/netfilter.h), so we use "i" as a fallback.
> > >
> > > https://gcc.gnu.org/releases.html says gcc-5 was released in 2015,
> > > i.e. after 2012 ...
> > >
> > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> > > >
> > > > ---
> > > > Changes from
> > > > arm64: jump_label: use constraint "S" instead of "i" (https://lore.=
kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> > > >
> > > > * Use "Si" as Ard suggested to support Clang<19
> > > > * Make branch a separate operand
> > > >
> > > > Changes from v1:
> > > >
> > > > * Use asmSymbolicName for readability
> > >
> > > But it still fails on gcc-5:
> > >
> > >     arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
> > > invalid operand
> > >       asm goto(
> > >       ^
> > >
> > > http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/
> > >
> >
> > How odd. godbolt.org has 5.4 and it seems perfectly happy with it.

> https://godbolt.org/z/GTnf3vPaT

I could reproduce the issue on v6.8-rc5 using arm64 defconfig
and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:

    In file included from ./include/linux/jump_label.h:112:0,
                     from ./include/linux/static_key.h:1,
                     from ./include/linux/kasan-enabled.h:5,
                     from ./arch/arm64/include/asm/cache.h:41,
                     from ./include/linux/cache.h:6,
                     from ./include/linux/slab.h:15,
                     from ./include/linux/resource_ext.h:11,
                     from ./include/linux/acpi.h:13,
                     from arch/arm64/mm/fault.c:10:
    arch/arm64/mm/fault.c: In function 'do_page_fault':
    ./arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
invalid operand
      asm goto(
      ^
    ./arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
invalid operand

There are also a few warnings due to unrecognized options:

    arch/arm64/mm/fault.c: At top level:
    cc1: warning: unrecognized command line option '-Wno-shift-negative-val=
ue'
    cc1: warning: unrecognized command line option '-Wno-stringop-overflow'

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

