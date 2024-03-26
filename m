Return-Path: <linux-kernel+bounces-118278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49AE88B730
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22631C338AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779DB4E1CC;
	Tue, 26 Mar 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPeORWmc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BD71CAA5;
	Tue, 26 Mar 2024 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418955; cv=none; b=TwLONcN/EvsNihlZ0Z3/egT7zQkL8XygscY7T6dGX5HJXE1hAixMJeIwrpBuFxjbBzhLFqRpDcPWrVvRIvmvIXwn108dTNezcieotBA7n8mDN3Aqo+uUpMgripHuEQrl2Ow3Nk38JnrnsJ0QW+MvTuOj4hhw09oJ2MJCr/wJBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418955; c=relaxed/simple;
	bh=bEf0WUnJbqlmVNqarioLAax5bxE8sZZnJg1j9i2kLvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWSylRqiBzHHToGTSAEmUHzkpmE0JYX7w8HXFgivBUEdSRCpCgMcGxSQwPbH1wQpYWUR+smihAaHr8g0phTzb367/JTNfkhz7tRkaAY0EUx1tyGXTCk8CWDx/Jj3/t9jYfSfv1vb+SQeDtfmL2atTQoK3e7uTGbGul6bJF5y3Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPeORWmc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso31367315ad.2;
        Mon, 25 Mar 2024 19:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711418954; x=1712023754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73eQR7CGAkz95d7GXos8MkovGVByD2X2H2r6s8fqSg8=;
        b=BPeORWmcrflkY1Kq/NmOTaXj3SkBueTEEB/kojoXKKTJqlpm041xpQjY8h1rhgqZHo
         W5cOSW8qs8I1IGGAdLpBqU8WdRSw/j0E3xf/OcniTomrmvcK1yjv4dOfZ2Z5nyss0mph
         5XBsB9Qfya6eKycQfsgVIMD2uB7D9pJQ+66URpjFhC3zu4t3tN+V1g8j93oBFO2OGThb
         EvHVc1tByrKCTXNLjOGqXus8RRmTm7hsXfxzIaaMot0cTOZ/yK3QYu1tOoF6OCoi8uod
         mHv1+swMEVRTDxeqAZe80s+TnXTXFTzllSvb3t8ZnmE+Z73RcZ9xRTtq6aqIWKHmnnCX
         BD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711418954; x=1712023754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73eQR7CGAkz95d7GXos8MkovGVByD2X2H2r6s8fqSg8=;
        b=bpQnu81HomDgq4PiO5ZrFpu0+dGNZPbNe1uUJSvJ8/wZtyFFrNS091IJ1p7sd0YyZ8
         h3BUdCjoVgrFFKmiK9PrgYL04LX5aa4vFxxTfSoZNS62PFIYbrXbcieTBSqm6ZNi2vtN
         gwzpg0anfFIk8r9MuX4fy1TRHWPPUrhcoHKijeP9weuuU9uT24uEVmNGsd9b68yJR+M0
         iPJiN+gKxu+tEsOviVrmDS733O3IyC5NtqhBBXz0D3+lgYxqaoImN1aTnFYy0sDsjjpq
         /6gLfElWsJbV8LRzFIIFidXJevhvBXS28qZVWpOqccGh0H0tgVr1494Xj83BZIx/dgH/
         lOMA==
X-Forwarded-Encrypted: i=1; AJvYcCX0JwqL59q6By+iH5bNMt0uxlheGyCNrKmNdumzTUexqQT/8v6Ak6uhsVYV36pJexBYtZaTOVWJ4sJskeyqkc6C2QbcbxhsbLtBdpNK0LxxUfegmtG3iW5EnZBAyp9t5XVXSMfu
X-Gm-Message-State: AOJu0YzTkUWKe7AapqfJJBNtiR3NcPQpGva7bDN3iQiykfwe3jLxH1er
	rbzcUc2bJdKd0xM6fNtBtqSKK0UOoUaw9swvf6zLr03zu2cIlgCs
X-Google-Smtp-Source: AGHT+IF6GXa2VTA1W1YPk3cnu4xdmPVrbcFJi+tCRu4NHMa9iYP+ttbmNglSA9D3f9fMMrQD8FFQSQ==
X-Received: by 2002:a17:903:298c:b0:1e0:8931:d372 with SMTP id lm12-20020a170903298c00b001e08931d372mr10003221plb.23.1711418953480;
        Mon, 25 Mar 2024 19:09:13 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902ed8300b001e00285b727sm5473228plj.294.2024.03.25.19.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:09:12 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6D9901846856B; Tue, 26 Mar 2024 09:09:10 +0700 (WIB)
Date: Tue, 26 Mar 2024 09:09:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
	pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <ZgIuRpP1UgkZQftn@archie.me>
References: <20240325120003.1767691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iPkO6wcSfm1xOeY9"
Content-Disposition: inline
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>


--iPkO6wcSfm1xOeY9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 08:00:03AM -0400, Sasha Levin wrote:
> Sasha Levin (1):
>   Linux 6.7.11-rc2

Hi Sasha,

Commit 506a04d850a45d ("Linux 6.7.11-rc2") bumps EXTRAVERSION to -rc1 inste=
ad
of -rc2 as it should be.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--iPkO6wcSfm1xOeY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZgIuQgAKCRD2uYlJVVFO
o05zAQD5KzpC5v2SHArWZcmbZ/QqSraBJ2hQUaLIOsDxJaaTQQEA2iGgt7eKOu47
O1zAHbEMqWPm9dhdqndG1KC30owdXwc=
=1w9U
-----END PGP SIGNATURE-----

--iPkO6wcSfm1xOeY9--

