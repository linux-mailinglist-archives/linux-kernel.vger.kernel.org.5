Return-Path: <linux-kernel+bounces-131653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C839898A70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC764283E18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFC1C2A1;
	Thu,  4 Apr 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ4d96sn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34111C2AF;
	Thu,  4 Apr 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242351; cv=none; b=dZyQch+7+UFGkeCgEMnaxCGB0dB72wf87daie3d77S6Ab7EeXhL/k3MDkJG4ttETNV221v3fEeQmR611QITyMkFuM2uuZiESMYkrmw/oOPCpHpFPBDVFWsVB7YaP8Nww0Gs1fEZwuqqHeFwnRLEZh/EmFX8qklGyBRbnVTdFCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242351; c=relaxed/simple;
	bh=FVN+XU95iFZygTEUmTEWzjGUOeNxuFL1vZ2k7fKSY28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNdNB6/D1zE48QBfBjj4AKY7TLQkad69lRiDRKq1dwJdJwr1Do6lZ6PCLCMmOFc1ty4W19+ciCQJLDUy+Q0GxL8LCxkaIw2nyl9gnQbCXBDaczgPiFQP9XeZ/BnYRLNNPdPh/KcwBuoh3sevncne7NS4t2EZBKxejtxxrej933g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ4d96sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6164BC433F1;
	Thu,  4 Apr 2024 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242351;
	bh=FVN+XU95iFZygTEUmTEWzjGUOeNxuFL1vZ2k7fKSY28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQ4d96sncUwpLSXRdO3Bmos1MhA1dXSW/a4RAM3OmavozoeMqEpEcuw/x1YQ7C+bE
	 NANpo8VvxRApMqAz3igOSWnt+K+4RYnyg3H16tgTnTgsjoqW0T2+59pNIApGekVC8Z
	 TJCBZa+pdm4MGW6KzqwRuT7AxxWNlINIXlh0taPjKBRdF/uLRcEHu9tSUvn59l72lh
	 DgVSNMFSSElRTnyxlYEbJm0atkhWS8DlgOoCS6DbOLDH9JqPMkIe3AdDa3ZHYu/0+s
	 xWGG2DqJRg2xDBlJ94w+eRU5FT0uI7IN8un6YegcbCdjHljJ4lYdl+7EWHsJ+JDKwc
	 HzzkhhwM22Lnw==
Date: Thu, 4 Apr 2024 15:52:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: Shawn Sung =?utf-8?B?KOWui+WtneismSk=?= <Shawn.Sung@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Houlong Wei =?utf-8?B?KOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Message-ID: <20240404-lankiness-devouring-d4d012b22cb9@spud>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
 <20240403-conflict-detest-717b4175a00c@spud>
 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5sEXL4CMpiDMisKi"
Content-Disposition: inline
In-Reply-To: <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>


--5sEXL4CMpiDMisKi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 04:31:06AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> Hi Conor,
>=20
> Thanks for the reviews.
>=20
> On Wed, 2024-04-03 at 16:46 +0100, Conor Dooley wrote:
> > On Wed, Apr 03, 2024 at 06:25:54PM +0800, Shawn Sung wrote:
> > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > >=20
> > > Add mboxes to define a GCE loopping thread as a secure irq handler.
> > > This property is only required if CMDQ secure driver is supported.
> > >=20
> > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > ---
> > >  .../bindings/mailbox/mediatek,gce-mailbox.yaml         | 10
> > > ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git
> > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > index cef9d76013985..c0d80cc770899 100644
> > > --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > mailbox.yaml
> > > @@ -49,6 +49,16 @@ properties:
> > >      items:
> > >        - const: gce
> > > =20
> > > +  mediatek,gce-events:
> > > +    description:
> > > +      The event id which is mapping to the specific hardware event
> > > signal
> > > +      to gce. The event id is defined in the gce header
> > > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> >=20
> > Missing any info here about when this should be used, hint - you have
> > it
> > in the commit message.
> >=20
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-arrayi
> >=20
> > Why is the ID used by the CMDQ service not fixed for each SoC?
> >=20
> I forgot to sync with Shawn about this:
> https://lore.kernel.org/all/20240124011459.12204-1-jason-
> jh.lin@mediatek.com
>=20
> I'll fix it at the next version.

When I say "fixed" I don't mean "this is wrong, please fix it", I mean
"why is the value not static for a particular SoC". This needs to be
explained in the patch (and the description for the event here needs to
explain what the gce-mailbox is reserving an event for).

Thanks,
Conor.

--5sEXL4CMpiDMisKi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg6+qgAKCRB4tDGHoIJi
0tiPAQCmKL+7qqsiglTH60MzilEx595s4NTTEM6sOmrSsCQmHwD9FA2Hgru6DIpV
u2H+l/GfFPpbBLY5L/Sz6HL5EuzTfAk=
=u8hN
-----END PGP SIGNATURE-----

--5sEXL4CMpiDMisKi--

