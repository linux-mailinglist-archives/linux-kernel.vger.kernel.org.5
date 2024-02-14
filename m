Return-Path: <linux-kernel+bounces-64760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE485428A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B61285A67
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2610A01;
	Wed, 14 Feb 2024 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0pCrmRW"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC56D51B;
	Wed, 14 Feb 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707890058; cv=none; b=cFyN5sbU3xzEoI3LNEr3Ut34DaiCXeKTaQc/fDE1V0+E4fU2Obq5J2E1nfJ83r0ei4nA+lMPKez1tHYMLutxnvSHw74umseDMRjFNczTO8+F5aCwALDGhSnlUXrnf6fRmp7aMjUMV9oZlzCORx0T9+2WB6MFRI2PyTXuGfcS+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707890058; c=relaxed/simple;
	bh=25ckc3KM/P31T2MmlHew23WCxv8QHqJXI2iLVgv6gnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lucqJM8lhQ1AfKL1Y9Zih7kN1NXxvZit7VnXEqJYE3PA7eTv+GD/kjYroj9tOaDX0so+wurszGPx+lM6E1F8cghE7zP7xIzofWjIl776Tgru9+bw9FsU8clZIpjw9ppQW8/IJt9IFybfWs42mNRmEZjStLrAjna5Fl6NrOSKILY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0pCrmRW; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c02b993a5aso3010006b6e.1;
        Tue, 13 Feb 2024 21:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707890055; x=1708494855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghC12rpvGm7hIVfOQHZin5gwiwfogaH9K8RQZ1Sn/iQ=;
        b=L0pCrmRWfNVFXJhOiRcNGnJOD3V7nsr9AlxtnO+7fd24vmBvHWPUSUtAR+PSPRDFmx
         OFpR6RK5PphINfZt+9sZdfPJAwXYshT82hM/Sff05XiXHrO1VRAJnowTndk9IIIOYRZD
         VK4tdIYyfYi0OyBTxV4oqxojLoZ6Hq2xdah9C2AisdTXXZzibihHIjFtWaaDLQ4kIuto
         4n1qtMnMV+qIniMJOK319pQG0LdpEvqP9TGvOJWFO3aD23DKc6RmFsPUY33qtjXUqXkr
         XHeMg8TY6/kcCCh10FTNKW7LteVbYWlUYi9MNuAEKBgt8Areprp1slkjTg/3DCWG3MSh
         38QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707890055; x=1708494855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghC12rpvGm7hIVfOQHZin5gwiwfogaH9K8RQZ1Sn/iQ=;
        b=t/oJNfd4ECOjUWOPPwWCsFLdPG7UVFZRzv71Mxrodz6ReFgGbrsoX3jKdw26lHkE7R
         TATSScVGDA9TH2gk1kmOvfBY7R1X7giiuR76aO1WZHZ4ufqfwcZw28FQu7Q02p2+mKoK
         L0NodnFn6AeH4wInsSbKBAr7m60N3GcEE+XKglIiXBoD07PwNLdhxDElJqhXS5nmlW/I
         9R1Is3PZzNy80jSWKk8Gn9JAHTEIrbfwEBMvW3yYbS7U1CfDeulijwD7NKutTNE/5JpA
         DkPE2jrHDago1s9zmFFzrAG7qkkALPa1uEBY/PnMTMaGdCYdi00FxVCXbVg4kv9kIGQ/
         pQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVaIhGeTQV24ybaC+KZn3gHCdB19OLbZ8hsYF+nWdK8Lr/plq4d35UBnXSKln70hQSjrvbicXrI8qxaIFQgFxsuIFo7rj0c9p88vn4Yw3/BGIApxlySRThziY/ijgnvgUBunaOD
X-Gm-Message-State: AOJu0Yx7hj3TxHDvdpbAI6bI8Le7yuSU3HhZIMHjDwG6r+zmTFC5INR5
	sYz50Fr2Wy25zkIVH8FLMtwXGnOUEySVgijxBNq5dzz4ycQu4ygR
X-Google-Smtp-Source: AGHT+IEXpLPaMTyAVhb4VHkjhzRgcyaB2xH3mfWfn94BF+1TLb9Cj8iZhNm+mNqolmDyKmzfO+X1cQ==
X-Received: by 2002:a05:6808:14cc:b0:3c0:3d8d:7f6e with SMTP id f12-20020a05680814cc00b003c03d8d7f6emr2121825oiw.5.1707890054945;
        Tue, 13 Feb 2024 21:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXCJgN2Hv+RvIZ8J9zjiv1ouPV57Mq/XEHjqEtPRtzonHUmNWPnLswOIY5Yby9VMgdh5zkANwP1nTjKBFLXSHvnJdd/+sDKfKDMil9l+LJMH4JN+ZrkgAuGh41J8+O5A4uT5Y1ALEHKpaVDMAC60GQJ9SxaMV9hwTGQFHDlUkOQDL4luB/8ZPUVdanLt6Qam97PDPGx+aJHtC32oDLDgyWZ7iM0etjbHfgo9xFUxg/WV17aOVW3HiihJFrnBHaBG03ISAskXyi6FPOog3ACzVrVXAGnlgfG/2cmyOpnR9R23AM5DLpoWIu5bJVqVhJjDkIxl318GQ45h+qDF03P6Qv8PT/YNqTviWygE5YXr4AFKbbLf+D+TGXG+7IdsTMN8pXX3NIMKVIBr31oBQ+XrmmHdEhM2Tc4RwS0V4qrSBZeqJYMpvmC7VG1kmOfw3U3c0aClyi6kktwS/aHuh2JDMIG9qKa8IsGLluynFuRCoSTBKGlHnRuaiwtbarixra6GkQGRnjLwTFsO1zdDqIgQfMeYqc0lP51PYeWaTDhg==
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fa12-20020a056a002d0c00b006e0f6e6c014sm2529593pfb.84.2024.02.13.21.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 21:54:14 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 31FD1184690A9; Wed, 14 Feb 2024 12:54:08 +0700 (WIB)
Date: Wed, 14 Feb 2024 12:54:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
Message-ID: <ZcxVf2ysc1A0nRlu@archie.me>
References: <20240213171852.948844634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0gDu7LBv92JGmNAy"
Content-Disposition: inline
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>


--0gDu7LBv92JGmNAy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 06:20:09PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--0gDu7LBv92JGmNAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZcxVewAKCRD2uYlJVVFO
o2ZuAQCcBrSXuoc6mNTOwuhFUBhCaiPzAKZLcjTU8b8yb3peRwEA9JZq/o05Fq9Q
xpdcN0T/vsW9YJaSMqVp4WXASgKawA8=
=vYtO
-----END PGP SIGNATURE-----

--0gDu7LBv92JGmNAy--

