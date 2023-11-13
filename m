Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FAE7E99CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjKMKHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjKMKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:07:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4B0D5A;
        Mon, 13 Nov 2023 02:07:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so6519614a12.1;
        Mon, 13 Nov 2023 02:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699870023; x=1700474823; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1UVNwz3drUtlCcbwnzq+CFMoiQbpRGCy5kRE6bKE8o=;
        b=J0C+wXzqI3c9XDZu5+MztxryDAeZrkYipQCg+0H8Zd/fhP9PHIP2rQrSTse3HNr1yI
         ln4lyGakspsqLMhy1sA8ImqXF7PNmBB/rSbfGs4anBYBWl3XMuId7SEptP9SLfPGANof
         5LRC5PQ/HDJ7CU3yA6ZjNGfQ6/yyfjX6xKRizdBJwQEB9jxXQAwUmt01kmI+V6fJGbgC
         bmVEK0fjE5LEQbVTxchagCgJPP4q19XrNtULNaOrgvZAoSZF2hNcpouHPd/Gzm2DxR3c
         V8m3Bp0cpQayUEHWmJDIaMtslyYb8J7lpgEmAoZGwuo8ho6yQN1BQ+GEgB9IyLzkRhY4
         00kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870023; x=1700474823;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1UVNwz3drUtlCcbwnzq+CFMoiQbpRGCy5kRE6bKE8o=;
        b=CKfYpr6Z2cNrY0LV0GjJoM7k8zwekeyiNmfQ8lhMhYW7ap/Nzy+uZEHLQKbfDhAD6a
         2OIO0YoOX6KLOfT+M2af7GL9GvQ50+Kb100jvKLYPG1015S1447Eq5QIHAkPhqnDk1dZ
         o21KVvnG7AkwcOcj27ciGHq1WZ8t8DbiYPc34L76EL4w9xfj0K4T/u9E+dloauG56EMJ
         dFtnIonpi1fm5e9MZICumQnjb4A7dGV9kTFM+dXvNGUNoWwGTxknR7nc2fzYPIimXKX4
         CZFipHxd4D+C5aQ0estPtuMUYf3KeSj7733uemzrjQQq91QCU6d0/f+GnsbJFJYlKVHB
         Rzvg==
X-Gm-Message-State: AOJu0Yxcq6h6Ufd3M7nWC5owX5Iw21TjvoXPN6oeg7xo/m4xY88GKD9d
        61ycyaciLxmJuHK1D4QiM6vUSrns98AhtQ==
X-Google-Smtp-Source: AGHT+IGyrROtTFxyW749aHe9+Qh+zqYm6ESaHF42cs0Vlkcr6OoBfx4smMeCzi+Q7xnXlEg7ryaVeQ==
X-Received: by 2002:a17:906:7ad5:b0:9dd:64ca:dc69 with SMTP id k21-20020a1709067ad500b009dd64cadc69mr3930534ejo.1.1699870023492;
        Mon, 13 Nov 2023 02:07:03 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b009ae587ce128sm3761920ejb.216.2023.11.13.02.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:07:03 -0800 (PST)
Message-ID: <fcfdc6f05926db494ea0105e5523cc21ecfdf4e7.camel@gmail.com>
Subject: Re: [PATCH v3 14/42] power: reset: Add a driver for the ep93xx reset
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>, nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Lennert Buytenhek <kernel@wantstofly.org>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
        netdev@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Date:   Mon, 13 Nov 2023 11:07:01 +0100
In-Reply-To: <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-14-3d63a5f1103e@maquefel.me>
         <ZLq0Z0QgBdCoDpV+@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy!

On Fri, 2023-07-21 at 19:37 +0300, Andy Shevchenko wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Issue the reboot */
            ^^^^^^^^^^^^^^^^^^^^^^
This is the relevant comment, one can extend it, but looks already quite
informative considering EP93XX_SYSCON_DEVCFG_SWRST register name.

But Nikita would be able to include more verbose comment if
you'd have a suggestion.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map, EP93XX_SYSCON_DEVCFG_SWRST, 0x00);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ep93xx_devcfg_set_clear(priv=
->map, 0x00, EP93XX_SYSCON_DEVCFG_SWRST);
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mdelay(1000);
>=20
> Atomic?! Such a huge delay must be explained, esp. why it's atomic.

--=20
Alexander Sverdlin.

