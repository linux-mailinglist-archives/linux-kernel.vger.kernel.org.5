Return-Path: <linux-kernel+bounces-50253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096084766A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043A21F257CC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB814C5A8;
	Fri,  2 Feb 2024 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qdj16sLU"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2A14AD2F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895706; cv=none; b=iwTIu7Udf1C8XcyIn2WO64mw4+3OJihrYg1EyMbCSkjwwwKHufEiyxOIgWoty066KCIfmT52nSEisiAmkhE4cf5WsCWNPpkLR/jrVKOjASu+s3lafV5s60N2ISnRrIPc3xlE1uRWhdary4dWK4TTF+gC1Mhv8NEnJ4OezyK9/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895706; c=relaxed/simple;
	bh=eu87qWyaCqCwnJ2sVE3adNP4GW3OSLM7PQC7Mv20M54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYfvMF1Dg3rlCxCsVlQ03l5pqDmR5iSUQermdcehvrX6dXCaclntIwDEu6hip8x+e45nEe+uPC1vRPQa89Hn3+N1ucj1EX0S+/89LA1NWn0AFMMXiWhwiO43l7WDEuFKSE6ZaSbH9z9NHRUMpaG9qDEz3dsvB8Sn2UuLaqMT4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qdj16sLU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6041c7aa418so19993347b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706895703; x=1707500503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxj2OxF2tKrpIUq+UtFX2EYPlsFE5Q6qUnNhW/MIt3w=;
        b=Qdj16sLU9H9ljl2jwX+fQhhDY5X6JydV/fCOGN55bQ48i1rfSACdGkMq0JYNdjiJfZ
         yFGiA4KW3TggLF1zmqCOduCfCb21KjTXzJQ/kCNYljgypWP/fGyaROE5WS4Sp611MWqY
         q+6OKpCd0JBKsL+kTi7ffthXUOEQ6gfkgIiqHp4NuoVymSEMYV3jW1xFNNdooBI6Vs8r
         HnI43k2yUpR1yWYraRULZPTV2e85cytSjWXSUfqITGrJ75hK7h0Gh8QebGOujOjXEUhM
         wFZvUUU6lOO2dmEkPQKCelJL0k71LPvtx8cqUx0j3QGh7xlgboXu6vI3xt/6bi2Wfaba
         3GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895703; x=1707500503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxj2OxF2tKrpIUq+UtFX2EYPlsFE5Q6qUnNhW/MIt3w=;
        b=icd/fWMomwPUWCetBSDnfw2QEht8p5RRCeoJSXGRirOjE8qAuvCATQXaLJmr0nm6JA
         x8Nmr+f7kpOsaAh8RmOuFVWZOWa7FoXRbkC5UPRtAnQlIeFyDadZ5tHeudD9gT1Ztvog
         ZlADJRk7Cn3iKOFM71taV3Z48UlWel/gCqh1JRniCdRJcjaVtlZad17Tw+2N0fReM1bu
         l4inUzNa/D6I2XZ9TeaVu5GQPFGQuQSHPxbXlKjJhy55CjQEr51/BMu3e/nzsltxHfYY
         raNuCQ0r/d5v2fqNkewTzqy5QoYzL/rvaoPmZWzjMwikFSDucf89pjaAQYlwGANujyS0
         PyJw==
X-Gm-Message-State: AOJu0Yzl8kDGuIXhvuRCTw1QeaXJV+C6fy9x1bWyzPCtJEzedXDp//YY
	J3dFG8g6yzB5vo59YrkvU81FeuZGnrUoCdo7t4moQzO5VM9nEyIiUzBjporVo86d7y5g0r92xO0
	n0nhFMkDycxAYnZXQ1wFCJiGTlNfazzDSaPkLZw==
X-Google-Smtp-Source: AGHT+IFk5DGrKzY72GiycyDtvkLTtkXrC8wEY0Si65aRZsHdPgrlzM1jRrbOkIKcKHGqdVylJVKAGka3odlCQXOIhNM=
X-Received: by 2002:a0d:d8d2:0:b0:5ff:53db:6b71 with SMTP id
 a201-20020a0dd8d2000000b005ff53db6b71mr9197451ywe.26.1706895703473; Fri, 02
 Feb 2024 09:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706802756.git.geert+renesas@glider.be> <ffb1eb1d747dce00b2c09d7af9357cd43284d1c4.1706802756.git.geert+renesas@glider.be>
In-Reply-To: <ffb1eb1d747dce00b2c09d7af9357cd43284d1c4.1706802756.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Feb 2024 18:41:31 +0100
Message-ID: <CACRpkdaBBFjtgoUhhK8-X28BK=2NCyRS2NiYvVEZFAsQiNZH9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: gpio: Correct default GPIO state to LOW
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:58=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> According to the GPIO regulator DT bindings[1], the default GPIO state
> is LOW.  However, the driver defaults to HIGH.
>
> Before the conversion to descriptors in commit d6cd33ad71029a3f
> ("regulator: gpio: Convert to use descriptors"), the default state used
> by the driver was rather ill-defined, too:
>   - If the "gpio-states" property was missing or empty, the default was
>     low, matching the bindings.
>   - If the "gpio-states" property was present, the default for missing
>     entries was the value of the last present entry.
>
> Fix this by making the driver adhere to the DT bindings, i.e. default to
> LOW.
>
> [1] Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

It's closer to the spec, but Mark's pick, anyway:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But on the subject, the bindings say this:

+  gpios-states:
+    description: |
+      On operating systems, that don't support reading back gpio values in
+      output mode (most notably linux), this array provides the state of G=
PIO
+      pins set when requesting them from the gpio controller. Systems, tha=
t are
+      capable of preserving state when requesting the lines, are free to i=
gnore
+      this property.

Actually, Linux can read back the value just fine in output mode,
so what about just ignoring the property and update the document
to stop saying that about Linux?

See drivers/gpiolib.c:

static int gpio_chip_get_value(struct gpio_chip *gc, const struct
gpio_desc *desc)
{
        return gc->get ? gc->get(gc, gpio_chip_hwgpio(desc)) : -EIO;
}

static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
{
        struct gpio_chip *gc;
        int value;

        gc =3D desc->gdev->chip;
        value =3D gpio_chip_get_value(gc, desc);
        value =3D value < 0 ? value : !!value;
        trace_gpio_value(desc_to_gpio(desc), 1, value);
        return value;
}

int gpiod_get_value(const struct gpio_desc *desc)
{
        int value;

        VALIDATE_DESC(desc);
        /* Should be using gpiod_get_value_cansleep() */
        WARN_ON(desc->gdev->chip->can_sleep);

        value =3D gpiod_get_raw_value_commit(desc);
        if (value < 0)
                return value;

        if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
                value =3D !value;

        return value;
}

None of this path excludes lines in output mode...

If individual drivers don't support it, it's either because:

1. The driver is buggy (such as not implementing .get()
  and should be fixed.

2. The hardware is actually incapable of reading the
  value in output mode.

3. Reading the value hardware register is bogus when the
  line is in output mode.

All these are driver issues and have nothing to do with Linux per se.

Yours,
Linus Walleij

