Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B404756D56
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGQTe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjGQTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:34:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9839D;
        Mon, 17 Jul 2023 12:34:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991fe70f21bso662605266b.3;
        Mon, 17 Jul 2023 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689622464; x=1692214464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYQ8MaDMGhvh5jrKhzRgcfiYyE0M1SG6+4azBMBqudI=;
        b=CmYsV+OUNE6OWix7qWg2NF9ksb+D4FwJEZz5BB5Bt/eEtlbnBpWxzX1hjxX7GWMqbP
         QBss3SAYbf08ZGFzeGlGu8svA+436HShSfeRePvPl/5SsV4Fi73RrXgNqWoj/5aAHE+n
         CSqV+P/yUXwSn/vt9QkACzC/YZqH/RF4Va2KFecfDefZJ1WQtq4cOWU0H5x1WXjQAXaf
         X9btZnmo+RiAnZHQWN0shbzijTaFo7v1aF8zdleQKC3A7KRH+fDuqbGpdfDBIhfSpKuY
         DdyLGY2oKZR3HC1qyeUtfB1POtC2MdmqdDR6cz0tcGI7drepjmRZnwDYY8bZV67pILK5
         vbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689622464; x=1692214464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYQ8MaDMGhvh5jrKhzRgcfiYyE0M1SG6+4azBMBqudI=;
        b=RGNTGhrRbyqN/XlOa3fJJLuRG3ieYjYizO8wXAGAQosG2GvwBctVNhKTcLgQmcwsHH
         mnlOJDWP+RUgoJhw+IgwB7huVioNKLGN5TVK3c5OLrinQgQZR+Jj9FLUOLjffGVnle7J
         efQ+e4eKij5KY5tNoL+WVNRjP1L7ioQfVc9M29Is12PQhSOLJvRPX/9R/5FyuctQGt0A
         iBQIklwvddVynXK3BkF+LplZ+EzyYtoNIBC2stGr40ZgP5n24pbi7tJaETGgmc7/KuxQ
         Z5yVuAmbFZfzqro+Z62ifRYdm0EB1ouQPzm0lulpD7PEV1emR4MOhvD+ffEw8H/7Cjbc
         zALw==
X-Gm-Message-State: ABy/qLaDp+uwwlg0U8fRGzlL8Rv5HjV+huHKn3C6+GfIEGRw6A+noX27
        mkw0WzqxzX/EeFom3ltIAKJ4eWZkYgu/WgoztTE=
X-Google-Smtp-Source: APBJJlGurTqxANGgZNeReihcfNiVDUQt3bLiY5il/O2f15miMPKQEnW6eArvtv8YdY0XGgskr4ratb3Fb7Qvh+aEAis=
X-Received: by 2002:a17:906:841:b0:991:cfce:7a09 with SMTP id
 f1-20020a170906084100b00991cfce7a09mr9440149ejd.67.1689622464190; Mon, 17 Jul
 2023 12:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
 <20230717172821.62827-5-andriy.shevchenko@linux.intel.com> <c47c26ba7ea5bcbdcbe1d001b6cc527cee6c7d03.camel@crapouillou.net>
In-Reply-To: <c47c26ba7ea5bcbdcbe1d001b6cc527cee6c7d03.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 17 Jul 2023 22:33:47 +0300
Message-ID: <CAHp75Vcjq9=Q2_fsGJ9oCw=WYR3p3ot_cNLiDJV93psNcXXHLw@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:02=E2=80=AFPM Paul Cercueil <paul@crapouillou.ne=
t> wrote:
> Le lundi 17 juillet 2023 =C3=A0 20:28 +0300, Andy Shevchenko a =C3=A9crit=
 :

...

> Unrelated change.

OK.

...

> So the correct way to update this driver would be to have a
> conditionally-exported dev_pm_ops structure:
>
> EXPORT_GPL_DEV_PM_OPS(intel_pinctrl_pm_ops) =3D {
>     NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,
> intel_pinctrl_resume_noirq),
> };

This looks ugly. I didn't know that EXPORT*PM_OPS designed that way,
but it seems pm.h in such case needs EXPORT for NOIRQ case as well.

> Then your two callbacks can be "static" and without #ifdef guards.
>
> The resulting "intel_pinctrl_pm_ops" can be marked as "extern" in the
> pinctrl-intel.h without any guards, as long as it is only referenced
> with the pm_ptr() macro.

I'm not sure I got this. Currently drivers do not have any guards.
Moreover, the correct one for noirq is pm_sleep_ptr(), isn't it?

--=20
With Best Regards,
Andy Shevchenko
