Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81E76F3E1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjHCUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCUKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C33420F;
        Thu,  3 Aug 2023 13:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC45D61E59;
        Thu,  3 Aug 2023 20:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E1C433C9;
        Thu,  3 Aug 2023 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691093445;
        bh=rRqWLzad4aYTCLv6ApNU6Oinv4secXSUMatIH4Ddfbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QjVnoLJuhpzo+LVf5FxzVfxf7yERbuR73Vpqbu8gQy3L+cf9TsrVNciOqPwf0hmm7
         MKSs9DW/8T/MfqHNOP+6a3JfhJEYw3z1KiS12SUFQ84wcNWLaYCfLkl2GgTpitO1L0
         D7PnYJTtjts85h5Am9c9D9JCABDKeAq+DoD9TZ8w3t0Wm2MkJj7Ic6m54LqfHgBgNg
         oqsP38kdvLo1OO8Ib+liKFEKp+OuWZwZxndHXr1SdPyUtCoEh7mbf0vPC8XBxFYKLq
         cQ0NOimg4T+CnfjdGg7XVapzbgXk1olWoR0gGnYZEzQG23uMqDmc5ZK6gEUeP/XrqK
         icDmarkKOeNPw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b9a828c920so20848161fa.1;
        Thu, 03 Aug 2023 13:10:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy0l8ZS3iJbJ2LNTwRsCcUO1xlDTyUv4LOB/UbE04UoUGyD3MqC
        oD1CuOVnLqse6y6eXd6QmSeRQ/brk8hxZLwA2g==
X-Google-Smtp-Source: AGHT+IE8fLe5MbJV69kyUFyJY/X3Z5LLAhMuRB6XwAHzqyccpuPqPwBNAC1U7wPXbTbUefmajp7PmI0PgtW94DVwLxA=
X-Received: by 2002:a2e:7202:0:b0:2ba:18e5:106f with SMTP id
 n2-20020a2e7202000000b002ba18e5106fmr781135ljc.30.1691093443210; Thu, 03 Aug
 2023 13:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161840.1393996-1-hugo@hugovil.com> <20230721161840.1393996-7-hugo@hugovil.com>
 <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
 <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com> <2023072240-supremacy-shallot-a77f@gregkh>
 <20230724115428.d191186852c0bd0ee0d78398@hugovil.com> <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
 <20230731124600.39eb8d5c132f9338c2897543@hugovil.com> <CAL_JsqLaF70hNQndXpJfmH1TMGNbA7myQG0GK9fjyKOs63z-3w@mail.gmail.com>
 <20230731144115.14733f0e01f586a7efb91370@hugovil.com> <20230803135401.3a11bfb7c2985c1a90a2521b@hugovil.com>
In-Reply-To: <20230803135401.3a11bfb7c2985c1a90a2521b@hugovil.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Aug 2023 14:10:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-qbz=w2a00EXh_e1XmY1gF1nvxih7AOYXw+VuMXhnmw@mail.gmail.com>
Message-ID: <CAL_JsqK-qbz=w2a00EXh_e1XmY1gF1nvxih7AOYXw+VuMXhnmw@mail.gmail.com>
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:54=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Mon, 31 Jul 2023 14:41:15 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
>
> > On Mon, 31 Jul 2023 12:04:45 -0600
> > Rob Herring <robh+dt@kernel.org> wrote:
> >
> > > On Mon, Jul 31, 2023 at 10:46=E2=80=AFAM Hugo Villeneuve <hugo@hugovi=
l.com> wrote:
> > > >
> > > > On Mon, 31 Jul 2023 09:31:53 -0600
> > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > > On Mon, Jul 24, 2023 at 9:54=E2=80=AFAM Hugo Villeneuve <hugo@hug=
ovil.com> wrote:
> > > > > >
> > > > > > On Sat, 22 Jul 2023 17:15:26 +0200
> > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > > On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wro=
te:
> > > > > > > > On Fri, 21 Jul 2023 13:24:19 -0600
> > > > > > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > > > > > >
> > > > > > > > > On Fri, Jul 21, 2023 at 10:19=E2=80=AFAM Hugo Villeneuve =
<hugo@hugovil.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > > > > >
> > > > > > > > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from mo=
dem control lines")
> > > > > > > > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem statu=
s lines")
> > > > > > > > > > changed the function of the GPIOs pins to act as modem =
control
> > > > > > > > > > lines without any possibility of selecting GPIO functio=
n.
> > > > > > > > >
> > > > > > > > > Requiring a new DT property is not fixing a kernel regres=
sion. You
> > > > > > > > > should be returning the kernel to original behavior and t=
hen have a
> > > > > > > > > new DT property for new behavior.
> > > > > > > >
> > > > > > > > Hi Rob,
> > > > > > > > please read the entire patch history starting from V1
> > > > > > > >  and you will understand why this course of action was
> > > > > > > >  not selected.
> > > > > > >
> > > > > > > That's not going to happen, sorry, you need to explain it her=
e, in this
> > > > > > > patch series, why a specific action is being taken over anoth=
er one, as
> > > > > > > no one has time to go dig through past history, sorry.
> > > > > >
> > > > > > Hi Rob,
> > > > > > I initially submitted a patch to revert the kernel to original
> > > > > > behavior, but it created more problems because the patch was
> > > > > > unfortunately split in two separate patches, and mixed with oth=
er non
> > > > > > closely-related changes. It was also noted to me that reverting=
 to the
> > > > > > old behavior would break things for some users.
> > > > > >
> > > > > > It was suggested to me by a more experienced kernel developer t=
o
> > > > > > "suggest a fix, instead of hurrying a revert":
> > > > > >
> > > > > >     https://lkml.org/lkml/2023/5/17/758
> > > > >
> > > > > Do I have to go read this to decipher the justification and reaso=
ning?
> > > > > When Greg says "in this patch series", he means in the commit mes=
sages
> > > > > of the patches. You send v9 already and it doesn't have that. The
> > > > > patchset needs to stand on its own summarizing any relevant prior
> > > > > discussions.
> > > > >
> > > > > I never suggested doing a revert.
> > > >
> > > > Hi Rob,
> > > > I am sorry, but this is exactly what I "deciphered" from your
> > > > original email.
> > > >
> > > > I am trying very hard to understand exactly what you mean, but it i=
s
> > > > not that obvious for me. If something is not clear in my commit mes=
sage,
> > > > I will try to improve it. But before, let's try to focus on making =
sure
> > > > I understand more clearly what you want exactly.
> > > >
> > > > > Obviously, someone still wants the
> > > > > new feature.
> > > >
> > > > I assume that you refer to the "new feature" as what was added in
> > > > the commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem cont=
rol
> > > > lines")?
> > >
> > > Shrug. It's one of the 2 commits mentioned, I don't know which one
> > > exactly. Whichever one changed default behavior from use GPIOs to use
> > > modem ctrl lines.
> > >
> > > Reading it again, I *think* this patch is correct. Default behavior i=
s
> > > restored to use GPIOs. The DT property is needed to enable modem ctrl
> > > lines.
> >
> > Hi,
> > this is correct.
> >
> >
> > > What's not okay is just saying, these platforms may or may not need a=
n update:
> > >
> > >     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> > >     mips/boot/dts/ingenic/cu1830-neo.dts
> > >     mips/boot/dts/ingenic/cu1000-neo.dts
> >
> > Yes, my bad. I initially mentioned them and hoped to get some
> > feedback, which I never got, and I kind of forgot about it.
> >
> > > You need to figure that out. Have you checked with maintainers of
> > > these boards? When were they added and by who? At the same time or by
> > > the same person would be a good indication the platform uses modem
> > > ctrl lines. Or were these platforms in use before adding modem ctrl
> > > support? Then they probably use GPIOs or nothing.
> > >
> > > If there are platforms which would regress if the modem ctrl feature
> > > was just reverted, which ones are those?
> >
> > Ok, let me do some checks and get back to you on this.
>
> Hi Rob,
> for this board:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>
> it uses a SC16IS740, which doesn't have any GPIOs nor modem
> control lines, so no DT changes required.
>
> For these two Ingenic boards:
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts
>
> They use a SC16IS752, which has shared modem control lines and GPIOs.
> Unfortunately, the maintainers have not (yet) responded to my
> inquiries. Also, I tried to search for schematics or block diagrams on
> the net but couldn't find anything.
>
> These platforms were in use before the patch to add the modem control
> lines was added. Then like you said they probably use these shared
> lines as GPIOs or nothing, so no DT changes would be required.

Okay, that's useful (please add to the commit msg).

Still, what platform(s) need the modem control feature? Presumably
that's whatever platform Lech and Tomasz work on. I guess given the
Reviewed-by they are fine with needing a DT change.

Rob
