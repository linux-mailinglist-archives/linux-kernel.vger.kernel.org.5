Return-Path: <linux-kernel+bounces-38744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17583C523
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825A81C24089
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFD6E2D3;
	Thu, 25 Jan 2024 14:48:30 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5643AB5;
	Thu, 25 Jan 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194109; cv=none; b=Rbqk60+e+jqjdgZR53xYG88+El1Hp8L7x9E7P2AB4qqbpae+407RVoreRnkm+PUZqOKR+8FcvmXN3AhTgh0hCRyN9t/F9tLBMx3yjpBPxh1CRgOkl4d4bEwz6WO+iRqfFZHyThVAC4HAGFNsJAFcZKpQpwPXqAIcCZEMVsVwPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194109; c=relaxed/simple;
	bh=gC8yh7SbqhWBDjSrMZJJDyyUj2pIJgZ3BbEvjuSF48M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LduQOZW8TKRyxba2yBTxS3QzZFrTWAFg2b+Vby2JDQ84BypOc5peSDMLNGPxFTuOvJbNfoqgVZFWqfa0INssFbXz7WmI4ff1DhJyYTUaG75+E1nyMtWbensrtwMLVAR6bs64v+XWs3f4aWJ+sygYRzf4u5dPTDxkaC3+VShnGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff7a098ab8so58593467b3.3;
        Thu, 25 Jan 2024 06:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194102; x=1706798902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iy0vCAdx1ql9Q43DYTTM1zqch4I6/dCcp4gNza1bT10=;
        b=MlUQjOahfHyukU/KiAXNPtwIDA8tdSebmG4fcaLe8Gyhk7AYrS3ELsqD0pv/Wb5IVH
         vUGHKQXGJ3pqlVWNXY4Rg53/yp4d/arTtRklNn99td1D9lDUkbQw4XqvHDSkCxzNNENk
         a43ib70togdc0BUZQfaPpzfSzG/9ydw9hHNzfK9Krg+HkLG96ZlB4eALQZV7bDhZGh+y
         Qw6M/xmIQ8Ug/qmSPjkNvq9Kc8Gdl47W9A2jvKDdYJFfJ/Chc5AWf+gOZWhnmkmEUTWd
         lSyY0E0RPtMzWQAR/WNQK4nmenTX7rqPYo0wQw4afbJSz096xSSQzS3PnN8TyP0GbpLQ
         pTFA==
X-Gm-Message-State: AOJu0YxU760tLSTq5OI23WKtcnUvVNF7zs0OysBDYU+6wzfgh/r7VzLG
	GKhAceYQTL0Q4jicoMryXh2Ajh/kFJy5S+FEhMLh8Qt/q59j3l6hu1CjzUNpEUU=
X-Google-Smtp-Source: AGHT+IH59lQIL3x5MygNDx34sqx+OigzhPI42SunaFRXn7POzP6xhgdrT0HLqfZqbwJbYsAIG47LoA==
X-Received: by 2002:a81:4fc9:0:b0:5f6:d6b9:9ea4 with SMTP id d192-20020a814fc9000000b005f6d6b99ea4mr997793ywb.79.1706194101830;
        Thu, 25 Jan 2024 06:48:21 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id cp25-20020a05690c0e1900b00602ac0e698dsm689253ywb.68.2024.01.25.06.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 06:48:21 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff88cbbcceso59188497b3.2;
        Thu, 25 Jan 2024 06:48:21 -0800 (PST)
X-Received: by 2002:a81:8409:0:b0:5ff:d871:c76 with SMTP id
 u9-20020a818409000000b005ffd8710c76mr1047968ywf.34.1706194100880; Thu, 25 Jan
 2024 06:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr> <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
 <b65a68eb-6b96-41ff-bbb9-38cb2dee940e@smile.fr> <CAK7LNARVbjVkP=v7uQDB=Z+Ntcy9MiFa6WowTX9mA47YjS3zTg@mail.gmail.com>
In-Reply-To: <CAK7LNARVbjVkP=v7uQDB=Z+Ntcy9MiFa6WowTX9mA47YjS3zTg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jan 2024 15:48:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkQb6GSC2XmZHCf5hCmQ9XEW+T2r+jyjy92La4gZvGkg@mail.gmail.com>
Message-ID: <CAMuHMdUkQb6GSC2XmZHCf5hCmQ9XEW+T2r+jyjy92La4gZvGkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yamada-san,

On Wed, Jan 24, 2024 at 9:13=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Wed, Jan 24, 2024 at 5:56=E2=80=AFPM Yoann Congal <yoann.congal@smile.=
fr> wrote:
> > Le 24/01/2024 =C3=A0 09:09, Masahiro Yamada a =C3=A9crit :
> > > On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@s=
mile.fr> wrote:
> > >> Le 23/01/2024 =C3=A0 13:54, Geert Uytterhoeven a =C3=A9crit :
> > >>> On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@=
kernel.org> wrote:
> > >>>> This is used only for initializing other variables.
> > >>>>
> > >>>> Use the empty string "".
> > >>>>
> > >>>> Please note newval.tri is unused for S_INT/HEX/STRING.
> > >>>>
> > >>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >>>
> > >>> Thanks for your patch, which is now commit 4e244c10eab345a7
> > >>> ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> > >>>
> > >>> When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> > >>> defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_=
SHIFT,
> > >>> the aforementioned commit causes a change in the generated .config:
> > >>>
> > >>> -CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > >>> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> > >>>
> > >>> It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead =
of
> > >>> the integer number zero?
> > >>>
> > >>> init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
> > >>> init/Kconfig-   int "CPU kernel log buffer size contribution (13 =
=3D> 8
> > >>> KB, 17 =3D> 128KB)"
> > >>> init/Kconfig-   depends on SMP
> > >>> init/Kconfig-   range 0 21
> > >>> init/Kconfig:   default 12 if !BASE_SMALL
> > >>> init/Kconfig:   default 0 if BASE_SMALL
> > >>>
> > >>> Note that reverting 4e244c10eab345a7 is not sufficient to fix the i=
ssue.
> > >>> Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero i=
f
> > >>> int/hex symbol lacks default property") does fix it.
> > >>
> > >> (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero i=
f int/hex symbol lacks default property") to stay, allow me to try to help)
> > >>
> > >> The problem is quite easy to reproduce:
> > >>   $ make x86_64_defconfig
> > >>   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> > >>   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> > >>   CONFIG_BASE_FULL=3Dy
> > >>   CONFIG_BASE_SMALL=3D0
> > >> Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.

> > >> For what it is worth, CONFIG_BASE_SMALL is defined as an int but is =
only used as a bool :
> > >>    $ git grep BASE_SMALL
> > >>   arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL =3D=3D 0
> > >>   drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL=
 ? 256 : PAGE_SIZE)
> > >>   include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL=
 ? 0x1000 : 0x8000)
> > >>   include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ?=
 PAGE_SIZE * 8 : \
> > >>   include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BA=
SE_SMALL ? 128 : 256)
> > >>   include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BA=
SE_SMALL ? 4 : 6)
> > >>   init/Kconfig:   default 12 if !BASE_SMALL
> > >>   init/Kconfig:   default 0 if BASE_SMALL
> > >>   init/Kconfig:config BASE_SMALL
> > >>   kernel/futex/core.c:#if CONFIG_BASE_SMALL
> > >>   kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7=
)
> > >>
> > >> Maybe we should change CONFIG_BASE_SMALL to the bool type?
> >
> > My first test shows that switching CONFIG_BASE_SMALL to bool type does =
fix the LOG_CPU_MAX_BUF_SHIFT default value.
> >
> > >> I'll poke around to see if I can understand why a int=3D"0" is true =
for kconfig.
> >
> > Here's what I understood:
> > To get the default value of LOG_CPU_MAX_BUF_SHIFT, kconfig calls sym_ge=
t_default_prop(LOG_CPU_MAX_BUF_SHIFT)
> > -> expr_calc_value("BASE_SMALL" as an expr)
> > -> sym_calc_value(BASE_SMALL as a symbol) and returns sym->curr.tri
> >
> > But, if I understood correctly, sym_calc_value() does not set sym->curr=
tri in case of a int type config.
>
> Right.
>
> The following will restore the original behavior.
>
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -349,12 +349,15 @@ void sym_calc_value(struct symbol *sym)
>         switch (sym->type) {
>         case S_INT:
>                 newval.val =3D "0";
> +               newval.tri =3D no;
>                 break;
>         case S_HEX:
>                 newval.val =3D "0x0";
> +               newval.tri =3D no;
>                 break;
>         case S_STRING:
>                 newval.val =3D "";
> +               newval.tri =3D no;
>                 break;
>         case S_BOOLEAN:
>         case S_TRISTATE:

Thank you, that works for me.
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

