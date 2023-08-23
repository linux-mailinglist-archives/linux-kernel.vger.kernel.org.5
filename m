Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D247857F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjHWMla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHWMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:41:29 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC8E46
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:41:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a85b9c6ccdso2227570b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692794486; x=1693399286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/f7T3FZf5QGSLEO262NyuWeijF0vG1zwz/aiGhEhO0=;
        b=sr8rx74L1zfe5NRH3/c1LNcfCpc1f8v2uvrU94iCS9tu5m4puB6UFiog6hf29WcVOL
         fWPjolJMZ8q/OrmRrs3XtWYMVXD43Hzye8A0YgH0Z4+8uub6URQ0BFy4kXsrYfMAUYO4
         U+Osy05eZffzhbonC5XyLYPoSdD6+dmhf0eUjYyOv4ufmc56b1cVeML3pX3MaSTdAiq0
         R84zBhoO4GWpBQ56nhP1hXX+3eguE8UrV26FiWotpz6QcHiiXVCBvTQJwrZ1xQGeRLN4
         iVCuldTdO13IcvOP6ca19/MuwLYdVUyFxw2RuZvqU5H0fCnd/4Iy0cpIg7R1fthThHRS
         /8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692794486; x=1693399286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/f7T3FZf5QGSLEO262NyuWeijF0vG1zwz/aiGhEhO0=;
        b=KPpYYgxY7Cc6SeNkZd2IeZrovEebDwIdToHK/1tCIYr4zQxVu6T1ejvHEVgrhVdJKd
         FoFxFfryDEYl4hHX7ALYkXzVYGdcMfUB40k1r49ngh441Lf7ga3jQ+S/oeg27qQVDOZL
         SWqaGzb9240YU8wNSAHlHaZq815kIB7K7PeEDnLNZ96AdcIilmDQc/bjKt1Ogj6uXr6/
         j5ja6L+yHpP1lI4vNFFKLoTLwf9c5xLpJTo5MQ91ZssRicd1/FXFgaBWfMxnRlqIXF/d
         Q897xGQmcdSMu8fv2TvQg+q656uZkmq0vyNOp9IG/QYWQEOoB6gvZqCRafstgL10GFHb
         6Vjw==
X-Gm-Message-State: AOJu0YzR+kEiIUO6ho0xr5q6X479lZtNx2O8beEEihDavZy9NyfiAikW
        4RgXpDdMKOr+/oPAEO6Pxxl/ZamjHViWCSbSZXhENg==
X-Google-Smtp-Source: AGHT+IGEVmJslUpD3TVQwsDHcK7stA8pSL9fmRj2QDvtZ9ZXvOFRcGwz5G+dkmi/efeD5ViaafkbJuoJhokEz4S2QrQ=
X-Received: by 2002:a05:6358:33a2:b0:135:99fa:a125 with SMTP id
 i34-20020a05635833a200b0013599faa125mr12763757rwd.1.1692794485931; Wed, 23
 Aug 2023 05:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230823104010.79107-1-balamanikandan.gunasundar@microchip.com> <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230823104010.79107-4-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 23 Aug 2023 14:41:14 +0200
Message-ID: <CACRpkda2gJkj6_25rnLUHNaLC3_kcSbCF+y6RRvbnUsju-iJYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: atmel-mci: Move card detect gpio polarity
 quirk to gpiolib
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     dmitry.torokhov@gmail.com, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, hari.prasathge@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balamanikandan,

thanks for your patch!

On Wed, Aug 23, 2023 at 12:40=E2=80=AFPM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> The polarity of the card detection gpio is handled by the "cd-inverted"
> property in the device tree. Move this inversion logic to gpiolib to avoi=
d
> reading the gpio raw value.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
(...)
>  drivers/gpio/gpiolib-of.c    |  7 +++++++

Patching here is the right approach!

> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +       if (of_device_is_compatible(np->parent, "atmel,hsmci") &&
> +           !strcmp(propname, "cd-gpios")) {
> +               active_high =3D of_property_read_bool(np, "cd-inverted");
> +               of_gpio_quirk_polarity(np, active_high, flags);
> +       }
> +#endif
>         for (i =3D 0; i < ARRAY_SIZE(gpios); i++) {
>                 if (of_device_is_compatible(np, gpios[i].compatible) &&
>                     !strcmp(propname, gpios[i].gpio_propname)) {

This duplicates the code right below. Can't you just add an entry to the
existing gpios[] array?

I would imagine:

    static const struct {
        const char *compatible;
        const char *gpio_propname;
        const char *polarity_propname;
    } gpios[] =3D {
#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
        { "atmel,hsmci", "cd-gpios", "cd-inverted" },
#endif
(...)


Yours,
Linus Walleij
