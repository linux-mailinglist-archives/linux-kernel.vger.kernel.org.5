Return-Path: <linux-kernel+bounces-118346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7509788B8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C71D2E6F95
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F75129A8E;
	Tue, 26 Mar 2024 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9KkelDY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01ED21353;
	Tue, 26 Mar 2024 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424746; cv=none; b=RRc2crBi9M3SjId179Z4/FHpkJYXiYeC4VVwgdmsYiQiYzMcKfm56m/Fv/TusOFC3m0yInUnlMzCuNUwWA8NOGNJ6jCx8QNV2OlbhdHC6quC5D0ixAkus7e9pNZV483BkY2LVyYPnM7z6KjLr8L/mCHsgy+9Vw7/RtOlePjsd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424746; c=relaxed/simple;
	bh=ksIDaTJR1kBwQLBHuVqFIn/ic3OHvFLmAdKuJ79h8sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDOZs6Y3DPF46B6wI1ZdfDytUbweNCKpvwBzQrO1wFb6uPgPKFkFfYx06h7nl+DLkUPFmE436y47uOZvSJWKUv0/9IVfhzV0ta95/wCJ+7lLqpJ4oGvqAFYWdm3mYIyaI4bql2zdXHx60qrDYTfT255hjfGmHCP393rQY2DzcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9KkelDY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e7425a6714so3218536b3a.0;
        Mon, 25 Mar 2024 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711424744; x=1712029544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1fYlZ/3hmBw4nvXtVpF10RkhB88OJ8ZZm7dAmINvHA=;
        b=X9KkelDYu93b/2AJqB2JVVuHEvPuxKWMAJ0sXBVXlb+5FhSC3La9Minu5/zyFFV4Ku
         nhkoFbpSgVIgoJR1c1AZoBg6DD5n2L9Te1sGUNdeVORiXOAm1bQ+xVBLWbJSN768NHti
         Mp74p0yAh0/J9vJaVsqwTuU9xS6VPNnVbaAUMIp8RZ1VVqasLV3+A1x1uzQNlWCnLoxj
         jdSObubcbTtCGK/hhc8rrhGiqEPZ5SwBp1Jbxa+axXzNJbjSxKciv3Tur6qYseR1nh5Y
         90yJjKOE0ByKG+k6hILChZKF0a1/RrA2WFf+Sz6zUqpf6GWxcBI8HOdCAAa3hArrEM8u
         HG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711424744; x=1712029544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1fYlZ/3hmBw4nvXtVpF10RkhB88OJ8ZZm7dAmINvHA=;
        b=j6Ralym2Q0FsEHQT3gJTjMzTFRIYad7qQUpy/npQePMXonV6KuCph+R+r92z/WhduD
         8qqhsWZ0C/7uuyIn4kcybf6T5Dq+buzbm92tzlMjeRv7MwzORjtu/NFkKCPGUMmTfP1l
         oKlcof9Zfaf3SeUl5MEVWpcLFCwlyuWfy9GUPdFF9inH4IssjYmRs72YqlGgOHV1xR9Q
         rpC0UTUs7esyEiH5i7UNWh3rkdxhOgE6+O4oehdCNQm6CVZmLbm7kLdQTKbNQh46GS7e
         1c53Ub6e+wBQpJulEDJanwd8+sycsu9+55DJNgCUmvQMoWMkuofuyNet3YkjhP4RIQQR
         4L3g==
X-Forwarded-Encrypted: i=1; AJvYcCXCzOutLOsomTZQsQSB1qO1cV1oP3HeRkSgvzBGCvLDC2wOQaiPeVI75Wi4YV+aZW/E9eJzqfKrWMJHy0Lj2SrkRd80mZfw0cbWntcPijSaMgXtMIilEPN7ZmvYy3YM5w9YZzAy
X-Gm-Message-State: AOJu0YwO/hxS1zyRvUVQGdfIQKmn+o0vCtdEGp0gsYrZiem++0udwDP+
	WRzTEKmyvi+gMpkynKP34XcR2YGFi/Udt1QZtBHY4wY/eGvlHlgC
X-Google-Smtp-Source: AGHT+IGec8796eKwoF9eBcusOEaR8GvWhrQZYO7m3ZkpbCHdsjlERpG06NfhRw+ovQWYeRzn/qZdvw==
X-Received: by 2002:aa7:888f:0:b0:6e6:8ca5:c0d4 with SMTP id z15-20020aa7888f000000b006e68ca5c0d4mr9578557pfe.12.1711424744005;
        Mon, 25 Mar 2024 20:45:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id z7-20020a634c07000000b005f05c9ee8d3sm2190528pga.93.2024.03.25.20.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 20:45:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BC09F18462B10; Tue, 26 Mar 2024 10:45:39 +0700 (WIB)
Date: Tue, 26 Mar 2024 10:45:39 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
Message-ID: <ZgJE4_YCcav6jO2V@archie.me>
References: <20240325120018.1768449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P6JA4jGNmeSeElZB"
Content-Disposition: inline
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>


--P6JA4jGNmeSeElZB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:00:18AM -0400, Sasha Levin wrote:
>=20
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--P6JA4jGNmeSeElZB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgJE3wAKCRD2uYlJVVFO
oyexAQCT3iD4Rf32yvaBFFY6sxPnZpmsSUL48HkEyamg5KgrTAEAzuKnjLpXBIBH
TwkDqEac2sk5mPOg6OMAvUXlqpMLqQI=
=B6Lt
-----END PGP SIGNATURE-----

--P6JA4jGNmeSeElZB--

