Return-Path: <linux-kernel+bounces-15344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCAE822A6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433F21F23EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC11862E;
	Wed,  3 Jan 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VNE1vr6+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288518625
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ccfbdd77f6so2079263241.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704275265; x=1704880065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Uu3c8CS1lVfKVNMcApNeIRZ8Y8V3EqweSncyL4lcTY=;
        b=VNE1vr6+zbcW+RbuKh48/16HqjYZBHVcz0NYHe6UiYsVmbAde+BZjIMHpmbK8O+C4M
         hjK+UG4v0/aOOvpogWzUWGJJw2wWt3BTRPKh9BH7OMJ2RFLeyJuE5wGdRzAdmx6taF3U
         WosPh1KaxZAHyIQqYqbN73SbzE8hOAm6miln6AlWZasmp+iPBfx6nOmY97nWlQk2F040
         eKx4W169JBStTe+7qr2H9KhYEAVSeECiVfaKokqZ9eB1MomNCXAZnQeOMMalwmfQs/eU
         gXHxFwewzNeZ7Ga16rKuBAlLxfrQhY8rajcwasv3SW6lehcMRtl1BHOqkdKnt4dEVZKg
         Rofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275265; x=1704880065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Uu3c8CS1lVfKVNMcApNeIRZ8Y8V3EqweSncyL4lcTY=;
        b=Kq9lQmucQ5FzhrRCUiPQ53p2DwUnK4of9hVR2jxgjx6Pew7zpBt9/VAOYRvEZbfGwu
         VwR0n1Mt43SVoYZnnjdmfqz6YALfRzdKzUxlOIG316Q+B5myINe4QB4oGRslHyg8DfC6
         DWyj/vx+Wr4o7VIu07G/U15f45w1x0lR0nL1Hu3E/mquQXzGUbgryhUAbhehGf/KiQ/A
         NS+rvXm69qqCvXu17DMNhFN7s1z7f7UAfQPFSTi6TDTJTZlWPiX31AMLPS/DOajZF35u
         XpwLEtnIg9KgYIzD+V/Nm4kpQmlzGxiutCc5+NyiBsLcpaJfhptYHh1teKfKcRGlwtEG
         uA5w==
X-Gm-Message-State: AOJu0Yzt05wKDS/79Yec92rr/sdjy7oUpi1aFZ0jvQc6yQO8sAd7CKhW
	NeDgsMVWUd/Cng4fpu93ug4glpaEVGka3xWTjCMr4+ZfR0XTfw==
X-Google-Smtp-Source: AGHT+IEYu7lrKPktfj6xVwnpsPDmZsLaProxg+WpiLZAf8IdKHO8AmnXGk+VkPfNvNleTDCFWcsjOBbBtgiFrLe2YUo=
X-Received: by 2002:a05:6102:2b86:b0:467:7814:ec21 with SMTP id
 ib6-20020a0561022b8600b004677814ec21mr2561562vsb.9.1704275264727; Wed, 03 Jan
 2024 01:47:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228104800.24913-1-tychang@realtek.com>
In-Reply-To: <20231228104800.24913-1-tychang@realtek.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Jan 2024 10:47:33 +0100
Message-ID: <CAMRc=MeB6UBf2cCrB8XHtfKigmS3Gb41SV-G6F+0X7Dd+7oatw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add gpio driver support for Realtek DHC SoCs
To: Tzuyi Chang <tychang@realtek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 11:48=E2=80=AFAM Tzuyi Chang <tychang@realtek.com> =
wrote:
>
> These patches add the bindings and the gpio driver for Realtek
> DHC(Digital Home Center) RTD SoCs, including RTD1295, RTD1395,
> RTD1619, RTD1319, RTD1619B, RTD1319D and RTD1315E.
>
> Change log:
> v4->v5:
> 1. Add more description in the Kconfig.
> 2. Add comment for the counter-intuitive number 31.
> 3. Convert to use cleanup API and module_platform_driver() macro.
> 4. Simplify some of the code as suggested in patch v4.
> v3->v4:
> 1. Arrange the compatible list in alphanumerical order.
> 2. Remove the size check for the offset array.
> 3. Add the debounce callback.
> 4. Conducted a review of the critical section, employing raw_spinlock_t f=
or locking purposes.
> 5. Add gpiochip_enable_irq/gpiochip_disable_irq to fulfill the immutabili=
ty requirements.
> 6. Use irqd_to_hwirq to get hwirq.
> v2->v3:
> 1. Remove generic compatible and use SoC-specific compatible instead.
> 2. Add the missing descriptions for the rtd_gpio_info structure members.
> 3. Assign gpio_chip fwnode.
> v1->v2:
> 1. Add description for DHC RTD SoCs in the bindings.
> 2. Revise the compatible names in the bindings.
> 3. Transitioned from OF API to platform_device API.
> 4. Use u8 for the offset array within the rtd_gpio_info structure.
> 5. Record the size of each array within the rtd_gpio_info structure and
>    implement checks to prevent out-of-bounds access.
> 6. Use GPIOLIB_IRQCHIP helpers to register interrupts.
> 7. Use dynamic allocation for GPIO base.
>
> Tzuyi Chang (2):
>   dt-bindings: gpio: realtek: Add realtek,rtd-gpio
>   Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
>
>  .../bindings/gpio/realtek,rtd-gpio.yaml       |  69 ++
>  drivers/gpio/Kconfig                          |  13 +
>  drivers/gpio/Makefile                         |   1 +
>  drivers/gpio/gpio-rtd.c                       | 604 ++++++++++++++++++
>  4 files changed, 687 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gp=
io.yaml
>  create mode 100644 drivers/gpio/gpio-rtd.c
>
> --
> 2.43.0
>

I applied this series. For the future: the commit subject should have
the "gpio: rtd: ..." prefix. I added it this time.

Bart

