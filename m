Return-Path: <linux-kernel+bounces-51466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C193D848B95
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004601C21F21
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180AD79D8;
	Sun,  4 Feb 2024 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6jxkDyE"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062657491;
	Sun,  4 Feb 2024 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029495; cv=none; b=AJVbWA0zJJrUeZ85QmSe5J4Ly4f2x1yVBK4SLmjmtBHuVLOahe5cxmiUPPcvS/SnOXxotoF9Y3bzmodBy8Zt6Fbq/O5uIJJXqLJuidTNxr430+TWwIlqOQc+EjAYSKJQW7qpA3yPJRgGorD0RdN1NYbWtnh7Q1UoSpj/KmuZRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029495; c=relaxed/simple;
	bh=TWYStyek2yVFcxjdK1fNZqAcriCNEswKCVwF/MvulMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdVd0MNXwl7yNv9HTtIpG3NQkwXXWxk0ICNX6IjlI2UXBF1toC6ZK1MMZBG9ImDGQ+WHbBP0pgN0gin4dTrv2DWHV3pw96XFgCv1gGlwJs1xg+NmvKQ2bw5ReBHsqU/fE1Tsmr+lKrVBG0TqyD3/8uMejbpg9f+Q7PvmNEnr/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6jxkDyE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d51ba18e1bso31599195ad.0;
        Sat, 03 Feb 2024 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707029493; x=1707634293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=806upVwJJIqrdHZYBEdu7UNncPOKx7M8gRsklLDCWtw=;
        b=j6jxkDyEIac4KBjUrCDP6i4CAziYLHfUw/vIMSm6YZxaRa5rDei4ls74DRIN5pE6Md
         Wc/wfU06LUiFFS32IauSaBSxMtoNVjVp6oz1e27DJX5uH/n4MxrUjTvgGCNaa27284iT
         156o0E8ECtGwliqdGdMtfFsOHJei8O1OZ47w7NTxxsm5yyNxomyg6UuL+A5W25amQf6b
         6E0t+cOYHT7kwrK3tAXH2qTmWHU6Kv8F8tVOzI2TSBOIPV0lGMIHanFaEXxMSDZgBpA2
         dJtOIUk12zgnebQKn68/CBLaf7evwZkytBMq2CUjMSsPlpk1qXA7XdLDGp93IgMzsu5V
         xsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707029493; x=1707634293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=806upVwJJIqrdHZYBEdu7UNncPOKx7M8gRsklLDCWtw=;
        b=wVNoMl7K46i+nV52rVaPnDGLilqGy03fJw2m+tp+OTy2FgrEXcSFzzpGMlNMfD1WkM
         TkQiCL3QaR4SLHgjG2f5f7dDDChrTEkPcP3k8N3SP1vyRCdCEGqZtz4euv9HMi54vy1d
         B9XrdVM6wWeOoEQY+ApghfEhFbMgD24wQf1MmTa5c9HAuL0WLiIZI5heBY/4ICLeO/5R
         qWT6GT5QsjshHKKkjkd4Is/VHskyXmpd4Rr6lyCm3n/fTnSz0VIJLDPQl4q2y/dn/6zf
         j3syFUJR4WQT9Bw+CUmOtOWRRA3kaZHCZVdXk4jKAzJl/cKYBlA9QxqGb6Zwx1bR1PTp
         KRyQ==
X-Gm-Message-State: AOJu0YwDGzrkO34rNClt96SPLJO0cU/A9uUla2XOYlaH73CqIW5R+Chh
	LlgxvRFFSZ1U1CQyq696xucIlQrsNYZMwh9cLNsklkHE4CLArwgB
X-Google-Smtp-Source: AGHT+IGk/vsXMjb+tMFduJVmtfptw5PVcP57IfsIzRz+/YTnLvCX0NAD1/hLjsceQNZjqKmRTY9lkQ==
X-Received: by 2002:a17:903:1cf:b0:1d9:8b4f:909e with SMTP id e15-20020a17090301cf00b001d98b4f909emr4233496plh.35.1707029493167;
        Sat, 03 Feb 2024 22:51:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUPUiSTLGMAbftianwgz4yYTknTZoq4FcECIUAbj0CjVv+k6+ciAQmNSPsrorUm+hDz5JkfOzYZ/wDPDhAYo9q3SPdNdh40QWKaIz0cmN3Bw2bllRKFbNYLa33QLJcJL89KyxQeqaHCc7fjVfeMa+Qfh8/OKzAtbTr4PrTOkz3fpSLHZcStMhROybWPe3qMU/ivVz+PXg248OKIXqDqJ2DKjZQTwiCsf/ICidO+LVAQVaN5swcAD84d3hyX88qTMQB2BYikZZ5oBI4F782XjUiftUzm07wiNZ9EahcZQ/Xa8RCynKHgSd/V6vk2uoPHz+FbhjwJzVgq4nkU8SUOLQLUpw0coNpbe5TRLf56TYBPz/acuT8L/JIbx5ezQ/obtaoONxddIPkuiHHIVmjMCb+GpD2kPIlXEwyBbKDAw7oHvPquMvqh++jgSJo65HKbyDKXlKmxiBH/S9tDCmvX9pCOlGrxu9bwyNFbKUWA6/OiJ1wXyOqc+FNDpuahx6VR/ubibe/NpJaTPZNvGy4eR6/EavX7iUsJO7LtMtvYjA==
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b001d8ffe741basm4125133plw.36.2024.02.03.22.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 22:51:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5D5441846855D; Sun,  4 Feb 2024 13:51:28 +0700 (WIB)
Date: Sun, 4 Feb 2024 13:51:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <Zb8z8OBV0CI8ZSVB@archie.me>
References: <20240203174810.768708706@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YW6O7mIOwnm0dUVX"
Content-Disposition: inline
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>


--YW6O7mIOwnm0dUVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 09:52:59AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--YW6O7mIOwnm0dUVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZb8z6gAKCRD2uYlJVVFO
ozUlAPwNme3FmvCgq4hk0g36NC3AOYHMFgFALcsVW5ExqnvHpQEA2UJJpwWlDJk1
VuPdN08hMaqU15neYQjlKPujZshscQk=
=DtpE
-----END PGP SIGNATURE-----

--YW6O7mIOwnm0dUVX--

