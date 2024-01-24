Return-Path: <linux-kernel+bounces-36502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4318C83A1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0436286AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA75F9C1;
	Wed, 24 Jan 2024 06:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZcjS5T7"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E05F513;
	Wed, 24 Jan 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706076580; cv=none; b=koC6wuEUBGeymEmRT2su1B+YGIBDYg1dTqlaYLi9Y+LH2JDYbUgb26Irr5vQEKyOeWMtEnP4xejMW5Rmn/GU0/4IoIpfvnbbhjlKmsdvixfrufmnE/wj7L5JmGuffbQoHtiYJiuC/GvX4LvQEOgSIKmN4bDM3/9S+nRuxvxhH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706076580; c=relaxed/simple;
	bh=QPrzbMUSRppMUppd+9EXmi5fQQ+Uif6tDCZQPvztAlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exHv4z3jmIb8wJXtzwQ1K1yCxBD8XH58JBLUsRY+7ZkDRoZOWNEfgOuQrF5yypyshFv2N09UqLB890GZJLCRMZUiwADXNVaWz1lurF4+vdmLLB9TSWK3c+Hm5gcWOI1yWWyA7pTq2xSWy0p8huJwZ4hklkaArS3zfPe6QmF5goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZcjS5T7; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bd6581bc62so3575130b6e.2;
        Tue, 23 Jan 2024 22:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706076578; x=1706681378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddFkrLYV49OOGsw3xBz4LEthLKO7WQPAAsxP1oQV98g=;
        b=nZcjS5T75F2pIZtv14TAiAxgt8LsTkijIie7SxDMSIKRG5Q35ygMjhPskxIMHyC1V2
         G/yBbE+IecHnlqBeWdrX1APRk2b01hS00HZsSCkXMBBt7wzTwTTxB11X1+xsxiYJN21d
         oyeX9NPXy2U24BSvMbVLsWr0zLz4f1MnJy7SlQgCB1iqeVbqW7L11c+jsMhaCCEmQnST
         VHEZosCriNBmYBeBb3PPS5aL1MbMJeBhgKPKshiKNfiQWqCOtNV9kpHI6+JeUugnve7k
         IEnw0PoPZfOFqIbvmaNW4paLide7CK8F/qZ468N9zbHwcCWuuYBKW1N8hwfI1Xv5AcXX
         TD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706076578; x=1706681378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddFkrLYV49OOGsw3xBz4LEthLKO7WQPAAsxP1oQV98g=;
        b=L+tmRD6Bc7YE2hUWHc3prhk9OXs3fyq1iMicDAJCDykR/8L3hSyqaG5nfBhLpufv7l
         qu2bj4cIrG/1QIPgQeVlUyLi/I/q5EIVRVlwkDaz/D/kepzqH2o2bruKsEnogSaSqe7B
         oVTBjLzUN+nl7XXYQzMkJyV4FUOTb2vUoYJeIZtS0ban5S1z/pRrRhYRNEo9C43zNLYI
         YMQwjzY1UT4NQiMrQZ2r73GuwGSDUuHmYBIy8Wr2JHfy2iuhRfVHS49YWkw55jHWg++D
         TUh9hheI885aebknXK+5z09Shz+a9VaAA0gv9AHuRZEgBu8d/KIXYPVg10/XVarR9xLo
         PAJQ==
X-Gm-Message-State: AOJu0YycLjE4Z8kT0eCqpkZ4EP0elvE+xBBMcesndAxOVgmJZkddzst+
	7M7+308onxAAEU0wc9S91YSaVnMEUS2gahd13vVWqWV9ad7ZPhvv9uR7sLwaQh0=
X-Google-Smtp-Source: AGHT+IHy206D+dXsznYMPRNs3sVxNuAF0r+/fh3ddUozvjmI9oIvn4prCQMnoeeRqTd/3iokULUUEw==
X-Received: by 2002:a05:6808:1894:b0:3bd:cfd3:8607 with SMTP id bi20-20020a056808189400b003bdcfd38607mr660611oib.65.1706076578162;
        Tue, 23 Jan 2024 22:09:38 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fk19-20020a056a003a9300b006db87354a8fsm12657551pfb.119.2024.01.23.22.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:09:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 041B0184EA861; Wed, 24 Jan 2024 13:09:33 +0700 (WIB)
Date: Wed, 24 Jan 2024 13:09:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
Message-ID: <ZbCpneBZPtJO2AQo@archie.me>
References: <20240123174533.427864181@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQAs6C5Lptua5lKA"
Content-Disposition: inline
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>


--EQAs6C5Lptua5lKA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 09:47:11AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--EQAs6C5Lptua5lKA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZbCpkgAKCRD2uYlJVVFO
o0KXAQCuyDhAAfWtcAEGKQ630SuIueR0MiuVhQRAwEnF4RU9jQD/Xw7Slc7k3hi/
juirP4bpu6pgj3VimPnzm9+dNuSCpQU=
=d8b6
-----END PGP SIGNATURE-----

--EQAs6C5Lptua5lKA--

