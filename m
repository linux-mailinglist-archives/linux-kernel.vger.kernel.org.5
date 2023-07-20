Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF075AEB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGTMs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:48:58 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485EE110;
        Thu, 20 Jul 2023 05:48:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-993a37b79e2so131416266b.1;
        Thu, 20 Jul 2023 05:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689857336; x=1690462136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+jxCbEvGzyKjyTj5pJgEX0b5zuXLRMsMFJaA5OrlJ4=;
        b=OdQX2hW2Kj0lODXLeMRUgJ6riXjmDIq+ah6/HOC/ykDprD9K+qzAHVWpbeMJMp8DFV
         5jgchHmUuKTyLvUudp72y1LnrsSe+rMm75y3xoUNYCVtHfpYhA3A81GRhfiNFOS+u9HS
         Ux8kk1NQwVXUKzJC9xCpyxAqW6scsWHvdxrb/zVVS/Kvcl4GwD3+d4uGItElp3lwkebx
         zBk4e6sO61niB4CYOf3AtxauTBw1Mcw4Gi4ioR/EQlb03a9Rz9Tb0hDJCIj6pUiJU7SD
         +4Q5e0hLFTp+XayHMYxNfpkewwSqTonMIF4NIGsi7JDjYg+RpUsy4JzwzR4khYw2Zvna
         V4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689857336; x=1690462136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+jxCbEvGzyKjyTj5pJgEX0b5zuXLRMsMFJaA5OrlJ4=;
        b=OszAiAPkUR3KqvYErG/2NUOGWy+Rn85ERkburTvu9WP2R7iy7imWfRRh0R3cZNFlAx
         HzAh+iQWQpEkNOH5PHvvRnA9X9onMS7+GLuAesmqATa0DoZHI0jI2Mh+B+xkFnGtJl8f
         M5CJEaTMOBT79/f3XbNxhloIJVSNww2ZvRdEt9y7WA0JuAmXJm/50CwVbelAiC2I1NJR
         bFjvPM99gNeba/qly6R6AempBtm9RtZF6zMnKDjOVWMbiEnsbtTr7Mc9wxo6QIJLKB/d
         ixRa2HiHY1WyOPeqnjVCID61/yESIY9aysErenIUBjmGmzS+mom1X6D2Dk4NPSZ7H8BK
         jtEw==
X-Gm-Message-State: ABy/qLaS9UvNvkEeZicwh40zuQtVqYbZ8NOm72PhA+wXyUuSP2l6D5Wv
        Iio6yN2ppFs1BNvuPN98cjCv8TwjX6/6qXIevF7YFsvC0KeQvQ==
X-Google-Smtp-Source: APBJJlH458gk1ffSu+b6OMpqHd6StyzzvcT3lPQmcH+523VX95By7jCuN/ua/ZRY7knrlg5nOwepXes1Ud2YHKpXuMI=
X-Received: by 2002:a17:907:c29:b0:991:b2a2:e424 with SMTP id
 ga41-20020a1709070c2900b00991b2a2e424mr6757509ejc.76.1689857335624; Thu, 20
 Jul 2023 05:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230720123102.154699-1-przemekchwiala@gmail.com>
In-Reply-To: <20230720123102.154699-1-przemekchwiala@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 20 Jul 2023 14:48:47 +0200
Message-ID: <CAKXUXMzNejUiJQOnkB9J28nbQg4epKF5c59d20SK9we7-txyJQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max17042_battery: Do not use CONFIG_
 prefix in regular C code
To:     Przemyslaw <przemekchwiala@gmail.com>
Cc:     hdegoede@redhat.com, krzysztof.kozlowski@linaro.org,
        m.szyprowski@samsung.com, sebastian.krzyszkowiak@puri.sm,
        kernel@puri.sm, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 2:33=E2=80=AFPM Przemyslaw <przemekchwiala@gmail.co=
m> wrote:
>
> From: Przemyslaw Chwiala <przemekchwiala@gmail.com>
>
> Using CONFIG_ prefix for macros is not a good practice.
> Use CONFIG_ prefix in Kconfig only.
>

Przemyslaw, thanks for the clean up of kernel config references. One
less to go on my clean-up list.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

> Signed-off-by: Przemyslaw Chwiala <przemekchwiala@gmail.com>
> ---
>  drivers/power/supply/max17042_battery.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 17ac2ab78c4e..e7d37e422c3f 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -36,7 +36,7 @@
>  #define STATUS_BR_BIT          (1 << 15)
>
>  /* Interrupt mask bits */
> -#define CONFIG_ALRT_BIT_ENBL   (1 << 2)
> +#define CFG_ALRT_BIT_ENBL      (1 << 2)
>
>  #define VFSOC0_LOCK            0x0000
>  #define VFSOC0_UNLOCK          0x0080
> @@ -1116,8 +1116,8 @@ static int max17042_probe(struct i2c_client *client=
)
>                                                 chip);
>                 if (!ret) {
>                         regmap_update_bits(chip->regmap, MAX17042_CONFIG,
> -                                       CONFIG_ALRT_BIT_ENBL,
> -                                       CONFIG_ALRT_BIT_ENBL);
> +                                       CFG_ALRT_BIT_ENBL,
> +                                       CFG_ALRT_BIT_ENBL);
>                         max17042_set_soc_threshold(chip, 1);
>                 } else {
>                         client->irq =3D 0;
> --
> 2.25.1
>
