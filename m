Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D617C8835
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjJMPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:01:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE5C0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6469EC433C7;
        Fri, 13 Oct 2023 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697209297;
        bh=XwBgXpXgYLg9MgD+nnnx88FLFxUjShjOXlnTqK+olfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOboIkdNWOEKjYfIskqC+u3bj27ujMsDVh9PHb/Hzjl4zAasVGX6FNlVirBn93CT7
         tr9GyiYMPJv3EBei09cmulhYfaQMMsKzvnrJx/l6bh88LzS48lIZPZwYvyePbMXvwE
         v7DK28FKj/PU4Dyeec4VEuxMJdSJS0S9S0OyDn/W89ubeQnui9DbH843eGJTMluf+X
         ox2IW/U6UXO2wYNS7jh/bfv2TjJxbXlHxiSRyzoXdOFRmN+pq3vt4KqSK8XRREHxgL
         A4WEsjrlCIFLwT13JPcSbjtF6H/0eN7FwbrF8lq6xF25p920TWYnCfC9n1LxMcMddM
         l9JqAlQfJVZmQ==
Date:   Fri, 13 Oct 2023 16:01:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     thomas.delev@amd.com, michal.simek@amd.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1
 master and MAINTAINERS entry
Message-ID: <20231013-blip-sheath-440f05d3767e@spud>
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0bXVZ/QeawNbrU3k"
Content-Disposition: inline
In-Reply-To: <20231013093109.37165-2-kris.chaplin@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0bXVZ/QeawNbrU3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 02:30:12AM -0700, Kris Chaplin wrote:
> Add YAML DT Schema for the AMD w1 master IP.
>=20
> This hardware guarantees protocol timing for driving off-board devices su=
ch
> as thermal sensors, proms, etc using the 1wire protocol.
>=20
> Add MAINTAINERS entry for DT Schema.
>=20
> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
> ---
>  .../bindings/w1/amd,axi-1wire-master.yaml     | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-ma=
ster.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.ya=
ml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> new file mode 100644
> index 000000000000..41f7294a84a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/w1/amd,axi-1wire-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD AXI 1-wire bus master for Programmable Logic

Inconsistent case for the title here bothers my OCD, but the binding is
fine as far as I can see.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +
> +maintainers:
> +  - Kris Chaplin <kris.chaplin@amd.com>
> +
> +properties:
> +  compatible:
> +    const: amd,axi-1wire-master
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    onewire@a0000000 {
> +        compatible =3D "amd,axi-1wire-master";
> +        reg =3D <0xa0000000 0x10000>;
> +        clocks =3D <&zynqmp_clk 0x47>;
> +        interrupts =3D <GIC_SPI 0x59 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b2c378b4fd9..6ec3922b256e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1066,6 +1066,13 @@ M:	Sanjay R Mehta <sanju.mehta@amd.com>
>  S:	Maintained
>  F:	drivers/spi/spi-amd.c
> =20
> +AMD W1 DRIVER
> +M:	Kris Chaplin <kris.chaplin@amd.com>
> +R:	Thomas Delev <thomas.delev@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/w1/amd,axi-1wire-master.yaml
> +
>  AMD XGBE DRIVER
>  M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
>  L:	netdev@vger.kernel.org
> --=20
> 2.42.GIT
>=20

--0bXVZ/QeawNbrU3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSlbywAKCRB4tDGHoIJi
0tHYAP4uAXwv3ro3wdcDxYLMpAqtbZ6nqRBVfA3Ai/RL7xr9vgD/VbV4jzbXlwRc
w7H6U85tITzD5uMAE7D5G/OhIU/1EAM=
=DJTU
-----END PGP SIGNATURE-----

--0bXVZ/QeawNbrU3k--
