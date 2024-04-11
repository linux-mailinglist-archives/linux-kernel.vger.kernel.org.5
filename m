Return-Path: <linux-kernel+bounces-140736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF38A1877
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B33B27EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504E17548;
	Thu, 11 Apr 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1tuCVeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDB13FF6;
	Thu, 11 Apr 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848727; cv=none; b=CG3wRS8PowYZ7kUpPCg6ARq/OHPcdQgM361Vd8ADRp/7DQrmDthNL1d0XYSw3PtLjfT6c1Tx2hlYq5qBBmnvFt6IhS+xdA67qGGkdNOQ77/qONVLyjHxVsc5M7lZLFYtwAi7I4Ewl+bZ+IYW+t5Qo57f6by0ySBr/qOuZhttUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848727; c=relaxed/simple;
	bh=IVfpujiqFE7Wz//nwMyDR2FjbxTDeZ4CZN8xF6MI70w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAK0qFdgSTwZ3fcZVVUuP+oDBiaXK61b52DBQvIRoEVMuEpR0kbYk7sFuIawAWEmIc7MZIOfdACukKoAtPvMTqx9AlrSATw4qFUARzcb7tOpjNxCk/63ggbhusTru6p0GKJSnGG/LYCAOk2ejdBHdT9GvbhSKpeeHFqw+yhLdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1tuCVeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC9AC072AA;
	Thu, 11 Apr 2024 15:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848726;
	bh=IVfpujiqFE7Wz//nwMyDR2FjbxTDeZ4CZN8xF6MI70w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R1tuCVeNUKpp6zEOSjIfgsnalqciR99+p5fDV76dBQnfwf1wpZNmhunVF9ebrmXDV
	 5BMi57E1CkD4/YwFU2mwLj79o4lqqc9JLfTlwcVYieNh6CstJ+EYirLZi4f5B934Iu
	 V2ci9VAl1j7ceZzaZsDvZA7P/x75QZvcvTNpCcM1DxSFq94oiO9SPGzy2O7X0TfxE2
	 y84pB2PRT6PO6K5CNy2ZUId0v53FSOlbYYCIjr6mzXawZ/BNa8ItiVnVuqL0i9aIeS
	 bAWfr0kXIhTQq+YPRlVcJihJvg4hLoKrz1GQRGj/9SpDmIu2fGYRH9XAdUnZVkBOXj
	 VuoDEOZ9EW8xw==
Date: Thu, 11 Apr 2024 16:18:40 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, chu.stanley@gmail.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, stanley.chu@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] dt-bindings: ufs: mediatek,ufs: Document
 additional clocks
Message-ID: <20240411-curvy-satirical-8c50cf79d703@spud>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-8-angelogioacchino.delregno@collabora.com>
 <20240411-filth-trekker-8a8c185d589b@spud>
 <f7fcbae7-fd54-4ad5-8dc6-4deb80088b79@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BPJ3krEP7ZWCC7l0"
Content-Disposition: inline
In-Reply-To: <f7fcbae7-fd54-4ad5-8dc6-4deb80088b79@collabora.com>


--BPJ3krEP7ZWCC7l0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 05:14:34PM +0200, AngeloGioacchino Del Regno wrote:
> Il 11/04/24 17:10, Conor Dooley ha scritto:
> > On Thu, Apr 11, 2024 at 01:42:59PM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
> >=20
> > I appreciate being told they're on all, rather than it being unsaid and
> > having to ask.
> >=20
>=20
> You're welcome :-)
>=20
> > > some of these clocks are optional and used only for scaling purposes
> > > to save power, or to improve performance in the case of the crypt
> > > clocks.
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> > > ---
> > >   .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 14 +++++++++++=
++-
> > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml =
b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> > > index e2c276da3f2c..21b038db100c 100644
> > > --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> > > +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> > > @@ -26,11 +26,23 @@ properties:
> > >             - const: mediatek,mt8183-ufshci
> > >     clocks:
> > > -    maxItems: 1
> > > +    minItems: 1
> >=20
> > Could you add an itemised list to the clocks property please?
> >=20
>=20
> Not really... Honestly, I'm not confident that the description will be 10=
0%
> correct for all of them... can we do that at a later time, when I will be
> really that much confident in writing down a proper description for each
> of them?
>=20
> The only thing that I'm really sure of is exactly what I wrote in this co=
mmit,
> nothing less, nothing more... for now :')

fwiw, my motivation here was a better explanation for what "ufs" means
as a clock. When the block has some "ufs" clock and a "axi" clock it's
kinda clear what they do, but with 7 ufs clocks now, it's not really
clear what the bare "ufs" one actually does.

If you can't provide an itemised list, please set maxitems.
=20
> > >     clock-names:
> > > +    minItems: 1
> > >       items:
> > >         - const: ufs
> > > +      - const: ufs-aes
> >=20
> >=20
> > > +      - const: ufs-tick
> > > +      - const: unipro-sys
> > > +      - const: unipro-tick
> > > +      - const: ufs-sap
> > > +      - const: ufs-tx-symbol
> > > +      - const: ufs-rx-symbol
> > > +      - const: ufs-mem
> > > +      - const: crypt-mux
> > > +      - const: crypt-lp
> > > +      - const: crypt-perf
> > >     phys:
> > >       maxItems: 1
> > > --=20
> > > 2.44.0
> > >=20
>=20

--BPJ3krEP7ZWCC7l0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhf/UAAKCRB4tDGHoIJi
0jVLAQCdNb1Gih80RDqdXRY3kcs4MBVqtfkDT6i122nbuJOL1AEAx+wKLmQLY3RJ
Ld/HWV+CNWWPYqHyLYE+D2RFn9PYlAo=
=2ddv
-----END PGP SIGNATURE-----

--BPJ3krEP7ZWCC7l0--

