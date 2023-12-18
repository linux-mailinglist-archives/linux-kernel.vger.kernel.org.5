Return-Path: <linux-kernel+bounces-4450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C6817D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063181C22C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D076084;
	Mon, 18 Dec 2023 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTKrGbBO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D001949893
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso5094301a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702938879; x=1703543679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j775zdStwoFQYQMkXt4HFx0DeDqilzNZA8Ur98U7dD0=;
        b=HTKrGbBO62Vsui4T+upy9lZ5sFG28esvKaDUL6L8C1reRpssME/oOecWdQY/48xMOS
         haYs0Tb3gIGEHwWaidWj9aZQjWOVHj35yBPfacq1vtzHoUvEO0ydzw58NtyntkWdNh32
         ZMMjlmKo3Fzi0lFdFl4s+Vm3q3e9n1OFYs2KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702938879; x=1703543679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j775zdStwoFQYQMkXt4HFx0DeDqilzNZA8Ur98U7dD0=;
        b=qdI017G8KE9Ren6Heernq9TuxN/cuzpxSGVvGoApAUjjAIgYSGFe+fYL1liUvRylCR
         UqGrWKL22U3UvQtJnhQUA6JuVDJFxkehoQpodgZKADvBaSvWJUgb0PmfL/ZL7FoH/Hul
         nLD0Vcv6nJtfCgNVbTrD7ufTAAD9b/PcGu71Jk9wWdyv8EHbHYa4jCNJhZmyhjG0kvbO
         rXf0DyDlNQKyCdX7yZ2pzwfwgOf2qKPzuSDM9ArVrvGwChiSBKLQN5mkPiWN5WALO7qY
         9oAdusH5XnHCmMwOI3Fi9nudg5CldMX9em9TOh8MEHRul+HwUdZbIdWy/BLGOUj79OYa
         ovbA==
X-Gm-Message-State: AOJu0YyTO1f5UXX+4S5DyrFtvd8I8gUaUqaxuvW7+te1YXJ5dWj1xKko
	ZKhTQwk5SIEviWqIs/Geuune5oKzjhvBqTsoWSzFkGSk
X-Google-Smtp-Source: AGHT+IFRvgL5EJ89GRVPUVTLB10lchxswPvxxo+CEZKuXwMGv714rAn6wQodyQ2o8keXFQ5XRvN5zw==
X-Received: by 2002:a17:906:51d5:b0:a23:7578:94a1 with SMTP id v21-20020a17090651d500b00a23757894a1mr24696ejk.81.1702938879337;
        Mon, 18 Dec 2023 14:34:39 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709061d5800b00a2350a75dc0sm2130387ejh.207.2023.12.18.14.34.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:34:38 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1811a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:34:38 -0800 (PST)
X-Received: by 2002:a50:c307:0:b0:54c:9996:7833 with SMTP id
 a7-20020a50c307000000b0054c99967833mr22018edb.7.1702938878434; Mon, 18 Dec
 2023 14:34:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216173409.1264655-1-michael@amarulasolutions.com> <20231218073407.300982-1-michael@amarulasolutions.com>
In-Reply-To: <20231218073407.300982-1-michael@amarulasolutions.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 14:34:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VaDJSXt5kyfzZ=qv9ZHRNerHFs7izXZbgudvfcOThc_Q@mail.gmail.com>
Message-ID: <CAD=FV=VaDJSXt5kyfzZ=qv9ZHRNerHFs7izXZbgudvfcOThc_Q@mail.gmail.com>
Subject: Re: [PATCH V2] tty: serial: kgdboc: Fix 8250_* kgd over serial
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: daniel.thompson@linaro.org, gregkh@linuxfoundation.org, 
	jason.wessel@windriver.com, jirislaby@kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 17, 2023 at 11:34=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Check if port type is not PORT_UNKNOWN during poll_init.
> The kgdboc calls the tty_find_polling_driver that check
> if the serial is able to use poll_init. The poll_init calls
> the uart uart_poll_init that try to configure the uart with the
> selected boot parameters. The uart must be ready before setting
> parameters. Seems that PORT_UNKNOWN is already used by other
> functions in serial_core to detect uart status, so use the same
> to avoid to use it in invalid state.
>
> The crash happen for instance in am62x architecture where the 8250
> register the platform driver after the 8250 core is initialized.
>
> Follow the report crash coming from KGDB
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
> v1 -> v2:
>         - fix if condition during submission
>         - improve a bit the commit message
> RFC -> v1:
>         - refuse uart that has type PORT_UNKNOWN
>
> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not a total expert on this code, but this seems reasonable to me.
One nit is ${SUBJECT} should probably be "kgdb over serial" instead of
"kgd over serial"

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index f1348a509552..9b7ed4aac77a 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2633,7 +2633,7 @@ static int uart_poll_init(struct tty_driver *driver=
, int line, char *options)
>         mutex_lock(&tport->mutex);
>
>         port =3D uart_port_check(state);
> -       if (!port || !(port->ops->poll_get_char && port->ops->poll_put_ch=
ar)) {
> +       if (!port || port->type =3D=3D PORT_UNKNOWN || !(port->ops->poll_=
get_char && port->ops->poll_put_char)) {

Another slight nit is that the above line feels a little long,
clocking in at 110 columns. I know the 80 column limit isn't so firm
these days, but if it were me I'd split it across 2 lines.

-Doug

