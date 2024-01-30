Return-Path: <linux-kernel+bounces-45000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D2842A31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B2B24736
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498A91292F0;
	Tue, 30 Jan 2024 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3OreCJz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4521292CD;
	Tue, 30 Jan 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633705; cv=none; b=fa3Eb+BW8w67dpKCJQfLo4zfXJmXJz5KaGPkWIPrX/97ZMwG+6IPrpbsZ7B9aQNWYp2ZltpdZXjB5vvRE1WtNM1jFnRo1oEAUdygoCCQp7lZ7G+z4tr4IRSmWBNEI92h1KEgb9l/Hf/pPq27hvm7z62XysQuX2TFDf9pJ3Ud87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633705; c=relaxed/simple;
	bh=ZN68Z2wa2IkqX2W/7CDghaewC4izhCOODj8is9NucqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuffSWItB2SYs57fOOTnAlWdla36J0F3evniM/acBxeFNjCwS4+gYe5gp1as9fO9ZrWmtZfDP9izAco69q7e2hCbxhX1RuHXoibzPgqfeflXe07F9Lk5SqMltUPBdN/qmVpVI5ltX4iyE0uHFHbeEpMHPTjwY/phwrhn9lqyGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3OreCJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA84C433C7;
	Tue, 30 Jan 2024 16:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633705;
	bh=ZN68Z2wa2IkqX2W/7CDghaewC4izhCOODj8is9NucqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3OreCJz7R8m9wWmqrNDf02nbR+Q1XuExeLGFBooyAywAbZBmP4JsBozKg2A2ucfg
	 gvAjj81k6Gy7Drs29C7GCeFstNnfFEq9m7piujeEIXVqMzNofzHqWFKEvH/JeCqcyT
	 GPXjtj6E8qLvr407SlWspw6+Iwe4hFsLHYzx7DR0+sCpm8kQN5O/h2kAtB/zvdkj5x
	 9fofnIqdan+M3l7LNLYBGJ4ACXaAK3KV1bihcBI9+Xwbgv9TdbLZlBQBIxBa5jlQKg
	 ywzP7ouscoF2r9Ysmw0tWfVbYbLpcz3MMhdTEQ1Etx7gZn1jTxCU7xCqYc2S0ezFXc
	 qSmOZ7Tbm42Aw==
Date: Tue, 30 Jan 2024 16:55:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	kishore Manne <nava.kishore.manne@amd.com>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe soc-vvmem subnode
Message-ID: <20240130-synthetic-passerby-44bab0ad9e1a@spud>
References: <3869498c995cbb123127122f429e90de0a3f4014.1706531104.git.michal.simek@amd.com>
 <20240129-vastly-hunk-0680e152c03c@spud>
 <ec0f347c-483d-47d2-b868-0c64070cc153@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BU7b17+mVNT7itsx"
Content-Disposition: inline
In-Reply-To: <ec0f347c-483d-47d2-b868-0c64070cc153@amd.com>


--BU7b17+mVNT7itsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 08:13:09AM +0100, Michal Simek wrote:
>=20
>=20
> On 1/29/24 17:57, Conor Dooley wrote:
> > On Mon, Jan 29, 2024 at 01:25:06PM +0100, Michal Simek wrote:
> > > Describe soc-nvmem subnode as the part of firmware node. The name can=
't be
> > > pure nvmem because dt-schema already defines it as array property tha=
t's
> > > why different name should be used.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >=20
> > > Dt binding for nvmem node has been already merged and it is the part =
of
> > > linux-next tree.
> > > Here is the reference to it just in case:
> > > https://lore.kernel.org/r/170635581622.41421.8980881999042944764.b4-t=
y@linaro.org
> > >=20
> > > ---
> > >   .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml   | 9 ++++++=
+++
> > >   1 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,z=
ynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xln=
x,zynqmp-firmware.yaml
> > > index 7586fbff7ad6..108772ef574f 100644
> > > --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-f=
irmware.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-f=
irmware.yaml
> > > @@ -62,6 +62,12 @@ properties:
> > >         interface.
> > >       type: object
> > > +  soc-nvmem:
> > > +    $ref: /schemas/nvmem/xlnx,zynqmp-nvmem.yaml#
> > > +    description: The ZynqMP MPSoC provides access to the hardware re=
lated data
> > > +      like SOC revision, IDCODE and specific purpose efuses.
> > > +    type: object
> > > +
> > >     pcap:
> > >       $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
> > >       description: The ZynqMP SoC uses the PCAP (Processor Configurat=
ion Port) to
> > > @@ -110,6 +116,9 @@ examples:
> > >       firmware {
> > >         zynqmp_firmware: zynqmp-firmware {
> > >           #power-domain-cells =3D <1>;
> > > +        soc-nvmem {
> > > +          compatible =3D "xlnx,zynqmp-nvmem-fw";
> > > +        };
> >=20
> > Would it not be better to have an actual nvmem-layout in here? The
> > ~empty node here looks rather odd.
>=20
> No issue. Do you want full or just nvmem-layout with compatible string (w=
hich is
> required)?


What you have below here seems like a much more useful example. I'd go
with that.

Cheers,
Conor.

>        soc-nvmem {
>            compatible =3D "xlnx,zynqmp-nvmem-fw";
>            nvmem-layout {
>                compatible =3D "fixed-layout";
>                #address-cells =3D <1>;
>                #size-cells =3D <1>;
>=20
>                soc_revision: soc-revision@0 {
>                    reg =3D <0x0 0x4>;
>                };
>            };
>        };


--BU7b17+mVNT7itsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbkp5AAKCRB4tDGHoIJi
0jQLAQCOeib5tcX6tEcKKUiRouIu3/C9GTGk2X/tIfQzaGKcxQD6AkDiq9g327L9
BZRRAwIsfJ0/zkLp6eBqjTbywmmPjgI=
=/dwj
-----END PGP SIGNATURE-----

--BU7b17+mVNT7itsx--

