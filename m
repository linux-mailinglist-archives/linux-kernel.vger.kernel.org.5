Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C14786EED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbjHXMVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbjHXMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:20:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A78019B0;
        Thu, 24 Aug 2023 05:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692879651; x=1724415651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UniHE8T8CBJsXsp5AUwf/p97KIJh8SiPdFKSRg4PQ+0=;
  b=gyEZHeBRWxhU1PBDnEAvl5BL3Ah+mmHP+78Eov4u/4B6GNJO4nP2e5nW
   FHtRlt4+U8B1vZ0GweVHRgqi6xYX5jLzm8mE9WtrlcP+vG1LE9NA/uuro
   9HXQ/DG6eCoe9KJm+jgT/O6UE8D73+k32rhjR+HbSuv7DfHVt25O3PMUb
   DX/399keAVBLf5MVHNl241yay4kQFD4pIm5T/Gyvgl/lIiPV405R57G+g
   FRlyMx3zFyLvunXukOGModDZMCMLqgQHEq2CHq6XuL8st8Ip5jvMda/cT
   +mgXKNEYjbi4XsuVIV5pLhm1tJuhM+q61MAV+e5cDSfsjI3GNWWAp2K8t
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="asc'?scan'208";a="1101686"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2023 05:20:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 24 Aug 2023 05:20:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 24 Aug 2023 05:20:47 -0700
Date:   Thu, 24 Aug 2023 13:20:06 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230824-factual-jawed-2dddd2cf2bdd@wendy>
References: <20230711201831.2695097-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qk1i/rPebejGNd0P"
Content-Disposition: inline
In-Reply-To: <20230711201831.2695097-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qk1i/rPebejGNd0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 01:18:30PM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
>=20
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart. This matches what is returned in riscv_hwprobe() when querying a
> given hart.
>=20
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> ---
>=20
> Changes in v4:
>  - Documentation: Made the underline match the text line (Conor)
>  - Documentation: hanged "in question" to "being described" (Andrew)
>=20
> Changes in v3:
>  - Add some documentation (Conor)
>=20
> Changes in v2:
>  - Added new "hart isa" line rather than altering behavior of existing
>    "isa" line (Conor, Palmer)
>=20
>=20
> I based this series on top of Conor's riscv-extensions-strings branch
> from July 3rd, since otherwise this change gets hopelessly entangled
> with that series.
>=20
> ---
>  Documentation/riscv/uabi.rst | 10 ++++++++++
>  arch/riscv/kernel/cpu.c      | 22 ++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 8960fac42c40..afdda580e5a2 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -42,6 +42,16 @@ An example string following the order is::
> =20
>     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> =20
> +"isa" vs "hart isa" lines in /proc/cpuinfo
> +------------------------------------------
> +
> +The "isa" line in /proc/cpuinfo describes the lowest common denominator =
of
> +RISC-V ISA extensions understood by the kernel and implemented on all ha=
rts. The
> +"hart isa" line, in contrast, describes the set of extensions understood=
 by the
> +kernel on the particular hart being described, even if those extensions =
may not
> +be present on all harts in the system. The "hart isa" line is consistent=
 with
> +what's returned by __riscv_hwprobe() when querying for that specific CPU.

Thinking about this again, I don't think this is true. hwprobe uses
has_fpu(), has_vector() etc that interact with Kconfig options but the
percpu isa bitmap isn't affected by these.


> +
>  Misaligned accesses
>  -------------------
> =20
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1acf3679600d..6264b7b94945 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
> =20
>  #ifdef CONFIG_PROC_FS
> =20
> -static void print_isa(struct seq_file *f)
> +static void print_isa(struct seq_file *f, const unsigned long *isa_bitma=
p)
>  {
> -	seq_puts(f, "isa\t\t: ");
> =20
>  	if (IS_ENABLED(CONFIG_32BIT))
>  		seq_write(f, "rv32", 4);
> @@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
>  		seq_write(f, "rv64", 4);
> =20
>  	for (int i =3D 0; i < riscv_isa_ext_count; i++) {
> -		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> +		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>  			continue;
> =20
>  		/* Only multi-letter extensions are split by underscores */
> @@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
> =20
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	print_isa(m);
> +
> +	/*
> +	 * For historical raisins, the isa: line is limited to the lowest common
> +	 * denominator of extensions supported across all harts. A true list of
> +	 * extensions supported on this hart is printed later in the hart_isa:
> +	 * line.
> +	 */
> +	seq_puts(m, "isa\t\t: ");
> +	print_isa(m, NULL);
>  	print_mmu(m);
> =20
>  	if (acpi_disabled) {
> @@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> +
> +	/*
> +	 * Print the ISA extensions specific to this hart, which may show
> +	 * additional extensions not present across all harts.
> +	 */
> +	seq_puts(m, "hart isa\t: ");
> +	print_isa(m, hart_isa[cpu_id].isa);
>  	seq_puts(m, "\n");
> =20
>  	return 0;
> --=20
> 2.34.1
>=20

--qk1i/rPebejGNd0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOdK9gAKCRB4tDGHoIJi
0liiAP4gl0tcLeJen0DrqHl7mUfFjKLV+rxAVZFw6sBF8FRmaQEAu0Z51JiElsPS
KyIRZMIWB/CZJgPwPVBoToRKWWbtSAA=
=u5eg
-----END PGP SIGNATURE-----

--qk1i/rPebejGNd0P--
