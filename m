Return-Path: <linux-kernel+bounces-70207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C08594C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C173282F11
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D53FC8;
	Sun, 18 Feb 2024 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxXswUeI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E62746B;
	Sun, 18 Feb 2024 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708234397; cv=none; b=Jh0i2gyI+oSbfBbMyAhJd2OFwfBJvf7NE97uOA8hpWuFF8ZVHc4LrppOEdFYrYmlIg7fW56/oiew1qf4V2qt9c4dz+qM407XfA1We9iRmHwnQQVvKhVP2xdU+7tFUEZ/BaJ1oLIW7yUCyRW9Rs5H+Wsm/BKXQz8LeU7TS5arOy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708234397; c=relaxed/simple;
	bh=GqNYA2Bj3/SL4As+R9FGWzLCJHAv3u/RQsuABRTN2Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INUvOz575fAtA7S0nRaqoZlnR6d3m5nefLRkLhwMY6+kIKAyDrgENLbY5mm/IqSYAE2Heyea8d+vNEhOE9DKCGQ57UliRqFpUx/qT+14VYJSE5nKWaXHhVYG1dm9bVq4lxLGJQzT9RhivFuxUmfDU5okvV9tZ8kxiFkcGk+KrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxXswUeI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1631859a12.1;
        Sat, 17 Feb 2024 21:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708234386; x=1708839186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y68dTqA0jekNS95QL0SJwxszqmGOVWXly2G1K5IHR+E=;
        b=YxXswUeIdCGtUxuUv1GCyUahj2FJOSqrtmSt9jAHe9WUT7zt6F1Rk9aLuCVPPOEC7C
         TmG+5vTcopPs0k0oM+bTTWwq405LplG1gjlLQAJj20hb/pVWSrm0pAOFgMg7m7Iagr7t
         Kl/y43ENRbrT9yxYVyFakBKUsz98cJPEySpL0n+jLhw7UykV4zXv3RhOuJT6fnR/Q3EP
         B19NtW5JlW3rQBxLHb+J1tv2nlte21PtPOvzmLBRurILLNfXJhpyQApFvYL21F69FqBB
         JOfv9/2IPMXSyH8XBNIN5rym5uyvT1r+ycG0Fw+fcQ/iWc6FA80qIxTW8y4JMZAhcYcI
         cPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708234386; x=1708839186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y68dTqA0jekNS95QL0SJwxszqmGOVWXly2G1K5IHR+E=;
        b=hknpUrW/vcmkTgjlkMSQM8ZdtzLXYfdyXvsNE0KTmWUgNit4TUHN6aIUzM5ViMvuaS
         XQMG3Ke/haDvjxXGDWRisVqmJJPbgoW9atZZEZTePunDD2iPnAj0J1hmkp4tkvQM3oJi
         EluTXb/2sGpJnBuzmThKTlnOIaVkamjEk2yz7bNY8vLD5dMAoNskeJby4t/Ynqfbgrvr
         LUzxGu48LqkB+YBa465PmDDqzJT2nmQgbgYXqONX2ik78yQ8aX8MRJWo7E+FSmIy9N9N
         QMD+7pXqTAsZOk7njKfVlZL0rBebBvWxc4BSCcc/Z9iUXNdOfEWXw729j6OXcXdC4oBI
         Nx8g==
X-Forwarded-Encrypted: i=1; AJvYcCVvq2oeT99+j6wq9eo4XBaxlP50vb1oaeV27s+7wOy5PNxwWx7WUXJhr6q2+T2358rs1RZ9eScASe2SPwzqgnuD72BxIRYIQlsL1vAIc5KU86u/TiWV1lI08WP+o1XVQaQ1SO8hB64SrcvS
X-Gm-Message-State: AOJu0YymsNrOtzRh92PpLs1KC7ggQJIhSU8qmC0yMaETg+6fmCxgV4e8
	Whh8S0ajMJMOwRMosVM4xK0/OeFwUoDc3uO/DuIpz25pf/3RfzDwSkuymMzxfl0=
X-Google-Smtp-Source: AGHT+IFUWZDeYa0ir/9aq6y8x3xP/MrbRtZoz+v+Z4r43s7Sm1Xjv+6GvTp4EvbBngI9OZl9VNSL5A==
X-Received: by 2002:a17:90a:ff09:b0:299:2454:9746 with SMTP id ce9-20020a17090aff0900b0029924549746mr5996295pjb.22.1708234385574;
        Sat, 17 Feb 2024 21:33:05 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id sy8-20020a17090b2d0800b002963cab9e2asm2608339pjb.2.2024.02.17.21.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:33:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 846541846B483; Sun, 18 Feb 2024 12:33:00 +0700 (WIB)
Date: Sun, 18 Feb 2024 12:33:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Robert Elliott <elliott@hpe.com>,
	Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: fix CRYPTO_JITTERENTROPY help text
Message-ID: <ZdGWjFvnVKPiaiec@archie.me>
References: <20240217165513.24061-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eE075mgGRLmg7yKw"
Content-Disposition: inline
In-Reply-To: <20240217165513.24061-1-rdunlap@infradead.org>


--eE075mgGRLmg7yKw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 08:55:13AM -0800, Randy Dunlap wrote:
> Correct various small problems in the help text:
> a. change 2 spaces to ", "
> b. finish an incomplete sentence
> c. change non-working URL to working URL
>=20
> Fixes: a9a98d49da52 ("crypto: Kconfig - simplify compression/RNG entries")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218458
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Robert Elliott <elliott@hpe.com>
> Cc: Christoph Biedl <bugzilla.kernel.bpeb@manchmal.in-ulm.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  crypto/Kconfig |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff -- a/crypto/Kconfig b/crypto/Kconfig
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1269,10 +1269,11 @@ config CRYPTO_JITTERENTROPY
> =20
>  	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
>  	  compliant with NIST SP800-90B) intended to provide a seed to a
> -	  deterministic RNG (e.g.  per NIST SP800-90C).
> +	  deterministic RNG (e.g., per NIST SP800-90C).
>  	  This RNG does not perform any cryptographic whitening of the generated
> +	  random numbers.
> =20
> -	  See https://www.chronox.de/jent.html
> +	  See https://www.chronox.de/jent/
> =20
>  if CRYPTO_JITTERENTROPY
>  if CRYPTO_FIPS && EXPERT

LGTM, thanks!

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--eE075mgGRLmg7yKw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdGWjAAKCRD2uYlJVVFO
oxkkAPwNrD/EDUlf7d/c09ydmX95bxp3vXJwWjlje88gLPaOogEAg0YO8EG4vKJe
MJg/+ioZZi5iUpuKS+9JxqhoHK4mQg0=
=KrEh
-----END PGP SIGNATURE-----

--eE075mgGRLmg7yKw--

