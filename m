Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F3767410
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjG1R5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjG1R5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:57:22 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA66612C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:57:20 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-794cddcab71so996644241.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690567040; x=1691171840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjwyxWFDME+rX0obgtV5/nSSXhzmrLOPNjo6saBh8f4=;
        b=MdUOTvvhZcMf/WUYAwh4fLVzEuZjbL5JH4ZipqIptm8/3uPce7lXR7sBJRJbArgjG+
         nWKeWA+OYAJPtp0D/0g5PZgzWh2MDj+2SR6X5UUSY5Q3x2ZtFvMAGRVAL7G7S6/ADSGR
         QKFStz2IEYhLe9ZXNVN7rmmXSmU8MHGBJH1nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567040; x=1691171840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjwyxWFDME+rX0obgtV5/nSSXhzmrLOPNjo6saBh8f4=;
        b=IpSyIs4yOHVXHOlC7SjBzMvxguIOQLkPmhRy50ZixW88aXWQGsK6FfG9CaJPAl41yO
         xf+k4WwdcnhT0S8n4kpd48BLFIHTPBJQU9xoXFM4sMOW2+sEoTm+/023LY92dmv517U2
         LX7I0v2vDrqeZaYbYx4d5KMN/VPR9Fdio1YZF9POQf0su5lMA3HD25gxmRvD/+YlDgCe
         V1J/GfR2JXCgpI4j/JJZyeeu7DAXQtzX95pamjTi3v9Z+oNJFmiD1YLEyWF8TY3UjAIJ
         q+XdzAc+/AUoH0UNXAuk2uGuAdpV36pMTuCF6+89ZGvVCSruhcRgMg1hJL3ucPnonUWw
         fBkg==
X-Gm-Message-State: ABy/qLakfGyDX8gQau6A/Rb+afCPK2h8QzHZeEFxuB84IOJXqCenPki8
        LOKse0oOt2D8r1x14+y4aQYyEkpb0+WQZXU7XHY=
X-Google-Smtp-Source: APBJJlG7JhmxFPbv0DNBolcMgyY7ieJ4wDD+3Gw6SwQK1+p3/4EtEpAn8Xeqnj1VJ+3l9p+K7mEOKw==
X-Received: by 2002:a05:6102:2f5:b0:443:7787:8333 with SMTP id j21-20020a05610202f500b0044377878333mr2583611vsj.8.1690567039833;
        Fri, 28 Jul 2023 10:57:19 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id s4-20020a67c384000000b00447765805a5sm129596vsj.29.2023.07.28.10.57.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:57:19 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-794cddcab71so996634241.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:57:19 -0700 (PDT)
X-Received: by 2002:a05:6102:44b:b0:445:23e7:767f with SMTP id
 e11-20020a056102044b00b0044523e7767fmr2175806vsq.28.1690567038783; Fri, 28
 Jul 2023 10:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org> <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley> <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley> <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
 <ZLZgZvE35fYCkgOq@alley>
In-Reply-To: <ZLZgZvE35fYCkgOq@alley>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 28 Jul 2023 11:57:07 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
Message-ID: <CAHQZ30DQw9n=uiuz3-nqnOKVbZdp-=DfeSn2feoPL08RjYzT=A@mail.gmail.com>
Subject: Re: [PATCH] init: Don't proxy console= to earlycon
To:     Petr Mladek <pmladek@suse.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kramasub@chromium.org, Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Li Zhe <lizhe.67@bytedance.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhou jie <zhoujie@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, sending again since my original reply wasn't in plain text mode
and got bounced from the mailing list.

On Tue, Jul 18, 2023 at 3:50=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-07-14 15:42:36, Raul Rangel wrote:
> > On Fri, Jul 14, 2023 at 12:35=E2=80=AFPM Petr Mladek <pmladek@suse.com>=
 wrote:
> > > On Fri 2023-07-14 11:21:09, Raul Rangel wrote:
> > > > On Fri, Jul 14, 2023 at 10:38=E2=80=AFAM Petr Mladek <pmladek@suse.=
com> wrote:
> > > > > On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > > > > > On Sun, Jul 9, 2023 at 8:43=E2=80=AFPM Randy Dunlap <rdunlap@in=
fradead.org> wrote:
> > > > > > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > > > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > > > > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > > > > > >>> Right now we are proxying the `console=3DXXX` command lin=
e args to the
> > > > > > > >>> param_setup_earlycon. This is done because the following =
are
> > > > > > > >>> equivalent:
> > > > > > > >>>
> > > > > > > >>>      console=3Duart[8250],mmio,<addr>[,options]
> > > > > > > >>>      earlycon=3Duart[8250],mmio,<addr>[,options]
>
> I have finally got the meaning of the above paragraph. I thought that
> it was talking about that the format was equivalent. But it was about
> that also the effect was equivalent.
>
> > > > > > > >>> In addition, when `earlycon=3D` or just `earlycon` is spe=
cified on the
> > > > > > > >>> command line, we look at the SPCR table or the DT to extr=
act the device
> > > > > > > >>> options.
> > > > > > > >>>
> > > > > > > >>> When `console=3D` is specified on the command line, it's =
intention is to
> > > > > > > >>> disable the console. Right now since we are proxying the =
`console=3D`
> > > > > > > >>
> > > > > > > >> How do you figure this (its intention is to disable the co=
nsole)?
> > > > > > > >
> > > > > >
> > > > > > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-paramet=
ers.html
> > > > > > says the following:
> > > > > > console=3D
> > > > > >     { null | "" }
> > > > > >             Use to disable console output, i.e., to have kernel
> > > > > >             console messages discarded.
> > > > > >             This must be the only console=3D parameter used on =
the
> > > > > >             kernel command line.
> > > > > >
> > > > > >         earlycon=3D       [KNL] Output early console device and=
 options.
> > > > > >
> > > > > >             When used with no options, the early console is
> > > > > >             determined by stdout-path property in device tree's
> > > > > >             chosen node or the ACPI SPCR table if supported by
> > > > > >             the platform.
> > > > >
> > > > > Sigh, I wasn't aware of this when we discussed the console=3D han=
dling.
> > > >
> > > > It took a bit of digging to figure out what the actual intention wa=
s :)
> > > >
> > > > >
> > > > > > The reason this bug showed up is that ChromeOS has set `console=
=3D` for a
> > > > > > very long time:
> > > > > > https://chromium.googlesource.com/chromiumos/platform/crosutils=
/+/main/build_kernel_image.sh#282
> > > > > > I'm not sure on the exact history, but AFAIK, we don't have the=
 ttyX devices.
> > > > > >
> > > > > > Coreboot recently added support for the ACPI SPCR table which i=
n
> > > > > > combination with the
> > > > > > `console=3D` arg, we are now seeing earlycon enabled when it sh=
ouldn't be.
> > > > >
> > > > > But this happens only when both "earlycon" and "console=3D" param=
eters
> > > > > are used together. Do I get it correctly?
> > > >
> > > > The bug shows up when an SPCR table is present and the `console=3D`
> > > > parameter is set. No need to specify `earlycon` on the command line=
.
> > >
> > > Strange, see below.
> > >
> > > > > This combination is ambiguous on its own. Why would anyone add
> > > > > "earlycon" parameter and wanted to keep it disabled?
> > > >
> > > > This is not the case I'm hitting. I'm honestly not sure what the
> > > > behavior should be in the `earlycon console=3D` case?
> > > >
> > > > >
> > > > > > > >>> diff --git a/init/main.c b/init/main.c
> > > > > > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > > > > > >>> --- a/init/main.c
> > > > > > > >>> +++ b/init/main.c
> > > > > > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char=
 *param, char *val,
> > > > > > > >>>       for (p =3D __setup_start; p < __setup_end; p++) {
> > > > > > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > > > > > >>>               (strcmp(param, "console") =3D=3D 0 &&
> > > > > > > >>> -             strcmp(p->str, "earlycon") =3D=3D 0)
> > > > > > > >>> -        ) {
> > > > > > > >>> +             strcmp(p->str, "earlycon") =3D=3D 0 && val =
&& val[0])) {
> > > > > > > >>>               if (p->setup_func(val) !=3D 0)
> > > > > > > >>>                   pr_warn("Malformed early option '%s'\n"=
, param);
> > > > > > > >>>           }
> > >
> > This contradicts your first point. We need to call
> > `param_setup_earlycon` so it can handle `console=3Duart,mmio,XXXX`.
> > That's why this block of code is here. IMO it's very confusing
> > behavior that `earlycon=3Duart,mmio,XXXX` and `console=3Duart,mmio,XXXX=
`
> > are the same thing.
>
> Urgh, I didn't know that "console=3Duart*" started early console.
> I always thought that it was just another way how to define
> the normal console.

Yeah, it's all very confusing. We should probably remove the
`console=3Duart*` from the kernel documentation so people use
`earlycon=3Duart*` instead.

>
> (I feel shame as a printk maintainer. But I have never used it.
> And this has been the first patch in the related code since
> I started watching printk 10 years ago.)

lol, please don't shame yourself. There are plenty of odd quirks to be
found in maintaining such a large project.

>
> Looking into the history, "earlycon" parameter was added by
> the commit 18a8bd949d6adb311 ("serial: convert early_uart to
> earlycon for 8250") in 2007. The parameter "console=3Duart,mmio,XXX"
> started the console earlier even before.
>
> The "earlycon" parameter allowed to define the early console
> an explicit way on the command line. But it was not strictly
> necessary. The same effect could have been achieved by:
>
> static int __init do_early_param(char *param, char *val,
>                                  const char *unused, void *arg)
> {
>         struct obs_kernel_param *p;
>
>         for (p =3D __setup_start; p < __setup_end; p++) {
>                 if (p->early && strcmp(param, p->str) =3D=3D 0) {
>                         if (p->setup_func(val) !=3D 0)
>                                 printk(KERN_WARNING
>                                        "Malformed early option '%s'\n", p=
aram);
>                 }
>
>                 if (strcmp(param, "console") =3D=3D 0) {
>                         if (setup_early_serial8250_console(val) !=3D 0)
>                                 printk(KERN_WARNING, "Failed to setup ear=
ly console");
>         }
> }
>
> > The reason my patch checks for a NULL or empty val is because
> > `param_setup_earlycon` has a special case to handle the
> > `earlycon`/`earlycon=3D` case:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/=
heads/chromeos-6.1/drivers/tty/serial/earlycon.c#223
> >
> > ```
> > /* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
> > if (!buf || !buf[0]) {
> >   if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
> >     earlycon_acpi_spcr_enable =3D true;
> >     return 0;
> >   } else if (!buf) {
> >     return early_init_dt_scan_chosen_stdout();
> >   }
> > }
> > ```
>
> I see. It all makes sense now.

Great :)

>
> Your patch is good then. Well, would you mind to add a comment into
> the code and make the commit message more clear even for dummies like
> me?
>
> Something like the patch below. It would be better to split it into
> two:
>
>    + 1st shuffling the check and adding the first part of the comment
>    + 2nd fixing the case with empty console=3D options.
>
> I could prepare the patchset. I would keep your SOB for the 2nd patch
> if you agreed.

Yes, feel free. Thanks!

>
> Here is the proposal:
>
> From d2fb7c54bed4c67df229c56fcc1b0af83ada5227 Mon Sep 17 00:00:00 2001
> From: Raul E Rangel <rrangel@chromium.org>
> Date: Fri, 7 Jul 2023 19:17:25 -0600
> Subject: [PATCH] init: Don't proxy the empty console=3D options to earlyc=
on
>
> Right now we are proxying the `console=3DXXX` command line args to the
> param_setup_earlycon. This is done because the early consoles used to
> be enabled via the `console` parameter.
>
> The `earlycon` parameter was added later by the commit 18a8bd949d6adb311
> ("serial: convert early_uart to earlycon for 8250"). It allowed to
> setup the early consoles using another callback. And it was indeed
> more self-explanatory and cleaner approach.
>
> As a result, for example, the following parameters have the same effect:
>
>     console=3Duart[8250],mmio,<addr>[,options]
>     earlycon=3Duart[8250],mmio,<addr>[,options]
>
> Nevertheless, `console` and `earlycon` parameters behave different when
> the options do not match an early console. setup_earlycon() accepts only
> console names in __earlycon_table. Also the empty options are handled
> differently:
>
>   + When `earlycon=3D` or just `earlycon` is specified on the command lin=
e,
>     param_setup_earlycon() tries to enable an early console via the SPCR
>     table or the device tree.
>
>   + When `console=3D` is specified on the command line, it's intention is=
 to
>     disable the console.
>
> Here comes the problem. The current code calls param_setup_earlycon()
> even when `console=3D` is used with no options. As a result, it might
> enable the early console when it is defined in the SPCR table or
> a device tree. This is obviously not what users want.
>
> The early console should be enabled via SPCR or DT only when `earlycon`
> is used explicitly with no options.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> [pmladek@suse.com: Add comments and more details into the commit message]
> ---
>  init/main.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/init/main.c b/init/main.c
> index ad920fac325c..3b059e316e62 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -733,13 +733,25 @@ static int __init do_early_param(char *param, char =
*val,
>         const struct obs_kernel_param *p;
>
>         for (p =3D __setup_start; p < __setup_end; p++) {
> -               if ((p->early && parameq(param, p->str)) ||
> -                   (strcmp(param, "console") =3D=3D 0 &&
> -                    strcmp(p->str, "earlycon") =3D=3D 0)
> -               ) {
> +               if (p->early && parameq(param, p->str)) {
>                         if (p->setup_func(val) !=3D 0)
>                                 pr_warn("Malformed early option '%s'\n", =
param);
>                 }
> +
> +               /*
> +                * Early consoles can be historically enabled also when e=
arlycon
> +                * specific options are passed via console=3D[earlycon op=
tions]
> +                * parameter.
> +                *
> +                * Do not try it with an empty value. "console=3D" is use=
d to
> +                * disable real normal consoles. While "earlycon" is used=
 to
> +                * enable an early console via SPCR or DT.
> +                */
> +               if (strcmp(param, "console") =3D=3D 0 && val && val[0] &&
> +                   strcmp(p->str, "earlycon") =3D=3D 0) {
> +                       if (p->setup_func(val) !=3D 0)
> +                               pr_warn("Failed to setup earlycon via con=
sole=3D%s\n", val);
> +               }
>         }
>         /* We accept everything at this stage. */
>         return 0;
> --
> 2.35.3
>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
