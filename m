Return-Path: <linux-kernel+bounces-119680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D378688CBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1144C1C63A37
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5B86626;
	Tue, 26 Mar 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b28mlofq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537A482EE;
	Tue, 26 Mar 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477471; cv=none; b=trBz0RaUcqB7STOpikY3PLgKsIuZ+ld9akS3ZrHrZAcKF0vNPWDnr1lX7j1uNNZhpbpVdGXkyEjkSNy4NMN6rgalBQD9hSIAIPcuhdQlf7XpAglN1FupfxajPT+rZHPLPk/1AcWt5MicrsFh1wYRxla41kd73tKRkO0nqsRCxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477471; c=relaxed/simple;
	bh=3xBRhog27kxC70sDx2aQpj3OzOt3xnmvvAsyDrsmcII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opll3aHgSXZFlQPhRgsVbfbXfr+12NCtxtaqoaHmd91mZvdaYh8X2Q+7EpEy7J/rf1Uk0kFuE6GaAwLhOPzsNAPQW4+w1uZ46w6k6A7ZO4Dc2p6FIydY+BfVw0hoAVG+uw3YmRgw9UCnNZmXNUZOytYWEIBktO8tH1nUG4RS0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b28mlofq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0572BC433C7;
	Tue, 26 Mar 2024 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477471;
	bh=3xBRhog27kxC70sDx2aQpj3OzOt3xnmvvAsyDrsmcII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b28mlofqMpgdxgVoQwKl8xE5R3uFIancJn4ehIIqdxVvqItovYRjc0SScholjd/QT
	 GWuk/KKHJsAkhi505UdUHjsnvpf/1qlIHa0yMn6hV3w11DZOqTFfwSF8X/60t/JQ9/
	 jc6M4mWwT/YjK+WblM3Aq7Y1INPJmcz45pHvSpcppInNgQz4zB6q0cma1NXVV/0fs4
	 /I3HB2oSaVfGFVuY9gfatvsW22+uoQV9IEgAL83hxaxaBOPu5Hp4AL+aIYEaQiFfSe
	 f4PBLdf45fUGRRtaC2HGu1v4CzVhmmyhEilob1839hZkBy0S2pOfWyCSY+FN8PdAkw
	 7QXys+J0KIVjg==
Date: Tue, 26 Mar 2024 18:24:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com,
	Rob Herring <robh@kernel.org>, Zev Weiss <zweiss@equinix.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240326-april-word-972cd4836e81@spud>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
 <20240326103549.2413515-2-Kelly_Hung@asus.com>
 <32cd6f33-b4e9-4b7a-bcea-b1f2e421d67e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/q+Q8QflJy7p9izc"
Content-Disposition: inline
In-Reply-To: <32cd6f33-b4e9-4b7a-bcea-b1f2e421d67e@linaro.org>


--/q+Q8QflJy7p9izc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:36:50PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 11:35, Kelly Hung wrote:
> > Document the new compatibles used on ASUS X4TF.
> >=20
> > Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Where did it happen? Where did you receive this tag? Please provide link
> to lore.

Robh's bot sent two reports, but I do not see a tag:
https://lore.kernel.org/all/?q=3Dc%3AKelly_Hung%40asus.com+f%3Arobh

> > Reviewed-by: Zev Weiss <zweiss@equinix.com>
>=20
> Where did it happen? Where did you receive this tag? Please provide link
> to lore.

Zev seems to have left a comment on this, but not provided a tag:
https://lore.kernel.org/all/20240223220115.GB9299@packtop/

Kelly, it is important that you do not add tags unless someone gives
them to you explicitly.

Thanks,
Conor.

--/q+Q8QflJy7p9izc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMS2QAKCRB4tDGHoIJi
0sgmAP99qKHB+cAXDMc3qKChE30qQxxp/UYWhpZUny6oL3v5fgD/Vi2hhcCmf16A
C/hk3u2rhCGbNyawGryEwd6Z81hpgw0=
=cX+i
-----END PGP SIGNATURE-----

--/q+Q8QflJy7p9izc--

