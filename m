Return-Path: <linux-kernel+bounces-72992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F785BB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A9A284DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983867E6E;
	Tue, 20 Feb 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjeB14b8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10DC67A0F;
	Tue, 20 Feb 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431358; cv=none; b=PKpE2rtKRuyL7C4FtOgHQyUi2OeMXWb4zaKYhDjreABOlXNEBBp3cQ8DouxZQ63EOnrMPqW4HwCoCahiPbHUtifW1HTYAjcGZcfWOSOIT+d/eEPJXsS5yBSRZ9/1Xj9UtpsUtnO8jnhWI45uD5XoVIQg6jxjCrZe0S8pu+SWg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431358; c=relaxed/simple;
	bh=NFKIpWFlrcLcgm96+Riat3ntN8g+TKcG0bqfTPRK4F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+HKH84JQo4598EaN2UlVQrNyPuO+Cbz8jxvhZhPs8PjNXtUXE9KhJnobOaAm4dMI5aFARXWlnvsycOF7YJfwlAQb0XN6NpyY8h6ITkbjbJTBqsG84gzYSA7a1lmo78ylPVdCL39rn7lVsHCf+PB5STZ59JHPz2FyUIQ+jgToZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjeB14b8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4126aa42402so10646695e9.0;
        Tue, 20 Feb 2024 04:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708431355; x=1709036155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1kHmAH30WGxy5AZqgJqTBRqpGld5Izrqx3fcp2YhQqw=;
        b=hjeB14b87dnr13bbW/fyC0anOOQ2VbHDbOtLUbtzj5Cmb/vdMLJdkA6694mwxqfKxw
         qBZDF4lUmoCGMcKLKfqL9a0O7e5vrtxrTiD9G9qOe1yhaoeqdsKUsrXkTkMKD6GiSmcb
         PbUB6F05jBymkFDIoZg9Q8O+O1HmnMu/4wiOpbYCI/Wq+hH2Q8T2+uV1QpTb00GkHcCb
         tKNW0/67dXUOSjPoKVXLN3exQQvN8LWuIxGyWEm3wM7DbRLrmAkAbguOeNmkWRhVhYqQ
         J/YLFPaOw272P9RhLwikN3Mzyw7sNRWFc14XmMplN+p1w+TOQKlL9MJiIMfFD1uJlhJE
         cOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431355; x=1709036155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1kHmAH30WGxy5AZqgJqTBRqpGld5Izrqx3fcp2YhQqw=;
        b=kkyHJsigsTrp2QH0YJJVtukK52Nsoq7x+ePb9GAa/ON4QtJiS7+qROi7ZhdwSHaRPp
         qlKjBrvcCvYNz5rNtqpB0Gy3QDM4xT3RXRoRiEBFP1xVM2WXu4YwMzGgnG2BX8L4z31c
         xA5DnuB/pIAxf4NY9q4TkQJy/9PN8GpUekfNYr9DbOG9JkgZ6+Mxlm321+EwL6P5Tb2P
         CoqJW0YwZTiTgIsPjhxcaAClJug5XpkQEK1LQOY19yWrdS7S79wjkzRmeDOwvIzd6QXY
         vfSUG1Ii4UermQ8ntrI8Zh/4VKML9aCzA3obFv5MKpYhnnN1MryWj0mwrYpKKJI3z8wW
         Y2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWqcLVEkIEem6eSBQ4gTRN33y01ok4X3JLzu0X41hEBCPCDuZjAgOvp7910qrIhMtNVRm9ZR06Iq6AHNhUdKVkdZNHy1t0aOERtzo6GAoJVmgo/12ISxqQFeYk1cxNYUNoe6GxhPkEF/19hdWcS3ZV7GJYUEH1jhUTzRsHnNE5FRb37500vIFSS1z7tPu8CNWd7b8xL6hY1ANZCgQNqDQI=
X-Gm-Message-State: AOJu0YzNTv88pwG51w1p+fd7UGIFLqWnO6Vmr5cuSEcR3ySFV1poRdgs
	q8vD19XvvmkCFFLWu3wo92VXE1bRoYNj1WoX92Pem41DxjQu6DyW
X-Google-Smtp-Source: AGHT+IH8LNEn6d2zlOk1KelrI39dl9uZ+tjiwqV5GG6X14RQwC+tUIx7y4JAcJ/RsWA+Kk8zORUWpg==
X-Received: by 2002:a05:600c:45d2:b0:412:1e2:e237 with SMTP id s18-20020a05600c45d200b0041201e2e237mr10899429wmo.20.1708431355061;
        Tue, 20 Feb 2024 04:15:55 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id ck4-20020a5d5e84000000b0033d3f0eee9dsm7984801wrb.27.2024.02.20.04.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:15:54 -0800 (PST)
Message-ID: <9edfd3481a317ada51be03fa9da824edbcede9c0.camel@gmail.com>
Subject: Re: [PATCH v13 3/3] iio: adc: ad7173: add AD7173 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org, 
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,  ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 20 Feb 2024 13:15:53 +0100
In-Reply-To: <3bc2c1c6-726a-4751-ae81-4d8336619025@gmail.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	 <20240220094344.17556-3-mitrutzceclan@gmail.com>
	 <6af326b1bf24faea652b4549ff5db24b96ee80c5.camel@gmail.com>
	 <3bc2c1c6-726a-4751-ae81-4d8336619025@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 13:25 +0200, Ceclan Dumitru wrote:
>=20
>=20
> On 2/20/24 12:38, Nuno S=C3=A1 wrote:
> > On Tue, 2024-02-20 at 11:43 +0200, Dumitru Ceclan wrote:
>=20
> ...
>=20
> >=20
> > > +};
> > >=20
> > > +	indio_dev->name =3D st->info->name;
> > > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +	indio_dev->info =3D &ad7173_info;
> > > +
> > > +	spi->mode =3D SPI_MODE_3;
> > > +
> >=20
> > I don't think we need the above. We should just enforce it to SPI_CPOL|=
 SPI_CPHA
> > in
> > the bindings [2].
> >=20
> > [2]:
> > https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree=
/bindings/iio/imu/adi,adis16475.yaml#L45
>=20
> Rob Herring V1:
>=20
> """
> > +=C2=A0 required:
> > +=C2=A0=C2=A0=C2=A0 - compatible
> > +=C2=A0=C2=A0=C2=A0 - reg
> > +=C2=A0=C2=A0=C2=A0 - interrupts
> > +=C2=A0=C2=A0=C2=A0 - spi-cpol
> > +=C2=A0=C2=A0=C2=A0 - spi-cpha
>=20
> If the device(s) are not configurable, then you shouldn't need these 2
> properties. The driver can hardcode the correct setting.
> """
>=20
> ref:
> https://lore.kernel.org/linux-iio/20230810205107.GA1136590-robh@kernel.or=
g/
>=20

I see. I thought it was the other way around... Then, the other thing is th=
at I think
you should call spi_setup() after hardcoding the mode.

- Nuno S=C3=A1

