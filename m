Return-Path: <linux-kernel+bounces-66728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1148560C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E431F21348
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833512C80F;
	Thu, 15 Feb 2024 11:02:05 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E912C803;
	Thu, 15 Feb 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994925; cv=none; b=W6Kp0hlsfUYghS8jD2R1YnS6TfUjAlcGup7LZSFJNcAb463hRH6jBHw4vYPRGdirwegagT7lk25VwG9VanjNOqne7ic23d1M6HUf9/K4i89GWx+BtbK+8ZjIn1u45n1N701Pds113McozWsAnPlORYiN2uGXHHswZaESoVoPEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994925; c=relaxed/simple;
	bh=Hm8P6oyenZi1eBAN/OYEEjXEBmdCYWOQryV6DrT4dG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6zOK0f9u8GJSMylU6a+9nsTwrofYJ3us/7bwLSpSwFi6dq97P2cfKLXhGn3DqwGkjdp8erSHxglMVUXPQghZmFMsKmTSY0LNdGRZ1z3MybR9o4E0RWLHqE1YIXBrrdfWlv9dnmJ55ZGYIXqRRNp353yb7XEeQOHAIm7KqjGV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60792653b94so7207997b3.3;
        Thu, 15 Feb 2024 03:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994921; x=1708599721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2t28MWrQY7W2xrmkJ0+2MqE764Vph7M/VElh1kErvI=;
        b=vwQyxUdgFU2pEm8C0wXUszuwAZKzfTR/npEJad27wvKl3HYYHcZEwW47dBMfgJSePB
         fNMzFhHdjzdBMYZEm753jr6nGR2UEU/K5N0A3+TuGiXMAxtxsg7U7QKoffwdK0RQXTVB
         gFO7ApP9zmwogmduUOBYFqtmiSXycGSdXQAwqk/wSoS3tKIcThiRRGEgrG3kl9tO7KjY
         v16fdh3VOji3be1IyDoCNAXf/pSz/ibP4HD21+jzcyLzYhGC2HmSJZ4ehVgfxKeo1fCg
         Uip5FE9zQvMrcadt2oxKpAyANNudsBH1bt3xOEcS0sGPnwHbybWvXrEklHNbNG8cVB7+
         s4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7se4Fa6lu5WbVJ+3yfHyuFLPC/eGeJMaMYK+p3qF/N8LZtDzW/1wLGyHwzq8VNohPD+dZVhwK6A0zpYutfJqV/75C2tUGe9cYS5z
X-Gm-Message-State: AOJu0Yz8IAziqXkiI3TSDg9V1ElY5dywEEjZweWHIyIl9Q0JrGNNOzoU
	jqjwaLJx2s5fgD0p0G+/x0uBsIlEu3B9r2DQrO1CcyvLq2NGpSZOfafvb9H8KvMJBw==
X-Google-Smtp-Source: AGHT+IFp/GUaVBX5zoCb3rmqVmvDAR+9wQUUZl43QSTZ+paxGWDoy+ekaDJYp4BvQJD2K89GA6zk0w==
X-Received: by 2002:a81:a743:0:b0:607:9cf8:931f with SMTP id e64-20020a81a743000000b006079cf8931fmr1151829ywh.6.1707994921347;
        Thu, 15 Feb 2024 03:02:01 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id t18-20020a81c252000000b006078c48a265sm193310ywg.6.2024.02.15.03.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 03:02:01 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60792653b94so7207757b3.3;
        Thu, 15 Feb 2024 03:02:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKI7tm2VPv3qye/uwdbsaZ0XY4xnDzzrOq2Np9woEkvG6jW3xP0V+6+yVBs0W/K2AA4jJJxuDBVMfzr4M8mPh939jJO3viX3Q7SeYR
X-Received: by 2002:a81:ae1a:0:b0:607:835b:8cac with SMTP id
 m26-20020a81ae1a000000b00607835b8cacmr1048601ywh.42.1707994920654; Thu, 15
 Feb 2024 03:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-16-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-16-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 12:01:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUM1o7bEaUdU=CmcJakZ4kMvWPTrBZG+s=eK3xdc9WRFA@mail.gmail.com>
Message-ID: <CAMuHMdUM1o7bEaUdU=CmcJakZ4kMvWPTrBZG+s=eK3xdc9WRFA@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] auxdisplay: Add driver for MAX695x 7-segment LED controllers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Add initial driver for the MAX6958 and MAX6959 7-segment LED
> controllers.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -187,6 +187,20 @@ config HT16K33
>           Say yes here to add support for Holtek HT16K33, RAM mapping 16*=
8
>           LED controller driver with keyscan.
>
> +config MAX6959
> +       tristate "Maxim MAX6958/6959 7-segment LED controller with keysca=
n"

I'd drop the "with keyscan" for now...

> +       depends on I2C
> +       select REGMAP_I2C
> +       select LINEDISP
> +       help
> +         If you say yes here you get support for the following Maxim chi=
ps
> +         (I2C 7-segment LED display controller with keyscan):
> +         - MAX6958
> +         - MAX6959 (debounce support)

s/debounce/input/

> +
> +         This driver can also be built as a module. If so, the module
> +         will be called max6959.

> --- /dev/null
> +++ b/drivers/auxdisplay/max6959.c

> +/* Defines */
> +#define MIN_BRIGHTNESS                 0x01
> +#define MAX_BRIGHTNESS                 0x40

Unused? (for now, until you add LED brightness support)

> +
> +struct max6959_priv {
> +       struct linedisp linedisp;
> +
> +       struct delayed_work work;
> +

IMHO these blank lines don't add any value.

> +       struct regmap *regmap;
> +};

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

