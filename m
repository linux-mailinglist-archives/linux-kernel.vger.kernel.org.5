Return-Path: <linux-kernel+bounces-104367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18587CCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1323E1F21FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5C1BF5D;
	Fri, 15 Mar 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpUHnxUF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB819BCA;
	Fri, 15 Mar 2024 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503263; cv=none; b=rcIQ8YuL2gyeXTP+zDZSz5HMw6D/OAC5dnA+/0PQjH21I/sHdsUjQcOYy2IUKEA1HbNXkFbSVeFYdGsf+0+k4QKnGip5F1HnrxYQwAvofy6M62Yfg5nikseHgrI6jhqhTNZwME1brJkSdGrYVVTa86nHo1zLjLAmfD3cp9jAIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503263; c=relaxed/simple;
	bh=AswBXoqd1Nll3PUsMhni9UdwEee82Lmsp5/ibAz0M40=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWHMILonN3mF0DZ7MS4gSLs3sAk+65Mku00s48wnJRQo/xhmtIYe6+zm3NYg9RZNdAsc5v9GGPJ/Mh3vhGHsVhrMxCkO04V8r/dAyz5d5UOcVBKrozTuZVCVOb7Br5eW0FofTmivFCllrgiqp//xtqL41pLIgs+AzTdaVIaGXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpUHnxUF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e76d653b5so1772916f8f.3;
        Fri, 15 Mar 2024 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710503260; x=1711108060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBlUH6VyFh2xDF9O9EaMafykW3lDWFVu4skyiusQ/sk=;
        b=jpUHnxUFK12f0BTl5gAr1zZmhGUG/Av7drZXHs5RH8p3t9v/67k8+qL0tXJ2lCrVBB
         nLqjZlU500dUBuNHpF48FMzBl0voW1kiRDJXZ3rEyiq3G2fJ+CA5Vdy8QO2HENLdRrfc
         XF0F55OPVfHMg4BXK3RkQYTdXcb5rX6S7SIIWTkLaTanHPozaDiwEzFknXTldrAyrz+r
         xgPk4cdCm+4u3ClPB811+iENXgDXA4nIvLAha4M4nbJ8N+5FPTUaL3F1KQLfmDtpq1xW
         MkRxnl+VDu3mhaZL7wb7WguGORBsYpYzcmH4tN1yUTtNBxVpC5iXMWBvFLAYdpdAwqay
         SJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710503260; x=1711108060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBlUH6VyFh2xDF9O9EaMafykW3lDWFVu4skyiusQ/sk=;
        b=m3HT0OVDFiJreUo+ji7NFXX8AvEg3nNzKDO3H+uzdME/T3v2OBS6jpRd1/QPFeaF34
         OrblqLLN6EDXZs7BlVY2n+NtRG8f49vjj24xwCOQ7z8Gi6BHbUER9owHGPdRRSJ1TdgT
         ITkWd/uE8pFM6pZYePB1sy+6zKaLfMdxgjD5pL2crs0Ubij2JfNDg9phXJd3J0NAlu88
         ZkpS2unStGVrUtjVJwHf6dTdT6EH+fpX8JptCYYKC8ApCmzz0L/ewS/Y0uNecVhD9ye7
         l0Qcv792wH/k3FkAifClgTO31G3OzK3/iPRGuHPAb/AixtXm7HAtSzy6f+3scZW0gcE7
         Jr2A==
X-Forwarded-Encrypted: i=1; AJvYcCUsCpaUdUfH/kGcq1ewXmNEDnbuvFVhxx5G/kLX62ytVcoFj89myuBcXAPYaVC+EzCY5hKAOQa6RnU3Bz+C5nh5pcgsLrzyXXs1zIs7T43HzpFATA5Mvea/gfdRnrJqbGeop7q32jr/
X-Gm-Message-State: AOJu0YxuYT58NMX53r1Z60mg4Ps8I02ihyiB3f90CZXQm0vIXuflQz4b
	+qn0NtywxS5Rc5+zkmjpfhgupPnK/PzFzmuRqwexbikSz6WiKGQ3
X-Google-Smtp-Source: AGHT+IHi84fX2o6Jp6CHUeDay1Tto/v43V7AWtP3llWsnohmF+j5EzC//EqLEZbyWp1SgH73pk7jFg==
X-Received: by 2002:adf:fe89:0:b0:33e:73e8:c1e1 with SMTP id l9-20020adffe89000000b0033e73e8c1e1mr3569085wrr.18.1710503260207;
        Fri, 15 Mar 2024 04:47:40 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id f22-20020a5d58f6000000b0033e7a204dc7sm3002446wrd.32.2024.03.15.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:47:39 -0700 (PDT)
Message-ID: <717ad48efa7ffc6cc1960be05558e9cbf0b6c4c8.camel@gmail.com>
Subject: Re: [PATCH][next] iio: accel: adxl367: Remove second semicolon
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Jonathan Cameron <jic23@kernel.org>,
  linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 Mar 2024 12:51:07 +0100
In-Reply-To: <20240315091436.2430227-1-colin.i.king@gmail.com>
References: <20240315091436.2430227-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 09:14 +0000, Colin Ian King wrote:
> There is a statement with two semicolons. Remove the second one, it
> is redundant.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl367.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 210228affb80..5cf4828a5eb5 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -621,7 +621,7 @@ static int _adxl367_set_odr(struct adxl367_state *st,=
 enum
> adxl367_odr odr)
> =C2=A0static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_=
odr odr)
> =C2=A0{
> =C2=A0	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -		struct adxl367_state *st =3D iio_priv(indio_dev);;
> +		struct adxl367_state *st =3D iio_priv(indio_dev);
> =C2=A0		int ret;
> =C2=A0
> =C2=A0		guard(mutex)(&st->lock);


