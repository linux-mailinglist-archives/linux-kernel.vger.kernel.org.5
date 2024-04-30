Return-Path: <linux-kernel+bounces-163264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9E8B67F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2924B1F23088
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135EC8DE;
	Tue, 30 Apr 2024 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db6wleuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C7101C4;
	Tue, 30 Apr 2024 02:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443798; cv=none; b=lexcE6nvf5OrlaIxhQGYSsT8T4xcsN0Rqw7YGp/mXmJE1YGqOgrOApdKKi17LSTMaq/V34gE24/5+FbR6IBaYGXQFhlQ4EMu3rbo7NGXxusLGKoSqBxJfeRA8jCcrpp4oc7yO+Ju/81q0MVvMBaqMrFlPK5F29+OlXL8m9v7IbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443798; c=relaxed/simple;
	bh=8t/mXbPLCf67SAZoEUDSVbA3GfmovWe1yCtq7ZTbGeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4E4mjb8kWquTE1gWt0lR3BRpu49F5Utqlu/VDUEi9zy+TYgNxLZfMPREpL4iuFAyKq/rOTF+4wlUIWnTI7kBSQx1J5NyAj5ZsVka1bivMVLq6KjgYjk9Lw53EpDPpaGGa6C1Qh06VXn8dUQewRBOCcYcdj/SmhF7Ht0GZsEryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db6wleuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C20C4AF19;
	Tue, 30 Apr 2024 02:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443797;
	bh=8t/mXbPLCf67SAZoEUDSVbA3GfmovWe1yCtq7ZTbGeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Db6wleuTNzj/3dFgaoOOtW1lZiwGvNthzDetQg0d6ao7cTqF1fL7r1ijETPGxf25U
	 ccFLpO3r0cmBSmwK1TOlRWt7KyQ/I2S7GY+m5M7VgoNLJfbdeM7ENfVIzVovxBuFOp
	 Pznrrq+AwPkIM0veg9gBGR7m96IK87AtM8rJ73kCNfj+raf/IWqjKeT5aEqrQ+Gafu
	 HSZLdjdMWx3QfC+fWBjCb/lVqYEPapgvstXIwizO912XviQ2aqrhBWsBTtSdBmCpef
	 5r3FbW6nneZeOE64J6DSK/piPkr2clNEzZeNHHDW5KiHDUJFbOGXxCMQHt2elm5fkO
	 Q0rdnG8Li+CXg==
Date: Tue, 30 Apr 2024 11:23:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <ZjBWE5XEJjHjftsn@finisterre.sirena.org.uk>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <Zi--4ko_vAtFSxyn@finisterre.sirena.org.uk>
 <20240429192848.13c576b7@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oQZad9ye1MEygLXs"
Content-Disposition: inline
In-Reply-To: <20240429192848.13c576b7@kmaincent-XPS-13-7390>
X-Cookie: lisp, v.:


--oQZad9ye1MEygLXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 07:28:48PM +0200, Kory Maincent wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Apr 26, 2024 at 12:42:53PM +0200, Kory Maincent wrote:

> That's right I was focusing on power where I could use already implemented
> voltage and current callbacks. Would you be interested to a new get_current()
> callback to know the current and allows regulator to deduce the consumed power
> or should it be specific to PSE subsystem.

That feels like it belongs in hwmon or possibly power rather than in the
regulator API but it does feel like it's generally useful rather than
PSE specific.

--oQZad9ye1MEygLXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYwVhIACgkQJNaLcl1U
h9BPOwf+P8SpKQiGARD/BM5DUus7+SoDOth5tMscCMNgchxFllbLym+WU8LY1Hlt
5pRI+m+2R7A1F9j6bz75cfAp0Aq0c1RQBKgw7OHRWeb4QyRbJQ3vB0qsSuVYaYy2
kQ2V/FItYBQZ1qxNKpN321csQKHZnzEL/ipSqv6WG3cVXHMfpYoCloP8DVK0jx1O
VuLWUCYRUwfglqML55VAUYDF4gDXm1Lll9TFIt9EG//ZfSInz1O+PxL8TWbAgo8u
d29yZ+Wl0piZ1b4xfAvfrMUUVRUm12TaY50zLVlh3Q5gVMc7YENr2xNhz9c0d7kY
07F2O34yCweJd5m9VfYRCaf6zmyXcg==
=oL0P
-----END PGP SIGNATURE-----

--oQZad9ye1MEygLXs--

