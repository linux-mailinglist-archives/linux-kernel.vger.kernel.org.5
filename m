Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA175813D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGRPqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjGRPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E344AA9;
        Tue, 18 Jul 2023 08:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79B1D61644;
        Tue, 18 Jul 2023 15:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3494C433C7;
        Tue, 18 Jul 2023 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689695206;
        bh=76mVnJR9o74Ma8KmtRmvfVhR/CCcRdmixqoJDHlIGzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTqoea1e4JsUd0SgXsF3R8CUlUt42gzMufzNo8YkXur/QdtUJdJ5jhWDr5UneKhQy
         JLxl3nBJQM80I/OEH5dR+H6AJTnJl9pUcsh7ioARJ1EbCqtgsiZgfUFyvcKkLGV93V
         zLJ7K/I2ho+eoF1XcUZhSPCLd9k9edyAGCXX/cpl10COVm2lsY3afE/Et/KI+McnaH
         /s+h6dNU5sXUu4N5BI7p5Buf1GYxt0YALSvDPaC7/xWplza8Cqqv0cqeyYoF/hS8vR
         Y/aHDeQMGt38kLsWeviLvYz7tGi6C5cGJmdmHpslvjVR1xz5pyopZ/PjLwHMpik1sX
         hJYpV6TyUgSOQ==
Date:   Tue, 18 Jul 2023 16:46:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: nand-controller: add
 nand-skip-bbtscan and nand-no-bbm-quirk DT options
Message-ID: <20230718-curfew-jumble-aeafe95c5cc7@spud>
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+7otubzjJ6EFgf8c"
Content-Disposition: inline
In-Reply-To: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7otubzjJ6EFgf8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2023 at 12:48:16PM +0200, Johan Jonker wrote:
> A NAND chip can contain a different data format then the MTD framework
> expects in the erase blocks for the Bad Block Table(BBT).
> Result is a failed probe, while nothing wrong with the hardware.
> Some MTD flags need to be set to gain access again.
>=20
> Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
> so that the original content is unchanged during the driver probe.
> The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
> the nand_erase_nand() function and the flash_erase command.
>=20
> Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
> so the user has the "freedom of choice" by neutral
> access mode to read and write in whatever format is needed.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> Previous discussion:
> [PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
> https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMa=
il.zimbra@nod.at/
> ---
>  .../devicetree/bindings/mtd/nand-controller.yaml    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b=
/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index f70a32d2d9d4..ca04d06a0377 100644
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@ -103,6 +103,19 @@ patternProperties:
>            the boot ROM or similar restrictions.
>          $ref: /schemas/types.yaml#/definitions/flag
>=20
> +      nand-no-bbm-quirk:
> +        description:
> +          Some controllers with pipelined ECC engines override the BBM m=
arker with
> +          data or ECC bytes, thus making bad block detection through bad=
 block marker
> +          impossible. Let's flag those chips so the core knows it should=
n't check the
> +          BBM and consider all blocks good.
> +        $ref: /schemas/types.yaml#/definitions/flag

While this seems okay, as it seems to describe facet of the hardware...

> +      nand-skip-bbtscan:
> +        description:
> +          This option skips the BBT scan during initialization.
> +        $ref: /schemas/types.yaml#/definitions/flag

=2E..this seems to be used to control the behaviour of software, and does
not describe the underlying hardware.

Maybe I'm off, but the description of the property does not hint at the
aspect of the hardware that this addresses.

Thanks,
Conor.

> +
>        nand-rb:
>          description:
>            Contains the native Ready/Busy IDs.
> --
> 2.30.2
>=20

--+7otubzjJ6EFgf8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLaz4gAKCRB4tDGHoIJi
0g3xAPoCChSgHtJm/s66HpBbvjdcQLRTQYdBP7qBc021LHTnKAD+ML/axLivhd8k
t9BrKrTs3wFm05P8sJkqLPbYdU9C5gg=
=07DA
-----END PGP SIGNATURE-----

--+7otubzjJ6EFgf8c--
