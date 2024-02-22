Return-Path: <linux-kernel+bounces-76981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2285FF68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BEC1F23445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AE155A39;
	Thu, 22 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrbR7OFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742C39FC7;
	Thu, 22 Feb 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623042; cv=none; b=qj7mi2/ITYK9oqcm4c6E0mjeg+zXFw7QL0hJjNqBPJ/toGRhjBE4m1L5aBu2Z50CVz2W3nzqh+YaiISNXqs23Y9pnHMXyvvI+guP9nyp19WnMFCSgFWf7Vj3UNzbfBhJLr7eQulHBncw8bM5WvAPDW7VEH27ya3IqNO8VBLcguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623042; c=relaxed/simple;
	bh=8dkiuR42Ay/FRMA2iw0COAQGckjNrMYLquYYR2M/lIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL7EuGB7ao8Ke2R2H3wrzIn2/lnR4K7I3Xsvg3uYbRi1Yzv0Iyl9yZoqTh04LhvpaPGO0FkgS0yzzri15w75F5nWQPwv8IsNQTDb7uMNp/864bRuC6fUHwiM/6QI1XriRx2kkiAYtkW0jZtLikm7gCXRVYiRrGQpRHZ7JhRq4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrbR7OFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EC9C43390;
	Thu, 22 Feb 2024 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708623041;
	bh=8dkiuR42Ay/FRMA2iw0COAQGckjNrMYLquYYR2M/lIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrbR7OFoLPGODCmGI+TDfzEExz/Qee9nZii1IsdYTaZldFXQF4cyRr/V3KKe+bot/
	 e5b5/0w/aJHY3/4vR5uVmjCciqHlsoIXN2eYoISW3Na+AVl4f/Y1u76S2gxxR7qwZu
	 xnD9QIwRo11sgBnzNvl90hEZGfReZt58IvoK+lXThAGL61tbuU7gtBJ2CeLNrN6v/0
	 yE87uui9DNn8vEdpzF0VilK/ynHv4fmqTb6NalpeOPPVbHQOUxnCHTkuDA7Tz52PAo
	 QMQGvKZHkbz9EoAd0hVppnS5hKaANUGIbTFboVdFEWizHgpMoTyciVIy9n5aBfmkFd
	 AZndupAuEswzQ==
Date: Thu, 22 Feb 2024 17:30:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] dt-bindings: usb: analogix,anx7411: drop redundant
 connector properties
Message-ID: <20240222-runny-routing-8e7801a09113@spud>
References: <20240222082819.10321-1-krzysztof.kozlowski@linaro.org>
 <20240222-election-doorstop-8c179803c47e@spud>
 <838ed10f-7f0a-48e8-a195-a155e4766f49@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KCmP/T33K8VIerl3"
Content-Disposition: inline
In-Reply-To: <838ed10f-7f0a-48e8-a195-a155e4766f49@linaro.org>


--KCmP/T33K8VIerl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 05:56:12PM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2024 17:08, Conor Dooley wrote:
> > On Thu, Feb 22, 2024 at 09:28:19AM +0100, Krzysztof Kozlowski wrote:
> >> The binding references usb-connector.yaml schema, which lists all
> >> allowed properties and ends with unevaluatedProperties:false, so we can
> >> simplify analogix,anx7411 binding by dropping everything covered by
> >> usb-connector.yaml.
> >>
> >> Suggested-by: Pavel Machek <pavel@ucw.cz>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../devicetree/bindings/usb/analogix,anx7411.yaml   | 13 -------------
> >>  1 file changed, 13 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.ya=
ml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> >> index e4d893369d57..3f5857aee3b0 100644
> >> --- a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> >> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> >> @@ -23,24 +23,11 @@ properties:
> >>    connector:
> >>      type: object
> >>      $ref: ../connector/usb-connector.yaml
> >> -    unevaluatedProperties: false
> >=20
> > The connector schema sets `additionalProperties: true`. Is removing this
> > correct?
> >=20
>=20
> I think you look at some old version:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/connector/usb-connector.yaml?h=3Dv6.8-rc5#=
n327

Huh, you are correct. I had a stable kernel checked out somehow in the
git worktree I apply dt patches to while reviewing them rather than
linux-next. Sorry about that..
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KCmP/T33K8VIerl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdeEvQAKCRB4tDGHoIJi
0v0NAPwLF928qfOKaGLUcPyTY2d5VS2sykFrvFXmuGYywqZj+QD+Ko2s6NTikrHJ
0RiYWScGqZjgz7d2ASenP/OUGUoEtgQ=
=ishp
-----END PGP SIGNATURE-----

--KCmP/T33K8VIerl3--

