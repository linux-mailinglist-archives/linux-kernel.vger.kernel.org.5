Return-Path: <linux-kernel+bounces-158251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D218B1D84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F7E1F22014
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC1584E0B;
	Thu, 25 Apr 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4ePHFFN"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A68286B;
	Thu, 25 Apr 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036420; cv=none; b=hJamxgMb1JTqV2ryaFtYpT1L+oAiJyxYU1k0buh4U3KAPwp3P3rd+ZYQEt0vApFzFa3/XPULyN7VxoUH+WAtCOwRufw8U4Q8UnrOqX95ZtO6KOleS6JbBY27BjBE0/rc8bZBDGqJM8t8l/voNkgaYbuP1qZ7x87PIG7yCAq2bmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036420; c=relaxed/simple;
	bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BisDirj9ebqHY5F+piGC48z9ZdLI2u7C+mBePH38kfwQWxsfwHNNeFGGbDxnFZzxv5rR2E/bg8GdgRE3kiIkv7J5R1n/sGbxV2EQu1qw9aN4FR4M6nBUx9uwrb0o+hvBpPVAo8UzMUl8qPrkCjnEuMV2TJeizvYDR/aJK8VjREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4ePHFFN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecec796323so801061b3a.3;
        Thu, 25 Apr 2024 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036418; x=1714641218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
        b=m4ePHFFN3DWkBJL5J11UIpBw0wVPsiGN+A5/nxe8XRF5ROeXkUkyZzOmruYmoohL1r
         RWSsmwb8cDygMhoRHcchhcS+PmRo9c3sCUzCUmY2nG1FHyrJhYxmt7AKFiV7s7vjazxs
         S+uYS5kWfONIqj5bXfxBteWt/Tbl7e/GDsX02EbauRQZb3OP04s2PLB5j7irgarU8/W6
         Uel4m49mldGQr31Rimhaa1wzlSbuYiZvyVFAplIyzfWXY3meaAvtVjcBxTNAgj/rRObs
         STwIPEgVQ3NqXk0igDUnJx3lejxEDNWvNixU9I0BKADHRT31VmLvB/zYxkFYNpLW4+7h
         42GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036418; x=1714641218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eobe3x7c9CyI2IUIU9H13+fYzPpeASRF8Xdxx5XJjYA=;
        b=TalpX96HrodV3fFSW9o0+cDyyuutx4tOpwweF+LEoZcPj1wmPAB8ucFbXwpjKePHyp
         YUoNOQp8g6yGUXqT/MSNaGBW5mV14JPlG0l+UgsQw77j3TloGwQRF6Q1Sl34BKOtsg/F
         PZRUsO4PzulhLinMi3wncm5056w2FIRTsZOhYdW5jkjD5lsXsjyVH0dzstoP7uMe6flr
         ApbJWqtXaVGslJJFf1enYbQwjF8uE5WMaWWWwPdyirrVI3PTf3TCNTnYBrcjQU8USZ3p
         yxlmb62NMTGZ9uz+kXtX9Ro12SuWsMLhls7ETNDQHq27lv3ZPLw/TvFE9Izlev9cItYH
         NP3g==
X-Forwarded-Encrypted: i=1; AJvYcCXeu/vaSiOrru+13rvBvpd9x+Xvx4MzT/sIshiFAwHsZWeKw4Ofz0gKJ/Aw4bL/H/oSzBxP8DLhqi2y/IbirnfZOeOIwxMMDsjvDhhB1x5IiB4JKMRKCOU1TtWHlXE/+5tGcAtHaAdU
X-Gm-Message-State: AOJu0Yw5lUIPy6/VHmCPISBp3ArJRKEfTqYDGxFNwEgjaeefIEjZaP1C
	Gm1wHKd4nHPe1vlcS6Dh45LBS5TVGbtenn2wmuhoe9fd8ij0Mdmd
X-Google-Smtp-Source: AGHT+IEcl6IzLLKiM9OnGHl9KJWuISOkQx1HFxAPlzz5abY7e+KR16xrC66zK2tX4k7qPamThBER9w==
X-Received: by 2002:a05:6a21:350d:b0:1ad:8334:df97 with SMTP id zc13-20020a056a21350d00b001ad8334df97mr5611859pzb.5.1714036418263;
        Thu, 25 Apr 2024 02:13:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm10854365pga.91.2024.04.25.02.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 02:13:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 703DA1995D6D0; Thu, 25 Apr 2024 16:13:33 +0700 (WIB)
Date: Thu, 25 Apr 2024 16:13:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev,
	Linux Kernel Maling List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Cc: Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>, Josh Don <joshdon@google.com>,
	YouHong Li <liyouhong@kylinos.cn>
Subject: Re: [PATCH v2 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZioevHI3wok_yiSv@archie.me>
References: <20240424150253.560999-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6+EK+eavKzI6maIW"
Content-Disposition: inline
In-Reply-To: <20240424150253.560999-1-mhklinux@outlook.com>


--6+EK+eavKzI6maIW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 08:02:53AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6+EK+eavKzI6maIW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZioetwAKCRD2uYlJVVFO
o3WBAP9d21rIomzf/1Ba3BKC836P2zEVgmENMEMVr3xzUNPp8gEAkEaSxCqc4bbC
FbUDRlMjRROKs/jYO2ln7Xxgto0xXQ0=
=uLGe
-----END PGP SIGNATURE-----

--6+EK+eavKzI6maIW--

