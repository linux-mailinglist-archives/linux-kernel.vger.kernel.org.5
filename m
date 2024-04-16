Return-Path: <linux-kernel+bounces-147064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167D8A6EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836E11F2186A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938512F5BE;
	Tue, 16 Apr 2024 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp9aWPme"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26712DD95;
	Tue, 16 Apr 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278946; cv=none; b=lBGeUQhrNL9jrr135Z70zcOL1fXjlZ+iF2x9uQQsjBsoHrk8DDEeLT4BmX+3FVSgUX7yAw+3ht3THsh95zQjJ0hDL68O0ppuTMQf0ka+kN8HDTHoa8fFHTo9YtoD1TZZy2XMEcUsClSdBtmDteAUzYRYQAG/+8RCO66FsLGzTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278946; c=relaxed/simple;
	bh=N7wBR+UpwtOV9tGvVgMsV+bnRTrkTRC+bkXsjuPHIuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdszABVUP8uCGvukqb+GKNp/wI7phVHWovWj+J0QIqp+wT6J4rMQoF/mJZmd1qFdDgLotUYNPpdLIVK9y9tRH7UrK9zSkEMveubHBUQCnXb/RZT3DiuydMbwqZ48omK2Jj0RtaKk6diJeI8hAgXMQ+h9/VVaihbphdDIjJ0foTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp9aWPme; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4012379b3a.2;
        Tue, 16 Apr 2024 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713278944; x=1713883744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BX6A1PLIPUHloNbC1YwAKF3yvucqzC+IykrkDL2EP9k=;
        b=Cp9aWPmeMH+dt/AMVWJSWZu8t/9uQxw8G/UwKTRTZwxUj9JadJkKxBHFl++VxFoiwE
         AgLIp1xWmESaiSA5/UbYipL+s+H64p2AfNFhzJpzILY0IfZrrVBHmqqKxkkI/nxgw+7h
         6kB+okac3WlQTYydfqpoHnmFvn4pwxCy0WgtGsrUov56z37148y/6Ipd9avj+Bld/i+u
         k312TBwFccBR94oD1Mqw1hz1rKvJlODxVat36Gd9+cGw1Ky1szuuJIDP4tEPSF5w98Ix
         ieFzGmi5PGiPZ0CwokfeIJFQv2NV9yuFCh7hHzKp9Sv3jR31nXxuj1S+DBPnwGiCGQzN
         M+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278944; x=1713883744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX6A1PLIPUHloNbC1YwAKF3yvucqzC+IykrkDL2EP9k=;
        b=TJBznwNQNwYKj022PeFNvURJ3+Ixc6bGrVQPrx2e+2+2Z8+7m8f9+CWqtjB6L72KY9
         D/Ry/MFNSiljHfavSSj4Gk8XFm/ZLyhKUmp83LmkYOnJ2VONv4jyF6NyKOOcMsml1X71
         GTn1bdRSK+3V1jG30+VS5htwDEZwYpvpn07GJ3EZvlnXddp3Xe4qrxsTNKP9zEh3zy5b
         VSeCCA5f8BZsf898SGMrmbHSK1xvUsp1q3UCA/ASkBrG1AFr1zWKSzVB8n9oxXxDtAek
         /DROd/DDDqgNmRdJ85md3UppbRW0SskzUTcqkO2ftaaOCSU24OxNFsKiV3vvYTOng/YG
         2QpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJQkQTvTuMLMUjNoh2v+mrMhx1RHnGnK+EeKCefutz8gnnyIy93jXJhUQ1rH5Cl0sI3/0NRvjDsN5IDi+mchXp8SdMkBiKZNM+wQE7dARzuPjMPkxJW2AXff5RgcdrIe5FIF97uusdDH6euD4Qt00y/o9n8AtpkNji5kjSiQG4Mg==
X-Gm-Message-State: AOJu0YyfRdaf1tAvlnYUg6ENAs3thHAunlbsisQogRi/YvDVG2AOHUMU
	Ajwqd4HaHvxyq7C+cyfkvvAsIliZuNvn7n0LftYyN3M/+lHFIz++o1lv4n6huM3hJZFmjgleE4L
	IAO1SFMGW7lTIXxHgnBKiLXdqbqrYGjFxL4I=
X-Google-Smtp-Source: AGHT+IHwXhNE3qhkiOVa1dv2tNZZoMwwK96HbsfDvdiRkntrb7ZgeBlDRihGUMHsqNe5ZhvEp1uCE2io4H+6TCFJAD0=
X-Received: by 2002:a05:6a20:3255:b0:1a7:9fd2:8bbb with SMTP id
 hm21-20020a056a20325500b001a79fd28bbbmr11344740pzc.24.1713278944220; Tue, 16
 Apr 2024 07:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414065305.9796-1-marco@sirabella.org>
In-Reply-To: <20240414065305.9796-1-marco@sirabella.org>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 16 Apr 2024 16:48:52 +0200
Message-ID: <CAOiHx==-V-SeyiH3+BbPD2r13vwsWE2MzRDjtHRBWX7CtFLsDg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: spi: Update gpio+bitbang instruction
To: Marco Sirabella <marco@sirabella.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, 14 Apr 2024 at 08:54, Marco Sirabella <marco@sirabella.org> wrote:
>
> The way to do this was changed in
> 9b00bc7b901f (spi-gpio: Rewrite to use GPIO descriptors)
> and there's no real docs outlining this,
> update defunct #include "spi-gpio.c" instructions
>
> Signed-off-by: Marco Sirabella <marco@sirabella.org>
> ---
>  drivers/spi/spi-gpio.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index 909cce109bba..8c5f88f01db2 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -44,22 +44,13 @@ struct spi_gpio {
>   * per transferred bit can make performance a problem, this code
>   * is set up so that you can use it in either of two ways:
>   *
> - *   - The slow generic way:  set up platform_data to hold the GPIO
> + *   - The generic way:  set up platform_data to hold the GPIO
>   *     numbers used for MISO/MOSI/SCK, and issue procedure calls for
>   *     each of them.  This driver can handle several such busses.

9b00bc7b901f (spi-gpio: Rewrite to use GPIO descriptors) removed the
fields for the GPIO numbers, so this is definitely not the way
anymore.

Since the code now always uses descriptors, the performance comment in
the first paragraph does not apply anymore as well and should be
dropped as well.

>   *
> - *   - The quicker inlined way:  only helps with platform GPIO code
> - *     that inlines operations for constant GPIOs.  This can give
> - *     you tight (fast!) inner loops, but each such bus needs a
> - *     new driver.  You'll define a new C file, with Makefile and
> - *     Kconfig support; the C code can be a total of six lines:
> - *
> - *             #define DRIVER_NAME     "myboard_spi2"
> - *             #define SPI_MISO_GPIO   119
> - *             #define SPI_MOSI_GPIO   120
> - *             #define SPI_SCK_GPIO    121
> - *             #define SPI_N_CHIPSEL   4
> - *             #include "spi-gpio.c"
> + *   - The inlined way:  manually set up and register a gpiod_lookup_table with
> + *     the appropriately labelled gpio pins "sck", "mosi", "miso" & an array
> + *     named "cs" before calling devm_spi_register_controller (XXX).

I think you need to use platform_device_register(), at least both
remaining users do so. And this is AFAICT now the only option for
registering it via C code (which also means that DRIVER_NAME will
never be defined from outside, and GENERIC_BITBANG will always be true
.. ).

Best Regards,
Jonas

