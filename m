Return-Path: <linux-kernel+bounces-102968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B687B937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422B51F235DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585F5D744;
	Thu, 14 Mar 2024 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfrmeHMD"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE1EEC4;
	Thu, 14 Mar 2024 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404524; cv=none; b=U/8uJA9MYtKE8widHNRybbnZBxmrrssr3T6ZMmdJT6BxaN3xJVwYrxZzJeCg8irLT5+2MeTNi5lYS/1LyKGy8PqlfDKuZ9SLOnKPREVCIokGxl1BwuZ0+pYyde3kZDQeGAXydUipTLEcl6PgAOgxK5WW0cuqqjWDrr457mglH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404524; c=relaxed/simple;
	bh=Raz9CPzOnUaU1tPAYaMSYIkJu/vS221oqvUc15h9J8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQpHy4AwEvHw+suwi9ofVDXlG0Io0Y+h7PhR+dq4/5DjqP0gFNYKh9KFXkOOfkHnQMBzM0VfC1H9cq4LESjnhhwSrhtNWe32hvQ6FqL3Jd3MO5V/JPXGUluvd28lZxJgV2XZwPtTee426rkpvHicP0I5RHf6DA7mkQo1LlsEWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfrmeHMD; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso474998a12.0;
        Thu, 14 Mar 2024 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710404522; x=1711009322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KpbtCDZDaHBSD0f9OvaVnP4iDO/B06DJPllaymCvXj8=;
        b=kfrmeHMDOpEHkDBlsi/eOzbshjOeNg+c/3lcrvjL/6X/d3eFZ4inkYDMYJTQE5pWbu
         W3qFQ6yFNLDo9KVHtPLmN/7WUfPbHmrUnr949fp900896wClPyOWJ2XJwBX+Ef/3pa4e
         hxEExJhfgWvteiNJFQIWtMdqcI9PSf/Nio+3cZm0rfbYCLR2t2Q5e1It92+qTnxLmxhu
         wThZ1CL1bWcS/16FNLBhDpQF3+xOt3Ch+BT08vtmGDBrgb9DhADl/3zDudA1z1xj4rBZ
         9XoND55rV/2ywVk/hx6B03yoJn1Hr+3pSY4W9ijeI5mihtJfjRJR8bGMvja+bOKy73tu
         51zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404522; x=1711009322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpbtCDZDaHBSD0f9OvaVnP4iDO/B06DJPllaymCvXj8=;
        b=so/11ZdoPRmopB1Z+Qf85o2eFQYkxcCThZPL+HFnsgjWFA+2F5Rx7yB9ThhQ77Bytq
         N+WW7ktsWGdrlqAcHgCGlYRzX7v7eMZ4bE0GlKU988JOW3Ucx7WgCjX0WeCgrsr8UEli
         QlZLyrAsD7UaI8CV4NQXjZkLajemY2acysidBSwa75eMCkYiIBO0j7y/qJOo0xFZg9uz
         2MbzaQQJuhqr885d6oR07ZG31KB/YLZQCCdkkM/3X+CvjgX3gKSXLUEgEty4XPeQisZm
         Ug/GX6zKlC9R/L5JdLD8gT4fO/0Zl4BbKG7M5n84jZQhRgqDe8+EVBNiJqXCBuAQnHKm
         Y5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhBNb8CTMSvsZHYWCAy6gnKdejlnjeJHvpLWC18JtFucz1tdFL5lh11cGujaNY/AuOD2aVM67F7B4IpQ7Rj5uP27qLgJzRDRGtK8ptUbMC3idtq0K5YCvPTtFdG6/s1Kx4AF4q
X-Gm-Message-State: AOJu0YwJ/r7b2APnPCbhrxZF4XgC2+4NE2dOiTTLMZHyv601TYJ/zmWK
	EyEk0Zr1BaNLjBLVcREYnOJngBBuL/uedyCAW/VP5v9o7DVkQAgi
X-Google-Smtp-Source: AGHT+IHj50023IHbKR96PyDV7KR7RC1vtlkS6zOf4CEjfWniHdCsmGh8rRkuSSkrm4XkOKeDbA6ReQ==
X-Received: by 2002:a17:90a:c20b:b0:29c:7409:9248 with SMTP id e11-20020a17090ac20b00b0029c74099248mr933300pjt.32.1710404522400;
        Thu, 14 Mar 2024 01:22:02 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id nc16-20020a17090b37d000b0029bb5a95a3csm256290pjb.55.2024.03.14.01.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:22:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 74884184798DF; Thu, 14 Mar 2024 15:21:58 +0700 (WIB)
Date: Thu, 14 Mar 2024 15:21:58 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
Message-ID: <ZfKzpiF4l7eRUq0d@archie.me>
References: <20240313163019.613705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AdnvMIIDLKT63i4Q"
Content-Disposition: inline
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>


--AdnvMIIDLKT63i4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:30:14PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.8.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--AdnvMIIDLKT63i4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfKzogAKCRD2uYlJVVFO
o5qXAP9J5S50wg5KbTgalsV4gty72Z4qKciqralfAbsoDxhuYwD/cbweqbdX2BHF
zn1FCjyAT2FBYTHK4psKPdx2ct3nSQg=
=FHoG
-----END PGP SIGNATURE-----

--AdnvMIIDLKT63i4Q--

