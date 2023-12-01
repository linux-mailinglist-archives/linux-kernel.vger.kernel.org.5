Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0777980112C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378300AbjLAQOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLAQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:14:33 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4E10DE;
        Fri,  1 Dec 2023 08:14:39 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58d54612d9cso1279957eaf.1;
        Fri, 01 Dec 2023 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701447279; x=1702052079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYTlbXNdi6+RrRGCgYzyhZgk7oIw1vxlucZ//ZpY5TY=;
        b=RdPWCBg/AWIpAUkzlE4SLWPlJ6yAypwVj4eHM/EY4QTBUlmJrpwCd3DqUlI5PImPAO
         Ih/GUAg470noTo2quaqkc4hJWg2KX+nJayn4HuscdXr7LqdRuEqlQqJN4kTR8yUnuWJf
         rjISwj3gm1KFMzqCAWnAg6RQg4nUsqJWpT3YS0+ajbqfPELUcu7bP35hhhOAiS4WVNeM
         3bRAOqAHMgQgO5Y+p5T59H5wE4LhddD6j1+Jvp2XRd73m+iI1HIFRrrdieMAwiuYNHyb
         b1hwRoWjHbsm/TjsPz7pauvW5/98qvBBt1w135wRgk/tFUj1A2/Ngpz3ykWPN3bw9uLu
         xs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701447279; x=1702052079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYTlbXNdi6+RrRGCgYzyhZgk7oIw1vxlucZ//ZpY5TY=;
        b=Q6FvfSQ7LYNoyyJc3OJN8clfpQeYhCoiUE8oFnWzzMWRtcOHi6MeHN/s6z5qixXWfq
         k3zGHIMLT0nkElMVSlMOojiEXJigSLHNvAhO6izRJIC4NnewIsRqgD3xEidOjwqlRVd3
         FRz3Q6lHOZjq4fw4n/HbnugL1qKYLC4Svk+hWrKEFoHtv4a2PTxsEjpFnqvqF/4AfrQY
         3y0pX2v1hQdIzoay8N1KRAvjT3qYhb2o/fGXGTkBmwoe7Zsa6qzbLgXbcj7Xa0Jp/dkN
         ZAOGS5GpJwomCB/98CsyTBtFfaikWJ9k7adeJuU9mbOcMBjXlpeuIPCxSZSM5xUpB8Oz
         b3qQ==
X-Gm-Message-State: AOJu0YzxLUESrnTOsC6ZPeVnsUHFu3d572NBHIezzKPmYOVNSuIqGKQG
        q7v4C5QQ2vn3V3qwyQLr7rKgN8x3JAhPwD3ttQ4=
X-Google-Smtp-Source: AGHT+IGX2vHj6B9J+2EgcQe6Dq33ZfVIjlDZWDaGR2C/r7mSSSmrhaEehDYe2+uJKbfyCWXRKy4sfpGhwBGbdmoAQng=
X-Received: by 2002:a05:6358:4327:b0:16e:236d:a6d8 with SMTP id
 r39-20020a056358432700b0016e236da6d8mr25684338rwc.20.1701447278775; Fri, 01
 Dec 2023 08:14:38 -0800 (PST)
MIME-Version: 1.0
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
In-Reply-To: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 1 Dec 2023 18:14:02 +0200
Message-ID: <CAHp75VcRQ6UaBbS4fWZhShEdFyd2NL1qWszkgrXBC-APJmg8tw@mail.gmail.com>
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data corruption
To:     =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(I like your analysis and a workaround, however there are quite a few
style minors, see below)

On Fri, Dec 1, 2023 at 5:56=E2=80=AFPM Jan Kundr=C3=A1t <jan.kundrat@cesnet=
.cz> wrote:
>
> The TL;DR summary is that the regmap_noinc_write spills over the data

regmap_noinc_write()
(we refer to function as func() in the text and code comments)

> that are correctly written to the HW also to the following registers in
> the regcache. As a result, regcache then contains user-controlled
> garbage which will be used later for bit updates on unrelated registers.
>
> This patch is a "wrong" fix; a real fix would involve fixing regmap
> and/or regcache, but that code has too many indirections for my little
> mind.
>
> I was investigating a regression that happened somewhere between 5.12.4

v5.12.4
(you even used v later)

> (plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our
> MAX14830 UART would work fine the first time, but when our application
> opens the UART the second time it just wouldn't send anything over the
> physical TX pin. With the help of a logical analyzer, I found out that
> the kernel was sending value 0xcd to the MODE1 register, which on this
> chip is a request to set the UART's TX pin to the Hi-Z mode and to
> switch off RX completely. That's certainly not the intention of the
> code, but that's what I was seeing on the physical SPI bus, and also in
> the log when I instrumented the regmap layer.
>
> It turned out that one of the *data* bytes which were sent over the UART
> was 0xdd, and that this *data byte* somehow ended up in the regcache's
> idea about the value within the MODE1 register. When the UART is opened
> up the next time and max310x_startup updates a single unrelated bit in
> MODE1, that code consults the regcache, notices the 0xdd data byte in
> there, and ends up sending 0xcd over SPI.
>
> Here's what dump_stack() shows:

According to the Submitting Patches, this can be reduced to show only
important lines.

>  max310x spi1.2: regcache_write: reg 0x9 value 0xdd
>  max310x spi1.2: PWNED

>  CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.5.9-7-g9e090fe75fd8 #7

This is not important...

>  Hardware name: Marvell Armada 380/385 (Device Tree)
>  Workqueue: events max310x_tx_proc

>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from regcache_write+0xc0/0xc4

...nor these...

>   regcache_write from _regmap_raw_write_impl+0x178/0x828
>   _regmap_raw_write_impl from _regmap_raw_write+0xb8/0x134
>   _regmap_raw_write from regmap_noinc_write+0x130/0x178
>   regmap_noinc_write from max310x_tx_proc+0xd4/0x1a4
>   max310x_tx_proc from process_one_work+0x21c/0x4e4

>   process_one_work from worker_thread+0x50/0x54c
>   worker_thread from kthread+0xe0/0xfc
>   kthread from ret_from_fork+0x14/0x28

...neither of these.

> Clearly, regmap_noinc_write of a register 0x00 (that's the TX FIFO on

()

> this chip) has no business updating register 0x09, but that's what was
> happening here. The regmap_config is already set up in a way that
> register 0x00 is marked precious and volatile, so it has no business
> going through the cache at all. Also, the documentation for
> regmap_noinc_write suggests that this driver was using the regmap

()

> infrastructure correctly, and that the real bug is somewhere in
> regmap/regcache where a call to regmap_noinc_write end up updating an

()
ends

> unrelated register in regcache.
>
> Until regmap/regcache is fixed, let's just use an adapted version of the
> old code that bypasses regmap altogether, and just sends out an SPI
> transaction.
>
> This is related to my commit 3f42b142ea1171967e40e10e4b0241c0d6d28d41
> ("serial: max310x: fix IO data corruption in batched operations") which

12 characters of the SHA-1 is enough (for now).

> introduced usage of regmap_noinc_write() to this driver. That commit is
> a fixup of commit 285e76fc049c4d32c772eea9460a7ef28a193802 ("serial:
> max310x: use regmap methods for SPI batch operations") which started

Ditto.

> using regmap_raw_write(), which was however also a wrong function.

Oh, cool! Here you used () :-)

> Fixes: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched =
operations")
> Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch o=
perations")
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

> To: Mark Brown <broonie@kernel.org>
> To: Cosmin Tanislav <cosmin.tanislav@analog.com>
> To: linux-serial@vger.kernel.org
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: linux-kernel@vger.kernel.org

"To:" lines are so unusual.

I have kinda "smart" script [1] that has a heuristics that works in
99.9+% cases well. Consider using it or taking an idea from it.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.=
sh

...

>  static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsig=
ned int len)
>  {
> -       struct max310x_one *one =3D to_max310x_port(port);
> -
> -       regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
> +       const u8 header =3D (port->iobase * 0x20 + MAX310X_THR_REG) | MAX=
310X_WRITE_BIT;
> +       struct spi_transfer xfer[] =3D {
> +               {
> +                       .tx_buf =3D &header,
> +                       .len =3D 1,
> +               },
> +               {
> +                       .tx_buf =3D txbuf,
> +                       .len =3D len,
> +               },
> +       };
> +       spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer=
));

Can you add a comment like FIXME explaining why regmap is not used
here, otherwise I will expect some clever guy to "fix" this again.

>  }
>
>  static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsign=
ed int len)
>  {
> -       struct max310x_one *one =3D to_max310x_port(port);
> -
> -       regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
> +       const u8 header =3D port->iobase * 0x20 + MAX310X_RHR_REG;
> +       struct spi_transfer xfer[] =3D {
> +               {
> +                       .tx_buf =3D &header,
> +                       .len =3D 1,
> +               },
> +               {
> +                       .rx_buf =3D rxbuf,
> +                       .len =3D len,
> +               },
> +       };
> +       spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer=
));

Ditto.

>  }

--=20
With Best Regards,
Andy Shevchenko
