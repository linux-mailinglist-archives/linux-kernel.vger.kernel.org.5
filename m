Return-Path: <linux-kernel+bounces-24619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D1B82BF42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FE6286A56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F58B67E93;
	Fri, 12 Jan 2024 11:33:49 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E667E83;
	Fri, 12 Jan 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f07f9d57b9so62996337b3.1;
        Fri, 12 Jan 2024 03:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705059225; x=1705664025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJjVyh+7oYXym23boo4u//OtALG0QudsORSegf3gMfU=;
        b=ik20vNzQ2gO6ND4LchWuysAUC9bQvo+Ks29nGwXp3kIIVcirRDJvJ7+voI4NVix6r1
         SVIZW7ZbyoFW2yuR6JN+RUHpi/re7nbgwkvRdn27Bpl1vYgzDfzEdO2LOITDfXr5bS1h
         J602ayASd+27dCLAOIzKh3IJerEUMLIqw8hCVD4J8B9gMg8Q75eubpNGdWOCOxYH+AKq
         Jhb8spdPh2y3C749in3Tbht1PQGiI+Umj9aKGiZwB9TDE6EkB9Wx/fHjgsSyVBBxvQxt
         Q9F9tA0lxCqLqN609qYH7YUpTOeta9O0X61AfToa5KtA0hEPS/KOeQlOwBFA0QPYnGi+
         Sgjg==
X-Gm-Message-State: AOJu0YyUjTIniEaCkLwQU00Tnw7g9H8/gLywB4oBrcVquaifoKAdvpp5
	fjr/nIcpBJV+igqRIqeCzifHgPzR8IQKeA==
X-Google-Smtp-Source: AGHT+IEiJOfRxtKJH7BEiPKzT7rZmAL3A78HPD9ldDc6m+i5McVCXufe2sL9UH8lKGwdBnPCOSGRQA==
X-Received: by 2002:a05:690c:7:b0:5fb:86a1:3e57 with SMTP id bc7-20020a05690c000700b005fb86a13e57mr1277241ywb.39.1705059224939;
        Fri, 12 Jan 2024 03:33:44 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d20-20020a81ab54000000b005e1a5593c0csm1222838ywk.60.2024.01.12.03.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 03:33:44 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5fa52e173f7so31599737b3.3;
        Fri, 12 Jan 2024 03:33:44 -0800 (PST)
X-Received: by 2002:a81:b650:0:b0:5ea:5340:fb1d with SMTP id
 h16-20020a81b650000000b005ea5340fb1dmr1186575ywk.53.1705059224288; Fri, 12
 Jan 2024 03:33:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111162419.12406-1-pmladek@suse.com> <CAMuHMdW1XyimybybSwAfwgzeUyFj6riRZZZzQK7zjTVUJziX-Q@mail.gmail.com>
 <ZaEiFXscVBdOJEeI@alley>
In-Reply-To: <ZaEiFXscVBdOJEeI@alley>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jan 2024 12:33:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW5V9wQzTzYt+iGBtYEDrcL-g4nzswAB6ME1At1W42qRw@mail.gmail.com>
Message-ID: <CAMuHMdW5V9wQzTzYt+iGBtYEDrcL-g4nzswAB6ME1At1W42qRw@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: Safe warning about bad dev info string
To: Petr Mladek <pmladek@suse.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Down <chris@chrisdown.name>, oe-kbuild-all@lists.linux.dev, 
	kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Fri, Jan 12, 2024 at 12:27=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
> On Fri 2024-01-12 10:22:44, Geert Uytterhoeven wrote:
> > On Thu, Jan 11, 2024 at 5:26=E2=80=AFPM Petr Mladek <pmladek@suse.com> =
wrote:
> > > Both "model" and "strflags" are passed to "%s" even when one or both
> > > are NULL.
> > >
> > > It is safe because vsprintf() would detect the NULL pointer and print
> > > "(null)". But it is a kernel-specific feature and compiler warns
> > > about it:
> > >
> > > <warning>
> > >    In file included from include/linux/kernel.h:19,
> > >                     from arch/x86/include/asm/percpu.h:27,
> > >                     from arch/x86/include/asm/current.h:6,
> > >                     from include/linux/sched.h:12,
> > >                     from include/linux/blkdev.h:5,
> > >                     from drivers/scsi/scsi_devinfo.c:3:
> > >    drivers/scsi/scsi_devinfo.c: In function 'scsi_dev_info_list_add_s=
tr':
> > > >> include/linux/printk.h:434:44: warning: '%s' directive argument is=
 null [-Wformat-overflow=3D]
> > >      434 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, #=
#__VA_ARGS__)
> > >          |                                            ^
> > >    include/linux/printk.h:430:3: note: in definition of macro 'printk=
_index_wrap'
> > >      430 |   _p_func(_fmt, ##__VA_ARGS__);    \
> > >          |   ^~~~~~~
> > >    drivers/scsi/scsi_devinfo.c:551:4: note: in expansion of macro 'pr=
intk'
> > >      551 |    printk(KERN_ERR "%s: bad dev info string '%s' '%s'"
> > >          |    ^~~~~~
> > >    drivers/scsi/scsi_devinfo.c:552:14: note: format string is defined=
 here
> > >      552 |           " '%s'\n", __func__, vendor, model,
> > >          |              ^~
> > > </warning>
> > >
> > > Do not rely on the kernel specific behavior and print the message
> > > a safe way.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202401112002.AOjwMNM0-l=
kp@intel.com/
> > > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > > ---
> > > Note: The patch is only compile tested.
> > >
> > >  drivers/scsi/scsi_devinfo.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.=
c
> > > index 3fcaf10a9dfe..ba7237e83863 100644
> > > --- a/drivers/scsi/scsi_devinfo.c
> > > +++ b/drivers/scsi/scsi_devinfo.c
> > > @@ -551,9 +551,9 @@ static int scsi_dev_info_list_add_str(char *dev_l=
ist)
> > >                 if (model)
> > >                         strflags =3D strsep(&next, next_check);
> > >                 if (!model || !strflags) {
> > > -                       printk(KERN_ERR "%s: bad dev info string '%s'=
 '%s'"
> > > -                              " '%s'\n", __func__, vendor, model,
> > > -                              strflags);
> > > +                       pr_err("%s: bad dev info string '%s' '%s' '%s=
'\n",
> > > +                              __func__, vendor, model ? model : "",
> > > +                              strflags ? strflags : "");
> >
> > Do we really want to make this change?
> > The kernel's vsprintf() implementation has supported NULL pointers
> > since forever, and lots of code relies on that behavior.
>
> Yeah, it was safe even in the first git commit. And it was probably
> safe long before.
>
> Well, I can't find easily how much code relies on this. I would
> personally do not rely on it when writing new code.

Lots of debug code relies on this when printing string pointers.
It doesn't warn because the compiler cannot prove (yet) that such a
pointer can be NULL...

> > Perhaps this warning can be disabled instead?
>
> IMHO, it is not a good idea to disable the warning. I believe that it
> checks also other scenarios and can find real problems.

True.

> Also I think that compilers are getting more and more "clever".
> So keeping the "suspicious" code might be fighting with windmills.

Also true, unfortunately.

So one day the whole "if (!model || !strflags) { ... }" block might
be optimized away, when the compiler decides that NULL pointers are
Undefined Behavior, and thus this cannot happen.

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

