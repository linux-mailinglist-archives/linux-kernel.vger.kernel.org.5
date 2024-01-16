Return-Path: <linux-kernel+bounces-27665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E496F82F3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852CAB23D40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CB1CD38;
	Tue, 16 Jan 2024 18:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN2kb8mB"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47781CD1B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428815; cv=none; b=NTASpZc4J1k5EWut7+3JVbDEFENBJymsL3EwkdS6e8aLUfP8+UUfbPf1uXxfbcXRRA91isTAaz1ovjrtNqEJ6oecM/GeajqNKjoyKoZn3T6V9whf1qjTHxGmzhlAnmrF8F0g3QTbSt0IS7QzQnJTKiO3tFy899h8FOYNj/OYBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428815; c=relaxed/simple;
	bh=VuJdDQsi3mmyRqeinzNAGN5yeAy5DGs8zpA7Gnrei2w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=C//RH6PlqlUmsGqv5xDACDRsVXq8210Zeh/Z6pmH2U58JwPhpabiAxtFFy1ZMxB9b+nGp7iy3urvrVyXaDruDARThIuQomZ2qCpg6ZXeh7Vuc3oAi4DjjBGNEJQn/8CZCQ95yz2ag27IQ9mHKgMqCV+duLSoAgWW2Ebs5g1TJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KN2kb8mB; arc=none smtp.client-ip=209.85.166.176
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3606eb704edso43359725ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428813; x=1706033613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjIZbfBCvKCg1WSRzAw5p1veNjGXMCanGfKSk9xh9uU=;
        b=KN2kb8mBtcScJ7fOGhTyOOYrUghJvGm49zenor5IQP5MDYAvZwb1fTTF5LGBqr1WLZ
         UtnESJZaHbdUjmIitRY4XS4BcTeZ7xbWXE+cmukEGSTPevcakCADSY9tx/EywqBT56JV
         ov+rbcAMMdmmT5pKrpstCoz7pkNOJq5AMu3sqnyWULTIK+6bYHHcUMo44wRS4SWLsJSz
         Xoejz5ngnkNO/mU6LY/c58O5o0E4ir9XNBRwGGQzDCUbkfZYuqhrdlNU8Qraypa7g4Ui
         NcuwF3cIvBMmfX88238gECs3O5OfRFvNsRLOfpNACI+QZad40somCo+Cbr0C6moC5i5c
         m2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428813; x=1706033613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjIZbfBCvKCg1WSRzAw5p1veNjGXMCanGfKSk9xh9uU=;
        b=ea9W3RjXm6U0vU5JoIVuREqNqkALDPIVBOuyXfO99OCkoeo34ZXWL+71Ed2G+LQhV3
         yNBjippgfmUGUbMpRwl+8Hd9fhyYvTXyvaz6ZhSJLRJTRqdQaX58I6YgGXB5raoIC2A5
         VGn3ZY1he8GuYuqa+YP+/G5dRORldMoAHpQeW0+igbm6ZW0/5PgRvGUjgChaYoNTCSIT
         d9nUQoVqSLQZaJ5jJz2ym/RySlejb3kR68W4RO+XIQkQznjKAXKzv41TBmq8oJ7VRM+i
         9dhif6LUP9yEK4h08c3XebipaURb/X+7RGLaCZS96xI6beGeWlpkPFYFO6VSU+kOv1qg
         MHWw==
X-Gm-Message-State: AOJu0YyO/tyxDc6Oz/LdU00/0XjqA1u9XQeCM6mE+y9zn45B/q3y6hrN
	Iri3mHHVgr9GTxNWnq1JXXGjFMO0DdDCG6/zI74+FalcjzRKQg==
X-Google-Smtp-Source: AGHT+IHg5H35PYEEVlG5CAjQhp4Vgw+BUhaFLcX5a93zb87VvfJY7vry+G4Z8Xu/GiQMw/VBPGWw/29JhGAAebs2l4c=
X-Received: by 2002:a05:6e02:1248:b0:360:29f:b7a9 with SMTP id
 j8-20020a056e02124800b00360029fb7a9mr7406208ilq.3.1705428812938; Tue, 16 Jan
 2024 10:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-5-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 12:13:21 -0600
Message-ID: <CAPLW+4kMO=PMZn5Vntik6YYe+DnpYi7TEegG4D-EdGq2_ERwbQ@mail.gmail.com>
Subject: Re: [PATCH 04/18] tty: serial: samsung: sort headers alphabetically
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Sorting headers alphabetically helps locating duplicates,
> and makes it easier to figure out where to insert new headers.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/tty/serial/samsung_tty.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 74bc5151dad4..f37d6724bfe5 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -21,26 +21,27 @@
>   * BJD, 04-Nov-2004
>   */
>
> -#include <linux/dmaengine.h>
> +#include <linux/console.h>
> +#include <linux/clk.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/slab.h>
> +#include <linux/dmaengine.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> -#include <linux/ioport.h>
> -#include <linux/io.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/init.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_s3c.h>
> +#include <linux/slab.h>
>  #include <linux/sysrq.h>
> -#include <linux/console.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> -#include <linux/serial_core.h>
> -#include <linux/serial.h>
> -#include <linux/serial_s3c.h>
> -#include <linux/delay.h>
> -#include <linux/clk.h>
> -#include <linux/cpufreq.h>
> -#include <linux/of.h>
> +
>  #include <asm/irq.h>
>
>  /* UART name and device definitions */
> --
> 2.43.0.472.g3155946c3a-goog
>
>

