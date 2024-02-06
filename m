Return-Path: <linux-kernel+bounces-54661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548984B229
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AF01C233FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43E512E1C9;
	Tue,  6 Feb 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+JzJVH1"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8ED12DDBB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214365; cv=none; b=qeQy8njioHrERFgDmaqou5pJOZla1ci9lqlC3nuAmRcNuaulHHLRUcZD+0jUcZthQ3BQ7lRjQ987ij1Tfg4+4JmXLyVfT0greIzV6IMORnOgU2YtscZC409I04tN0wCfg80zTh6VgAkRA16k0JgDwqIYL85TdqVav5wdDdMuQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214365; c=relaxed/simple;
	bh=Av25SvJY+VoNb8IAXb8ten2tW6yMRrOZ0ZoYKecDGM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jypyS+vRn76Z0aab0M2O1P81zvh19zw7MM1RMzjGzfn22p7vrti8EqAcz8/g10hoFN/t+dRoGjq3RKTj/yLWCfA5VwvKBEjEGPjiN6fmx0Bs+6Q4cpOcTo/yOnR25kP1AteQY5UjjYwWcpcCSVNe7QU3sw+D9z3Vk7ct43S6QYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+JzJVH1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68873473ce6so2805346d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707214362; x=1707819162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RtzBJx6wCZPpOqlih50m+fMwaDQ7Jnq2Nn6LSXNODY0=;
        b=p+JzJVH1MM/61FUBQqjrKL7WO2ltkZzIAQZoZWOfibzETc1Q1OQlaxFvqGWVYnKblf
         7X+aURNckWXmKKQBqwDR7zLPHjrlo8sssVZJmJoCzWa9U0RxwC46LM5dl4VAluWz0KeB
         OVx642kKk1rEKYlsx0up7aDaJ2hdOhk8Cf0u6wkljugoTzocPCm29Yier56EIv7qaito
         qwcA6Sc6LCwa+183PN6/FmgCMGwHQxxZ/4lyRj3g1Necr57zVzCpoGSevwIAFN4qyPhQ
         /M0RXhuzckxpp7MA9tpVO5q9M+A0GjuZ25aoz42JhIoIBY3AYYxdPQ89KkBi+Mq0ldaC
         HLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214362; x=1707819162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtzBJx6wCZPpOqlih50m+fMwaDQ7Jnq2Nn6LSXNODY0=;
        b=vxJAXXdlK+eQOYMq99WySfqeIjnORKBhAhvJHTzLC5zH6RwR7V9HJpR4BWEMi4PquM
         dkTSsOgcmSTmTA59bIYTjLOyn3E/UDmbjquoblMIt0HWeEYqEa6Li7MWWtGqKheudtXD
         HzhlVe+RBfmRHzLvfm89mycUS9TeVWCF3RoLhrWjVXWcZ4RyIONRuYZ9CgagkUsgIkjY
         iPzD4Xg5Ni1YwxiPq2hZO1n+Aq/I3iPcN0QjlUhq/lok5rgRpyw0qSn/TB1VXqH3r6E0
         sEdskwhEP+qRqYdqQYgpNCR1VpNyycR7GXAc3RzaoY5LTHn457C5Bz0qb4NHjjK5fNtu
         Ovtw==
X-Gm-Message-State: AOJu0Yzjg0KWPytOsHLPj/QPSabtppW5+ieDtH0xBKC9adiIGuX2i4Ja
	cS90C+zxQAd3ZiUUE9dLbEDeRviQiab/eqOVlMSKKo3WvL/yh9dkZfAb8q5Mjn2cfn3WHicsK+B
	GgpFe8WMY+Z1zzO6fNPf8hNmnjoiTEBg85NE2Eg==
X-Google-Smtp-Source: AGHT+IGMnZCoArTwWYltdog0J5CuS3/WLyIEtaUP+2kn+xaLD0CqS4Ik67E9lGPDKQvE0SR3tqrIbbn5FwyITbeWlxE=
X-Received: by 2002:a05:6214:4107:b0:681:7ba3:3649 with SMTP id
 kc7-20020a056214410700b006817ba33649mr1703512qvb.63.1707214362070; Tue, 06
 Feb 2024 02:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org> <20240206085238.1208256-5-tudor.ambarus@linaro.org>
In-Reply-To: <20240206085238.1208256-5-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 6 Feb 2024 10:12:30 +0000
Message-ID: <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
Subject: Re: [PATCH 4/4] spi: s3c64xx: add support for google,gs101-spi
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, semen.protsenko@linaro.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Tue, 6 Feb 2024 at 08:52, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add support for GS101 SPI. GS101 integrates 16 SPI nodes, all with 64
> bytes FIFOs. GS101 allows just 32 bit register accesses, otherwise a
> Serror Interrupt is raised. Do the write reg accesses in 32 bits.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

The patch ordering seems a bit off with this series..I believe it should be
1) dt-bindings patch (docs first)
2) Add the use_32bit_io flag / functionality
3) gs101 support (this patch) that uses the use_32bit_io functionality

Peter.

>  drivers/spi/spi-s3c64xx.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index cb45ad615f3d..9ad0d513fb30 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -19,7 +19,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>
> -#define MAX_SPI_PORTS          12
> +#define MAX_SPI_PORTS          16
>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
>  #define AUTOSUSPEND_TIMEOUT    2000
>
> @@ -1538,6 +1538,19 @@ static const struct s3c64xx_spi_port_config fsd_spi_port_config = {
>         .quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
>  };
>
> +static const struct s3c64xx_spi_port_config gs101_spi_port_config = {
> +       .fifo_lvl_mask  = { 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f,
> +                           0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
> +       .rx_lvl_offset  = 15,
> +       .tx_st_done     = 25,
> +       .clk_div        = 4,
> +       .high_speed     = true,
> +       .clk_from_cmu   = true,
> +       .has_loopback   = true,
> +       .use_32bit_io   = true,
> +       .quirks         = S3C64XX_SPI_QUIRK_CS_AUTO,
> +};
> +
>  static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
>         {
>                 .name           = "s3c2443-spi",
> @@ -1550,6 +1563,9 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
>  };
>
>  static const struct of_device_id s3c64xx_spi_dt_match[] = {
> +       { .compatible = "google,gs101-spi",
> +                       .data = &gs101_spi_port_config,
> +       },
>         { .compatible = "samsung,s3c2443-spi",
>                         .data = &s3c2443_spi_port_config,
>         },
> --
> 2.43.0.594.gd9cf4e227d-goog
>

