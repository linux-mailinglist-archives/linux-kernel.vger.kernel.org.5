Return-Path: <linux-kernel+bounces-127537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC0894D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CE7283252
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD0C3D552;
	Tue,  2 Apr 2024 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1kWbiqs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950F3D548;
	Tue,  2 Apr 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045820; cv=none; b=nTZJHRkJcE2+71rHv7vYsOxG57+jXqKp+bXGbIAtauMurZXjP/DpqypUXbmH+2sXJaSUa8USuESsVHhaKyEFaOJ6M6knNcbojlY6a3cdFFq5x0jAPEMhGgz+a/SNT8klb1V+Zo3U/Mh2fb9amqTWkEu0dFjQkUCiL6FyHygC6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045820; c=relaxed/simple;
	bh=fHfWBt+5+tlmiFF5W8s3mbBkeuPcLWeMDiItbwj7Tt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+2q4UmNaX8J3ciSCJjPHJ7ypVs6SQPlFYcbE1oYDzbkGGHGINuWXgUHtesruqlVqH+qiP6jJ6AJSHtBOpi6o+A0j8AxB+B3StScGmAwSRlDN2id1WwViMcw88ONSzlw7y8R1WpXPlpBZZiyz87lWgVG1QDvTEoD7twG4oQ6EMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1kWbiqs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0f2798cd8so39415475ad.3;
        Tue, 02 Apr 2024 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045818; x=1712650618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkNvR4qIQ0Db8em+0g0qh+1j9L+Q3Yqd9OtOLhE4ahQ=;
        b=Y1kWbiqsorSy5rP1TzAPHtjglbubNyVvgxYL/MxfQwQjKOHCc3lebfNPwDaCFOAUXo
         RNkT70nzRQipulm8a/MJngKp7Nk5bnDR7zZlHyrwzxtPbflj7A98i9A1FqNqhOFJDstj
         4U1LuwppvcuvsxcumgVfGObYv3J9szlgCtvnI42EMIoxsKj0/LP/Ll5I/bP589HiFXgS
         yMEckFV2kCwGx2HtJmHpKDxw7n8RT8zPI6KNlT+/yo7aDzXcp1Jo/Y3vWMSJMbHOzTt/
         XWNSG1Vx4HQd+/3EkxgsfXwiu0wtLXyfc+9lN9roE6r1FohzLqhphbvuDWBsvfY5gG0M
         HHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045818; x=1712650618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkNvR4qIQ0Db8em+0g0qh+1j9L+Q3Yqd9OtOLhE4ahQ=;
        b=KMtTvNL0bpkEDnc+JzHiMPJGi52IsWShe2Efi1zk2UxMLqnu6kRUws5cFAnsR6QlnJ
         Py0WMmOV3X3hys0r6O7oOPU9bkDrn8jnK9BIMvd4ylj73z6OCXYgb1OQZPDzKXnIl4lD
         7Gtg0VRDwiD+/CyWY3nsikDc1NIm5PU+umv2r9v6dqKe5ASBzQ41aSOCRfe23e6J0htE
         A+VrJbK/IKZ74RnFrbrKYmQAFauREHPvtiL7q9ArEuZ2yOm7hay/U5E1LlNUXkGA6DOs
         +OlOECAq1ckuUktEyF0CvlUxbH0/3twsENI9Xff4XzL3um9DIbqkJPxF6crbkZ1N1Ln1
         LdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXor2JTxf/aVXTkIkvRoRIEgThcmD0sjpzMkJyL4bIonzpQI1mGzMNScIeMwh1+ovYfNvSSh1rnRwh4Y9kgrn3pAI9t1i6DgniGbF11taJCkCBqCwr8DyhKNC77jN6S/1uElrLY
X-Gm-Message-State: AOJu0Yz+yYBiKUbVRj2dHEDu1iZrn4H4SVDNw+iQi6Ne1aS0tXNDygqO
	0k8c+2Rx0rZbKaK/4wC04B1yjp46Yys/o2M5nXbONuYyiGZhXQmi
X-Google-Smtp-Source: AGHT+IFxd0fZOmFNHBnb+TBQTxGABlte5U58aCoKtKjlAKnzhZGF2G6G4Wy/MVJQ/Sdd/ZuNPOMopA==
X-Received: by 2002:a17:902:ce8e:b0:1e0:b0d:5b7d with SMTP id f14-20020a170902ce8e00b001e00b0d5b7dmr11626393plg.36.1712045818498;
        Tue, 02 Apr 2024 01:16:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e249843f3csm5680349plb.223.2024.04.02.01.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:16:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D40B21847976E; Tue,  2 Apr 2024 15:16:54 +0700 (WIB)
Date: Tue, 2 Apr 2024 15:16:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Message-ID: <Zgu-9mXbrP7KnKLT@archie.me>
References: <20240401152549.131030308@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2pA8USOwcFlMD1qA"
Content-Disposition: inline
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>


--2pA8USOwcFlMD1qA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 05:39:26PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--2pA8USOwcFlMD1qA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgu+8gAKCRD2uYlJVVFO
ozkaAP9vI+2/N+R4TCcyvBBlUBallO1Fb8t4vDeTkR3TW7qTxQEAnVLG01UHNXKC
kkWlz1NayRaFHHVptcG2FT95HtwmqA8=
=g7sZ
-----END PGP SIGNATURE-----

--2pA8USOwcFlMD1qA--

