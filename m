Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6E75A693
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjGTGf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGTGfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:35:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3E5211F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689834845; x=1721370845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NXJkJED8MudXTMwu79GUYLDPwHFyYBvTFVqQJATwOJA=;
  b=RWc2KpqUZw2G3MAvhfFV8+rSnrcVJfovSzLBwxpAdYch2rBeOd8dnUk2
   BgbvoAGJZDb3fTNMeWXFUtmsY8gd/doUFjGmrRp0Eu5Ou9tJKj/ORM4AQ
   7hmkjCwF3inm1gL+Yf/tOb21t+7hL8lfh/QLfpPq13p+3bX5hrZD4JkZ4
   3CRNAgKm+fIB2xfJaIfdtaM6LExoUceyAa4PPshA9y58uxt7L8lUhBSEW
   1JUlC/OCZkDxq6l9wvris+hMTkDVI2WxhqhzWLv9MSJB3Lxlma3toBmjF
   aYSXsUY8yw7cfmL7v1EBcoPrwQbi+1x3f4fJCLI/ESRSHYV/h/7caj64t
   A==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="225561845"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2023 23:32:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 19 Jul 2023 23:32:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 19 Jul 2023 23:32:15 -0700
Date:   Thu, 20 Jul 2023 07:31:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Woody Zhang <woodylab@foxmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ajones@ventanamicro.com>
Subject: Re: [PATCH] riscv: add SBI SUSP extension support
Message-ID: <20230720-speller-suffocate-29ee7cc0b1f6@wendy>
References: <tencent_B931BF1864B6AE8C674686ED9852ACFA0609@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bIP/mw2/ir0BscVj"
Content-Disposition: inline
In-Reply-To: <tencent_B931BF1864B6AE8C674686ED9852ACFA0609@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--bIP/mw2/ir0BscVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Woody,

On Thu, Jul 20, 2023 at 08:23:19AM +0800, Woody Zhang wrote:
> RISC-V SBI spec 2.0 [1] introduces System Suspend Extension which can be
> used to suspend the platform via SBI firmware.
>=20
> This patch can be tested on Qemu with recent OpenSBI with
> `system-suspend-test` enabled like [2] in DTB.
>=20
> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.=
adoc
> [2] https://github.com/woodyzhang666/qemu/commit/e4a5120133c1dc354e6ac437=
ec1f870f6c0f6d05
>=20
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> ---
>  arch/riscv/include/asm/sbi.h | 10 ++++++++++
>  arch/riscv/kernel/sbi.c      | 26 ++++++++++++++++++++++++++

There's prior art here, that is seemingly more complete:
https://lore.kernel.org/all/20230118180338.6484-2-ajones@ventanamicro.com/
IIRC, the reason it is still in RFC status is that the 2.0 SBI spec is
not yet frozen, so this cannot be merged.

Thanks,
Conor.

>  2 files changed, 36 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..3b04016da671 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -30,6 +30,7 @@ enum sbi_ext_id {
>  	SBI_EXT_HSM =3D 0x48534D,
>  	SBI_EXT_SRST =3D 0x53525354,
>  	SBI_EXT_PMU =3D 0x504D55,
> +	SBI_EXT_SUSP =3D 0x53555350,
> =20
>  	/* Experimentals extensions must lie within this range */
>  	SBI_EXT_EXPERIMENTAL_START =3D 0x08000000,
> @@ -236,6 +237,15 @@ enum sbi_pmu_ctr_type {
>  /* Flags defined for counter stop function */
>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> =20
> +enum sbi_ext_susp_fid {
> +	SBI_EXT_SUSP_SYSTEM_SUSPEND =3D 0,
> +};
> +
> +/* SBI suspend sleep types */
> +enum sbi_susp_sleep_type {
> +	SBI_SUSP_SLEEP_TYPE_SUSPEND =3D 0x0,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index c672c8ba9a2a..9a68959f9f18 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -9,8 +9,10 @@
>  #include <linux/init.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
> +#include <linux/suspend.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
> +#include <asm/suspend.h>
> =20
>  /* default SBI version is 0.1 */
>  unsigned long sbi_spec_version __ro_after_init =3D SBI_SPEC_VERSION_DEFA=
ULT;
> @@ -520,6 +522,26 @@ static void sbi_srst_power_off(void)
>  		       SBI_SRST_RESET_REASON_NONE);
>  }
> =20
> +static int sbi_system_suspend(unsigned long arg,
> +		unsigned long resume_entry, unsigned long context)
> +{
> +	struct sbiret ret =3D {0};
> +
> +	ret =3D sbi_ecall(SBI_EXT_SUSP, SBI_EXT_SUSP_SYSTEM_SUSPEND,
> +			SBI_SUSP_SLEEP_TYPE_SUSPEND, resume_entry, context, 0, 0, 0);
> +	return ret.error;
> +}
> +
> +static int sbi_system_suspend_enter(suspend_state_t state)
> +{
> +	return cpu_suspend(0, sbi_system_suspend);
> +}
> +
> +static const struct platform_suspend_ops sbi_suspend_ops =3D {
> +	.valid          =3D suspend_valid_only_mem,
> +	.enter          =3D sbi_system_suspend_enter,
> +};
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or =
not.
>   * @extid: The extension ID to be probed.
> @@ -624,6 +646,10 @@ void __init sbi_init(void)
>  			sbi_srst_reboot_nb.priority =3D 192;
>  			register_restart_handler(&sbi_srst_reboot_nb);
>  		}
> +		if (sbi_probe_extension(SBI_EXT_SUSP)) {
> +			pr_info("SBI SUSP extension detected\n");
> +			suspend_set_ops(&sbi_suspend_ops);
> +		}
>  	} else {
>  		__sbi_set_timer =3D __sbi_set_timer_v01;
>  		__sbi_send_ipi	=3D __sbi_send_ipi_v01;
> --=20
> 2.39.2
>=20

--bIP/mw2/ir0BscVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLjUvwAKCRB4tDGHoIJi
0liCAQDOneTEE/l+NQoyXArGTAg/it54GYEgQyRV+OVw8IPaxgD/a5hWPEPE3qUo
Q7u0xZvKbQpAv2f+EFfYD1Zy6FpnHQM=
=+VoD
-----END PGP SIGNATURE-----

--bIP/mw2/ir0BscVj--
