Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB867FF125
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbjK3OFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345794AbjK3OFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:05:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF071B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:05:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A52C433C8;
        Thu, 30 Nov 2023 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353108;
        bh=lmIGpKWrJyGtIsNIsR54E9YSDqwPCFA4y8LfMhRheK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=STUxfY0mRk7um76FD5/rHkPm2ztlpi6k/23SFfFByJTfCbR1vyS5z3yel3e2eWO9a
         3ntX+q9LMyax8uzDlOX6ROZnAiqC+DErfFoYCU2aH2dOXFLiOCnDLU7T2/IyFTV7TO
         DPZKBfTNhASlgO5i0IdjK/TmS8ELPXrr5rZDnMl28ulftr+WTxB8BlYvf2dlkCBCnM
         ssX5AtKHdo0OV3IeBZPuH7rjrdsSd6PwtqmZSNizLyisS48kCd8KyvlsIXflO7ABOg
         jnSeI/AsywjB2WRTo2/kLi2RBsQr+JYYBZloviOZLzUdezNiPGs0cffFYGyXuJBOCl
         W5GwPvauUn2tw==
Date:   Thu, 30 Nov 2023 14:05:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v1 1/8] riscv: errata: Add StarFive JH7100 errata
Message-ID: <20231130-creed-fragrant-e0d91f125cb2@spud>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
 <20231126232746.264302-2-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ioHz8gwtxd+71Mjh"
Content-Disposition: inline
In-Reply-To: <20231126232746.264302-2-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ioHz8gwtxd+71Mjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:27:39AM +0100, Emil Renner Berthing wrote:
> This not really an errata, but since the JH7100 was made before
> the standard Zicbom extension it needs the DMA_GLOBAL_POOL and
> RISCV_NONSTANDARD_CACHE_OPS enabled to work correctly.
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/Kconfig.errata | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index e2c731cfed8c..692de149141f 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -53,6 +53,23 @@ config ERRATA_SIFIVE_CIP_1200
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config ERRATA_STARFIVE_JH7100
> +	bool "StarFive JH7100 support"
> +	depends on ARCH_STARFIVE && NONPORTABLE
> +	select DMA_GLOBAL_POOL
> +	select RISCV_DMA_NONCOHERENT
> +	select RISCV_NONSTANDARD_CACHE_OPS
> +	select SIFIVE_CCACHE
> +	default n
> +	help
> +	  The StarFive JH7100 was a test chip for the JH7110 and has
> +	  caches that are non-coherent with respect to peripheral DMAs.
> +	  It was designed before the Zicbom extension so needs non-standard
> +	  cache operations through the SiFive cache controller.
> +
> +	  Say "Y" if you want to support the BeagleV Starlight and/or
> +	  StarFive VisionFive V1 boards.
> +
>  config ERRATA_THEAD
>  	bool "T-HEAD errata"
>  	depends on RISCV_ALTERNATIVE
> --=20
> 2.40.1
>=20

--ioHz8gwtxd+71Mjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWiWbQAKCRB4tDGHoIJi
0u/jAQCrrpHJcB50JqgVgzMBgnx7WBxwRTTudybT8nQKUtYhFwD/cfgMwzTaZjJq
WBDq1ck0ck5FCB5pz9sJ3Wmfg/dAmg4=
=Mabv
-----END PGP SIGNATURE-----

--ioHz8gwtxd+71Mjh--
