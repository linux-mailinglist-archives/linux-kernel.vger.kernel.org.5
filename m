Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8BD79F11F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjIMSad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMSab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:30:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA11BC6;
        Wed, 13 Sep 2023 11:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB50C433C7;
        Wed, 13 Sep 2023 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694629827;
        bh=31I+vvfgxK2RhSOo9RhuKS344PF5cuX3/n6t1MBZpzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCFNq3tlLXBYEdwM2SebVUys4XPCNqAteJLX8meljGy/43fW9KgqlC5NrbO/EK9VX
         nB8jd6URfw0oaYQXALu8Id/brV27/zfSdcCMdAaohnUnGG2BAt3l7M6r5zyCR/072a
         FjSI1Zw1fwB01Hwe5scQfa9WnHJ8oDLEibDp0LYrYSSAxhPjj0AxNFI0XZJjbWkj1v
         a84rr5RFBuSSvgHUNXInn69Je4vSP4lFSawZ/p8fPiwQEjCRJmdCICyjjwN4uTc84Y
         Aq+Nf2tzKXlqmWdAZVYmsSGknWTlDyntQqblNoS7mbVaVSNo0AglWbi/sn61UZ0eIT
         BmBQu0zWuUEgw==
Date:   Wed, 13 Sep 2023 19:30:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: Add Mstar SSD202D RTC
Message-ID: <20230913-depress-bootlace-6b88bfd83966@spud>
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zSIJHToUSvODMYzW"
Content-Disposition: inline
In-Reply-To: <20230913151606.69494-3-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zSIJHToUSvODMYzW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 05:16:05PM +0200, Romain Perier wrote:
> Add YAML bindings for Mstar SSD202D RTC.
>=20
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  .../bindings/rtc/mstar,ssd202d-rtc.yaml       | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/mstar,ssd202d-r=
tc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml=
 b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> new file mode 100644
> index 000000000000..4c1f22ef5a2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/mstar,ssd202d-rtc.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/mstar,ssd202d-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mstar SSD202D Real Time Clock
> +
> +maintainers:
> +  - Daniel Palmer <daniel@0x0f.com>
> +  - Romain Perier <romain.perier@gmail.com>
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mstar,ssd202d-rtc
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

So, this seems fine to me in isolation, but isn't this now the sort of
thing that can be documented in trivial-rtc.yaml?
Its only got compatible & reg, which seems to fit the bill for that.

Apologies if I am missing something,
Conor.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    rtc@6800 {
> +        compatible =3D "mstar,ssd202d-rtc";
> +        reg =3D <0x6800 0x200>;
> +    };
> +...
> --=20
> 2.39.2
>=20

--zSIJHToUSvODMYzW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQH/vgAKCRB4tDGHoIJi
0kNuAPsEvE8AqBxe+MoFCB0pt3YnCSej+vAgfRprRQ+KRYy1yQD+Lzs9ukZ+5ELi
q1HOYU3/VRN5LYUIQ75IqFUXkGmnXAA=
=Oj2N
-----END PGP SIGNATURE-----

--zSIJHToUSvODMYzW--
