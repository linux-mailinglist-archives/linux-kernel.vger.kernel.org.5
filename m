Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EB579D62E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjILQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjILQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:23:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA010E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:23:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0E8C433C8;
        Tue, 12 Sep 2023 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535825;
        bh=biFFduZ1C4O3DX/VQihj7MaVYd4W5bX5wM/9wVdt810=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR0fW+KyZ9Eq2rtV2L9yQcFxmU2NXDiOo79n6SCdi990t7zSmCIuZG918ca0p7ABi
         HNNtw2azE5jJFXaLQaX22cYrcDsAyq+PAys56QZSxuMgDCNUc9UB0PYSJkWwTwpM85
         VkOij5Kmo8l/L4TZP2XDxPEf/EWijK9XazVq7Zl83wawhRvW8GZ4zByo3/vY/nycSe
         TMPznE7kLaojYC4zRmND6QhDly+vTyOKMu/pUzMCey8iwzfRWT3JyYPU7dstmUSFul
         c/929Q+Ghwm2xBQUsYb1z+bhz+S3RyEU7ezTkcAFrHMJuaS/KW0BJP6RuQ+wsesqRu
         0iEJuyxKDEJTA==
Date:   Tue, 12 Sep 2023 17:23:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jinyu Tang <tangjinyu@tinylab.org>
Cc:     william.qiu@starfivetech.com, hal.feng@starfivetech.com,
        conor.dooley@microchip.com, palmer@dabbelt.com,
        apatel@ventanamicro.com, ttjjyystupid@163.com, falcon@tinylab.org,
        wangjiexun@tinylab.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: defconfig : add CONFIG_MMC_DW for starfive
Message-ID: <20230912-breeching-zealous-84c859e90eb7@spud>
References: <20230912133128.5247-1-tangjinyu@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tOfKvfF/NMI329BY"
Content-Disposition: inline
In-Reply-To: <20230912133128.5247-1-tangjinyu@tinylab.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tOfKvfF/NMI329BY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 09:31:28PM +0800, Jinyu Tang wrote:
> If these config not set, mmc can't run for jh7110, rootfs can't
> be found when using SD card. So set CONFIG_MMC_DW=3Dy like arm64
> defconfig, and set CONFIG_MMC_DW_STARFIVE=3Dy for starfive. Then
> starfive vf2 board can start SD card rootfs with mainline defconfig
> and dtb.
>=20
> Signed-off-by: Jinyu Tang <tangjinyu@tinylab.org>


Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> v1 -> v2:
> Change the order of these by using savedefconfig, thanks to
> Conor Dooley.
>=20
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ab86ec3b9..76c43a532 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -169,6 +169,8 @@ CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
>  CONFIG_MMC_SDHCI_CADENCE=3Dy
>  CONFIG_MMC_SPI=3Dy
> +CONFIG_MMC_DW=3Dy
> +CONFIG_MMC_DW_STARFIVE=3Dy
>  CONFIG_MMC_SUNXI=3Dy
>  CONFIG_RTC_CLASS=3Dy
>  CONFIG_RTC_DRV_SUN6I=3Dy
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--tOfKvfF/NMI329BY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCQjQAKCRB4tDGHoIJi
0unBAQDNHlf3rnnuIDjF1ENKvc6GsCR/WCMXJ+6S2YLmJ5M8QQD9HQzsZqQnlVZc
fOvWx1ylOXG7jDJHiIh+c39+luEFBAY=
=6mo+
-----END PGP SIGNATURE-----

--tOfKvfF/NMI329BY--
