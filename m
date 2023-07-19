Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBD75942B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGSL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGSL3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:29:55 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090610D2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:29:54 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4813688e561so1933981e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689766193; x=1690370993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4VfGXDItiz3rOhUAQIyTNmCOzkfaYXWYp0bCIPaFY4=;
        b=Vgr2o6cI8lHX0NMfceh2+i/P1G842ozgB/a0J63s/W3gBktk1rCfXLxNTjs3gycu3E
         6A0j9h4au9zLjLIkBNppRbaf1zlPR7dabVZSOjeU1r5dAdIWLMN1F95sY+tGVH3XeOKD
         huVzBUUeonRnAEHlW/Ee8CILx7Lhx6AHjVJwF+M3OqhX3iGod20aaNTGyd9bR10k134x
         k68szYIS+ph8uAmeX/brp0j3hbmeUR8A2jg/PWjHipYIDk681KeC094elCrs5HI/QpTQ
         aheHT47OzZmfkFyAwxUGBSaSyO10LZqMQkFak/KYg9XWYmOHkUGbKSuLiI2XFjWBr8pi
         22wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689766193; x=1690370993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4VfGXDItiz3rOhUAQIyTNmCOzkfaYXWYp0bCIPaFY4=;
        b=V7yMs9uKmgeiLEZSeoWdUv9FhaVNeAhYQfViXGyCVpIiqYnm6gvq2GPKZR6TRsXyPz
         tqZkUPOuql0btgDAn4l8WnVJ94uEIaVyuTvxwhVrWswq4vIH42YXepTPrqmeT7CODhR4
         bGB/7ZMSsRffSiFksVgH+sUdjfPEI8+czegg8Opjr3a9b+HAj6WJA9vqHlWLyvtcRmgd
         rM0DspwatV0QVE7YgJ7iV539954R0FAv3eWUjytVixNaB+z7oTSRF/5giYCrj27CxGI0
         MNvZ/iCosFsiiiHlPJsR3rKn3CJpIxvUEOKl3PEvCsSWYfsqvx4V9cg64o4+Ss3TD+v2
         je0g==
X-Gm-Message-State: ABy/qLarc4seRBRO0Vj195ZmrNlvofPiBMWu1kkWBSzQsMXY1yh7Chwk
        DfujFIDau/DhXt+Msx1lmjfsjF4mA9tQXKEhQeU2/w==
X-Google-Smtp-Source: APBJJlGhAN7cR3t34C3nRUgJY2UbNEIDk1e+PecKgQX1lein5M7EmL8XAFDWrh4b3tPGbEXDrbnagRCDx33hup8yQGc=
X-Received: by 2002:a1f:60d6:0:b0:471:7398:5af1 with SMTP id
 u205-20020a1f60d6000000b0047173985af1mr2313164vkb.10.1689766193751; Wed, 19
 Jul 2023 04:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230717205357.2779473-1-samuel.holland@sifive.com> <20230717205357.2779473-3-samuel.holland@sifive.com>
In-Reply-To: <20230717205357.2779473-3-samuel.holland@sifive.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 19 Jul 2023 13:29:43 +0200
Message-ID: <CAMRc=MdaS9PXE1xxSyBSxVhv-B6TNwot0+TLoF1-cNcLYaQ-WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: sifive: Allow building the driver as a module
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:54=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> This can reduce the kernel image size in multiplatform configurations.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  drivers/gpio/Kconfig       | 2 +-
>  drivers/gpio/gpio-sifive.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index e382dfebad7c..1a8e8a8c85d6 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -564,7 +564,7 @@ config GPIO_SAMA5D2_PIOBU
>           maintain their value during backup/self-refresh.
>
>  config GPIO_SIFIVE
> -       bool "SiFive GPIO support"
> +       tristate "SiFive GPIO support"
>         depends on OF_GPIO
>         select IRQ_DOMAIN_HIERARCHY
>         select GPIO_GENERIC
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 745e5f67254e..5941a817491c 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -277,4 +277,6 @@ static struct platform_driver sifive_gpio_driver =3D =
{
>                 .of_match_table =3D sifive_gpio_match,
>         },
>  };
> -builtin_platform_driver(sifive_gpio_driver)
> +module_platform_driver(sifive_gpio_driver)
> +
> +MODULE_LICENSE("GPL");
> --
> 2.40.1
>

This looks good but please follow Andy's suggestion and convert all
of_*() uses in the driver to generic helpers, then drop patch 1.

Bart
