Return-Path: <linux-kernel+bounces-77756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E528C8609D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B271F261A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607A010A13;
	Fri, 23 Feb 2024 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJw5m5Aj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035F2CA5;
	Fri, 23 Feb 2024 04:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662426; cv=none; b=RM4VT+ZnCuwec2KBbnWr2iHa2ct4QJf0V6L4NpNiQUhfo7GgdIFu2KZesj+9WqK36bu8JZhbX9Avf3lOaut0bCMzZijM2jx7qWWZHWXTgGdJ58RSGARox1lrB2H534od2Hf6QW9nczX3FUGiphKeWiyrq11x1QJGiq5MlkHmmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662426; c=relaxed/simple;
	bh=DaYOsizSC6q2DFwRiqDzd0sgVjrRcguu4TDpthJnDLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gj6E/GoOymx+CYtk5T/6a9bSq7uzwcksgyQ/J7k8lvVt83ALHsRfHHK5D36JmlSsgsB6Bf49FvmrdJ6ZWyCKr4ov3NplXq5QAsDC6XurwEcSCbdr6FWYl3s7w8gT13xcPO4t7j9isNIGlIH0XtUtFFXtVOB98JNCxoPUsn/GyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJw5m5Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E4C433F1;
	Fri, 23 Feb 2024 04:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662426;
	bh=DaYOsizSC6q2DFwRiqDzd0sgVjrRcguu4TDpthJnDLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nJw5m5Ajhd5AFgFLc7Sxg9PPom3cl9EmlrqHHP9DT5G5jQZWOAldcRvpsehZrnUNJ
	 hSXU4rB+lXrZ1h+svoi6cVtlhEhL9KWFurfAYQlt7LaA5/OJPdmszQhakfduTLJ/yL
	 TuWHy3w9RgD8rvEFEf2zxsISZKB4M0bIxSGAryLPRrcNhZuNdNwuW/atbJWeD6zcee
	 Y+4jUIhX5DlythiXIUy4XKj7AqOxcvuK6kq29Q9hW6pec66vqDzVbcj+/0hTvFgpmL
	 0xXMRzp1ITAYC4jNFpV/Pqaj6eZ46XvKX6Nmlut2R+C3UUgH2x1fwleHjOTFccBRRe
	 e7P928V24r5Wg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512d8fe4fceso513689e87.3;
        Thu, 22 Feb 2024 20:27:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5sXj0G2y7wO99xgXip9X9grrsuLfMcggZSIh7T+llNO6rX0Xke7ZTumzSmCnyfUN6Bqva20obSXat03Mw2NNs5gAag647q5M705wSv5b64lnz+wNDEnIJ+Q89NWyCOlO/8VSnHBHUlZqR
X-Gm-Message-State: AOJu0YwWo/LUni6Hb6SSwrSZwyCHYQYo5Tq+kfMlCwlHmCNIfurUiBOz
	s/vWtcsQgT/TvEnxnLuO4xtYY1/2hWfX24urybV0RhPBQfbciRV7GiAY01INE8fYVAfHAbI/jAx
	/6DMLqbSLsppO0fGB7nawA+3ohzU=
X-Google-Smtp-Source: AGHT+IEoJ2f3nq0jZkNP9bJ1ogMeoFXnGKxgLpXxMJyl3oxvW/aw2HmGVrBDdoPIrQfG5Rauvz7gc/GWwtokbfcZgPc=
X-Received: by 2002:a19:f718:0:b0:512:dc21:d89c with SMTP id
 z24-20020a19f718000000b00512dc21d89cmr544054lfe.38.1708662424615; Thu, 22 Feb
 2024 20:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221202655.2423854-1-jannh@google.com> <20240221202655.2423854-2-jannh@google.com>
 <CAK7LNAQG_dX8p0Lch-wg8cOVRQzaJUh2zFJL+3tgpcT8_iSTow@mail.gmail.com>
 <CAG48ez3Kg+BPsf_gWhm9E3QwOOw_CbTnHJ828Df41i1_EYrxnw@mail.gmail.com> <CAG48ez39zR+Um-9HMX2GgbOZrvQFjA=bN_dsZBJPvmnqtyg+VA@mail.gmail.com>
In-Reply-To: <CAG48ez39zR+Um-9HMX2GgbOZrvQFjA=bN_dsZBJPvmnqtyg+VA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 23 Feb 2024 13:26:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR059LrBgvZVfapTGtU_VrHhHdrk1XfCbACPe-7109UiQ@mail.gmail.com>
Message-ID: <CAK7LNAR059LrBgvZVfapTGtU_VrHhHdrk1XfCbACPe-7109UiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: build faster by using .incbin
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 11:21=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Thu, Feb 22, 2024 at 12:20=E2=80=AFPM Jann Horn <jannh@google.com> wro=
te:
> > On Thu, Feb 22, 2024 at 5:07=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > > On Thu, Feb 22, 2024 at 5:27=E2=80=AFAM Jann Horn <jannh@google.com> =
wrote:
> > > >
> > > > Currently, kallsyms builds a big assembly file (~19M with a normal
> > > > kernel config), and then the assembler has to turn that big assembl=
y
> > > > file back into binary data, which takes around a second per kallsym=
s
> > > > invocation. (Normally there are two kallsyms invocations per build.=
)
> > > >
> > > > It is much faster to instead directly output binary data, which can
> > > > be imported in an assembly file using ".incbin". This is also the
> > > > approach taken by arch/x86/boot/compressed/mkpiggy.c.
> > >
> > >
> > > Yes, that is a sensible case because it just wraps the binary
> > > without any modification.
> > >
> > >
> > >
> > >
> > > > So this patch switches kallsyms to that approach.
> > > >
> > > > A complication with this is that the endianness of numbers between
> > > > host and target might not match (for example, when cross-compiling)=
;
> > > > and there seems to be no kconfig symbol that tells us what endianne=
ss
> > > > the target has.
> > >
> > >
> > >
> > > CONFIG_CPU_BIG_ENDIAN is it.
> > >
> > >
> > >
> > > You could do this:
> > >
> > > if is_enabled CONFIG_CPU_BIG_ENDIAN; then
> > >         kallsymopt=3D"${kallsymopt} --big-endian"
> > > fi
> > >
> > > if is_enabled CONFIG_64BIT; then
> > >         kallsymopt=3D"${kallsymopt} --64bit"
> > > fi
> >
> > Aah, nice, thanks, I searched for endianness kconfig flags but somehow
> > missed that one.
> >
> > Though actually, I think further optimizations might make it necessary
> > to directly operate on ELF files anyway, in which case it would
> > probably be easier to keep using the ELF header...
> >
> > > > So pass the path to the intermediate vmlinux ELF file to the kallsy=
ms
> > > > tool, and let it parse the ELF header to figure out the target's
> > > > endianness.
> > > >
> > > > I have verified that running kallsyms without these changes and
> > > > kallsyms with these changes on the same input System.map results
> > > > in identical object files.
> > > >
> > > > This change reduces the time for an incremental kernel rebuild
> > > > (touch fs/ioctl.c, then re-run make) from 27.7s to 24.1s (medians
> > > > over 16 runs each) on my machine - saving around 3.6 seconds.
> > >
> > >
> > >
> > >
> > > This reverts bea5b74504742f1b51b815bcaf9a70bddbc49ce3
> > >
> > > Somebody might struggle with debugging again, but I am not sure.
> > >
> > > Arnd?
> > >
> > >
> > >
> > > If the effort were "I invented a way to do kallsyms in
> > > one pass instead of three", it would be so much more attractive.
> >
> > Actually, I was chatting with someone about this yesterday, and I
> > think I have an idea on how to get rid of two link steps... I might
> > try out some stuff and then come back with another version of this
> > series afterwards.
>
> I think basically we could change kallsyms so that on the second run,
> it checks if the kallsyms layout is the same as on the first run, and
> if yes, directly overwrite the relevant part of vmlinux. (And adjust
> the relative_base.) That would save us the final link... does that
> sound like a reasonable idea?


I do not know how we can save the final link.

Inserting the kallsyms data into the .rodata section
would change the address of all symbols that come after.
Only the linker can sort out the address change.


>
> I don't really have any good ideas for saving more than that, given
> that we want to squeeze the kallsyms in between the data and bss
> sections, so we can't just append it at the end of vmlinux... we could
> get the symbol list from vmlinux.o instead of linking
> ".tmp_vmlinux.kallsyms1", but the comments in link-vmlinux.sh say that
> extra linker-generated symbols might appear, and I guess we probably
> don't want to miss those...


I knew it was not trivial.
If you do not have an idea, you do not need to change it.




--=20
Best Regards
Masahiro Yamada

