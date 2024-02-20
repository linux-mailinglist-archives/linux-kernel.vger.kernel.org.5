Return-Path: <linux-kernel+bounces-72999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D537B85BBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B32F1F21E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175D67E8A;
	Tue, 20 Feb 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuWRcKSh"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A165BCD;
	Tue, 20 Feb 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431657; cv=none; b=hy9gOirjqMVZj46oXVf0/FJo55ZIvFHd84G33hsaRhV/PDlwz53C3iel0nMJqnNgELCoz5eOqNKyZZT53n2JwVo06Kye41nyI6u0OGv4rR4rHtKBfyLV3NcvaCzfmCUq3ZrR9yvf3bLlgFRiQCMN3fBRu2qc9ua1n5N0dOxRDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431657; c=relaxed/simple;
	bh=AR1J82QzcekaL9KNDGEHl7j5+lUCFPMNjibpDdXhUEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tu4KIITOvBk7iE4BS1rDDHFOyyVyZxDWQwbSuFHQ3pZ33Y/okgTpdHmc9VE+9oU4pTy8VcaYXp0q6IyOL4kPdeM4tTtdK6thHBkAD+93iKvNd/BlnH9AcwCQwxwrcWJ8P3j2Gjl9F/CAwk4+KSLUhpvNFJ3JhvhcOMvJJjxAhVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuWRcKSh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512a9ae6c02so3297705e87.2;
        Tue, 20 Feb 2024 04:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708431654; x=1709036454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PDi18Ie+s81peNgcU4/hAGc3IXSIdDCsGyhzUSlE3Gg=;
        b=iuWRcKShFI0qai7rpkXlrHmTvsz97x5pS+QDEEQ4OgAqYT0WuOXqrqH9QddDljlz03
         9pb1Oy03JDc9si95cEei9pzrKRgN3CE7VSRPnTkIhcov7WjWYrEMQBdf5VaUDpEUoX55
         YWFt8e2p+xwmLVmc2jxyDoRTPVtqqbE7ZwIjMj//UW3v/v3uyxQh0J4Q9k6GSq0J78EG
         RsDF1HdLCL0cB1WmYD3bXXfMbqis8hasAoJkQjiCFnS6cSLgEG5BXIIgXhzxajXPtc0s
         6IG7s12ziZQrLvtpi8SO+0tOG4bsVifVcOE49wrMJYwGdoQ62Kbqf4eHssPYPjCw16D6
         TeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431654; x=1709036454;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDi18Ie+s81peNgcU4/hAGc3IXSIdDCsGyhzUSlE3Gg=;
        b=wLMQOJXSx+md5EtIPHPj+rwgIm+z54J6YeIKzW1K8gqv4Idc0gIz/fXOWeTcabkZGS
         k4ILwFEDpVe1MUsdOmg1l2WBXJxM1u81U6QKS6dyO9Rn2I7KzniP+cl4Vsea+YGlet0u
         GVtzCi75RAdDEHx2ngAKm8YoynHSJn1IvRv7JuZqFHxNBr3EwEO7Si+SEv1B7D76hR2y
         ULOURBswrahmcmHv9LQ6I66QggKQze8pbxmbV8kpeZRasVZEjXxI3dF4uBlVGZ72suAd
         4xE/UfHhVodxCkRb0JlDcQRLg7pvuZ3Xy95r0mS5fWfqd83uV/UDMqCka80AuerhFP6r
         X8JA==
X-Forwarded-Encrypted: i=1; AJvYcCXJHWsOgJD3OJCxtb+NDdwYFL/OnbXGNes+t9RpORVMwG0r3RqDbbx72HkXnWB2te1ym2c+RVs8k1AZhRABafgJprnBpPVFlWB0KT0MHSKVQ6NP/yoc9x5VkyjreRt2TyUPxmVD27+A7OzfjceSFowW8NyhB59eskoc6HQO156uzBiqw6/wcrN93nVg9tN7DUa/p7LPpwuyOc3iFS9C+9Y=
X-Gm-Message-State: AOJu0YyDsto35oB1VC+xMvPOWqDXFSiiSJD+mDBm67nMHN0rJ/u5ASfR
	JBhCpijS4+YzZRobJOt9DsVZVdJW25mecnGRd4oM7QS9aoXD5W6s
X-Google-Smtp-Source: AGHT+IGPwxdHUo/dctJ2Ngn2KMm46rbjC+bLYnQpfVfi/08A3miFjRBAzS2SnNRqxZvw1VG03rAsYg==
X-Received: by 2002:ac2:4e6b:0:b0:511:763f:7d40 with SMTP id y11-20020ac24e6b000000b00511763f7d40mr8407631lfs.35.1708431653979;
        Tue, 20 Feb 2024 04:20:53 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3dd52e758bsm3885807ejc.100.2024.02.20.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:20:53 -0800 (PST)
Message-ID: <fc49f36bf1df931f7c67dd195aa74636eb479e64.camel@gmail.com>
Subject: Re: [PATCH v13 3/3] iio: adc: ad7173: add AD7173 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
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
Date: Tue, 20 Feb 2024 13:20:52 +0100
In-Reply-To: <20240220094344.17556-3-mitrutzceclan@gmail.com>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
	 <20240220094344.17556-3-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 11:43 +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org> # for changes up until V12
> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---

Another thing that caught my attention

..

>=20
> +static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +	struct ad7173_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct fwnode_handle *fw_node =3D dev_fwnode(dev);
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (!fw_node)
> +		return 0;

I think that better than the above check (do we really have any case where =
fw_node is
NULL?) is to have:

if (!IS_ENABLED(CONFIG_COMMON_CLK))
	return 0;

- Nuno S=C3=A1



