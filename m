Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E251877429A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjHHRq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjHHRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1F9005;
        Tue,  8 Aug 2023 09:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8A74624D4;
        Tue,  8 Aug 2023 11:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF5CC433C8;
        Tue,  8 Aug 2023 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494108;
        bh=UkivAZmLW9i4huYTFXBK1YV0BryRlhOAytfJztzlggU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ97j+5hLGMVbKHdZ1aViwNCvIbQgg/S4qMWRigfT01dPG1Vgt0pod5bCV01KlhCF
         BvXzq0suUk+PXfRLLZE0JUfG1i4EirOSb3gBQjc+/dZjEL6IACywl3JXwyQtNtEX1/
         LCtoht/QdFfiEkLInSeta+ki3qbeB3QJ9wPHEHXLZ585G8ei3+jn2IhPLVJ92/DOZj
         rn5l+5kXMEEFl6hctodJT7YHMHHPXDNy3ks9K6zDJwONIeFhljJuUJ2hAjOKN9OTD+
         kw1yHnBoeZx0iuHp6rk0FJWBVxDBYsweTNPDpRYM7blAT8ebE+mmPlfrJnIOjz1m9F
         xwNHfa4Qv9lyw==
Date:   Tue, 8 Aug 2023 12:28:22 +0100
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
Message-ID: <20230808-bazooka-uncoated-a3401d94b063@spud>
References: <20230807110836.2612730-1-danishanwar@ti.com>
 <20230807-euphemism-trailing-ef4130dc7437@spud>
 <910a4a98-712a-5517-5a5b-ffb962f83463@ti.com>
 <20230808-unwomanly-generic-67d20f0e51cd@spud>
 <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NwSvyREEgDmJNJA5"
Content-Disposition: inline
In-Reply-To: <cd74e31f-8bc6-445b-9c33-51e53a439cd2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NwSvyREEgDmJNJA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 04:30:32PM +0530, Md Danish Anwar wrote:
> On 08/08/23 4:18 pm, Conor Dooley wrote:
> > On Tue, Aug 08, 2023 at 03:14:31PM +0530, Md Danish Anwar wrote:
> >> On 07/08/23 8:09 pm, Conor Dooley wrote:
> >>> On Mon, Aug 07, 2023 at 04:38:36PM +0530, MD Danish Anwar wrote:
> >>>> Add interrupts and interrupt-names protperties for PRU and RTU cores.
> >>>>
> >>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>>> ---
> >>>>  .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 ++++++++++++++++=
+++
> >>>>  1 file changed, 22 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rpr=
oc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >>>> index cd55d80137f7..6970316943bb 100644
> >>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> >>>> @@ -66,6 +66,16 @@ properties:
> >>>>        Should contain the name of the default firmware image
> >>>>        file located on the firmware search path.
> >>>> =20
> >>>> +  interrupts:
> >>>> +    maxItems: 1
> >>>> +    description:
> >>>> +      Interrupt specifiers enable the virtio/rpmsg communication be=
tween MPU
> >>>> +      and the PRU/RTU cores.
> >>>> +
> >>>> +  interrupt-names:
> >>>> +    items:
> >>>> +      - const: vring
> >>>> +
> >>>>  if:
> >>>>    properties:
> >>>>      compatible:
> >>>> @@ -171,6 +181,9 @@ examples:
> >>>>                <0x22400 0x100>;
> >>>>          reg-names =3D "iram", "control", "debug";
> >>>>          firmware-name =3D "am65x-pru0_0-fw";
> >>>> +        interrupt-parent =3D <&icssg0_intc>;
> >>>> +        interrupts =3D <16 2 2>;
> >>>> +        interrupt-names =3D "vring";
> >>>>        };
> >>>
> >>> These examples would probably be more helpful if they used the
> >>> appropriate defines, no?
> >>>
> >>
> >> PRUSS Interrupt controller doesn't have any appropriate defines. This =
doesn't
> >> use GIC so defines from arm-gic.h can not be used here. These are spec=
ific to
> >> PRUSS INTC.
> >=20
> > I was deliberately vague in case the gic stuff applied too, but my main
> > question was about the standard defines used for interrupt types.
> >=20
>=20
> There are no standard defines for these interrupt types. However I can cr=
eate a
> new .h file defining all the three interrupt cells and their values for b=
oth
> PRU and RTU cores if you think that is required. Otherwise we can go with
> hardcoded values.
>=20
> Please let me know what you think should be done here.

It'd be good to reference to the documentation for the cells, I don't
think adding a header is necessary here.

Thanks,
Conor.

--NwSvyREEgDmJNJA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIm1gAKCRB4tDGHoIJi
0tOtAQCfCBZovM5h/DFSNCYnfyXE2fsxd2ohVBEMEPk/DVcwhgD/Q16z85gw+G0U
S6cjm/OHhUkYWI+it8xAji3FtYYPCwY=
=oc4g
-----END PGP SIGNATURE-----

--NwSvyREEgDmJNJA5--
