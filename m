Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F675406A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbjGNRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjGNRZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:25:16 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904723A84
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:25:12 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-48133dc9820so589665e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689355511; x=1691947511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwgCPPbBkchF0RJ84B5/5F8PIdazAR42CJmMhfBtzss=;
        b=M2Zym/1gNnm+1zAWBiHZzC7rsXnxJgAQM8emy5bFRjvQK0vo2cZJBG3RD562Td1uzQ
         sROGtC5csy2vn7ADUiEA+MBSxlyK1qjtOBWKwEfGnZEhPXZNJ2ClOdDDapNCQMuZwZbW
         oLOvBInUbEdXB6txWlVgR83/acHxJx81M9GbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355511; x=1691947511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwgCPPbBkchF0RJ84B5/5F8PIdazAR42CJmMhfBtzss=;
        b=Zs0o2BSf0w/tq/PrTSs3xIynLfGBFwUFAO4zOp4sN1fIeGpOHEcT1UoCRlETWYNhL1
         yC2hW8VmcSnPO8asCu0W5ln/SBKLuejHbWF+dfbajeaKAB0SB2lTAGnQeVS7ua1KZBxZ
         IKlxISIoDZDHN5hCygrAeQ2SsJBQnscwb5wT2iYWSw0ROWj1GXdsKrc4/n9OuaQczrXI
         hbV6sjM3JQqQIHNB44wEJGYiiS6+mk40XMuFDMx81hiW5hn9S1ay8wXPk4ompLazgnC2
         l7iyvh88y89op5+67BvpWGKrkAp0UOensdOPKSRksqVVgugQKtJD94HlY8WQBZbrAYP3
         UY6Q==
X-Gm-Message-State: ABy/qLZHYZBTLyNHngTbsmuaW4VH6kceH99mOL61wtInWKjsSWOVf0Ex
        8WEE5G3JsfrCSCGr55ftKEg+PpsTXOQ9fbKbAnU=
X-Google-Smtp-Source: APBJJlFnSoC+Nu0+T6QNCeH9vejzAddfZ4xrnfPsyfGpX8OQPE7Kbl/d9AO9qWpJTVb9nHXLyCsiPA==
X-Received: by 2002:a1f:cac1:0:b0:471:13f7:548e with SMTP id a184-20020a1fcac1000000b0047113f7548emr2004590vkg.9.1689355511658;
        Fri, 14 Jul 2023 10:25:11 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id j25-20020ac5c659000000b0048138190696sm753242vkl.13.2023.07.14.10.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:25:11 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-791b8500a1dso605150241.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:25:11 -0700 (PDT)
X-Received: by 2002:a67:e897:0:b0:443:7bd9:3fea with SMTP id
 x23-20020a67e897000000b004437bd93feamr2265868vsn.23.1689355511009; Fri, 14
 Jul 2023 10:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230707191721.1.Id08823b2f848237ae90ce5c5fa7e027e97c33ad3@changeid>
 <b32ae8af-7950-c725-5632-6ec13420bf77@infradead.org> <6101a3bb-30eb-97fc-3a8e-6d15afc4efb5@amd.com>
 <3de1ff24-3970-6e22-a73c-70446b8de4bd@infradead.org> <CAHQZ30BLb13Mz5+3MCgV30eG-LiU-6-4F7AEinGQmsgiyzD-yA@mail.gmail.com>
 <ZLF5_dJyQgzNnrnO@alley> <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
In-Reply-To: <CAHQZ30DjZE6Mg-KUrLQOLHh+OxNHZXRDkuZopxJb3F7G29TsXA@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 14 Jul 2023 11:24:59 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Bt9ijVMcg_yjOrWO1+i4fFqJMfzUMGcpOy-OHDWjsASg@mail.gmail.com>
Message-ID: <CAHQZ30Bt9ijVMcg_yjOrWO1+i4fFqJMfzUMGcpOy-OHDWjsASg@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 11:21=E2=80=AFAM Raul Rangel <rrangel@chromium.org>=
 wrote:
>
> On Fri, Jul 14, 2023 at 10:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> w=
rote:
> >
> > On Mon 2023-07-10 09:30:19, Raul Rangel wrote:
> > > On Sun, Jul 9, 2023 at 8:43=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > > >
> > > >
> > > >
> > > > On 7/9/23 18:15, Mario Limonciello wrote:
> > > > > On 7/9/23 18:46, Randy Dunlap wrote:
> > > > >>
> > > > >>
> > > > >> On 7/7/23 18:17, Raul E Rangel wrote:
> > > > >>> Right now we are proxying the `console=3DXXX` command line args=
 to the
> > > > >>> param_setup_earlycon. This is done because the following are
> > > > >>> equivalent:
> > > > >>>
> > > > >>>      console=3Duart[8250],mmio,<addr>[,options]
> > > > >>>      earlycon=3Duart[8250],mmio,<addr>[,options]
> > > > >>>
> > > > >>> In addition, when `earlycon=3D` or just `earlycon` is specified=
 on the
> > > > >>> command line, we look at the SPCR table or the DT to extract th=
e device
> > > > >>> options.
> > > > >>>
> > > > >>> When `console=3D` is specified on the command line, it's intent=
ion is to
> > > > >>> disable the console. Right now since we are proxying the `conso=
le=3D`
> > > > >>
> > > > >> How do you figure this (its intention is to disable the console)=
?
> > > > >
> > >
> > > https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.ht=
ml
> > > says the following:
> > > console=3D
> > >     { null | "" }
> > >             Use to disable console output, i.e., to have kernel
> > >             console messages discarded.
> > >             This must be the only console=3D parameter used on the
> > >             kernel command line.
> > >
> > >         earlycon=3D       [KNL] Output early console device and optio=
ns.
> > >
> > >             When used with no options, the early console is
> > >             determined by stdout-path property in device tree's
> > >             chosen node or the ACPI SPCR table if supported by
> > >             the platform.
> >
> > Sigh, I wasn't aware of this when we discussed the console=3D handling.
>
> It took a bit of digging to figure out what the actual intention was :)
>
> >
> > > The reason this bug showed up is that ChromeOS has set `console=3D` f=
or a
> > > very long time:
> > > https://chromium.googlesource.com/chromiumos/platform/crosutils/+/mai=
n/build_kernel_image.sh#282
> > > I'm not sure on the exact history, but AFAIK, we don't have the ttyX =
devices.
> > >
> > > Coreboot recently added support for the ACPI SPCR table which in
> > > combination with the
> > > `console=3D` arg, we are now seeing earlycon enabled when it shouldn'=
t be.
> >
> > But this happens only when both "earlycon" and "console=3D" parameters
> > are used together. Do I get it correctly?
>
> The bug shows up when an SPCR table is present and the `console=3D`
> parameter is set. No need to specify `earlycon` on the command line.
>
> >
> > This combination is ambiguous on its own. Why would anyone add
> > "earlycon" parameter and wanted to keep it disabled?
>
> This is not the case I'm hitting. I'm honestly not sure what the
> behavior should be in the `earlycon console=3D` case?
>
> >
> > > > >>> diff --git a/init/main.c b/init/main.c
> > > > >>> index aa21add5f7c54..f72bf644910c1 100644
> > > > >>> --- a/init/main.c
> > > > >>> +++ b/init/main.c
> > > > >>> @@ -738,8 +738,7 @@ static int __init do_early_param(char *para=
m, char *val,
> > > > >>>       for (p =3D __setup_start; p < __setup_end; p++) {
> > > > >>>           if ((p->early && parameq(param, p->str)) ||
> > > > >>>               (strcmp(param, "console") =3D=3D 0 &&
> > > > >>> -             strcmp(p->str, "earlycon") =3D=3D 0)
> > > > >>> -        ) {
> > > > >>> +             strcmp(p->str, "earlycon") =3D=3D 0 && val && val=
[0])) {
> > > > >>>               if (p->setup_func(val) !=3D 0)
> > > > >>>                   pr_warn("Malformed early option '%s'\n", para=
m);
> > > > >>>           }
> >
> > Huh, this is getting more and more complicated.
> >
> > You know, it is already bad that:
> >
> >     + "console" enables the default console which might be overridden
> >       by ACPI SPCR and devicetree
>
> That's what this patch fixes. You need to specify `earlycon` in order
> to get the ACPI SPCR or DT console.
>
> >
> >     + "console=3D" causes that "ttynull" console is preferred,
> >           it might cause that no console is registered at all
>
> This patch also makes it so `console=3D` no longer enables the earlycon.
>
> >
> >     + both "earlyconsole" and "earlyconsole=3D" cause that
> >
> >      consoles is enabled
> >
> >
> > It is already bad that "earlycon" and "console" handle the empty value
> > a different way. But this makes it even worse. The behaviour
> > would depend on a subtle difference whether "console" or
> > "console=3D" is used.
>
> This patch makes it so that `console` or `console=3D` don't enable
> earlycon. Earlycon can only be enabled via `earlycon` or `earlycon=3D`.

Sorry, I misspoke. Earlycon that is configured using the SPCR/DT can
only be enabled via `earlycon` or `earlycon=3D`. You can still enable
`earlycon` via `earlycon=3Duart,mmio32,0xFFFFFFFF` or
`console=3Duart,mmio32,0xFFFFFFFF`.

>
> I don't see the `console` (without the =3D) documented:
> https://www.kernel.org/doc/html/v6.1/admin-guide/kernel-parameters.html.
> I'm guessing this is an undocumented "feature" that snuck in while the
> `earlycon` stuff was being added.
>
> >
> >
> >
> > > > >>
> > > > >
> > > >
> > > > --
> > > > ~Randy
>
> Thanks for reviewing,
> Raul
