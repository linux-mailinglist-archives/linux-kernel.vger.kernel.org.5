Return-Path: <linux-kernel+bounces-30825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB338324B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FDA1F2370B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB875256;
	Fri, 19 Jan 2024 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYBgKVVO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976ED186F;
	Fri, 19 Jan 2024 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705646319; cv=none; b=FP9j2BCL+Jlyy2ZRWOlQQ2QHCsAVnbFrwU63/6UumNwTRxftfQhU+lDfBvtzmsHvzlG0R9DVFd40vYweagTXfTxBHvANdn7bJ5aV1uSwKP+M0rCgAinR6zunoxJONiyFC8wnJI/phoTvSmZXcLTgAXtQN9LyBXvvzVWpWSwCNyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705646319; c=relaxed/simple;
	bh=j7SHeHyxzRsXVPHN2nQxvOkMM30oEoiFZsERLqnzMC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqH0nwMmPAkfG9mPj9wPCVFFiGTmgY4gPJ4KsIrVjw4o0yuZV7C4WFS7tHfjvO0gyydMzsxoKYe7D0a6uUU/7Jypruxa9C88fZQZofZ4fVdzLp/SpXbw5S7q8Hu3skPJfFwJilq+YAIpOhwV6yPbUyMGdY7jq9MjTZEczmRKQ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYBgKVVO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6daa822be30so361795b3a.0;
        Thu, 18 Jan 2024 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705646317; x=1706251117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Qe/k8+og9KBjj5t8Na1yVhACJJNYJYcaBiHf/D2Yf4=;
        b=eYBgKVVOE23Apysfuy/mXZt8qSejtP6tCi6bWPtP2tIieKTMtA20dvMucPuDq9ZJCv
         t6jyHf0mHPPLwjC62ptI6deojNAap1rHRKnma4W21oJsDaeNMWfZVJcd7aXGAEQvvH5c
         Cnk1bUbH5f/6uIQRiHAReeQU+R+U5awjQbgzT1Q+h2JzD/zfASAK9RkL3pSiLdjGNbSf
         uKKyfukjidqQVjIGH8Ol2JHUKKphvyjDZ6BvQTYy3H7nILYN/odfFocvExoAwSH7r50l
         l+3Cx98u6ZiGC8rYVifHJG3eDrH22O9u4MaGIP0rLkcdi5NsKIwElDCQJR7/bXgprDYa
         vAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705646317; x=1706251117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qe/k8+og9KBjj5t8Na1yVhACJJNYJYcaBiHf/D2Yf4=;
        b=R37TMZX/yxFNcUgRkRv+Gzf+giD4PvR33aelVFkkzkvonoe5Qu+rb1LyiK9XmNKHj8
         SHFtLsfUuv+pnb9V5Z2KC9NvfH++dUAHivnqkwTf089t1gz7/8q5L3RcEhk2F//OoZ+/
         GAblxaqtXTjaSj7GzT9S1MR0Wyy3sN0d5WUUtMIE4MuRiSGeJIxPPZciJujuXrC3G8aw
         1v4RsZ34LoGvpI+3XLZ8ndzTozhBcMeDu4hrAd/TO9WxWuh+y+iN0URakLBlK0uvYLGc
         4HdjSbpUMo83ZQi0jsqlS7yS/IvrgZc678Elm2jik1ONUzEe5EscF/ltPt3VirHCzDkz
         0vrQ==
X-Gm-Message-State: AOJu0Yw5LP8XjU8t2Bc4ldjQAegF1lCnTIK2C6+G5vf72zh1553Uc1aW
	Fr5hUVL2hx/AUiz8E7Xzmiv/8iQtzGrx6OQkjygg/3jgrLp8+5bY
X-Google-Smtp-Source: AGHT+IH1qY4E7ovyO81RAOnSK2e21BwX85mzcpzM4d6G/8IA158nOsNAYBXc2TuDlCSM5zRU0T9Ltg==
X-Received: by 2002:aa7:9d05:0:b0:6da:3437:f70a with SMTP id k5-20020aa79d05000000b006da3437f70amr1950328pfp.25.1705646316882;
        Thu, 18 Jan 2024 22:38:36 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c2-20020a62e802000000b006da24e7c16dsm4319294pfi.186.2024.01.18.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:38:36 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 06F2E1854A1A0; Fri, 19 Jan 2024 13:38:31 +0700 (WIB)
Date: Fri, 19 Jan 2024 13:38:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
Message-ID: <ZaoY50OP1WG3d1R_@archie.me>
References: <20240118104320.029537060@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zrxoHMcrjZRlqHg7"
Content-Disposition: inline
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>


--zrxoHMcrjZRlqHg7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:47:02AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed the kernel on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--zrxoHMcrjZRlqHg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaoY3wAKCRD2uYlJVVFO
ow4aAQCfiuuNbYW2Qcd5R55SfiZmkisibKOU2oQF7MNL2ha5KAD/Yc3tVRXu3yM/
xpv+7sFkIbAHmcVOljQRwS8Pss4MhgY=
=8hPW
-----END PGP SIGNATURE-----

--zrxoHMcrjZRlqHg7--

