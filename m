Return-Path: <linux-kernel+bounces-30827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 056938324BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C9B22320
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48370539A;
	Fri, 19 Jan 2024 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyI4mMT6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF903214;
	Fri, 19 Jan 2024 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646752; cv=none; b=fF7Z4MdrqY2m8JFBM2axBIbyudtnvicsKUFngUgkVf/oCPfzgix8lmv/MDPc5rfzYWZir4PMIGQs79rUPeobWkxNyan22hLZzvC5OT8S5d6idters1QcD0T1jAuzmUj9IXM81RUmOShRQd+u6DKcmvxB//QKEKFhva2XlBvo/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646752; c=relaxed/simple;
	bh=wQk4FOUlnnv8BFLKWr2FYKxfjNLY8sHTXI6EqsBnuMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUx+uO/wyoVfNn92TGfIzdCJ0OoB9aOTw6csmD1i258ItmjeNJu570fdUPadpeO2j3ebpX3pvSzBp0UQjqww/BHU06eeuU/Xh2xs2S62usX3jSqs4Q3Fug60X5AgEtHefDkI7pk+maJB/XeOuaWqB00NazYMumK2A6uaeu/olcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyI4mMT6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so399683b3a.2;
        Thu, 18 Jan 2024 22:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705646751; x=1706251551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTKVPZWGYFU6FXuHPoulVuF2kETQ9HD+uYcU74cb1xI=;
        b=hyI4mMT6/pvMtqXyXqkLOIrKxJjgkZdXx0fbjoRCZOffJpQ/1sNKpjoUeMZF9QyHjz
         MzELqNYOvuwrvupP38dVYtcw8I7it1B1PAfkrx4xIWLR4WmvMdunSn0bMmgmD+jAGtLR
         4U1ZgtByFjo1LsUnhzoZ6Ov5ULqfXcsvKi2OB63hGOAB3pOA+IZQJnCeCtUy44CPf5pT
         jI9qTw5NNn8ceCNooSiIMysWibr5ov+d2V3TJqOibLmi5tVTarlh/qu/UavS2r7/hnUy
         Z0/ks0CxmuT1kOQra0FsKMR9307YDvuFpeTWsG/i3XptkHpR/rpYHiElzP48c62Tzp2V
         auZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646751; x=1706251551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTKVPZWGYFU6FXuHPoulVuF2kETQ9HD+uYcU74cb1xI=;
        b=JOHwgnTmd9Ga2PAmHR4zd6wzp8JXh/4eBZurs+crqfCA2Wcd6Kk4Tw/ZiZCH/e3ueC
         7Y+Xc+G536ULhhxsnPPdMxMvYqzkl4ZSFuHLsa9Wn6eYVE4PNRXqUcGcWTXZR2mrMTxR
         b7MEs/vlC+fCR5+kdDgkvP6JTBqfJPVYlkAmrHzxRcTMM4lr0r3bkltltyyYr9MNahE2
         61RGLiYMU827E8MiQ6ZPFUuyg8Z0x8D86ivsTs9/XUY4SQPDtDXzouH+rFQ1BlP0vbJ7
         eUiqfO93InC49PAJg6T0cx7XpumYabJ36/IGKYDS7UiOHd3fbtMwXEwNcGnwKRyDaDpG
         ZqPQ==
X-Gm-Message-State: AOJu0YyU3lfKLCHbwHX9Fktyvw7EsF/sVkNE4e/aK8CkOHWiP/EUzIUe
	mxRYqMvZMaur7HadAvhCcyKLVnSShInd7r6XLYDGVU9K32o/Nxec
X-Google-Smtp-Source: AGHT+IE90ay1HpXv0tuY9/Vu/wIY6ULbl1WxalXDALUIyoRxbSFIDXIy8E5Zv0zxEwLjdi5mqeA+BA==
X-Received: by 2002:a05:6a20:81d5:b0:19a:d795:7ae8 with SMTP id r21-20020a056a2081d500b0019ad7957ae8mr1818901pzb.82.1705646750688;
        Thu, 18 Jan 2024 22:45:50 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k9-20020aa792c9000000b006d9bf45436asm4372549pfa.48.2024.01.18.22.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:45:50 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9C2C4184DAE02; Fri, 19 Jan 2024 13:45:46 +0700 (WIB)
Date: Fri, 19 Jan 2024 13:45:46 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
Message-ID: <Zaoams2Ca2RgKB0F@archie.me>
References: <20240118104301.249503558@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uveMEZpKYU3Kv0ph"
Content-Disposition: inline
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>


--uveMEZpKYU3Kv0ph
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:48:50AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--uveMEZpKYU3Kv0ph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaoalQAKCRD2uYlJVVFO
o67kAPwIbu+cMpTwjCo2YUWCUWcIvqh3zVWY8ZW6VJpDWacXyAEA+DDItFr9LArJ
/fBg3dEJQ6tw7c5yixxIgn/w5bEKvQg=
=/zNN
-----END PGP SIGNATURE-----

--uveMEZpKYU3Kv0ph--

