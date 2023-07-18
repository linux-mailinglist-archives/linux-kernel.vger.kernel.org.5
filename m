Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E001757C23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGRMr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGRMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:47:24 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DEE7E;
        Tue, 18 Jul 2023 05:47:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-993a37b79e2so764508266b.1;
        Tue, 18 Jul 2023 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689684442; x=1692276442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGJYHhuupeLvD7iUldP9gnEGkr9rwuBLn1dMa+Ew/24=;
        b=VtcOZtNqJWG8/eO0W1GhqAZLKZOFgVOETWyaoKVn0z/TT2Ts9Tb1e3h933FhL10+ZZ
         DDMS6W2h5xtqTSg04fncdtozKVtCNJiTtgxuAt6iQyY+Q+ONFfWYWY+jl0Oq2wUZarCP
         +uQgony4GCEpdt+cIKVGX9obZkVXwGs/mreeaKjD84xFqP20y0/fQtDYIkTWOAtBm7vg
         MRXVINgDtCgfMyNrLjeAuMKMabGfhbtUlVSYqktym5jf2OPLNKxI7LZlKLg+T68up0YF
         uaHTSmgsC2n4yeJtoUIrSZ3r+nnzsZgA3jyrDF9zagZ4CKqBac+iVifM4xfdPylCGWQ0
         bD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684442; x=1692276442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGJYHhuupeLvD7iUldP9gnEGkr9rwuBLn1dMa+Ew/24=;
        b=M/RaL74uN7lV8lfixXlsnW27IPSBHnnUy6BgaED6ebqeZznxhvCHDwldZeaxtSVIao
         m/OWVKkfSJq/E0+ioiosaaMCQa/Xb4LSmoHkUaRXw5vvx6tPHx9d3avInb7by2o0RS0v
         rEkouaVhBv6ngmRr3eU1QkBxYEtqr1/9w8fElwWj6W5xk5klTdn4mPGYVoPQWsZJTM+7
         kiQ33IhHFAMYZZV71kEf3xaxiR5lHzTNV2LYcNHizlDnMGgxFm3iJ4Cz6zFl2nerO9cG
         3OAU2M4mOZwB0Xa4KMbKRyp4kD/6QuSVR5CtFCeR4WePcU+xGn8wy+FxuLwDICE3tSll
         tfDA==
X-Gm-Message-State: ABy/qLYxpS6vlg7T1ibcnLMYBcMR2Dg3F1BuOvK1Q377p3BdDfYMtaMh
        E3wXqsI6S0GKInRaHVgBF24uv+Y6N6r/LHMhJPA=
X-Google-Smtp-Source: APBJJlFWv/5l9OJf010RuvZ9Y5zmoeMZFAeyTTu73opyEbrIbXnZfVJSDMIhH8II3cHyjZ0u2hBQXv0rFIDUJ2ed/J8=
X-Received: by 2002:a17:906:4987:b0:997:e836:6c4 with SMTP id
 p7-20020a170906498700b00997e83606c4mr559158eju.9.1689684441861; Tue, 18 Jul
 2023 05:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-8-andriy.shevchenko@linux.intel.com> <64741cb9-3bcb-ba50-6e09-f30847bda669@collabora.com>
In-Reply-To: <64741cb9-3bcb-ba50-6e09-f30847bda669@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jul 2023 15:46:45 +0300
Message-ID: <CAHp75VcEptnG7SvKNdnjW8xmS9z5VVUJvpyD1ygmm-6dCjgWNA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: mediatek: Switch to use
 DEFINE_NOIRQ_DEV_PM_OPS() helper
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

On Tue, Jul 18, 2023 at 12:47=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
> Il 17/07/23 19:28, Andy Shevchenko ha scritto:

...

> > -static int mtk_paris_pinctrl_suspend(struct device *device)
> > +static int mtk_paris_suspend(struct device *device)

> > -static int mtk_paris_pinctrl_resume(struct device *device)
> > +static int mtk_paris_resume(struct device *device)
>
> What's the reason why you changed the suspend/resume function names?
> I don't really mind, but please at least mention that in the commit descr=
iption.

To put it on a single line. I will amend the commit message, thank you
for review!

...

> > +DEFINE_NOIRQ_DEV_PM_OPS(mtk_paris_pinctrl_pm_ops, mtk_paris_suspend, m=
tk_paris_resume);

...here ^^^

--=20
With Best Regards,
Andy Shevchenko
