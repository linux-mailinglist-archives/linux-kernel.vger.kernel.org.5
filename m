Return-Path: <linux-kernel+bounces-78908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58197861A79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10ED288E00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C0D14CAD5;
	Fri, 23 Feb 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2DiHODe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468314CAC6;
	Fri, 23 Feb 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710199; cv=none; b=bWVh2iz3cdAd1hOa+XKWU5KVCB7toCReQLFikXomdgkR7LPWVI6E5bbiCpsBgggWivQ6cnSU96H2xPk1udCzIM0xahoTEX6KOx2AWILSVUa3EL/Br8oj2OY+H/+lNT5jNkROCPDuWhqbuJkzE8PL0p28NwF6JM37sVRR/VyAFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710199; c=relaxed/simple;
	bh=h0Z6febrHHLV18pVzOViZljOJbK5UtwzTaH1fctKaJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTioDZt3cdDQ9wblaFfytJ2Re3LeFz8fVyzGqeBqXLqQMIxrLxMJ+j5zNZR9JIsSovFNxyGkCuGZaJqKSrZAtFdhGd9kaqRE8hTFdge0v5XSGljrhCuTf4Oj5AHobjxVc1AtZ8Hg/l6EZvbMEKuy+1gU/Kij4qmOVanxO5gs1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2DiHODe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0130AC433C7;
	Fri, 23 Feb 2024 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708710199;
	bh=h0Z6febrHHLV18pVzOViZljOJbK5UtwzTaH1fctKaJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2DiHODe4yWCvhz6ISI0S5PdnMER7aKAtq/IhRypfHKMcyRzzcBciIyH4OOZ7bkKp
	 lqKo1rjk9vxhrP89HRF8wEU9BCEy6TKZ/rMf/UpSeIBbCHDqTpO3ZIyxiWO+W7iWYH
	 JZ92LpswcV81kmCbWb+zneIFpiP7RMLCnU6kJh1rJcPebc6fT9xmxN7qkHtk/ddR+3
	 dUjFFlW2z2t6A/QZFg0FZ9n/8dHROZRzqmj5DFFT/DdWP5lZVJftnzZCKKqiv0ju0R
	 phxvZzUQc0gxPspWdOXK+4I2AmZb48g6BBEPHB2VAgkq3eDf6BY828HFv2MZ3anQ+3
	 WJGVkKaKs88gQ==
Date: Fri, 23 Feb 2024 17:43:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
Message-ID: <20240223-conceded-ungraded-3bf06dcac60b@spud>
References: <20240221130223.073542172@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N8inhLCaiHO09vQN"
Content-Disposition: inline
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>


--N8inhLCaiHO09vQN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2024 at 02:03:19PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I know I am late, the perils of being sick alongside manual reporting,
but better late than never.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--N8inhLCaiHO09vQN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjZMQAKCRB4tDGHoIJi
0qCHAP9Av/dZq0bSBqxiUuafVJSeiV3qkeWsa4l8qoRKEX75vwEA6u43CalY+eUq
B0WRcDYuTm5F8OVb9kh5SfSHec7k/gg=
=E5Zu
-----END PGP SIGNATURE-----

--N8inhLCaiHO09vQN--

