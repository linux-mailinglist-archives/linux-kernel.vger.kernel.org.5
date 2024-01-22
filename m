Return-Path: <linux-kernel+bounces-34064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CD38372C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB68A1F242F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC963F8F8;
	Mon, 22 Jan 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B32OpiG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91E3EA81;
	Mon, 22 Jan 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952458; cv=none; b=byOnHAEuYQXIxWgiiIM1CSFNJqgUpsFHgTNUKfWTsi+6wtSn2ncQnpHkyH7bAfi0GTvL0I6IKCcTavnKtBvoWmOpvjI7Yqb+1q+Laq+DUu/Dbj9MrtZa9l3QVOp7glyUWH+1fSeaZDq1tHK4B3fk7u4vbnMHmE15GTwvGL5IhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952458; c=relaxed/simple;
	bh=pVtGodeicWDJGJnRxQD9TYUUvY4ml1P1cyQImCYhXeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqsEN6rrN+S/DSvgShcGe538a/HjjfkpGHC0a1MwJIIrOkTcT182JhF37aI1xOEB8fAIuFVmxTfevxjyuc/JYZ2ThWxRifr0YxsFJlM2EBf2RgG6Ye26pm2zv/K4K/CaLJcR4amHsytMmx53yj8wsxypp4RCmnkSa5s3/EHiuP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B32OpiG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6737C433C7;
	Mon, 22 Jan 2024 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705952457;
	bh=pVtGodeicWDJGJnRxQD9TYUUvY4ml1P1cyQImCYhXeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B32OpiG26rQr9Hr+UduoekLolHO0MhEsx6aRThvVxDKX/JeW2uys7/etwEddPf18/
	 u4SYBNkVTnimvXhcHCfsm/umRFJplfoU4qRh0Wki6ANXrnOjgWjh/ZiDQvLy896JcQ
	 wngPjKpEXXgbeeS5DzNnK+l6PrCgNy4EA8xQPkfIKDxWcYbb79Wm9eJ0B3NQpD9DAX
	 bTn9BiKFLiV8CU65SThM3+UUnR0aAcepvfTstsvTZASmeMSLR/jpRb6GOFbLQIasFy
	 IUh2MGOGgfhJDldXMXMioYEA0wEQreKlHbUGuK2/RuHQcGN8dCBsiSqeMl02O/D7WS
	 eCamcXgaaL1SA==
Date: Mon, 22 Jan 2024 19:40:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Seven Lee <wtli@nuvoton.com>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cJlmuN7wD9uJzDfe"
Content-Disposition: inline
In-Reply-To: <20240122-daunting-woof-19fac5689bb2@spud>
X-Cookie: Nice guys don't finish nice.


--cJlmuN7wD9uJzDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 06:00:14PM +0000, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:

> > +    enum:
> > +      - 0 # VDDA
> > +      - 1 # VDDA*1.5/1.8V
> > +      - 2 # VDDA*1.6/1.8V
> > +      - 3 # VDDA*1.7/1.8V

> I would also rather than this enum was used to have sensible values for
> the enum itself (which I suppose means strings here), rather than the
> register values. Seeing "nuvoton,dac-vref = <2>" in a devicetree is not
> very meaningful IMO.

Do you have a concrete suggestion for how to more clearly write these
directly?

--cJlmuN7wD9uJzDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWuxMIACgkQJNaLcl1U
h9A9wgf9GwcA7Ig0ZhctUzcIuOgFXg+HVs2fAzHGak6ySbki+9ticBmi6pSE85Ss
VawLZpUX9H/Gp2cV7U/PV81ax0MHTrvo1QWWmSoS+3BBHxgqCIHMNrM1houNIxle
YrH2Sq3AKOSs8QHUPF7YQu4VuJV7bOCH5C7FaAIXhVNu3l6iwpz4cBXN7Ta49+9Y
qVYxl0hq+Rk4FCA/7idB0c6I+Xahcz9oQ6YAk+vLkVASFAqgPiY+EDundI2abdW0
P3DwApDBdBjH/fYSf8WAu4x/R1VLvSKMj9gZBbYZdBnsM+u0kyx/0o9C1Lgg/iav
WYCEFzYB3Q/cJxIvQi6YFEwLBvty3w==
=l5dE
-----END PGP SIGNATURE-----

--cJlmuN7wD9uJzDfe--

