Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7080E78863E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbjHYLqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbjHYLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:45:36 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837712105
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:45:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d7815003420so800998276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692963932; x=1693568732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcf02hKF/0IdH3b1tfgEymyLjXbz5lFk9LkSgZ+/VMA=;
        b=NXO+TOtkKX+bmKbXuTm0NUbkfxdku2aPo89ryMUq6iKKoSkZeNcvPAxF/bwzV7Eujg
         u6WF2gihqJ9s2SCDG6vYWQ9kbfporJWKFWZ1QouFO3tOeQlAoSm9lJ82Iuc03a6V/q1F
         NtK//fmUSm9gcKGUZxXwhxksr7YPzQbaBWBOQHfeFqodDOP7/Nr0IPLxY9Fe0oSNBmcr
         HrabKwve6jfC5QWE5nYDd2fztV+PeSf4R2gcaO2E3u4kEyJ6v9lvTu41asp9/vy6oEcT
         VLznEBoC+AGgyzjEhlUbFuyE9feuer683jMNKgerc2uCsoX+uimeVpNR/ymwy33l4mYH
         I2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692963932; x=1693568732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcf02hKF/0IdH3b1tfgEymyLjXbz5lFk9LkSgZ+/VMA=;
        b=DjNqQ2Nn8DckTaWCXc+XHks6dkvWM1/C4ghNnD2GTjAu/vgrRPWNwCJfFy5uYrDxuz
         r6AOvFmTJHW0P0F4KGD7rLHGpIx4iIIV38rgOHVtpGK2BGKwF6N1XaUs4kuaPev0aC09
         UT3o7zxYQQ0+ja14RXZ9BI0+W2gwhlY7NrThPn3Uen5VLBfpHSSJCs6hnyrkHMkbr74i
         08vHrU8BBFtsJ1eVzgkiIA0fMU2tMa+bkU6Ri4pznP11LTP6b6Lef3nMyG8CWpbhvg1C
         GMpkct70/NloCIL8C2e+5rQcVfkGOeZhpwUjb4+uHafzom6kihYsvm2ajrNLQi3v9qJh
         KjZg==
X-Gm-Message-State: AOJu0YxizxtWUYJj+LggLRITKxoY86vW8z4p4LW1NTa7whAGz+Pnf38i
        lhADNzZ3PZL4pxJWT/ofmrDl+LK7zq6tk0AMfC8oyA==
X-Google-Smtp-Source: AGHT+IGrtKMF8Yp+gEsaJ2A+cL1/buPgbXCYxwk792IJXE1syFo/+NkzfJGbMAyhGaVIo5+B9Tp9iUpkpzem/NxNnX0=
X-Received: by 2002:a25:d0d5:0:b0:d77:ec2f:63b with SMTP id
 h204-20020a25d0d5000000b00d77ec2f063bmr5858906ybg.5.1692963931772; Fri, 25
 Aug 2023 04:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230825095157.76073-1-balamanikandan.gunasundar@microchip.com> <20230825095157.76073-4-balamanikandan.gunasundar@microchip.com>
In-Reply-To: <20230825095157.76073-4-balamanikandan.gunasundar@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Aug 2023 13:45:20 +0200
Message-ID: <CACRpkdahEcKgR9gR7iU0cW_aDTReDYBKdP+5_F+hGcarCjG9gg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: atmel-mci: Move card detect gpio polarity
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:53=E2=80=AFAM Balamanikandan Gunasundar
<balamanikandan.gunasundar@microchip.com> wrote:

> The polarity of the card detection gpio is handled by the "cd-inverted"
> property in the device tree. Move this inversion logic to gpiolib to avoi=
d
> reading the gpio raw value.
>
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@micro=
chip.com>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +#if IS_ENABLED(CONFIG_MMC_ATMELMCI)
> +       /*
> +        * The Atmel HSMCI has compatible property in the parent node and
> +        * gpio property in a child node
> +        */
> +       if (of_device_is_compatible(np->parent, "atmel,hsmci")) {
> +               np_compat =3D np->parent;
> +               np_propname =3D np;
> +       }
> +#endif

You don't need to use the preprocessor actually, what I did in my
example works:

if (IS_ENABLED()... && of_device_is_compatible()...) {
...
}

If the first expression in the if() clause is constant false, the compiler
will optimize out the entire if()-clause. At least the compilers we care
about.

Yours,
Linus Walleij
