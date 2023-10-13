Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A047C884F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJMPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjJMPH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:07:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C5CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:07:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603ACC433C7;
        Fri, 13 Oct 2023 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697209677;
        bh=dhX9Cz4CPdlTS15c30PJqSWT8Hhp5TTCXVK+ytwsF+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdS4R5qu/2CmE/A/7LWDaTOjVXe9stnWCGRS3hmJXHIOGqjNXPJ1Auge+RaBdJPf+
         QjAJye2oMUHKRQwNdCtGqE0d6/Qwc0iGVzvHu/dnUOImiA4Z3lXSd19b5OEZzWxvSO
         uQLTYYA//2o9MjVMkK6HYwiJRxCUdZ4zePrq4D5cE8dwdupPAOPOeXJdrPyguxQe7a
         xdxCSs57gRfobdSGacBkWhFZlcZk+rV9lXiB70tk/NZfp8TcMqEccyrl+zBVOmgG02
         lAY5Z4okTJCIzcxOeE1RT6M5Z3EfslthRBSub9lD2fzuxH6vz3N99oSrZKr/Igu257
         nfBdmpb69SSpA==
Date:   Fri, 13 Oct 2023 16:07:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kris Chaplin <kris.chaplin@amd.com>, thomas.delev@amd.com,
        michal.simek@amd.com, robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1
 master and MAINTAINERS entry
Message-ID: <20231013-january-caliber-2e7acbee15ec@spud>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D0eSubfO6C5kvNYG"
Content-Disposition: inline
In-Reply-To: <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D0eSubfO6C5kvNYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 05:04:32PM +0200, Krzysztof Kozlowski wrote:
> On 13/10/2023 11:30, Kris Chaplin wrote:
> > Add YAML DT Schema for the AMD w1 master IP.
> >=20
> > This hardware guarantees protocol timing for driving off-board devices =
such
> > as thermal sensors, proms, etc using the 1wire protocol.
> >=20
> > Add MAINTAINERS entry for DT Schema.
> >=20
> > Co-developed-by: Thomas Delev <thomas.delev@amd.com>
> > Signed-off-by: Thomas Delev <thomas.delev@amd.com>
> > Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
> > ---
> >  .../bindings/w1/amd,axi-1wire-master.yaml     | 44 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-=
master.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.=
yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> > new file mode 100644
> > index 000000000000..41f7294a84a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/w1/amd,axi-1wire-master.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD AXI 1-wire bus master for Programmable Logic
> > +
> > +maintainers:
> > +  - Kris Chaplin <kris.chaplin@amd.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: amd,axi-1wire-master
>=20
> That's a quite generic compatible. axi is ARM term, 1-wire is the name
> of the bus and master is the role. Concatenating three common words does
> not create unique device name. Compatibles are supposed to be specific
> and this is really relaxed. Anything can be over AXI, everything in
> 1wire is 1wire and every master device is a master.

Given the vendor (and the title of the binding) this is almost certainly
an FPGA IP core, so the generic name is understandable. Using the exact
name of the IP in the AMD/Xilinx catalog probably is the best choice?

--D0eSubfO6C5kvNYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSldSAAKCRB4tDGHoIJi
0sBKAP93WwQ4YTKSu7mJymnqveBhEtNSTuCJf8KJYNoJgZVzfAD9F0MIZhF1dKAC
2RQaPgWN8gVOs/24ipBDUWeEca2vAwY=
=VLV0
-----END PGP SIGNATURE-----

--D0eSubfO6C5kvNYG--
