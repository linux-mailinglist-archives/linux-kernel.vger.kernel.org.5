Return-Path: <linux-kernel+bounces-128595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DD895CE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8621F214F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7A15CD59;
	Tue,  2 Apr 2024 19:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+w9BqWg"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610915B98D;
	Tue,  2 Apr 2024 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086846; cv=none; b=h2/C0m9mTfoA0vODFCaMkt+Tze9Qog0NYiE49aECtW26aG2zqYwOXesXZlrPxpnqqRELg7Z2mPgKDzBwFg8XEd4y3eU7XgpMNJ1ywAPnKLxPAXeJlmm3jzlpH+P/W5wxwBjF2TCidxxKJZNnHpxZVsxhx1mvzTb2qtq2ilmNqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086846; c=relaxed/simple;
	bh=uyf/Pl8TfA3/sDo0PLePDpCjIGDzGYe1T2UiXjFKfhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDN/GyEzNApiP5Bzc9JU8yEvwIOP8COdNk/b6ygzyoReqVaLOQ38hILp3ghLn0Y7vptRBlqkwb6yN4RSsA+hkDAgG32Fp2efEhAvoK+dNJ5w5zYs42ds/NIgFw3SoA39A6coQNewjWDTXDm8qOYPeBqF1R33Z0zgr+fu50p4UIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+w9BqWg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4644bde1d4so753330266b.3;
        Tue, 02 Apr 2024 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086843; x=1712691643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFlszyiWnk5HTRYNcbVHpUgDW/C34zJ91mv8A40Foz8=;
        b=c+w9BqWgvc+om4ZXWgjAGUw9X8tQSrKNAzqfeiCgROSFonWeG9IX3Ovg//IZz3Y4gy
         yCk9b/cYj/2SnTPRIgEcDDMCOfYYiZOCFoJR/IKBNqgEsSABG4QCt2R60mWfbABjh2/X
         sznt3A/WYbzOc0VHqZFrt4l9wJm2FZpUr/dgT0z0OZfGyQNzJLG0UJErmn+D/EtHglPb
         40JP/nV9g59FK1xHJks0Nw8a8ZdKrARvGd/rHU45UM6KCOhHjswn/kZ9Af7GqLgKOdJD
         flcI20CxRC0GBvqBcwMUknd4MXBi5nn+CJszfxo1U9Q5nq3KSiXrigHI5tMeCbEsYlGO
         N+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086843; x=1712691643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFlszyiWnk5HTRYNcbVHpUgDW/C34zJ91mv8A40Foz8=;
        b=V7UdLQ+Icden5RfUHul70I3w0ZQHYZK38fVAoyoi8ssS31Opero6l7yXf+KnlbIHW2
         iz4Vzr3SHwFMLYMoxu3bMOZrbWuwx5ybhGQKA2ClEifXbdmWg8qY7nwPrCn8ODrMcCiN
         d3YkmWs8RYPANKLqw0HaXlF7EaWeV6f3XZA5yz6QrqIGuZLosNyNIPX8B8924oXmkiAA
         G3Dk7QYmy8iFxeE7vcgt9ssjR7YDne1BMTaDm0383DQIvMebFYJPcw71kr/h/e7uUBnC
         0FXz+v8si57qkZC9M+ay8FznCWMhqnJzdYXKOAR5JXge5r1WX1BTlZJC3JWWjlvZbB1X
         3v1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4NLTgh9ASYqC1nQjYD6ia+TqQzdexH+jTlK5YTVq1NhY/qSZTV+3gSr8C+fmqkHH33+nvroEE3S37jIFgpQT47UtRP6rnlkmRzl5iVsDGuvmLSA3Woqt0qNjf4aTVRLWkS3pwiV9Oo5eM
X-Gm-Message-State: AOJu0Yz1tzqrpIy5KtpnJGESh8A4nFy3q1wRd/DvYo2ZBAg5lyNzzDZI
	TgiboYtEXgSQvt+9tPS1boKUhvmfGThmD+OP220olQB2IzJSmWgtiBd96DCnMjodb2ay2eXOLbN
	3WFYm0USPADWTkCyrfy2g1Vqo1MU=
X-Google-Smtp-Source: AGHT+IHhe5CMOmVwSalChAbGoM0MlF5r97iJJx2O6zlFWmiGUpBUNF5mSVKS71RwkL5/0gCjNJJWw6saPU1v7QvCIyY=
X-Received: by 2002:a17:906:5782:b0:a4e:207e:b71 with SMTP id
 k2-20020a170906578200b00a4e207e0b71mr9204641ejq.6.1712086843139; Tue, 02 Apr
 2024 12:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com> <20240402174353.256627-4-hugo@hugovil.com>
In-Reply-To: <20240402174353.256627-4-hugo@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 22:40:07 +0300
Message-ID: <CAHp75VdZ5yYVx7Df7G4X4Y7ZvJ3LAdq=A0fVNzNfMcdywJC-dQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Split the common code from sc16is7xx driver and move the I2C and SPI bus
> parts into interface-specific source files.
>
> sc16is7xx becomes the core functions which can support multiple bus
> interfaces like I2C and SPI.
>
> No functional change intended.

..

> -config SERIAL_SC16IS7XX_CORE
> -       tristate
> -
>  config SERIAL_SC16IS7XX
>         tristate "SC16IS7xx serial support"
>         select SERIAL_CORE
> -       depends on (SPI_MASTER && !I2C) || I2C
> +       depends on SPI_MASTER || I2C

Is it?

>         help
>           Core driver for NXP SC16IS7xx serial ports.
>           Supported ICs are:
> @@ -1042,22 +1039,18 @@ config SERIAL_SC16IS7XX
>           drivers below.
>
>  config SERIAL_SC16IS7XX_I2C
> -       bool "SC16IS7xx for I2C interface"
> +       tristate "SC16IS7xx for I2C interface"
>         depends on SERIAL_SC16IS7XX
>         depends on I2C
> -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> -       select REGMAP_I2C if I2C
> -       default y
> +       select REGMAP_I2C
>         help
> -         Enable SC16IS7xx driver on I2C bus,
> -         enabled by default to support oldconfig.
> +         Enable SC16IS7xx driver on I2C bus.
>
>  config SERIAL_SC16IS7XX_SPI
> -       bool "SC16IS7xx for spi interface"
> +       tristate "SC16IS7xx for SPI interface"
>         depends on SERIAL_SC16IS7XX
>         depends on SPI_MASTER
> -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> -       select REGMAP_SPI if SPI_MASTER
> +       select REGMAP_SPI
>         help
>           Enable SC16IS7xx driver on SPI bus.

Hmm... What I was thinking about is more like dropping
 the SERIAL_SC16IS7XX and having I2C/SPI to select the core.

See many examples under drivers/iio on how it's done.

..

> +EXPORT_SYMBOL_GPL(sc16is74x_devtype);

Is it namespaced? Please make sure we are not polluting the global
namespace with these.

..

> +#ifndef _SC16IS7XX_H_
> +#define _SC16IS7XX_H_
> +
> +#include <linux/device.h>

Not used (by this file).

> +#include <linux/mod_devicetable.h>

> +#include <linux/regmap.h>

> +#include <linux/serial_core.h>

Not used.

> +#include <linux/types.h>

> +extern const struct of_device_id __maybe_unused sc16is7xx_dt_ids[];

No __maybe_unused. Just have it always be added.

> +const char *sc16is7xx_regmap_name(u8 port_id);
> +
> +unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id);
> +
> +int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *=
devtype,
> +                   struct regmap *regmaps[], int irq);

> +void sc16is7xx_remove(struct device *dev);

Will require forward declaration

#include ...

struct device;

> +#endif /* _SC16IS7XX_H_ */

..

> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

Follow the IWYU principle (include what you use).

..

> +               return dev_err_probe(&i2c->dev, -ENODEV, "Failed to match=
 device\n");

+ dev_printk.h

..

> +static int __init sc16is7xx_i2c_init(void)
> +{
> +       return i2c_add_driver(&sc16is7xx_i2c_driver);
> +}
> +module_init(sc16is7xx_i2c_init);
> +
> +static void __exit sc16is7xx_i2c_exit(void)
> +{
> +       i2c_del_driver(&sc16is7xx_i2c_driver);
> +}
> +module_exit(sc16is7xx_i2c_exit);

This is now module_i2c_driver().

..

> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SC16IS7xx I2C interface driver");

+ MODULE_IMPORT_NS()

..

> +++ b/drivers/tty/serial/sc16is7xx_spi.c

Similar/same comments as per i2c counterpart.

--=20
With Best Regards,
Andy Shevchenko

