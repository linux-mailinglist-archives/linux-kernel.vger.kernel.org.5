Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679097FDB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjK2Pe1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343806AbjK2PeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:34:25 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CACDD6E;
        Wed, 29 Nov 2023 07:34:31 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ce8eff71e1so51041147b3.0;
        Wed, 29 Nov 2023 07:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701272070; x=1701876870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PopFwY+hhIZfxVE9aZTSkJkF/ON9bFHv/e84VhxRzic=;
        b=twW48JyFlxMXpPKtz2BhpaRDlUE6GTOzVA0ww8tOU1BGVBe4f3LkmhrIT+9qN2aPvA
         8UrWGx65AOo0oxDwfC/3V+bpI/rgRGiFGi6fLPP9nZsD1opaFN/BmsRkxpnf8Vtlhi+D
         RaU4d+DANI7wNUCU4kwuws0A071c6qx5xR9Blba9wiPhZEOr1/SIO7kQbZDU5cb1re5J
         uYE0DJJLiMJY5C0YOEoKTS8rcyaziafACRKHBFi34ZLQf6+8Dc8EVVApqAS2rFwUuHDa
         M+2IgPss+i6W65XeOqQu17f50a6qWWIC8mSNaA91NPr0Isf+zspLJWelAFKLI3MAVtEE
         nUIA==
X-Gm-Message-State: AOJu0Yyb0N7Kyfg51yMKYyBBIAGFJ+V0Gl/5o8tGZ24tzPDDa5mER6Y6
        ySqGdbAWbUVDf/7sIuSje3jrcBoeMvklSQ==
X-Google-Smtp-Source: AGHT+IGHu7D8eS13TdxxyKSbAjrXpBQtZN0OmT0VadmL+cf9abgCKNoHUGqJAPSJp2LBYN88W0yKVg==
X-Received: by 2002:a81:5e43:0:b0:5be:7046:b2f7 with SMTP id s64-20020a815e43000000b005be7046b2f7mr18852045ywb.40.1701272070526;
        Wed, 29 Nov 2023 07:34:30 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id j83-20020a816e56000000b0057d24f8278bsm4546860ywc.104.2023.11.29.07.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:34:30 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59b5484fbe6so68699917b3.1;
        Wed, 29 Nov 2023 07:34:30 -0800 (PST)
X-Received: by 2002:a05:690c:fcb:b0:5cf:b2cc:cf5d with SMTP id
 dg11-20020a05690c0fcb00b005cfb2cccf5dmr12967096ywb.5.1701272070101; Wed, 29
 Nov 2023 07:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20231128200155.438722-1-andriy.shevchenko@linux.intel.com>
 <20231128200155.438722-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWt0qq-Umd8udb7fxpNVZ=X9O9eZGMVGFSGRO_d9UkgNw@mail.gmail.com>
 <ZWc_o4Dcsb0v5TGB@smile.fi.intel.com> <ZWdJUBNMYj9qvCf2@smile.fi.intel.com>
In-Reply-To: <ZWdJUBNMYj9qvCf2@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Nov 2023 16:34:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVfMq=nuJhDSq6QFr-hev8af1UpHRAD4g5heVTgQ+7qWA@mail.gmail.com>
Message-ID: <CAMuHMdVfMq=nuJhDSq6QFr-hev8af1UpHRAD4g5heVTgQ+7qWA@mail.gmail.com>
Subject: Re: [PATCH v3 06/22] pinctrl: core: Make pins const in struct group_desc
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Nov 29, 2023 at 3:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Nov 29, 2023 at 03:41:55PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 29, 2023 at 12:21:45PM +0100, Geert Uytterhoeven wrote:
> > > On Tue, Nov 28, 2023 at 9:04 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > It's unclear why it's not a const from day 1. Make the pins member
> > > > const in struct group_desc. Update necessary APIs.
>
> ...
>
> > > >  int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
> > > > -                             int *gpins, int ngpins, void *data);
> > > > +                             const int *pins, int num_pins, void *data);
> > > >
> > > >  int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
> > > >                                  unsigned int group_selector);
> > >
> > > Probably this is also the right moment to change all of these to arrays
> > > of unsigned ints?  Else you will have mixed int/unsigned int after
> > > "[PATCH v3 13/22] pinctrl: core: Embed struct pingroup into struct
> > > group_desc", and purely unsigned int after "[PATCH v3 22/22] pinctrl:
> > > core: Remove unused members from struct group_desc".
> >
> > Hmm... Can it be done later?
> >
> > I can, of course try to change the parameter here to be unsigned, but it most
> > likely fail the build for those drivers means need more patches, more delay to
> > this series.
> >
> > Linus?
>
> On the first glance updating API here does not fail the build.

That's what I had expected, as drivers already pass int or unsigned int
arrays anyway.

> Lemme incorporate this into v4.

Thanks!

> Meanwhile the drivers I left untouched, it might be separate changes
> to convert from int to const unsigned int.

Sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
