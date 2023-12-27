Return-Path: <linux-kernel+bounces-11775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57C81EB86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF660B22097
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C623C9;
	Wed, 27 Dec 2023 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae9MPyRg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5EB23A6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9cdd0a5e6so290953b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 18:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703644233; x=1704249033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xBQFRljuS9xylNChmSTG+Qfitf8PreuDOuqdWWJFaE=;
        b=Ae9MPyRguV//17mqaLkjZo7QQ98Q4zIijbMI6XIRNAdpJlsrvYxtXNoAyHVPq2isUr
         lT2VJSp75tztppMYpRAMgpDrhGTGBtF9Xkrz1mPdxwL3hEDpqFfUIaCj6j0+T4AMG/ch
         viaf9yGWV0A08P5hLjRs+1jcVJqWedbsJ+mHD3hKwSOwpcW4JyreGpVIV24WulqskZAw
         gOzwsQF1FB9HcLpJp0Ybk4orFNZa/wQtK2jd9UU5YNTSA1f9oIHVt8Rtu3mCjCIxp4LR
         RYD8cekJbcccIvaiUm8PBm+TsU6d/+6gn4oFrdbTQHi+psSUh5wZPD3f6FMmbu4M3WCK
         j50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703644233; x=1704249033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xBQFRljuS9xylNChmSTG+Qfitf8PreuDOuqdWWJFaE=;
        b=MQOIgLZjvSKUePU42NKAyClhwNbdadRQGUMrED09UPbeMOkDA4b7PtVIiev/sRV4tu
         8rAg5+L6KlvaQKv3+Lu1MWBZuD4N2u+aDoC2LOlksKxu40Ynhy+AUiYO+NHQIEozsGY3
         efj7wNclMUJarylp/SbPdCnZZN2rgzQlcVw+5r56/nm+Ic7U3mOsb+9ME6QfGlVvZMhO
         HqFYenWuSoFJTTTs37PBrA9f7cNy5ZCr/033Pyes4dtxxPIWv4q/clH0BN8ElbRvMTyl
         L9/osL+eSvB1JoxY8HjVBc5RzxNtjSAxii5ESe78bmwN4yKOtof+k2hn5I/flAOv3GWP
         jdjw==
X-Gm-Message-State: AOJu0YwfNwyssh8EMbiOb1MFXaSBhLq/fQGI6ouM6gQVmTfBaQ356NhS
	5XxFev88GfcIkuG8e5cbG/MQtUvSLMd22w==
X-Google-Smtp-Source: AGHT+IG+MdvAkbNYUXMrY+Ex/TfjFJSwXDbSpWCZpzIXMEpnK2Ai7ihhFdQ35uuh+PBi/Ud8dCq35Q==
X-Received: by 2002:a05:6a20:160c:b0:195:edf4:9e8f with SMTP id l12-20020a056a20160c00b00195edf49e8fmr674581pzj.66.1703644232903;
        Tue, 26 Dec 2023 18:30:32 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001d4752f540esm1744485plk.198.2023.12.26.18.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 18:30:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A304610205C65; Wed, 27 Dec 2023 09:30:29 +0700 (WIB)
Date: Wed, 27 Dec 2023 09:30:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>,
	harry.wentland@amd.com, sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com
Cc: Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Removing duplicate copyright text
Message-ID: <ZYuMRZU85plJiVWO@archie.me>
References: <20231226235741.4376-1-marcelomspessoto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZGVgynaKhqIN2HVd"
Content-Disposition: inline
In-Reply-To: <20231226235741.4376-1-marcelomspessoto@gmail.com>


--ZGVgynaKhqIN2HVd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 08:57:41PM -0300, Marcelo Mendes Spessoto Junior wr=
ote:
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
>=20
> The file display/modules/inc/mod_freesync.h has two identical AMD
> Copyright texts. This simple patch aims to remove the duplicate one.

Hi Marcelo,

The patch subject should have a subsystem prefix (e.g. the full subject
should have been "[PATCH] drm/amdgpu: mod_freesync: Remove duplicate
copyright boilerplate").

For patch description, I'd like to write it as "mod_freesync header file
has duplicated copyright boilerplate. Drop the duplicate". And make
sure that your Signed-off-by: trailer is on the bottom of description,
before triple dashes (`git commit -s` does it for you).

>=20
> ---
>  .../amd/display/modules/inc/mod_freesync.h    | 28 -------------------
>  1 file changed, 28 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/dri=
vers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index afe1f6cce..cc3dc9b58 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -1,31 +1,3 @@
> -/*
> - * Copyright 2016 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining=
 a
> - * copy of this software and associated documentation files (the "Softwa=
re"),
> - * to deal in the Software without restriction, including without limita=
tion
> - * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be includ=
ed in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Authors: AMD
> - *
> - */
> -
> -
> -
> -
>  /*
>   * Copyright 2016 Advanced Micro Devices, Inc.
>   *

The diff itself LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ZGVgynaKhqIN2HVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYuMQgAKCRD2uYlJVVFO
o0qFAP48gatzxW12gHZZvhcbCTjbLWlzeSScerZ+QyttfS1K4QEAxEaqJj86R9nS
X7dnpFXXjKu+pZ+rN8LzhrBwEQgndQk=
=xonQ
-----END PGP SIGNATURE-----

--ZGVgynaKhqIN2HVd--

