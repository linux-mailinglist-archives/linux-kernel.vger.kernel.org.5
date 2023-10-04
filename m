Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8677B7C51
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242045AbjJDJhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjJDJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02911B4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:37:10 -0700 (PDT)
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA8593F197
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1696412227;
        bh=UlzyPWI8qWZBcNbmieOr3BVk1gktgoZ26fzf7WupCLs=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Hb8GJ5bapUJ+1oSrsDDiP/doJGXC2OH/n+FE4X/s9jGGYeiS9YYeUGHI7BJhmNp8I
         YhPDRENkvO6j5XXuHy7obeRMNlKevJ0uG5/wGPeLcQu+C1/K/Oqo2cHFcugvihAXhl
         CUgCprKFCMwswH6Bm4kcNE1ITOp/rOcCfUZZWlMEivvbCcIvEb+zwH8mnudWujEGWq
         nSgR+x0bBxXH0UXO/uSy57xEY6kxM/NytTdINtYVNidfg9TsWX1DgmhwzRwEs5+TUL
         wxt1bR7d1+iR3eRyW37fPI81+OO3KdD7HuGvPyY1uvMpzyLC6F1vaGGAMX+6j5RFCr
         mrxXKippYLcrQ==
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6557c921df1so19025746d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696412227; x=1697017027;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlzyPWI8qWZBcNbmieOr3BVk1gktgoZ26fzf7WupCLs=;
        b=QQXzRPs39AgZ6tmM8p2HyZ36J3pkIlhQQmm8+gxwfAjvcrhMXULmWu7AtAodpQamb4
         +TdbsOJ3R5bKCeMAxaNdVDM7PCK5ye++mIb21ydA3IqNZViOBJRTwavKvKTemp5dk6vn
         g7OS0cjJwd8b4g4jxxlZZtk3kBCJ0uGnPybNYcECZfGTeYzyu2a2laBGN3Gs4nx2pfaI
         Nw9d+9ZICOx2BYHpZPLzoCcx8oIT0iB2ksFShYHM864mp5cJ5o5YDXC+HpnvavqmaUYJ
         N6ii/zL87O2pD2d/POzZ93PNbn6UuuVTHs83alCxJGp7VZ66tuAJ61NusXW9vyA1lwXU
         pqKQ==
X-Gm-Message-State: AOJu0YxuO0kMF+MOBqIMfGEt5VF1UUlXWBr43PAl40ExG2kdeQHOy/Cb
        Iet9wpNXebuP/eSf+OqeI1DJ+g+SQCd8szu79Mq/VV0Ixu05/fXcHWeHw9uv5AAGSalNwLKdzgG
        /mYYra6LDr+tDSI9sw7stkJdKIbG0IUoUCP5hvOfFRW9v+8Tk14t2omftKQ==
X-Received: by 2002:a05:622a:105:b0:418:14ee:ac55 with SMTP id u5-20020a05622a010500b0041814eeac55mr1536955qtw.25.1696412226874;
        Wed, 04 Oct 2023 02:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUROpxIWaT7n1WPahi3nX20TV2/exAoVeIV9d0hQsY2h9AA9g+9PkkDCp26GV+2x4HCsso37GEcaHcGtLWEk0=
X-Received: by 2002:a05:622a:105:b0:418:14ee:ac55 with SMTP id
 u5-20020a05622a010500b0041814eeac55mr1536947qtw.25.1696412226601; Wed, 04 Oct
 2023 02:37:06 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 02:37:06 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231003145114.21637-19-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-19-brgl@bgdev.pl>
Mime-Version: 1.0
Date:   Wed, 4 Oct 2023 02:37:06 -0700
Message-ID: <CAJM55Z8S_4OGM_-iEACLzZgwt6_KoYr56RbPn+4kx7Beu2WjUg@mail.gmail.com>
Subject: Re: [PATCH 18/36] pinctrl: starfive: use new pinctrl GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 4 ++--
>  drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> index 530fe340a9a1..22a2db8fa315 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> @@ -918,12 +918,12 @@ static struct pinctrl_desc starfive_desc = {
>
>  static int starfive_gpio_request(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	return pinctrl_gpio_request(gc->base + gpio);
> +	return pinctrl_gpio_request_new(gc, gpio);
>  }
>
>  static void starfive_gpio_free(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	pinctrl_gpio_free(gc->base + gpio);
> +	pinctrl_gpio_free_new(gc, gpio);

Hi Bartosz,

Thank you for the patch. These new pinctrl_gpio_*_new() functions now seem to
have the same signature as the starfive_gpio_*() functions. Is there a reason
they can't be used as callbacks directly so we could just delete the
starfive_gpio_*() wrapppers?

Also it'd be great to be to be CC'd on at least the first generic patches where
the new functions are introduced to have some context without having to look it
up on lore.

/Emil

>  }
>
>  static int starfive_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
> diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> index 640f827a9b2c..5557ef3fbeb2 100644
> --- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> @@ -547,12 +547,12 @@ static const struct pinconf_ops jh7110_pinconf_ops = {
>
>  static int jh7110_gpio_request(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	return pinctrl_gpio_request(gc->base + gpio);
> +	return pinctrl_gpio_request_new(gc, gpio);
>  }
>
>  static void jh7110_gpio_free(struct gpio_chip *gc, unsigned int gpio)
>  {
> -	pinctrl_gpio_free(gc->base + gpio);
> +	pinctrl_gpio_free_new(gc, gpio);
>  }
>
>  static int jh7110_gpio_get_direction(struct gpio_chip *gc,
> --
> 2.39.2
