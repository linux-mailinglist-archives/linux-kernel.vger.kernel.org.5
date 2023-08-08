Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218CA7747F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjHHTWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjHHTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA1310E9C8;
        Tue,  8 Aug 2023 09:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E096624A6;
        Tue,  8 Aug 2023 10:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F57C433C8;
        Tue,  8 Aug 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691491687;
        bh=g4Al6u/oxW9sOdVO40WZiYWYztfE/tWlGU1STUdbHRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsIaGXcA79+KRvi55vDwZcaycKr5Mc/tVkLjU9fnNOY0UZLyw4vPkks1ugyvNMdZv
         srirx/T+v64qvDgrub2wSDxGiS/PYNi3uuTSQoz89p7MJQy3+2poNJRzUWKNVWRLpg
         wQP0U7Mdof49bv8EQ0mxaWPbO00xd64PzEDXDyLSCKUw1N6Kwpdr+2B21tHFn1aTwp
         E2oma7Au+eu76VP9dHf8q2a11dhwdmCzggYmbElo7c2WGOjSEHsYn3sM6kZdXQeANH
         EvYNDPEwf6tVZEpntFzO6jB/RyIpiIdleHwr0hQTx3SD77GNmeoiHOgVaKiRK8405H
         RaOFRZFBn8QcQ==
Date:   Tue, 8 Aug 2023 11:48:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>, Suman Anna <s-anna@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Message-ID: <20230808-unwomanly-generic-67d20f0e51cd@spud>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RzfM45YTf9+4RvqO"
Content-Disposition: inline
In-Reply-To: <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RzfM45YTf9+4RvqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 03:14:31PM +0530, Md Danish Anwar wrote:
> Hi Conor,
>=20
> On 07/08/23 8:09 pm, Conor Dooley wrote:
> > On Mon, Aug 07, 2023 at 04:38:36PM +0530, MD Danish Anwar wrote:
> >> Add interrupts and interrupt-names protperties for PRU and RTU cores.
> >>
> >> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >> ---
> >>  .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 +++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc=
=2Eyaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >> index cd55d80137f7..6970316943bb 100644
> >> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >> @@ -66,6 +66,16 @@ properties:
> >>        Should contain the name of the default firmware image
> >>        file located on the firmware search path.
> >> =20
> >> +  interrupts:
> >> +    maxItems: 1
> >> +    description:
> >> +      Interrupt specifiers enable the virtio/rpmsg communication betw=
een MPU
> >> +      and the PRU/RTU cores.
> >> +
> >> +  interrupt-names:
> >> +    items:
> >> +      - const: vring
> >> +
> >>  if:
> >>    properties:
> >>      compatible:
> >> @@ -171,6 +181,9 @@ examples:
> >>                <0x22400 0x100>;
> >>          reg-names =3D "iram", "control", "debug";
> >>          firmware-name =3D "am65x-pru0_0-fw";
> >> +        interrupt-parent =3D <&icssg0_intc>;
> >> +        interrupts =3D <16 2 2>;
> >> +        interrupt-names =3D "vring";
> >>        };
> >=20
> > These examples would probably be more helpful if they used the
> > appropriate defines, no?
> >=20
>=20
> PRUSS Interrupt controller doesn't have any appropriate defines. This doe=
sn't
> use GIC so defines from arm-gic.h can not be used here. These are specifi=
c to
> PRUSS INTC.

I was deliberately vague in case the gic stuff applied too, but my main
question was about the standard defines used for interrupt types.

> I think these example are OK. Please let me know if this is OK to you.

--RzfM45YTf9+4RvqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIdYgAKCRB4tDGHoIJi
0sfFAQDUGTaUH2VxL1ST+sf18hKE5yCqpFEUkOJu+bgGPLkmuQD/XAUCs4HrdF2v
1lu3PdJ0QSaQoDb36Qrpa6k3hHGvUQg=
=l++a
-----END PGP SIGNATURE-----

--RzfM45YTf9+4RvqO--
