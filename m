Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCD7E9A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKMKXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKMKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:23:35 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1418D75;
        Mon, 13 Nov 2023 02:23:32 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5bf5d6eaf60so43584527b3.2;
        Mon, 13 Nov 2023 02:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871012; x=1700475812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISelrhUz+tUwTPOpVjAn5G1ABI4YmRZvCmOYJcKmy7Q=;
        b=FKPymDsO6DcEeuw50V07tfIdJBSarXf+j18wnrkYVnw2RmkMZhphzbR3iiVlDR2PYF
         mYPFD6CtTLHlr+mzzHwFHDrEyOH7t8B2nWftiAPhHGeQ2etaYOlopkjSHTSG4iYjiXKU
         26/nSzQ+dAGlokiHLt667qktFJiB3bMulkr6aIWn+BcPj6Ourj/nn1dbXUswHiRMiRW6
         4N310Ld2MvfaA4b1Q0VBqGIGgcFXEDIix8jTNaugmFWyqlQVZ1vTonDQ0yaHxknym6VV
         IEtCPqGctWVWWiSnaEKAwNbdqfCXAgC5scAMby3VNYJTEtk8tYylV1kxb07K6H6SLDsF
         8JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871012; x=1700475812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISelrhUz+tUwTPOpVjAn5G1ABI4YmRZvCmOYJcKmy7Q=;
        b=sc67gZCiBaFg49cXXypw+w4ElFoz4eT2QRhx0B8IWbN2SkuJnSDRjq1QEo8v4eEp8J
         zM4FipFrNRAU32G2/+0Jnwu4qubtgTAbX5hi9AfHZz+0teHs0bQA3NoMcShn8X0T6GRN
         cVTse907IV5t4g/LNwEcTtRGNdJNOCWgOBbKsWCalG7aSRNwU+RYx8TaDzXmrjapSLRS
         F3ODeUc9fIBS1EjtU0cfmgMG1dnMpzigLaR8qsQxCU5bf0kw2pDGcLoiGYrsM1jnCbuY
         CR9kPIbhQt7R8MfQ6f1K00y2gRQ1U/QxgojyF1NAVf0uy3DhRWlWLSXqB1QHyzO1Yq3/
         rgOQ==
X-Gm-Message-State: AOJu0YxPmRyPoMeWR3mSDABUzksR4caSuPpNJQUWSJZDhXS5ja/jwVGm
        alOdGOHKblf9seHw8IU67osSAhfbmad/FK5firU=
X-Google-Smtp-Source: AGHT+IGeFMq6OPRYVFpLBqn7U8F7RLctOzbaeZinyDCceNJQA9yzq0afSM1d3lxBYSz248sE7pBipt1geSP2uWLF31w=
X-Received: by 2002:a81:4782:0:b0:5a7:a817:be43 with SMTP id
 u124-20020a814782000000b005a7a817be43mr6070415ywa.6.1699871011907; Mon, 13
 Nov 2023 02:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me> <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
 <fcfdc6f05926db494ea0105e5523cc21ecfdf4e7.camel@gmail.com>
In-Reply-To: <fcfdc6f05926db494ea0105e5523cc21ecfdf4e7.camel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Nov 2023 12:22:56 +0200
Message-ID: <CAHp75VcsF8GtmE2iDf2xPWi7U5WXhi1ZFUSeA_Y+TfHQn72Jrg@mail.gmail.com>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 12:07=E2=80=AFPM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
> > > +       /* Issue the reboot */
>             ^^^^^^^^^^^^^^^^^^^^^^
> This is the relevant comment, one can extend it, but looks already quite
> informative considering EP93XX_SYSCON_DEVCFG_SWRST register name.

This does not explain the necessity of the mdelay() below.

> But Nikita would be able to include more verbose comment if
> you'd have a suggestion.

Please,add one.

> > > +       ep93xx_devcfg_set_clear(priv->map, EP93XX_SYSCON_DEVCFG_SWRST=
, 0x00);
> > > +       ep93xx_devcfg_set_clear(priv->map, 0x00, EP93XX_SYSCON_DEVCFG=
_SWRST);
> >
> >
> > > +       mdelay(1000);
> >
> > Atomic?! Such a huge delay must be explained, esp. why it's atomic.

--=20
With Best Regards,
Andy Shevchenko
