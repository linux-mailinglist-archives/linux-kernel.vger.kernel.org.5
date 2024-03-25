Return-Path: <linux-kernel+bounces-116801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C4488A40B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E12D2E30D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358A182F0D;
	Mon, 25 Mar 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeTAERib"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303412D748;
	Mon, 25 Mar 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361350; cv=none; b=XprHs9bSIhnqjir9Gpwf6EJzpJDDJrANLc14l5lTR/nXhU5MRPqIrjChk4sGzGrOy2MtyQ9MiHHjXOgAnJhvFgxkwhuFj+l8eMYhKfTZgE0z+i3jIpFzE7YsiEEiQ3WqH0OyY0tRBasAfQguwDuf48/rkJYnsZ27oQdItKqzFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361350; c=relaxed/simple;
	bh=V30m0JYDi8x0GmxGboZwh4/DcXEwG2j3+H3OdQ6EWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQaf7p3B7PrXVH0m33maet2ciob7A462x2zTrcXp4bkMjuydP9Vy4CpJWAGZr20jS+sqbJ9HlZxgfhuYuKvtGqt1AsL2rph9XiISYrQTnuan9MQ5h5TKYF0E4zGd9/EfZXsd1GSuyy+Qsi0ELOW03RWyTaKDB2+X8M06178Sws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeTAERib; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0bfc42783so4224545ad.0;
        Mon, 25 Mar 2024 03:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711361348; x=1711966148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uOKPCMQduVXmNCnc4Te94yxmXAOtyZtdKVKuZQkFA4=;
        b=VeTAERibRTMi4seDOLGIjXPEm7nk7npjZSFiu6m5UKixn7PTi9F3tz83QM9NCCEyjF
         tQQEcJ+SXxcpgrf9Tu+lrpqiepHarSl9pqsTK4gCnqMtODWGjT6SCLEVGQQbVm8xf8BV
         M1Sza8bSy1mjWDPBZ3J22EzlrVl1pkGIklT2vSg5SwSaO5KOc2dypN3Gm9cmlVmwfu1c
         ww02tdCapRPm3OqlQk1V2/84PgE0NmSocxQqeo7oa4KJKITb211c+X7fTA1F0+SClybe
         sBOvP32FDIMARccvGQ644KrZVAUTr5I4Zc2C4KgdAy3nL/MGw/ROfkhQji59eCG0Torh
         8xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361348; x=1711966148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uOKPCMQduVXmNCnc4Te94yxmXAOtyZtdKVKuZQkFA4=;
        b=Y/XNiGT8q9tr+HA+ycX3zlvjyQMhQ8pn/EVnIZKOS7gdam2tEI9ajwlAVCdsJCEShS
         DGm5Oe1o/tLLs1j+59msDdqFHVMeN+9pzTqjOjUQ//MufONp7RsTfxNWnQRnVNVarw52
         i+nyKMUP90R5QblauDHkNro9rDLdaCupickEL6e4pgJOaH7eBtDK7Fe1dbWAVr51qRd2
         MvdKQGO9WOe/q7CrZDeX7+nDXT3jKXUiKe1MJbTqoj5DJEP4h7Xg3g/TIbzCrK8VuzCv
         LR5QNqc/sUuw048mXCNuqbwvQlttdKdxoYcCpvTvGfPj+pqZJx0m7dyTXMfyr715J9wT
         e09A==
X-Forwarded-Encrypted: i=1; AJvYcCVBp5Rm+eIq86HL+5OV2U4I5ha8/nH4WJJMl5QAEbu3p5vwCNfq5pkNigQDHkdkJ/aqnaPEBh33KeU785xlG90vO2bjsjNI9Gu1bmvhu+5n6pmxYGltoXMBgsdBma+QpS9nwdst
X-Gm-Message-State: AOJu0YzKEB16/N+a9CvZu5e0rvxyR91I6BW+du7ZI9badiNroIelxZ0E
	Uy/2D+GqrEEH7j9hox2PKgj6J9T2Si84EJFpxcJQSj3CN1NbC17A4Vd0R8Awn3Q=
X-Google-Smtp-Source: AGHT+IGOFNW+UZMcxD7JWblO4Yispyc1KrbP0k8euiJgM8TWXgBkyBAJdazVAX/uHx4yXrWfYcrp6A==
X-Received: by 2002:a17:903:90d:b0:1e0:4cfa:5e65 with SMTP id ll13-20020a170903090d00b001e04cfa5e65mr7313355plb.16.1711361348181;
        Mon, 25 Mar 2024 03:09:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ld3-20020a170902fac300b001dcbffec642sm4392412plb.133.2024.03.25.03.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:09:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 81CA118468567; Mon, 25 Mar 2024 17:09:04 +0700 (WIB)
Date: Mon, 25 Mar 2024 17:09:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/713] 6.7.11-rc1 review
Message-ID: <ZgFNPz46K5lxn5V6@archie.me>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tf3nKGwIMKfskhd"
Content-Disposition: inline
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>


--4tf3nKGwIMKfskhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 06:35:26PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4tf3nKGwIMKfskhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgFNOgAKCRD2uYlJVVFO
oz1KAQDoKQIvwoNPWK266QIqg6FZmHWFb/ujdGAgufp7FtQ2gwD+NRpyN24InunR
vAQ5vtrkyfPi5LNFNId//5YOU6bRgAg=
=a5B2
-----END PGP SIGNATURE-----

--4tf3nKGwIMKfskhd--

