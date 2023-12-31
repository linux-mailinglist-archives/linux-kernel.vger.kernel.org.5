Return-Path: <linux-kernel+bounces-13650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F202E820A59
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844F31F214DB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B99186C;
	Sun, 31 Dec 2023 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdziH2DJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BED4422;
	Sun, 31 Dec 2023 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ea5cc137so62096575ad.0;
        Sun, 31 Dec 2023 00:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704010261; x=1704615061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNU5f1jiVvfWfhV5Quib7e5NTPQnlPBAE6ShQ69pG70=;
        b=KdziH2DJrfl6WYtimu7erHhjAwemWnfsmxTVAWHPiZ6HJM1Oe88WSMEf/k7od85Ete
         LPb9Pw26Jpl+E+0l8l9wTevz6/uiKG5aVEKOTFbyM7unGwweG39YDvsWEKgcGUrkNAUA
         bTrpMCwzIslK1DIxgdux7NX0aleHKbqkDIlATyA7rY6vVNSzGxprWnejxIPM18yksMGR
         lC9B12hy6MUFjRuwoXuHVf4Gr+y+tBJJ6QO7ZWdmpBdl3XoUooRiUQIOdJeTSS2qxWEU
         zaVT922P0mSB3DMABXOhNelJXYalkLtTFDd84+8Co6USFvHp4Cyl6BrJ41k9voa8XRD5
         6P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704010261; x=1704615061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNU5f1jiVvfWfhV5Quib7e5NTPQnlPBAE6ShQ69pG70=;
        b=xMunX2yOLitNkehisgLqX9ul5y2KhY9BlmJXILvXp5I759JpztzMIEpRWC4ges1QN/
         L82/PhSnL6jhMARQEYtSDfdIfUIK4SEBdlGnmT6Cic/wU1otKD5c9pFrGGu7SrnA7E6e
         qBQirKKKfdQRYYUbZqAtbc9TFswxKMx96Wh44o7OosjrqMkZf33GNo1eQ4vSzhYNBUEf
         WDa8weDewaJVrfwJcowjYYZOAehXVbQvAUYp7bilADma1WBDTEtAN9ubQCYbQoO2+6XU
         JyaVrcZg2ZPkpUDPdoSp0zKTUFCY0kYuKtWwfGMHsYBeDMuDKww3FkkvhG6mGMA5WdKv
         pQNQ==
X-Gm-Message-State: AOJu0YxW0qLtsX5J2njehPF6uENRqhZnktZTFuXkaDEYC0LRE1XMlyyy
	M1hpMU/96xpmfCIFy2W4oi0=
X-Google-Smtp-Source: AGHT+IFPMMmQXICk0Xsb8doenjlLsZpwV0V5bK2hxpjhNQxxQC9+e21mLcKuBDT4Q4mHiR2ZbxTUNQ==
X-Received: by 2002:a17:902:daca:b0:1d4:4768:5f with SMTP id q10-20020a170902daca00b001d44768005fmr13873909plx.37.1704010261427;
        Sun, 31 Dec 2023 00:11:01 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jm7-20020a17090304c700b001d3e6f58e5esm18232091plb.6.2023.12.31.00.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 00:11:00 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 981A610213F98; Sun, 31 Dec 2023 15:10:55 +0700 (WIB)
Date: Sun, 31 Dec 2023 15:10:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/156] 6.6.9-rc1 review
Message-ID: <ZZEiD_ONxq8TYA4O@archie.me>
References: <20231230115812.333117904@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B1Z6bosjNKpAgHCa"
Content-Disposition: inline
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>


--B1Z6bosjNKpAgHCa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 11:57:34AM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.9 release.
> There are 156 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--B1Z6bosjNKpAgHCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZEiCAAKCRD2uYlJVVFO
o26yAP9tYDzcg0457MaAvIx3MLTSyyhIS1qzU7VLxPRpjXxUcQEAy0ujbZo0iOYC
tqCz07M9cy0joTywum50wyTerTV8jQg=
=IVGP
-----END PGP SIGNATURE-----

--B1Z6bosjNKpAgHCa--

