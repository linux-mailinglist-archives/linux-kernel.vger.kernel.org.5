Return-Path: <linux-kernel+bounces-59077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548684F0DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88221F244F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97452657DA;
	Fri,  9 Feb 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IalBDYTx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206665BA7;
	Fri,  9 Feb 2024 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464087; cv=none; b=sb7anrQwwItfCGNdoTqeg7Dcd9+laA0rFpVS7JEhjt9k4cxHftj6Jm/pdQJ4IGMcMt01fF7SOtSss+QzbXLNAtMCkiD5qDPHvSTSOeZfDFUy0x0H9DMjxfS9rBdx79EXjHs5sJZrJA2YfFV+9cS+KjY+dhIB4gaiROAdLY3ZzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464087; c=relaxed/simple;
	bh=CMPjf5ZcgIXX/5rX8wFH4Kq38vPirxh6V50ymBzFNsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGYB4E8GpKvRt2Swidruw4bUWhDlBeCmwHv9Dkxp79Restix/EglMmKWfTT/zsVyFCiUNic17pKu/SEBwHU8ZdI2rfqqNRCSeKm/JAjP2txV76Ck938KY20zU/4JstIu+5kyeAOtgAKYD8XsIwSHUSE2NvgR3MKMAxRCRu2BEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IalBDYTx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a38291dbe65so70876166b.3;
        Thu, 08 Feb 2024 23:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707464084; x=1708068884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuFnXWKAMZUaHr8SMQtDYTrcpRwqO7vAOmQCsQKVayA=;
        b=IalBDYTxXNd6kYJJDBQo9a2y7CVuG0+lLmn6YZLAu48VB3Hs4e0mU8aMnq06lrfNaF
         4kutB1/UEuhxRh01hauAMPPkYn35ZV8CZo6Rh8aqMzCdZ8X9M8zP6s8LQlQ7gUCaBrUG
         rmT9dVO+arx2acvJIeCGruOysPAzSvVinufUY1u26yQNAE70SbOktPWIpT8CszgGXGCP
         uL9nCtk6s4WHfQB1JQHfV9IjbqkBJ/e8IqjKejnmP2VQFYLinrOudEC7dOiRp50qfaUk
         IvredWLEtACZF0KEiJZr+OQ3CrFk6nTO8TVW1kiAXS2OtnrYCA6rn4xixV6uO+MbE1La
         SoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464084; x=1708068884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuFnXWKAMZUaHr8SMQtDYTrcpRwqO7vAOmQCsQKVayA=;
        b=srLLDfRS8tPFsFF5aNzM77jkFDkEkHA55BLDXsJKqJ9DDqfTWlecIYt9OoD1HOa+0S
         0cX1eAINGCf3acsNfZnlH1Odd06ApJ7LDBMRbmAziFHuc5sDrXFX8ig+pFJ38mLcl5rZ
         iE3YqL3xKW3O9sUSzmtRxpg4r87nBmmmvbLmOmyg3X+22t/+BEaCnsqpUuWYy20e8TaV
         Yc905SXi/gWzF3FeoDBHmtGzqKFrhcz8Qc84KzSe9aD79SYMFQH4S5DIelpI0wpqily8
         NLTkd2Z96IUOF6gO+PiZoPB00k3dH9U1zpZxYGLDrsvnTaI/557U22U0vkFUD+vSe4CP
         xMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2hCPK6YfTvGK7/8JDNgH83Yx9KSZpAbmbjgiqtX7BJPfty75WHeBZ6hf+j6VDt7fXuRpziXPgoRHVNd8gnyOalrD3i1msA35PMfSF
X-Gm-Message-State: AOJu0YydtfRj1ewAW76Y3MhnaOkcQJPGoDnuu9JrHariaOHKEwFOaPTW
	uEXvnoktd2WI/6V0lChM/x2kbGQ840Wm5A+onhNVVGutl+PEuAin
X-Google-Smtp-Source: AGHT+IGUKKHBefz7fx7UIvUnC9l9ovj864pSj6cuFOHkw0xi/FG0eSLqGEuaOsa9GrrsimwbRw+diA==
X-Received: by 2002:a17:906:2dd5:b0:a3b:fe66:1aa6 with SMTP id h21-20020a1709062dd500b00a3bfe661aa6mr111799eji.53.1707464084171;
        Thu, 08 Feb 2024 23:34:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUxh2ZM/zOopClfurLS95s0uJ3GEQPK7RrTf4GLKvNcpyJQgDypMcQ82QPDLpn2WlO+JyLo2kCW2D7XLBpmNLD1ZvG+uDIVSTSBjS2S5si4g4w5ymv1FfMz2JvslH3SC3AdSejRCNBOlcVvHD9DeZpAqB80aBxgzYvj9Z5LUXaZf4gMbwPmgF7/u2c
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709060a9800b00a3845a75eb7sm480523ejf.189.2024.02.08.23.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 23:34:43 -0800 (PST)
Message-ID: <77e7ed84395c716e17d783e9411fd57ad8c22295.camel@gmail.com>
Subject: Re: [PATCH] iio: core: make iio_bus_type const
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 09 Feb 2024 08:38:03 +0100
In-Reply-To: <20240208-bus_cleanup-iio-v1-1-4a167c3b5fb3@marliere.net>
References: <20240208-bus_cleanup-iio-v1-1-4a167c3b5fb3@marliere.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 16:37 -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the iio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/industrialio-core.c | 2 +-
> =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index e8551a1636ba..9b2877fe8689 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -42,7 +42,7 @@ static DEFINE_IDA(iio_ida);
> =C2=A0static dev_t iio_devt;
> =C2=A0
> =C2=A0#define IIO_DEV_MAX 256
> -struct bus_type iio_bus_type =3D {
> +const struct bus_type iio_bus_type =3D {
> =C2=A0	.name =3D "iio",
> =C2=A0};
> =C2=A0EXPORT_SYMBOL(iio_bus_type);
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 4f89279e531c..e370a7bb3300 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -669,7 +669,7 @@ DEFINE_GUARD_COND(iio_claim_direct, _try, ({
> =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0
> -extern struct bus_type iio_bus_type;
> +extern const struct bus_type iio_bus_type;
> =C2=A0
> =C2=A0/**
> =C2=A0 * iio_device_put() - reference counted deallocation of struct devi=
ce
>=20
> ---
> base-commit: 81e8e40ea16329914f78ca1f454d04f570540ca8
> change-id: 20240208-bus_cleanup-iio-1e5714e23bb9
>=20
> Best regards,


