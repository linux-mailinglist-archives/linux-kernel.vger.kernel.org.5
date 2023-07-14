Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84637542D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbjGNSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGNSvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B62D6B;
        Fri, 14 Jul 2023 11:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6642A61CEA;
        Fri, 14 Jul 2023 18:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC148C433C7;
        Fri, 14 Jul 2023 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689360691;
        bh=75P5bsMunT6wijRx+XHlIke36CUI4vRQg315QeNciy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bx45JmWpw3YldzFhH5s6ix/Rdr46B/eBj7iAH367RmnbohY7JRDobL8hUeX0QE1KN
         KNP8spldtJRSz8iF7X2sx3IpZXAtOuMwpXe6cmm0R8FTLs99BcFRtDiu4a1dMwzzLo
         0wwTu1ijAw70sv/lB3BPPty4yS+6fWjN9lQWKZ8OH7+sVQBwRhS5spTQqbBqXVWM0B
         0jNrwkOGIRmXsfODczggwzths92xZqqUHA7a923G0fvVHcC1fBJZdTcpW4CgmnZn07
         bT8F4SfYnJFfPOSUdOZ8xVJYOmPs59277wdk6MPsw4y1bk5rozKtOBx25BjfthBx6e
         NKlSMBMPJCc3Q==
Date:   Fri, 14 Jul 2023 19:51:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] soc: microchip: Explicitly include correct DT includes
Message-ID: <20230714-handcart-batting-e805e7567231@spud>
References: <20230714175139.4067685-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jizOvC+TdPQbkhjW"
Content-Disposition: inline
In-Reply-To: <20230714175139.4067685-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jizOvC+TdPQbkhjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 11:51:38AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Hmm, usually these go to different places. I'll push them both to the
at91 repo.

> ---
>  drivers/soc/atmel/sfr.c                     | 1 -
>  drivers/soc/microchip/mpfs-sys-controller.c | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/soc/atmel/sfr.c b/drivers/soc/atmel/sfr.c
> index 0525eef49d1a..cc94ca1b494c 100644
> --- a/drivers/soc/atmel/sfr.c
> +++ b/drivers/soc/atmel/sfr.c
> @@ -10,7 +10,6 @@
>  #include <linux/nvmem-provider.h>
>  #include <linux/random.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> =20
> diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/mi=
crochip/mpfs-sys-controller.c
> index 216d9f4ea0ce..fbcd5fd24d7c 100644
> --- a/drivers/soc/microchip/mpfs-sys-controller.c
> +++ b/drivers/soc/microchip/mpfs-sys-controller.c
> @@ -13,7 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/jiffies.h>
>  #include <linux/interrupt.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
>  #include <linux/mailbox_client.h>
>  #include <linux/platform_device.h>
>  #include <soc/microchip/mpfs.h>
> --=20
> 2.40.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--jizOvC+TdPQbkhjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLGZLwAKCRB4tDGHoIJi
0jrYAQDw7C52D/rlhw9ADfh3Tidha+PsWlRE8UAzBK5ZyW8ZfAD+M+zjTm+uTux4
jG/xdu1L8A0cXPKX4J+cAJDgImqV5Aw=
=jETL
-----END PGP SIGNATURE-----

--jizOvC+TdPQbkhjW--
