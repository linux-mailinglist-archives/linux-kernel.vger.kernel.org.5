Return-Path: <linux-kernel+bounces-56165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F784C6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362231F24633
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB120B03;
	Wed,  7 Feb 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6zENeWd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604C2231F;
	Wed,  7 Feb 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296871; cv=none; b=QOJNdndOmm/Z1vnVkgmYlhsOBhAv6YDdezFYJZtDT9JYbobosE+zUqY6u9i1TyEW11ZMJZg0cNBw92Nekn0NwMum+MQR5lpujcXUe+IOKGescmMaa9UiFuKMQAMoA57PdOWOnUqCUDoVYyyIdUpNbnpXgVzxeDqfZWrhljmNkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296871; c=relaxed/simple;
	bh=eZ+JnOV19PVeH4H/+aeC4cPDspUN9ZTpPviNI/TBmgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IH1I1tPV5CjgpeBkUuMiD+Nt73U6dl+pk26Y1zFVlJa74qHV/SkzDa+/tiUM6K/KmgHgTLJZdHxYreEk/OXscUCI1prbzjAObH7SgR2aejgW9mDGLrtjBjab9Zn6RtveYSK5XwXstXQPyoWDT0y5+Ba0cR2tTiDlOacXWiIZJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6zENeWd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso1450527a12.1;
        Wed, 07 Feb 2024 01:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707296868; x=1707901668; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swJ2Qvj5Sz/5JU1GsnqjI51zR2sc49lYmmlCIIsiX7c=;
        b=a6zENeWdAooV5hvluR/ylUlPu/mFxRKfmwVUTDM2lW1cCCkCKcYXcRUpSp9T2dOssk
         KP/XfwfrsQmvsNOrSeN/DcVra6Hr2dc1Z1ldTwMIZYVHJXaqf8mlTbW3e+sqz8rauL1r
         dp3udUeop7aP8ojjcQFjxFl7vgqzcv10VQfX/1mfvkUj3mHJiJopCHP2Am2j5LTHkiJM
         kdC40PRKrRqFUpCkuqObQDp/nIgLQtyFXllLv+ZBoIxxprr7xjv6eKW+6x9gQaukGsbI
         qXG4INvS97dZ7WnzLR7NGkL5sANzestRTzs+Canq33u26XJrt7vEf2SLouChAZSCnGwE
         uGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296868; x=1707901668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swJ2Qvj5Sz/5JU1GsnqjI51zR2sc49lYmmlCIIsiX7c=;
        b=WLeiirZAA8xkHqDOf35Lo99Gm6lff2vmxfuwOaskoNGZ4oNNXfLXphRGRJc+GB7s6o
         8BT9zEM4FrD3GU50E/OpFf3t5cjmgssKCixJk7hlsIo8/3uFPWwMQop4jX6TEa7+4MzF
         f3kkWoKDfgGMmGJX+EZEa2KcM8TkPTM4UNQsQTnoaecuRVVsdCM6nPsalVVPHhzD4jEr
         apwno9yLVRiamAOarP5Xus8FHoP4pg2dSiCR1LstyFEdFs3UhDd9fc0dcsVTn/jo12qU
         nx/+l5kL/qk6tfpeRRuVRN8NjyLoiEepTnfgi3UTjLnZvrldymtXT9pM42K1I+0mYst/
         l7wg==
X-Gm-Message-State: AOJu0Yw08IwvO5cW4pNMUyHM+7K8mrQeonCNMxZKNd5j1MJkqcBBIyV/
	aLrIfxChdfeusa6NiYM4ml4MkYwA6q/MluKdQsi8hShP905A23E59wdbbjNWdEy4Aw==
X-Google-Smtp-Source: AGHT+IEgatN1iB6tfJnwcFc1bwXTKl8zTQo7oXJ5BZGh/Y5IUOgLzuZVgFKqWwVuwsL/GNtlo2UJ/w==
X-Received: by 2002:a17:906:30d2:b0:a38:4340:60d3 with SMTP id b18-20020a17090630d200b00a38434060d3mr3054335ejb.10.1707296867654;
        Wed, 07 Feb 2024 01:07:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2Smbh4V36E4jJxROqksgZUcsjMcAGfFArEA5c1SJMhRg3uFaKfqNJi8jfCitVN4A2eJ3j6U6c5h21n+x6yqpoQUuXA8VjG41JHZG5n5COqn7WoIu3iKg5nrYusRaoj8w/GQ5oZd/XfHuKmsgfphiwF737RNrKuEso3BWxzTMOoemntKqvtzvWBgY0BwJ++ILhdBmOurYG88q8zyM73SiYAFgfsSWHshvhkSymyYYUdlCDtQ==
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a388723b7a1sm211558ejc.50.2024.02.07.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:07:47 -0800 (PST)
Message-ID: <9c53981719f8d44c38a5eb32e629dcec4bd2c60a.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: adxl367: fix DEVID read after reset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2024 10:11:06 +0100
In-Reply-To: <20240207033657.206171-1-demonsingur@gmail.com>
References: <20240207033657.206171-1-demonsingur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 05:36 +0200, Cosmin Tanislav wrote:
> regmap_read_poll_timeout() will not sleep before reading,
> causing the first read to return -ENXIO on I2C, since the
> chip does not respond to it while it is being reset.
>=20
> The datasheet specifies that a soft reset operation has a
> latency of 7.5ms.
>=20
> Add a 15ms sleep between reset and reading the DEVID register,
> and switch to a simple regmap_read() call.
>=20
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---

This likely needs a Fixes: tag as well. With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl367.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 834ee6d63947..210228affb80 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1368,9 +1368,11 @@ static int adxl367_verify_devid(struct adxl367_sta=
te
> *st)
> =C2=A0	unsigned int val;
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D regmap_read_poll_timeout(st->regmap, ADXL367_REG_DEVID, val,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =3D=3D ADXL367_DEVID_AD, 10=
00, 10000);
> +	ret =3D regmap_read(st->regmap, ADXL367_REG_DEVID, &val);
> =C2=A0	if (ret)
> +		return dev_err_probe(st->dev, ret, "Failed to read dev
> id\n");
> +
> +	if (val !=3D ADXL367_DEVID_AD)
> =C2=A0		return dev_err_probe(st->dev, -ENODEV,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid dev id 0x%02X, expected
> 0x%02X\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 val, ADXL367_DEVID_AD);
> @@ -1449,6 +1451,8 @@ int adxl367_probe(struct device *dev, const struct
> adxl367_ops *ops,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	fsleep(15000);
> +
> =C2=A0	ret =3D adxl367_verify_devid(st);
> =C2=A0	if (ret)
> =C2=A0		return ret;


