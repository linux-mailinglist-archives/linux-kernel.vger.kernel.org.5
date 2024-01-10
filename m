Return-Path: <linux-kernel+bounces-22201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05883829AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134A21C25C20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CB24878C;
	Wed, 10 Jan 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMfJzWKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B54176A;
	Wed, 10 Jan 2024 12:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30DAC433C7;
	Wed, 10 Jan 2024 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704891460;
	bh=3aOr1DkG81cJdxOae61hHTJFgTMQ6lUVanEgx/mZU9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMfJzWKWgtXEyUNHoxMeKR9EmKtEwlOxH6+ofJBRkASMpMNApcPz3rAM6NCy+vf2h
	 oUVtp9Wca1aE+RLlYroq8Ftb/0XFJolG0kRrhQ41nByvYQ0ZVNT8MsWR9IPj7TZ+xL
	 Fyl/cInKBHGPDFmbRVLp3DmJ00AvhzejbWxycsysgFrNIuiFB6DNsvUvUYn8xYoVG/
	 5Hv5CD26XjM0MvjSumh7ijUIBs3ZM2VHRjgUGDx7R4dk1fT/pF6tQk5oOuIVzelluu
	 XuwDBYWxzAUEzsg66VbasizgPVbns4MHlfkC27tdPREYnOFRN+XjkwbFUSdWFikjHV
	 2pWayy5mJMY2Q==
Date: Wed, 10 Jan 2024 12:57:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: dai-common: Narrow possible
 sound-dai-cells
Message-ID: <3b1b956b-985c-45f2-bda3-018aaf897295@sirena.org.uk>
References: <20240109213812.558492-1-krzysztof.kozlowski@linaro.org>
 <1ja5pdzb7k.fsf@starbuckisacylon.baylibre.com>
 <7e312b05-857f-40a6-a1a1-a954dfea7044@sirena.org.uk>
 <f9f5df54-dbeb-4246-b30f-52f3db7d94b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9SLwTmkr8BW6Pqv"
Content-Disposition: inline
In-Reply-To: <f9f5df54-dbeb-4246-b30f-52f3db7d94b3@linaro.org>
X-Cookie: Do you have lysdexia?


--/9SLwTmkr8BW6Pqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 10, 2024 at 01:51:03PM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:37, Mark Brown wrote:
> > On Wed, Jan 10, 2024 at 12:07:30PM +0100, Jerome Brunet wrote:

> >> If restricting things here is really important, defaulting to 0 (with a
> >> comment explaining it) and letting actual devices then override the
> >> value would feel less 'made up'

> Wait, what do you mean by "letting actual devices then override"? It's
> already like this. Nothing changed. What do you refer to?

The suggestion is that instead of limiting to 1 and having one device
override limit to 0 and have all the devices that need 1 override as
well.

--/9SLwTmkr8BW6Pqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWelD4ACgkQJNaLcl1U
h9CrTQf+LLAwsEUru632QVX726jBEgYejO+232auc1QPN3nCubqCb4513/fQpETn
orkv05itGQnm8SYRs4qrGpu/FU+MKJMgYP5VBjKM4iLvMxvvyo0qSzwkH6NDKMVq
DZmbIEbOAZfvLkdpHZXVakjK9hDQIVEDHdJZJuEIOdZI6pDdduUwi7YRbS9fxfve
DeiaYHy4qBgNabVB3gQKj6rVVD59T7f4irH/aLqFu20JXZh1eKl7SgBIbqh7O4YV
wUqhNkSghoCmOXE+GKY8S1LlywYeCtE5MJd8Bz0amyC13ve94KfwbWjBpFfRxOVL
DDiWtRY4btXyPBalxDVQ0K65DKEZvQ==
=5LfC
-----END PGP SIGNATURE-----

--/9SLwTmkr8BW6Pqv--

