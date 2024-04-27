Return-Path: <linux-kernel+bounces-160992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BF78B458A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373DC1C21143
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8315482C2;
	Sat, 27 Apr 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXbP4+6x"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F1481BD;
	Sat, 27 Apr 2024 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213512; cv=none; b=kbhvtx9DZ7P4HclRdnQoYqgULZmoxKjrJ4SLUP6P7DFlqYwyxwTAMVc3YpYbd7t7she+L78nyA5PArIWJXCmOGKMBNPpgYtpPD8GCF9MJXNZDJo3+76ttJGezWxz4wPzOE1oThpq1IKq+amcP02WPiQdfny25qJGWCvp6KmoRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213512; c=relaxed/simple;
	bh=E6nxNxAubOE05wakCf4v1ZumsoMoA2UmJWIHNfoSllc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVnmD/9fKffqV4T5dL036HhPUjvzkTMAqDK5TVWs0v4ywmg9441Jvj7s1Dm9ghnTZrx+yjdr8tOKyrSfTH0vKIM7ic5ZBtOfJc+YaeiNFC6aUSBKm7fH7H/q1j5y1/t66WErWYGaD+khoj58o/AApyYnqxWeOCyIN2COmadctTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXbP4+6x; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eab16c8d83so23561025ad.3;
        Sat, 27 Apr 2024 03:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714213509; x=1714818309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LUJKteoqdO5SeaZqJ7h1IGkjXYQG9ye3U8EDumHvbUU=;
        b=hXbP4+6xnRUpqphG1c4wciqzLp2whGmbXebHA7oF/pKHKTW/OVaEtQUVWJBuh4OxVv
         fB+t1JaG+5mMMfl955N4a8PAvEpdLwE0TaJloSbS99W6GhpxQK0n71sIAeprKdbJEpSp
         VtvtXqCdJAuGr3K94EswSyBiPCKizQS3i8XmV+vTQmrFbV+dpnZT7/LFiqwBgG3dhNk3
         w3XtZ77MxxmZbSvAs1syN1RP/qNAZmq5Dhy/mm7Wyt3VaSt5J01F13MadYBxHGuA1Fs0
         KgDUjOc/au5RjB7xgn0HFqyVh8dI1oW0rv50hRCbPnXkDt4mHV7Xq2XfmPYt1peQXfW3
         qkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714213509; x=1714818309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUJKteoqdO5SeaZqJ7h1IGkjXYQG9ye3U8EDumHvbUU=;
        b=T49IUIda43HeiHYIov8VFOM6qc14hrhEvu/INlgq+KtA/z9XkdZd5fnz4jgXEMyqUB
         sPT5Wt9WLueTTYFIxWtJpclEmqs4f9C2UwvzNK7DVP1K+9jkeSNVYoS4sqlIXZsNQvTq
         DFECY6M4E1MMlwLQQz3pABHVQJ1RMfAR4MG8WIYklh24z2sipROxhuzoJwOpE6gEKORu
         Wm8xLmX9/cDBbRqagf9QuFhwkDC2q3vt+n5e616hTQE31zRPY7t+cOr6tsNhAhyqKNcU
         1k+PWy6ewNchVa5C/fo1UHUtLD1RgCwNNUYYDgh1UCr/t1l/o42X35R7IK1U139ucX3m
         oh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp4UxRnSjQgfsTUjZheoHsDVTgN/qAwkgwdNfVyB08jRFv2Gv98ciT2FltS7I5iLLMhFw4DZViUQKvaj+iDvTSB7fViT4YmqquqTgCAK1Z1VNku7NqgZJY4K499LBMRsIqJuVpCaNNu53sx+pD0Rl8cFi6hqSz39kguevvqM9W5yXy
X-Gm-Message-State: AOJu0Yy18UATGIyjS2Xyt2bisA5RbNnmMu8EPUAKgnJTb5ZvnYDajWo2
	iBZZCGtpaqSrzGz+2sBsnk3/RAn898ZOwDSkVvLxcYla3klnxISJkK5b/w==
X-Google-Smtp-Source: AGHT+IHNhgASlzQriqkArHfommJX1rdgRS/zpt5HED9VzsPQ9Sx3R/YbIq8Peic1KbwOOc8vorCNcQ==
X-Received: by 2002:a17:902:aa84:b0:1e0:b87f:beb4 with SMTP id d4-20020a170902aa8400b001e0b87fbeb4mr4765079plr.30.1714213509107;
        Sat, 27 Apr 2024 03:25:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id kg8-20020a170903060800b001ea699b79cbsm6316530plb.213.2024.04.27.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:25:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 026CC18498712; Sat, 27 Apr 2024 17:25:05 +0700 (WIB)
Date: Sat, 27 Apr 2024 17:25:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Bird, Tim" <Tim.Bird@sony.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux Stable <stable@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>
Subject: Re: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Message-ID: <ZizSgfNRtAjZv4-q@archie.me>
References: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N2Pm/WPT0MeZxS0x"
Content-Disposition: inline
In-Reply-To: <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>


--N2Pm/WPT0MeZxS0x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:18:14PM +0000, Bird, Tim wrote:
> -To sent additional instructions to the stable team, use a shell-style in=
line
> +To send additional instructions to the stable team, use a shell-style in=
line
>  comment:
> =20
>   * To specify any additional patch prerequisites for cherry picking use =
the

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--N2Pm/WPT0MeZxS0x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZizSeQAKCRD2uYlJVVFO
o16hAQC4vFq5JUPRgrcka4ItB6aOJ9kAqfRetDbc1wuJDCLkmAEAp2GOG95bUjr1
lvh8/S7PZiWSH/I5r9yUoey0fCdwWwc=
=w/az
-----END PGP SIGNATURE-----

--N2Pm/WPT0MeZxS0x--

