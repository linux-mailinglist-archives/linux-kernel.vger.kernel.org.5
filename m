Return-Path: <linux-kernel+bounces-91659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D63F8714C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22001F2164E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE913EA97;
	Tue,  5 Mar 2024 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkGPjE5L"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5276729A2;
	Tue,  5 Mar 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613127; cv=none; b=VSxFa6Tqe/F4R2TJ8qCHnlXk6dxG4HbZ1yOHuQ+VK1ZJlb64JWoHvCeXi7VqzgAK1mBZgVudZxc6bLXnmJXOSWyXh/7TfDJXSrxh/FE7AV2Ay1APAKRGuEWrc+vRPI3MvRf1N3NDtAmB5uCnW8UhTN0QEyZMES/nT11Lz2P0ecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613127; c=relaxed/simple;
	bh=SSauG8f7miAub2NYhDAYyCaW33Q/IdRj5+nLht4jlvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itlf+CzXXXiV6ReBh5rkQ32cjOn1e6PBUM+aNBRa4S2CL+guSwV8VahXHAe2XCGIT85PFx6lonXtWfqXMe/6G0dUzEMT9MXYCKuOo88KIYaeDShZAVYrTZFe/mujpO0VVIpJprTaw0NwV2tfCjT5sOhMooyuFIdihJ8+yylOjRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkGPjE5L; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e57ab846a1so3306031b3a.3;
        Mon, 04 Mar 2024 20:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709613126; x=1710217926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUsIcCqc0n65+aOxiM0hSyFnKyfuIyZZToEWRW7EiWM=;
        b=HkGPjE5LXNjX9NkPUWNJbnB+jGsyUydIg14Km40YBUIlzAm87AgHzkmEVFIpLEuIvN
         lAnBxPo5lVe8LR5KZiQFE9aYbXS9ov288f9/VPkEOAn8VVOkNTPRzRnTuPOyIVHGI2s+
         VYkSGA3mo5g8R7HgqeylN3+d1iWb89vhY0n2Nu3bqWpdt70iOfywwEqp11tPCvqxIu9M
         aU254dUgNJkaFvN33hV0OE28psUTYkFLK0ILrgySznawdP/5zFq9DoB2kVEgfKHu7vcD
         ZvVo/AFSLxsz4vA4S67/POoVxU6IwBUIwk1vmeOe1hN5IS9v6rZ3N5+kXXnmBcclvqB4
         GNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613126; x=1710217926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUsIcCqc0n65+aOxiM0hSyFnKyfuIyZZToEWRW7EiWM=;
        b=l3o4EYzyhxImr6hIkCDFcX15LRYsNcaXUrlqnuoloccieAvgbeF0cmt6SS8K541jnX
         Mr6r5zjOiSGWeSVlnjMn2ozKjDAHSjHg1xCs2ohcYinipnzS82V3PyUeKM1PnYU46Zeu
         vXWpD5mYgcnaVRNJ8bv9NK/o5uI/avMp7IFfzfLaaY002spSy0uzSNGbKuisqs73wY05
         GNYS73YY3yrrtT8lsj7X7GiU9bbi6g5bWUfiUFQw6icXLCbhHHA8Otw8DjaTLXyLbdy5
         AHSfouFzkIovl9M10fWntv4Y5oXW1MQ44WgYVYVRzl4Hkk2DHC3AT2tMyER0m72QL6XG
         XnhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUadaxL8gKw7vZTSGkzFwMI4vTC7RyYZyFbk4i7wYN0UNCUxoYaJkyW+gqBuV07s07AkKgurmrCKuPA42emqXS82CI6pPxYEomsPLlfwmUm/yednFjMbmov2J3AB3Ax8o1XKC4
X-Gm-Message-State: AOJu0YwAy45gYQeB3POegbAmAxVC5vC0L77cRouWd7NoAUIU+4456wfU
	taEYOCYoISPESJUwbETcc9319/kvkTo7DG7uEBT7SLu+lao9vKtWZEkV2M4anyQ=
X-Google-Smtp-Source: AGHT+IHZ1C96qA12U3lQMwf0gIJuHT1w+JsoMpzvZ2EGHDm0ld2y+Xb2ndKyMn9HP3mN7nicmWTeLg==
X-Received: by 2002:a05:6a00:1ad0:b0:6e5:9a0a:b668 with SMTP id f16-20020a056a001ad000b006e59a0ab668mr9802051pfv.27.1709613125578;
        Mon, 04 Mar 2024 20:32:05 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b006e5dc1b4866sm5202800pfd.144.2024.03.04.20.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:32:04 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 5367918479810; Tue,  5 Mar 2024 11:32:02 +0700 (WIB)
Date: Tue, 5 Mar 2024 11:32:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
Message-ID: <ZeagQq5Lo48TUmCJ@archie.me>
References: <20240304211551.833500257@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o6vkPx93oPOd8dIi"
Content-Disposition: inline
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>


--o6vkPx93oPOd8dIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:21:05PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--o6vkPx93oPOd8dIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZeagPQAKCRD2uYlJVVFO
o88YAQCZD4Jm+zkUub5+BFacdBLmgePDQQZ3Hn7LtSUmRmK2CQD/USt81uh+xzuU
TDBTciGePK0Y34BHO9ZlC9dbjitq/wQ=
=lIRS
-----END PGP SIGNATURE-----

--o6vkPx93oPOd8dIi--

