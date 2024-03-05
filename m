Return-Path: <linux-kernel+bounces-91647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D987149E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264B8283E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CB3D0C2;
	Tue,  5 Mar 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeIt0vGI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B96FB5;
	Tue,  5 Mar 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709612277; cv=none; b=rYjCEPuky0+eeg0mC2Gyxir9KdVtqxUWHknbZL2q5qQCD9khpmDMYBf2k5pTnozhuLoBHYr6klvIAG9mSIzEbIug+6CcR63bJ1s+/XkUtZF4/rROffhGGshY9IfLztXzgTfwZwLK8hXLsnkB0zRMQTS6ywxgpgvDkWLNn7WZbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709612277; c=relaxed/simple;
	bh=PMm6IJbVUU20g9GmtA1BcIAyZWOfquQicAEh8ioQwis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgVkOchvIdVuuSFaPq6hFQfYFPj8ytAV3Dgej/mCkTYLcDNjyEaHqHTMLCM6S/MJW4qQoPDPNryf2l+2f+Jgrarm6khqOqg7deXzRSu4q5m/o9ssW8RYtCARjaPWc59yRO2OPLPiy8Ay1gL77d/4GR97QzRyKHw4d9CWSQf1oFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeIt0vGI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd10ae77d8so13468585ad.0;
        Mon, 04 Mar 2024 20:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709612269; x=1710217069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQaq34HoVtHjvXgaDxLIUrazOpOpb0uW450dmoQsxuw=;
        b=XeIt0vGIl8V5B+dOSxz2OqJuZpUssLEnDkQOIWt/vL3oSMJRcoqBB6NseDZgM5GJaq
         hz0x5RSpb+Qwew3uVOmrjlOBwRsmq/Y15DHJzTzFmgs0ipmK/Qi2ZteEZwsGQ7J8ZdFE
         AnaV5dBlshFTe4sLWd0rJ15FqWtLb8Nv4reuIJ+15DbSV5l6hzX2LQZUT3U0WuZuXS/k
         u4NmEaDHIvFGuHZYaRTAJWmLqAiU164ImjVi5GJkYTuHcnxEgFSW9gtnR9DZ8tCO6Jnn
         d3/GJNIAuTcJTg7FCq5Y/NkEDxqOnaAq2W8Xm4g2A+NZrX1MzqQWN9hE0n6FkXz7bASN
         KZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709612269; x=1710217069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQaq34HoVtHjvXgaDxLIUrazOpOpb0uW450dmoQsxuw=;
        b=fK9ONanAjjwHO+2S/pgg/pCdBnpTkQjbzvv89IZiFXDGYUEtbQqTeM26JbtxAe5irx
         Okxe3tjggCATCGwDPZiHStOBYJ612Jgz8GvzedbWzpuoKShi/Obuokp0nudfbhr6CEGu
         wyJn4mbbUH/b8Gemd8UvQpo3y5EYbAOYVkSrKekCx0PmnZTI5Ych9nTnUs+g4T5Zx5Eo
         nIzyl88OA6WoTUwrBHNyUROkcn1i18D/eMpN3298yuBxJHzjG0Mhz94yjGFO0hWBJOsd
         20RTZZNbxmk+xm9nFsIGPjq9Xb2pLV6XBT8xn9eN/5ebQeC64NEqji4UcDxSlq+hxZ+j
         AYLg==
X-Forwarded-Encrypted: i=1; AJvYcCUt1wBJ8138yzTlFN6t0ZOn2lFVT6sXWF8VmKALh2VTGI9NPTBrmIi8bEefQpRdYWexZA1OQFu6T/ysjLr5/gzZAsKqHMOxNGjfGMVr6VqZ9ZNaj4e/oSGhFutG0VgycDVEYLW1
X-Gm-Message-State: AOJu0Yw+wbLQvNJOim3oV6eRvk087M9Cp0RHMpyqXYPxmp7CkJzBxIuS
	sYRcW7KAPPn+49k2XVd61NjPS6js3Dqy5wkNCOPhezTUqCu4t6oU
X-Google-Smtp-Source: AGHT+IHIlsa9YB+bVzYd/+WxOaXiNYu/xNxqaMa1UED3Hz5jg+P07OlwsttsmBAYJBETkxH8Hd6Urw==
X-Received: by 2002:a17:902:d2d0:b0:1dd:7e0:29c with SMTP id n16-20020a170902d2d000b001dd07e0029cmr1022213plc.12.1709612269227;
        Mon, 04 Mar 2024 20:17:49 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001dcf91da5c8sm5519409plx.95.2024.03.04.20.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:17:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id ED0C3184CEDB9; Tue,  5 Mar 2024 11:17:45 +0700 (WIB)
Date: Tue, 5 Mar 2024 11:17:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/143] 6.6.21-rc1 review
Message-ID: <Zeac6ZuQZcLfeao3@archie.me>
References: <20240304211549.876981797@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NP6dH/psSJnTgtz8"
Content-Disposition: inline
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>


--NP6dH/psSJnTgtz8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:22:00PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.21 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--NP6dH/psSJnTgtz8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZeac5AAKCRD2uYlJVVFO
oylgAQDm0/YUAzWYS/z7s1dCuazDkryEOFZyPPZIijm34L0vMQD/XdrFq8DVd/9O
YGAPYKJJSwmEy/G56+3aj99fiTXPdwE=
=/PQ4
-----END PGP SIGNATURE-----

--NP6dH/psSJnTgtz8--

