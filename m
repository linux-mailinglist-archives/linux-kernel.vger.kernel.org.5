Return-Path: <linux-kernel+bounces-126652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55509893AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F51F21110
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07444376FC;
	Mon,  1 Apr 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+5byxU5"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DC38FBC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974391; cv=none; b=tneDkGEzzs3A9iyB+6Lp1LHqguuonO+EmazcjXEDFB53BmdhweJWNL9W67iQXAwmIE45ibksaiq9rc2MOIDTxPdQ7g6K1Rsj482hLb6dJ19NtzChImKOJMPDH/IXpKsr9SRx0tRPx3t0srDzTyFIrTB5nrB3RDSG7vJ3PdNE4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974391; c=relaxed/simple;
	bh=c2T6wibH5F5WD78oV+uJZBaTSlduS/x3Pva398zJ2NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+L/48RX+0y3AtoFigVwONXEf4fo7JyFLK+U49sewGhXkWrR+7Qg+stzXgv8Ajtbg4lreATTsP7XSqUS3klE8+GTYUA1V85/xDBLT3yw2zN1SETs2AD2Bi+gIGOSUzf2iNXRTC9ulOrF+0rUT8C3vYBPosjbXpRPDo5Y/lIHj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+5byxU5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so3583139b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711974389; x=1712579189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6feF6K6v6g7R1Hg319jEuD6xgNSbVhQOmS4a1TLMNc=;
        b=E+5byxU5lr2uIqu2X5pSa0U8wJAK6wb4zLm3JuG9M/JckVdT0RYCw3Qsqu3q+MQ4TE
         49mq8aa9kNVqp8KpZ2lIsRVxhivirfDAH9C4Nrbc9AfbvSiSX9BW2ysJ7qVxFoWbSErS
         lqtnOCrMX72gG0OOg5aFEm3tVTF6YapnHR+ug8p1/+BxuSGV26bYtBleZOwWapqGo4q5
         VK3iAsvl3GEA86prpoOP5HyWy8SFtEYDHsn60552oFqEVb2EtCIXSm/vRue9gEKnn8/7
         AFMVeniv1/YwEbtzsxugtzLmUm+MQaM14tHbfLbDSdgHHNXU3qgryudBQKYOc53sapoz
         hozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711974389; x=1712579189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6feF6K6v6g7R1Hg319jEuD6xgNSbVhQOmS4a1TLMNc=;
        b=K+Ff71Ywd5zff3Htt2ikk319pI5BEyaVjqx7NQ3/4xVY5rL7VVUyaw4Jc2Xj3LbeX+
         7U0H4VzBrps8qDfkbqBikWvSkBM0h1ONFlymEfvHHmnDV8ymmgnjw1UKh8iQlYQRUzma
         mN0YnXBB5MWBlpABu/SlakoSkzfr5cE6alIu33VrlvHCA08tOoInRFP2HzUEygp+ynh2
         MDBkJ5rlZb0uU9y9s961MD7DakkYNLKTX/mcJ5V8S/XgqjqGXHvvz1zoNLi1sMkUGn5S
         g54fJMcxn+doajK4Ae6wejO9nevf/Xz7zCLfLqPpfntqvBVY+njJIkIrQ/L5iCR3rwTa
         aWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUlPWGX4HTJS9+YrREo1phTFKDI5gm10wOlJjiwD4jHFvefgZLk+pStVoRBaXPelgwr5rbsYGwFT5f0OrKCRLbPt3z9cnOVWZe20xA
X-Gm-Message-State: AOJu0Yz6fKRvQiCQLfKdi2Xf5yMfOmrgi0tp/uMqiUIuZCxNKJzpxA/w
	E4qKtkwblg2jbs1vKJyRabBxpgDMqxLFjfkwtSQnqpmjV1JTvqca
X-Google-Smtp-Source: AGHT+IEAivMxtOmgKqQ4sG59sjkiA6GyfykFA6t8zaG5rQMJo8i/Wp4nRjMYYFNRSp2kdaCucXtiVw==
X-Received: by 2002:a17:902:dacf:b0:1de:e5aa:5ce with SMTP id q15-20020a170902dacf00b001dee5aa05cemr10304970plx.41.1711974388885;
        Mon, 01 Apr 2024 05:26:28 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b001e014627baasm8902636plk.79.2024.04.01.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 05:26:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 977C51847ECE7; Mon,  1 Apr 2024 19:26:26 +0700 (WIB)
Date: Mon, 1 Apr 2024 19:26:26 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: me@wantyapps.xyz
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prathu Baronia <prathubaronia2011@gmail.com>,
	Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Fix indentation
Message-ID: <Zgqn8izgsMI7rQNA@archie.me>
References: <20240305211416.755911-1-me@wantyapps.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RMq/zonEoj5TvfGw"
Content-Disposition: inline
In-Reply-To: <20240305211416.755911-1-me@wantyapps.xyz>


--RMq/zonEoj5TvfGw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 11:14:01PM +0200, me@wantyapps.xyz wrote:
> From: Uri Arev <me@wantyapps.xyz>
>=20
> Warning reported by checkpatch.pl script:
>=20
> CHECK: Alignment should match open parenthesis
>=20
> Signed-off-by: Uri Arev <me@wantyapps.xyz>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis=
-fifo/axis-fifo.c
> index 727b956aa231..ab758a527261 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -381,8 +381,8 @@ static ssize_t axis_fifo_read(struct file *f, char __=
user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret =3D wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -			read_timeout);
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +						       read_timeout);
> =20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {
> @@ -522,9 +522,9 @@ static ssize_t axis_fifo_write(struct file *f, const =
char __user *buf,
>  		 */
>  		mutex_lock(&fifo->write_lock);
>  		ret =3D wait_event_interruptible_timeout(fifo->write_queue,
> -			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> -				 >=3D words_to_write,
> -			write_timeout);
> +						       ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
> +								>=3D words_to_write,
> +						       write_timeout);
> =20
>  		if (ret <=3D 0) {
>  			if (ret =3D=3D 0) {

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--RMq/zonEoj5TvfGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgqn7QAKCRD2uYlJVVFO
o8s7AP93pQcbIO5XI50jdNT/8fX+13cGyDwmxZvPuGWkmwswPwEA4/xSD6mE4SEW
iaXCdqJLVhWJfdTk2viDAHS0hL4WGAU=
=Ba1J
-----END PGP SIGNATURE-----

--RMq/zonEoj5TvfGw--

