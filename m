Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0089C771789
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHGAoQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Aug 2023 20:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:44:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7072B1;
        Sun,  6 Aug 2023 17:44:11 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3E50B24E28D;
        Mon,  7 Aug 2023 08:44:08 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 08:44:08 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 7 Aug
 2023 08:44:07 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Mon, 7 Aug 2023 08:44:07 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>
CC:     "conor@kernel.org" <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Topic: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Thread-Index: AQHZxTKPVELaCqW/WUK93+UXGxBdOK/eAqwg
Date:   Mon, 7 Aug 2023 00:44:07 +0000
Message-ID: <3e066032031e4552b4b7903755deb669@EXMBX066.cuchost.com>
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
 <20230802-detention-second-82ab2b53e07a@wendy>
In-Reply-To: <20230802-detention-second-82ab2b53e07a@wendy>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor.dooley@microchip.com>
> Sent: Wednesday, August 2, 2023 7:13 PM
> To: palmer@dabbelt.com
> Cc: conor@kernel.org; conor.dooley@microchip.com; Paul Walmsley <paul.walmsley@sifive.com>; Atish Patra
> <atishp@rivosinc.com>; Anup Patel <apatel@ventanamicro.com>; Alexandre Ghiti <alexghiti@rivosinc.com>; Björn Töpel
> <bjorn@rivosinc.com>; Song Shuai <suagrfillet@gmail.com>; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Petr Tesarik
> <petrtesarik@huaweicloud.com>; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: [RFT 1/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
> 
> Add an erratum for versions [v0.8 to v1.3) of OpenSBI which fail to add
> the "no-map" property to the reserved memory nodes for the regions it
> has protected using PMPs.
> 
> Our existing fix sweeping hibernation under the carpet by marking it
> NONPORTABLE is insufficient as there are other ways to generate
> accesses to these reserved memory regions, as Petr discovered [1]
> while testing crash kernels & kdump.
> 
> Intercede during the boot process when the afflicted versions of OpenSBI
> are present & set the "no-map" property in all "mmode_resv" nodes before
> the kernel does its reserved memory region initialisation.
> 
> Reported-by: Song Shuai <suagrfillet@gmail.com>
> Link: https://lore.kernel.org/all/CAAYs2=gQvkhTeioMmqRDVGjdtNF_vhB+vm_1dHJxPNi75YDQ_Q@mail.gmail.com/
> Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6z8
> Reported-by: Petr Tesarik <petrtesarik@huaweicloud.com>
> Closes: https://lore.kernel.org/linux-riscv/76ff0f51-d6c1-580d-f943-061e93073306@huaweicloud.com/ [1]
> CC: stable@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/sbi.h |  5 +++++
>  arch/riscv/kernel/sbi.c      | 42 +++++++++++++++++++++++++++++++++++-
>  arch/riscv/mm/init.c         |  3 +++
>  3 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 5b4a1bf5f439..5360f3476278 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -252,6 +252,9 @@ enum sbi_pmu_ctr_type {
>  #define SBI_ERR_ALREADY_STARTED -7
>  #define SBI_ERR_ALREADY_STOPPED -8
> 
> +/* SBI implementation IDs */
> +#define SBI_IMP_OPENSBI	1
I would suggest to create an enum struct for the SBI Imp ID in the sbi.h file. What do you think?
> +
>  extern unsigned long sbi_spec_version;
>  struct sbiret {
>  	long error;
> @@ -259,6 +262,8 @@ struct sbiret {
>  };
> 
>  void sbi_init(void);
> +void sbi_apply_reserved_mem_erratum(void *dtb_va);
> +
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  			unsigned long arg1, unsigned long arg2,
>  			unsigned long arg3, unsigned long arg4,
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index c672c8ba9a2a..aeb27263fa53 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -5,8 +5,10 @@
>   * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>   */
> 
> +#include <linux/acpi.h>
>  #include <linux/bits.h>
>  #include <linux/init.h>
> +#include <linux/libfdt.h>
>  #include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <asm/sbi.h>
> @@ -583,6 +585,40 @@ long sbi_get_mimpid(void)
>  }
>  EXPORT_SYMBOL_GPL(sbi_get_mimpid);
> 
> +static long sbi_firmware_id;
> +static long sbi_firmware_version;
> +
> +/*
> + * For devicetrees patched by OpenSBI a "mmode_resv" node is added to cover
> + * the region OpenSBI has protected by means of a PMP. Some versions of OpenSBI,
> + * [v0.8 to v1.3), omitted the "no-map" property, but this trips up hibernation
> + * among other things.
> + */
> +void __init sbi_apply_reserved_mem_erratum(void *dtb_pa)
> +{
> +	int child, reserved_mem;
> +
> +	if (sbi_firmware_id != SBI_IMP_OPENSBI)
> +		return;
> +
> +	if (!acpi_disabled)
> +		return;
> +
> +	if (sbi_firmware_version >= 0x10003 || sbi_firmware_version < 0x8)
> +		return;
> +
> +	reserved_mem = fdt_path_offset((void *)dtb_pa, "/reserved-memory");
> +	if (reserved_mem < 0)
> +		return;
> +
> +	fdt_for_each_subnode(child, (void *)dtb_pa, reserved_mem) {
> +		const char *name = fdt_get_name((void *)dtb_pa, child, NULL);
> +
> +		if (!strncmp(name, "mmode_resv", 10))
> +			fdt_setprop((void *)dtb_pa, child, "no-map", NULL, 0);
> +	}
> +};
> +
>  void __init sbi_init(void)
>  {
>  	int ret;
> @@ -596,8 +632,12 @@ void __init sbi_init(void)
>  		sbi_major_version(), sbi_minor_version());
> 
>  	if (!sbi_spec_is_0_1()) {
> +		sbi_firmware_id = sbi_get_firmware_id();
> +		sbi_firmware_version = sbi_get_firmware_version();
> +
>  		pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
> -			sbi_get_firmware_id(), sbi_get_firmware_version());
> +			sbi_firmware_id, sbi_firmware_version);
> +
>  		if (sbi_probe_extension(SBI_EXT_TIME)) {
>  			__sbi_set_timer = __sbi_set_timer_v02;
>  			pr_info("SBI TIME extension detected\n");
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 70fb31960b63..cb16bfdeacdb 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -29,6 +29,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/sections.h>
>  #include <asm/soc.h>
> +#include <asm/sbi.h>
>  #include <asm/io.h>
>  #include <asm/ptdump.h>
>  #include <asm/numa.h>
> @@ -253,6 +254,8 @@ static void __init setup_bootmem(void)
>  	 * in the device tree, otherwise the allocation could end up in a
>  	 * reserved region.
>  	 */
> +
> +	sbi_apply_reserved_mem_erratum(dtb_early_va);
>  	early_init_fdt_scan_reserved_mem();
> 
>  	/*
> --
> 2.40.1

