Return-Path: <linux-kernel+bounces-122774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A378188FD10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C831F283CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1F7D07D;
	Thu, 28 Mar 2024 10:30:25 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423274A18;
	Thu, 28 Mar 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621825; cv=none; b=SsijwSsfNdIMpFJrlxDo1LU0zQyDP586IhMf6e6P1C2OiG5InYzHB4EwcFRT0trBcmSjH+1vg6JhasYsSK/KWepbUCe/SXl0pF24PYT0jh290NKe9MDLhogS6ymUEvnR/cuBXPBiYY4r5f/9S2Sz33zZyV2RqYnlprTqPM/VB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621825; c=relaxed/simple;
	bh=JR9iqgTeubnrq/uVPcMjl9IKr5EmGLhVBGHkhPwE0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZrfdhs61GXjc0wzqbTAEoIor0Or2A19f70gK61KCvRglAoY6RFuLzxPlnIwjekM4kdn6bUsMdrd92ORQriJkWAiaSgliJ1wY1WV0kb7kz3PV9LmBeaHfBwSSgpgcrXLPyXbd4TnuKWkWDzaOSTJO6AtJ8qCSDQaCMdQlJIyySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 853451C007E; Thu, 28 Mar 2024 11:30:21 +0100 (CET)
Date: Thu, 28 Mar 2024 11:30:21 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tavian Barnes <tavianator@tavianator.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.1 018/451] nfsd: Fix creation time serialization order
Message-ID: <ZgVGvd3A/nqycSbX@duo.ucw.cz>
References: <20240324231207.1351418-1-sashal@kernel.org>
 <20240324231207.1351418-19-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1zfRCI3yqJQlBjBy"
Content-Disposition: inline
In-Reply-To: <20240324231207.1351418-19-sashal@kernel.org>


--1zfRCI3yqJQlBjBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun 2024-03-24 19:04:54, Sasha Levin wrote:
> From: Tavian Barnes <tavianator@tavianator.com>
>=20
> In nfsd4_encode_fattr(), TIME_CREATE was being written out after all
> other times.  However, they should be written out in an order that
> matches the bit flags in bmval1, which in this case are

This misses upstream marking, probably should be:

commit d7dbed457c2ef83709a2a2723a2d58de43623449
Author: Tavian Barnes <tavianator@tavianator.com>
Date:   Fri Jun 23 17:09:06 2023 -0400

    nfsd: Fix creation time serialization order

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1zfRCI3yqJQlBjBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZgVGvQAKCRAw5/Bqldv6
8nLJAJ9kuw1vzUkXQRmIUPbwTtO1hMOuKwCeMhyCOLAn1EJJrG+Qyj6kFp8h2nc=
=lfLG
-----END PGP SIGNATURE-----

--1zfRCI3yqJQlBjBy--

