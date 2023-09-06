Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CEF793BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbjIFL5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjIFL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:57:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BA6CE9;
        Wed,  6 Sep 2023 04:57:11 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79536bc669dso142390939f.3;
        Wed, 06 Sep 2023 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694001431; x=1694606231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETStM79EhTs6Ycln+MpBOlSHhZ1EU5fe9eA0HiVtwus=;
        b=oUF40hm6gigNCbo9Ofs32OLGi0Bkz+Lag4FWd4IVyl1GxgrVn+wfo9v7ZZxD0c3PEP
         Vy5PZT69RQsO9Nag1clc+wVcI0oRBdYtQ9gGi+l1O8VTY9TN0vZMbhp8l+GY34cD/wG+
         dAPHMIL4seBnPOnDDb1MlzjJtMUYDlh7lOz/3S3az30E7eGLYttC0CrULJxzH+uUSsVI
         NcdaKR1hsMWaPCbqiULwV+pHrlHj3IReLIlQ2fl8P5e3NnWKwkzEIl3g5WBK6mwcv3p/
         Vfczj/BD7vXa8bdPiEL3eaShe/eYXwJWKZvyGEgxDQKOoq/WfOAUmjI/y1AEiaQKDlOd
         AzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001431; x=1694606231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETStM79EhTs6Ycln+MpBOlSHhZ1EU5fe9eA0HiVtwus=;
        b=U/PqC89S48uFE2AU/V9UKPPotcZlYAcIv14vCulgnutszcb1lWEtcn5kyuTJJAZ/WS
         HEYFD+KnpElcZ+1VhaXHT67Z1MYhkCzWviCXzDobRwUn63qGMmEgRoHsvabV22ZIzEmK
         QZ64FnqhQad/hlzVzRUYYro+JLfS3Kma5D4XXye/AKZVfPKvoYuV3+gY+DR0OiUzdVTq
         UOxAExe6lboQnbLdoya3FScHBgqSNI4RYL6TobawuvBslNKvqqk1R9b1K4M7T3RwUP8E
         QXENq9A5r3m6+kfbdE17qchl3RVdofU6HXcHKOGcFfutSQ4CflGrOWT6L1UvhkdMZjdU
         XX/A==
X-Gm-Message-State: AOJu0Yx5iaJ7OC1418laiTPUIaO03AO3aszpdVmR0lS4Lm2ngQw5rkCI
        Y7yyRYlT1svEaDtl4N9TgLfCJy4Sg8FIAntE9BQ=
X-Google-Smtp-Source: AGHT+IEOhq6VDgO3a0YX3tdNF7tWgG7HbMlJSr7peyF1oA/kLtARoeuJcOKm/EM7g19JdHSakjYDsH7PEMyT+vf7fzc=
X-Received: by 2002:a6b:4904:0:b0:787:953:514b with SMTP id
 u4-20020a6b4904000000b007870953514bmr18718722iob.3.1694001430751; Wed, 06 Sep
 2023 04:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230905125603.74528-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <71ed3e90-2c94-2692-7b13-9788acfb9af6@tuxon.dev>
In-Reply-To: <71ed3e90-2c94-2692-7b13-9788acfb9af6@tuxon.dev>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Sep 2023 12:56:10 +0100
Message-ID: <CA+V-a8vkRmQBe=CAcrf2HaPpHDQS5fZADWLGDrJXSU9iP5dtPw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Add validation of GPIO
 pin in rzg2l_gpio_request()
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Claudiu,

Thank you for the review.

On Wed, Sep 6, 2023 at 9:12=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxon=
.dev> wrote:
>
> Hi, Prabhakar,
>
> On 9/5/23 15:56, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Validate the GPIO pin request in rzg2l_gpio_request() callback using
> > rzg2l_validate_gpio_pin() function. This stops any accidental usage
> > of GPIO pins which are not supported by the SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/=
renesas/pinctrl-rzg2l.c
> > index 37cdfe4b04f9..4ad08a4b786a 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -795,12 +795,18 @@ static const struct pinconf_ops rzg2l_pinctrl_con=
fops =3D {
> >  static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int off=
set)
> >  {
> >       struct rzg2l_pinctrl *pctrl =3D gpiochip_get_data(chip);
> > +     const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[offset];
> > +     u64 *pin_data =3D pin->drv_data;
>
> Maybe move this down a bit to keep the reverse christmas tree order that
> the driver is using as pattern.
>
Sure, will do and send a v2.

> Other than this:
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
Thanks for testing.

Cheers,
Prabhakar
