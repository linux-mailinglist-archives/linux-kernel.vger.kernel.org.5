Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE23757C11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjGRMoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGRMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:44:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE8170E;
        Tue, 18 Jul 2023 05:44:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9936b3d0286so801042066b.0;
        Tue, 18 Jul 2023 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684252; x=1692276252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjafSjwhPYU7xqZqTIKooSTK5vgwuXrvEkZkgBS1tpQ=;
        b=svWBMpAzUIcAKZFhbHmS1VForkB52Iwtil3hYos/NhMBLkdcnjFkQYfMA27oQkeQ0c
         J8gz0UU9uTFqvcyqYgZItHaSIGB9kZpwgzHISgERQJAXsUOB2kdPZJk2GEOJ7TvDhA91
         oltJy+6JfEkrHkOzlR2nmE22d1ttxlNPAs+b7TUOyNW9gwl4anIMdjZab5YvdHSMHCAB
         rHEv6KI1D7LUHjErwNrACg0CbZeFJmTBkY6pdFswB7i1RrOuBU80ZlNb31wgTtpX+T8C
         602eYVK4LPPZ+vyCtu0zQWz6sM4CVSq9dFS9vQjUaWIQYCzVmQUPT4HexvKIFyGUEqrM
         3Prg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684252; x=1692276252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjafSjwhPYU7xqZqTIKooSTK5vgwuXrvEkZkgBS1tpQ=;
        b=g8dbbgtcUNI+9LXkfG2uyzjho9Omtf9UaMj+nL0/zvTOG6i6tsa+HvgdDnzPIWqKWI
         THk0FqlygpI5RUoUf9R+209HKqhzFO8yGAiQeBm4qfaUvBK3vIOYjl9KUgSyJ/u7zjpQ
         rSZsgDgNmK19Gzd6aWJl790DZOlPZk+MIhQNtfvcxhTB5qq9NtWejt8eARrVRIJsFmwh
         BfMIyVROPPJXBtmW3wFHz9L4TIVuVnxIc4SqA88fwFT4w+J8ppVfqVB8cemZavbvCVNt
         HIxWVOzGhVcbWLcqy/xAr+9mx2Le2etxPlobq7ch7SFk5IJJjMeYWhpG2JgZvzolF/Xs
         u5HA==
X-Gm-Message-State: ABy/qLbwCkk3sYe7K8DTkbDDg5CsLUdNEC0LZiom8QlevOxCVemRAMlJ
        XgtKBhnrwXPCzfQEpG8UTjbmrJHfKThYMg29fEA=
X-Google-Smtp-Source: APBJJlG9m2BdQIW7onW1xnE8sV9rYPKp5JUOVkqIggApCTArboC/1wLbwqqnhKpHXdE0VmBN/AdKoTT/9mSwxAThd1A=
X-Received: by 2002:a17:906:1054:b0:994:569b:61b4 with SMTP id
 j20-20020a170906105400b00994569b61b4mr9894424ejj.28.1689684251957; Tue, 18
 Jul 2023 05:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-10-andriy.shevchenko@linux.intel.com>
 <03592cf5d6854dd5e534e0416de946fd38e4380c.camel@crapouillou.net> <CAMuHMdWMHjFdh0Ze9k8gZC_Cjp62zdwDK1cvehHb5WXYw+p1XQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWMHjFdh0Ze9k8gZC_Cjp62zdwDK1cvehHb5WXYw+p1XQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:43:35 +0300
Message-ID: <CAHp75VeVvUL29KUKaLHMpBnQE+WTkQmp=cC2y=dcjjv_d=D8vQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] pinctrl: renesas: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Tue, Jul 18, 2023 at 1:12=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Mon, Jul 17, 2023 at 9:12=E2=80=AFPM Paul Cercueil <paul@crapouillou.n=
et> wrote:
> > Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9cr=
it :

...

> > I think you could do:
> >
> > .pm =3D IF_PTR(IS_ENABLED(CONFIG_ARM_PSCI_FW), pm_sleep_ptr(&sh_pfc_pm)=
),
> >
> > Then you wouldn't need the #if defined(CONFIG_ARM_PSCI_FW) guard either
> > (as long as the code still compiles fine when that config option is
> > disabled), and you wouldn't need those dummy callbacks.
>
> Unfortunately not, as the code refers to psci_ops.cpu_suspend.
>
> You could create a small wrapper for that, though.

 I think it's already too many wrappers mentioned and since you
reviewed and acknowledged the change (thanks!) I will stick with my
initial version.

--=20
With Best Regards,
Andy Shevchenko
