Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35637E4AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344003AbjKGVhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKGVhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:37:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A363010E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:37:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE309C433C8;
        Tue,  7 Nov 2023 21:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699393020;
        bh=WVHuwAsOTOgCpgWq5u1CL+9mVSJ7u1AEg+A8bUKFufw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOMjw7cwGgOFP2GVMJmbAwiPe5MYA9xXrjD0OGhHShaZ1r9eluhn88ZljGrCss2El
         HoBZzch39wsweFWdDWU5hkLq+IKIy240MpLi8Ipu5zCEJYwEqAVbDo/eIj5KQUL1Sk
         OOqUJMTH7R8moFajz7CuqJdl/+eIml8b1+Bnnlw377DbjmH979sNQRAj6ViFv3Vfzh
         hu8sok7PI0Ml0YebkAUu4XVIcwOXVpGE8NksbG9JunlP4G5ESPAuL1Y0NeI/f6m4CI
         5bF5faKg+jWy7G4yAGxyyFh19NZlFZ6OJ9WOyvHKj/Z8zFmk19QyfRbf171pySTOzD
         ubcABA7joDzAg==
Date:   Tue, 7 Nov 2023 21:36:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        palmer@dabbelt.com
Subject: Re: [PATCH] dt-bindings: soc: Add new board description for
 MicroBlaze V
Message-ID: <20231107-darkening-daylong-deef34169798@spud>
References: <50c277c92c41a582ef171fb75efc6a6a4f860be2.1699271616.git.michal.simek@amd.com>
 <20231106-hangnail-prankster-a04e713bed35@spud>
 <4223470c-5596-4168-9c89-e701559fbbed@amd.com>
 <e9fef49e-c0ca-4f7d-9618-151216e25280@linaro.org>
 <92d95425-5bae-4ada-8fc3-966e7bfbd815@amd.com>
 <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ao6O2bmitc7/nT1o"
Content-Disposition: inline
In-Reply-To: <90f9991e-26a3-498e-9449-c96663987459@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ao6O2bmitc7/nT1o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Palmer

On Tue, Nov 07, 2023 at 01:38:15PM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2023 13:09, Michal Simek wrote:
> > On 11/7/23 12:27, Krzysztof Kozlowski wrote:
> >> On 07/11/2023 12:09, Michal Simek wrote:
> >>> On 11/6/23 18:07, Conor Dooley wrote:
> >>>> On Mon, Nov 06, 2023 at 12:53:40PM +0100, Michal Simek wrote:

> >>>>> +description: |
> >>>>> +  AMD boards with MicroBlaze V SOC
> >>>>> +
> >>>>> +properties:
> >>>>> +  $nodename:
> >>>>> +    const: '/'
> >>>>> +  compatible:
> >>>>> +    oneOf:
> >>>>> +      - description: AMD MicroBlaze V
> >>>>> +        items:
> >>>>> +          - const: amd,mbv
> >>>>
> >>>> You don't actually list any boards here, but instead permit having o=
nly
> >>>> the SoC compatible and no board one. The SoC compatible is also
> >>>> incredibly generic. Personally I don't think this binding makes any
> >>>> sense as it appears to exist as a catch all for anything using your
> >>>> new cores in any combination.
> >>>
> >>> I think I need to define any string for compatibility because it is s=
tandard
> >>> property. Because this is soft core it can be added to any board with=
 AMD/Xilinx
> >>> chip. I don't have really an option to list all boards.
> >>
> >> Why? Either there is a product with this soft-core or there is not. It
> >> cannot be both.
> >=20
> > I am doing basic enablement. I am not making product. Product will be d=
one by=20
> > our customers using this core.
> > There will be thousands of different configurations done by customers w=
hich will=20
> > have products with it. Also there could be hundreds configurations done=
 on the=20
> > same board.
>=20
> If this is the same board, then why there is compatible for it?
>=20
> >=20
> > Does it make sense to have board related compatible string like this if=
 this=20
> > evaluation board is used by a lot of customers?
> > "amd,kcu105-mbv-ABC-vXYZ", "amd,kcu105-mbv", "amd,mbv"
>=20
> I miss the point what is the hardware. Evaluation board is the hardware.
> If someone changes it and makes a new product, it is a new product.

To me, this does actually make (some) sense.
The first compatible is "soc" + board + design.
The second is "soc" + board.
The final one is the "soc".

I say "soc" though, because it is not a single soc - it could be any
configuration of these soft AMD cores on an FPGA in any quality,
possibly set up heterogeneously too. I don't think trying to define a
generic compatible for it like this makes sense as the soc part does
not come close to identifying a specific device.

Until someone actually creates a product that ships with this, I don't
think it makes sense to try and define a binding.

I spoke to Palmer a bit about this, and what I think would make sense is
if you had some sort of "reference design" bitstream that people could
download and run on xyz AMD devkit. If that existed, then we could
document that configuration etc. Otherwise you're in the same spot that
a lot of IP vendor stuff is, where without there being something that
qualifies as "real hardware" using the core, it doesn't make sense to
try and create bindings etc. It's the same for the various people in
the RISC-V community that created their own CPUs that they run on FPGAs.

> > Or I can define qemu one.
> > "amd,qemu-mbv", "amd,mbv"
>=20
> QEMU is not hardware, so not.
>=20
> >=20
> > I think customers should be adding their compatible string in front of =
generic one.
>=20
> To what? To evaluation board? Why?
>=20
> >=20
> > Years ago I have done the same thing with Microblaze where compatible i=
s defined=20
> > as xlnx,microblaze only.=20
>=20
> Again, what is the use of such binding?
>=20
> > When customer take this soft core, put IPs around and=20
> > create a product they should extend it to be for example like this.
> > "xyz,my-product-1.0", "xlnx,microblaze";
>=20
> So there is a product, not evaluation board.
>=20
> >=20
> > And over all of years I have never seen any single customer to try to p=
ush dt=20
> > description for any Microblaze based product.
> >=20
> >>>
> >>> I am happy to change it to something else but not sure to what.
> >>
> >> Alone this compatible does not bring you anything.
> >=20
> > I don't agree with it. It is standard property and I have to define it =
somehow.
>=20
> The property is already defined, you do not have to define it. What you
> define here is the value for compatible. Why do you need to define it
> somehow? Who asks for that?
>=20
> > If not, I get an error.
> > .../xilinx-mbv32.dtb: /: 'compatible' is a required property
>=20
> So you have a board? The patches must be linked to each other, e.g.
> preferred way is to send them in one patchset.

There were patches sent to U-Boot for an example configuration:
https://lore.kernel.org/u-boot/d488b7016e0d1b1324c64d8a8b2f033851aab6c6.169=
9271804.git.michal.simek@amd.com/

> > And it tells me that this risc-v compatible core runs on AMD fpga and i=
t is=20
> > compatible with it.

Basically, it provides no more specific information than the cpu node
does. From me, it's a NAK for a compatible like this that that permits
using it in isolation for any core configuration and combination.

Cheers,
Conor.



--Ao6O2bmitc7/nT1o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUqt9wAKCRB4tDGHoIJi
0oAiAP9JzV4b2GyfDh/zwrcYZfB6dXpoGDIqlwE6XX5chvzZ0AEA6Lg7BBpd1xNJ
8HkpNTmeOhZy813/Tl5dkxb3sFDldQM=
=UR+u
-----END PGP SIGNATURE-----

--Ao6O2bmitc7/nT1o--
