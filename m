Return-Path: <linux-kernel+bounces-96209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13387589E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFE81C22461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B81386C5;
	Thu,  7 Mar 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTLMpS3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AFD634E9;
	Thu,  7 Mar 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843996; cv=none; b=maIhfOBV9oZmrN06kcDammkeopy+3ljL5WOyUqhkiA1QrL6rALelGtaass2N5JUh8JpCbvGof4sudaQigT8opEiWuIk6IQyJQunUW420AAgW8p979VEE5sww1+3oHKR5PEpnwcWkuYPYOdDVEA1HlW/QmoQEF+icrQhqD5nixRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843996; c=relaxed/simple;
	bh=xzOKp2H5xhff7RPjl7hUZinOqbqvSZ0ptOXYVgfGCwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi7zpLVPHmK/GN2wrLuw9J2OWbf3zO/oXjJg1F/LhqJ/TQKA+WjV1nhdlvXti7RXCsP503n1Qu+Wqzp0K+q3+4eeFeIvNb5yoZmVAwh4QDrp3fowtvaTAZ+LPJealA2TV+bMu3v4GHmEG708SaoWlr51WXsDZKDDpTDhBSF9PMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTLMpS3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4708CC433F1;
	Thu,  7 Mar 2024 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709843995;
	bh=xzOKp2H5xhff7RPjl7hUZinOqbqvSZ0ptOXYVgfGCwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTLMpS3V56JS9D8rU1wNJes/qKPjQmq1Xy9PQLl9UYi85d/tBRdkmdybujPkQ0oc1
	 lCh5LU5sR8iY6ZKRnZVzRsvjsaJ4iyxUYoHVqrCLU5MTyTSQth4Ok11AvCyeybhoiV
	 R9nre40xIwxjSHJh0avjbHqEQynpt50oJBk8uWmgkBXqXxHjWVE2oSUa9pP4AJYgq6
	 yqg5jtfLoySoJdERzW00Fym8HKrWWyBLnoKhYld/vSZR926l5KS4Q6e7/wb4p/iluj
	 pqM6DhqT9yuG4mRnSPQffBQ4yRLhv8+PyB2NFSM0plLLgy7LPxuWDR5YelHrKhE5cp
	 cS6Oy03pNvtvQ==
Date: Thu, 7 Mar 2024 20:39:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, conor.dooley@microchip.com,
	nayna@linux.ibm.com, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, jarkko@kernel.org,
	rnsastry@linux.ibm.com, peterhuewe@gmx.de, viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Message-ID: <20240307-cytoplasm-compare-6656aae737ac@spud>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse>
 <768fc5f1-3919-477e-a8e6-16a7e8536add@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDMXI+tGPlolqedq"
Content-Disposition: inline
In-Reply-To: <768fc5f1-3919-477e-a8e6-16a7e8536add@linux.ibm.com>


--IDMXI+tGPlolqedq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 10:11:03AM -0500, Stefan Berger wrote:
> On 3/7/24 05:41, Michael Ellerman wrote:
> > Stefan Berger <stefanb@linux.ibm.com> writes:

> >=20
> > Also adding the new linux,sml-log property should be accompanied by a
> > change to the device tree binding.
>=20
>=20
> See my proposal below.
>=20
> >=20
> > The syntax is not very obvious to me, but possibly something like?
> >=20
> > diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Docu=
mentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > index 50a3fd31241c..cd75037948bc 100644
> > --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > @@ -74,8 +74,6 @@ required:
> >     - ibm,my-dma-window
> >     - ibm,my-drc-index
> >     - ibm,loc-code
> > -  - linux,sml-base
> > -  - linux,sml-size
> >   allOf:
> >     - $ref: tpm-common.yaml#
> > diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Do=
cumentation/devicetree/bindings/tpm/tpm-common.yaml
> > index 3c1241b2a43f..616604707c95 100644
> > --- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> > @@ -25,6 +25,11 @@ properties:
> >         base address of reserved memory allocated for firmware event log
> >       $ref: /schemas/types.yaml#/definitions/uint64
> > +  linux,sml-log:
> > +    description:
> > +      Content of firmware event log
> > +    $ref: /schemas/types.yaml#/definitions/uint8-array
> > +
> >     linux,sml-size:
> >       description:
> >         size of reserved memory allocated for firmware event log
> > @@ -53,15 +58,22 @@ dependentRequired:
> >     linux,sml-base: ['linux,sml-size']
> >     linux,sml-size: ['linux,sml-base']
> > -# must only have either memory-region or linux,sml-base
> > +# must only have either memory-region or linux,sml-base/size or linux,=
sml-log
> >   # as well as either resets or reset-gpios
> >   dependentSchemas:
> >     memory-region:
> >       properties:
> >         linux,sml-base: false
> > +      linux,sml-log: false
> >     linux,sml-base:
> >       properties:
> >         memory-region: false
> > +      linux,sml-log: false
> > +  linux,sml-log:
> > +    properties:
> > +      memory-region: false
> > +      linux,sml-base: false
> > +      linux,sml-size: false
> >     resets:
> >       properties:
> >         reset-gpios: false
> >=20
> >=20
>=20
> I have been working with this patch here now and it passes the following
> test:
>=20
> make dt_binding_check dtbs_check DT_SCHEMA_FILES=3Dtpm/ibm,vtpm.yaml
>=20
>=20
> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> index 50a3fd31241c..cacf6c3082de 100644
> --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> @@ -74,8 +74,12 @@ required:
>    - ibm,my-dma-window
>    - ibm,my-drc-index
>    - ibm,loc-code
> -  - linux,sml-base
> -  - linux,sml-size
> +oneOf:
> +  - required:
> +      - linux,sml-base
> +      - linux,sml-size
> +  - required:
> +      - linux,sml-log
>=20
>  allOf:
>    - $ref: tpm-common.yaml#
> @@ -102,3 +106,21 @@ examples:
>              linux,sml-size =3D <0xbce10200>;
>          };
>      };
> +  - |
> +    soc {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        tpm@30000003 {
> +            compatible =3D "IBM,vtpm";
> +            device_type =3D "IBM,vtpm";
> +            reg =3D <0x30000003>;
> +            interrupts =3D <0xa0003 0x0>;
> +            ibm,#dma-address-cells =3D <0x2>;
> +            ibm,#dma-size-cells =3D <0x2>;
> +            ibm,my-dma-window =3D <0x10000003 0x0 0x0 0x0 0x10000000>;
> +            ibm,my-drc-index =3D <0x30000003>;
> +            ibm,loc-code =3D "U8286.41A.10082DV-V3-C3";
> +            linux,sml-log =3D <00 00 00 00 03 00 00>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> index 3c1241b2a43f..591c48f8cb74 100644
> --- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> @@ -30,6 +30,11 @@ properties:
>        size of reserved memory allocated for firmware event log
>      $ref: /schemas/types.yaml#/definitions/uint32
>=20
> +  linux,sml-log:
> +    description:
> +      firmware event log

Can you provide a more complete description here please as to what the
different between this and the other property? If I was populating a DT
I would have absolutely no idea whether or not to use this or the other
property, nor how to go about actually populating it.
The "log" in your example doesn't look like an actual log of any sort,
but I know nothing about TPMs so I'll take your word for it that that's
what a TPM log looks like.

> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +
>    memory-region:
>      description: reserved memory allocated for firmware event log
>      maxItems: 1
>=20
>=20
> Is my patch missing something?

I think you also need the dependantSchema stuff you had in your original
snippet that makes the linux,* properties mutually exclusive with
memory-region (or at least something like that).

Please make sure you CC the DT maintainers and list on the v2 and Lukas
Wunner too.

Thanks,
Conor.

--IDMXI+tGPlolqedq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeomFgAKCRB4tDGHoIJi
0rDjAQDCS+FWUSIjoa3pw2hIV6BHFi7ckp38kgze/iTx08jC2wD/Y6NcNqHRNxyH
uqytmYK1UqfYlV6C3HtkWQilNytz6QA=
=5EVs
-----END PGP SIGNATURE-----

--IDMXI+tGPlolqedq--

