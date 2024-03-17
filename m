Return-Path: <linux-kernel+bounces-105456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7F487DE1B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81608281AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F01CA9E;
	Sun, 17 Mar 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM5e5iqM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C171367;
	Sun, 17 Mar 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710690556; cv=none; b=rYGK8X7aI5txe26rs+/+jPXjsiQ21V4l71ECaz3bmQEa5UZ8xkLOeYTj+pIz4JV10t27ixNkiDR9mHkD3x03Qj0KrScbbGsqWwolptfiIYhJ1zQEIhNZFWyA+WKQfll42vYH1cOz6XO1n69OTz5L33Gvp6NUCLVB3e37QoLOEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710690556; c=relaxed/simple;
	bh=LdpyYbYNuF+OR1AOEmZnwLSBboDczWS8oE9fk1CQDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFOzA6ZMjJv2EJjl+QJE7e3Od0oOWpz8gkLN182qJ73cMtUfEW89xqSLzgHVB1m3AyPcytVylTYiBXumly/iyoi6nAz0uV6ptZDQ+C1a+d6gVGav+1SL9LFBwFHhrCjGEdbRyzQrGTUESaOpIB6B3wRfhQ2TG8aeh4mG8X0ZGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM5e5iqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526C8C433C7;
	Sun, 17 Mar 2024 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710690555;
	bh=LdpyYbYNuF+OR1AOEmZnwLSBboDczWS8oE9fk1CQDW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YM5e5iqMYeGrO8qd2LMXW8BhqELysmFBchVgtsfMhj2NE8pVuMHqqEO9m7aKxRr7C
	 OCbrDamxynIRmGjtM/D2N/nmC/lozcrdJpFwQ5JZ22liB0JFyNwvypjyGVT6PpeZJv
	 5Mr31Tm4M41Bop/EtYgd2YWmxjHBQ37qz5+TgVQhblTu22xfmbbzKqEK51Olct7itg
	 UUL9djWjS4WPb19OLVup7vX5qNBPrKAhcEtQkNYzw1nSvO9lyTKpOqXrJQCG8SrUXD
	 Ds2GIIogOIJzvACwLekK+XzT6Tmn/zj2WBQr6s7vPY51q+IZsapauvZyxHNKSQW4eU
	 Q+xJir/xsO0Kw==
Date: Sun, 17 Mar 2024 15:49:11 +0000
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
Message-ID: <20240317-jersey-trolling-d4678546e87d@spud>
References: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
 <20240317-curator-smoky-99568f9308bc@spud>
 <60039f49-a20d-49b9-8a3d-2ded499435a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kk6uFwGcxqpNcnbw"
Content-Disposition: inline
In-Reply-To: <60039f49-a20d-49b9-8a3d-2ded499435a4@linaro.org>


--Kk6uFwGcxqpNcnbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 04:26:55PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2024 16:23, Conor Dooley wrote:
> > On Tue, Mar 12, 2024 at 07:50:35PM +0100, Krzysztof Kozlowski wrote:
> >> Convert Samsung S3C6400/S3C6410 SoC clock controller bindings to DT
> >> schema.
> >=20
> >> +description: |
> >> +  There are several clocks that are generated outside the SoC. It is =
expected
> >> +  that they are defined using standard clock bindings with following
> >> +  clock-output-names:
> >> +   - "fin_pll" - PLL input clock (xtal/extclk) - required,
> >> +   - "xusbxti" - USB xtal - required,
> >> +   - "iiscdclk0" - I2S0 codec clock - optional,
> >> +   - "iiscdclk1" - I2S1 codec clock - optional,
> >> +   - "iiscdclk2" - I2S2 codec clock - optional,
> >> +   - "pcmcdclk0" - PCM0 codec clock - optional,
> >> +   - "pcmcdclk1" - PCM1 codec clock - optional, only S3C6410.
> >=20
> > I know you've only transfered this from the text binding, but what is
> > the relevance of this to the binding for this clock controller? This
> > seems to be describing some ?fixed? clocks that must be provided in
> > addition to this controller. I guess there's probably no other suitable
> > place to mention these?
>=20
> To make it correct, these should be made clock inputs to the clock
> controller, even if the driver does not take them, however that's
> obsolete platform which might be removed from kernel this or next year,
> so I don't want to spend time on it.

I think the comment should probably mention that these are the expected
inputs, part of me thought that that was what you were getting at but I
wasn't sure if instead they were inputs to some other IP on the SoC.

--Kk6uFwGcxqpNcnbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcQ9wAKCRB4tDGHoIJi
0jbjAP0el+zfqXU/1GH/ci5i68AFLqupDHz+2uX0i/EiXkqgwgD9FSPzzbqPkxlg
rMx2MTgf2+caqhXEviVOR/fol7xARgk=
=QuI7
-----END PGP SIGNATURE-----

--Kk6uFwGcxqpNcnbw--

