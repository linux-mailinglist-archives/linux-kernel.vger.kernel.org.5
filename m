Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C376BD90
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjHATV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjHATVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:21:55 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2F1BF1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:21:54 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4475af775c7so2036348137.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1690917713; x=1691522513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOoS0qhaKcElbsi0Z+E0aV8vW9BZkaI19KrbMNaM/w8=;
        b=H9t4D98cKETFIQBfxDzZBVS9TJtmYLNTa72PhkBpa0JdqLZ06xJZ1866UR/yW1NDwI
         2ZV7TRslvDdsvVug/p0Jz2y7W7cj1xsakRVjqoykZDVftldCrCxzEAUjBHOPH7OY9d07
         Lb7167PzGl7XZj7lxjn7gmz3rnfd2DSBz/n4AZKxDV83hYT8TSxCnya+6SGtzHRNh4iS
         fMejEI94L4exTqhQdEHsOJxQ2Qsyq/ji9SilTH06QZbGJ3pbHPqN+xiC4uPi1dCwXrhu
         WgQGJl6ymtqmiJ+0all926OUTRzyIQzIdnT35advjd/pDvGEb5luUQ8Kj1HV09vJfuvr
         uQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917713; x=1691522513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOoS0qhaKcElbsi0Z+E0aV8vW9BZkaI19KrbMNaM/w8=;
        b=GCm3CJmdDlUxeylWQPn4/RtpREgeEXR9gW7Pmc9ESgN1gVuGL/99VKY6Ti96Lu73kE
         hys9hwIoX2d26Z/zkx7xs2ykncwBl5uaGRltY4aRh006CIO84VoEPjzTw5C/3eLKtEaW
         j4X/o7ODHP7cBAYfm8WrsqqidiYgE9L3cOAoxQ7KvKO0XwEV6Dhz9zkKXj7DeN6TrKH4
         R4oLZBWwRsnpZmj0giWNfTsSSQ4RNWIFX327wWKEQEftAaARBwGwLgJFVHXL5ekF8K//
         16ZkQQm7larjvB+6fA1lHWJEmoI/sRtlASKGaW64AD8yJRZrJuQT7nQGGvCKW/duS3bY
         bNiw==
X-Gm-Message-State: ABy/qLYVqtKigYLxUKOH+pDe9uBlDXouiDNsI+32N4R7Eh61JFL23YEA
        OZRZJbrxofr3ZyCSMPyhSQdMefTqiI2lo3Vkz/HiMQ==
X-Google-Smtp-Source: APBJJlF1meobDFC+ZZom+NUUmu82u66qQdK7EfT40YIL+nHAb5GKoQnLKohZsZSnrsBaksvB/hYoVew2swB3GYS0bU8=
X-Received: by 2002:a05:6102:2456:b0:443:873a:16b8 with SMTP id
 g22-20020a056102245600b00443873a16b8mr3193533vss.30.1690917713403; Tue, 01
 Aug 2023 12:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230725123623.6411-1-aboutphysycs@gmail.com>
In-Reply-To: <20230725123623.6411-1-aboutphysycs@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 1 Aug 2023 21:21:42 +0200
Message-ID: <CAMRc=Mettq0xOPx7cgzk=-szp=FrzyWkCiW8NxC9WWyDnAM4dg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: max77620: remove unneeded platform_set_drvdata() call
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        andy@kernel.org, linus.walleij@linaro.org,
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

On Tue, Jul 25, 2023 at 2:36=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call is not required because no counterpart
> platform_get_drvdata() call is present to leverage the private data of
> the driver.
> Since the private data is confined to this driver file, external access
> is not feasible.
> The use of this function appears redundant in the current context of the
> driver's implementation.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>
> Changelog V1->V2:
>
> * https://lore.kernel.org/linux-gpio/20230720132535.23413-1-aboutphysycs@=
gmail.com/
> * fixed subject line: adjusted colons where needed
>
>  drivers/gpio/gpio-max77620.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
> index c18b60e39a94..8c2a5609161f 100644
> --- a/drivers/gpio/gpio-max77620.c
> +++ b/drivers/gpio/gpio-max77620.c
> @@ -331,8 +331,6 @@ static int max77620_gpio_probe(struct platform_device=
 *pdev)
>         girq->init_hw =3D max77620_gpio_irq_init_hw;
>         girq->threaded =3D true;
>
> -       platform_set_drvdata(pdev, mgpio);
> -
>         ret =3D devm_gpiochip_add_data(&pdev->dev, &mgpio->gpio_chip, mgp=
io);
>         if (ret < 0) {
>                 dev_err(&pdev->dev, "gpio_init: Failed to add max77620_gp=
io\n");
> --
> 2.34.1
>

Applied, thanks!

Bartosz
