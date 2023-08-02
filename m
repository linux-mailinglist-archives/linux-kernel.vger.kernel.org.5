Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407476C5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjHBGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHBGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:55:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560C10C1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690959322; x=1722495322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hb6CE2J/7siYpXeRApw5gdYJame1jDnCoPajhlfdJug=;
  b=0ihMGNQ1DUCYrSFP0aC5GImbI2Mnes7RwGvth/UIK394IXdhkn/PP9n2
   Yacgm47BZBVrhOj4qTQXg+iOVciPNISbaWyINBDNxEr7xRflVG1LmayTV
   9/Kyfj+fou0AsoJoqYIRGWe7pBid+sPA3UjXoBOhwxSW9j3Bz7Pw2Hekn
   663b6J0Krg3eIS0yoZyhO5aG0oXsU/rkpJQW4R0ark36MyUEmyFK7gN4q
   bD1M1tyIHmAyPewJ83eDPntml0MERySOm/PMX+fzv0/C0j6sT3pyWRwIh
   HE1A+5npUe2OeEO/8GAWWJkgEPvUn62A+uAWrBvz1eQte0GARrUgVizX9
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="227517169"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2023 23:55:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 1 Aug 2023 23:55:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 1 Aug 2023 23:55:11 -0700
Date:   Wed, 2 Aug 2023 07:54:35 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace
 zihintpause
Message-ID: <20230802-sharpness-spoon-f9b8804fb66f@wendy>
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FVNaThGgTV3kObRx"
Content-Disposition: inline
In-Reply-To: <20230802064215.31111-1-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--FVNaThGgTV3kObRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Wed, Aug 02, 2023 at 02:42:15PM +0800, Minda Chen wrote:
> Actually it is a part of Conor's
> commit aae538cd03bc ("riscv: fix detection of toolchain
> Zihintpause support").
> It is looks like a merge issue.

Yup, spot on.

> Samuel's
> commit 0b1d60d6dd9e ("riscv: Fix build with
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy") do not base on Conor's commit and
> revert to __riscv_zihintpause. So this patch can fix it.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Did you actually manage to trigger this, or was this by inspection?
clang-15 + binutils 2.35 was, IIRC, how we spotted this because that's
what the clang-built-linux CI uses to test the LTS kernels from before
LLVM's IAS was supported for RISC-V. Seemingly all that needs to be
satisfied there is that zihintpause doesn't appear in -march so this has
gone unnoticed.

Fixes: 3c349eacc559 ("Merge patch "riscv: Fix build with CONFIG_CC_OPTIMIZE=
_FOR_SIZE=3Dy"")
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/include/asm/vdso/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include=
/asm/vdso/processor.h
> index 14f5d27783b8..96b65a5396df 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -14,7 +14,7 @@ static inline void cpu_relax(void)
>  	__asm__ __volatile__ ("div %0, %0, zero" : "=3Dr" (dummy));
>  #endif
> =20
> -#ifdef __riscv_zihintpause
> +#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
>  	/*
>  	 * Reduce instruction retirement.
>  	 * This assumes the PC changes.
> --=20
> 2.17.1
>=20

--FVNaThGgTV3kObRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMn9ngAKCRB4tDGHoIJi
0hxdAQDFRoolcE1ZciJySVnzfJ0A7cPaXejOwC5uLjAsT0671AEAmAQgIFMO/NXx
QEYAk2a7x7wm2TOTAaDFHFgWbGPK9wQ=
=CujL
-----END PGP SIGNATURE-----

--FVNaThGgTV3kObRx--
