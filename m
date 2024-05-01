Return-Path: <linux-kernel+bounces-164995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C18B862B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6541C212B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0474D584;
	Wed,  1 May 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkeYkYla"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E42E3F2;
	Wed,  1 May 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549197; cv=none; b=Bm8JyMKfRJJb4wKtMvMgaFSa1fOFw8ERita9eP6CnpPHg8mFjMVRm1SyeUytx8xGQG0e+WhzP0p9sEzGl1eK+/V9WkHB1CMc1DLL+//wC3OHgBbO0GL8KBwAQu9GgdZvxACBq3mXiUDk2TXzkHGJtxf8hTjo2xuYxExzyOdJ7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549197; c=relaxed/simple;
	bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkxfAegtczwnIfz2Swl+O3l4o0gq8NDXpKaAAGX+AgO7cC6/YcSo+nDOQ/JLiUdU8w0wXBjLI2UFFw9dn9lT8FHWs15X0j65sgk0zZugaUpsQIYIGiRrQorsnRwVc17/ie+sFUB0muLLEtUYvtqDWI9UtwDVjL4iVXwcZWZskzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkeYkYla; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1eab16c8d83so52921075ad.3;
        Wed, 01 May 2024 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714549195; x=1715153995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
        b=lkeYkYlavqCvNh+rLvd5S2clhQO5HTVHqjRAnpGQNTi0ckjWlD1eiCFcFOFQHp6TnN
         Y/V7qmscLVHaXDzIjQFiA/omUDOZBrAut5k4zdmzzcgHzV2q1T4cxZeSq2j/f+nn3TFI
         nJSlJuESh/rHLYGCCZ8Z7BLjwHbdRoWuCxacQiBbVb91AuwtWy+5bkrWErpMJqsz1xpE
         iyniSAzZLHU67K3E69An6U4+0Kp6uF5dLyID2/aDJCB3231b9hvTKqt7F2efAbBdxtoS
         I8qlGBhKpVvxaPtokidR3JHmWT7fAL7HU+K7aQSwPobuasV9jOOtw2N22SLVk94R+U3c
         41sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549195; x=1715153995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eWuGHYXfyJHepRujiagDpeV3q8qyo9GkPxVCzukQy4=;
        b=SNx37z3opqq7vkLIl/cTXxdHcGUKz7z//73aQcMiZB6sc/CMWeva44TFxD7QhbAKeW
         SFK4ynDYD/mWDWKNXa2xr/2bDZ5wD0jQYy+q+BXD1EDZRZdfgxA3R2uQogcfifvg0fCw
         +uc2EM56PN42fidACFNPxCAr6NcFuCw0n4YO46HlK501w1zWvtE4LyzMh8dyvDgR4sE2
         ZUk6ZgVMoREpLyxkBuPA59Sqbspq3sRn2y0Tbtp0C9S7v72Wic45PBKM2VUW1mUosEsC
         14Dr/uN0EW2SyHlMSAUag+XMmfl4qMwSSrDyPyipVSmw6KznWTt1tpGrxQ6eQqm71+gH
         upUA==
X-Forwarded-Encrypted: i=1; AJvYcCUKuU6//uHoBG5xMIH0Tkt9ue/CSTxHz2zwABo7YhUVCUdoGFjieQZ5SxlKKa4IUz468ONqlx4HWs9GGzoltlBEbHvy30FclCb3CIr4HLZ18XFTc9CcAlwWIU9oPbCJUEwR3H1N+nvo
X-Gm-Message-State: AOJu0YxVL2rZMqDfgNivpTvztspJ6OoxRfrZdLf6ddKbHszBcU7YOels
	7MoHfU4S1yWAs4g7T3tfO2imfjd1fcRip1lfP+816zwavMfdbBKz
X-Google-Smtp-Source: AGHT+IGtHhq6yEiiulIYwbWbLH9rp2tc+PgviJAeQI/3SWUvHmKXCvEk5gVgKxrvXwKxyIXXBnfupQ==
X-Received: by 2002:a17:902:eb8e:b0:1e4:6253:75db with SMTP id q14-20020a170902eb8e00b001e4625375dbmr2093312plg.17.1714549195020;
        Wed, 01 May 2024 00:39:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902edc400b001e29c4b7bd2sm23626709plk.240.2024.05.01.00.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:39:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 23CFD18462B23; Wed, 01 May 2024 14:39:51 +0700 (WIB)
Date: Wed, 1 May 2024 14:39:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
	corbet@lwn.net, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, petr@tesarici.cz,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Message-ID: <ZjHxxzRb-63ARo6Z@archie.me>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SQuUPEbHKzRUh2zX"
Content-Disposition: inline
In-Reply-To: <20240429151337.1069470-1-mhklinux@outlook.com>


--SQuUPEbHKzRUh2zX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:13:37AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> There's currently no documentation for the swiotlb. Add documentation
> describing usage scenarios, the key APIs, and implementation details.
> Group the new documentation with other DMA-related documentation.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Other than outstanding reviews, the doc LGTM. Thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SQuUPEbHKzRUh2zX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjHxwgAKCRD2uYlJVVFO
o3WrAQDvhNlHDw0C1NqqL2yH9OQNIxn9j4y2CY6FFWX/Oz/INwD/WbBcId0StqpV
oVnntracxxAV03zfP4U6+nARrv12Qg0=
=zv+C
-----END PGP SIGNATURE-----

--SQuUPEbHKzRUh2zX--

