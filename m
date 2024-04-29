Return-Path: <linux-kernel+bounces-162185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CE8B5758
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49291F23000
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4BD38396;
	Mon, 29 Apr 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWhZaw0X"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448953383;
	Mon, 29 Apr 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392151; cv=none; b=Xpt3+bEs7o8meSIQ6hUAqOfCT5X4hffYfw1RFHpgUU9JXw0A4hSl5KKoLdVC9rJyD1TXL4SKfL0ygyeQ/BUz41s1FQ06e2HDevy1AZdV8exHPC/11SH2QJ9TcGj5fyS8/3oOKhP8oSeIxl3PTVbeeM7gj2jSY0S6+Lsc05qbQrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392151; c=relaxed/simple;
	bh=y+5yRp4hZZlhcS8Hnh7ujBkkvEUXh6QrchD4YdBX1c4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZTAeccMMiY6wsEGnEb3/7azF8tD2wiHWO68ZQ/34elF4SujY3sj/Rk92WyUW3yU0A3a2k8oB5SRlISFbXOlXUz7mDVlhb4f+Fj8KzzfXVFzySuZEx/oXEpahp5Fn7GBn+uONoSpyTL3OzdaT4h1rU9KQugTct3NJXy+dxdwYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWhZaw0X; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so4505635a12.1;
        Mon, 29 Apr 2024 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714392148; x=1714996948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLFNprZuwHsZtlRkA4qR4RqYKlel9cjffFWXRNhhgPc=;
        b=LWhZaw0XMiw565y0MyIEcFalbvRHGcpZXDoZYn3+S4SJxQnhtDiFGLcva1Id+uahns
         JVFPnJ0m/EFA/l2xENsBNeVUbLFjVAuxYGX/cKQmq64NEnrI243BiGIEU2Vnthym2faZ
         4l0neufTvUgDukl+C1Rs8Vk06oXKJMMueZHEQw5xNz56/O42isaMHPSivmb+aBhK3wZa
         gW6pMvLSS94UEedDgCpkFk8SIjsXAAXJu2vmso/cxllKzixxd1ZAdtR7iXDHBuEvuOT/
         Ey2duNswZdqQR2Qn0atDcQpqK4OA9v9V0/ZfiyxXdnNJ1gveh6w4iY0jJaaZ1HSZAXNs
         s+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714392148; x=1714996948;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLFNprZuwHsZtlRkA4qR4RqYKlel9cjffFWXRNhhgPc=;
        b=cpxHmwKi3iAOwL4Pe4FKZop8n1S24ZxLxVlBn1vx1qe5bVVTCqs3BTSmOkLuAYcFd8
         0C5xwtU43A0fGsGPy4g7RL43LfnBy18kmaJe/dQ7FV6DUk+gDLD9lgy0hoU7YBI0VoBk
         5fOw6CU3hDwWLIGTuA7Fmp5idP28+lfFxbtW/+CgZwzDxqLKCXM1F42lpSvgielBlOhY
         T0oPI2PSQR7PfZhdaCIs+Q/LITd5ya7v6Mo3fr+1QkbsBhOqXP9faI4KpMNkKBcY3zbY
         oeSF/bpU3/nojgaHN/hgbd8OizffDhQdRfyaIcmVTIq9dT7j9KMl0VwiqWPzmIbTQ8qe
         dtvg==
X-Forwarded-Encrypted: i=1; AJvYcCXFHSYPC82QGnjHi9V1autPXVF72G3gq+sNbAv6rriyqUthodIDql1UEoPHDUy9fcxLbaJb5pPZ/8yXXob6ejj4AEHVJx+wValwGgQaUKSnmeuKhoTOOktg0a1nMPlty7RpnpCnsSeT
X-Gm-Message-State: AOJu0YwFRdRXGofv2+5INU4/C+KR232R3Rd+hzB2E+/WBSOwa7za7EFi
	y1DmT20Pl+3kgeK0tZ5NkqH/75oLq/0VmuTB9go+kxJ9cqlhSa/E
X-Google-Smtp-Source: AGHT+IHCwhcy1snUeqwen+Ie6UtT4Ir4L5ehHoHd1ao15B6fwE9gQFFI/3DtMTy2yR2SLjPrJk5b1w==
X-Received: by 2002:a50:8747:0:b0:572:71b2:e200 with SMTP id 7-20020a508747000000b0057271b2e200mr3427265edv.22.1714392147757;
        Mon, 29 Apr 2024 05:02:27 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 15-20020a508e0f000000b005726e5e8765sm2640289edw.3.2024.04.29.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 05:02:27 -0700 (PDT)
Message-ID: <1d9cdfa05150a389433aa399b44fcbcff5bed258.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ad_sigma_delta: use 'time_left' variable
 with wait_for_completion_timeout()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-kernel@vger.kernel.org
Date: Mon, 29 Apr 2024 14:06:05 +0200
In-Reply-To: <20240429113313.68359-2-wsa+renesas@sang-engineering.com>
References: <20240429113313.68359-1-wsa+renesas@sang-engineering.com>
	 <20240429113313.68359-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 13:33 +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeo=
ut'
> to
> store the result of wait_for_completion_timeout() causing patterns like:
>=20
> 	timeout =3D wait_for_completion_timeout(...)
> 	if (!timeout) return -ETIMEDOUT;
>=20
> with all kinds of permutations. Use 'time_left' as a variable to make the=
 code
> self explaining.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index a602429cdde4..40ba6506bfc1 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -206,7 +206,7 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0	unsigned int mode, unsigned int channel)
> =C2=A0{
> =C2=A0	int ret;
> -	unsigned long timeout;
> +	unsigned long time_left;
> =C2=A0
> =C2=A0	ret =3D ad_sigma_delta_set_channel(sigma_delta, channel);
> =C2=A0	if (ret)
> @@ -223,8 +223,8 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delt=
a,
> =C2=A0
> =C2=A0	sigma_delta->irq_dis =3D false;
> =C2=A0	enable_irq(sigma_delta->spi->irq);
> -	timeout =3D wait_for_completion_timeout(&sigma_delta->completion, 2 *
> HZ);
> -	if (timeout =3D=3D 0) {
> +	time_left =3D wait_for_completion_timeout(&sigma_delta->completion, 2 *
> HZ);
> +	if (time_left =3D=3D 0) {
> =C2=A0		sigma_delta->irq_dis =3D true;
> =C2=A0		disable_irq_nosync(sigma_delta->spi->irq);
> =C2=A0		ret =3D -EIO;


