Return-Path: <linux-kernel+bounces-164870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB28B843B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D491F23949
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144812E4D;
	Wed,  1 May 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdxV+vmO"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F30EAF1;
	Wed,  1 May 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529566; cv=none; b=ViscAgbKXcRoCQ8yRYa1NPzx1XS2TX+h1hqrqrUCO07wv/BYOpP1CBP++Y1E6q91E657qoVepbk5SQIDpdPVOCp+nLkil23N+4GpagVXTGVZCoDVrPagZCSdvHTs1cI3P1rZZFrhP5cKHVjF8Q/KruSEpLJG2CslQB01uPxoTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529566; c=relaxed/simple;
	bh=3BgS9/AJBLqIe6NZ23UzhVBM7IJQLJanQj1HJ7kcSj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPW1f05ieu4XGSYiqHl5eLd9KDPuuXEbcnnChferuoxzFLD8EflSS29ANSLy3vLrHqaX21oy4UxaHmEEv+X3I4fFM+x2TB4Z9Pt/RCLqT7p25x2tvCvOnz+hFob0sJtpGXWy5GGlXwE48gYCxH5eqMFAsgcearcx5HaQBGwTpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdxV+vmO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e86d56b3bcso58728875ad.1;
        Tue, 30 Apr 2024 19:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714529565; x=1715134365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RLvimjdrO9Jqv7W4cDqyYmgShWy3d76V8PjiL+KAV50=;
        b=JdxV+vmOM5ALUzNbhFsVFX896Y/CNG3FTlpoULdG817mO5M7fvfyThTiUcKgWTz01I
         GPPOjy25TsGAscp2Lz7vhMizQ5GVFvIPucFD+1dC3EDjje39X7rBg4374VQE7/hDq8Bc
         wSHZ6S0CUvQlTOLvt61Jj5GcyXZYw3K9gGe+y4/ddzYuN4Bb3nyf2MwitTvfu5YveJLz
         obZiEGXXwj/x+MSe4aBmM4T/qE0oP0XoiaJ5sYe/nJqct3l7GEEAdNE5BOKr6t0CCbp/
         jTHMfgSmxyHj8GLpmqZw4dX43O+yXmx+ndvpNhTgfj6et+V4ixnRiRiiIs27l9XjyCjy
         l8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714529565; x=1715134365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLvimjdrO9Jqv7W4cDqyYmgShWy3d76V8PjiL+KAV50=;
        b=Np1KE8dfjEpS6MS8YrTZdNI6S7SrhBh6QzSaE9XoEBgglUSFXrrdJTw6/G7iRKB/mX
         eYBbik01QhX7So93hABwVcpUl15JMpP/WgLCPOUBQdzjPJ/yaEcOEBGeXdTVh8qqVqar
         uGeqR78mK6y/uxAaOrnlNCBOgcBOkg2WFDH3Qf/cPth3/8nTVhgtN5TJTdileYWQKnGA
         ovonGNMUxtBi6rJ7HREnKaQOMcnRBp0DGI3Xe832iHV0nFfBcziyGIDUCeGvGdRN0Umr
         IVmjLfFVWZa+EWVr93wSHISYa65dz+Tg7HzWHRp8RQDiTLnXvvd6qfK4nWG6IejedHdF
         751w==
X-Forwarded-Encrypted: i=1; AJvYcCW1d+DhDSpyJeXUd9/rgv6kxs6MMtQiGJxNpQug/CDlfmxDKCE6EnjtT7Pq1rU3gtlGLqXqloJlZ824LqRsBrr+v1GoPHN80m6GY3z1CcHPdd26UOzeNmotwis9dcCo7EgiWnH6
X-Gm-Message-State: AOJu0Yzw+/fYKKeOkmvkkEWxp8+gH1CifMxxE+0IH60gRJQWzmZSjxKO
	K5GqcI1ut98XoA39ixtd025ZGvdWmDKKkFDJtxPem6eefs10YLzj
X-Google-Smtp-Source: AGHT+IFU1CNEHqsVmvSlgmR45wcV27Yx06nSSBXJ6JaF28LU8QLf+Y0xNiTeih6ek4z7354TpTJIMg==
X-Received: by 2002:a17:902:ec85:b0:1ea:b125:befa with SMTP id x5-20020a170902ec8500b001eab125befamr1316439plg.55.1714529564636;
        Tue, 30 Apr 2024 19:12:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001e27ad5199csm23050397plb.281.2024.04.30.19.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 19:12:44 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 08E3518462BD2; Wed, 01 May 2024 09:12:41 +0700 (WIB)
Date: Wed, 1 May 2024 09:12:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
Message-ID: <ZjGlGbF325nZTjIe@archie.me>
References: <20240430103103.806426847@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D4r5PoDmW8atS8hS"
Content-Disposition: inline
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>


--D4r5PoDmW8atS8hS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:36:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--D4r5PoDmW8atS8hS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjGlFQAKCRD2uYlJVVFO
o5FqAPoD1n/DIgEveWXfDbsxiyA5LKJGy4n7/x5mvX1m30jTDgEAnWfO5SuWF0cM
qpKAoRkPth+GeeT+JNDRdwJhaXEjHAk=
=F/Lb
-----END PGP SIGNATURE-----

--D4r5PoDmW8atS8hS--

