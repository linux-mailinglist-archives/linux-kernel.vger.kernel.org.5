Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90E5790787
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbjIBLC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjIBLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:02:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE4112D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C0AFB826E6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C0FC433C7;
        Sat,  2 Sep 2023 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693652541;
        bh=nWRp3kNt0uCKDvR/efj7kKP5j/V5vGO+TJUPxq8elAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrjcyFPTU160rKO1Kt5+wuQbuw/7eRXtQtTi7/Swk7y6ewBq3wg0e0oStgpLsusQQ
         zV/xmjisEPfLduUTVDQJ0W+n1JByouskEBEJDNX9dPdp1Poaizxr/P5KwUrTs2tiTa
         f14Lgt4db+SU6JE3Z/m37wBPJX0H+Ni5UAV+ygFzNUVtpf5hpsb4OqrR2FoFGAC42R
         5m5ATCxAsj54sobWtYs1nV7a/9p4smXKDq+absVI7AXIWxtcbA5LwKHYq1onnCybfS
         g5rSLhmJoeWdhFkuwQhl9+NOXXSkno6+TUTcBeb6yM4uHsZBTdz+GKuwTiTSKG22xv
         COIjyYMxH2Mzg==
Date:   Sat, 2 Sep 2023 12:02:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
Message-ID: <20230902-plexiglas-cannot-e4ca8494ef95@spud>
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZRn/ZXZBHlvjdjg5"
Content-Disposition: inline
In-Reply-To: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZRn/ZXZBHlvjdjg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 12:03:20PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
> enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
> avoid any build failures.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp@i=
ntel.com/
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Replied here earlier, but pressed the wrong key & it only went to the
list.
I think this patch probably also needs to grow a Fixes tag, for
commit f2863f30d1b0 ("riscv: errata: Add Andes alternative ports").

The 4 Kconfig patches ideally would've been in a series, since 3 of the
4 seem to be fixes & the 4th depends on one of the fixes being applied.

Thaks,
Conor.

> ---
>  arch/riscv/Kconfig.errata | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index bee5d838763b..566bcefeab50 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -2,7 +2,7 @@ menu "CPU errata selection"
> =20
>  config ERRATA_ANDES
>  	bool "Andes AX45MP errata"
> -	depends on RISCV_ALTERNATIVE
> +	depends on RISCV_ALTERNATIVE && RISCV_SBI
>  	help
>  	  All Andes errata Kconfig depend on this Kconfig. Disabling
>  	  this Kconfig will disable all Andes errata. Please say "Y"
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--ZRn/ZXZBHlvjdjg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPMWOAAKCRB4tDGHoIJi
0taDAQCl8QFGGuuCZWZwjq0NAg/MOvQ1IE3aTOyReSkf3CSWmgEAhGTMm/mRzXsS
Y5+ZrqbMvP+CtswbvJi7NfMs8BhfPgw=
=KonS
-----END PGP SIGNATURE-----

--ZRn/ZXZBHlvjdjg5--
