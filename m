Return-Path: <linux-kernel+bounces-131144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B508B8983AB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6C32826A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0977353F;
	Thu,  4 Apr 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGxIBB6G"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEE3D96B;
	Thu,  4 Apr 2024 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221201; cv=none; b=FHoJfDRJJkzMvvfs5Qc6FUuXF3OEryRf9zXc6+D0ia+cD2Yv7rHoJruhKhk6In1MYts0+pXPYp4kG2nj2Pq0i1R5ciDaauLNj40O7z81RNs2sGjNH7SESjM8z1CVDU5IlI+a49O5UlemPcgMXbR0uGHYE6YrcVUSYzyajnkSyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221201; c=relaxed/simple;
	bh=zFV67fOp03KxbIcwK8vP/lP0IGis8ozPjbOeUJBXnYQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVQnaCuXZs7QRNhrj8YozhoXq0oIAQTv9soXpTvbpfJp09+t+D/0FTDZ+Fd8sK6WLFdEOFnXiZM3jQuC7n1joohpejkkEcovzZmPWl1YIByRSJ4OybsmUTQYewguFqYZPNKkAmcg1vq64VC95hd/+te86HjXG+qgBZtFkY2N2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGxIBB6G; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so651882a12.1;
        Thu, 04 Apr 2024 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221198; x=1712825998; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OOhldulBQUILs95IIEuLjdbv/PRLLb7tYoW3G02BM1Q=;
        b=fGxIBB6GwGSg3ORo18n22QSxykmpNuOSZRPpKYz+S/Zft55fOunJKt+v0uttlFNNsr
         D+dNelPqOphSF9H06bUWvTMdBw/bv3At/v7f4tUJml+krleLtDPHpVwd1MQ5sx281biK
         wZKxMpP/RSAjsEcJeeTtt2g/qBrXEXdDlhCcWdpWoSaLhNYvrlKiTGIVN4adnLQROgvn
         8mKVkSlHgTFPhbZtSfynG0pgG1Envkh7KaablJ6U5C2YvG2dkbz3h3+3KkHDufBI/h7M
         1kHibHUBt6VbSDJUyKzY3ktDy6nKrkzGfJvmniHQKyOFZUpnBUdCEsx3uPmu2mHnrvjO
         5YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221198; x=1712825998;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOhldulBQUILs95IIEuLjdbv/PRLLb7tYoW3G02BM1Q=;
        b=XB6TZs67WoGRh6I2o/ToxT97Ng1ENlDN0R1rB0qZmFcKwQeW9CBHy06/2mHVdPWz7u
         S3kq2tLOcB7VeEd4Hm6eQbjShsJo2J0U1xajSAMaRWT65dgr6xh2mNbEGJER/GNJ/Qcj
         GXQxGDpLHn26wX6GEaS2SJYiejmrRhUQINYir+prTYYmVeEjkbDD+ADlpjTAtRVXWnZG
         rIVANlBWBbqh8nwiUqYyhHwHNYHP3YDBK+Etnp3RH/shWweAoe1+Qp/B26DW07ggTtIt
         T60IqI86CHYZZlacejAdUGA93I+hvmOXhBFirEDNB2E91JjJaek+1ox/n6PlOgngLh6m
         9c+A==
X-Forwarded-Encrypted: i=1; AJvYcCWuW0RGgxM4JB2dyxNI8sxFx/g1N7l2hxx4yETdoK/HCe9tYqXgWpcWbfs9rfMtFxMZHl6/zXq2L9B4r3SgAmPSb8kaOatRbdRAiSahbsi3MrNc8mn7f04H6x4ptqh2kcTF8OU997v/sUaWUfzvipHDXW5T92Ib6A6ka7R+I9Q9X0WF+FGKFJfJ
X-Gm-Message-State: AOJu0YzRbtCx0MYyMlMk27hZocZZHGh143l06eafpbybtV0zsSctPiL3
	YdlnvfgA+UMTj5Yu3g7ovwncE+zxuQbk/+ZiUxoeRjdIqBLBAvXuT5A0zqShWxDv+Q==
X-Google-Smtp-Source: AGHT+IGY+C7YfnEBCwiRkSDQ7u8iEooJJomfeXMR+JEgEVhZyoKeF281Qcvg+5HUFUHi+lrqfU8O4g==
X-Received: by 2002:a17:906:2314:b0:a51:7a24:4de4 with SMTP id l20-20020a170906231400b00a517a244de4mr1422298eja.41.1712221197942;
        Thu, 04 Apr 2024 01:59:57 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id i25-20020a17090639d900b00a4df5e48d11sm8805509eje.72.2024.04.04.01.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:59:57 -0700 (PDT)
Message-ID: <8faeeb203456ceb8c07c5f2a46f8a7b367f574e4.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: Fix ! vs ~ typo in ad7173_sel_clk()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Dumitru Ceclan
	 <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Michael Walle <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>, Nuno
 Sa <nuno.sa@analog.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Date: Thu, 04 Apr 2024 11:03:29 +0200
In-Reply-To: <5401c681-c4aa-4fab-8c8c-8f0a379e2687@moroto.mountain>
References: <5401c681-c4aa-4fab-8c8c-8f0a379e2687@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 10:31 +0300, Dan Carpenter wrote:
> This was obviously supposed to be a bitwise negate instead of logical.
>=20
> Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 4ff6ce46b02c..b1d6ea17ced3 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -835,7 +835,7 @@ static unsigned long ad7173_sel_clk(struct ad7173_sta=
te
> *st,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	st->adc_mode &=3D !AD7173_ADC_MODE_CLOCKSEL_MASK;
> +	st->adc_mode &=3D ~AD7173_ADC_MODE_CLOCKSEL_MASK;
> =C2=A0	st->adc_mode |=3D FIELD_PREP(AD7173_ADC_MODE_CLOCKSEL_MASK, clk_se=
l);
> =C2=A0	ret =3D ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 0x2, st-
> >adc_mode);
> =C2=A0


