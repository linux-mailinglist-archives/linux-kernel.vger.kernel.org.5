Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91A17DA1F3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346482AbjJ0UtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0UtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:49:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B991B6;
        Fri, 27 Oct 2023 13:49:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E95153200996;
        Fri, 27 Oct 2023 16:49:04 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 16:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698439744; x=1698526144; bh=dtOld/txYEOwF3Z5A2XVbShO6PkSrUylLU0
        +N0ne2fI=; b=YI7V5BNQfndHxfn7jpabB9fYqmIj+CRgL4ysUxV4nYvbo+5zVCW
        +9txpKvXCf2MIBhuP29eBKTgByfwLd24YCLCtpLXzsju0A/E+slD2B4er9T0Je4y
        6fGgiQEF5zPMOgALq/DnyMw7GT2KNJLeiRPdHeg+gIYx3s6+aFvaMZTB1jbzaOUg
        nugSnN9YJeBHRBDgE4ykcBtUZ/1s9HdoC+/VPlDYBZFgfoAi1eNqsQcsk7R9vN5A
        JDz21zIlE5Cv6iMvUgjdvZn1wHnRynCIJ9c+Ct+9JQTXTIAEez25cQ8kpQ4mZwiZ
        4D4fl9hj+dnmzSEaFWZGXEWfb0fXT2leWlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698439744; x=1698526144; bh=dtOld/txYEOwF3Z5A2XVbShO6PkSrUylLU0
        +N0ne2fI=; b=YaTDunpVdvmvwSu7OfYWGjPB0iVxw+pZu8jN6KzAcmHfrBdmh7C
        IN1WadDtE3ay1uxZ+yvqrQk1FzQErkaXzyX4rO0p7vPgRlh/Q8M8p5kyHgr90+kv
        6+WN01EqXXm5NjBYpSP0fbHrrwC2VFQQsAJnMJLt8V+4fOEdbyqBPsoBqs82Oxuw
        4EeLECVPQHqXh7BDooGBfuqX/olIwuwRStzx0XQ/sA6XWO/DBN5Ol3NLezoXZYuj
        qYG5MUaVMlkAKyuS/vGohmPUpsk23gQHQ6vO6b3JpCh6hC2R9AEkScWJ8sn7t5J4
        ZtLyzHgwnmbULT8pSNNpt7xLz7cP+s4U6TA==
X-ME-Sender: <xms:QCI8ZUN9Y6scGzHKDTV_4XERCJ7c4dnWrS_zlbQbIQSwQopVYxlFXA>
    <xme:QCI8Za-joDeTMvv4l3Bm8RI2tf8O1ZnV5cQawY2LCMFPAXRE-Pynipp2NZalti64A
    PWVXQ9Y6QZXI8gQ4EE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:QCI8ZbRDKaF-fy8xo4u3Iga4END5S3_jR3tAED7QxBdc4Dvl0Gp-rQ>
    <xmx:QCI8Zcv3OHjULDmtL01KgJoMOgJPual9Gx9XUG7GErEVuJ2ip9RBAw>
    <xmx:QCI8ZcenSRTI_FSViz_Lj1cbqmFd0NVuhTDvl1v9G7A6p8z-_dLVGw>
    <xmx:QCI8ZU4Qajc6nRZPYbhX0eBxUNBdowEMSaDEcQSc3xYM_UJ1u9Ydhw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3988636A0075; Fri, 27 Oct 2023 16:49:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <c6503877-b120-4685-9665-7d728b8fd760@app.fastmail.com>
In-Reply-To: <20231027182650.281405-8-jiaxun.yang@flygoat.com>
References: <20231027182650.281405-1-jiaxun.yang@flygoat.com>
 <20231027182650.281405-8-jiaxun.yang@flygoat.com>
Date:   Fri, 27 Oct 2023 21:48:44 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org
Subject: Re: [PATCH 3/3] serial: Add an earlycon driver for MIPS UHI semihosting
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B410=E6=9C=8827=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=887:26=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> UHI is MIPS's implementation of semihosting.
> Add an earlycon driver to help with debugging on boot.
>
> This driver is capable for print log using UHI's "Plog" or interact
> with KGDB using UHI's stdio function.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/tty/serial/Kconfig             | 13 ++++
>  drivers/tty/serial/Makefile            |  1 +
>  drivers/tty/serial/earlycon-mips-uhi.c | 85 ++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/tty/serial/earlycon-mips-uhi.c
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index bdc568a4ab66..04c62c6b45cd 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -85,6 +85,19 @@ config SERIAL_EARLYCON_SEMIHOST
>  	  This is enabled with "earlycon=3Dsmh" on the kernel command line.
>  	  The console is enabled when early_param is processed.
>=20
> +config SERIAL_EARLYCON_UHI

^ Oops there is a symbol name mismatch, will fix in v2.

Sorry for the noise.

Thanks
- Jiaxun

> +	bool "Early console using MIPS UHI semihosting"
> +	depends on MIPS
> +	select SERIAL_CORE
> +	select SERIAL_CORE_CONSOLE
> +	select SERIAL_EARLYCON
> +	help
> +	  Support for early debug console using UHI semihosting.
> +	  This enables the console before standard serial driver is probed.
> +	  This is enabled with "earlycon=3Duhi" or "earlycon=3Duhi_stdio" on=
 the
> +	  kernel command line.
> +	  The console is enabled when early_param is processed.
> +
>  config SERIAL_EARLYCON_RISCV_SBI
>  	bool "Early console using RISC-V SBI"
>  	depends on RISCV_SBI_V01
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index f6b8c220dcfb..ef5e9c87aea1 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -9,6 +9,7 @@ serial_base-y :=3D serial_core.o serial_base_bus.o=20
> serial_ctrl.o serial_port.o
>  obj-$(CONFIG_SERIAL_EARLYCON) +=3D earlycon.o
>  obj-$(CONFIG_SERIAL_EARLYCON_SEMIHOST) +=3D earlycon-semihost.o
>  obj-$(CONFIG_SERIAL_EARLYCON_RISCV_SBI) +=3D earlycon-riscv-sbi.o
> +obj-$(CONFIG_SERIAL_EARLYCON_MIPS_UHI) +=3D earlycon-mips-uhi.o
>=20
>  # These Sparc drivers have to appear before others such as 8250
>  # which share ttySx minor node space.  Otherwise console device
> diff --git a/drivers/tty/serial/earlycon-mips-uhi.c=20
> b/drivers/tty/serial/earlycon-mips-uhi.c
> new file mode 100644
> index 000000000000..002bb2c37064
> --- /dev/null
> +++ b/drivers/tty/serial/earlycon-mips-uhi.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MIPS UHI semihosting based earlycon
> + *
> + * Copyright (C) 2023 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/console.h>
> +#include <linux/init.h>
> +#include <linux/serial_core.h>
> +#include <asm/uhi.h>
> +
> +static int stdin_fd =3D -1;
> +static int stdout_fd =3D -1;
> +
> +static void uhi_plog_write(struct console *con, const char *s,=20
> unsigned int n)
> +{
> +	uhi_plog(s, 0);
> +}
> +
> +static void uhi_stdout_write(struct console *con, const char *s,=20
> unsigned int n)
> +{
> +	if (stdout_fd < 0)
> +		return;
> +
> +	uhi_write(stdout_fd, s, n);
> +}
> +
> +#ifdef CONFIG_CONSOLE_POLL
> +static int uhi_stdin_read(struct console *con, char *s, unsigned int =
n)
> +{
> +	if (stdin_fd < 0)
> +		return 0;
> +
> +	return uhi_read(stdin_fd, s, n);
> +}
> +#endif
> +
> +static int uhi_stdio_fd_open(struct console *co, char *options)
> +{
> +	/*
> +	 * You have to open both stdin and stdout to get console work
> +	 * properly on some old CodeScape debugger.
> +	 */
> +	stdin_fd =3D uhi_open("/dev/stdin", UHI_O_RDONLY, 0);
> +	stdout_fd =3D uhi_open("/dev/stdout", UHI_O_WRONLY, 0);
> +
> +	return (stdin_fd < 0 || stdout_fd < 0) ? -ENODEV : 0;
> +}
> +
> +static int uhi_stdio_fd_close(struct console *co)
> +{
> +	int ret1 =3D 0, ret2 =3D 0;
> +
> +	if (stdin_fd >=3D 0)
> +		ret1 =3D uhi_close(stdin_fd);
> +	if (stdout_fd >=3D 0)
> +		ret2 =3D uhi_close(stdout_fd);
> +
> +	return (ret1 < 0 || ret2 < 0) ? -ENODEV : 0;
> +}
> +
> +static int
> +__init early_uhi_setup(struct earlycon_device *device, const char *op=
t)
> +{
> +	device->con->write =3D uhi_plog_write;
> +	return 0;
> +}
> +
> +static int
> +__init early_uhi_stdio_setup(struct earlycon_device *device, const=20
> char *opt)
> +{
> +
> +	device->con->setup =3D uhi_stdio_fd_open;
> +	device->con->exit =3D uhi_stdio_fd_close;
> +	device->con->write =3D uhi_stdout_write;
> +#ifdef CONFIG_CONSOLE_POLL
> +	device->con->read =3D uhi_stdin_read;
> +#endif
> +	return 0;
> +}
> +
> +EARLYCON_DECLARE(uhi, early_uhi_setup);
> +EARLYCON_DECLARE(uhi_stdio, early_uhi_stdio_setup);
> --=20
> 2.34.1

--=20
- Jiaxun
