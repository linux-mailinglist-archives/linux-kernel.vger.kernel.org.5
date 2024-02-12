Return-Path: <linux-kernel+bounces-61573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 120068513C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB321F21C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FD3A29E;
	Mon, 12 Feb 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMCnaUpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E103A292
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741983; cv=none; b=JS7R4iJXLYywLtXEnP2NAgAYQgwR4MI9YEGjht3Zk/j8LH34byIqoeRim4tjahIAZQgZ4/naNnX4GgVz29VMFmfDmpOQXGTs9EsvaAGmTS/xtCAyhb0QQBIgNk0ZOGGWfVSRYya4mnX9h9HbQ5NPz3wpCm4skdDT4CLra3T+VQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741983; c=relaxed/simple;
	bh=T04eMKlRmhh0N7XBjNQYZVDQetsg6SmMJw4HxdbXeus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7FWdxK2Es9C2NBPE6Fhrk3JnAHGWPzh9BwJtgjjWIYBL5LFoW1BkZvM5cO8ra9M+gA4jhFW7XoeU6wiyt8l4omNOFhKDjhDwYdXl4wKBAwhi9Z/0N1dw3mIslgz+QHE4YitF3kLLGTuWobDGP+An1gjL7HpCMzmYaeLypafcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMCnaUpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41C8C433F1;
	Mon, 12 Feb 2024 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707741982;
	bh=T04eMKlRmhh0N7XBjNQYZVDQetsg6SmMJw4HxdbXeus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMCnaUplbLxYvwaKJZlYICpgEO7jT+wkATFj5qV2jug7YnGu06+3bSUhvn3RGfkHa
	 pbYhbMdl4GyXfXMpb+C/UuLJwUOStz4TD2/pgKWx639zW8ATGBTqPS0c0xsxxBbLdP
	 z4yTlyOKLBKwpU0086yyX69ILC4+Ddeu21+gPj21Haz7tpMxLwR7Uo0Xsh7TqSPm+R
	 Y6YQJ1WcV8YZ7J9Ec8Il9S02Jrn5RULF2Z7U3sQoPpjXWlln8YbgBncX2g2D7X8xn2
	 LimC9mCc9rQOloighvlEfSFlPKvhXaHoqbGRD75umoSRzQ13dvbvhIZbiIYWCYcEUN
	 2aNB4tLCz86HQ==
Date: Mon, 12 Feb 2024 12:46:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Yinchuan Guo <guoych37@mail2.sysu.edu.cn>
Cc: linux-kernel@vger.kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] sound: codecs: fix typo 'reguest' to 'request'
Message-ID: <8ac806cd-cbf3-426f-86b4-280b3b219dc1@sirena.org.uk>
References: <20240212065014.3696356-1-guoych37@mail2.sysu.edu.cn>
 <20240212101820.18437-1-guoych37@mail2.sysu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ptXczeETsw1q7wE5"
Content-Disposition: inline
In-Reply-To: <20240212101820.18437-1-guoych37@mail2.sysu.edu.cn>
X-Cookie: Will stain.


--ptXczeETsw1q7wE5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 06:18:20PM +0800, Yinchuan Guo wrote:
> This patch corrects a common misspelling of "request" as "reguest" found
> in the log messages across various files within sound/soc/codecs.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--ptXczeETsw1q7wE5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXKExkACgkQJNaLcl1U
h9C3nQf9EUFXfoDws1b190kMBs/Z0ap9A88voC/e4V0SNN/CLwha5LBfTZGJOuKb
rBAQ2hZziz/p4uFawh++cjKjDT621x+/RMibXRmF74AXU1Xz8JrN3gihhD6Qhlqh
AIU/TU+jwASDEdvJat7kqvjgOsJo11tnOXj7MVVOlolXVYTzpOJzknhyjxEldvdF
wMgx9h+pGoa+R/EnkkXSDWGBV3ASuesRIfMy/RQgBhyjDN8G6WqPwJDyW8Id5rGL
1SbPXWfQVzlrLDHIU+ysdRgu0WeMED8uG9xM8QBoXDYscSIu5wcqFaCPfeDgcRR6
HKF7TSMBmXxiR68Vz8u8qKr93OBK5g==
=HAkn
-----END PGP SIGNATURE-----

--ptXczeETsw1q7wE5--

