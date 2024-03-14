Return-Path: <linux-kernel+bounces-102956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D687B90A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E606D1F220A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAD5D47F;
	Thu, 14 Mar 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5zfUZn/"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A1B46A2;
	Thu, 14 Mar 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403345; cv=none; b=WC+Gu6eeeP4bX8dntofDPFAzTfeqaLEl9zehkEmc6g11zv5uFArQnuo+e6zy+ehC/k4bL5ngfiJAQj5lrry9aI8zE4lA1mTOJBA5P10oOlwHnUvRzJn0oUNvxvf/dMpgsrVDk0iLfP8+z3eSY1gN0Wpu2ZZCg3R2SFd75q7t4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403345; c=relaxed/simple;
	bh=lNVDHQX/mIw7AJvUj7+s9s59A1wTshS+MD5h95jyCrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxQPVd60bIr4ULLmh/E9vl7FBNZ6pPT9ZhPyd7IjjYAl0S11G/MsRe2+PJP19AS7M+74fkDebqNztaK6OfhBMkNrz+EDkIi+hcfjALMfCdRFksCV3qrUIY6aY/MMTW1vYXk2ao7rMHnzhCKRL2qgpVx8vESPv+Rjyx6OjlHsHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5zfUZn/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ddcfe064faso5021555ad.3;
        Thu, 14 Mar 2024 01:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710403343; x=1711008143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tUlSH8g9DotuU5hYQgre4apbAxO3FFBLpyKhLOExEA=;
        b=Z5zfUZn/YBRJpq9PLycHH94VW0SRe3EA8ZAgd/YfuvMjcvh6q2OaQPFOzWFUGd/VRY
         MAx/Td4ai49L1hRjF7BZ5PqdoAZag83phrfw8ZpVJsoY90de/3/pd8kVMhXjj6KOyOvs
         8duaFdS6jqohpSbFf0djwu/mmLXfcCY7Wzzbh+1T3QzoqfcymDR1OkNBFAWIfzru0EBx
         JjVhO9Rlf2GqLOX4/Lp4PDrJMZDHa3MjtcTc2qaUZbht6CaKH0+N/5wSrjvJ7mjBw1t1
         5hI0k2TNKqLeHzujaXK5SyNUfAiFMyqApo5BYGxNKdDIJDJN5TAYDd4HjL2HI3eVzKUB
         mPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403343; x=1711008143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tUlSH8g9DotuU5hYQgre4apbAxO3FFBLpyKhLOExEA=;
        b=iM+4iKcVkBB9wOZ7ev+/8FC4BbSG2bvCrLbDNzwfSRvJnASQRxwZB+n6Mw5WMXtJ2I
         lhqFmrC2JlVuGM8e62C1hHrjU/rAILv2j0TLGlqLi4ePzGs/yJpVmyqeK/BvqWgg2cfN
         E4bKeUwPFKlusyf2+uTxd++rRHaplAXmb1xqUeCMAgOOckcpOAYNe7bWdX0Ntwzz7Xqz
         F4Q5QeiyTmmRcv6oKLOXJOKr7m1lxwm1LlP9quu75fd6dIG2fKBzRxUHeE+U2uipLpW8
         yrbc5j1lHcToFzab3GC29jVM4jgeAkirzarHQmG8BG7BldSHazfdqIi2C6+QfwMObH5m
         hO4A==
X-Forwarded-Encrypted: i=1; AJvYcCVFx++VosDUb5cO6DxVNBNiCloKzcufZdeADxS0osbQXWhZzZPWOyagHRkFLheBO6bz0Vmo8v+33GyEqxkv+i/jiXPDO3YEB/zwKxbKHDPOsFCZ2uxBcngCGLgX5nu4tfE0d717
X-Gm-Message-State: AOJu0YxMFB7nMxSJyKSy0cjv2XyrJcuYNrjwBMegCCIHW92SxOAAwpX2
	wq1Ubss5qIv9lJwc3yavuVi4ShFJOGx9zEf+nKZnawd72b0Nu9xG
X-Google-Smtp-Source: AGHT+IGeF+dZ/qBLzM1FP8R74RfxKh6ua/V/q1nw84IWE/eAXsz+2Wc2maqawHPvmWh3Buv+WJqTJA==
X-Received: by 2002:a17:902:dad1:b0:1dd:6296:1709 with SMTP id q17-20020a170902dad100b001dd62961709mr1193173plx.63.1710403342693;
        Thu, 14 Mar 2024 01:02:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001dd7d66ac95sm1004572plk.78.2024.03.14.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:02:20 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D8C951849F745; Thu, 14 Mar 2024 15:02:17 +0700 (WIB)
Date: Thu, 14 Mar 2024 15:02:17 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 6.6 00/60] 6.6.22-rc1 review
Message-ID: <ZfKvCZe0nPvht8uC@archie.me>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iKDuspMc5Vmr+Gy5"
Content-Disposition: inline
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>


--iKDuspMc5Vmr+Gy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:36:07PM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.6.22 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--iKDuspMc5Vmr+Gy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfKvBQAKCRD2uYlJVVFO
ox/SAQCSm8ejTJ4TdLyM5g8WMrvV63PAacz1f+8TgFEaid2I0wEArUMaAV7qdvoV
Wjc+UW6+XcESNbMH2Vo98EHjtrYoagI=
=NJcJ
-----END PGP SIGNATURE-----

--iKDuspMc5Vmr+Gy5--

