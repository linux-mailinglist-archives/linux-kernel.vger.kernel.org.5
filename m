Return-Path: <linux-kernel+bounces-57590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40AB84DB1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FCA2839A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217396A02A;
	Thu,  8 Feb 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSsAsX1H"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AAE171A4;
	Thu,  8 Feb 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379913; cv=none; b=Ub7UMVRI0nzC3yuIhUQdZ+b1ncdTeIyyetDLyUz1j1IE3jQTzwmS3rtEs7TuEulW6PDTJn9D6pUWJV9uQWHcXk16nvsilbVPuhfF6wOErQF3xzgaybt/Ll7wpkoIw4u5dO/mvLcpy97X9CnSCWbDSADVsRFsoA8MR4eZ289MrC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379913; c=relaxed/simple;
	bh=961XXUYAg7flUndFM6MqR2FMjasU0hzE16yiPbWwwHg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y4M7Pos+TVwiLXXZao3SVeDYnfDd6y/8p8FL79TinzGsO8kxFLqqvPqcd6QjFz1nT2mY9SU6u30qzYwv7Wz0e2b1bk25znLxvRNpTBa0VgF5zegl9ELHiPjQD5zsRSAPA4IgPKNpqW/6jgi7JulOAhsljjAey1tubyJ8NxzkN88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSsAsX1H; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so2251564a12.3;
        Thu, 08 Feb 2024 00:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707379910; x=1707984710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OREw2fCwmTOMl21TQGPuH4XMzXOOzUHUl3pryOOA5T4=;
        b=JSsAsX1HNFPqZJy7qCEdWjJn/hm/RrYNVdL21zRA30vxAvgRur6h2c1KhUBrh7oxIE
         dbGkWZPEiiRK6UzcXzoQnbR/HnmqBhGvEmpa/qtTxQVOrRRzngGC9NIYhEviBtKRMvlx
         3zpLcPzBVc2yRE7X9JdhTVP/wCTv0nNtOE28mzlBn7ygU6ksGWrrpHUbP18d2+HoYKSo
         bCio8pAGpD+5+JjkYrT2v+vmvnBPlx4dfP0aoBYskIXPPC5/8A0KIGNdvdGRzdQftTHt
         Zpx5bywdczJjFnraRmSN4vFjit1MMW1IwfZqCRm0i6ZLfJujZEE6G1S+qtz6+AFPElLj
         IjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707379910; x=1707984710;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OREw2fCwmTOMl21TQGPuH4XMzXOOzUHUl3pryOOA5T4=;
        b=a8EPxRxG3tzGoflhj9RBF5oncq3TwN1C5s+f5NDdOf83ZbUe9mR245KaJdyl3gpcvY
         /MrXv/IU2Pw2lgED6sGMdsHxzpVSKhfTJs4WY40mWZfMl4Uz8HUoN/rUQVupZHfKq3eu
         SWFsnbnorZZoK7fHR0E0F6tH3CLjBzV5cl2++yPHn5OKUYME/vqCX4cefS554X0frDPH
         pkKiCFBe/xeFW4wevxA+rGrJ8/A2wA5hvWLAGJM8FpFen6pJwpvXWFCCnh71bM/N8SXz
         QnHegnYRg2NcfIzzw35UrBwLNc9RtiNnsvKPBHqtaXqQ3hCvI/Rui2hlRcPL3pxoboHR
         tP9g==
X-Gm-Message-State: AOJu0YzPqonrPkZNaHohOK1U31P/ed8vBYX2xSYR4yHYrVgMpOV8T5dG
	iZlXBQzl4vDmzzPH6/mI72NfIFpQm6w7AZDSUkji1LVlmI2mN5tt
X-Google-Smtp-Source: AGHT+IGnXR5BJFklRFdJYPpIREQovNNS62qBg8rA72sgc8HGGBvkOtq6WFlZNCBMtlX6XXaP39UT7Q==
X-Received: by 2002:a05:6402:645:b0:560:5fc:4c9e with SMTP id u5-20020a056402064500b0056005fc4c9emr4541341edx.41.1707379909884;
        Thu, 08 Feb 2024 00:11:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTEkTSSsSduVuXM9x4994Z3n8VN4h9dZF9DLuYiQcX1oMmyytSD8KVrFPlFdtnaQAJ5AIqWKsBlIf7/G3dUkJR4+GnJ4Kolw3oQ7HQQoUxYiTFZF7ajVeNBH0OPt9Ee2fkkS3+FV2Lm39io50LOFlqy9uDZUEstFJ5O9BecTCZlw1vugoys5O8JvmQ7iKBNVW6zYX3Mw5dscopbHr2ei8oNntGQlKUBED9trveEMKw2ViYNXtEm+Ng0OUM2nrgyok/h1A=
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id w8-20020a056402128800b00560fe987dd1sm504206edv.28.2024.02.08.00.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:11:49 -0800 (PST)
Message-ID: <fd81a6127a9b7abb6eae0785281836a238af8b57.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad4130: zero-initialize clock init data
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron
	 <jic23@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2024 09:15:08 +0100
In-Reply-To: <20240207132007.253768-1-demonsingur@gmail.com>
References: <20240207132007.253768-1-demonsingur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-07 at 15:20 +0200, Cosmin Tanislav wrote:
> The clk_init_data struct does not have all its members
> initialized, causing issues when trying to expose the internal
> clock on the CLK pin.
>=20
> Fix this by zero-initializing the clk_init_data struct.
>=20
> Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
> Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4130.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index 53e19a863198..c7df499f9775 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1794,7 +1794,7 @@ static int ad4130_setup_int_clk(struct ad4130_state=
 *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0	struct device_node *of_node =3D dev_of_node(dev);
> -	struct clk_init_data init;
> +	struct clk_init_data init =3D {};
> =C2=A0	const char *clk_name;
> =C2=A0	int ret;
> =C2=A0


