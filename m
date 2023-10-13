Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B297C8879
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJMPUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:20:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6882BBD;
        Fri, 13 Oct 2023 08:19:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D88C433C8;
        Fri, 13 Oct 2023 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697210399;
        bh=Ys/cvxFKhwCwYOjOvCw9T7BfPly1K4cJ+M/3bmQc+Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZqDUehC0aiPe3EqQfvthVAkOux7as2LZtQj4BGg5keUgoxhnb10bkvYC6qhQBOGl
         y5k5MH0xIO1alBElMbWWaTIRylCkKD7AR17m6xRp5XhjAVPczx4AczzcyzHEWyN5At
         Z90jnuNAqWpE/RA/0Jl+u0jBG6lEavH3x79l8jzV27akEMFd35AaVJUxUxhRsjlhq3
         09iXnLNhhpnLQlenhk6V6b7igix4Uq7Uez7kr503GQ02lkcJd90PwbWq0vULZ7ldSH
         PB2GoZ1B5bWWQJK2JhLjDoOASbKnmJM056xyx7+v85GI3dd85NRVmTNB7kVeEFbxTJ
         TUFymO0A4PIUQ==
Date:   Fri, 13 Oct 2023 16:19:54 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kernel@puri.sm, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: imu: st,lsm6dsx: add mount-matrix
 property
Message-ID: <20231013-violin-craziness-f63d75ce0116@spud>
References: <20231012142041.253332-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P8B0cjiJh5K8TxQ1"
Content-Disposition: inline
In-Reply-To: <20231012142041.253332-1-martink@posteo.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P8B0cjiJh5K8TxQ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 02:20:41PM +0000, Martin Kepplinger wrote:
> Add the mount-matrix optional property to the binding since it's supported
> and very useful when using the chip on a board.
>=20
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Cnor.

> ---
>=20
> revision history
> ----------------
> v2: (thanks Jonathan)
> * remove the addition to the example to avoid unrelated discussions :)
>=20
> v1:
> https://lore.kernel.org/linux-devicetree/20230721103410.575555-1-martink@=
posteo.de/
>=20
>=20
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/=
Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index ee8724ad33ab..28b667a9cb76 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -93,6 +93,9 @@ properties:
>    wakeup-source:
>      $ref: /schemas/types.yaml#/definitions/flag
> =20
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.39.2
>=20

--P8B0cjiJh5K8TxQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSlgGgAKCRB4tDGHoIJi
0oBKAQCus90abVTh797fUK9MBhVX7IgtB22InyoFl27Oq5aaBAD9Ho4MoB2mpS/+
swxyv+swXVpmsEWkggAahOhWsfJ1CQg=
=+Hu7
-----END PGP SIGNATURE-----

--P8B0cjiJh5K8TxQ1--
