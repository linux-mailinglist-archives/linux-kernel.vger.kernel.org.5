Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432D876EB11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHCNpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjHCNpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:45:21 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70846B4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:43:48 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44768e056e1so422023137.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691070228; x=1691675028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcdtTw4dkel5J7XpneY7Xveaen65+k0rJwQXNomPT1Q=;
        b=YUx/Uk831P+5OMLZz9Ezcx9gqA+M4bfPCexEZuTXnfDhCo+Zm4LHxtbjh/LECMaV38
         WXKlX+HXKmyPDW3841NAIsdCs4jMP8peAqpq/dRPJIwYTKS34lf1fMck10sz6jbgkTVR
         W65DpN2d5s393vwqcr3nYCs2Av8EtvykozfWjNEB6CyKPsXjemWPrmxidVZh98TWo3ZO
         IQrA0DYa4Ypj9T8zGgYslYYjB/ARxfpz7vVthq9aPkFDBSJOUIg59sYtegKBqy0Yy8Tl
         kB/k1QUxbFhl+9IsYIou2kPUB2UKepG+7dmfSb5EcYsXBbtnplaWXp/XaJlkqodo5q7w
         zgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070228; x=1691675028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcdtTw4dkel5J7XpneY7Xveaen65+k0rJwQXNomPT1Q=;
        b=lvxHoVrAEmx3DI+kdfm1MDBqRM2Obj0ghKjBngR9xQ/J+DooBe+8N8F3bXIKCgFe/b
         c1Q8q1ZnjVqhALIVXqhcGZEnGkw1jfOuaLgzhdhaC4ne+S3cc4Sg4C31Nb3eMICRWQmE
         aL7TWMZWPyqUbOajwd7caVBsZ0hpKhF8RnMUw/0te/R/qK2MIQkrtiNH2GO0uHsIN7ET
         cBE0fSDE0dWD4vY0xayjd4hYCbRmteNYCSRPXvobIOm31NDjw7QGumD1WoK1FL+yc8ZY
         DpEQeveWguScLZnlF9jGgwWJO3zJT0Bx6SG5sq2agoF8iy2N54N/u+vEd2qMRfQ6PQe7
         N3JQ==
X-Gm-Message-State: ABy/qLZuhiDbPUUpuB0k6ggiyjoktJH3nAxPI/uZajnI/G5XlD6jl1B0
        H+V8CIcdHGxENgK99MD2C9G4WddOKi28Fab8wuZRH3aOl8v9BJhktPI=
X-Google-Smtp-Source: APBJJlE6DgfLE8ulxBo2wRraz26sn1daNLA3cL1gBrcHf6ZmlOp7zQpV46Wgmp6efS+6X1TrYnjp67ALFLhBzF+uhHo=
X-Received: by 2002:a67:f797:0:b0:447:4456:a1cb with SMTP id
 j23-20020a67f797000000b004474456a1cbmr6774531vso.25.1691070227847; Thu, 03
 Aug 2023 06:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230801072800.4130-1-aboutphysycs@gmail.com>
In-Reply-To: <20230801072800.4130-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 3 Aug 2023 15:43:36 +0200
Message-ID: <CAMRc=MdZg6vXj9gG27qRwry5qFhxKOW4W8W-UhQL7rjSwmiSYA@mail.gmail.com>
Subject: Re: [PATCH] gpio: sch: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, andy@kernel.org,
        Alexandru Ardelean <alex@shruggie.ro>
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

On Tue, Aug 1, 2023 at 9:28=E2=80=AFAM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/gpio/gpio-sch.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index 8a83f7bf4382..e48392074e4b 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c
> @@ -380,8 +380,6 @@ static int sch_gpio_probe(struct platform_device *pde=
v)
>                 return -ENODEV;
>         }
>
> -       platform_set_drvdata(pdev, sch);
> -
>         girq =3D &sch->chip.irq;
>         gpio_irq_chip_set_chip(girq, &sch_irqchip);
>         girq->num_parents =3D 0;
> --
> 2.34.1
>

Applied, thanks!

Bart
