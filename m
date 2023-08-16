Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47177E5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344408AbjHPPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbjHPPuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:50:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB732D57;
        Wed, 16 Aug 2023 08:50:04 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bc9d16c317so5313250a34.1;
        Wed, 16 Aug 2023 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201004; x=1692805804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB7+5icQ5UTUMKnaDnyZ2cljK5vL3tau83bYKQpLyAo=;
        b=Wd+bpyTClvEVSzKupMvIKrNkqmkPJIIlS1GQAnH1zjc/eP0DznOZa6YLQah6IX2VIT
         MhLluHfF69yjxdqL/tzB2JARoxVrDTG29v3UbXTTa32zoBZZwTjYiLYkcLCPyS+Hmg/I
         wXN5GVw/+uiah8l0ShE9PNutuzmHhnXIws+ObDdhXIGVB4pmohs3M+L3HMuj89L/4CGy
         jc4jY2rGLDdYPEYYXngZzdhGlgZOZiO68zRYNOc4Fqr/kPGGF6JrTRoeUOVXsKcaw9vi
         5fZqL2ZeMar4K28qWOF9vLGzYukuLoiq2Ka9EarruFfXqMJsNhlW8MniFph5b2ACownb
         z9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201004; x=1692805804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB7+5icQ5UTUMKnaDnyZ2cljK5vL3tau83bYKQpLyAo=;
        b=NFIu6AOP0Y3QQXywPzqKrZyg7fm8PRcXRqUXPB/7WXrVO0Rh3VtBk/q07ZY7BdvzVg
         PnRzJP818vPfmEYy/DtI61etOEHWLOvAg9SjldSs+lSjNwnOBTSI512vcqccdE2K7dan
         HjR0kvtMX3pEchq9jwkcFY6SyO1Zq8RSlUs03EEIygXMcIdNw6HtosTy2vh1eDgcVhEF
         jQke+Z1W1EMHNuRW2RxFW+NOYBM2dRE+zYcqan1kUpQvEgWYd/0j1eULagmX5T9xFV44
         C3lJYHFrdnK1P3JB0+mGPXcfsogQTW+r7acD5e2s/3aLvLfBmkLHu/6YJJyGeMOyaiAZ
         16eg==
X-Gm-Message-State: AOJu0Yxh11aHvtTzynEPpjM+I0XDzxZmD78YytqXP+Tc0UCR0qIbKZgD
        5gdF7P8q9hHYhLuQazr0NJLujFynnpDUgncFnMgMJJgTsiQ=
X-Google-Smtp-Source: AGHT+IHcfwUYm3HCUC9d5U+ltSlNKWYLuQFXQdNYRPI0Y0Cy6bPgO5d3prxCnuYzi2je9q9keQgSdLfCH4iL+1FzSh4=
X-Received: by 2002:a05:6870:3382:b0:1bf:1346:63e with SMTP id
 w2-20020a056870338200b001bf1346063emr2430102oae.49.1692201004053; Wed, 16 Aug
 2023 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230816154442.8417-1-asmaa@nvidia.com> <20230816154442.8417-3-asmaa@nvidia.com>
In-Reply-To: <20230816154442.8417-3-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Aug 2023 18:49:27 +0300
Message-ID: <CAHp75Vdp9TYTod6UBLxG_YrT_vD4azfyrM9dTrau8CPJuH_vrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 6:45=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> Support add_pin_ranges() so that pinctrl_gpio_request() can be called.
> The GPIO value is not modified when the user runs the "gpioset" tool.
> This is because when gpiochip_generic_request is invoked by the gpio-mlxb=
f3
> driver, "pin_ranges" is empty so it skips "pinctrl_gpio_request()".
> pinctrl_gpio_request() is essential in the code flow because it changes t=
he
> mux value so that software has control over modifying the GPIO value.
> Adding add_pin_ranges() creates a dependency on the pinctrl-mlxbf3.c driv=
er.

...

> v1->v2:
> - No changes.

Is this correct?

...

> +static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
> +{
> +       unsigned int id =3D 0;
> +       int ret;
> +
> +       if (chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK)
> +               id =3D 1;

This id calculation seems wrong to me as I said in v1 review.
Why do you think the above is what you want and not just working by luck?

> +       return gpiochip_add_pin_range(chip, "MLNXBF34:00",
> +                       chip->base, id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
> +                       chip->ngpio);
> +}

--=20
With Best Regards,
Andy Shevchenko
