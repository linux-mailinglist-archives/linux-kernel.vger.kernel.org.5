Return-Path: <linux-kernel+bounces-136387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8E89D385
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE61EB244E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E277CF17;
	Tue,  9 Apr 2024 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWxf69rx"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BBD7CF37;
	Tue,  9 Apr 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648680; cv=none; b=GEZVLha1Rc4yQBoZxB5tLCSPodZu4rhj3cBewBbYxZzW0Kytdh/2FQJWjA5ddUFg4j69IusgPuf40DGAfykiHbChvY5KLX8GWuOKICeS215IpLqVgrruAc0phYY3NiiankgRX95bfko4OkavNxXH0bd5QvOA1tRdSQczvdHm/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648680; c=relaxed/simple;
	bh=eN/Kbm8JIvI8VT1ekgbsIrtHERUOe+RG1vZ3KjwFC1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mUxx1jy3m7liEX1Xcn+X29Y+zxLyIeyEiYUY9Rt0HcfehOJEB09mRz2+2XKukVUHzs2WmKFySy8Zk5rqZXVxkrTfDjLVNBfJey8/4Ix0v4JEbvNYgGr4SCFD57QfHZgN4Bn80qlLQ03QoZVdGn8RqBYgFdvhxaWCSf7ymUIAfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWxf69rx; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22200c78d4fso3048180fac.1;
        Tue, 09 Apr 2024 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712648677; x=1713253477; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glJ/raStn7JcLXqAKXJOlY+XSeBuKwLManaPf/wnEcA=;
        b=EWxf69rxCOCMFczHzSkVaFxG8HOerO1lV17k75QNHFib6HpPIUTwgnQKepHJt/bffc
         yLb6nXQCfifV0v0Y++pfGnx5QRMCppe/Ayq1Jpi6o8kTQwvEfZnA8H794UNk78I6ueFt
         JTtEG9uY1jjajznfe16Hri201KBmtlmMniKvzkbqo4Rc+2SHli/6vv8mDWZa+85LihjR
         9kdto/IXdC8Rg+s2b4jaEgh05KSX2zyvGYCEc11fERPxH15YK+Ce1hrSzURLRthe8PFz
         N6QkztDQW6eNeJG6VuBGDk39wz1xtDFu3NQ3DggWV1KVFmJdIbyXXgKlj5nL/batXLYe
         17zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648677; x=1713253477;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glJ/raStn7JcLXqAKXJOlY+XSeBuKwLManaPf/wnEcA=;
        b=R7gO6NEq10NYgMddBrYNxaHSvi7LBQbOfLkFH9YSVBBRWr8LpHQIb7P7uo04IoFhR3
         jg7WwAqieyHcbVT8qJztQ0gJuuEu62qQot7DxTHEwmV5Yl7vEafCXG6pAKhmFeaBEJzh
         A6PLpnUckekrUSSLTM91H089m0gpv7Mzq/8vasLviq3BKiMYUuhP0JuKukPTze7rsrR6
         0zHhC6voHXpGjR2WkDTljW9x8XXo9Szu2+ccA55zR+P4IvtmTBseUFUZOZ363dHTaaFC
         9cOz1P4J4/whDqM6Arl5BdhwRH01Dp+xZ3KJhef+HhRzhlxrUFxkyRttRPZfMkdTzsD/
         7NMw==
X-Forwarded-Encrypted: i=1; AJvYcCX5XUxK0z4x6+1oMJqEzq2g7DMFdYV8J+ul9siI7iHxWlnu9L075D4t/zg1CllggCs5RKHgeqUPZzrdHwf0u5Etn/J1ZtC8BHqoKSUNND0WkKLwKXx7lv+wUsHYKMYyPHBO0bc1bfoHsCe9
X-Gm-Message-State: AOJu0YzcVqKKUHKIS3CAP4Y76OO30RrMwhdnVNKeMvOOTBs/xTGSg0Kk
	u4tipymCXXSS/fwUghIYnOWVivili7NBSEMCReSeJeY2MZg5mJhKh/kl28e0ui4=
X-Google-Smtp-Source: AGHT+IGhrVloGDWsURG4uDQX4JDIXqR4evFudZXRp9MphChgDw9agxSF7vVEk1ECPWIwoQcX1ZgS3w==
X-Received: by 2002:a05:6870:65a5:b0:22a:6c9a:ece8 with SMTP id fp37-20020a05687065a500b0022a6c9aece8mr11297334oab.21.1712648677600;
        Tue, 09 Apr 2024 00:44:37 -0700 (PDT)
Received: from localhost.localdomain ([43.159.199.34])
        by smtp.gmail.com with ESMTPSA id r16-20020aa79890000000b006ed0f719a5fsm5809065pfl.81.2024.04.09.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:44:37 -0700 (PDT)
From: Guanbing Huang <albanhuang0@gmail.com>
To: gregkh@linuxfoundation.org,
	andriy.shevchenko@intel.com,
	rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org,
	tony@atomide.com,
	john.ogness@linutronix.de,
	yangyicong@hisilicon.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	lvjianmin@loongson.cn,
	albanhuang@tencent.com,
	tombinfan@tencent.com
Subject: [PATCH v6 3/3] serial: 8250_pnp: Support configurable reg shift property
Date: Tue,  9 Apr 2024 15:44:23 +0800
Message-Id: <3049b47a51fb403d6b1e97e63fcae70e1a810963.1712646750.git.albanhuang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1712646750.git.albanhuang@tencent.com>
References: <cover.1712646750.git.albanhuang@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Guanbing Huang <albanhuang@tencent.com>

The 16550a serial port based on the ACPI table requires obtaining the
reg-shift attribute. In the ACPI scenario, If the reg-shift property
is not configured like in DTS, the 16550a serial driver cannot read or
write controller registers properly during initialization.

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Bing Fan <tombinfan@tencent.com>
Tested-by: Linheng Du <dylanlhdu@tencent.com>
---
v5 -> v6: fix the issue that the cover letter is not chained with the patch series
v4 -> v5: modify to obtain the value of mapsize through the pnp_mem_len function,
          add annotations for the iotype variable, delete excess uart.port.flags operation
v3 -> v4: dependent on two pre patches: "pnp: Add dev_is_pnp() macro" and
          "serial: 8250_port: Add support of pnp irq to  __uart_read_properties()",
          the iotype is reserved, the mapsize is initialized, fix the UPF_SHARE_IRQ
	  flag, check for IRQ being absent
v2 -> v3: switch to use uart_read_port_properties(), change "Signed-off-by" to "Reviewed-by" and "Tested-by"
v1 -> v2: change the names after "Signed off by" to the real names

 drivers/tty/serial/8250/8250_pnp.c | 40 +++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 1974bbadc975..8f72a7de1d1d 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -435,6 +435,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
 	int ret, line, flags = dev_id->driver_data;
+	unsigned char iotype;
 
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
@@ -443,37 +444,46 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 	}
 
 	memset(&uart, 0, sizeof(uart));
-	if (pnp_irq_valid(dev, 0))
-		uart.port.irq = pnp_irq(dev, 0);
 	if ((flags & CIR_PORT) && pnp_port_valid(dev, 2)) {
 		uart.port.iobase = pnp_port_start(dev, 2);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_port_valid(dev, 0)) {
 		uart.port.iobase = pnp_port_start(dev, 0);
-		uart.port.iotype = UPIO_PORT;
+		iotype = UPIO_PORT;
 	} else if (pnp_mem_valid(dev, 0)) {
 		uart.port.mapbase = pnp_mem_start(dev, 0);
-		uart.port.iotype = UPIO_MEM;
+		uart.port.mapsize = pnp_mem_len(dev, 0);
+		iotype = UPIO_MEM;
 		uart.port.flags = UPF_IOREMAP;
 	} else
 		return -ENODEV;
 
-	dev_dbg(&dev->dev,
-		 "Setup PNP port: port %#lx, mem %#llx, irq %u, type %u\n",
-		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
-		 uart.port.irq, uart.port.iotype);
+	uart.port.uartclk = 1843200;
+	uart.port.dev = &dev->dev;
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+
+	ret = uart_read_port_properties(&uart.port);
+	/* no interrupt -> fall back to polling */
+	if (ret == -ENXIO)
+		ret = 0;
+	if (ret)
+		return ret;
+
+	/*
+	 * The previous call may not set iotype correctly when reg-io-width
+	 * property is absent and it doesn't support IO port resource.
+	 */
+	uart.port.iotype = iotype;
 
 	if (flags & CIR_PORT) {
 		uart.port.flags |= UPF_FIXED_PORT | UPF_FIXED_TYPE;
 		uart.port.type = PORT_8250_CIR;
 	}
 
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
-		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
-	uart.port.dev = &dev->dev;
+	dev_dbg(&dev->dev,
+		 "Setup PNP port: port %#lx, mem %#llx, size %#llx, irq %u, type %u\n",
+		 uart.port.iobase, (unsigned long long)uart.port.mapbase,
+		 (unsigned long long)uart.port.mapsize, uart.port.irq, uart.port.iotype);
 
 	line = serial8250_register_8250_port(&uart);
 	if (line < 0 || (flags & CIR_PORT))
-- 
2.17.1


