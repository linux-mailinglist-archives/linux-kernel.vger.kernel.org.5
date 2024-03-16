Return-Path: <linux-kernel+bounces-105023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9187D7BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827F01C21144
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21E74431;
	Sat, 16 Mar 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyOJbXVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7723B1;
	Sat, 16 Mar 2024 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710551474; cv=none; b=g1nOESycgzL4HBGzN9NPQjlUiL3XdoBYYn/8ZaWKDjbaWvLeTqCyx+gT1I4GmgpLf5VE2hZDTuW9b2jl1X9ogzbSJMyk8brMaXqLWMLHjYmJYv85khuYaONgfZ0vquuC8ZhTk+v5zbNFu2AgjTpjQs9/NPIPfCAN1/X69uP+ykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710551474; c=relaxed/simple;
	bh=/2mV4x22F/QVgIh76C3BMbNB2KLcrxBXoWVMuW7h7mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKAsHydytImYg8w0siKNtQkkKoT5EUN4s+utUKuP6IlCLwxzfHY6AGHvjdH7ams6eL4jr5PT5fP2jTH0sgmdXtsQVCWT77aY+tPergy0wov+rwStyVBRnFKsxkFongl8JQzwjrJvGZvix0IHOAbP5R+QYRQ5pj8ioQuukk6IFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyOJbXVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F49CC43390;
	Sat, 16 Mar 2024 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710551474;
	bh=/2mV4x22F/QVgIh76C3BMbNB2KLcrxBXoWVMuW7h7mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VyOJbXVj8BQowIBfk7EMLO87izqo47PBgcN7S2u76zsD+gwyLmpIOEQHH8p/LCtub
	 w4mS7gFbhyVIJEh+i4eV2kqfFm93ipbOPmzBqCNjDCWFw9GES06tF4HrO6lkOgwcDz
	 OJiCDHJEoD0U/No4D1VlSZ7y4bf2/Hj9YjgDYAlTWsTlMvlcWba/H4hNGDeAW67FYR
	 7IaufWPMPM6gdP2flaw3iSA9sx5xvRTxaawqXWoENgXVvYis3gnB5wObVV5J/QqLHH
	 2ISa5M0hntATc02lNQ+05IjfhOX/9HJ1x0vz3NT/nkUuR41WKCKGqsRUeR3m6uqxhu
	 UdWcb+baTEpbw==
Date: Sat, 16 Mar 2024 01:11:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
Message-ID: <81c2c997-52f8-48a6-ace5-1bf503462f25@sirena.org.uk>
References: <20240316005917.20526-1-justin.swartz@risingedge.co.za>
 <182aa3a1fcd05a2e25b55442f58ced5b@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0+AF4gs/20AJKM5f"
Content-Disposition: inline
In-Reply-To: <182aa3a1fcd05a2e25b55442f58ced5b@risingedge.co.za>
X-Cookie: A well-known friend is a treasure.


--0+AF4gs/20AJKM5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 16, 2024 at 03:01:02AM +0200, Justin Swartz wrote:

> Please ignore this patch. It was accidentally sent without
> "v2" nor --in-reply-to=...

The --in-reply-to should be avoided:

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--0+AF4gs/20AJKM5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX08awACgkQJNaLcl1U
h9CI0wf7BetQ9uuB98Mxk6JweW8nndlgvuseO/vOtdWIr+mUTeIaAAVdgh4NgVs/
sDcjKdJAs3FFmRqfXcaS7DT2Ycg8S+NPw1NBJ9fEpPcirFUwP5kao4QZXziSBEdv
nvhZKZWWjWN9Y3iJF0zBDrd6V36xOaZdl3eOXRwgFKOOOpffVeb1sHVDHs2832jw
CNvukno+dvaW5q9zNfp6l+oLPsPgzuhZnDfcytvdpm2SqGw2ACqK2w+eFfKyOJfu
e8T+wKmdM84+PKWu/Fxp4IEj21RBxCb+AF4HJqeLYek7KkBAjg4ibhDwBBHSExpf
VjbAOlXUKXULbiOShjlGEWrigaeQ+A==
=0jKr
-----END PGP SIGNATURE-----

--0+AF4gs/20AJKM5f--

