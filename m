Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2E2754459
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGNVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:42:53 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459FF1BDA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:42:51 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-796d78b3f68so813260241.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689370970; x=1691962970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XdTX/O1yVVfiTgZyYqQD/Zcn+34T1q54/mLMYGXS/Y=;
        b=eDxRc+3ZSO+fGhjV8gbMBEHt9s+PM2WHwRSZsj4WpZS9XpjYGZxdfbH/0w3gFFIwHb
         lYRmd8NnD7lZwPdAHpsf2O4EeWHbZPZql9Kcra4rLLgeAykTvxrhpbD+XlkmyrwG4hTc
         QdmDIUduQ//qIjTJWxcgpvkxVJALGDpoeIkrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689370970; x=1691962970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XdTX/O1yVVfiTgZyYqQD/Zcn+34T1q54/mLMYGXS/Y=;
        b=Jg96brg5PY+c+aNoMMKOLPdb6ub2KTFm5Xfn44D1l3d14dEN1E7sMGurq7Vqp8RPIF
         f61HQpBwEg5BECx7q1GYhznfOXO4jJdg2jgwtECsc51fnZ6kj+p0++7/5Xnuue9ygvM4
         5XFvk/e0EkYFPyAEa20JSwifbvms1GpOml73MNAlMGCYbPC5HgzBa9ZdI9GOPWnQA7jc
         dIPLz+6KpeeUuVJydMpFBog4u5BQBPy1HPny62sJ7OVQctJZErafupGyif7B5UCowRAY
         dX8+sModvvqi9GxwxVX//rXra/xPrz1bxnZ1azhpQNro8EoILOGmb7DVHTfUqdzJy0A6
         qRHw==
X-Gm-Message-State: ABy/qLZcSNpbVibo0uAEuCq6W4tJ4P9ZqUzWW4dZHhPBXkcc6qZWlHio
        gKJoJmquazX0GpD5J9ylcbShWu7f4Cde4xvxV24=
X-Google-Smtp-Source: APBJJlEEzIhnUJP8OLA+Xfsf7FD7CIsQbr6QJzOu8U/LQhSNHgb3WikM/CeLQ4HwfEi/q5URVOaQVA==
X-Received: by 2002:a05:6102:3bce:b0:443:6e56:573 with SMTP id a14-20020a0561023bce00b004436e560573mr2840602vsv.35.1689370970118;
        Fri, 14 Jul 2023 14:42:50 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id x8-20020ab05ac8000000b0048b7c4e8277sm1231109uae.15.2023.07.14.14.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 14:42:49 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-443746c638eso886410137.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:42:48 -0700 (PDT)
X-Received: by 2002:a05:6102:1352:b0:43f:561c:2ea3 with SMTP id
 j18-20020a056102135200b0043f561c2ea3mr3413336vsl.21.1689370968418; Fri, 14
 Jul 2023 14:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org> <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley> <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
 <ZLGVYg1FAZN7VFxB@alley>
In-Reply-To: <ZLGVYg1FAZN7VFxB@alley>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 14 Jul 2023 15:42:36 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
Message-ID: <CAHQZ30Abpvm+__VK9oaU9eWwLKpiND+rmfjrPvF_R_09d2JqGQ@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:35=E2=80=AFPM Petr Mladek <pmladek@suse.com> wro=
te:
>
> First, I am sorry I sent the first mail too early by mistake.
> (Friday evening effect).

No worries.

>
> On Fri 2023-07-14 11:21:09, Raul Rangel wrote:
> > On Fri, Jul 14, 2023 at 10:38=E2=80=AFAM Petr Mladek <pmladek@suse.com>=
 wrote:
> > >
> > > On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > > > On Sun, Jul 9, 2023 at 8:43=E2=80=AFPM Randy Dunlap <rdunlap@infrad=
ead.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > > > >>
> > > > > >>
> > > > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > > > >>> Right now we are proxying the `console=3DXXX` command line ar=
gs to the
> > > > > >>> param_setup_earlycon. This is done because the following are
> > > > > >>> equivalent:
> > > > > >>>
> > > > > >>>      console=3Duart[8250],mmio,<addr>[,options]
> > > > > >>>      earlycon=3Duart[8250],mmio,<addr>[,options]
> > > > > >>>
> > > > > >>> In addition, when `earlycon=3D` or just `earlycon` is specifi=
ed on the
> > > > > >>> command line, we look at the SPCR table or the DT to extract =
the device
> > > > > >>> options.
> > > > > >>>
> > > > > >>> When `console=3D` is specified on the command line, it's inte=
ntion is to
> > > > > >>> disable the console. Right now since we are proxying the `con=
sole=3D`
> > > > > >>
> > > > > >> How do you figure this (its intention is to disable the consol=
e)?
> > > > > >
> > > >
> > > > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.=
html
> > > > says the following:
> > > > console=3D
> > > >     { null | "" }
> > > >             Use to disable console output, i.e., to have kernel
> > > >             console messages discarded.
> > > >             This must be the only console=3D parameter used on the
> > > >             kernel command line.
> > > >
> > > >         earlycon=3D       [KNL] Output early console device and opt=
ions.
> > > >
> > > >             When used with no options, the early console is
> > > >             determined by stdout-path property in device tree's
> > > >             chosen node or the ACPI SPCR table if supported by
> > > >             the platform.
> > >
> > > Sigh, I wasn't aware of this when we discussed the console=3D handlin=
g.
> >
> > It took a bit of digging to figure out what the actual intention was :)
> >
> > >
> > > > The reason this bug showed up is that ChromeOS has set `console=3D`=
 for a
> > > > very long time:
> > > > https://chromium.googlesource.com/chromiumos/platform/crosutils/+/m=
ain/build_kernel_image.sh#282
> > > > I'm not sure on the exact history, but AFAIK, we don't have the tty=
X devices.
> > > >
> > > > Coreboot recently added support for the ACPI SPCR table which in
> > > > combination with the
> > > > `console=3D` arg, we are now seeing earlycon enabled when it should=
n't be.
> > >
> > > But this happens only when both "earlycon" and "console=3D" parameter=
s
> > > are used together. Do I get it correctly?
> >
> > The bug shows up when an SPCR table is present and the `console=3D`
> > parameter is set. No need to specify `earlycon` on the command line.
>
> Strange, see below.
>
> > > This combination is ambiguous on its own. Why would anyone add
> > > "earlycon" parameter and wanted to keep it disabled?
> >
> > This is not the case I'm hitting. I'm honestly not sure what the
> > behavior should be in the `earlycon console=3D` case?
> >
> > >
> > > > > >>> diff --git a/init/main.c b/init/main.c
> > > > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > > > >>> --- a/init/main.c
> > > > > >>> +++ b/init/main.c
> > > > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *pa=
ram, char *val,
> > > > > >>>       for (p =3D __setup_start; p < __setup_end; p++) {
> > > > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > > > >>>               (strcmp(param, "console") =3D=3D 0 &&
> > > > > >>> -             strcmp(p->str, "earlycon") =3D=3D 0)
> > > > > >>> -        ) {
> > > > > >>> +             strcmp(p->str, "earlycon") =3D=3D 0 && val && v=
al[0])) {
> > > > > >>>               if (p->setup_func(val) !=3D 0)
> > > > > >>>                   pr_warn("Malformed early option '%s'\n", pa=
ram);
> > > > > >>>           }
>
> My understanding is that this code in do_early_param() allows to call
> param_setup_earlycon() with the @val defined via console=3Dval.
> It reduces cut&paste on the kernel command line.

Exactly

>
> It should never enable an early console when "earlycon" is not defined
> on the command line. Otherwise, console=3Duart[8250],mmio,<addr>[,options=
]
> would always enable earlycon as well.
>

Yep, this is what my patch fixes.

> If the "earlycon" is not defined on the command line then
> we should never call param_setup_earlycon() in the first place.
>
> Or the behavior is even more crazy than I thought.

This contradicts your first point. We need to call
`param_setup_earlycon` so it can handle `console=3Duart,mmio,XXXX`.
That's why this block of code is here. IMO it's very confusing
behavior that `earlycon=3Duart,mmio,XXXX` and `console=3Duart,mmio,XXXX`
are the same thing.

The reason my patch checks for a NULL or empty val is because
`param_setup_earlycon` has a special case to handle the
`earlycon`/`earlycon=3D` case:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/head=
s/chromeos-6.1/drivers/tty/serial/earlycon.c#223

```
/* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
if (!buf || !buf[0]) {
  if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
    earlycon_acpi_spcr_enable =3D true;
    return 0;
  } else if (!buf) {
    return early_init_dt_scan_chosen_stdout();
  }
}
```

Before my patch `console=3D` would call `param_setup_earlycon` which
would toggle the `earlycon_acpi_spcr_enable` flag true. This is
probably also the code that handled the naked `console` command too.

> > >
> > >     + "console" enables the default console which might be overridden
> > >       by ACPI SPCR and devicetree
> >
> > That's what this patch fixes. You need to specify `earlycon` in order
> > to get the ACPI SPCR or DT console.
>
> It sounds strange. earlycon is needed only for debugging. While
> ACPI SPRC or DT should define the preferred console by the platform.
>
> There are three levels of preference:
>
>    + console=3D parameter defines the user preferred. It overrides
>      everything.
>
>    + ACPI SPCR or DT should define the preferred console by
>      platform. It will be used when there is no user preference.
>
>    + Kernel registers the first initialized console with tty driver
>      when the is no preferred console by the user, ACPI SPCR, or DT.
>
> As I said, I would expect that early console is enabled only when
> earlycon parameter is defined on the command line.
>
> In each case, it seems that acpi_parse_spcr() and of_console_check()
> call add_preferred_console() even when earlycon is not defined
> on the commandline.
>

Currently the policy if SPCR is used for the default console is
determined by architectural policy. ARM64 enabled it, while x86 keeps
it disabled:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/head=
s/chromeos-6.1/arch/arm64/kernel/acpi.c#229
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/head=
s/chromeos-6.1/arch/x86/kernel/acpi/boot.c#1748

I'm honestly not a fan of enabling the SPCR console by default. It
will slow down booting since things now need to get written to the
UART. It's useful for debugging problems before the real console
driver can register (ttyS0, etc). It would honestly be nice if kernel
OOPS/panics got written to the SPCR UART. The earlycon also has
problems in that the ACPI power resources can't be specified so we can
run into problems when the ttyS0 ACPI power resources get enumerated
and turned off because there isn't a driver registered yet. This can
cause the earlycon to die/hang since it just got powerd off. But I
digress :)

> > I don't see the `console` (without the =3D) documented:
> > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html=
.
> > I'm guessing this is an undocumented "feature" that snuck in while the
> > `earlycon` stuff was being added.
>
> Honestly, I do not see where the "console" without '=3D' is handled.
> console_setup() does not check if the @str parameter is NULL.
>
>
> Anyway, the behavior already is complicated. But it might still
> make some sense when:
>
>    + "earlycon" parameter would try to call param_setup_earlycon()
>      with @val from "console=3Dval" parameter. It reduces cut&paste.
>
>    + "console=3D" causes that "ttynull" driver gets preferred. Which migh=
t
>        cause that no console driver gets registered at all. [*]
>
> But seems to be yet another level of craziness when "console" or
> "console=3D" would affect whether the early console will try
> to be defined via ACPI SPCR or not.
>
> I believe that this patch solves the problem. But it looks
> like a workaround which makes the logic even more tricky/hacky.
>
>
> IMHO, the right fix is to make sure that param_setup_earlycon()
> should get called only when "earlycon" is defined on the commandline.

We can do that, but it will remove the `console=3Duart,mmio,XXXX`
handling. IMO that's the correct thing to do, but I suspect there are
a lot of people that depend on it.

>
> Best Regards,
> Petr
