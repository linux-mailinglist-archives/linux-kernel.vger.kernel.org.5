Return-Path: <linux-kernel+bounces-85644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C487C86B89F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA0F1F22ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D065E08F;
	Wed, 28 Feb 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FvhdjVb3"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DC5E07E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149936; cv=none; b=JE/iCxLNFp/7547pggfEFMXjwWDlxArd5DytVmonPQAHRanKAmFgJ9oBv1JMdRVEN80YgDaJeIG/LoQ1qSjquuZhQrScPIJcooqdMQsK7aLKC2FrUYHtjZdZJ6etfCNi3DVlAmyAjQCA/URX5ehIo3BNKOpGUrK89oie9Wtxp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149936; c=relaxed/simple;
	bh=PRdP2j04kxlBLPjXcsnuNmfbodBD9MgXPDZDAAM0Z+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AytWa6AM+ZBidL1ywHOXZLJ6VFOxdhu1xVyUjN3CGWyK3yjUVUvVeUNV2mXgDYk6dr8sF+ZR7ha/pjzs3zX0guVtgvIIsSivpQ5yOnZic7Jj7hw5qD7xMlDvzQq97837NNA7LI4NLuKfsRprvC4kPUDiUOOkizJYD+BJCUMtX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FvhdjVb3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d288bac3caso1141271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709149932; x=1709754732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMIx8saBxEDCNVvunMWep/UC7uGA5dpb1FEvqu7GpNY=;
        b=FvhdjVb3L9Gv+hSerTeQe4sm6Fax/LzdgjqzSIhJ3UijUWEvmKY1TIqqYu6t5VE/fa
         DV6BWyJUB/kZl8uWZPQnvfge8ZyKMS1swtv1+1lwwKKVBkb5oXFxIBRwPX3Lga3rON+x
         IkfbFrY/YxXoM6aKlxDgxc8J6ARA0fiqWULFHPHwqKw0irIZLM8p5eWSzndmU0TvoM/e
         j/cR4mcRNsitvCMV48+PYthYv2BRZMpq4fuF13ltTckw6YrAEHj8CH2khYpVzgfB1/k2
         jnSlMVDFFE++Yl9Bpqg4GpXBRlalvYM8OUlLbXGsWlsFBEq6hUbs/RaqY6Uk8JvoT5tT
         kNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149932; x=1709754732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMIx8saBxEDCNVvunMWep/UC7uGA5dpb1FEvqu7GpNY=;
        b=a/qdyTtdVjXDUuIlJfuPO7E1GFc1G+3JFMN5PSvo9WeNPIlBStgZ4WrpAteoWnlKGL
         j83YXcZaocnK3Db6qdo2AQjovpEHl1pdAmEcQMB+YWV+ZwJGTm8ctPsSvo9KMcOsPsv6
         IM4Lvb+UQ1kRzrnDwe4rOPkOlpVTgpLIcYa5JKRU5xOg1FSoXVxuPCJhF1VnvpEK82La
         JqK1F/rNa7PGFQbAx9gVqF5DcabsLkJDMfEDyl3sCFBpN8wTmcUBDzl6EGdKknDaJlXY
         n7ZgS2Iyu9wb56SxlgJfYNRyYCO6QkSccNtZRI0JYJ8cMUJ2prz/081a7fLCcBNslN5e
         oy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZWmzl/QsZSOzLOSL3eW8151rwlsbbFFATD/2s0+EwiwxL2FWF1w5bl4iuXBTOXFsd0QhRp9FswXdNJodjb/k7axy34wn6kJLrMa9r
X-Gm-Message-State: AOJu0YxrVfcbzxz0FcPcxfZxazWrVw7mfKq2Wn85fkmmCzxZ0RZObRk6
	vs1+xIRthoJOvsVyv5ozGMfTOpmhev8HDYeYz4b9pGyxQw1F7/k3MSN2F6cHsjpaoDj/cUJlVBx
	IIGtRUN34y9lW3kejZeJ1mCgyohWXsjAf+zNvSA==
X-Google-Smtp-Source: AGHT+IEeqc2DJL8bDtNuCdiE0hcB+g4u5E7DX7tnm+IIvm6tYVJh272iDAXQ62pVabMCSml+sylR0HxW4kAIFO/RVxo=
X-Received: by 2002:a2e:b8c3:0:b0:2d2:38b6:661b with SMTP id
 s3-20020a2eb8c3000000b002d238b6661bmr11809905ljp.33.1709149932500; Wed, 28
 Feb 2024 11:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228122617.185814-1-alisa.roman@analog.com> <20240228122617.185814-5-alisa.roman@analog.com>
In-Reply-To: <20240228122617.185814-5-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 13:52:01 -0600
Message-ID: <CAMknhBESDhM2m=LqPH6XNGeDe+AwZ-38f+_Mja0xdSv5pXOoJQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com, 
	alisa.roman@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:26=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>

..

> @@ -1012,6 +1052,73 @@ static const struct iio_chan_spec ad7193_channels[=
] =3D {
>         IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>
> +static struct iio_chan_spec ad7194_channels[] =3D {
> +       AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
> +       AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
> +       AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
> +       AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
> +       AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
> +       AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
> +       AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
> +       AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
> +       AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
> +       AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
> +       AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
> +       AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
> +       AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
> +       AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
> +       AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
> +       AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
> +       AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
> +       IIO_CHAN_SOFT_TIMESTAMP(17),
> +};

Based on the discussion on the v3 patch I was expecting this to be
fully dynamic rather than having a fixed number of channels since
there are so many possible combinations and the fact that
pseudo-differential channels should be using AD7193_CHANNEL() rather
than AD7193_DIFF_CHANNEL().

> +
> +static int ad7192_parse_channel(struct fwnode_handle *child)
> +{
> +       u32 reg, ain[2];
> +       int ret;
> +
> +       ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(reg, AD7194_CH_DIFF_START, AD7194_CH_DIFF_NR))
> +               return -EINVAL;
> +
> +       ret =3D fwnode_property_read_u32_array(child, "diff-channels", ai=
n,
> +                                            ARRAY_SIZE(ain));
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(ain[0], AD7194_CH_AIN0_START, AD7194_CH_AIN0_NR) ||
> +           !in_range(ain[1], AD7194_CH_AIN1_START, AD7194_CH_AIN1_NR))
> +               return -EINVAL;
> +
> +       reg--;
> +       ad7194_channels[reg].channel =3D ain[0];
> +       ad7194_channels[reg].channel2 =3D ain[1];

Needs to set ad7194_channels[reg].differential =3D ain[1] !=3D 0.

> +       ad7194_channels[reg].address =3D AD7194_CH_DIFF(ain[0], ain[1]);
> +
> +       return 0;
> +}
> +

