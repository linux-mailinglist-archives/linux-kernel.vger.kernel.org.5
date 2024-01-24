Return-Path: <linux-kernel+bounces-36747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9630383A5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F99128725D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80927D521;
	Wed, 24 Jan 2024 09:52:45 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7918625;
	Wed, 24 Jan 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089962; cv=none; b=m0+1IqX7e2b/X+c5mSNgolynGota0l1mwII4YtBn2DEXPFWfe9apu9Av7lsIwZSVI+L0KuEahOP+GlRzlQaAz2ArovD73l0SwOFnyZFtTOVbir39q6mcKrauek4VFLFtlhWgYk9S7AiteWd8Em0FMnIiM+XHdPj8Z9NRPjoTeyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089962; c=relaxed/simple;
	bh=x1fsVDdsOFD6tbu+vLQ3FdacZX1F0b/QkoHTJwiwpSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npPifhcr46u1iuxqtjbd9Pt64dZV3jREYuYalLBNnqrk7nrCJB/3S4KY25O3p7TwJTA0b86lA++njSoCLMxW029JPqUa7hEdj71adC66rgGMlpaNpbfEev8HtmOm5oG3w8XruoklEPR+ud4NsXzs+SqsUfRbWmC3rjzBDwIvSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5ffb07bed9bso29900077b3.0;
        Wed, 24 Jan 2024 01:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706089958; x=1706694758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb9WF/ExCOiStM1ck1NToosyRyKsQZOXa+C3tVqzcsc=;
        b=fFlGpVlzdZV89ZaTo7voBO7EWe1M0M8l4O78QQOzAuKuou5F0jqsZT1uuYUSV3lX7M
         5oppDdJ728LArM+diyiNbH/ZiJZbOvhIpdCCmZCNHVL/QDDi66K6otR/GCEZFRQ68qkU
         jWilULytMulFTQjV9c+sd0Y8faCAuK16ieqFnvlbd3vJno254ihjcfZH4MutjNym40kS
         cN26WVuJtDMMh82JdzWjelCMUT7AYCOZYrftI1fJkblvIT/ifTZYV/iLJnURlZFOnNz1
         9XDri4POJiFXlewCe3tjvQcRJX+kPUo+bVl4eZLg64y67Zh735J8+iAkWnd83l40j2Cs
         dxUg==
X-Gm-Message-State: AOJu0YzhtKy6RkQax8r/GQ5eF5qepsP14pk2EbE5f02crRCoa357eqhV
	9e/JVVBqTSHXkrnVUaBV+xtUIBwRA2JEyUVgzcYywH3z2tZJtew8rfAHQXVB11o=
X-Google-Smtp-Source: AGHT+IEOQC01b0M5bEfgaa2k8oik+PCvmRiuqQqMnZIjR3CfDSsWTus6Ql/mWEkIEurxeX6BGER6jg==
X-Received: by 2002:a0d:d94c:0:b0:5d7:1940:8dfe with SMTP id b73-20020a0dd94c000000b005d719408dfemr329592ywe.101.1706089957751;
        Wed, 24 Jan 2024 01:52:37 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id a126-20020a0dd884000000b005ffa3fa57f9sm3548291ywe.51.2024.01.24.01.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 01:52:37 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3263909276.2;
        Wed, 24 Jan 2024 01:52:37 -0800 (PST)
X-Received: by 2002:a25:7801:0:b0:dc2:1dd0:1d1b with SMTP id
 t1-20020a257801000000b00dc21dd01d1bmr315581ybc.19.1706089957157; Wed, 24 Jan
 2024 01:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr> <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
In-Reply-To: <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jan 2024 10:52:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLMNj=Yvf4QxxrCxf-UBr-VXUxfJei+V2bNd0M7D1OhQ@mail.gmail.com>
Message-ID: <CAMuHMdWLMNj=Yvf4QxxrCxf-UBr-VXUxfJei+V2bNd0M7D1OhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yamada-san,

On Wed, Jan 24, 2024 at 9:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@smile=
fr> wrote:
> > Le 23/01/2024 =C3=A0 13:54, Geert Uytterhoeven a =C3=A9crit :
> > > On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > >> This is used only for initializing other variables.
> > >>
> > >> Use the empty string "".
> > >>
> > >> Please note newval.tri is unused for S_INT/HEX/STRING.
> > >>
> > >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >
> > > Thanks for your patch, which is now commit 4e244c10eab345a7
> > > ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> > >
> > > When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> > > defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SH=
IFT,
> > > the aforementioned commit causes a change in the generated .config:
> > >
> > > -CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > > +CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> > >
> > > It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead of
> > > the integer number zero?
> > >
> > > init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
> > > init/Kconfig-   int "CPU kernel log buffer size contribution (13 =3D>=
 8
> > > KB, 17 =3D> 128KB)"
> > > init/Kconfig-   depends on SMP
> > > init/Kconfig-   range 0 21
> > > init/Kconfig:   default 12 if !BASE_SMALL
> > > init/Kconfig:   default 0 if BASE_SMALL
> > >
> > > Note that reverting 4e244c10eab345a7 is not sufficient to fix the iss=
ue.
> > > Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
> > > int/hex symbol lacks default property") does fix it.
> >
> > (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if i=
nt/hex symbol lacks default property") to stay, allow me to try to help)
> >
> > The problem is quite easy to reproduce:
> >   $ make x86_64_defconfig
> >   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> >   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> >   CONFIG_BASE_FULL=3Dy
> >   CONFIG_BASE_SMALL=3D0
> > Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.
>
>
>
> I could not produce it in this way.
> I ran the same commands as yours.
>
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 for me.
>
>
>
> masahiro@zoe:~/ref/linux(master)$ git describe
> v6.8-rc1-29-g615d30064886
> masahiro@zoe:~/ref/linux(master)$ git diff
> masahiro@zoe:~/ref/linux(master)$ make  x86_64_defconfig
> #
> # No change to .config
> #
> masahiro@zoe:~/ref/linux(master)$ grep
> 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> CONFIG_BASE_FULL=3Dy
> CONFIG_BASE_SMALL=3D0

Interesting...

$ git describe
v6.8-rc1-29-g615d300648869c77
$ make  x86_64_defconfig
[...]
$ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
CONFIG_BASE_FULL=3Dy
CONFIG_BASE_SMALL=3D0

Does it depend on the flex/bison version?
I have Ubuntu LTS flex 2.6.4-8build2 and bison 2:3.8.2+dfsg-1build1.

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

