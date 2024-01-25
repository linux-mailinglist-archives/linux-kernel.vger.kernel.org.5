Return-Path: <linux-kernel+bounces-38233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A095983BCDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4152E1F2F460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616471F61C;
	Thu, 25 Jan 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X58mvdCB"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83A1F619
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173504; cv=none; b=uZXlv9Qko7ziQ2VeKR+cEjv84W1zMAnLvJwgRemz8oeALur7iSejpWD9/Nimi2jLl5v3NDEX3KH3C6R+MisuqqGwq4h3GpIK1SjfsI5neasNezH+G0Qiab7+JqgP0X9jgPDLGP/ohvxPUcIYZJ5E4EBoBUKH4i4qej/t2DfsIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173504; c=relaxed/simple;
	bh=lipnMpwPco9x7KCIoob4tS30Jg6ddwgaMbgOVw0YoI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK3dO3lgaRXKXJyWbvWaxDmpsSc2zaoAlVSSzOkcMawMXFe/2+lw4KWUtdQPeHlpzdrBasjqMuUQqVdXC7ShGb1AgF9J2qMmSZpKmhmQc+uBjBFs0+R2Iz6g1DyDE/SPW47gdR9pq0EqFA0pCmVoOXIJBRykl1LV8lRJmR/Bkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X58mvdCB; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4bd80b41cbdso160143e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706173502; x=1706778302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yl5XDxNSx+scno4sOmOPamPnwehic8cqjKIJbS0TL4=;
        b=X58mvdCBymraHkwlYwZdQgnCmM5TcvsWU0IzAKvOzAbQ3OhtaN86Aulmefn9szzPTD
         bTm3OcgAThKYs2HZPOD8Yyc95gRTA1RnV1KHDcxV1rwSaAEtSHy6thgM+xukd900Hlzb
         QSWG0WXKqM9hUd9l1OpeAqsA+F/JbXpDQ3ksnriZm96kN0ZHuChkMkXIxdHLv4AwEiHZ
         OgkjEHL9wEo0B9WE1N+sgaPlZ6eTADiO3N8c9i3FjPFsU4jprdAPSCOLE3lzGTWD0oen
         +APs74LPXe9uwheyzn/StMJ2eUcpSJxUZ2qxRctdNoh6f/7o+6aAjYRgK90VUKT9TAxs
         t2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173502; x=1706778302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yl5XDxNSx+scno4sOmOPamPnwehic8cqjKIJbS0TL4=;
        b=Bn+vyraOBrvjXB/ddzUsd4Q2D/XnXfSDwMZ8eblN63U1npcHOkbyyOfIebrylbi5mV
         5jCdBw0qMvO5sPwZ1uHGCMxVyA9vzRKsXVMtF+FHobvGod7ln0B5NbCNF9jb+XM2XZoN
         6lmmTeX0VV1KG0zGhJPIIMwUzNOIjKSMmS1rNdyDM/MOsyZrqJNZyiJH6DvE84AO8EQd
         Bbur3yIkB+VgcXWEqnMI1Q+FtCURWHqlGQq+q4CpKN1iD/2gB8mqA/5QZghOJL1Tq8E/
         /S9cImTD+2Z9zLA+tEad7y+EGmUzf5PyGxPnT40rytYWWIUC4hzTim+z2t1gvs6UoDdk
         M+Pw==
X-Gm-Message-State: AOJu0Yx36ekIemrNNHjz7Mt/pbtIYeShp6zE/lRt7/UHM6QNdwkORjVh
	9hw9bz7tsoiyiulHVYIUlas+H7WqzWrpbhUFTocugo1cdsAXCySuco/GRMlq0tVV7SFPfKmDVm9
	VGDmXn6HUJsg5N4U26JL1rHmk8GzDLWXgS6ID4w==
X-Google-Smtp-Source: AGHT+IHZWV4UhDIIHdron+8ZF5KochAC0026rXhEu1We5qqfpAof5+JF6/mZFAZjawdecPIHq2gOns25o02YMaXlq/w=
X-Received: by 2002:a05:6122:71f:b0:4b7:a77c:d133 with SMTP id
 31-20020a056122071f00b004b7a77cd133mr385418vki.11.1706173502163; Thu, 25 Jan
 2024 01:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org> <20240125081601.118051-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125081601.118051-3-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 10:04:51 +0100
Message-ID: <CAMRc=MfYg5MgndDZtrAaScmtjXm4-AX6y1np7V3p4ngBKZG-pw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: add gpio_device_get_label() stub for !GPIOLIB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add empty stub of gpio_device_get_label() when GPIOLIB is not enabled.
>
> Cc: <stable@vger.kernel.org>
> Fixes: d1f7728259ef ("gpiolib: provide gpio_device_get_label()")
> Suggested-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>
> Reset framework will need it:
> https://lore.kernel.org/oe-kbuild-all/202401250958.YksQmnWj-lkp@intel.com=
/

And I suppose you'll want an immutable branch for that?

Bart

> ---
>  include/linux/gpio/driver.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index c1df7698edb0..7f75c9a51874 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -831,6 +831,12 @@ static inline int gpio_device_get_base(struct gpio_d=
evice *gdev)
>         return -ENODEV;
>  }
>
> +static inline const char *gpio_device_get_label(struct gpio_device *gdev=
)
> +{
> +       WARN_ON(1);
> +       return NULL;
> +}
> +
>  static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
>                                        unsigned int offset)
>  {
> --
> 2.34.1
>

