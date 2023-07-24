Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F7F75F35F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGXKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGXKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:33:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0ECDB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690194794; x=1721730794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2A2JU/fzgzYQsCwx+j1j5mbZhV4V8Gf7uWXcztu+eQs=;
  b=MRAzXxWUeNTpUM1VrFfGVAUoGXb9dL+TwpgARt1+Si8BtfzZTUeD1Dz4
   rfnA5ddGZr8jtjHi+BBq/90vZVJlYKWT8f1HE1DvwAT7v8LK6twTAB0yC
   k4iONtNa6PxBAoze04IQFVrXSQozb/cRGG0QlDIwNZZLbkRU3tiUOemoS
   t2X2vIgjzvbohGYuBT+8GLCZDfTpm3NJ5vDKDuCRxPJxBMuGYPlHFqlr8
   3XdcJQteO3Z5rnBbm9gUNeaL+0qBq4H+Hrp8JhdQ1RwoP0hGwxG3brbch
   yZqNpOuNZEwHdUwqCCCkFKWWE4Db0zuB7AbRAypnAN0VKyzlndq30A3fL
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="237300210"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 03:33:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 03:33:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 03:33:11 -0700
Date:   Mon, 24 Jul 2023 11:32:38 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return
 iomem address
Message-ID: <20230724-zit-stunning-901bfd989a4a@wendy>
References: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkxf3SyDjVGAdJvc"
Content-Disposition: inline
In-Reply-To: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zkxf3SyDjVGAdJvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 03:33:46PM +0530, Sunil V L wrote:
> acpi_os_ioremap() currently is a wrapper to memremap() on
> RISC-V. But the callers of acpi_os_ioremap() expect it to
> return __iomem address and hence sparse tool reports a new
> warning. Fix this issue by type casting to  __iomem type.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@i=
ntel.com/
> Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Surprisingly, my automation already tested this patch. Usually there's a
several hour delay between posting & testing.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> Changes since v2:
> 	1) Removed unnecessary __force.
> 	2) Removed unnecessary space after cast to fix checkpatch --strict warni=
ng.
>=20
> Changes since v1:
> 	1) Removed enhancements from the fix patch.
>=20
>  arch/riscv/include/asm/acpi.h | 2 +-
>  arch/riscv/kernel/acpi.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index f71ce21ff684..d5604d2073bc 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -19,7 +19,7 @@ typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HARTID
> =20
>  /* ACPI table mapping after acpi_permanent_mmap is set */
> -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size=
);
>  #define acpi_os_ioremap acpi_os_ioremap
> =20
>  #define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 5ee03ebab80e..56cb2c986c48 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -215,9 +215,9 @@ void __init __acpi_unmap_table(void __iomem *map, uns=
igned long size)
>  	early_iounmap(map, size);
>  }
> =20
> -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  {
> -	return memremap(phys, size, MEMREMAP_WB);
> +	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
>  }
> =20
>  #ifdef CONFIG_PCI
> --=20
> 2.39.2
>=20

--zkxf3SyDjVGAdJvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL5TRQAKCRB4tDGHoIJi
0sSUAQDRKYATqlpRLkFQpUraMl2rdoynN0aAfJOpVdSZbqnsrwEAuylSpN7Gpx3x
eShz+1UlkmUkL7qLQ4c5WW/ZZyoJQQQ=
=5gPe
-----END PGP SIGNATURE-----

--zkxf3SyDjVGAdJvc--
