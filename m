Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCAB7B6CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjJCPMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJCPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:12:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4823A7;
        Tue,  3 Oct 2023 08:12:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3ae388eb437so2296069b6e.0;
        Tue, 03 Oct 2023 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696345948; x=1696950748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECaqdI7SkATSg6dLYHm3TC7CIUrImRF4newrkHZGp1U=;
        b=IFNwXu6d1TQ2Wx8RPBnsKzQ96mpeGfk9QMxrHto6yrZ/l3lv1iUyIJuhKTgdUCeW3B
         2qcSY1hm25SdgpkLTFr/oCOH2g1W49hXV1sfTyDXpJcVgOjDXvhaBPRwmuzQMzGJIW3+
         IIVZH2f4xk7nuD9CxS0Gvrkf79XposxY5jA0Dnwq7xpTTkR704UFb3MD1mZj3beKOtld
         jMQTTWICszeafI1ZUGUgVI/SIpkodfm36I6X6xhr5H6z0YuzPh38zPP0pWefkZTi666t
         CeH+iyWaiFP4spGWJGm/RZiDyLfRSy9AN9vj1KxF724fqQXd3qkqUZ8UuivCtrb3U1mc
         Rn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696345948; x=1696950748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECaqdI7SkATSg6dLYHm3TC7CIUrImRF4newrkHZGp1U=;
        b=mFbABkd+PdYrH2fcgSsNNdNxCYTq2+iEgWDCVGEhLYj+M14gNPwgCKUyIZDwN3isGz
         JyyVKPAHu65nTthwRzEIy9l3CPvc67NUg51TEEkh905JTHkMZgT/+vCfpxR22LWNUyV2
         xHuMZi8LV6rOl6zNCR8urhHmtolBXw17ypEw+PWSZpfSj9ypQobanYbbHvYhLFJtcPMs
         jY+Vo301fWtmQjGXb5cVOSJNvZhcvdikmAD7urJQuZbVTYJkSmnVtOpfn5FuWYZ+RDLf
         hFZ5AFfnCOpACbulobtsxChUb3t6A/NHVUcYHtZU23aBWE0V951LARP9vR8wQM62iRKX
         e8RQ==
X-Gm-Message-State: AOJu0YwmiYmwZAmLoPcrU32g0GFi63xQL740yo5kc9a7ANigkbqz0odN
        GzTzEarj2uRFO6wqs27UgxR3K9qK2oiAFMVYPLOHT9b+smg=
X-Google-Smtp-Source: AGHT+IH5H3/t7zPw5SP+N+dl6xhTtfkDJ0MFJ/sGvjHU/Nip+gZexAEu1fatTwmqdWe3j+m1IFQF7KKRMy/ldm6gneY=
X-Received: by 2002:a05:6808:18a0:b0:3ad:e05b:6745 with SMTP id
 bi32-20020a05680818a000b003ade05b6745mr1676701oib.27.1696345947986; Tue, 03
 Oct 2023 08:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-26-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-26-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:11:52 +0300
Message-ID: <CAHp75Ve7y8aSgy8JagLBgMT2Vh5Heit8=ckvDgCL8Qx15OmMpw@mail.gmail.com>
Subject: Re: [PATCH 25/36] pinctrl: cy8c95x0: use new pinctrl GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.

With whatever name of the APIs at the end,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-cy8c95x0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl=
-cy8c95x0.c
> index fae80b52a6fc..8c6006353515 100644
> --- a/drivers/pinctrl/pinctrl-cy8c95x0.c
> +++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
> @@ -554,7 +554,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pi=
nctrl *chip, int reg,
>
>  static int cy8c95x0_gpio_direction_input(struct gpio_chip *gc, unsigned =
int off)
>  {
> -       return pinctrl_gpio_direction_input(gc->base + off);
> +       return pinctrl_gpio_direction_input_new(gc, off);
>  }
>
>  static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
> @@ -571,7 +571,7 @@ static int cy8c95x0_gpio_direction_output(struct gpio=
_chip *gc,
>         if (ret)
>                 return ret;
>
> -       return pinctrl_gpio_direction_output(gc->base + off);
> +       return pinctrl_gpio_direction_output_new(gc, off);
>  }
>
>  static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int of=
f)
> --
> 2.39.2
>


--=20
With Best Regards,
Andy Shevchenko
