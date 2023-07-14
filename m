Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6DA75405F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjGNRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjGNRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:21:23 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D455D9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:21:22 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4409abccbefso535013137.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689355281; x=1691947281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZoeOx5F8zWgQSEjQwpA4WlFOT1qV96xDCNWUKiznt8=;
        b=nnHkWJ4542XN7rNWwLLg0SPu84dTfjb5t6zhHOLNyUVMPsE3/y/lSknbC+JmkiTnH1
         2iIrFB1lDJGwGXdl4LtuElhgEONxzYbWnx3kbRrrdBn9ijYRJSplvxAGOpPirUe98KsS
         V0avPtV1mKOEJO3y/8X4wlo66QPPPsxpswFpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355281; x=1691947281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZoeOx5F8zWgQSEjQwpA4WlFOT1qV96xDCNWUKiznt8=;
        b=hHYv70xDjpxIDZ1ExZi8O1cCn/KXrRpFcF3R5wjlyRX0dyVYn9R/HBfROHjOdNGiXA
         mFLVX/0vxZLF7XOr3GgmEqFp+KoSYA5pXUUaNKbYQQo7AHu+6gz99gfw8VQVtiT9Hr/8
         rUsyhyhoFuz64lLZjI7U/BaIN8W66/CnItRG4BPiW4VKsalzpDEKVge6eaVuyHMSSGym
         Z1xn3tMtU5ErISlIsqzr6+JUvAoih+LJBL5r5aptyd9ouxR+tKDAqfEiLeCJgVpA+bQ+
         aCD+rMKXTBusoT0Wb20qCmaAHvsduAjUNzQW1DaJsnwpQsmCe4cqIRKYAA8VPygSLEe+
         I7EA==
X-Gm-Message-State: ABy/qLasInn6uewUrlZ/4z35y7Z5HKhttEpOhacocza6snBE35oCJyO4
        Ft4FtDwVC7bSptl2rU4GMvyp11+nfjEcvw6rC0o=
X-Google-Smtp-Source: APBJJlGW/ozx6PGcRj2ys1nDyu0vu+yei7NCTjzTI2DRLSrihCDUwWVNm2kOfJbJJq14aL1KrAaIXw==
X-Received: by 2002:a67:fe4e:0:b0:443:7ab8:b5d7 with SMTP id m14-20020a67fe4e000000b004437ab8b5d7mr2219151vsr.14.1689355281173;
        Fri, 14 Jul 2023 10:21:21 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id f3-20020ab01003000000b0078a2d65ebdesm1145507uab.11.2023.07.14.10.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:21:21 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-440b53841a4so535605137.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:21:21 -0700 (PDT)
X-Received: by 2002:a67:edd8:0:b0:445:228e:62db with SMTP id
 e24-20020a67edd8000000b00445228e62dbmr1727069vsp.8.1689355280492; Fri, 14 Jul
 2023 10:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org> <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley>
In-Reply-To: <ZLF5_dJyQgzNnrnO@alley>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 14 Jul 2023 11:21:09 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
Message-ID: <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 10:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wro=
te:
>
> On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > On Sun, Jul 9, 2023 at 8:43=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> > >
> > >
> > >
> > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > >>
> > > >>
> > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > >>> Right now we are proxying the `console=3DXXX` command line args t=
o the
> > > >>> param_setup_earlycon. This is done because the following are
> > > >>> equivalent:
> > > >>>
> > > >>>      console=3Duart[8250],mmio,<addr>[,options]
> > > >>>      earlycon=3Duart[8250],mmio,<addr>[,options]
> > > >>>
> > > >>> In addition, when `earlycon=3D` or just `earlycon` is specified o=
n the
> > > >>> command line, we look at the SPCR table or the DT to extract the =
device
> > > >>> options.
> > > >>>
> > > >>> When `console=3D` is specified on the command line, it's intentio=
n is to
> > > >>> disable the console. Right now since we are proxying the `console=
=3D`
> > > >>
> > > >> How do you figure this (its intention is to disable the console)?
> > > >
> >
> > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html
> > says the following:
> > console=3D
> >     { null | "" }
> >             Use to disable console output, i.e., to have kernel
> >             console messages discarded.
> >             This must be the only console=3D parameter used on the
> >             kernel command line.
> >
> >         earlycon=3D       [KNL] Output early console device and options=
.
> >
> >             When used with no options, the early console is
> >             determined by stdout-path property in device tree's
> >             chosen node or the ACPI SPCR table if supported by
> >             the platform.
>
> Sigh, I wasn't aware of this when we discussed the console=3D handling.

It took a bit of digging to figure out what the actual intention was :)

>
> > The reason this bug showed up is that ChromeOS has set `console=3D` for=
 a
> > very long time:
> > https://chromium.googlesource.com/chromiumos/platform/crosutils/+/main/=
build_kernel_image.sh#282
> > I'm not sure on the exact history, but AFAIK, we don't have the ttyX de=
vices.
> >
> > Coreboot recently added support for the ACPI SPCR table which in
> > combination with the
> > `console=3D` arg, we are now seeing earlycon enabled when it shouldn't =
be.
>
> But this happens only when both "earlycon" and "console=3D" parameters
> are used together. Do I get it correctly?

The bug shows up when an SPCR table is present and the `console=3D`
parameter is set. No need to specify `earlycon` on the command line.

>
> This combination is ambiguous on its own. Why would anyone add
> "earlycon" parameter and wanted to keep it disabled?

This is not the case I'm hitting. I'm honestly not sure what the
behavior should be in the `earlycon console=3D` case?

>
> > > >>> diff --git a/init/main.c b/init/main.c
> > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > >>> --- a/init/main.c
> > > >>> +++ b/init/main.c
> > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *param,=
 char *val,
> > > >>>       for (p =3D __setup_start; p < __setup_end; p++) {
> > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > >>>               (strcmp(param, "console") =3D=3D 0 &&
> > > >>> -             strcmp(p->str, "earlycon") =3D=3D 0)
> > > >>> -        ) {
> > > >>> +             strcmp(p->str, "earlycon") =3D=3D 0 && val && val[0=
])) {
> > > >>>               if (p->setup_func(val) !=3D 0)
> > > >>>                   pr_warn("Malformed early option '%s'\n", param)=
;
> > > >>>           }
>
> Huh, this is getting more and more complicated.
>
> You know, it is already bad that:
>
>     + "console" enables the default console which might be overridden
>       by ACPI SPCR and devicetree

That's what this patch fixes. You need to specify `earlycon` in order
to get the ACPI SPCR or DT console.

>
>     + "console=3D" causes that "ttynull" console is preferred,
>           it might cause that no console is registered at all

This patch also makes it so `console=3D` no longer enables the earlycon.

>
>     + both "earlyconsole" and "earlyconsole=3D" cause that
>
>      consoles is enabled
>
>
> It is already bad that "earlycon" and "console" handle the empty value
> a different way. But this makes it even worse. The behaviour
> would depend on a subtle difference whether "console" or
> "console=3D" is used.

This patch makes it so that `console` or `console=3D` don't enable
earlycon. Earlycon can only be enabled via `earlycon` or `earlycon=3D`.

I don't see the `console` (without the =3D) documented:
https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html.
I'm guessing this is an undocumented "feature" that snuck in while the
`earlycon` stuff was being added.

>
>
>
> > > >>
> > > >
> > >
> > > --
> > > ~Randy

Thanks for reviewing,
Raul
