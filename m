Return-Path: <linux-kernel+bounces-64082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1E8539F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCC11C22B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1C101E8;
	Tue, 13 Feb 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KruYy6I/"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DB5BE76;
	Tue, 13 Feb 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849188; cv=none; b=VgByrfXtEKoT3GzNR1E5IgtP2QjqVFv+zJuYn+mvICfoABI3pGTusouWaU1dvGCs4V+2meol77H5/GDfV+M2j9Dnlrpd9gZi7KhlcAGlO8YEbLn37ld2+eJa8Iisa0CzVBxXgPdVTq1Ln2O+ZEsZqjvtwCbbJPB359as7vVFXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849188; c=relaxed/simple;
	bh=e9HGOQ/n6jL9fKCLwsx+pvE+M/jpyedKt8hknX9BeAM=;
	h=Content-Type:Mime-Version:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t3L/ZtQ5qsKeDBCGcOjBNX6FYOpe01w0Mr3XkHrMm5J6CaX2Ze23qcBOUyD1kJWqhG3iaehBAMiQh2v5i4nkEFCt2hfYOpiFNO9HTBbMXMC6i4VoVX3CrmToMLkeI1cy8msF9xCnLUq+QTl2SH7B8pNChMoNAi1S2LQhZcS56/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KruYy6I/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3566c0309fso571527166b.1;
        Tue, 13 Feb 2024 10:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707849185; x=1708453985; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B+PKDVGpsuB7nKSWQah+oYoMU6sDZbj7wuhtnl88f78=;
        b=KruYy6I/cAtsNDq18GPU43gnqDTDhRhQ9kbWS0Q6RC5vPy1tkccVPZ9KYygeKaU5GO
         21Wu4zTw/jr5NwyITyLv9Gutg9zDuqduubwOc/IuCy1U9mpomMxEz90fOYUWEmvulzZa
         KUJCo+lLxpr/C+wESopA0RV00SoCHLUa3/Osq8n3Q6vEHGrquX3EPv7K2vlTuKy0UfmF
         FnYNikn576J+ci6k1BPEVnXQN1fbVjIBven3b6az97IPJ2291k0a0F+7HPI7ymPI07bk
         zX5pwAtoiGjqcxxDS26Z4/yEen3sO3licgREcLgdWkNdFhXd1Di0KKF4x9Jf1m/eLpJC
         Gbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707849185; x=1708453985;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+PKDVGpsuB7nKSWQah+oYoMU6sDZbj7wuhtnl88f78=;
        b=ExxMi6YawUj6YXgW4ENU0LGRljjXeCOlUPgGIVm0vhQLDeaTkOHFIt8s/x5R/o72Du
         5auNbU6p0+fu4Q1ty2eDyaBrCIVhaInD5LZPyVYu86F66iU21JAJ1FS3LH5l5Jwr7ETm
         rGCeK51KpI1JwhZKYwg1FtSSXPkM1Od7WP5l39rjRUzMOhABJir+P5q6ArvEDMFELaHY
         Guc0EZa6i8EUfsi7zGXW1KF9UyRr4HBqPIqSFltJ+RUbMUzrKBUyqaGnCD9BNFGjLLPu
         hRIE6bdNGE58dqMh5Sl+L7D2fSHHTTAz9hxIfxYgDWIg6xzcvpvphnLR2FErlwkvrtBF
         wRrg==
X-Forwarded-Encrypted: i=1; AJvYcCXTAcdQh6iFIJRwq3lHX/YrXLf/pInd4dpqvHznZ/L9FYFtJ04qd7glt94U6quZ7lokcfqQwB9tGRmNeVzKOGj6f9ZJPpW/huFf9v7wEuY9oIOkxleda284NK5muGthvc7wleVWVAN8VkQ=
X-Gm-Message-State: AOJu0YzI/fkHz7uIVH0oRCNfuKDO+2KYWQSl7NZGDBHcJdoRpNMkhEtt
	MPAxmPAJwLBzz/+RJ0Jv9FPUYsqpGgaBPxh77dtSjIhCYbowaSs6jOBBXecN
X-Google-Smtp-Source: AGHT+IGUs4TucCGfmD5ueF97+M1k8oOPVOqap+bz5i+YMzT3KIZDvbFd5xlNZtAj908r6TpXF2eLFg==
X-Received: by 2002:a17:906:c44a:b0:a3d:14cd:f5a7 with SMTP id ck10-20020a170906c44a00b00a3d14cdf5a7mr116597ejb.24.1707849184936;
        Tue, 13 Feb 2024 10:33:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxKPneMdwPQnliJ/gUlhKG9r4ipF2STxArjZuwsHs2tzXcEZM8Qz+eP+bsl5azng37Z77u1C6pwdTcpQ184oPIfgZrJuj8f273xGM0ZyfUQbvijMqomJRx/7mAIgEUTZTkWy17pBUc7J5I0NgoCYLzUaUgaeIcTiKqEJubv0i8o7dChwwE9FP8F03EYe2YmFJNjio7RaEZA4h+Znj0IYWWUGsrJk67UwfvZ/CbnHEJutctNoyB9uKKvBu0+P0818k=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id th8-20020a1709078e0800b00a3d1897ab68sm526708ejc.113.2024.02.13.10.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 10:33:04 -0800 (PST)
Content-Type: multipart/signed;
 boundary=0a9fa848bf13dc3f6d68d18f6c155adc6a5a027ae555b6806e8a7e69f548;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 13 Feb 2024 19:33:03 +0100
Message-Id: <CZ460BUC6Y7D.1BJ8X9RRVRVPE@gmail.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] gpu: host1x: bus: make host1x_bus_type const
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, "Mikko Perttunen"
 <mperttunen@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Daniel
 Vetter" <daniel@ffwll.ch>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240213-bus_cleanup-host1x-v1-1-54ec51b5d14f@marliere.net>
In-Reply-To: <20240213-bus_cleanup-host1x-v1-1-54ec51b5d14f@marliere.net>

--0a9fa848bf13dc3f6d68d18f6c155adc6a5a027ae555b6806e8a7e69f548
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Feb 13, 2024 at 3:44 PM CET, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the host1x_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/gpu/host1x/bus.c | 2 +-
>  drivers/gpu/host1x/bus.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to drm-misc-next, thanks.

Thierry

--0a9fa848bf13dc3f6d68d18f6c155adc6a5a027ae555b6806e8a7e69f548
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXLteAACgkQ3SOs138+
s6FRzhAAgolp6TG5UNvoKNh0Qhzl1mr99uhsEB1A4oLSmdi7Z2KUPwmzs9FJGZRj
2GwJBb12PzksSMOE3xIBNu3EK45diHi/00lPKjPY3jiaR08AtLaMcrPmy/O472fW
d+JiyHMgne/SLoOuJvxRryx+MPZMrrUoAgIM574jxLOaWbNV7aCKjQVNoLhPsL0/
ZKmvowbL6NTUVprnL0NvmblY4bz98JSxWXAN2f6EO34lo7gVhqDyk1IZuIWU4RBZ
SD1VaVldr0g3PULLH6VVJe0hH/Mxoi7V/I4zlI+jagKpHdF6Brr9ViD+R/AE/tFo
G+HOWjmC/OhJvBiW0/DXd51JyhwJVVqNYN+Qcbrdze6L4EsrxLAaab7L2rzrc1Bu
3mWIRZ2jCQpNjEe0exAf1FQHddT+R/5gvLWAZr6szDD4uSV8crXgiEJl9dBssu0S
z29PO+JNbnlvq5DcDi2iDtNoy9IAEdfCQk7v76IhXqBH7uZAEDfWVDF20CtNmk+/
alfvn+nNEXzldW9+UPs40uYV88GfcbP6EIqN/SN4MxFXxtK3TQe7hKHjOVlXIT8E
1f06zctOOTWczqXO26JwF5ObQh5tV8CPMwTXhP2n8WzeDcDuAQx7VHRe4/UuHisC
L5n+7+GHCQdYDCWr8V920HmYiiB0/KBODHeeZXmkIE9JWDukODo=
=aI8z
-----END PGP SIGNATURE-----

--0a9fa848bf13dc3f6d68d18f6c155adc6a5a027ae555b6806e8a7e69f548--

