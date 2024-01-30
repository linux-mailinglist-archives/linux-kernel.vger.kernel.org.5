Return-Path: <linux-kernel+bounces-43998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC2841C02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E941C21EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B323383B1;
	Tue, 30 Jan 2024 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsXxe9om"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC1383A2;
	Tue, 30 Jan 2024 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596631; cv=none; b=RVNFdvRHI/ZohpkAGgfEgoV6DVr57NZ/FHzRT2Dt8vxpMnbgZR0ALGoLk9CU+s1nDs7LovgJ9gaIz1qGtg7P7KVIOJ66gbG8APIV+++6acs8psx+qZSdsUUBL7mw8ZKkr01XN4CgyPoazEPAPe5gqwAXrvjdpksaZLyKpPXKVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596631; c=relaxed/simple;
	bh=Pt0LMo6SGcA34xoqbjesioYU0CcVX1I7PW/asESQ0j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH+nT7WWVFc5taVDNcZGmAinhMlwMGUnEfBgO2QGP77hvPCHwVC0BDdtKGZRf5KIYm7VaoUeJXdjzaH221RCoF0TsQa4sVYJfxv1/H4i90lTB5Jtv+v9jkJ2NT4Pnx4rG+PM1/2EBvHGJP53nruI8rBcCTJMAg/sYSgpa1wA+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsXxe9om; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e133d5271cso594460a34.0;
        Mon, 29 Jan 2024 22:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706596629; x=1707201429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HIcCz0Mzc9BxMF6SwHpcNCpuboJRjlo/WiVPsfyzt7k=;
        b=SsXxe9omBDzPDJ6sAw2Y3HKmb+A9cxacHXmt3x0plaZo/3mduP/l2QxZs/6N0Qafrn
         3JRR+9ACpsAwZOocM2kK35nJqNYZHy4KE+XGMzLv6qqQHXaOe51cm9555DI6s584i+Yp
         4uI+/Y4C03ry93VcZQTB1/d/7okVw6Qg9WAI1fIU24OQvgZ2ZtWneBTAMtNO7MMmTpYU
         i/3zR54N4G+U3b9rfXaiBtvFIKtitshn80gAljY3++jq0j0b6N5tl4feoq80tbRQ9Zu/
         ad1/rPhT94eIontJ0FyULgC9/aUJGzIv9h3KAhz+g5DRniilCi68c9vilKq8njORatiT
         LBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596629; x=1707201429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIcCz0Mzc9BxMF6SwHpcNCpuboJRjlo/WiVPsfyzt7k=;
        b=fRwA7rPGHgrw99zVimTfETMGE1TzgBfyeL0C6NOaVtIVPZhVM1cLTMb8jyFhrIAg5u
         iFOLgokWNWYH5op1R57JwLfQHxSqy3+etkCoyKdDUo4pPRGKXhnsOqPWBdWzwBI0/pRT
         Y5p813L1ZFsvAw41oJ2abss4mzF4UNRD96EOrsT+G9x4PdvRXbnm5VAddfgxlHAdc487
         HNezjBvNkt+hm38ZHK/BCA2Fy7U2NRhpp4hpePDwU7+TPVFa1dKG4YK6CJMKcNsZlejU
         4Vlmy5cm3D21Xi3bI2xxDYuhyQlm8wa4ws1eYgn00L5nPI/JrQHFCQSPLLihttxT6e0B
         0/hQ==
X-Gm-Message-State: AOJu0Yxa21j16qRUd0fJGmhN/YzHsRZkkrr27aqoX+mq1764uAEbqNMo
	AprjQAUfzwdSC8OI8E3owAFtxE2n07F48Crx5gZRbJqNRhWPK5B1
X-Google-Smtp-Source: AGHT+IHt+p2OeOZfz041Va/zrBEWGNjlvIjR4t7egPI3rb02vl1yaX30F3AJ1JTs3GFQKicjjvyPSw==
X-Received: by 2002:a05:6358:524b:b0:176:569f:8921 with SMTP id c11-20020a056358524b00b00176569f8921mr8351321rwa.56.1706596629107;
        Mon, 29 Jan 2024 22:37:09 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m1-20020a634c41000000b005cfd70edc1bsm7297503pgl.7.2024.01.29.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:37:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 08C3D1866A4D6; Tue, 30 Jan 2024 13:37:04 +0700 (WIB)
Date: Tue, 30 Jan 2024 13:37:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
Message-ID: <ZbiZEIGny2PIuF_c@archie.me>
References: <20240129170014.969142961@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/mVOV2Mmh6IDwzHM"
Content-Disposition: inline
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>


--/mVOV2Mmh6IDwzHM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 09:01:04AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--/mVOV2Mmh6IDwzHM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbiZCQAKCRD2uYlJVVFO
owWXAQDXCSKB363QnUJTRrC3odrGNWpQBwmy8Fb1hlkF1p+ejQEA5kXnB5jF4Sio
96MJmP35mKDfdQ/N2NrkdGb9EBACZQk=
=A1hq
-----END PGP SIGNATURE-----

--/mVOV2Mmh6IDwzHM--

