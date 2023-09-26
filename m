Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90A97AF4F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjIZUWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZUWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:22:10 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B911F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:22:03 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f7f46b326so60889467b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695759723; x=1696364523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQPgNKa2ckzekLFC/mzb8gdM+KeB0NKG+j9gRkdkJyY=;
        b=moYeveR07OEjQ6/umxmF+9HR0p1HjxOMeHYGeQefnIYH1OAABI++MO7umRQIPdRw5e
         +/vKjGDlIX1+7+/NrPkNGdxjvKNZucfwtx+Ih5NtTABVYSqKkNB6YqIpbUPVA2U2mE7x
         4Qnwe7BLfXEiMyTI3gMT4YWElWPhs02/V4FTCRwMSBQu0xISH/AzQ2moh41+40yvj9s5
         21mMjtIvVsokUECCDYg4BTj0I0r+5MC0LEhAy+HaYSr5TUeiAuyIaqUXQdC/oZD6VKnY
         qs0GPpM1K+eGoRmw47pSY5FeZfoGI6Yny+IxTmMmZM2s4MunHvwcdY1FFDuu7/2gm6bd
         NZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695759723; x=1696364523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQPgNKa2ckzekLFC/mzb8gdM+KeB0NKG+j9gRkdkJyY=;
        b=uRy8ybBYZbAnfAKDcVc6q5UnqL85RNFr9Gw91mpGIf0RcTjpLO9cI6VeBlDZlIGqfQ
         ECMIn1kj6zC61zEKm+UT2GaX9z7+npUgm4bcAlqCjbNrUQkaMSaKnAbUekE9xnRRJ92J
         C0dB4Cjh2xRsYHXP6koZ5j8Jv2AUlRk/R0ZT0JgBmnhJtvf38Anh84RRnIZixOfgTv2W
         5Xl05h0J3LeHzjVlTtEnKsT98R+yW+sLN7H3hjRlYM0O4cLKNwOvbr/gKRwLSQrrD25x
         DyDrAqWYfsXi31cxMhaazhRXSEQvQRN0+dUO+iAPYky9bEnnN/T06p9KBsl5vMDxTAjU
         9hDA==
X-Gm-Message-State: AOJu0YxwQeMVyzPZH5CE9irmSJi0wg3SCRZaW9lYI0G8dIHCREaokT/H
        GsurJv4Fxx0ak4mkAwFbZO+1X1GuvCH/4ymAsuu/8A==
X-Google-Smtp-Source: AGHT+IFdsZivhBu7767dRMUTS4xzM+2fJEFXct3seu6QtXNrBvvb2Kl0FmLDOB3+wgdk2qyy/xNzAYl+aSMdAVjIs50=
X-Received: by 2002:a81:a0c3:0:b0:58c:53ad:ee3f with SMTP id
 x186-20020a81a0c3000000b0058c53adee3fmr74738ywg.34.1695759723006; Tue, 26 Sep
 2023 13:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926-pxa-gpio-v2-0-984464d165dd@skole.hr> <20230926-pxa-gpio-v2-2-984464d165dd@skole.hr>
In-Reply-To: <20230926-pxa-gpio-v2-2-984464d165dd@skole.hr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Sep 2023 22:21:51 +0200
Message-ID: <CACRpkdZBbUa9C=wj9vSuCem50+JutiYy-AMwMExKdC5SoVghgw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/6] ARM: pxa: Convert Spitz LEDs to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org
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

Hi Duje,

thanks for your patch!

On Tue, Sep 26, 2023 at 5:46=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Sharp's Spitz board still uses the legacy GPIO interface for configuring
> its two onboard LEDs.
>
> Convert them to use the GPIO descriptor interface.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
(...)
> +static struct gpiod_lookup_table spitz_led_gpio_table =3D {
> +       .dev_id =3D "leds-gpio",
> +       .table =3D {
> +               GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_ORANGE, "led_orang=
e",
> +                               GPIO_ACTIVE_HIGH),
> +               GPIO_LOOKUP("pxa-gpio", SPITZ_GPIO_LED_GREEN, "led_green"=
,
> +                               GPIO_ACTIVE_HIGH),

Unfortunately this is not how leds-gpio works.

You have to have the name be NULL instead of "led_orange" etc, and
put the LEDs in index order, in this case something like;

+       .dev_id =3D "leds-gpio",
+       .table =3D {
+               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_ORANGE,
NULL, 0, GPIO_ACTIVE_HIGH),
+               GPIO_LOOKUP_IDX("pxa-gpio", SPITZ_GPIO_LED_GREEN,
NULL, 1, GPIO_ACTIVE_HIGH),

Yours,
Linus Walleij
