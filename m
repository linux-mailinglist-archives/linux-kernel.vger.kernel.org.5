Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B844880DD77
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbjLKVjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjLKVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:39:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FA0D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:39:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1f0616a15bso555602366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702330750; x=1702935550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SySyhdl+LwK97eXIEdoblEzUW4l78p2e3ZeB9Nc8urE=;
        b=IZSYPBmkikLYZcFGlRfjfdupETlv+XM+Kdswn0h5mqIyN0JVVrpnV75OEi0jb6s3Zy
         zz+RtsGyqRxfIUXhz9sArX/LUGaRAQzk+Gu5lBYdjiMWq91fjamtQFRAuIzdgb/CbjQf
         8LthhEsyii8y6qo42Z6swezwypnfxnw8/UUP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702330750; x=1702935550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SySyhdl+LwK97eXIEdoblEzUW4l78p2e3ZeB9Nc8urE=;
        b=g3hfGApEFUfcO8w+KDsjRoG32JNVaHwE27nfMNxvhTXvpMDPUQLpbpI2Q9qSZ12xQL
         zt+xUMqp8oSFFpYIDMOWT/qYeGmfGZ4t0brK9N2HwzWSWcuwWSuFLnC3NbaOV44X359e
         ffJ4lepw5EJuWPTFrOmNxarkQL/Yy6lt4DFl4p1CvFWPik6OHSMYPGodQgsjnowPFGpK
         gdKktnhmH50NfFYNblMtdsIficsjtsf5oWmB5tvf4hYIYrb7Prmx5lbQpRPPof0UwD8T
         NVPU39oAK0b0bgQR9uiUY7uWbtuSNa/+xDnMbnLgAV6yZKGsVXgIwQ51RoChFwo/a0Hc
         9CIA==
X-Gm-Message-State: AOJu0YzMjlyyE7CaHGT+1YNC/qtC7mOjXhuebRxlbNQjbnhz14wLA8eP
        /Gtx8Pa9hh06NIUq/d2Vi2U9GSDV/J+cxlOQ5A6IDidc
X-Google-Smtp-Source: AGHT+IHJFHlsvmqlzTl6xehgkY4eh1vzDJj6ouGZm3BcPgtGiVGSFrfaD1cVIRQpKyo6++g8O0lrZg==
X-Received: by 2002:a17:906:8462:b0:a01:dc84:1658 with SMTP id hx2-20020a170906846200b00a01dc841658mr2672255ejc.4.1702330750234;
        Mon, 11 Dec 2023 13:39:10 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id tq26-20020a170907c51a00b00a1e8fa8b1f1sm5331470ejc.79.2023.12.11.13.39.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:39:10 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso4185e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:39:09 -0800 (PST)
X-Received: by 2002:a05:600c:1e27:b0:40b:5972:f56b with SMTP id
 ay39-20020a05600c1e2700b0040b5972f56bmr252603wmb.3.1702330749230; Mon, 11 Dec
 2023 13:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
In-Reply-To: <20231208212845.1679621-1-michael@amarulasolutions.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Dec 2023 13:38:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
Message-ID: <CAD=FV=WthrukuM5e6VH4wKH0CQ5k08A_g_Ehpo-NsouxxCiibw@mail.gmail.com>
Subject: Re: [RFC PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
To:     Michael Trimarchi <michael@amarulasolutions.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 8, 2023 at 1:28=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Use late_initcall_sync insted of module init to be sure that
> serial driver is really probed and get take handover from
> early driver.

Awesome that you used the earlycon driver to debug problems with
registering the normal driver! :-P


> The 8250 register the platform driver after
> the 8250 core is initialized. As shown by kdbg
>
> Thread 2 received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 1]
> _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/asm-=
generic/io.h:584
> 584             __raw_writeb(value, PCI_IOBASE + addr);
> (gdb) bt
>
> This section of the code is too early because in this case
> the omap serial is not probed
>
> Thread 2 received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 1]
> _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/asm-=
generic/io.h:584
> 584             __raw_writeb(value, PCI_IOBASE + addr);
> (gdb) bt
>
> Thread 2 received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 1]
> _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/asm-=
generic/io.h:584
> 584             __raw_writeb(value, PCI_IOBASE + addr);
> (gdb) bt
> 0  _outb (addr=3D<optimized out>, value=3D<optimized out>) at ./include/a=
sm-generic/io.h:584
> 1  logic_outb (value=3D0 '\000', addr=3D18446739675637874689) at lib/logi=
c_pio.c:299
> 2  0xffff80008082dfcc in io_serial_out (p=3D0x0, offset=3D16760830, value=
=3D0) at drivers/tty/serial/8250/8250_port.c:416
> 3  0xffff80008082fe34 in serial_port_out (value=3D<optimized out>, offset=
=3D<optimized out>, up=3D<optimized out>)
>     at ./include/linux/serial_core.h:677
> 4  serial8250_do_set_termios (port=3D0xffff8000828ee940 <serial8250_ports=
+1568>, termios=3D0xffff80008292b93c, old=3D0x0)
>     at drivers/tty/serial/8250/8250_port.c:2860
> 5  0xffff800080830064 in serial8250_set_termios (port=3D0xfffffbfffe80000=
0, termios=3D0xffbffe, old=3D0x0)
>     at drivers/tty/serial/8250/8250_port.c:2912
> 6  0xffff80008082571c in uart_set_options (port=3D0xffff8000828ee940 <ser=
ial8250_ports+1568>, co=3D0x0, baud=3D115200, parity=3D110, bits=3D8, flow=
=3D110)
>     at drivers/tty/serial/serial_core.c:2285
> 7  0xffff800080828434 in uart_poll_init (driver=3D0xfffffbfffe800000, lin=
e=3D16760830, options=3D0xffff8000828f7506 <config+6> "115200n8")
>     at drivers/tty/serial/serial_core.c:2656
> 8  0xffff800080801690 in tty_find_polling_driver (name=3D0xffff8000828f75=
00 <config> "ttyS2,115200n8", line=3D0xffff80008292ba90)
>     at drivers/tty/tty_io.c:410
> 9  0xffff80008086c0b0 in configure_kgdboc () at drivers/tty/serial/kgdboc=
.c:194
> 10 0xffff80008086c1ec in kgdboc_probe (pdev=3D0xfffffbfffe800000) at driv=
ers/tty/serial/kgdboc.c:249
> 11 0xffff8000808b399c in platform_probe (_dev=3D0xffff000000ebb810) at dr=
ivers/base/platform.c:1404
> 12 0xffff8000808b0b44 in call_driver_probe (drv=3D<optimized out>, dev=3D=
<optimized out>) at drivers/base/dd.c:579
> 13 really_probe (dev=3D0xffff000000ebb810, drv=3D0xffff80008277f138 <kgdb=
oc_platform_driver+48>) at drivers/base/dd.c:658
> 14 0xffff8000808b0d2c in __driver_probe_device (drv=3D0xffff80008277f138 =
<kgdboc_platform_driver+48>, dev=3D0xffff000000ebb810)
>     at drivers/base/dd.c:800
> 15 0xffff8000808b0eb8 in driver_probe_device (drv=3D0xfffffbfffe800000, d=
ev=3D0xffff000000ebb810) at drivers/base/dd.c:830
> 16 0xffff8000808b0ff4 in __device_attach_driver (drv=3D0xffff80008277f138=
 <kgdboc_platform_driver+48>, _data=3D0xffff80008292bc48)
>     at drivers/base/dd.c:958
> 17 0xffff8000808ae970 in bus_for_each_drv (bus=3D0xfffffbfffe800000, star=
t=3D0x0, data=3D0xffff80008292bc48,
>     fn=3D0xffff8000808b0f3c <__device_attach_driver>) at drivers/base/bus=
.c:457
> 18 0xffff8000808b1408 in __device_attach (dev=3D0xffff000000ebb810, allow=
_async=3Dtrue) at drivers/base/dd.c:1030
> 19 0xffff8000808b16d8 in device_initial_probe (dev=3D0xfffffbfffe800000) =
at drivers/base/dd.c:1079
> 20 0xffff8000808af9f4 in bus_probe_device (dev=3D0xffff000000ebb810) at d=
rivers/base/bus.c:532
> 21 0xffff8000808ac77c in device_add (dev=3D0xfffffbfffe800000) at drivers=
/base/core.c:3625
> 22 0xffff8000808b3428 in platform_device_add (pdev=3D0xffff000000ebb800) =
at drivers/base/platform.c:716
> 23 0xffff800081b5dc0c in init_kgdboc () at drivers/tty/serial/kgdboc.c:29=
2
> 24 0xffff800080014db0 in do_one_initcall (fn=3D0xffff800081b5dba4 <init_k=
gdboc>) at init/main.c:1236
> 25 0xffff800081b0114c in do_initcall_level (command_line=3D<optimized out=
>, level=3D<optimized out>) at init/main.c:1298
> 26 do_initcalls () at init/main.c:1314
> 27 do_basic_setup () at init/main.c:1333
> 28 kernel_init_freeable () at init/main.c:1551
> 29 0xffff8000810271ec in kernel_init (unused=3D0xfffffbfffe800000) at ini=
t/main.c:1441
> 30 0xffff800080015e80 in ret_from_fork () at arch/arm64/kernel/entry.S:85=
7
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  drivers/tty/serial/kgdboc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb164005..7f8364507f55 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -622,7 +622,7 @@ console_initcall(kgdboc_earlycon_late_init);
>
>  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>
> -module_init(init_kgdboc);
> +late_initcall_sync(init_kgdboc);

While I'm not denying that you hit a bug, I don't think this is the
correct fix. The way it's supposed to work is:

1. init_kgdboc() runs and registers the singleton kgdb "platform driver".

2. The platform driver's probe function, kgdboc_probe(), runs and
checks to see if the console is ready by looking at the return value
of configure_kgdboc(). If it's ready then we're good to go. If it's
not ready then we defer.

So I think the bug here is that somehow the console looks "ready"
(because tty_find_polling_driver() can find it) but it isn't actually
ready yet (because it crashes). That's what you need to fix.

I'll note that, in the past, I've definitely used kgdb on 8250-based
UARTs. Is your hardware somehow special or is this a regression?

-Doug
