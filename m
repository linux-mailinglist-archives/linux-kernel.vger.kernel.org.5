Return-Path: <linux-kernel+bounces-79582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E364862475
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C006E1C215A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76B25575;
	Sat, 24 Feb 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+5tO2H0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670631AAD0;
	Sat, 24 Feb 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708773408; cv=none; b=rm71FMDmfrAY/GttJz+EAoAwHt7FLmwMt+K0al95mI9gmpMyDvtPBfTIXZ8y3QDWyIAMxxPguIZyvgdsZ4wCLRkrcwEgqpQp2RFE7Dm7nJLeW9npJ3cs+bYKs96PrZYvS2yNundXqb7yCcVrliLwIPcrGxlGOmXqS0Ip0ekzdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708773408; c=relaxed/simple;
	bh=kZ8hJX47ATmYK50lOCZZLNt9mnM0+5Oqgb74LDAGxXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Smbsjd3qHgyKDPlKV4Mw35St74wRJps0VbA6J5Qb/8XwHX6uPhzUsx6a+eGfeic0hImIh8Konbjrk5ixfpwKZH2fh+DFA9e6hKEDe6fOnmwvXiKNsn52vdbshfa0nfHaqnB6oA+2fbvyW4wSWsByAUcsWGqTEWctWuq3qj3kzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+5tO2H0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD46C433F1;
	Sat, 24 Feb 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708773407;
	bh=kZ8hJX47ATmYK50lOCZZLNt9mnM0+5Oqgb74LDAGxXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+5tO2H0HmfgJohhBsvVsIaDD91w27TxYbQ2rPH6eriOKcA24DldHo2E7e0NQ1sHd
	 037LgSkiMM5OyfcpL/bjnof2MmfaqB9WTiryUltReYsCa1kLGtB6nYB8R4TQ7siaXT
	 8j/tm+VByIs5ltfqDI+S9njl7J7Y0ARJmjab5dkAQ/EkPmY+qLapVs5sJKyP3GL8o4
	 0qhdfqfsyf56PsXCGnWuJ+FIHlQVEfKjdmDqFv1gG1DmORmEiSTSe7QwiExA7bPC8M
	 znSmkkYBQHUTp/sRiwlcru1BZctdCIbqzphbXeHGZ8mcF2j/38wbIOapPkCBXoKVtm
	 NgQIc2yGGs/0Q==
Date: Sat, 24 Feb 2024 11:16:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Icenowy Zheng <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, Shoji
 Keita <awaittrot@shjk.jp>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240224111633.1485c165@jic23-huawei>
In-Reply-To: <bul6syabdw353oqomcbdz75b56q5yjgslczbw7d6yxfkxvy3hn@3yz3yusfzrlo>
References: <20240216185008.1370618-1-megi@xff.cz>
	<20240216185008.1370618-4-megi@xff.cz>
	<bul6syabdw353oqomcbdz75b56q5yjgslczbw7d6yxfkxvy3hn@3yz3yusfzrlo>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ond=C5=99ej,

Quick process comment.=20

Please crop replies to avoid never ending scrolling and more importantly
a high chance of what you actually want to say being missed!


> > +static int af8133j_probe(struct i2c_client *client)
> > +{

..

> > +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      &af8133j_trigger_handler, NULL);
> > +	if (ret)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Failed to setup iio triggered buffer\n");
> > +
> > +	ret =3D devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register iio device");
> > +
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > +	ret =3D devm_pm_runtime_enable(dev);
> > +	if (ret)
> > +		return ret; =20
>=20
> Ah, forgot to move this up. Oh, well. I'll send v4.
>=20
> kind regards,
> 	o.
>=20
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return 0;
> > +}
> > +

