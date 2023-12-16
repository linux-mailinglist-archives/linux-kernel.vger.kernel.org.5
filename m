Return-Path: <linux-kernel+bounces-2295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F59815AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665FB1F23CBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5C30D15;
	Sat, 16 Dec 2023 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZugbDB4/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3A30CFA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336445a2749so1330572f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702748054; x=1703352854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcNKbo+ErH20rVL2cPgRZ8ez+d9bV/DiPHkp7E+gUxc=;
        b=ZugbDB4/bxYHVvtkuVu7xvBaxs642sz4xxaeUCwWKO3BvvhwIPNbHhRjBWjxqsNyYP
         Yzvrl9M+fUarGq4WYmkfMDoTD+npFt+uby4unl6yV98K+wv0Qj9ks/3YlbAkAqLN9BTL
         ycEWOjrIueaBKuLIhdzzo6oaYAf0W+u+wJkR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702748054; x=1703352854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcNKbo+ErH20rVL2cPgRZ8ez+d9bV/DiPHkp7E+gUxc=;
        b=ofSY+a9eB7JMUWVM/Fe/3YL1audqzue3M4fyK68MgBiq94mbDXBcX1/w8Fhvg5fBWJ
         BZkTPuSdvm1efE1IlBNK4IWmdzFiC51Zi0j+ss0HHEbfbsiH8qtGIVIDQwEXPjOJvNEs
         54+i+mP6sheJkncoKe3IYMV+iW926gSFDNXO3+ab4ouFbu+qovolPATnCH15PB/P79lJ
         YgXNwKQ6gDiq4xPgB8q9dJkzXQv5qjxE/4v7jzpuhGmCP+6olyl7JOKoeH5aTTXeGuFy
         tgssj6nhXSWNp831enhxUkT3rsHlzMPqoL3uAb4coFWlnMinvoogyX7R3HYye4vtzABj
         qfMw==
X-Gm-Message-State: AOJu0YysMCst9KsuJNQ4mbZoHZ1fNYQHbkSkAR073KwDY5fsOFtXoEv0
	SCmn1Xjb980O4Ys28+jdwrErpvdgHhY5IoLeZnzbgq9U
X-Google-Smtp-Source: AGHT+IHq3H6OGMJVaIZIpP6diKAW2HYqaT5XUdbPkD58wkXQjJ0cnr7zH+XWbSPmTKbH9CWAIbG0wQ==
X-Received: by 2002:adf:f551:0:b0:336:5e1d:bac0 with SMTP id j17-20020adff551000000b003365e1dbac0mr723165wrp.4.1702748053546;
        Sat, 16 Dec 2023 09:34:13 -0800 (PST)
Received: from panicking.QSD (net-91-81-8-146.cust.vodafonedsl.it. [91.81.8.146])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d5151000000b003365e685102sm2082491wrt.29.2023.12.16.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 09:34:13 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: michael@amarulasolutions.com
Cc: daniel.thompson@linaro.org,
	dianders@chromium.org,
	gregkh@linuxfoundation.org,
	jason.wessel@windriver.com,
	jirislaby@kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: kgdboc: Fix 8250_* kgd over serial
Date: Sat, 16 Dec 2023 18:34:09 +0100
Message-Id: <20231216173409.1264655-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208212845.1679621-1-michael@amarulasolutions.com>
References: <20231208212845.1679621-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if port type is not PORT_UNKNOWN in the serial driver.
The kgdboc calls the tty_find_polling_driver that check
if the serial is able to use poll_init. The poll_init calls
the uart uart_poll_init that try to configure the uart with the
selected parameters. The uart must be ready and we can check it
using type as in other tty_io functions.

The crash happen for instance in am62x architecture where the 8250
register the platform driver after the 8250 core is initialized.

As shown by kdbg the iobase and membase is not configured

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt

This section of the code is too early because in this case
the omap serial is not probed

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt

Thread 2 received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
_outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
584		__raw_writeb(value, PCI_IOBASE + addr);
(gdb) bt
0  _outb (addr=<optimized out>, value=<optimized out>) at ./include/asm-generic/io.h:584
1  logic_outb (value=0 '\000', addr=18446739675637874689) at lib/logic_pio.c:299
2  0xffff80008082dfcc in io_serial_out (p=0x0, offset=16760830, value=0) at drivers/tty/serial/8250/8250_port.c:416
3  0xffff80008082fe34 in serial_port_out (value=<optimized out>, offset=<optimized out>, up=<optimized out>)
    at ./include/linux/serial_core.h:677
4  serial8250_do_set_termios (port=0xffff8000828ee940 <serial8250_ports+1568>, termios=0xffff80008292b93c, old=0x0)
    at drivers/tty/serial/8250/8250_port.c:2860
5  0xffff800080830064 in serial8250_set_termios (port=0xfffffbfffe800000, termios=0xffbffe, old=0x0)
    at drivers/tty/serial/8250/8250_port.c:2912
6  0xffff80008082571c in uart_set_options (port=0xffff8000828ee940 <serial8250_ports+1568>, co=0x0, baud=115200, parity=110, bits=8, flow=110)
    at drivers/tty/serial/serial_core.c:2285
7  0xffff800080828434 in uart_poll_init (driver=0xfffffbfffe800000, line=16760830, options=0xffff8000828f7506 <config+6> "115200n8")
    at drivers/tty/serial/serial_core.c:2656
8  0xffff800080801690 in tty_find_polling_driver (name=0xffff8000828f7500 <config> "ttyS2,115200n8", line=0xffff80008292ba90)
    at drivers/tty/tty_io.c:410
9  0xffff80008086c0b0 in configure_kgdboc () at drivers/tty/serial/kgdboc.c:194
10 0xffff80008086c1ec in kgdboc_probe (pdev=0xfffffbfffe800000) at drivers/tty/serial/kgdboc.c:249
11 0xffff8000808b399c in platform_probe (_dev=0xffff000000ebb810) at drivers/base/platform.c:1404
12 0xffff8000808b0b44 in call_driver_probe (drv=<optimized out>, dev=<optimized out>) at drivers/base/dd.c:579
13 really_probe (dev=0xffff000000ebb810, drv=0xffff80008277f138 <kgdboc_platform_driver+48>) at drivers/base/dd.c:658
14 0xffff8000808b0d2c in __driver_probe_device (drv=0xffff80008277f138 <kgdboc_platform_driver+48>, dev=0xffff000000ebb810)
    at drivers/base/dd.c:800
15 0xffff8000808b0eb8 in driver_probe_device (drv=0xfffffbfffe800000, dev=0xffff000000ebb810) at drivers/base/dd.c:830
16 0xffff8000808b0ff4 in __device_attach_driver (drv=0xffff80008277f138 <kgdboc_platform_driver+48>, _data=0xffff80008292bc48)
    at drivers/base/dd.c:958
17 0xffff8000808ae970 in bus_for_each_drv (bus=0xfffffbfffe800000, start=0x0, data=0xffff80008292bc48,
    fn=0xffff8000808b0f3c <__device_attach_driver>) at drivers/base/bus.c:457
18 0xffff8000808b1408 in __device_attach (dev=0xffff000000ebb810, allow_async=true) at drivers/base/dd.c:1030
19 0xffff8000808b16d8 in device_initial_probe (dev=0xfffffbfffe800000) at drivers/base/dd.c:1079
20 0xffff8000808af9f4 in bus_probe_device (dev=0xffff000000ebb810) at drivers/base/bus.c:532
21 0xffff8000808ac77c in device_add (dev=0xfffffbfffe800000) at drivers/base/core.c:3625
22 0xffff8000808b3428 in platform_device_add (pdev=0xffff000000ebb800) at drivers/base/platform.c:716
23 0xffff800081b5dc0c in init_kgdboc () at drivers/tty/serial/kgdboc.c:292
24 0xffff800080014db0 in do_one_initcall (fn=0xffff800081b5dba4 <init_kgdboc>) at init/main.c:1236
25 0xffff800081b0114c in do_initcall_level (command_line=<optimized out>, level=<optimized out>) at init/main.c:1298
26 do_initcalls () at init/main.c:1314
27 do_basic_setup () at init/main.c:1333
28 kernel_init_freeable () at init/main.c:1551
29 0xffff8000810271ec in kernel_init (unused=0xfffffbfffe800000) at init/main.c:1441
30 0xffff800080015e80 in ret_from_fork () at arch/arm64/kernel/entry.S:857

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
RFC -> v1:
	- refuse uart that has type PORT_UNKNOWN
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f1348a509552..aa07eb894a6e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2633,7 +2633,7 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	mutex_lock(&tport->mutex);
 
 	port = uart_port_check(state);
-	if (!port || !(port->ops->poll_get_char && port->ops->poll_put_char)) {
+	if (!port || port->type = PORT_UNKNOWN || !(port->ops->poll_get_char && port->ops->poll_put_char)) {
 		ret = -1;
 		goto out;
 	}
-- 
2.40.1


