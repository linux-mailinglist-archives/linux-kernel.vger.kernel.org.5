Return-Path: <linux-kernel+bounces-145320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C5A8A52A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C4E1C21EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66045745C9;
	Mon, 15 Apr 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpzx8k0X"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0DD74420;
	Mon, 15 Apr 2024 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189936; cv=none; b=KSbGRzHbl7Ei3IJtOI6+NgekFDiOytgd6WivQpUin0bpD4eQb7WemNG9BRtNKm3783j4HW8ywSbyyBtotWoR35i8H0Xodd9qpI8cx60Vv8RetcIr3LkyXMd7oGxEoSEDe6L8b/xMYI68ieQbpaBXECNANGaAPi4QpJE7UzsB9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189936; c=relaxed/simple;
	bh=C2RaXFcuh6uhrQqFZdquLpLy57EbGKkPUni9Jf4Km8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQPDm4x5IosXjz312JCq5OUHq9IJV2631BLzYVNQDkl5TG8QANgKSyMDhsIKA8weBO5ZXyIAtG34F88QZGUvwT765EHIhMNcDInMJzxpxPOAKIMBlix0Zkn69KeUkcs1Lr9q1JCf3vROxUvd2aSA3l9VKT++PUyEkP3HIuMVd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpzx8k0X; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3121476a12.3;
        Mon, 15 Apr 2024 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189929; x=1713794729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce+RZRNdvY2/c7BMbLG8IKG8g7W50m+r0bqN56BPld4=;
        b=jpzx8k0XvsE30XWjgOnfcrzTqufdwG0YJLdCGuWsWyorExU7YcQ5d1dQXT4ynOw2uY
         IxAhq3MiH5qaRTcWmgyg5XRpN95GW9pAnY440FKkbp0I2luXggqwvvnlP+gMUoXWY3BZ
         Hldh1RGHlbD57FcYBpFhBZ9pVx3CQx5LbHZG/AW0lWr2qLrAoBKcjZY8KkvmZGTOD+sr
         YTC5eefT7+fedTPXGLIrwQbUHvddnw3NDsWmzfHRFDeLpAlg3MKX25Upflgw8yA7Eogb
         oQPV2Gs2a+OIiyvJsBXbxe1UTZ38eNqIgoznRoAoxRAAKSwBnfKIzTWrUAaheJK66VVQ
         C/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189929; x=1713794729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce+RZRNdvY2/c7BMbLG8IKG8g7W50m+r0bqN56BPld4=;
        b=nWFvHhGZ7DdEJY3mIMW5wwJsT55+DTkXwZo1hrX6OSV4M+qcNQBiibY2l/bRP1dLY5
         YXM7Fi/FOGBTEmyqiLogQ7ep6pTtoV/bogHKzwH6ElM5t8X37vdXlWB9OKMjAYHQz5wA
         MJp28yifH40vbVCoKQxemMmCxlYeiDYtNkHOeon65+uzg7NkzN9uqAvJWS5ubzbn1vGC
         ipa9kNQzGq6lHP4QW79dX/gAy83xh5ZDOzuN/bkMLALKHu0lVmMi2qWi8wkoAB9QQQGS
         RVwW1ovU/lzpkbVbQMc7SRlTG+xbeGiEhgw2PTpadLSrQQkON6xGkTsPQbI5Vl8l4f4I
         TDWw==
X-Forwarded-Encrypted: i=1; AJvYcCVFkolld2GFSqzusotWP8OWhiy852shbAkkZ4sdOoL1vqM9DqmpzM3oaP2asPDb7EZzUK5ci+5EDywlfrsoaXqCBddOwNGzw3AVmhDZx++InNs+ZNMs0Ziz4RkDXD3oHUtWbC2gAFBUComXH4Ztat1IAvz7ArN9iHOZO3DoNx8j487LzhGhwoZ6OYiUVllvkIDbbSpiZsn2mfm8M92xUwwa
X-Gm-Message-State: AOJu0Yy0FZY007OVcR8AAdQuqipFhgID2qZDOl+X3VE0RilWqSAM6FzT
	yR//VpNJd0o6w5zME25rCSat/DrAYB4zSfSZNLm+CnrT6eeHuDpMgC+PayWuabZOFSDiuE80S0h
	DyfFN0kgLanOaCSeiMIvGqSyZChQ=
X-Google-Smtp-Source: AGHT+IH86wMUY1Sjlbl77b74h8OkFHcq+fDgDK9uWIRulsSWUGwrIz3dHKroKOaN9XoU6ownWtnCcV0AOUGrp658hc4=
X-Received: by 2002:a17:906:1355:b0:a4a:3441:2e2a with SMTP id
 x21-20020a170906135500b00a4a34412e2amr6807358ejb.55.1713189929060; Mon, 15
 Apr 2024 07:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org> <20240414175716.958831-2-aren@peacevolution.org>
In-Reply-To: <20240414175716.958831-2-aren@peacevolution.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 17:04:53 +0300
Message-ID: <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power
 it off during suspend
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 8:57=E2=80=AFPM Aren Moynihan <aren@peacevolution.o=
rg> wrote:
>
> From: Ondrej Jirman <megi@xff.cz>
>
> VDD power input can be used to completely power off the chip during
> system suspend. Do so if available.

..

>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

> +#include <linux/regulator/consumer.h>

Move it to be ordered and add a blank line to separate iio/*.h group.

..

> +       data->vdd_reg =3D devm_regulator_get_optional(&client->dev, "vdd"=
);
> +       if (IS_ERR(data->vdd_reg)) {
> +               ret =3D PTR_ERR(data->vdd_reg);
> +               if (ret =3D=3D -ENODEV)
> +                       data->vdd_reg =3D NULL;

> +               else

Redundant 'else' when you follow the pattern "check for error condition fir=
st".

> +                       return dev_err_probe(&client->dev, ret,
> +                                            "get regulator vdd failed\n"=
);
> +       }

..

> +       if (data->vdd_reg) {
> +               ret =3D regulator_enable(data->vdd_reg);
> +               if (ret)
> +                       return dev_err_probe(&client->dev, ret,
> +                                            "regulator vdd enable failed=
\n");
> +
> +               usleep_range(1000, 2000);

fsleep()

> +       }

..

>         stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> +       if (data->vdd_reg)
> +               regulator_disable(data->vdd_reg);

I forgot to check the order of freeing resources, be sure you have no
devm_*() releases happening before this call.

..

> +               usleep_range(1000, 2000);

fsleep()

--=20
With Best Regards,
Andy Shevchenko

