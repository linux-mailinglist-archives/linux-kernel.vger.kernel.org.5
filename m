Return-Path: <linux-kernel+bounces-40126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37C83DAA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E677B23A2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522F91B968;
	Fri, 26 Jan 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2T8g4kt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFC1B962;
	Fri, 26 Jan 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706275276; cv=none; b=e+JFGfWKpyBWoGLDEYplaXWa5HEigI4ivUBAPTOJiE1MOab3M9R53XxE9y5Oq7t67jrZhhVcuYWmSnpIQozdcIxSgWNW+baex7EkG20umGnqaRhslCg7DLFt+z48m0yhMZYtMBVp3W6xk0UDbCBldyMOgk1HETCw8Vd/lCr1O/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706275276; c=relaxed/simple;
	bh=zig9FnhaB0fy17ptQdqIUVr01bCMI+0JGDexlot/JbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Onlh3vEI3MGx5+2zTKS43RQ3GofWyIVPwnl/od2YozSie4xymnRO6dRXnEEfUKoVQBMV9Sw1b6rDhKjDt0oyJtDvsS8qR08ajooaADKmlBqcXpCMhZSMiLD0gtUqXgbVocRBoycJ/SLoHKOhlgoELL3o+tEDBAyb7y/8L30R8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2T8g4kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130E0C433C7;
	Fri, 26 Jan 2024 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706275276;
	bh=zig9FnhaB0fy17ptQdqIUVr01bCMI+0JGDexlot/JbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G2T8g4ktEINqIAiz4fbyX/BQWh8N25GYjfRe/hW7kFZYU8OadZChHfy47+WAE7JZs
	 TC0FEAJ9Q2Ei65ZvW63ee2o54M4e/qwuzES1l+fz/op+DchY5v37SsNJeFlDoXU5dC
	 1yjksuUoMNhObTpSy+slipa0zRVPTSV+nNApfUAyok2C9IAALwDPovMplXg0Uh98Zo
	 BlNlOD2zY+95PRLUobU+0L8s4k/qzUUP3zcn1bR+Chc0GVLOXSct1GIhjakTsSJ5kV
	 iOrTUOLcS5T9SoveZ7d2WxWnpGoperwf6/I1l6uKfMkCugMdzvVPCUpuJMFK2RgR8d
	 9Pdw2a4VLMhRw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-210dec2442eso224089fac.2;
        Fri, 26 Jan 2024 05:21:16 -0800 (PST)
X-Gm-Message-State: AOJu0Ywd3N3PgErnH9F5tHR0VYYrscQDEJUVYp3uJFwnje8tPUAMmT6E
	kOutdzUhWtF50iI3h5VwIO2eqvfG3zUTRknd+nuLZSy1ZeeQ1mcYnKSavOOlhgqdkZxeobuU+J0
	rhsrCFicE98UzOVvm/F+3Xyivs1Q=
X-Google-Smtp-Source: AGHT+IEJd47lxiZwmE+QaHi/uLBkM404G/xDpEPICAPhEsCH6h16DarYJulKuG2k6HB+nRTYeeqSQEEfZE6SYFmonYI=
X-Received: by 2002:a05:6870:9a87:b0:214:dee7:7d43 with SMTP id
 hp7-20020a0568709a8700b00214dee77d43mr1407763oab.7.1706275275378; Fri, 26 Jan
 2024 05:21:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr> <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
 <b65a68eb-6b96-41ff-bbb9-38cb2dee940e@smile.fr> <CAK7LNARVbjVkP=v7uQDB=Z+Ntcy9MiFa6WowTX9mA47YjS3zTg@mail.gmail.com>
 <928267c8-2c79-4f76-aa6e-26dc63c77e43@smile.fr>
In-Reply-To: <928267c8-2c79-4f76-aa6e-26dc63c77e43@smile.fr>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 26 Jan 2024 22:20:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQu7WmgbGkMv7WUAv0WGW+6DTPAtcW+TA5XAF9cq0hYOg@mail.gmail.com>
Message-ID: <CAK7LNAQu7WmgbGkMv7WUAv0WGW+6DTPAtcW+TA5XAF9cq0hYOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Yoann Congal <yoann.congal@smile.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:42=E2=80=AFPM Yoann Congal <yoann.congal@smile.f=
r> wrote:
>
> Hi,
>
> Le 24/01/2024 =C3=A0 21:12, Masahiro Yamada a =C3=A9crit :
> > On Wed, Jan 24, 2024 at 5:56=E2=80=AFPM Yoann Congal <yoann.congal@smil=
e.fr> wrote:
> >> Le 24/01/2024 =C3=A0 09:09, Masahiro Yamada a =C3=A9crit :
> >>> On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@s=
mile.fr> wrote:
> >>>> For what it is worth, CONFIG_BASE_SMALL is defined as an int but is =
only used as a bool :
> >>>>    $ git grep BASE_SMALL
> >>>>   arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL =3D=3D 0
> >>>>   drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL=
 ? 256 : PAGE_SIZE)
> >>>>   include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL=
 ? 0x1000 : 0x8000)
> >>>>   include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ?=
 PAGE_SIZE * 8 : \
> >>>>   include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BA=
SE_SMALL ? 128 : 256)
> >>>>   include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BA=
SE_SMALL ? 4 : 6)
> >>>>   init/Kconfig:   default 12 if !BASE_SMALL
> >>>>   init/Kconfig:   default 0 if BASE_SMALL
> >>>>   init/Kconfig:config BASE_SMALL
> >>>>   kernel/futex/core.c:#if CONFIG_BASE_SMALL
> >>>>   kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7=
)
> >>>>
> >>>> Maybe we should change CONFIG_BASE_SMALL to the bool type?
> >>
> >> My first test shows that switching CONFIG_BASE_SMALL to bool type does=
 fix the LOG_CPU_MAX_BUF_SHIFT default value.
> >>
> >>>> I'll poke around to see if I can understand why a int=3D"0" is true =
for kconfig.
> >>
> >> Here's what I understood:
> >> To get the default value of LOG_CPU_MAX_BUF_SHIFT, kconfig calls sym_g=
et_default_prop(LOG_CPU_MAX_BUF_SHIFT)
> >> -> expr_calc_value("BASE_SMALL" as an expr)
> >> -> sym_calc_value(BASE_SMALL as a symbol) and returns sym->curr.tri
> >>
> >> But, if I understood correctly, sym_calc_value() does not set sym->cur=
r.tri in case of a int type config.
> >
> > Right.
>
> Thanks :)
>
> > The following will restore the original behavior.
> >
> >
> > --- a/scripts/kconfig/symbol.c
> > +++ b/scripts/kconfig/symbol.c
> > @@ -349,12 +349,15 @@ void sym_calc_value(struct symbol *sym)
> >         switch (sym->type) {
> >         case S_INT:
> >                 newval.val =3D "0";
> > +               newval.tri =3D no;
> >                 break;
> >         case S_HEX:
> >                 newval.val =3D "0x0";
> > +               newval.tri =3D no;
> >                 break;
> >         case S_STRING:
> >                 newval.val =3D "";
> > +               newval.tri =3D no;
> >                 break;
> >         case S_BOOLEAN:
> >         case S_TRISTATE:
> > >
> > But, I do not think that is the right thing to do.
> >
> > Presumably, turning CONFIG_BASE_SMALL is correct.
>
> I'm working on a patch to do that.
>

OK, please go ahead.


I will restore the Kconfig original behavior for now
and send a pull-req.




--=20
Best Regards
Masahiro Yamada

