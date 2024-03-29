Return-Path: <linux-kernel+bounces-125070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA0891F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDF91C285DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834F144316;
	Fri, 29 Mar 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5O8A5+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730152F72;
	Fri, 29 Mar 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711719375; cv=none; b=DJv0riplocISZ2KqBapjH9PGOgO39UAoUazHd8oOxRaeKdsfd4nZxhsljrFn9whvBZtP/d7em0POMgEcEJ0p1ySItmzl96ueh0J4UP41BhToFO8JAk5yA1v1atIJJ/jv0S22DmEqIw9apXsWQIeQGb4p47A8F3ini8sKjyqjj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711719375; c=relaxed/simple;
	bh=jnwxTsD0edotBFz3w9snQJc1F0VCr5E8otP3pm+q3rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ushz3QfFhLmxj6/1+VohNIkrVQhajDAcKJrA+wnctXkpjqnkys7L9Dv6PJIyAB0qNYdBYHynC38oSbtU/aXcm9kPehgk8n9hcNs4KL9yWyYaGDNQMMWFPpKyq90+jn23YBCXBj3kSFUh/KdyC7HBj7diDQH3eUw7rJddAsWfPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5O8A5+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D93C433C7;
	Fri, 29 Mar 2024 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711719375;
	bh=jnwxTsD0edotBFz3w9snQJc1F0VCr5E8otP3pm+q3rM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5O8A5+e3T43C4JS0f9c3DLZ9ZjXZy3qEsRyEXX6aPW8BQiW5BoK+MPaqWwr88DUh
	 2YfchZgt+RbH4RumlTdWmx+3JghKVlgyRQHvi/rCRQWqVTQ0MVWZN6LPdaDSqAi44b
	 qKoIGqZcdpQ1eMbM30rb4H2UCLQ87ebkutaTdCRgMjDr9kL0deJtx7fx6t1sCviAQw
	 I1xPsFwQ/Kjv4JH2fJ4ohOI/vKXFQbQpkmIVVrMvLY3BQnjcibWNy8SkSDXp/C/Ug2
	 JSPrLcpih4WomBB0W7jmCoewNHmNoGZYeFO9Qg1kxBQEEX/fuM4dxAXz4K6639zNy9
	 tNbiDn3C2Vrzw==
Date: Fri, 29 Mar 2024 13:36:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8y?= =?utf-8?Q?=5D_ASoC?=
 =?utf-8?Q?=3A?= dt-bindings: Add bindings for Cadence I2S-MC controller
Message-ID: <ZgbDx6oD+mMUIvH1@finisterre.sirena.org.uk>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
 <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
 <NTZPR01MB09563633F5C3B5FBC95D61289F3AA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <7b4a35d0-6764-4c6a-9f1d-57481324c680@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iIGHYhhokfc75u7X"
Content-Disposition: inline
In-Reply-To: <7b4a35d0-6764-4c6a-9f1d-57481324c680@linaro.org>
X-Cookie: You might have mail.


--iIGHYhhokfc75u7X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2024 at 12:42:22PM +0100, Krzysztof Kozlowski wrote:

> I stated and I keep my statement that such block is usually not usable
> on its own and always needs some sort of quirks or SoC-specific
> implementation. At least this is what I saw in other similar cases, but
> not exactly I2S.

I wouldn't be so pessimistic, especially not for I2S - a good portion of
quirks there are extra features rather than things needed for basic
operation, a lot of things that might in the past have been quirks for
basic operation are these days hidden behind the DT bindings.

--iIGHYhhokfc75u7X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYGw8QACgkQJNaLcl1U
h9AoCQf/b7CetVNUQ04OVH9f281N1evjEGVDKNvmj8TAvLEoUEG4P3QSQCXLRTFL
XCqgLAxCUPBrhC1vZfv7x1NMf6FZtqXyP9O7mW6DwydE8RGlKZM+G0TrP3mkLs8g
y6+3eKFU0bo2GJTgJRsVtNtLNzTXsTUGO/tU9khE7a3mJImQucQlJJ57EG/qMxXa
As1WC+LHJ4fGYDQFYBEaL5kvjCd/K4/nxrUQIR5GGMpM4q8/MHNcvDVXColvnACD
ts0VNnwgkNiNEHiarjuIq1Lsx3kfPLCeVu3sbydAzszYi/mSC2AIcvzFqUCwy8Y4
SnpWS7wTOxtWTnqr1WykCbx0Tf7cDQ==
=kO0w
-----END PGP SIGNATURE-----

--iIGHYhhokfc75u7X--

