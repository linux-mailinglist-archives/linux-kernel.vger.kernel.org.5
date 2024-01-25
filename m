Return-Path: <linux-kernel+bounces-38184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974283BC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64B7287F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50831B973;
	Thu, 25 Jan 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P12TEnux"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672818638
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171787; cv=none; b=kW4ed5vbtmMy+qc0fhabSMEED1Wa633nZiZ5lr1cYYGzvEWmv/rGav9i5CKjTIJZ78wiGN5XMjUAkw4423RXhIPVzGDxSqL8YvAp8xMfIyToQYYIaaorOP36Z505VuCyJk5BR9S+cLqBFg/W1IkVKHHUrmfnwVeeAOJVtAYK3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171787; c=relaxed/simple;
	bh=qooEtGvBQ+blKW5h4z3pxUBP8ioX7XV+ZmoVKK10Hxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/Au9sh8/q1EUhxApO0Pco6iw0HFqUwjSWBbuKao5APa2E7F7fdTgG1BPGtxm9FOGlz63uedqElexJXSofeR4HR5P556co3kiQpMkyWnXtV5A2HHnmr28ngSmaWnNaO26WZStlXSr+cXXcflunVm/VIjOiL6+ClGW1R7HEdMWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P12TEnux; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bd45397c17so538124e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706171784; x=1706776584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfrj1tSmrxaEJmK1wFt8ZyU62zaatrSaUH2xIk0e35c=;
        b=P12TEnuxcH1nAFTrJfddf97upD3yAMsK2NKhOWNgbNL3XvAH7vlnKD+SPYQy9kTk0F
         fxfh92VBVw8MUiHQ+KAKBX79LCQZzPnFDFk4ugB+r6oyoXGm6OWhJRJogXSK4Fo55xnP
         xLZwcfO981SITTNErLpBQrANOfBvIXpN9uibpgCIwUPopqzjnx93m1y57tcW2q2ony2m
         4rqTaNkUXA1m+SaihTlVbMmb6KqsglaV34zxQqrz4vybOfn6Ush4z7us2IpDzYZL6QpF
         5KxL0nPj+4UGUVlA60y3dX4GE8WZ2WD3NAqVXgVwoZzurxRVcGv4Kg1QSjZB/4O0MmrA
         fNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171784; x=1706776584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfrj1tSmrxaEJmK1wFt8ZyU62zaatrSaUH2xIk0e35c=;
        b=IWdHtg6KgeVwFTjtvy+qJt+0BdST20rS2JN8R1OGwqppB2NrfA2NSlt9tn9SVqLKr5
         YZ7NmRzaIgs8ejgF+TDd5n9mOx4KT6/S60yZu8kEnN/WNX5MeIMtvS+reCXXFg+UH726
         QwIwmEK/PJPdGvvARhcaFBrgLDkVTncPuVdTf2H6AbJljaERYVhEBAin9btzBBq3G3Pp
         UlppSdyZuflzvYDC9grkU5QPV1cJMUq6108tLLmI3ZHDX++P9TjZxInb52iMefpKabcl
         rvJ6xndBlDUm7uNfos0nR+/1pP/XbDfREUTRyt9QR5ljE6l+j9ZC7qEP0BNLxk6eCffX
         TDCA==
X-Gm-Message-State: AOJu0Yx8jgImTpwhBxcYWmgbZgeOFZihhdM5OhrHFUfiy75g5nRQ4H5g
	jThnvgYHwAwMQshDI6kvRR7L3UZSQrtlZOAuZFLblNk92uaZrStjFUWKYSBWrpvmB7hlkbBI98e
	A8TQqE6GozoBORv90kqjnzZAedl+6NyVhYY3d+bboyXw7aOvl
X-Google-Smtp-Source: AGHT+IGjDrSN9NH9Q8W6iSCVre2BCEXpLwCYGPA1USwtRfIaGkgUmdH12KfPvs9ADyh4WxKD9T9WUXSiryfPlu5NEsE=
X-Received: by 2002:a05:6122:148e:b0:4bd:5edc:26c8 with SMTP id
 z14-20020a056122148e00b004bd5edc26c8mr290683vkp.32.1706171784583; Thu, 25 Jan
 2024 00:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 09:36:13 +0100
Message-ID: <CAMRc=MesG1nYSxx0osmQEEXCvs-6B4s4=TFYW5wD8pOXpV+OcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add empty stub of gpiod_to_gpio_device() when GPIOLIB is not enabled.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 370232d096e3 ("gpiolib: provide gpiod_to_gpio_device()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  include/linux/gpio/driver.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 9a5c6c76e653..012797e7106d 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -819,6 +819,12 @@ static inline struct gpio_chip *gpiod_to_chip(const =
struct gpio_desc *desc)
>         return ERR_PTR(-ENODEV);
>  }
>
> +static inline struct gpio_device *gpiod_to_gpio_device(struct gpio_desc =
*desc)
> +{
> +       WARN_ON(1);
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
>                                        unsigned int offset)
>  {
> --
> 2.34.1
>

Why is this needed? Users of gpio/driver.h should select GPIOLIB.

Bart

