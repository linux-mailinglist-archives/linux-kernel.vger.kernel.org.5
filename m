Return-Path: <linux-kernel+bounces-127525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A8894D22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EAF1C219F1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA33D962;
	Tue,  2 Apr 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJP5E1EK"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456943D3BE;
	Tue,  2 Apr 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045183; cv=none; b=ARd3JKforE5I/OD8QXwWRzPvnzbWQQaRm4hiLfwaJEFpGSry+kubRUpXYfVuSOMGWS+GNKsZJ3t3Uc5MCQDbiw0/hSI9eROOHR6KHmX9RPUf49S9AFkJXLEg70oug5M+utT5vSvyDjPlG+MDd4FC3v4Cd8sydOL39xaO5ZKDvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045183; c=relaxed/simple;
	bh=kJgQirTI1I953hqjFcUemxh/SZX8R5I6aDYfAnAz6fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyFYCJ3WfLlI+giD1svpbhJojCW2AiWV6/lKR8pKEeqwu/4s7l8wDOP+zoo2AUD+sMzcqXtbXAk6CSa2cukmWnodQbMbFTLra6TJSkbK9Z8n9iZg5PtihvLZIwfTQk/es4GJghws8UMqKrjmtHDmNcEeQyCDEuhbTEywxTqDskQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJP5E1EK; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c4f55a1bd6so158095b6e.0;
        Tue, 02 Apr 2024 01:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045181; x=1712649981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPHs2hPWTLntkIggErFbbhASWchhF98xlAmk0EF4jpQ=;
        b=KJP5E1EKaBsJLMbYoQTSCiIwNUnuPFSlLQswwAhdi+txcJ4rlu/qCuYSP9tU3+VpKE
         dm0R6pxieEn0bEQ735eaqf2ZW2RmrHCadsq4ry6NQUGu2QRzl7nGxH78Aja/hCm6bcqp
         yC9cHaOMG1OS/V9pgBQlRTGvkgJ9Ex/+XwdLOgKvHLhHb/EqGkRLbdUU5xCyKTHfvJfA
         MKjKa9VlAWWeREk3oeDk9uqBURqQ2OVGOcG5Ih4p0lVgvNRh5OuP/oBo+ANo7dReIL7+
         /jHevvNpgA5SEqpYHIesElV+u9EpKiuOHLRi63NbI7uJr2EJTXixkHKMDO+knAph7AnN
         okGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045181; x=1712649981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPHs2hPWTLntkIggErFbbhASWchhF98xlAmk0EF4jpQ=;
        b=GdNwYWw+5xNSfJHMfdUn/bmGHO6d0aNz7TZn7A7svaMFYCVi/xL7BKDXfCaSdE+UbW
         y/WPnhofQfaLkmeqt+FoMlvvRBY31my9n/eHXWtr4cyMqOZRodEZxH1MfNSd8yIC/EcP
         deH/MuIyo7SXgrOBckV8/MoZ+3ajX8gtl+ueHc2eNWrmu2gJIsabOV4AreRtyP8Io/B5
         FVhWlsgjOPAIv/yg4VDSsUc9kMkX0wcDDDPr63/Hox58bxkNirkpG2eTtvyJdCukK5F2
         HrBzWn3Q6KyaHdhA9pIY9WtUNKB5dx3k0x6YM6nTWGJRhNMEF5W97GcsIOtwqFIXXOfz
         nclw==
X-Forwarded-Encrypted: i=1; AJvYcCWwpsDPPk2OVNSH/fsipLgpukIVeW394Uq2fzqj214IBTPtLQDj2MtK5AqwONMnHwQsCG5wvfjkjz2esA0ZRxlZgTmvO3GpbtMxTevhgKASZB0eF/ysGVkeac94ix0dLphkEo37
X-Gm-Message-State: AOJu0YyYKFWgR1BhDThmnrfBhhqvE0z5/7wU4wudPgkbA0QKmDI0kDZL
	bG9eiXRoUBXFl8I2k6fDQYh3Rf/Lq0U4cKyTZOeu44r7xdpXBEwp
X-Google-Smtp-Source: AGHT+IGqmSpF0yhkNZdjEM3dvk67w/vLKdWfjypi6wQ2vQ2Fo/gMkH29noVnqfITEUtTUNfT1+Wpeg==
X-Received: by 2002:a05:6870:a19e:b0:221:bcde:29cc with SMTP id a30-20020a056870a19e00b00221bcde29ccmr14025852oaf.21.1712045181208;
        Tue, 02 Apr 2024 01:06:21 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j23-20020a62e917000000b006eae33e2ad0sm7713803pfh.30.2024.04.02.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:06:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1A302184797C2; Tue,  2 Apr 2024 15:06:17 +0700 (WIB)
Date: Tue, 2 Apr 2024 15:06:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Message-ID: <Zgu8eRIe-8V4EFu2@archie.me>
References: <20240401152553.125349965@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XFKL76haxz2xDr+I"
Content-Disposition: inline
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>


--XFKL76haxz2xDr+I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 05:39:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--XFKL76haxz2xDr+I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgu8dQAKCRD2uYlJVVFO
o0vEAQDaf16bnXQX8ruA/3MxP04Imds1t7wRYp4OW4lxH0a78gEA8ClknHqRVh5O
SShmSC4erOY/HEUqZ/IpxgcpZj1tTg8=
=ypa4
-----END PGP SIGNATURE-----

--XFKL76haxz2xDr+I--

