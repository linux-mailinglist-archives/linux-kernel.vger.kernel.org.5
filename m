Return-Path: <linux-kernel+bounces-146193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCEB8A61DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5256D285019
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BF12033E;
	Tue, 16 Apr 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmuyYchZ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EA199BC;
	Tue, 16 Apr 2024 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239468; cv=none; b=p3jlA3KadLhLaM+UAjVHHtpJ8oNPnwgLgSPRy6rILL442a3vxEfTJK9cLI7FeKtsFPISaUwkkSu/I+HVoJkJDlN1Uqx7EmB2/DMQelNgRk3+egsT/ZE1Hlp28ucyzSB65NPH6yRUbVQwSnQo5DejgEiK63xWss4pzSYpEek+mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239468; c=relaxed/simple;
	bh=P3DgkQW2viOoJBU4pbfa0M0RG2Gxai3iYNRUNy6jYiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOCV9itQb1XmVxYAfccvsQJLl6Ev/lRiNXz5NeMe6RYp/Ekyd1o2oW3BZQ4b90J1AVLHwApoUbKx/i+UK9Q52oVkS+RB7Wa4LL/dA9TO3gJJPZftSYiX1FUkL4tquW9yCLauTK2FyS62AjlJqd/1Mdontqx5U7fAtVpCo1mo8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmuyYchZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso3289049b3a.3;
        Mon, 15 Apr 2024 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713239465; x=1713844265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX6FHcjjwFTUVDd7n7O9sbio9XsGH+ecRXrlK3mp8Zc=;
        b=fmuyYchZNaQ56/S8gD0QFL/TQpvAnf2VRVEURg+3ITD9kZgltuqUJVZH746t5wS7jc
         b15c7eNbnZ8BnTO0tFAjycs1LWE6JIkRndOy+SchI/4FXzp8sohsvp9Kouan8U8POFzb
         FlA9JLF53bnRMGIAc6rCNmCTIhe3P8y9W5jW/Z7ZtTIPaCxv6ipFlfcXIRfVDTBy6WXN
         nGCdjtTvn1vYOXX4jN6s7qi2tFWlHf/ycYs3T2ZUykyII6BzxhYUrfHhcyyxohDaaR0e
         MByF7QEG4Z+VeR0sIOzxx1Y5wlw+8EHFgL3wDGnI6K84WqA2KntvOu4DIIV2mj3oFAMg
         jr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239465; x=1713844265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX6FHcjjwFTUVDd7n7O9sbio9XsGH+ecRXrlK3mp8Zc=;
        b=L9S9+iAGWuLH6eTa4KIbNdIZ+R8DxBn6Iia3p1FPo5gFfwDkFQY/jypdYUJ32KmIDq
         /+xmS1oWGDhN11do+n/9jLwmK7Iv9zdFU9RcmUnBj9HC+QRKaKqAyXiYSbee4cIOgu/W
         KQlGOp54BZMAwTu4dWsa/jV/VbUAdZkeJC/pgCHwyB+oC5jLPS1TCriFJln16Otgq48r
         MNSTl85LQ8aeWm0xsIT1jCijjZg1KRYB+M8/aTIybuhosYepHz/jj6ktAF7/JJbzN5q3
         L+Su1Ez+JyyuvUxh5avERR2qjIM9reFQMh5vfBxpi4rCmE1d4w1LtINX1QcHBKSh0lyE
         O2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXiJxJ2/ISaDYRnDBr13qKe42pAT7u+76F6Wl3cZW/jXl4Tu1MfMuVT2/LOQJritsis08wv61XkxPSMvfh5htBxg0gjlDQFWccoXPcIULVn8WqxuN7Vb4RzDj4nHiwRWrwW7Be6
X-Gm-Message-State: AOJu0YzOuUVLF3y5V0M5eRpnL12phhCXhRsWaGAY0fPSbHwBOL5ZpZa5
	f67yvjjcz0iSWoRXMPgHWxTRkju1GizdgiFeZip7pmLBRTi3A4v4
X-Google-Smtp-Source: AGHT+IHIur0c/TCXoYlr0j9DqqPmSFovFafZ1KQCTrbsQscWzuSEF4tIRIwDOI4jCfxvICVPtlcCBg==
X-Received: by 2002:a05:6a20:a11d:b0:1a7:7bc4:e214 with SMTP id q29-20020a056a20a11d00b001a77bc4e214mr13044628pzk.7.1713239464787;
        Mon, 15 Apr 2024 20:51:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902654f00b001e41ffb9de7sm8879005pln.28.2024.04.15.20.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:51:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 00DC118462BAB; Tue, 16 Apr 2024 10:51:01 +0700 (WIB)
Date: Tue, 16 Apr 2024 10:51:01 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/172] 6.8.7-rc1 review
Message-ID: <Zh31pTGbTkN5A_zN@archie.me>
References: <20240415141959.976094777@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r4y4EijudvVppG+6"
Content-Disposition: inline
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>


--r4y4EijudvVppG+6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 04:18:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.7 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--r4y4EijudvVppG+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh31oQAKCRD2uYlJVVFO
o7seAP9e5X80kS3O8QipkMOoSbj5a1jfjVB3NhT/xShO30X1hwD/bks7sFKdi4Z8
Xt9hnaUWGfpfLmF7zn11EwHPE/5YWQk=
=oNVo
-----END PGP SIGNATURE-----

--r4y4EijudvVppG+6--

