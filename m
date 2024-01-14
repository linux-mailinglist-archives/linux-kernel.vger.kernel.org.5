Return-Path: <linux-kernel+bounces-25408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870AC82CFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20155283160
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916E1852;
	Sun, 14 Jan 2024 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNM2gNJo"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E807E;
	Sun, 14 Jan 2024 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so2122654b6e.3;
        Sat, 13 Jan 2024 21:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705210489; x=1705815289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sE8GJgZQUurHRznhkMrLCR2jJi1Q8GCwy2Ue2LjotM=;
        b=dNM2gNJojTv1QW57qpzbynCbwdUD53Eh6nUSQHzv1PkY17+Pq7UTUXy+M0fVTMZvW2
         9fG3buEkl/LvHZZs3j9j7hG6j6JAKAE9/zOJyilPC1LHiWCA4FGpnid4KB09Tu4P95S+
         hYhhCytM9ws2eGiLcumBPgeOXGDdJ6MXHT9z3tpK8qQ7xR/iCONzFebw5h0zXEPcHClV
         AcmTM429kk39vzqMbAsCg45lYQldIdt+mMblMJOx8cEiJTwZC5rWyrAsSFoZsClnzMh0
         7kBD1W3hEuoFZ5O8/tJrqigo/BqmHFZp4Vj8qX3ta/PNN1VT3eDy+ff8M3FUiPxqTSSX
         xvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705210489; x=1705815289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sE8GJgZQUurHRznhkMrLCR2jJi1Q8GCwy2Ue2LjotM=;
        b=p0+HqhxgHo4WZdBFMs4iHk6ENMjhDvgKIdhhVI/3Xj2fr6iL+xMX0XzSquZlF//1ns
         fOnxJi77KNAay9r9zrQiym3PHY3fEI+JewYSzBvcbPz1JBQr7DrL1hzLBJX3tsaF1Mbm
         8+4GJGhiYCbCoW90ONHt2hqIGZ/IFrfncZNCbsrsFCNCFMtEI73YW70yFkTExOzeaS2+
         J0F2zxoE8pXry9gjklfs9hoKzO5bc3t5bqy620ArYuPUyQS9Fj4Dhr/FTqeW980tnDuI
         NLtq0PPG++YYUtGYYa22DUT2y21o4exArqKYKhfqEmaGg0WsF4qrhFbkP90jB+DV9OwH
         o0jA==
X-Gm-Message-State: AOJu0Yzl+Xdo8363pIF/pgQyt+gXQeul9sCeB4z4XDbxwK/lSqC8Xx3I
	iCTQg3tdZYXdKIV0PaJCiuo=
X-Google-Smtp-Source: AGHT+IHTG+PgGBbFgr5D7soUP+YgGL2BeumCRe0trgMNggDvAmVDnKvr+0kfpm4+h7VZoM2z5cvURw==
X-Received: by 2002:a05:6808:f15:b0:3bd:578c:d866 with SMTP id m21-20020a0568080f1500b003bd578cd866mr4727902oiw.35.1705210489281;
        Sat, 13 Jan 2024 21:34:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ke12-20020a170903340c00b001cfc3f73920sm5550792plb.227.2024.01.13.21.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 21:34:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 06AF51846DA01; Sun, 14 Jan 2024 12:34:40 +0700 (WIB)
Date: Sun, 14 Jan 2024 12:34:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
Message-ID: <ZaNycIqURYZLW1Yt@archie.me>
References: <20240113094204.275569789@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JGCWdCXWhEvYzJz7"
Content-Disposition: inline
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>


--JGCWdCXWhEvYzJz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 13, 2024 at 10:50:58AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--JGCWdCXWhEvYzJz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaNyawAKCRD2uYlJVVFO
o2JaAQDxLRLceubxCaSwvgyu7sQ6J7gVQIjdjD8/1ifIc0aq5QEAsd4mDLOz50D/
KDvdhnKa4f3YVGQCKctZ+SuYBXsG7AE=
=xq/3
-----END PGP SIGNATURE-----

--JGCWdCXWhEvYzJz7--

