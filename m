Return-Path: <linux-kernel+bounces-36512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD183A219
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D37B22797
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7EF9F5;
	Wed, 24 Jan 2024 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU7jNByM"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B1C8E1;
	Wed, 24 Jan 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078044; cv=none; b=KrUG4t5hXOwYOCSwVJu7HTaRxKqOeuXLYcSefz11CmbFhZk8MeFMNJP/+93iGujSOPVHcQDvaCkDNwbFwUDHQDdooCec46oCFuH50b8GuLTWBAJnoPwvpwL+u914veUfdGUmmXvTTpoAboMV/1M1ZZPxiUqbvHTsQIoPQeNdmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078044; c=relaxed/simple;
	bh=5YIrrYj0Si/6Hd480M/w7OJ0h2AH6GV9kwxXqRo+CR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7NiQ3AgycDCFMow48N3M0e08Sxn3+katbmBe8Zt+lfAT+WDDHjQnI2zCu0xjp+huc2OYUOe/KBAeruCUalauybogTWMzuko6UsTv+eLZ5JIpiWUM1Xeo2wqq/mz91kSEy591sXWf7wsaORF3drDzmbOreH0x2bIpMbUJUOJJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU7jNByM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d50d0c98c3so49245135ad.1;
        Tue, 23 Jan 2024 22:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706078043; x=1706682843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wwiArvKfER0AY3jSAMDODOvkCI4Zyn3MP5CTy914xZA=;
        b=ZU7jNByMwLFSwFnfXe+QjKF/6X0W6HT82oIZIUzE3YfdY0ygAdWB8br52c+KpUtVk5
         YntXj4tQ1GrRjm50Gm9rlIaN4p1yUZ347pXP4Oy0zQ3u1vbnDX5o2SLSxhY78KjDyZ9m
         6Qtyw8SfJU04t67wzmy+6mowx+PkmPBuYz9zY2akBIt4RGmpl1owpvISDhQR9cD9Xeyh
         9XbS1yY+F6UVrgDuCblThpjVRsaRuszRtRfK9znCBKyJ0rjGOOSaaCJsTcsV6+pwUwQD
         bsfBZAlJRYz25XcMl9nS5l7FmBBAZb9hH41K4g9tBVzZDyFoE4tc36dYT9Elj6oAOcw/
         yIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078043; x=1706682843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwiArvKfER0AY3jSAMDODOvkCI4Zyn3MP5CTy914xZA=;
        b=Cifw0sRt278QVTzIsVT/OBJ64LJdNEODomhSzFGEmr9MMKl80sCuQia0na3+OIAJ6y
         zIXI16JzyLjzRoBUHhs4PrCPhlFsGOW8MwcQUSCh1F/QjQBdZkZiLImRaWjaZ+FSrPIK
         uc9Th6WQl6owHPOw5v9VR3WA7mh4pSsqTFcGLped5UU0CrGWmTDoROzZPTmBvxy4SZzL
         OHKjh7ILquWxQQ6MClKDGH/diWyirWcCw0K3PX0LJ5iv05RM4ncLxJL1tLiCN6jMJcH4
         C/VBT7hNUgJULkFXVdDD11cdnEM6QaR1foKsFY+0fOJ70PuxhPdikG6bS0rNID+fVIKN
         qclQ==
X-Gm-Message-State: AOJu0Yz8H9793H9BbJIkbIXAauYCBRS+PZ4708PqNLodLcjEwxI7v0Ys
	O8MAsxn2ECnYY4o7q/EtkYia/KuRByDpVbF1aJnDG0Ub7O7MjGZu
X-Google-Smtp-Source: AGHT+IHlGWCuEIykEDS0rBLhPa98kQAWC3kOAyYmZk9CBmd6ampHBBrgWmJmW/+WuAgUE2Z/4/PXHA==
X-Received: by 2002:a17:902:e80d:b0:1d5:73d0:eb7d with SMTP id u13-20020a170902e80d00b001d573d0eb7dmr705815plg.18.1706078042587;
        Tue, 23 Jan 2024 22:34:02 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001d756bc2396sm4056873plg.192.2024.01.23.22.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:34:01 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D27DE184EA857; Wed, 24 Jan 2024 13:33:57 +0700 (WIB)
Date: Wed, 24 Jan 2024 13:33:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Message-ID: <ZbCvVWZDdJKdYzwI@archie.me>
References: <20240123174544.648088948@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BJmZCM1n8HINQoj4"
Content-Disposition: inline
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>


--BJmZCM1n8HINQoj4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 09:47:30AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--BJmZCM1n8HINQoj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbCvTwAKCRD2uYlJVVFO
o6ngAQC2zVMRCBg2iMXtB+uP+hmW44cKQRyMlnkPxbRa73caFwD/ZBl6VCSCxIbW
jeRrI4uuKZXBzjbdQHx9xdny0czn0gg=
=Ng2f
-----END PGP SIGNATURE-----

--BJmZCM1n8HINQoj4--

