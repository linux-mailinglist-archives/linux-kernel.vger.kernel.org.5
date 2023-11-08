Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08857E5EDF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjKHTxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHTxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:53:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD5D2118;
        Wed,  8 Nov 2023 11:53:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D9C433CB;
        Wed,  8 Nov 2023 19:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699473222;
        bh=uT2KLmrmUhN94cnP4FFn+d3WsX8llgsbYO6eI4at6Hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEouo/RJYW1+/AfIoWmlqz43ruAZ3V9b/TyWvEIUmLwSQrEhZoNXKvafzNzREdsZg
         n7MQKQRbWowrebqRKZ3gHECViOtfm03WeJ72gLuq9772xk7Ac4jZP5bFKCzyk+tIPV
         r0LpGgQoI8fwdQtWqAiyZt9UIALB6uZ2hh08qC1eEVwQdPEumQ7m6p+jRE9IAWx2i9
         g7QHIVAuU/ESOMvcet+rN8FslsKXqCMiWMX3Y41Uu7q6ff+wkenYTcrLMXVi3Tv3qB
         YDvvm1aI3zRc7pVuSTNZWIs+CZdfJ6WoYDi/YKltokBwtWPHmfSwYi6Xf1FzrppLwA
         u3imYGV90Ya9Q==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50930f126b1so52906e87.3;
        Wed, 08 Nov 2023 11:53:42 -0800 (PST)
X-Gm-Message-State: AOJu0YxqGuyCeo50H5Xib8zpVNSEyqcNPfLFvFaEfhdhBf1z3sBiSyRF
        Ej9frBm2H8BOpArgn+iivRIcQuNFebGy65IJjw==
X-Google-Smtp-Source: AGHT+IEfaijtVt5S6gSGT0Feyn+VLPUayVxp9jPnXP+x+3OxSEhYIiLXr3Gogz7S/reOMPV0b65sB891YA/tpnig+M0=
X-Received: by 2002:a19:691c:0:b0:4fb:7559:aea3 with SMTP id
 e28-20020a19691c000000b004fb7559aea3mr1887853lfc.39.1699473220973; Wed, 08
 Nov 2023 11:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20231108155647.1812835-1-jiriv@axis.com> <20231108155647.1812835-4-jiriv@axis.com>
In-Reply-To: <20231108155647.1812835-4-jiriv@axis.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Nov 2023 13:53:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL3veRuuDqWnZ+eUTP5Mvz5WffYktrBh6HqyARRThzmYQ@mail.gmail.com>
Message-ID: <CAL_JsqL3veRuuDqWnZ+eUTP5Mvz5WffYktrBh6HqyARRThzmYQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] Input: cap11xx - remove unnecessary IRQ parsing
To:     Jiri Valek - 2N <jiriv@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 9:57=E2=80=AFAM Jiri Valek - 2N <jiriv@axis.com> wro=
te:
>
> Separate IRQ parsing is not necessary, I2C core do the job.
>
> Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/ca=
p11xx.c
> index 4711ea985627..ccca9936ef25 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -518,7 +518,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_c=
lient)
>         struct device *dev =3D &i2c_client->dev;
>         struct cap11xx_priv *priv;
>         const struct cap11xx_hw_model *cap;
> -       int i, error, irq;
> +       int i, error;
>         unsigned int val, rev;
>
>         if (id->driver_data >=3D ARRAY_SIZE(cap11xx_devices)) {
> @@ -624,13 +624,7 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_=
client)
>         if (error)
>                 return error;
>
> -       irq =3D irq_of_parse_and_map(dev->of_node, 0);

Probably can drop the include of of_irq.h as well.
