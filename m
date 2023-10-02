Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2F7B572D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbjJBPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbjJBPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:50:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A892A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6944AC433C7;
        Mon,  2 Oct 2023 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261828;
        bh=O72E3ZVNiuEo0RBUJoTwRkR159xNbbJrFOP9dMKbWJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tvRWKuVWaj8ZDjW2PP+a9TusRDq1llpPG8Nk7Nsz4ZPHQndBkZSfaUHAPBv3C8zEv
         iNleVb7s8tlNmWvnQXBgu+ir00/xLNR8+oI+jrJAoFHUnKIxJOWYBdi18PS6GBsunw
         t428Gpxn+T3QYlr8ELm1Gi1HpIouWSoX0gqX0lzzXm8JWomZrQT5xEVyXuKOdmFjd2
         7XDDYGiKRpMdbuj8+/EqChEEk0rdxDTWq55vAcJR5HfSUKn/nH2TUAAfiHUUyw1VPQ
         BewBCu+ZtGWDYUcV6muQjccMoe5iS5Ak/L6mgpei0hCPILemPrQpwxAxAlVJkaK7JE
         yMMqQWpMCydiA==
Date:   Mon, 2 Oct 2023 16:50:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20231002-anyplace-impending-bcb62ca90f79@spud>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o8PPxZtlZhU/WX3V"
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-4-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o8PPxZtlZhU/WX3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:30:14PM +0530, Sunil V L wrote:
> Using new interface to get the CBO block size information in RHCT,
> initialize the variables on ACPI platforms.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.
> ---
>  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index f1387272a551..8e59644e473c 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,7 +3,9 @@
>   * Copyright (C) 2017 SiFive
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/of.h>
> +#include <asm/acpi.h>
>  #include <asm/cacheflush.h>
> =20
>  #ifdef CONFIG_SMP
> @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
>  	unsigned long cbom_hartid, cboz_hartid;
>  	u32 cbom_block_size =3D 0, cboz_block_size =3D 0;
>  	struct device_node *node;
> +	struct acpi_table_header *rhct;
> +	acpi_status status;
> +	unsigned int cpu;
> +
> +	if (!acpi_disabled) {
> +		status =3D acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> +		if (ACPI_FAILURE(status))
> +			return;
> +	}
> =20
> -	for_each_of_cpu_node(node) {
> -		/* set block-size for cbom and/or cboz extension if available */
> -		cbo_get_block_size(node, "riscv,cbom-block-size",
> -				   &cbom_block_size, &cbom_hartid);
> -		cbo_get_block_size(node, "riscv,cboz-block-size",
> -				   &cboz_block_size, &cboz_hartid);
> +	for_each_possible_cpu(cpu) {
> +		if (acpi_disabled) {
> +			node =3D of_cpu_device_node_get(cpu);
> +			if (!node) {
> +				pr_warn("Unable to find cpu node\n");
> +				continue;
> +			}
> +
> +			/* set block-size for cbom and/or cboz extension if available */
> +			cbo_get_block_size(node, "riscv,cbom-block-size",
> +					   &cbom_block_size, &cbom_hartid);
> +			cbo_get_block_size(node, "riscv,cboz-block-size",
> +					   &cboz_block_size, &cboz_hartid);
> +		} else {
> +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> +						&cboz_block_size, NULL);
> +		}
>  	}
> =20
> +	if (!acpi_disabled && rhct)
> +		acpi_put_table((struct acpi_table_header *)rhct);
> +
>  	if (cbom_block_size)
>  		riscv_cbom_block_size =3D cbom_block_size;
> =20
> --=20
> 2.39.2
>=20

--o8PPxZtlZhU/WX3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrmvwAKCRB4tDGHoIJi
0nf8AQCTxt4VlxBrgtIhfufLcu2yyKEOu8gbSQy5sLNEU03knAD/crKrOne+Xeiz
FzWiJRzcnFcqSj505sbzYo5m/x8tZQs=
=z/P5
-----END PGP SIGNATURE-----

--o8PPxZtlZhU/WX3V--
