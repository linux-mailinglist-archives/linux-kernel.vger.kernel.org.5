Return-Path: <linux-kernel+bounces-121542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E8D88EA87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7933BB2DEFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB451384BC;
	Wed, 27 Mar 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwfkdvz/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFABF12FF74;
	Wed, 27 Mar 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553707; cv=none; b=tsQ74LYvIwLvPUoaeZn0HXGma23kFD/hT2K/5cmiPecipf8xsv4z9OqDLj2gT0C9pgxYZIdO+OSNhZJ6xVJAtrpHw+CABezH0R1IL2a3ONGdog5GpkLVud/UZDgRgtVn6GgWxF7qmcejRn8MJ4usKEpo7GLwojyZKCpDmXqKc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553707; c=relaxed/simple;
	bh=OKOBRjWUmEBgIQQoauzyn2lJtxsFxD/jNHsmS6fQ4YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMw3F4Zkr7Cwb7WUf0z7kjSv798Aw+wlyx8ZcGAqlFIWb98zEgzyNeNULdYnDeIJfoNt8UcZyXTnTWrs0hCNn7tIaCfA+Oi8MEZdcib68QH7qtvT+dVS7ToHBmj/TtXwjLF+n9zGv22Ha98r8GTkElzPKow526gCvbnYy6LHT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwfkdvz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A80C43394;
	Wed, 27 Mar 2024 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553707;
	bh=OKOBRjWUmEBgIQQoauzyn2lJtxsFxD/jNHsmS6fQ4YE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pwfkdvz/X7rr2mAqpGmZvB0B8ecBq9LHLmAmpa00j0QbemDCmmS0o68hVnoPkJ9Gk
	 YPpwqZg/c+2xzVZcp2YJasyjcwOmFSmUNyKAFf4wzn6TwKGSx0+0cA/f2W8USgjkMR
	 7CVqMA4M/IcqiLyAD8vS+2ezbkmezvMF1CFZ3Ir50RXjc+lH1an5NtCUdR0YfFaNLI
	 jSrF662YW7otBMatSWokKC+8H7ORA+qaxSPEt4RgOhnNL+9xU54Ew1OPnQb3vzzh2G
	 IWICpt93yvvr+u/vDtdUdoF43nng3X+9t01NeWfmZ5KT9wvfrG7/OcuFYn5lgAfJ4e
	 K9fb39sNUn9gQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a46b30857bso1715306eaf.1;
        Wed, 27 Mar 2024 08:35:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxsm5TrY2rETOHYftjK3buFSPc+oVJp3jJtAaoT24A0wwS7ySFQXEI0q5Bw090mbBQAR8oOay2mN4Y8ix5ZcbF0cyLCfVUWhX4Qoqv3sJLsDeBXlcsgKtkZpREkpNzCB5ejuuWRX6scg==
X-Gm-Message-State: AOJu0YyGM2PCVbrD7R7g++N3ChbwiT/4rhq1ZjKy/9ZKj2J8556qww/e
	tIteKM4TApMHJj5/NjoRWgh66IT4ycNEW2cKPXG0tRptgD4r043jVP6feaR1Y45qTynKKzfk8eQ
	fwdwsdLpIchzz5k0W0NqH6EUrg/8=
X-Google-Smtp-Source: AGHT+IFBVjTHKN2OSbd29nBi1LmoTNb/CDz2t7Lc0cIWDApE6Zrrwq/1vp73kdOXVecYtj2lL221LJZ21VkZUIVKeyk=
X-Received: by 2002:a05:6871:b0a:b0:221:399e:959a with SMTP id
 fq10-20020a0568710b0a00b00221399e959amr24851oab.0.1711553706522; Wed, 27 Mar
 2024 08:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY4P282MB3063EE2CC37BD0EF2318B746C5362@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB3063EE2CC37BD0EF2318B746C5362@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 16:34:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iogogd+AxL5ZPU-80Nj-nQz4avkymaPRPa4SiJdvBfjg@mail.gmail.com>
Message-ID: <CAJZ5v0iogogd+AxL5ZPU-80Nj-nQz4avkymaPRPa4SiJdvBfjg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: thermal_lib: Continue registering thermal zones
 even if trip points fail validation
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:44=E2=80=AFAM Stephen Horvath
<s.horvath@outlook.com.au> wrote:
>
> Some laptops where the thermal control is handled by the EC may
> provide trip points that fail the kernels new validation, but still have
> working temperature sensors. An example of this is the Framework 13 AMD.

I believe that this is a regression introduced recently, so would it
be possible to provide a pointer to the commit that introduced it?

> This patch allows the thermal zone to still be registered without trip
> points if the trip points fail validation, allowing the temperature
> sensor to be viewed and used by the user.
>
> Signed-off-by: Stephen Horvath <s.horvath@outlook.com.au>
> ---
>  drivers/acpi/thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 302dce0b2b50..fd59e41037ec 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -903,8 +903,8 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
>
>         if (trip =3D=3D trip_table) {
>                 pr_warn(FW_BUG "No valid trip points!\n");
> -               result =3D -ENODEV;
> -               goto free_memory;
> +               /* Effectively disable polling since it is not needed */
> +               tz->polling_frequency =3D 0;

Because the thermal zone becomes effectively tripless, it should be
registered with thermal_tripless_zone_device_register().

>         }
>
>         result =3D acpi_thermal_register_thermal_zone(tz, trip_table,
> --

