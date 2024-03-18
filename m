Return-Path: <linux-kernel+bounces-106840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4210687F455
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7334D1C21A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177ED5FB81;
	Mon, 18 Mar 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1AdiFvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446415F86E;
	Mon, 18 Mar 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806373; cv=none; b=rZE8+C7TVCzBorLteqQBVk124GjktHCTd7DjyfPVuFkzZcs8QD4t9K19HloHZ/F+kpRejtSyo/wEuUIPq2goP7ewTJ7m3/KJ3GW3Yuzt6DMiAsFdHdVlk4pFolMtOEWHRlixrctYvbs9Aqse5PSjfo8PNmYmxnDHG9XuTmQN0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806373; c=relaxed/simple;
	bh=/cuO+2prC5+m8EiBqi7dT0cOyOlyonzfiRrZm1oPk7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BReKhBkHYMUKzzifm/fILz6kmZkQuCJBD4sgvK8kyItU3/RDGQxvCOIxkviy2XqQTfw9sLE8IiBDOwRLDc+6F1RO+qnj5KAZd1DXdbXNCeqlzeOP/fShrQGAw2UmLE89HduqpBJPoAxGkld4mjnHYJx67gLW+y9RaFoHk+hk3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1AdiFvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F906C433C7;
	Mon, 18 Mar 2024 23:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710806372;
	bh=/cuO+2prC5+m8EiBqi7dT0cOyOlyonzfiRrZm1oPk7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1AdiFvAp5GBUxAns2H0MMAN9yTybi5z6O17Afr1xOowOuzOjbiQmOXLsX1anKBLE
	 ekuU64TRkO34e0BQBu7aabyDQG2sab2rSYLeZaY1509JycooK2lwRbysy0jPUfvXss
	 ZRCF8DJJX02IUQkm1/E1tAUjhprfG0K9DFFFIuIyH+8Pt2mMW0mjy6g9YOtZDzEl//
	 vXvyhqPPectG1Zd3rdKITre0iOJNGzLglOg7oAZq6oXMXE25yfVzzwGLC+WhuuyUz3
	 1caAiqVqEZBiePx3A8nkfPjnmZNHqtNaEsG2uvZdBwwNRX10XivuZ6IDrtK5JMSXqO
	 vTJEHG9cUEnpw==
Date: Mon, 18 Mar 2024 23:59:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: clock: samsung,s3c6400-clock: convert to DT
 Schema
Message-ID: <20240318-mummify-helmet-91a1f970a07d@spud>
References: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
 <20240317-curator-smoky-99568f9308bc@spud>
 <60039f49-a20d-49b9-8a3d-2ded499435a4@linaro.org>
 <20240317-jersey-trolling-d4678546e87d@spud>
 <c456f575-570f-40d6-9960-634da314e1d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phI+MIIf734WzXdq"
Content-Disposition: inline
In-Reply-To: <c456f575-570f-40d6-9960-634da314e1d6@linaro.org>


--phI+MIIf734WzXdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 05:20:50PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2024 16:49, Conor Dooley wrote:
> > On Sun, Mar 17, 2024 at 04:26:55PM +0100, Krzysztof Kozlowski wrote:
> >> On 17/03/2024 16:23, Conor Dooley wrote:
> >>> On Tue, Mar 12, 2024 at 07:50:35PM +0100, Krzysztof Kozlowski wrote:
> >>>> Convert Samsung S3C6400/S3C6410 SoC clock controller bindings to DT
> >>>> schema.
> >>>
> >>>> +description: |
> >>>> +  There are several clocks that are generated outside the SoC. It i=
s expected
> >>>> +  that they are defined using standard clock bindings with following
> >>>> +  clock-output-names:
> >>>> +   - "fin_pll" - PLL input clock (xtal/extclk) - required,
> >>>> +   - "xusbxti" - USB xtal - required,
> >>>> +   - "iiscdclk0" - I2S0 codec clock - optional,
> >>>> +   - "iiscdclk1" - I2S1 codec clock - optional,
> >>>> +   - "iiscdclk2" - I2S2 codec clock - optional,
> >>>> +   - "pcmcdclk0" - PCM0 codec clock - optional,
> >>>> +   - "pcmcdclk1" - PCM1 codec clock - optional, only S3C6410.
> >>>
> >>> I know you've only transfered this from the text binding, but what is
> >>> the relevance of this to the binding for this clock controller? This
> >>> seems to be describing some ?fixed? clocks that must be provided in
> >>> addition to this controller. I guess there's probably no other suitab=
le
> >>> place to mention these?
> >>
> >> To make it correct, these should be made clock inputs to the clock
> >> controller, even if the driver does not take them, however that's
> >> obsolete platform which might be removed from kernel this or next year,
> >> so I don't want to spend time on it.
> >=20
> > I think the comment should probably mention that these are the expected
> > inputs, part of me thought that that was what you were getting at but I
> > wasn't sure if instead they were inputs to some other IP on the SoC.
>=20
> I can change it, but just to emphasize: in half a year or next year we
> will probably remove entire platform, thus also this binding.

I know, I saw that. I don't really care what you do given the platform
is being deleted and it is unlikely that anyone is actually going to be
assembling a from-scratch dtsi for this SoC. On the other hand, if
you're doing a conversion, even in this scenario, I think it should be
clear.=20
I didn't ack the patch cos I figured you were taking the patch via the
samsung tree (and on to Stephen) yourself, but here:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

I'd rather argue about the definition of erratum instead of this :)

--phI+MIIf734WzXdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfjVXwAKCRB4tDGHoIJi
0oZhAQD+pmOY+P/bz4THs5Dh9jBUlSFieYOnAX0+K/xeZPaoigEAtpb48qbPfE/w
ORq53TSn9+qiVqYzXqWjizxmSyWJRgw=
=BACD
-----END PGP SIGNATURE-----

--phI+MIIf734WzXdq--

