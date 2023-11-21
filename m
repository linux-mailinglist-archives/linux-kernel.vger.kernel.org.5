Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00BE7F3603
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKUSeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjKUSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:34:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFB12E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:34:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28517ef32c5so2160456a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700591642; x=1701196442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzdDJ4Dd6FTosNsKCwS18b6CXO06k4VJSeDsNXAqDjI=;
        b=YOWWC9qhZwdFcKNHWw1PrAwIR8Ee9lBU0QZHiZ6BA78yjgqHgTVokVyKUZQ6SncYw6
         nLjUnfw+qJYBJRtwMz1aEkRcyTp/gl3IvGeN9wQNCppeX4+/t9YVEj6jn3F6tvh7HOca
         CeRjaHnSC/XVnDfzYwBGbx1smGje86HPnImWuf+g1XrOfv8XCvVZaYIoV83IPswHnIlY
         dpKS86ly7F8RkbTrW93viiTGOf2DdUrgugHtP8NzyzzWXFPPkUScapqX/5AlZqh4+Ebq
         1tU7qPTkW5sHVTxaUDlSYxQQllIAx8lYEje7N4OY+0KEGiYQ23DVsI3pw+dUJqmuL1b+
         2xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591642; x=1701196442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzdDJ4Dd6FTosNsKCwS18b6CXO06k4VJSeDsNXAqDjI=;
        b=A+zgY7D2QJtnPPf4J+qneE68EF+fTWOJjyaTymUDNkA2c4K0eFGuDAMiO7oJpui0nL
         9yDb4BJMmn4H5ZqcUz0CVLqUdb6XOEi1q4a2jaZwllpaQ7I4X98i8zlD2ZbB1dYad2nq
         KFzWk6VUrgXECth0fhabRVc9hYr35fFQbLf/g/q+tgypi09nRt65fQ+ipYwBcahq5xzy
         YMCpkQBkV7545Uy4RGHMnBOJBzECMnQI34U9WA+LpV6YhrXi3PPrDseFUhMm2hqfv5EY
         5MPrB/KN8TInkMFQjuai585zsrDTtchYCxGNVfdtILfThK2HbC4zd5BNGQH2EukcMh56
         1MDQ==
X-Gm-Message-State: AOJu0YxcgAhwOlafpez1qOFPmEvwJmpafVqvQ1g+n9NcqbhcaFgK+M5D
        m5BeBD4G5lK6siCQNW60LNXM+iLbuQ+roFkX6ZPSdIvPrF2bb8Kaeho5pP9h
X-Google-Smtp-Source: AGHT+IHF7ocVdSZ8CZczrx8XKQgJ6e1yyNkflGjDn4AHaNW3RHHhMTAB4RhwOkC+6ysduWogFSJKUsp3Gw7AuhRwP4g=
X-Received: by 2002:a17:90b:1804:b0:285:25a1:ba9 with SMTP id
 lw4-20020a17090b180400b0028525a10ba9mr23029pjb.45.1700591642387; Tue, 21 Nov
 2023 10:34:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20231119085440epcas2p375fa3b2999e1a3ceeff9949136db7e28@epcas2p3.samsung.com>
 <20231119092909.3018578-1-youngmin.nam@samsung.com>
In-Reply-To: <20231119092909.3018578-1-youngmin.nam@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 21 Nov 2023 12:33:51 -0600
Message-ID: <CAPLW+4kO4wYP=5Sx7dPXU17b_CHBJKN_93GhWtZ60vKgNRTKwQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: add irq_set_affinity() for non wake up
 external gpio interrupt
To:     Youngmin Nam <youngmin.nam@samsung.com>
Cc:     tomasz.figa@gmail.com, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, alim.akhtar@samsung.com,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 2:54=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.=
com> wrote:
>
> To support affinity setting for non wake up external gpio interrupt,
> we add a new irq_set_affinity callback using irq number which is in pinct=
rl
> driver data.
>
> Before applying this patch, we couldn't change irq affinity of gpio inter=
rupt.
> * before
> erd9945:/proc/irq/418 # cat smp_affinity
> 3ff
> erd9945:/proc/irq/418 # echo 00f > smp_affinity
> erd9945:/proc/irq/418 # cat smp_affinity
> 3ff
> erd9945:/proc/irq/418 # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5   =
    CPU6       CPU7       CPU8       CPU9
> 418:       3631          0          0          0          0          0   =
       0          0          0          0      gpg2   0 Edge      19100000.=
drmdecon
>
> After applying this patch, we can change irq affinity of gpio interrupt a=
s below.
> * after
> erd9945:/proc/irq/418 # cat smp_affinity
> 3ff
> erd9945:/proc/irq/418 # echo 00f > smp_affinity
> erd9945:/proc/irq/418 # cat smp_affinity
> 00f
> erd9945:/proc/irq/418 # cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5   =
    CPU6       CPU7       CPU8       CPU9
> 418:       3893        201        181        188          0          0   =
       0          0          0          0      gpg2   0 Edge      19100000.=
drmdecon
>

Suggest formatting the commit message as follows, to make it more readable:

8<-------------------------------------------------------------------------=
->8
To support affinity setting for non wake up external gpio interrupt,
add irq_set_affinity callback using irq number from pinctrl driver
data.

Before this patch, changing the irq affinity of gpio interrupt is not
possible:

    # cat /proc/irq/418/smp_affinity
    3ff
    # echo 00f > /proc/irq/418/smp_affinity
    # cat /proc/irq/418/smp_affinity
    3ff
    # cat /proc/interrupts
               CPU0       CPU1       CPU2       CPU3    ...
    418:       3631          0          0          0    ...

With this patch applied, it's possible to change irq affinity of gpio
interrupt:

    # cat /proc/irq/418/smp_affinity
    3ff
    # echo 00f > /proc/irq/418/smp_affinity
    # cat /proc/irq/418/smp_affinity
    00f
    # cat /proc/interrupts
               CPU0       CPU1       CPU2       CPU3      ...
    418:       3893        201        181        188      ...
8<-------------------------------------------------------------------------=
->8

> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/s=
amsung/pinctrl-exynos.c
> index 6b58ec84e34b..5d7b788282e9 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -147,6 +147,19 @@ static int exynos_irq_set_type(struct irq_data *irqd=
, unsigned int type)
>         return 0;
>  }
>
> +static int exynos_irq_set_affinity(struct irq_data *irqd,
> +                                  const struct cpumask *dest, bool force=
)
> +{
> +       struct samsung_pin_bank *bank =3D irq_data_get_irq_chip_data(irqd=
);
> +       struct samsung_pinctrl_drv_data *d =3D bank->drvdata;
> +       struct irq_data *parent =3D irq_get_irq_data(d->irq);

I'm probably missing something, but: why not just use "irqd" parameter
and avoid declaring "bank" and "d"? Is "d->irq" somehow different from
"irqd"?

> +
> +       if (parent)
> +               return parent->chip->irq_set_affinity(parent, dest, force=
);
> +

Why not use irq_chip_set_affinity_parent() API?

> +       return -EINVAL;

Maybe use something like this instead:

    if (!irqd->parent_data)
            return -EINVAL;

    return irq_chip_set_affinity_parent(irqd, dest, force);

Can you please test if this code works?

> +}
> +
>  static int exynos_irq_request_resources(struct irq_data *irqd)
>  {
>         struct samsung_pin_bank *bank =3D irq_data_get_irq_chip_data(irqd=
);
> @@ -212,6 +225,7 @@ static const struct exynos_irq_chip exynos_gpio_irq_c=
hip __initconst =3D {
>                 .irq_mask =3D exynos_irq_mask,
>                 .irq_ack =3D exynos_irq_ack,
>                 .irq_set_type =3D exynos_irq_set_type,
> +               .irq_set_affinity =3D exynos_irq_set_affinity,

What happens if we just assign irq_chip_set_affinity_parent() here?
Would it work, or Exynos case is more complicated than this?

>                 .irq_request_resources =3D exynos_irq_request_resources,
>                 .irq_release_resources =3D exynos_irq_release_resources,
>         },
> --
> 2.39.2
>
