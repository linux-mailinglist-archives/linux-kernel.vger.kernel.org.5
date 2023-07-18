Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECCA757C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGRMvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjGRMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:51:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2511701;
        Tue, 18 Jul 2023 05:51:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99454855de1so504566866b.2;
        Tue, 18 Jul 2023 05:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684671; x=1692276671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/2563u5cOH3TFQnC6K2RUUtmAlaSoZJQm9HbnJPi6A=;
        b=iKKsUwLsrqwRmioG2l6VIuQCDdWIS+x7OvqTLH5gDfCTMpT+PYaav8SRQuyzIFdRK7
         xzPpn4SashCJNbr5fW/ErJIsUpoaGXJaa+RJDZXBKScdLc02p9LndavEuCl4RQRnTX9h
         3ZTYVLgnXzWVBt8H0toSOGPpXH28ikivdDHOj1voaDmtk6XEmYRXA+wPRH6qnqnMH4/M
         MPPAAXs/tmbovBrq6LkwpfZneVLY35A9HrthHuwr/Qwc9fyuZI/3MgISQ6meI/VrFnCP
         tCX7kFl6R7ED8YzzGfuqQfjnxbmJBTqYBWAXcYkNxgO+oztxChqdSdyATVA6ufkBPUId
         3lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684671; x=1692276671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/2563u5cOH3TFQnC6K2RUUtmAlaSoZJQm9HbnJPi6A=;
        b=BfKZ3TtwoKD9PKWIBK0qtNP01SzzdW7o/cmkH/UdHZ1cMTmp0UHeBmQjdSw/f8Iwyk
         q75eQlJT5khdHuvOozHAry9XA+CKqOWPcug2LAReb04eRywT+ZjLsnTkMK2s2agokvSt
         sQFee0iwlL01oN+tjlqCHDgms9AgGta+PWl1BLaNLiDcxnFyHV4+aYZcmhxsF0V58Zbu
         FJCHNf1J4S11rIWQA6iTaFFUd688BeG/emoGnZ1Xhk249AoKI25s06jYhUVvzsvdPbdT
         6Z9ZkmBZGWnLtyUEFqg31N87Mwmvy2uSJGtn/TzU+HQgLu2kPceidvT3aSrH+ZJWYBcv
         XYeQ==
X-Gm-Message-State: ABy/qLb61LkyjXSSpVNSVnJjynICkDJN7CALlJk3LBWUUUYDj5TR3/Np
        dt9xvnnylCrpkSMSFLLstMH3BGBbI8xMZTRIJ18=
X-Google-Smtp-Source: APBJJlEx07+dHAg1uNrR6U3SipVk2wgw6hkfeWbxoh6BDo4Hww7sGADxDz9h6Wu1gtnWGybAPUizheA0hRtDoVEKRpQ=
X-Received: by 2002:a17:906:749c:b0:994:5544:3aea with SMTP id
 e28-20020a170906749c00b0099455443aeamr10270194ejl.51.1689684671561; Tue, 18
 Jul 2023 05:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-11-andriy.shevchenko@linux.intel.com>
 <13f7153786cfcdc3c6185a3a674686f7fbf480dc.camel@crapouillou.net>
 <ZLZDL27zzDpY4q8E@orome> <5e4b5bc23f3edb3ed30cb465420a51ffceceb53d.camel@crapouillou.net>
 <ZLZ6amp5HKUbm5w3@orome> <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
In-Reply-To: <8f32cb8377808a073b043e0adf3ccf5ae5a84c92.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:50:35 +0300
Message-ID: <CAHp75Vc7W1EcHSoCaRCbJEcWb4naOez6d=W+kJVtMSifkPAozQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] pinctrl: tegra: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
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

On Tue, Jul 18, 2023 at 2:55=E2=80=AFPM Paul Cercueil <paul@crapouillou.net=
> wrote:
> Le mardi 18 juillet 2023 =C3=A0 13:41 +0200, Thierry Reding a =C3=A9crit =
:
> > On Tue, Jul 18, 2023 at 10:42:47AM +0200, Paul Cercueil wrote:

...

> > Looking at the definition of EXPORT_GPL_DEV_PM_OPS(), it will cause
> > an
> > EXPORT_SYMBOL_GPL() to be added. So there very well is a change. And
> > it's a completely bogus change because no module is ever going to use
> > that symbol. If we were to ever support building the pinctrl driver
> > as
> > a module, then this would perhaps make sense, but we don't.
>
> In this particular case the EXPORT_SYMBOL_GPL() isn't really important,
> the rest of EXPORT_GPL_DEV_PM_OPS() is.
>
> I don't think having a symbol exported it is a big deal, TBH, if you
> use the namespaced version. If you really don't want that, we need a
> version of EXPORT_GPL_DEV_PM_OPS() that doesn't export the symbol.

Ah, I agree with Thierry and it is another point why I do not like
those EXPORT*PM_OPS() macros.
Polluting an exported space (even namespaced) is a big deal, so,
definitely no from my side.

--=20
With Best Regards,
Andy Shevchenko
