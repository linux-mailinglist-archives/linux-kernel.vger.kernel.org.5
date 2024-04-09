Return-Path: <linux-kernel+bounces-136076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1802889CFD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D41C23A71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1018C15;
	Tue,  9 Apr 2024 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br3j05FT"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F23A1B5;
	Tue,  9 Apr 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626200; cv=none; b=ETSX3g5wn5E4qEx0QBcJlbpPJzHa9T5b7dP7LFfso5qVDBPnN0nZL77xWcqdaU8GPFs4qXlJwoz+QyAdLhySUZfSdsTZ/7TbzcVF5yEzLMgfZ24Rq+TPqmaB43XwYDfX3nb4rCAYDlAgO+MJkqDdcVopf93YjCfzujkktsjooX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626200; c=relaxed/simple;
	bh=1z6d1tDDSFA4H/I8bjImtg61JQJRyJ40xuTg84O98aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV0BzmeZEe73a3qo06ONXAQUuXJFiEvdq1RGWGhOJvJ3kj7+bbTF/Fg8xDdXrQ+MVF1Tl5sSxalrPH0SGbd55z6Gb57qFVUSimzMLvKGgvhSA3auPEwXhSh7GhAemakBZK8cqWWhR7wLDezdmvxvVJcvm5vLscg2pSgwxlUUOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br3j05FT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso3176413a91.1;
        Mon, 08 Apr 2024 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712626198; x=1713230998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcH7mjUSf37c2TRYjSnNBiA7jaHiSTYFNcmHQ9LeGEc=;
        b=Br3j05FTv4/gxLusypONvWVSm+IgYUzawnnESuU82PP/lOqoyAUCnnVKxv0uZnxH/9
         5zRRVI9AhEhC2zpI4K/vBQIiv2UpL/Pb0cwAC54t/SbB96szBqMfV8v3vFvqxBPJARK7
         y/oSMiNFoubvkbko4q4SaTkzRx2EHFmDmHq82MTkGeRj3+L9Gqz066eULeu6US+nYthj
         jydt/D/StlBJwFDLws/jzdKmMX4rSuqnJT5xUm7xm5gqfS5Pceh8AZZ7P3K/Z+FiKn/Q
         LDCIACswMf4OadKLdVCgJZED669RxFvjG4qbWr8e6yA5DO3+Qlzsd+8svnioN3n3Tc1a
         Fofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712626198; x=1713230998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcH7mjUSf37c2TRYjSnNBiA7jaHiSTYFNcmHQ9LeGEc=;
        b=wLBA8w81Mso8pSIzt3j5JvvGzpZs70RPL+l6wMxxvm6vEXP70uBnt8z1p17Lz5r0TV
         SjXs4bR2uTBsMMUp8vync6YYPtd3eRblfM9Pk6tciMRTp/BLGt7z78V4lOkpGtOD2JlS
         6SDwfzZq5KirDS+/cOHKc4VNwH4qHlrCoT5dB1CMos1zKcWdff14swfpRMwI/wW2JQ/i
         iiKsBu2YH5o6M4DTVXFxAkWJ1/2eEIkZ6B3VS2UWES5oZyUyw53jkWD4vDM6tHYpyxZW
         1cvGFWJ3BZrq1jhbMLTjqeN8S4LNRHgDZk3RqNXmktUSIpG1ezBGssDQ0+9XT6iyNhGq
         H6dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU43Tl3STFnjbHhuTtGn5ucKZ3o4LB1ZjXOsseClegSp1caJigw82AGU6y63lw68B2DRHr34cTdv6Tmtfgmj5LFMXTvb/OwWIAvrMj2P/GyEg8arRfWQh6THorJcSVbghQ269yq
X-Gm-Message-State: AOJu0Yz9em1//l3odCtN5QOgcDil8ZXqZcakLA9sQJWBuivZb+oq1oT6
	6Gb8glZmbqJ81sl/Puz0Z7O2sX5EiWSdc3d6wg0TCbIpPN2r8BMQvmy8XlLaCwk=
X-Google-Smtp-Source: AGHT+IGZnwgUOz1BqN1c5yLkdQwmmVssLMzs57TdHPJEJD5dpvuXwzoiIyQ9tZ5nOTVfg6tfbJ6www==
X-Received: by 2002:a17:90b:805:b0:2a4:7133:7e02 with SMTP id bk5-20020a17090b080500b002a471337e02mr8521041pjb.35.1712626198010;
        Mon, 08 Apr 2024 18:29:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b0029ffcf1df72sm8844622pjb.38.2024.04.08.18.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 18:29:57 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D49FF18470A1E; Tue, 09 Apr 2024 08:29:53 +0700 (WIB)
Date: Tue, 9 Apr 2024 08:29:53 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/273] 6.8.5-rc1 review
Message-ID: <ZhSaEVEEh78RY8fz@archie.me>
References: <20240408125309.280181634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a7kZAJtOWI2jj9SG"
Content-Disposition: inline
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>


--a7kZAJtOWI2jj9SG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 02:54:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.5 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--a7kZAJtOWI2jj9SG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhSaDQAKCRD2uYlJVVFO
o+2aAP9y814LJL5WCPu+pvg6Hy2dWEwsu28eEHvnd3UhmENragEA9wg9CmasZ13B
RCiyK5QJI8v0LCa3Jb/97eksR6Z2AQM=
=gjIS
-----END PGP SIGNATURE-----

--a7kZAJtOWI2jj9SG--

