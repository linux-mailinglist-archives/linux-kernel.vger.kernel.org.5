Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9C759AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGSQhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGSQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6F2717;
        Wed, 19 Jul 2023 09:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE14C61789;
        Wed, 19 Jul 2023 16:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F60C433C8;
        Wed, 19 Jul 2023 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689784586;
        bh=T67KVuMsXJyOHPpyRG/bF4u+lVYth3Zf4FyYGoex53A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3ZdEYbupgVsJzit/TJjMBMI1pQ8pnMPk2eY2TJHizVHcRhCCIs2G6wSKmru9CuYg
         ruEp67kxjdVKQIPZVkMwSI6CdpryX0NZpAYAhYUDUruC6T9xnyuEMf2dXWHR4kmH3k
         ewV2JPjapcDFamJ7uVoBOsUQ5oUAjoqYdB8sIQD9OXmyPECcbB7PxQXvDBxym+NuMm
         J5WscmACVaQfmSU4drA+8IVI/cCN8A5AHBdzlsBrYvP5My+3Cg3Ej9st3hAK9Jtp6S
         uvKnK/Cg/MX8z/aNRtrEtQAbBROe2du8KC3a2UsYabJm5jWi4G3npRk+0opcqGD520
         SgmaXBE+V5bjg==
Date:   Wed, 19 Jul 2023 17:36:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
        git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Message-ID: <20230719-sizzling-heaving-bc802f2ed2ae@spud>
References: <20230719061808.30967-1-pranavi.somisetty@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZZlRDUsAAGIHGb0l"
Content-Disposition: inline
In-Reply-To: <20230719061808.30967-1-pranavi.somisetty@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZZlRDUsAAGIHGb0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 12:18:08AM -0600, Pranavi Somisetty wrote:
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
>=20
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
> Changes v2:
> 1. Changed description for the property "reg".
> 2. Added a reference to the description of "phy-handle" property.

Seems fine to me, one /minor/ nit that I don't expect to be addressed.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yam=
l b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> new file mode 100644
> index 000000000000..9d22382a64ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml

> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        phy: ethernet-phy@0 {
> +            reg =3D <0>;
> +        };
> +        gmiitorgmii@8 {
> +            compatible =3D "xlnx,gmii-to-rgmii-1.0";
> +            reg =3D <8>;
> +            phy-handle =3D <&phy>;
> +        };

Ideally, add a blank line before child nodes.

> +    };
> --=20
> 2.36.1
>=20

--ZZlRDUsAAGIHGb0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgRBQAKCRB4tDGHoIJi
0pFDAQCmtiE2GnotCBnhox3kae5HrWkNtj3/Tv6uGBwnTLajtAEAiiBsXMRS3sfZ
PMfmBowd0X1+f9ihnG6IfCkO/fQ2pgg=
=Asfq
-----END PGP SIGNATURE-----

--ZZlRDUsAAGIHGb0l--
