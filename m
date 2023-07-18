Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB4E757C54
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjGRM5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGRM5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:57:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA57126;
        Tue, 18 Jul 2023 05:57:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991f956fb5aso703378466b.0;
        Tue, 18 Jul 2023 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689685056; x=1692277056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3eRjU9qlc/HtWCZOEqE82aSE5kNybf7RR8ZGMXqc60=;
        b=g6z0JwGiNFW3lz4PmozRF+XBezdo2jwekkRhUykp1ZwKGIqp1lXzBnDwppLhroX43w
         +h7R9WRr3XU6YoSKJtYC7dlhGyEi+wEwY0JiHZTH4QElAx6UnaINFkeHyA5F3zwFobtW
         ozQi7ooh991iba2ndW2C1CW5pi/+b2dNrIR5X6l4AtF24MCyTSeKcxnrJqEF/cGt3o40
         gEXfN+NQqDibali2B5IkDOKvyC9F5DtUxeXkIqLZVvOVu9R8PiJfnwQVvPYVERVyVPpa
         uQFLj4rOWqAI+QISNqfVmoJIZLzoFqOZxN8vOESmohzgWtJMPk5Tp4NyDYqe2E4XUZC6
         S4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685056; x=1692277056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3eRjU9qlc/HtWCZOEqE82aSE5kNybf7RR8ZGMXqc60=;
        b=hTAsquloAArJY6KXMvFisNUZW8W68eo0hNqoC39FwUo8TZDJyjitQMpKkjAWRR2hAW
         oMAOUgrlLdc1Sttiwo9bYnrJIKJS5xVeXGlsSPkAFQboFfVyOKIGodRrByGFn6E9dMe8
         UgayHXObFLJjgjXuW4eK0f+LMs97qmwo9laDKPAbftKpip5YXrM4OsU5UUwVmoeaeP2a
         Pl38SIA+uw4HbXI34toDEBRNI0SLB/H/qezSz5IV/ysHrLarTCixQfXDvHE4WJpB3tWY
         H6g9hGgylq0LeVg4XVfGW9vTpIctUZwI/cGwAbxqRWdJG2u1+3KdynDM0Z4FEA9LscMF
         AwPg==
X-Gm-Message-State: ABy/qLamOUduG+uPReI2T25aLi6RgTnVIbnsVnkaRjSPc1e3EzjcJQoM
        g5/BET2ymOiYL1Zuu7Q/+J/+h//t18yD01JotTs=
X-Google-Smtp-Source: APBJJlElrlsnM8Wh1LOSDVOQPK6Ij0zGU/u15EPxUjBld0Dc/Kvg0px3zFSARhUXJU3vRjipS2x9YKFDV7eHqZ+urTU=
X-Received: by 2002:a17:907:3a49:b0:988:f1ec:7400 with SMTP id
 fc9-20020a1709073a4900b00988f1ec7400mr11363213ejc.36.1689685056299; Tue, 18
 Jul 2023 05:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-5-andriy.shevchenko@linux.intel.com>
 <c47c26ba7ea5bcbdcbe1d001b6cc527cee6c7d03.camel@crapouillou.net>
 <CAHp75Vcjq9=Q2_fsGJ9oCw=WYR3p3ot_cNLiDJV93psNcXXHLw@mail.gmail.com> <8c66f79025ddd8388eeb9bdb3f0e789fe9f362d9.camel@crapouillou.net>
In-Reply-To: <8c66f79025ddd8388eeb9bdb3f0e789fe9f362d9.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:57:00 +0300
Message-ID: <CAHp75VdPNCvhVSeKESbd7VNVPa8GVXVnw04jaE4HMUjK_b8+dA@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] pinctrl: intel: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:56=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 22:33 +0300, Andy Shevchenko a =C3=A9crit=
 :
> > On Mon, Jul 17, 2023 at 10:02=E2=80=AFPM Paul Cercueil <paul@crapouillo=
u.net>
> > wrote:
> > > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9=
crit :

...

> > > So the correct way to update this driver would be to have a
> > > conditionally-exported dev_pm_ops structure:
> > >
> > > EXPORT_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops) =3D {
> > >     NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,
> > > intel_pinctrl_resume_noirq),
> > > };
> >
> > This looks ugly. I didn't know that EXPORT*PM_OPS designed that way,
> > but it seems pm.h in such case needs EXPORT for NOIRQ case as well.
>
> It's designed so that when CONFIG_PM is disabled, the dev_pm_ops is
> garbage-collected along with all its callbacks.
>
> I know it looks ugly, but we already have 4 variants (regular,
> namespace, GPL, namespace + GPL), if we start to add macros for
> specific use-cases then it will become bloated really quick.

Maybe macros can be replaced / changed to make it scale?

> And the "bloat" I'm trying to avoid here is the extreme expansion of
> the API which makes it hard for people not familiar to the code to
> understand what should be used and how.

So far, based on the rest of the messages in the thread the
EXPORT*PM_OPS() have the following issues:
1) do not scale (for variants with different scope we need new set of macro=
s);
2) do not cover cases with pm_sleep_ptr();
3) export symbols in case when it's not needed.

Am I right?

> > > Then your two callbacks can be "static" and without #ifdef guards.
> > >
> > > The resulting "intel_pinctrl_pm_ops" can be marked as "extern" in
> > > the
> > > pinctrl-intel.h without any guards, as long as it is only
> > > referenced
> > > with the pm_ptr() macro.
> >
> > I'm not sure I got this. Currently drivers do not have any guards.
> > Moreover, the correct one for noirq is pm_sleep_ptr(), isn't it?
>
> The EXPORT_*_DEV_PM_OPS() macros do export the "dev_pm_ops"
> conditionally depending on CONFIG_PM. We could add variants that export
> it conditionally depending on CONFIG_PM_SLEEP, but we're back at the
> problem of adding bloat.

Exactly.

> You could use pm_sleep_ptr() indeed, with the existing macros, with the
> drawback that in the case where CONFIG_PM && !CONFIG_PM_SLEEP, the
> dev_pm_ops + callbacks are compiled in but never referenced.

And exactly.

I don't think they are ready to use (in the current form). But let's
see what we may do better here...

--
With Best Regards,
Andy Shevchenko
