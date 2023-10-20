Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F37D12EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377691AbjJTPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbjJTPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:36:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CF9AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:36:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D730CC433C8;
        Fri, 20 Oct 2023 15:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697816184;
        bh=s1xV3JBd6JIKm+NQbSAbEH6DMv5wORv7APbuEHALwfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNHvl4mYVct+XX8kx8UXf2TT0nVK+m3RiqBgFauhIyP34BfS24P6w3cN+sNYgh86L
         zIefFNd8SChjbE5mt0RcnCDDVnHQI9kiZ34N/Ndcb99gaYfbftUXfVN2jHE+rGi3tm
         n1WJoP51Ny99stXZhmuo1Jrobgy4wuqH2wA5OViwEeNmvPtRxtmTZNsEomW/GeuStz
         E56SShxBTIycb5PteKMvF+cjGSX68RZRJUltSn2U6mia4caFYA/aHgilLqBlYv75n1
         XaB4EfF6m1ZGVqn9pgmCTZdSpN7ahbLcycEwthBAeTyHfVar01kDyclkbMcSWk/O7u
         O/Z9xWkCKirLA==
Date:   Fri, 20 Oct 2023 16:36:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231020-shudder-tackle-cc98a82f1cd0@spud>
References: <20231020150022.48725-1-sebastian.reichel@collabora.com>
 <20231020150022.48725-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xK1bQfKTFhB0MwbA"
Content-Disposition: inline
In-Reply-To: <20231020150022.48725-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xK1bQfKTFhB0MwbA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:11:40PM +0200, Sebastian Reichel wrote:
> RK3588 has three DWC3 controllers. Two of them are fully functional in
> host, device and OTG mode including USB2 support. They are connected to
> dedicated PHYs, that also support USB-C's DisplayPort alternate mode.
>=20
> The third controller is connected to one of the combphy's shared
> with PCIe and SATA. It can only be used in host mode and does not
> support USB2. Compared to the other controllers this one needs
> some extra clocks.
>=20
> While adding the extra clocks required by RK3588, I noticed grf_clk
> is not available on RK3568, so I disallowed it for that platform.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/usb/rockchip,dwc3.yaml           | 60 +++++++++++++++++--
>  1 file changed, 55 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/D=
ocumentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index 291844c8f3e1..264c2178d61d 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -20,9 +20,6 @@ description:
>    Type-C PHY
>    Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
> =20
> -allOf:
> -  - $ref: snps,dwc3.yaml#
> -
>  select:
>    properties:
>      compatible:
> @@ -30,6 +27,7 @@ select:
>          enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>    required:
>      - compatible
> =20
> @@ -39,6 +37,7 @@ properties:
>        - enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>        - const: snps,dwc3
> =20
>    reg:
> @@ -58,7 +57,9 @@ properties:
>            Master/Core clock, must to be >=3D 62.5 MHz for SS
>            operation and >=3D 30MHz for HS operation
>        - description:
> -          Controller grf clock
> +          Controller grf clock OR UTMI clock
> +      - description:
> +          PIPE clock
> =20
>    clock-names:
>      minItems: 3
> @@ -66,7 +67,10 @@ properties:
>        - const: ref_clk
>        - const: suspend_clk
>        - const: bus_clk
> -      - const: grf_clk
> +      - enum:
> +          - grf_clk
> +          - utmi
> +      - const: pipe
> =20
>    power-domains:
>      maxItems: 1
> @@ -86,6 +90,52 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - $ref: snps,dwc3.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3328-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3

minItems for clocks and clock-names is already 3, is it not?

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +          maxItems: 4
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk
> +            - const: grf_clk
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          maxItems: 3
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-dwc3
> +    then:
> +      properties:
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk
> +            - const: utmi
> +            - const: pipe
> +
>  examples:
>    - |
>      #include <dt-bindings/clock/rk3328-cru.h>
> --=20
> 2.42.0
>=20

--xK1bQfKTFhB0MwbA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKecwAKCRB4tDGHoIJi
0nobAP9gB+qsHrTFsAFDJu4+fvKBpfSdY02kTL2MPTojpyy3eAD8C3SFcHdhD6T3
zRXBywGwE+6lPmCkSRVvQByGqxESRAk=
=vfSY
-----END PGP SIGNATURE-----

--xK1bQfKTFhB0MwbA--
