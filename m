Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF137977C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbjIGQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238648AbjIGQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C05FC7;
        Thu,  7 Sep 2023 09:22:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B44C433B7;
        Thu,  7 Sep 2023 09:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694078832;
        bh=gfUw2CkyuebGdf6kVXtdNFVCIy9rVDXi7vP0kJLGY6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JchFbwdcXWKMDtudwax6UKpVWB+B5U/v1vOXAZ44MZyf32x5/DDnprw96ijz2katQ
         6teeKX/1gteMf2HuzGtY6wrep9ZbqKHl8KSmIT3qOrxjbmg5CwtnOKvw5z/zrR6aYv
         AocwKLwjM9QiskyDl+ptZ9qmutu6SxW/OPE610xdTgJKgWeIu9jM6xhNX4C9z9ZjAj
         0tjG+ByI5lBEWcOE08A0+TVxhpZLqkRmlUB2gYJyV4HZKxj/dmpz+MYn0IVul97MeF
         4oGEEAR9P1J4yUsCGK0gKhqnW8ZvFM6TM6ARt4h9lDwxgGSEPoH8YmJp5GubRmRJsf
         4PU9JR2Bu+qHw==
Date:   Thu, 7 Sep 2023 10:27:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, atishp@atishpatra.org,
        anup@brainfault.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        ajones@ventanamicro.com, heiko@sntech.de, samuel@sholland.org,
        geert+renesas@glider.be, n.shubin@yadro.com, dminus@andestech.com,
        ycliang@andestech.com, tim609@andestech.com, locus84@andestech.com,
        dylan@andestech.com
Subject: Re: [PATCH 3/4] riscv: errata: Add Andes PMU errata
Message-ID: <20230907-158e1f7e1e866d8c02726c9c@fedora>
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-4-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jMdrE/NsI/M9lmQR"
Content-Disposition: inline
In-Reply-To: <20230907021635.1002738-4-peterlin@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jMdrE/NsI/M9lmQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Sep 07, 2023 at 10:16:34AM +0800, Yu Chien Peter Lin wrote:
> Before the ratification of Sscofpmf, the Andes PMU extension
> implements the same mechanism and is compatible with existing
> SBI PMU driver of perf to support event sampling and mode
> filtering with programmable hardware performance counters.

If it actually was, you'd not need to modify the driver ;)

> This patch adds PMU support for Andes 45-series CPUs by
> introducing a CPU errata.

I don't really understand this in all honesty. You don't have Sscofpmf
support with a bug, you have something that is Sscofpmf-adjactent that
predates it. Why claim to support an extension that you do not, only to
have to come along and try to clean things up afterwards, instead of
accurately declaring what you do support from the outset?

(and just because someone already got away with it, doesn't mean that
you get a free pass on it, sorry)

Thanks,
Conor.

> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>

btw, what did Locus Wei-Han Chen do here? Are you missing
a Co-developed-by: tag?

> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
>  arch/riscv/Kconfig.errata            | 13 ++++++++
>  arch/riscv/errata/andes/errata.c     | 45 +++++++++++++++++++++++++++-
>  arch/riscv/include/asm/errata_list.h | 43 ++++++++++++++++++++++++--
>  drivers/perf/riscv_pmu_sbi.c         | 20 +++++++++----
>  4 files changed, 111 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 92c779764b27..a342b209c169 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -21,6 +21,19 @@ config ERRATA_ANDES_CMO
> =20
>  	  If you don't know what to do here, say "Y".
> =20
> +config ERRATA_ANDES_PMU
> +	bool "Apply Andes PMU errata"
> +	depends on ERRATA_ANDES && RISCV_PMU_SBI
> +	default y
> +	help
> +	  The Andes 45-series cores implement a PMU overflow extension
> +	  very similar to the core SSCOFPMF extension.
> +
> +	  This will apply the overflow errata to handle the non-standard
> +	  behaviour via the regular SBI PMU driver and interface.
> +
> +	  If you don't know what to do here, say "Y".
> +
>  config ERRATA_SIFIVE
>  	bool "SiFive errata"
>  	depends on RISCV_ALTERNATIVE
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/e=
rrata.c
> index d2e1abcac967..19256691f1ba 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -56,11 +56,54 @@ static bool errata_probe_iocp(unsigned int stage, uns=
igned long arch_id, unsigne
>  	return true;
>  }
> =20
> +static bool errata_probe_pmu(unsigned int stage,
> +			     unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_PMU))
> +		return false;
> +
> +	if ((arch_id & 0xff) !=3D 0x45)
> +		return false;
> +
> +	if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
> +		return false;
> +
> +	return true;
> +}
> +
> +static u32 andes_errata_probe(unsigned int stage,
> +			      unsigned long archid, unsigned long impid)
> +{
> +	u32 cpu_req_errata =3D 0;
> +
> +	if (errata_probe_pmu(stage, archid, impid))
> +		cpu_req_errata |=3D BIT(ERRATA_ANDES_PMU);
> +
> +	return cpu_req_errata;
> +}
> +
>  void __init_or_module andes_errata_patch_func(struct alt_entry *begin, s=
truct alt_entry *end,
>  					      unsigned long archid, unsigned long impid,
>  					      unsigned int stage)
>  {
> +	struct alt_entry *alt;
> +	u32 cpu_req_errata =3D andes_errata_probe(stage, archid, impid);
> +	u32 tmp;
> +
>  	errata_probe_iocp(stage, archid, impid);
> =20
> -	/* we have nothing to patch here ATM so just return back */
> +	for (alt =3D begin; alt < end; alt++) {
> +		if (alt->vendor_id !=3D ANDES_VENDOR_ID)
> +			continue;
> +		if (alt->patch_id >=3D ERRATA_ANDES_NUMBER)
> +			continue;
> +
> +		tmp =3D (1U << alt->patch_id);
> +		if (cpu_req_errata & tmp) {
> +			mutex_lock(&text_mutex);
> +			patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(alt),
> +					  alt->alt_len);
> +			mutex_unlock(&text_mutex);
> +		}
> +	}
>  }
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/as=
m/errata_list.h
> index 56ab40e64092..bb4c276e2c7f 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -13,7 +13,8 @@
> =20
>  #ifdef CONFIG_ERRATA_ANDES
>  #define ERRATA_ANDES_NO_IOCP 0
> -#define ERRATA_ANDES_NUMBER 1
> +#define ERRATA_ANDES_PMU 1
> +#define ERRATA_ANDES_NUMBER 2
>  #endif
> =20
>  #ifdef CONFIG_ERRATA_SIFIVE
> @@ -150,15 +151,51 @@ asm volatile(ALTERNATIVE_2(						\
>  #define THEAD_C9XX_RV_IRQ_PMU			17
>  #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
> =20
> +#define ANDES_RV_IRQ_PMU			18
> +#define ANDES_SLI_CAUSE_BASE			256
> +#define ANDES_CSR_SCOUNTEROF			0x9d4
> +#define ANDES_CSR_SLIE				0x9c4
> +#define ANDES_CSR_SLIP				0x9c5
> +
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
> -asm volatile(ALTERNATIVE(						\
> +asm volatile(ALTERNATIVE_2(						\
>  	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
>  	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
>  		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
> -		CONFIG_ERRATA_THEAD_PMU)				\
> +		CONFIG_ERRATA_THEAD_PMU,				\
> +	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
>  	: "=3Dr" (__ovl) :						\
>  	: "memory")
> =20
> +#define ALT_SBI_PMU_OVF_CLEAR_PENDING(__irq_num)			\
> +asm volatile(ALTERNATIVE(						\
> +	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
> +	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
> +#define ALT_SBI_PMU_OVF_DISABLE(__irq_num)				\
> +asm volatile(ALTERNATIVE(						\
> +	"csrc " __stringify(CSR_IE) ", %0\n\t",				\
> +	"csrc " __stringify(ANDES_CSR_SLIE) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
> +#define ALT_SBI_PMU_OVF_ENABLE(__irq_num)				\
> +asm volatile(ALTERNATIVE(						\
> +	"csrs " __stringify(CSR_IE) ", %0\n\t",				\
> +	"csrs " __stringify(ANDES_CSR_SLIE) ", %0\n\t",			\
> +		ANDES_VENDOR_ID, ERRATA_ANDES_PMU,			\
> +		CONFIG_ERRATA_ANDES_PMU)				\
> +	: : "r"(BIT(__irq_num))						\
> +	: "memory")
> +
>  #endif /* __ASSEMBLY__ */
> =20
>  #endif
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 9a51053b1f99..8b67f202d2ae 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -687,7 +687,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void =
*dev)
>  	fidx =3D find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	event =3D cpu_hw_evt->events[fidx];
>  	if (!event) {
> -		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
>  		return IRQ_NONE;
>  	}
> =20
> @@ -701,7 +701,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void =
*dev)
>  	 * Overflow interrupt pending bit should only be cleared after stopping
>  	 * all the counters to avoid any race condition.
>  	 */
> -	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
> =20
>  	/* No overflow bit is set */
>  	if (!overflow)
> @@ -773,8 +773,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, str=
uct hlist_node *node)
> =20
>  	if (riscv_pmu_use_irq) {
>  		cpu_hw_evt->irq =3D riscv_pmu_irq;
> -		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
> -		csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_num);
> +		ALT_SBI_PMU_OVF_ENABLE(riscv_pmu_irq_num);
>  		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
>  	}
> =20
> @@ -785,7 +785,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct=
 hlist_node *node)
>  {
>  	if (riscv_pmu_use_irq) {
>  		disable_percpu_irq(riscv_pmu_irq);
> -		csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
> +		ALT_SBI_PMU_OVF_DISABLE(riscv_pmu_irq_num);
>  	}
> =20
>  	/* Disable all counters access for user mode now */
> @@ -809,6 +809,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>  		   riscv_cached_mimpid(0) =3D=3D 0) {
>  		riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>  		riscv_pmu_use_irq =3D true;
> +	} else if (IS_ENABLED(CONFIG_ERRATA_ANDES_PMU) &&
> +		   riscv_cached_mvendorid(0) =3D=3D ANDES_VENDOR_ID) {
> +		riscv_pmu_irq_num =3D ANDES_RV_IRQ_PMU;
> +		riscv_pmu_use_irq =3D true;
>  	}
> =20
>  	if (!riscv_pmu_use_irq)
> @@ -821,7 +825,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>  		return -ENODEV;
>  	}
> =20
> -	riscv_pmu_irq =3D irq_create_mapping(domain, riscv_pmu_irq_num);
> +	if (IS_ENABLED(CONFIG_ERRATA_ANDES_PMU))
> +		riscv_pmu_irq =3D irq_create_mapping(
> +			domain, ANDES_SLI_CAUSE_BASE + riscv_pmu_irq_num);
> +	else
> +		riscv_pmu_irq =3D irq_create_mapping(domain, riscv_pmu_irq_num);
>  	if (!riscv_pmu_irq) {
>  		pr_err("Failed to map PMU interrupt for node\n");
>  		return -ENODEV;
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--jMdrE/NsI/M9lmQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmXYwAKCRB4tDGHoIJi
0pxmAP9b/N+QTuiiGLQEWlt7cn6OD1zZfzRKLSdkzb5rJKST1gD/W1NhzNBFX6Y3
bbE/vGgenMSmSIfKQAabZpl6s63mtwI=
=Oz/Z
-----END PGP SIGNATURE-----

--jMdrE/NsI/M9lmQR--
