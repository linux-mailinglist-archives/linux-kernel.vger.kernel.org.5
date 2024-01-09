Return-Path: <linux-kernel+bounces-20440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9FB827EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFCDE1F24583
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB338F67;
	Tue,  9 Jan 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqoiXbgE"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1F8F48;
	Tue,  9 Jan 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28c7e30c83fso1624243a91.1;
        Mon, 08 Jan 2024 23:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704783824; x=1705388624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs3tOsO7zy1R5Dpwf1Worw1jnEX4JWvf4b/DnGpavKs=;
        b=VqoiXbgETnXs2LvUFJcTF5bUFN4Fs5GDG2BDIK1s4eySyx8W2ejOpdEy9HX6J1QonT
         PoJLOdf3VWWSZyOAeexp1HrEGzTJ/1q77SpdtkYdhWJy+oGw0ItujS5cVbGQ68wWPj8n
         GA9cwPdodbULrgxQO13u0LIUI8cjFU67WXnYgS7cmn9n5DrqEKg33tO/UR/k8/sLmIPG
         aTSXkT6AQ61KoznzAJBYOA75IurL6PrKk8+rY8oluu7MSNSUyRPSD17GFsLSDQjnrVU8
         5N2H+KHs+srTAMPj0ArJeXaBUNt+bldCo7yqIgQC4TqN38u3zJWjMgoDXQotWDT6mI2p
         Dh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704783824; x=1705388624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs3tOsO7zy1R5Dpwf1Worw1jnEX4JWvf4b/DnGpavKs=;
        b=ZjGZfkQrHfbc8bnud33AiPaMSJ4je3rFaCvu2v87ipyBipi/SC/c3xL3xhk5zSBkND
         uahl20tH54aPnkM3hdmB5yNE0agL1A+NP7ZnyyKU3ik6rP8yJxnq0wdFtwziUXjZirbm
         TLd3yP/Cgy5Z3a0Nli1ri+aH06ghRf+zVYL9iqASNZNYWf9aJZkh4jHGn84ACktW1D+R
         8wy0Quv8aUxobuo1OWN+uh9AmwPzWTpDQ+mL+igXs/wOrq/8+SHHjZTmjXdM6CHpR4GD
         NQ+2BZzbevfG43kyQLMf8ZYghjaFpB9QK+H/8yeplUaT3FIdiZtlRZD3CTqCogbPD2Ai
         i3+A==
X-Gm-Message-State: AOJu0YxjiG3WcCHSQvGWp7ekC9rVMPAsYVjxCMhDb1OV7tU3wJM5PYvv
	ktvbWH7lZ56ns4Hfji0lYXA=
X-Google-Smtp-Source: AGHT+IHlKJ76g+fmxlFbm6sHZQfVBU5b579SBwlHShnFDtKCXWmJQCvm2U+ap2npA6+m4wrCrourKg==
X-Received: by 2002:a17:90b:1b47:b0:28b:e09f:58c4 with SMTP id nv7-20020a17090b1b4700b0028be09f58c4mr1764267pjb.67.1704783823464;
        Mon, 08 Jan 2024 23:03:43 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090a2ac200b0028bc1df95c7sm1254646pjg.4.2024.01.08.23.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:03:42 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 32439184790E7; Tue,  9 Jan 2024 14:03:40 +0700 (WIB)
Date: Tue, 9 Jan 2024 14:03:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
Message-ID: <ZZzvzNcUQCfDJyWJ@archie.me>
References: <20240108150602.976232871@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Znhe3Gzkdkhr9ETQ"
Content-Disposition: inline
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>


--Znhe3Gzkdkhr9ETQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 04:07:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--Znhe3Gzkdkhr9ETQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZzvxwAKCRD2uYlJVVFO
o8CKAP0WyKQZoY68dpZxDcQ82JWlTdXk1ikzn2Yo5vh3ecRn3QD+PJqd+Aj8h9VM
u203dzRkEqfonJ7VtvY8hqTTDwRyiw8=
=3kED
-----END PGP SIGNATURE-----

--Znhe3Gzkdkhr9ETQ--

