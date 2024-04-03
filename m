Return-Path: <linux-kernel+bounces-129852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E1897148
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18BB1C20948
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA8E148315;
	Wed,  3 Apr 2024 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6uUKMFm"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B12146D65;
	Wed,  3 Apr 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151389; cv=none; b=tuMr3mqWr/yLVkbr9xfX3v/1/7mvGzLl2CTgUKt6H4Rb+3InNp+k9TO/vWjYxtucaqq4Hfy4yUFy0tsgPe+ddIvQchAbBCtLhxeemRNIoihhURlUltgDBpJc03LH+RGVEbXzdrApPcR1inSR2jx3npt/BLsb8rT5qjH1yTF6xCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151389; c=relaxed/simple;
	bh=67RSiyH5ZhNEcNRXgJOJ6KcqQm2hSkTQG2+vbhBdG2c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rnsAaOPsmMi7ktdt/Flnk5RRg22LHqCeoUaIidxdDeSG8MqX593CGXimnixKf585UDumm4Xz4cZpgAQIGks+AdwhXKdOiZrecaRfY7yzJBj9SmmiYs0t5kmIjeuQoKuz+rQwYCXAWGVkXsEUp7mQU5dG0BlCWxGWOIr8JRBm+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6uUKMFm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3416df43cabso4470582f8f.3;
        Wed, 03 Apr 2024 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712151387; x=1712756187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQbQ3sWtqjTwtf4KGjxXKOIIihdDWIlW3qsePHEDCsQ=;
        b=U6uUKMFm/xneSc73ifigPmpIlwU11k4oMWT/nijWy7tjaZBf0mI7BjFXb38zCW2lRi
         GXw7h2UcI6NzBicqZpU9yhBuvhFRzH7D8ZPra4gU3JF0pLHKwY6JCyZKcvgpOQqzIyVC
         l1RTyfGm6sw7246YTqe1JIWJDt644WAXfc+MTdLlq5d8gQZ/E1PK2P30FMwAj0rSUD2T
         KZz2NM5zqSOLcV2wOSijj1j8/19uVvFIgNNpKJ6Hy3pGeUArcvmpJTRgPU0UhlNyudbr
         7G2jkrLLt+2Mh+obhJFm0D9Z5Ja6X/6aTy0TDCxoWkapJX2vbJaUYcVE4mDq+wD3WhF+
         igHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712151387; x=1712756187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eQbQ3sWtqjTwtf4KGjxXKOIIihdDWIlW3qsePHEDCsQ=;
        b=GfCw2kXwczTC8AWOBnfSW4CrEiOh9yY7jCsL+VLbve5dXVhQbQev1BfWEJl6dd8d3D
         cs6qk3x06JxfxLmKkIfRyX8UShTtxZ7fda8WwlY0oKUXZ3tQF9Wk/YpXGy2WnhYuW4pn
         jIYa/pw3SVnfQpqQjstI8yIRBDnjlCu1YFmi+KjFDyqQ8hfalZysRb8LfP+Otm5MA1sm
         C7R3xNE7MqF5fBW39xeGA97FwsV/7VsIAdY8VTe/3MYTyShRr49YofiOCK+1B4FowSYt
         U43wxYW7mvvrSN73hZ1cjkwAzNy7cLrvxIgVM3r8IgCHi3muELD65BIu1Et6LF3wkZFX
         hpDA==
X-Forwarded-Encrypted: i=1; AJvYcCXkLpu44CfTvE+SLVVwBQTK3FrOEO/T5NEAZjewqFIruoLmcgNW5CYHlZs7MqtC/oujFyhYATE7rzuM4KQdMWow+gUHnzGofYrfHAaO52tcrIQUSMNGbx+XkJfkLYjiIu7/zdvRKjKe
X-Gm-Message-State: AOJu0YwLwByYMaVeXzCAm+ehUzogSKnNtliRfMlTwn6imPFJOiLC3Oij
	Xq4FseBmk9rbRg2M4imO5Pcjv3jCb4qKO+ylZCJ0KO74/YgvJlDIQ+m0LVsUexY=
X-Google-Smtp-Source: AGHT+IHsUm5/draOpcd2OPbP7/J4b9FvpKBgNz3W2auRFwut4xnMy4fib7QvtY7NqPNsMZTt0xoY5w==
X-Received: by 2002:a5d:4e8b:0:b0:343:65a8:406d with SMTP id e11-20020a5d4e8b000000b0034365a8406dmr1948648wru.64.1712151386374;
        Wed, 03 Apr 2024 06:36:26 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id cs2-20020a056000088200b003418016b04csm17342603wrb.76.2024.04.03.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:36:26 -0700 (PDT)
Message-ID: <42641ec96d5c393e4c8bfe9164b8643af2f04426.camel@gmail.com>
Subject: Re: [PATCH 1/1] iio:imu: adis16475: Fix sync mode setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Date: Wed, 03 Apr 2024 15:36:25 +0200
In-Reply-To: <20240403111357.1074511-2-ramona.gradinariu@analog.com>
References: <20240403111357.1074511-1-ramona.gradinariu@analog.com>
	 <20240403111357.1074511-2-ramona.gradinariu@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 14:13 +0300, Ramona Gradinariu wrote:
> Fix sync mode setting by applying the necessary shift bits.
>=20
> Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> ---

Ups...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/imu/adis16475.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 01f55cc902fa..bd30c3469d9a 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1351,7 +1351,8 @@ static int adis16475_config_sync_mode(struct adis16=
475 *st)
> =C2=A0	 * in chip_info.
> =C2=A0	 */
> =C2=A0	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> -				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
> +				 ADIS16475_SYNC_MODE_MASK,
> +				 ADIS16475_SYNC_MODE(sync->sync_mode));
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0


