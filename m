Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2797A292F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbjIOVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbjIOVPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C73E10FA;
        Fri, 15 Sep 2023 14:13:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CA0C433B8;
        Fri, 15 Sep 2023 21:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694812424;
        bh=kwVCyuwmCscgtotgsB8jD0n68jkFaEcgtBnaGBUyKyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZhw53fzrT82yheV0xnWJ4/g9w/sF2neiZIgmuEA2lPaoIL+qnAI4893sV+R+QBYa
         xGBrDRfBrV+A/FDCHy+Stqg5vRzT4P5R+9jUiLMGEoPx+sNGa96SWHal/EYFDOmruw
         gc7jfrlUoPUFPMy3Nxa+btuYCpGFV2yBhnwAlftc4lRV8A54w0ngTKPZInD2uagTs6
         saFeY1zZVYq6eXFd6UL1BI+50zIbYb0j2D3T6Nm8/sLg+TeVMJEZRJ8vbHS2qk0GFI
         KH34abVCB+l9LJscenUJWiPiqza9jrRrtI3PHtJIuNYuCW8Uo4fnD0DC9h3KdhZ6Of
         mT1dAZPIIokvQ==
Date:   Fri, 15 Sep 2023 22:13:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: dt-bindings: media: i2c: Add ROHM
 BU64754 bindings
Message-ID: <20230915-starch-bankable-c4102e405a73@spud>
References: <20230915165946.4183839-1-kieran.bingham@ideasonboard.com>
 <20230915165946.4183839-2-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kq4SaRLaezFRFdFr"
Content-Disposition: inline
In-Reply-To: <20230915165946.4183839-2-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kq4SaRLaezFRFdFr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Fri, Sep 15, 2023 at 05:59:45PM +0100, Kieran Bingham wrote:
> Add YAML device tree bindings for the ROHM BU64754 VCM Motor Driver for
> Camera Autofocus.
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../bindings/media/i2c/rohm,bu64754.yaml      | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/rohm,bu64=
754.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/rohm,bu64754.yam=
l b/Documentation/devicetree/bindings/media/i2c/rohm,bu64754.yaml
> new file mode 100644
> index 000000000000..22da4a46bb0c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/rohm,bu64754.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2023 Ideas on Board Oy.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/rohm,bu64754.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BU64754 Actuator Driver for Camera Autofocus
> +
> +maintainers:
> +  - Kieran Bingham <kieran.bingham@ideasonboard.com>
> +
> +description: |

That | is surplus to requirements since you have no formatting to
preserve.

> +  The BU64754 is an actuator driver IC which can control the actuator
> +  position precisely using an internal Hall Sensor.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rohm,bu64754

Why such a complicated pattern when you only have one item here?
Why not just const: rohm,bu64754?

Otherwise, looks fine to me.

--kq4SaRLaezFRFdFr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTJBAAKCRB4tDGHoIJi
0pX7APoD4Kw9SlBLfhiuKvhkDRf+fTvAqfbXIgomg0v8+f45SAD/c6EsQdkx35AK
UEbTPbXlg9E1wyDB8q8C/ELFMgIXJQk=
=bR/q
-----END PGP SIGNATURE-----

--kq4SaRLaezFRFdFr--
