Return-Path: <linux-kernel+bounces-75932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BE85F0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9101C21FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C979F9;
	Thu, 22 Feb 2024 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhErK52/"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70A7490;
	Thu, 22 Feb 2024 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708579087; cv=none; b=mnZil/PYjlqh9C1INSMvoiEvi4K+g3yWwR7TmWZzM4AgAlW0nRRcmyOGsA0ucB9IxTcziZz8tiwfv+tDHdGekvh4Ma8a8IgZtPgKtXeYXuR4DV/ZnUBkT6TEMEm7PPyl3NrU4si7OZG49VHXcB1m07IaprHpZsXWvfHyxgCPQDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708579087; c=relaxed/simple;
	bh=E6kxIjupRfQ6whETQdBAa7XObspVL8EosoRw1aQIIVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snNlqTUoQMeYt9NX1Y5ScUh9ydz+3294biAkIKGD/2UQuA5EOxVF4fcu+ZGvVUlomhGiMPXUqskaIOjFmO2mtPegcne4qhySUF983BJ50VjYRE5livRBE08IOkMMt8x+kneYmGaRBC9cfNJgfB004Qt1TZZFB+VJtY4JRBoLV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhErK52/; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c17ac08a38so129129b6e.1;
        Wed, 21 Feb 2024 21:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708579085; x=1709183885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwERMhLydUQbM63HHAS3nRnQy7Lq2lbonIyWMpCTEio=;
        b=NhErK52/aMFn3CJL+qC/E2dSdVbwnUrPkpXT2yYuZb8gUsbtz8Cdmic8Ff6ERxg620
         ovK3u2DrP2xHP0vjIxlXMJsny0Ke9gpSeH4mjuU8if9TNJ+Bj3kcENB6sJ6N2GxOwDOD
         OPkw9Rj4aBa0oTFb/Gc6WERtNAZkfLD6anaOFkIZgKuaZBRyJRPrKQuXXvaDcvl1EfSn
         Fs6PodaOpceHTakJz2AgmH9xWcLNueAdtNP5T+yjwNQyoiy1P9rCwYiueXMxYX0fVM/a
         DqJMHHoVK5lhbv7BuCVj3LiIgGcwNTZwPZCZ384f/6gY+URKA95y+vZ535vLnjZm50nZ
         ON0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708579085; x=1709183885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwERMhLydUQbM63HHAS3nRnQy7Lq2lbonIyWMpCTEio=;
        b=Y4iqdAiUt+UgF5/0WfH/R6pkNsvPU97U7fUR9pgj9P0knxlUlB7A47SWmxpAjZmUh7
         MXDV9FUU5fs25lxjb8LCzjhFBtguyBgMcU2vo4ehfglXz6WZkGDxUxMm7XDn4ZESXOVD
         HiaIoJUuQjLklbBLc1grJUrJ+OAurN3ZejjgGUBiBWse0uNCOUw1pSPSEugrFyd0YHLh
         W190ngrM2vO619JuudSpxwo21tN23SsHPeClLCXibpuRl2/VluIARO2zi7YYC8eiQxby
         TlCsgFrEMmo2bl811OlNTIj4qXGsecx47SZkeE3vDr2TdEuydfWziVZxQif7lXZ1vvc+
         Ebng==
X-Forwarded-Encrypted: i=1; AJvYcCVNYMeQ56/BjEGHEwk/vS1Mp+rAqvR+FPPfXS8lTtor4mIr4iZX6k3aiFYwAxnpY3FQxL5JyD7vTVnox80zioADueSl9GhZt9tyCvtYD6bC07tUpgRfzMJYfGhJAQtNzn1Mc7vd
X-Gm-Message-State: AOJu0YyOGrityr6CyqKl26pRK3mCfFQafleFyO+Px13FZe91nXQtTaG2
	GdwU5Bt9Hze+J/IruD/j0NDHBJM37dikk7jhItsRWSdjFQNf9OYz
X-Google-Smtp-Source: AGHT+IEtdRoPxkdmxHgLnLRefjYoG5PSBEkg4YZ8kfOrcvTyfRPEb3/2j3ZwvzmyIHFUKJq6GH54Kw==
X-Received: by 2002:a05:6808:2f08:b0:3c1:7aa3:166e with SMTP id gu8-20020a0568082f0800b003c17aa3166emr1121361oib.24.1708579084639;
        Wed, 21 Feb 2024 21:18:04 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c18-20020aa78812000000b006e1464e71f9sm7701488pfo.47.2024.02.21.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:18:03 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CCF411848BD3F; Thu, 22 Feb 2024 12:18:00 +0700 (WIB)
Date: Thu, 22 Feb 2024 12:18:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
Message-ID: <ZdbZCP-Tiv3-43L_@archie.me>
References: <20240221125953.770767246@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mGK27+qIopmdpltJ"
Content-Disposition: inline
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>


--mGK27+qIopmdpltJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 02:01:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--mGK27+qIopmdpltJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZdbZAwAKCRD2uYlJVVFO
o3GKAQDqIwME+Q56DodiHbWqEX1GMJbRA2DZLnntnw6o9SkpRgEAhKw/eq3y+H3f
gsXpYGMe/dxDlFCt4pNiQMpOwXT8CAE=
=ij2T
-----END PGP SIGNATURE-----

--mGK27+qIopmdpltJ--

