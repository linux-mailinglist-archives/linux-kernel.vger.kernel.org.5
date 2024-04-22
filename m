Return-Path: <linux-kernel+bounces-152677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D18AC2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3017A2813BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB44C97;
	Mon, 22 Apr 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R554hteM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9E2F56;
	Mon, 22 Apr 2024 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713751486; cv=none; b=rLdzPR1hcqcxzYQlSeOm+ahK307DOm5pVcy/HH7KmFShrgdJQNQkpUzx6jvIIcuN7wgbg5155w44MQyeykyFP5B7WKdLU4i5PUJIGnWja8oQQK8tCo/pxgW+ANTaqXCk4iJ2du2MP9xQQfOy8bxp4GGcVWqsSjYUT8B1mWHGIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713751486; c=relaxed/simple;
	bh=XcK1exHDhSlHoAdUUFjKkrAP94hyw0NtS9+rJ4yzmbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI94xVBLISkXH02VOAuKsgf2pXJdP7y8SoUAB1J4uUrVF5tu9R+WJcMJmrrJihKhjGJaIGWI4CyB2jMX5SE4ZQ+vaCkA6PofE4og2Qy4wS7WJLU8glxo+c/WwUrhA5qot8FqCd9S45xta6NwACkF/289aFAFDnPyPgjTGQ4NDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R554hteM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243D5C113CE;
	Mon, 22 Apr 2024 02:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713751485;
	bh=XcK1exHDhSlHoAdUUFjKkrAP94hyw0NtS9+rJ4yzmbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R554hteM0cdmVrLrliiRIZHN2kP2nYb45KXkzOeWnOoiUd/W3bD6SHzQgsxPToOig
	 0H/7n99flJ+uRz98U3Y/pToOrp/HhsQigKGwuU7NLJ6bYYmvQ7FAGyTHolRNq7VXIJ
	 DUhcianteItoDZ9TjTbE71oJAaM04Nio/6+yoENIg7fA9uO8aoq7KVztNCPH5fOTVs
	 cG3t+W2LLOtV1R/crYyseu97p1MywjX2ywzGPtIB7m+uPvz7MO3G/oC0ZPeu7D7gsW
	 LUsic5YAarf94BWohduddVCdgm1n1LWPt6O9m5CcORNTgYrdQj41+MUJBnFAly68LB
	 E0AwY434ZYxAA==
Date: Mon, 22 Apr 2024 11:04:43 +0900
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
	keescook@chromium.org, gustavoars@kernel.org,
	henryc.chen@mediatek.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	wenst@chromium.org, amergnat@baylibre.com
Subject: Re: [PATCH v4 6/7] regulator: Add refactored mtk-dvfsrc-regulator
 driver
Message-ID: <ZiXFu10_NBROj-jA@finisterre.sirena.org.uk>
References: <20240418094134.203330-1-angelogioacchino.delregno@collabora.com>
 <20240418094134.203330-7-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sWXCwk7xYCT2BASP"
Content-Disposition: inline
In-Reply-To: <20240418094134.203330-7-angelogioacchino.delregno@collabora.com>
X-Cookie: TANSTAAFL


--sWXCwk7xYCT2BASP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 11:41:33AM +0200, AngeloGioacchino Del Regno wrote:
> The previous driver never worked, and never got even compiled because
> it was missing the DVFSRC driver entirely, including needed neaders.

Reviewed-by: Mark Brown <broonie@kernel.org>

--sWXCwk7xYCT2BASP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYlxbcACgkQJNaLcl1U
h9BPiQf+MHWLDD6c7mn4Lo9anxSg6sfBCPhJMRQgjilSVkWbO9u9qqRpZUcj6VfJ
cUaIU8rJOyel4ZYjFieZcFbw6+OQZvkAXb2mtrDYGod5PkB2iwYvZNHjmvuVIqzM
9WCbbMjphVoQtz3S8RJ44C00SIZdGLjjqyNH+OiG4BPjMHYM37lT70oTV/wv/4Nh
NblCIhPZfxgtUVVuRdyBB5NgpjsdHe+leEQp0UYBZ1+w6ES+z/bS41mCDgmSuOGh
0S7CP7CY5xy2A9e0G+LiZaBj7Y7AS8Xsn4rT0kSV9HeAwcWxEf/A6genOX8gDj0V
P4nqi3Cks0HOsm1EQABSBeVEPaOOEg==
=69No
-----END PGP SIGNATURE-----

--sWXCwk7xYCT2BASP--

