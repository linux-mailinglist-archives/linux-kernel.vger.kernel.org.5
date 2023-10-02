Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A27B57AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbjJBPq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbjJBPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:46:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ECAD7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:46:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E29C433CA;
        Mon,  2 Oct 2023 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261610;
        bh=CmmG84b/1OBnh9RduBYlaC31PLcl9rWTf7tM7hAt0i4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/PAwkBadBvbGrpkDaXWNVVBDnVeHkW1OSHNMHBGISuRWXaQT9+M0PS00iAThcFaU
         mIpBADPxntPzj9BWoSebDW8KKXItg8G+Xf0IH4smglI1BecONgtU+tws0KE7dmweRr
         hi3pi2gHuCjar8xeO4b1UDHk+mz8TQ6b9KAFV7wOukcAk/h66Sk6CGKhp90/qhN2Jz
         T8SNYwPq+Euel24AtDA23nefvRHTVuTBXgCTKhPfGpRltqgDX11sM3TwzyOlDK8/TG
         YwVnw0ilipHuN/tuLIa6MXzz2UgaWGg5yjLSxQlrI9zEIu2wfDZTjUrft6vgk1EscK
         5kFcJYt0aFXBA==
Date:   Mon, 2 Oct 2023 16:46:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Message-ID: <20231002-doorman-catchy-ff5b9ba14c3a@spud>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aL1TA5F1n3lbU8nP"
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aL1TA5F1n3lbU8nP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:30:15PM +0530, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
>=20
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index 9c8f3e2decc2..06f5bad3c3e0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_i=
nit_dt);
>  #ifdef CONFIG_ACPI
>  static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
>  {
> +	struct acpi_table_rhct *rhct =3D (struct acpi_table_rhct *)table;
> +
> +	riscv_timer_cannot_wake_cpu =3D rhct->flags & ACPI_RHCT_TIMER_CANNOT_WA=
KEUP_CPU;
> +
>  	return riscv_timer_init_common();
>  }
> =20
> --=20
> 2.39.2
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--aL1TA5F1n3lbU8nP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrl5AAKCRB4tDGHoIJi
0hIpAP4l78wWWSJgv9GiRYKP3viLL22FMxgc4K5BcjViUuXTFgEA1phiOLRhZJXQ
5THh1DtDO53ISPllC0QaOhA0ZPUYoAs=
=6uzF
-----END PGP SIGNATURE-----

--aL1TA5F1n3lbU8nP--
