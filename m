Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8747B4810
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjJAOdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjJAOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 10:33:31 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952ED3;
        Sun,  1 Oct 2023 07:33:29 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b811a6ce8so7152586eaf.3;
        Sun, 01 Oct 2023 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696170809; x=1696775609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Jav5+6DUIs7KX+qZ3JaZt9JVupViQnJo5QGYgH5Mc=;
        b=g8XVXritbColFM+++Y8QFPXk6i3peWJ2TjxOXgnEktURGTpBSvi8jwptRf+TftPBf8
         5OCQktDLxRnd4Jp49A1Y0fZhYZsZqOeBWhoiyV1AK3QEpfuWFrG12Z3BsGQOV6mx81mH
         wAC+EzHq1kf/4vQlxZcMqJfMpTVCoZ2C6tA6uVPIPtgS2v4DMUpXKUy4Zxn0FxZperBM
         oQDNGsbK712uLoVGhfPdS+3Qgtgqg6kxoaDzZ+oFkktzkoqwJhWtb6TV5bygNpH397NV
         LukTecU3jkMjN/K3s8dQWkM2wBnkbSOzvIByEmbbKjCV+R3C7JvJErFUOszQ+Oo6jvW4
         h8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696170809; x=1696775609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3Jav5+6DUIs7KX+qZ3JaZt9JVupViQnJo5QGYgH5Mc=;
        b=TCXpE5FB0nLLNlkr5rgQfQw3qqVTvdVJvWEiYZ7k8QJgcDZg6Dfd1yDqLrwKXtSqVJ
         z2zc2ER2o4Qgt2FyhibkdAHCCizHd7o/yfgrmo4vaQpT6FRcquB9UgIGEmUXGHgN5DdN
         qrT+GKpagBXqgwXC/zX2zT7n9mQTKmCtUmEUkuKVzmMHmUmXUQjCiQaj7Fi27/XQEQB8
         RCseEA8midy1ifJsXV0fm9OfBcMWYL8NcSFJseYhkYLa2I6A5o4S248V00Ipxr3Qt20e
         JmTU2RfHttYTeBQvphS8/PywB6lRt6ePx4C/9gunjbb1TXb95aMWARszYCa+xIaV/o4U
         OX+A==
X-Gm-Message-State: AOJu0YxENZjmD1jdtMhmaHLkOOcjJ2JBifNOJ9mCGwFNYSuJOHvtWMug
        8Ulc048+xr2c5m9sah7xFLchOhKa7Z4hDG1LGkN/RLI+3yyB8g==
X-Google-Smtp-Source: AGHT+IGgNaOiZcpHaHm5piA7udLhcvwFBsnPWU4dhIDLuEYbFppcaolhcpxeLANBtTKYa3FvhrVELca8deDOmfAKCc8=
X-Received: by 2002:a4a:2756:0:b0:573:bf68:8dbc with SMTP id
 w22-20020a4a2756000000b00573bf688dbcmr8662181oow.7.1696170809215; Sun, 01 Oct
 2023 07:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231001-pxa-gpio-v4-0-0f3b975e6ed5@skole.hr> <20231001-pxa-gpio-v4-1-0f3b975e6ed5@skole.hr>
In-Reply-To: <20231001-pxa-gpio-v4-1-0f3b975e6ed5@skole.hr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Oct 2023 17:32:53 +0300
Message-ID: <CAHp75VcBY3W8aVEsRMPNMW9940yT+_=-w8J2uKfqvmUiAVjPhg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 1/6] ARM: pxa: Convert Spitz OHCI to GPIO descriptors
To:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 5:13=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic@=
skole.hr> wrote:
>
> Sharp's Spitz board still uses the legacy GPIO interface for controlling
> a GPIO pin related to the USB host controller.
>
> Convert this function to use the new GPIO descriptor interface.

...

> +       pxa_ohci->usb_host =3D gpiod_get_optional(&pdev->dev, "usb-host",=
 GPIOD_OUT_LOW);
> +       if (IS_ERR(pxa_ohci->usb_host))
> +               dev_warn(&pdev->dev, "failed to get USB host GPIO with %p=
e\n",
> +                               pxa_ohci->usb_host);

Since you are using _optional() API, you need to bail out on the error
case and replace dev_warn() by dev_err(). I guess I already commented
on this. What is the rationale to not follow my comment?

--=20
With Best Regards,
Andy Shevchenko
