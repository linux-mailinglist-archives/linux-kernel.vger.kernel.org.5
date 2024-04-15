Return-Path: <linux-kernel+bounces-144991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F38A4DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F3C1F22EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C65FDA5;
	Mon, 15 Apr 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLRtvHHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADC5D471;
	Mon, 15 Apr 2024 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180852; cv=none; b=hHNFsiJdhy18uAbGhAO7rmjN5/IuCSvA9grlCn1zQwwwG51I4u/RmbtzwzekIoTJggbz1Am66AzMnRWaY6tOL5HS49MXIQpTP/j+qio+n7xCatCnwX9U0T28vlgO6R+p5PSEYWoLSqGwQWNb+J7To1oMF3a9yfbvSJx9dQO5LRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180852; c=relaxed/simple;
	bh=oycB9jVK6ip6bCA4Sd9xG74IVTqjPYQ5vyKfl8Zcb0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIEjiPvcuDWnp3n8+/kOI+0VdjhtfCocRzdqMCkXT4xMvBmF16EpEGbtuPHGCcRlvcro/98lTePnjXrQ9lp+zvV+rUkJ1gmjADjM8Il5jzunSWpl/NrlpqBm25jJtBfZJYKPJw7D1Pmn/DHPqVvVSoVYby9D6eyCB8rTllD/cFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLRtvHHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD21FC113CC;
	Mon, 15 Apr 2024 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713180852;
	bh=oycB9jVK6ip6bCA4Sd9xG74IVTqjPYQ5vyKfl8Zcb0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLRtvHHasimQPboHjCm1YlNvCKY3nYOhMISk8CX1qpFl8fF4vpi92qdMLz49DNMCX
	 nHycHCqZh8BRMw/Y56AGbN7aVgDFH6OuN7SBZ4FbmVDiQp4OFjU3hJf0ntpb3saYpu
	 MJ3JzMZcLQ4Og4NhYR3Pz1VJ1OFdZWvZhUnhjyGcJ1khHzD1OzmZgCDNOeGDF5171K
	 3ux5jx0shSBODXRjhd2q1/XwcBSetNs+ZiBAy2BY/kdbhm9XGZ4QRjvLMTKfZt+k20
	 ldtvFur0rdY5xqmAHo9ovMmrHvsarY7tJ29xGyUpxpJDM1JeAmU/zisfTbwREraEQ8
	 Cb0XDL4Tpg+4g==
Received: by mercury (Postfix, from userid 1000)
	id AB9D6106071D; Mon, 15 Apr 2024 13:34:09 +0200 (CEST)
Date: Mon, 15 Apr 2024 13:34:09 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the battery-fixes tree
Message-ID: <rpzxcmnsbrnclkxbcwvw26hclysaes5ldfe3h36vjmdqd4llce@yi2kgzyml6ga>
References: <20240415080406.51d34d53@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="roull5pmgfldsfla"
Content-Disposition: inline
In-Reply-To: <20240415080406.51d34d53@canb.auug.org.au>


--roull5pmgfldsfla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 15, 2024 at 08:04:06AM +1000, Stephen Rothwell wrote:
> Commit
>=20
>   bcbdcffd94ce ("power: supply: mt6360_charger: Fix of_match for usb-otg-=
vbus regulator")
>=20
> is missing a Signed-off-by from its committer.

Thanks, fixed.

-- Sebastian

--roull5pmgfldsfla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYdEKIACgkQ2O7X88g7
+pqyXQ/9EhJAbp2UtiD1FxXZbOOSiZxwTw6x03kE2vpCpC3sk3NZCh6kgtLThp/v
wC5Z3aLvm/tW0NPOSBklteECdmLxlS6EwYJhOuxSWyB4rB4h+ZB84DOyES3s4ZYC
3iLFnidQFUoaD/tyiQkeCvwyjelGN+he3DdWvDZ+fVPNR/Ej5zjUTcOVieXjNLfO
7cIMq0mbsNQAH5HwJ3gSmkfTBJ3ygx1uPC8oBJSdeYRhGzrb1AIah12Z+L05mfBE
D1IZGoJvFQpGME+UV4i+z9Cx8xS8gDHTFn3qSU7XZud8KJdXpP43897yCJPviI4d
/jR1gdMGA83kY+g3fNX4toBVqaSLvZyTwqDPhKzMx20ZmZWlWPfe9874vyjZyijt
HLHvNAxs7aJlx1qWY09C6BGW1LtqVsdx4MSsdz3esS86vTR9b8BvxEY6mXiJq5Jt
oDdXzq/6OQGEygSN5yCzPUNaDSZrsR311p2zRUgti2LQ+onyxGyUX1fCAm5pkfp+
pG+IZI0zEgoTPfg17M20fct5rAuoJbd72D2ITVbdvo6SfvP8B8G0el3PCSFnwIHC
Zd5BhYz6dilwcwMt6kZQjOgJ72yu7WogE9pQwxZYASAJniIm0HLUSIAyjqef3hrS
T1owAAG8JnbhFW8kpIk7NSdeCvhVb1Cdwy22bKVxCA5sn9SF6OI=
=LX8V
-----END PGP SIGNATURE-----

--roull5pmgfldsfla--

