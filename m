Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E07C5A51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjJKRf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjJKRfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:35:53 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65CC6;
        Wed, 11 Oct 2023 10:35:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 72F4E40E01AE;
        Wed, 11 Oct 2023 17:35:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KhXu90p_PwGC; Wed, 11 Oct 2023 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697045742; bh=2xE0gmi6Ttg1IOKKswsLnW0YDrM5m1naoQQoUeXdZMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIC8f4BNnzOrjZk3Hk6+G3rcFIIAI6ZooPyYIpdlGhaHvDTjGiv2AXd1ipHYVI85k
         fDmQZ3DMm6hSYPJUK2zZbjMoM9ce8box2B5f1IHFvcqRNamSM3C5yLqd6Vk5M6hcLQ
         4/Syf0qvAPoJ/13k0htAPH4C8fcehpnrxim7p9BW8WKo+bWRlWlo4OmN7fDkzWYiO/
         fnsqKMZX4sLW0i9NgjT1+H2rNmrnPNsBMzgCIAQ+unWy+hYbRuxpbrbk/52tzVr8tb
         07fWODJl/q/PM+7AMLGq6lwFtdHfY8NNyaKFQf0FRdQOWNKDgaJMg403GJxPSxWTx+
         10qel6O85+PAz2ZIFe9Ar4eU+lQ6qxbNr/qcCSWo56aHU8IJlgJUfx10cvXCazOCoJ
         JEHymbvYMQs+DpJI8SzcsW48PIzwNu4Y9lW0nO/eT3xsVHM+9pGX2hB4XmaRVsaAp5
         hUbHw2ucNdU9yFHMkPMi7Hm5vjZpN36hdWKkUTrBo+A1BbbwoFV4/SP1re9Ybxxdaf
         ac2m/rQtk5Mgln4PB+fMZF9Wk4bg/U/VUIAHW0UmhlHWrQn3AoGLYJ2q/tALW6pAni
         nrkoTxfee68eqxWoXOJMPdYD0/lNs75PND/jyjMt6jEsUPuFPs9f4UfTGq4jJF3UuK
         1hGmGO505sHFmjjocBudfSJA=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A4CA40E01A5;
        Wed, 11 Oct 2023 17:35:35 +0000 (UTC)
Date:   Wed, 11 Oct 2023 19:35:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
Message-ID: <20231011173528.GUZSbc4Ag03d9Xastz@fat_crate.local>
References: <20231005173526.42831-1-yazen.ghannam@amd.com>
 <20231005173526.42831-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231005173526.42831-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 12:35:25PM -0500, Yazen Ghannam wrote:
> AMD Zen-based systems report memory errors through Machine Check banks
> representing Unified Memory Controllers (UMCs). The address value
> reported for DRAM ECC errors is a "normalized address" that is relative
> to the UMC. This normalized address must be converted to a system
> physical address to be usable by the OS.
> 
> Support for this address translation was introduced to the MCA subsystem
> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
> since this was the only user of the code at the time.
> 
> However, there are uses for this translation outside of EDAC. The system
> physical address can be used in MCA for preemptive page offlining as done
> in some MCA notifier functions. Also, this translation is needed as the
> basis of similar functionality needed for some CXL configurations on AMD
> systems.
> 
> Introduce a common address translation library that can be used for
> multiple subsystems including MCA, EDAC, and CXL.
> 
> Include support for UMC normalized to system physical address
> translation for current CPU systems.
> 
> Future development to include:
> - DF4.5 Non-power-of-2 interleaving modes.
> - Heterogeneous CPU+GPU system support.
> - CXL translation support.
> - Caching of common intermediate values and results.
> - Leverage UEFI PRM methods as alternate backends to existing native
>   code.

That last preview-of-things-to-come paragraph can go. Not needed here.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35977b269d5e..5a286cb8e7f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -891,6 +891,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
>  F:	drivers/infiniband/hw/efa/
>  F:	include/uapi/rdma/efa-abi.h
>  
> +AMD ADDRESS TRANSLATION LIBRARY (ATL)
> +M:	Yazen Ghannam <Yazen.Ghannam@amd.com>
> +L:	linux-edac@vger.kernel.org
> +S:	Supported

"Maintained" right?

Otherwise

./scripts/get_maintainer.pl -f drivers/ras/amd/atl/access.c
Yazen Ghannam <Yazen.Ghannam@amd.com> (supporter:AMD ADDRESS TRANSLATION LIBRARY (ATL))
Tony Luck <tony.luck@intel.com> (maintainer:RAS INFRASTRUCTURE)
Borislav Petkov <bp@alien8.de> (maintainer:RAS INFRASTRUCTURE)

I'm not maintaining it. :-P

> +#define DF_BROADCAST		0xFF
> +
> +#define DF_FICAA_INST_EN	BIT(0)
> +#define DF_FICAA_REG_NUM	GENMASK(10, 1)
> +#define DF_FICAA_FUNC_NUM	GENMASK(13, 11)
> +#define DF_FICAA_INST_ID	GENMASK(23, 16)
> +
> +/* Register field changed in new systems. */

I don't understand that comment.

> +#define DF_FICAA_REG_NUM_LEGACY	GENMASK(10, 2)
> +
> +static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
> +{
> +	u32 ficaa_addr = 0x8C, ficad_addr = 0xB8;
> +	struct pci_dev *F4;
> +	int err = -ENODEV;
> +	u32 ficaa = 0;
> +
> +	if (node >= amd_nb_num())
> +		goto out;
> +
> +	F4 = node_to_amd_nb(node)->link;
> +	if (!F4)
> +		goto out;
> +
> +	/* Enable instance-specific access. */
> +	if (instance_id != DF_BROADCAST) {
> +		ficaa |= FIELD_PREP(DF_FICAA_INST_EN, 1);
> +		ficaa |= FIELD_PREP(DF_FICAA_INST_ID, instance_id);

Dunno, this is understandable to me:

		ficaa |= (DF_FICAA_INST_EN << 1) |
			 (DF_FICAA_INST_ID << instance_id);

All that FIELD_* macro crap not.

What's the advantage of using them? The additional build checks?

The code is a lot less readable with those things IMO.

> +int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
> +{
> +	struct addr_ctx ctx;
> +
> +	if (df_cfg.rev == UNKNOWN)
> +		return -EINVAL;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +
> +	/* We start from the normalized address */
> +	ctx.ret_addr = *addr;
> +	ctx.inst_id = cs_inst_id;
> +
> +	if (determine_node_id(&ctx, socket_id, die_id)) {
> +		pr_warn("Failed to determine Node ID");
> +		return -EINVAL;
> +	}
> +
> +	if (get_address_map(&ctx)) {
> +		pr_warn("Failed to get address maps");
> +		return -EINVAL;
> +	}
> +
> +	if (denormalize_address(&ctx)) {
> +		pr_warn("Failed to denormalize address");
> +		return -EINVAL;
> +	}
> +
> +	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx)) {
> +		pr_warn("Failed to add DRAM base address and hole");
> +		return -EINVAL;
> +	}
> +
> +	if (dehash_address(&ctx)) {
> +		pr_warn("Failed to dehash address");
> +		return -EINVAL;
> +	}
> +
> +	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx)) {
> +		pr_warn("Failed to add DRAM base address and hole");
> +		return -EINVAL;
> +	}
> +
> +	if (addr_over_limit(&ctx)) {
> +		pr_warn("Calculated address is over limit");
> +		return -EINVAL;

All those error messages do not dump the address they failed to process
and if you have multiple failures, you can't know which address they're
talking about.

I think it would be better if you have the respective functions state
the failure and also dump the relevant address/bits/etc which can help
the user debug this further. And remove the warns here.

Then, if the user can't do anything about the error, then you don't need
to say anything either but simply return -EINVAL from this function and
the upper layers would simply report the error.

> +	}
> +
> +	*addr = ctx.ret_addr;
> +	return 0;
> +}
> +
> +static void check_for_legacy_df_access(void)
> +{
> +	/*
> +	 * All Zen-based systems before Family 19h use the legacy
> +	 * DF Indirect Access (FICAA/FICAD) offsets.
> +	 */
> +	if (boot_cpu_data.x86 < 0x19) {
> +		df_cfg.flags.legacy_ficaa = true;
> +		return;
> +	}
> +
> +	/* All systems after Family 19h use the current offsets. */
> +	if (boot_cpu_data.x86 > 0x19)
> +		return;
> +
> +	/* Some Family 19h systems use the legacy offsets. */
> +	switch (boot_cpu_data.x86_model) {
> +	case 0x00 ... 0x0f:
> +	case 0x20 ... 0x5f:
> +	       df_cfg.flags.legacy_ficaa = true;
> +	}

> +}
> +
> +static int __init amd_atl_init(void)
> +{
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return -ENODEV;

That thing should use a MODULE_DEVICE_TABLE with a

X86_MATCH_VENDOR_FAM(AMD, X86_FAMILY_ANY, ...)

in it.

> +	check_for_legacy_df_access();
> +
> +	/*
> +	 * Not sure if this should return an error code.
> +	 * That may prevent other modules from loading.

Why would this prevent other modules from loading?

> +	 * For now, don't fail out. The translation function
> +	 * will do a check and return early if the DF revision
> +	 * is not set.
> +	 */
> +	if (get_df_system_info()) {
> +		pr_warn("Failed to get DF information");
> +		df_cfg.rev = UNKNOWN;
> +	}

No, you want to return an error here and not load the ATL - it is dead
code.

> +	pr_info("AMD Address Translation Library initialized");
> +	return 0;
> +}
> +
> +static void __exit amd_atl_exit(void)
> +{
> +}
> +
> +module_init(amd_atl_init);
> +module_exit(amd_atl_exit);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> new file mode 100644
> index 000000000000..e501f2e918d7
> --- /dev/null
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Address Translation Library
> + *
> + * dehash.c : Functions to account for hashing bits
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#include "internal.h"
> +
> +static int df2_dehash_addr(struct addr_ctx *ctx)
> +{
> +	u8 hashed_bit, intlv_bit;
> +
> +	/* Assert that interleave bit is 8 or 9. */
> +	if (ctx->map.intlv_bit_pos != 8 && ctx->map.intlv_bit_pos != 9) {
> +		pr_warn("%s: Invalid interleave bit: %u",
> +			__func__, ctx->map.intlv_bit_pos);
> +		return -EINVAL;
> +	}
> +
> +	/* Assert that die and socket interleaving are disabled. */
> +	if (ctx->map.num_intlv_dies > 1) {
> +		pr_warn("%s: Invalid number of interleave dies: %u",
> +			__func__, ctx->map.num_intlv_dies);
> +		return -EINVAL;
> +	}
> +
> +	if (ctx->map.num_intlv_sockets > 1) {
> +		pr_warn("%s: Invalid number of interleave sockets: %u",
> +			__func__, ctx->map.num_intlv_sockets);
> +		return -EINVAL;
> +	}

That sanity-checking is almost identical and repeated across a bunch of
functions. Pls carve out into a helper.

...

> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
> new file mode 100644
> index 000000000000..fe1480c8e0d8
> --- /dev/null
> +++ b/drivers/ras/amd/atl/denormalize.c
> @@ -0,0 +1,644 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Address Translation Library
> + *
> + * denormalize.c : Functions to account for interleaving bits
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#include "internal.h"
> +
> +/*
> + * Returns the Destination Fabric ID. This is the first (lowest)
> + * CS Fabric ID used within a DRAM Address map.
> + */
> +static u16 get_dst_fabric_id(struct addr_ctx *ctx)
> +{
> +	switch (df_cfg.rev) {
> +	case DF2:
> +		return FIELD_GET(DF2_DST_FABRIC_ID, ctx->map.limit);
> +	case DF3:
> +		return FIELD_GET(DF3_DST_FABRIC_ID, ctx->map.limit);
> +	case DF3p5:
> +		return FIELD_GET(DF3p5_DST_FABRIC_ID, ctx->map.limit);
> +	case DF4:
> +		return FIELD_GET(DF4_DST_FABRIC_ID, ctx->map.ctl);
> +	case DF4p5:
> +		return FIELD_GET(DF4p5_DST_FABRIC_ID, ctx->map.ctl);

You can put each case on a single line:

	case DF2:	return... ;
	case DF3:	return... ;

and so on.

> +	default:
> +		ATL_BAD_DF_REV;

Ew, this is ugly. Make that and ATL_BAD_INTLV_MODE into simple inline
functions which you can call.

> +		return 0;
> +	}
> +}
> +
> +/*
> + * Make a contiguous gap in address for N bits starting at bit P.
> + *
> + * Example:
> + * address bits:		[20:0]
> + * # of interleave bits    (n):	3
> + * starting interleave bit (p):	8
> + *
> + * expanded address bits:	[20+n : n+p][n+p-1 : p][p-1 : 0]
> + *				[23   :  11][10    : 8][7   : 0]

Very nice!

> +static u64 make_space_for_cs_id(struct addr_ctx *ctx)
> +{
> +	switch (ctx->map.intlv_mode) {
> +	case NOHASH_2CHAN:
> +	case NOHASH_4CHAN:
> +	case NOHASH_8CHAN:
> +	case NOHASH_16CHAN:
> +	case NOHASH_32CHAN:
> +	case DF2_2CHAN_HASH:
> +		return make_space_for_cs_id_at_intlv_bit(ctx);
> +
> +	case DF3_COD4_2CHAN_HASH:
> +	case DF3_COD2_4CHAN_HASH:
> +	case DF3_COD1_8CHAN_HASH:
> +	case DF4_NPS4_2CHAN_HASH:
> +	case DF4_NPS2_4CHAN_HASH:
> +	case DF4_NPS1_8CHAN_HASH:
> +	case DF4p5_NPS4_2CHAN_1K_HASH:
> +	case DF4p5_NPS4_2CHAN_2K_HASH:
> +	case DF4p5_NPS2_4CHAN_2K_HASH:
> +	case DF4p5_NPS1_8CHAN_2K_HASH:
> +	case DF4p5_NPS1_16CHAN_2K_HASH:
> +		return make_space_for_cs_id_split_2_1(ctx);
> +
> +	case DF4p5_NPS2_4CHAN_1K_HASH:
> +		//TODO

As discussed offlist, pls fix those.

> +	case DF4p5_NPS1_8CHAN_1K_HASH:
> +		//TODO
> +	case DF4p5_NPS1_16CHAN_1K_HASH:
> +		//TODO
> +	default:
> +		ATL_BAD_INTLV_MODE(ctx->map.intlv_mode);
> +		return ~0ULL;
> +	}
> +}
> +

...

> +static u16 get_cs_id_df4(struct addr_ctx *ctx)
> +{
> +	/*
> +	 * Start with the original component mask and the number of interleave
> +	 * bits for the channels in this map.
> +	 */
> +	u8 num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
> +	u16 mask = df_cfg.component_id_mask;
> +
> +	u16 socket_bits;
> +
> +	/* Set the derived CS ID to the input CS Fabric ID. */
> +	u16 cs_id = ctx->cs_fabric_id & mask;
> +
> +	/*
> +	 * Subtract the "base" Destination Fabric ID.
> +	 * This accounts for systems with disabled Coherent Stations.
> +	 */
> +	cs_id -= get_dst_fabric_id(ctx) & mask;
> +
> +	/*
> +	 * Generate and use a new mask based on the number of bits
> +	 * needed for channel interleaving in this map.
> +	 */
> +	mask = GENMASK(num_intlv_bits - 1, 0);
> +	cs_id &= mask;
> +
> +	/* Done if socket interleaving is not enabled. */
> +	if (ctx->map.num_intlv_sockets <= 1)
> +		return cs_id;
> +
> +	/*
> +	 * Figure out how many bits are needed for the number of
> +	 * interleaved sockets. And shift the derived CS ID to account
> +	 * for these.
> +	 */
> +	num_intlv_bits = ilog2(ctx->map.num_intlv_sockets);
> +	cs_id <<= num_intlv_bits;
> +
> +	/* Generate a new mask for the socket interleaving bits. */
> +	mask = GENMASK(num_intlv_bits - 1, 0);
> +
> +	/* Get the socket interleave bits from the original CS Fabric ID. */
> +	socket_bits = (ctx->cs_fabric_id & df_cfg.socket_id_mask) >> df_cfg.socket_id_shift;
> +
> +	/* Apply the appropriate socket bits to the derived CS ID. */
> +	cs_id |= socket_bits & mask;
> +
> +	return cs_id;
> +}

Those are some good comments above, cool.

> +
> +/*
> + * Derive the correct CS ID that represents the interleave bits
> + * used within the system physical address. This accounts for the
> + * interleave mode, number of interleaved channels/dies/sockets, and
> + * other system/mode-specific bit swizzling.

    * Returns: ... on success.
    	       ... on error.

...


> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> new file mode 100644
> index 000000000000..f3888c8fd02d
> --- /dev/null
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -0,0 +1,307 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD Address Translation Library
> + *
> + * internal.h : Helper functions and common defines
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#ifndef __AMD_ATL_INTERNAL_H__
> +#define __AMD_ATL_INTERNAL_H__
> +
> +#include <asm/amd_nb.h>
> +
> +#include <linux/amd-atl.h>

Is this file in the linux/ namespace because of CXL which is somewhere
in drivers?

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +
> +#include "reg_fields.h"

Include namespaces are in that order:

	linux/
	asm/
	"internal"

> +
> +/* Maximum possible number of Coherent Stations within a single Data Fabric. */
> +#define MAX_CS_CHANNELS			32
> +
> +/* PCI IDs for Genoa DF Function 0. */
> +#define DF_FUNC0_ID_GENOA		0x14AD1022

Genoa is an internal name - pls use Zen4 or so. Change "genoa_quirk"
too.

> +
> +/* Shift needed for adjusting register values to true values. */
> +#define DF_DRAM_BASE_LIMIT_LSB		28
> +
> +/*
> + * Glossary of acronyms used in address translation for Zen-based systems
> + *
> + * CCM		= Cache Coherent Moderator
> + * COD		= Cluster-on-Die
> + * CS		= Coherent Station
> + * DF		= Data Fabric

We have edac.rst for such things.

...

> +/*
> + * Make a gap in 'data' that is 'num_bits' long starting at 'bit_num.
> + * e.g. data		= 11111111'b
> + *	bit_num		= 3
> + *	num_bits	= 2
> + *	result		= 1111100111'b
> + */
> +static inline u64 expand_bits(u8 bit_num, u8 num_bits, u64 data)
> +{
> +	u64 temp1, temp2;
> +
> +	/*
> +	 * Return the orginal data if the "space" needed is '0'.

"original".

Run through spellchecker pls.

> +	 * This helps avoid the need to check for '0' at each
> +	 * caller.
> +	 */
> +	if (!num_bits)
> +		return data;
> +
> +	if (!bit_num)
> +		return data << num_bits;
> +
> +	temp1 = data & GENMASK_ULL(bit_num - 1, 0);
> +
> +	temp2 = data & GENMASK_ULL(63, bit_num);
> +	temp2 <<= num_bits;
> +
> +	return temp1 | temp2;
> +}
> +

...

> +/*
> + * Some, but not all, cases have asserts.
> + * So use return values to indicate failure where needed.
> + */
> +static int get_intlv_mode(struct addr_ctx *ctx)
> +{
> +	switch (df_cfg.rev) {
> +	case DF2:
> +		return df2_get_intlv_mode(ctx);
> +	case DF3:
> +		return df3_get_intlv_mode(ctx);
> +	case DF3p5:
> +		return df3p5_get_intlv_mode(ctx);
> +	case DF4:
> +		return df4_get_intlv_mode(ctx);
> +	case DF4p5:
> +		return df4p5_get_intlv_mode(ctx);

Put each case on a single line.

> +	default:
> +		ATL_BAD_DF_REV;
> +		return -EINVAL;
> +	}
> +}


...

> +static int get_dram_addr_map(struct addr_ctx *ctx)
> +{
> +	switch (df_cfg.rev) {
> +	case DF2:
> +		return df2_get_dram_addr_map(ctx);
> +	case DF3:
> +	case DF3p5:
> +		return df3_get_dram_addr_map(ctx);
> +	case DF4:
> +		return df4_get_dram_addr_map(ctx);
> +	case DF4p5:
> +		return df4p5_get_dram_addr_map(ctx);

Also on single line.

> +	default:
> +		ATL_BAD_DF_REV;
> +		return -EINVAL;
> +	}
> +}
> +
> +static int lookup_cs_fabric_id(struct addr_ctx *ctx)
> +{
> +	u32 reg;
> +
> +	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
> +	if (df_indirect_read_instance(ctx->node_id, 0, 0x50, ctx->inst_id, &reg))
> +		return -EINVAL;
> +
> +	if (df_cfg.rev < DF4p5)
> +		ctx->cs_fabric_id = FIELD_GET(DF2_CS_FABRIC_ID, reg);
> +	else
> +		ctx->cs_fabric_id = FIELD_GET(DF4p5_CS_FABRIC_ID, reg);
> +
> +	return 0;
> +}
> +
> +static int get_cs_fabric_id(struct addr_ctx *ctx)
> +{
> +	/* TODO: Add special path for DF3.5 heterogeneous systems. */

No TODOs - you return an error for unsupported systems until that
support comes.

> +	return lookup_cs_fabric_id(ctx);
> +}

...

> +int get_address_map(struct addr_ctx *ctx)
> +{
> +	int ret = 0;
> +
> +	/* TODO: Add special path for DF3.5 heterogeneous systems. */

Ditto.

> +	ret = get_address_map_common(ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (get_global_map_data(ctx))
> +		return -EINVAL;
> +
> +	dump_address_map(&ctx->map);
> +
> +	return ret;
> +}

...

...

> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> new file mode 100644
> index 000000000000..80030db6b8a5
> --- /dev/null
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Address Translation Library
> + *
> + * umc.c : Unified Memory Controller (UMC) topology helpers
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#include "internal.h"
> +
> +static u8 get_socket_id(struct mce *m)
> +{
> +	return m->socketid;
> +}

Looks useless.

> +
> +static u8 get_die_id(struct mce *m)
> +{
> +	/*
> +	 * For CPUs, this is the AMD Node ID modulo the number
> +	 * of AMD Nodes per socket.
> +	 */
> +	return topology_die_id(m->extcpu) % amd_get_nodes_per_socket();
> +}
> +
> +static u64 get_norm_addr(struct mce *m)
> +{
> +	return m->addr;
> +}

Ditto.

> +
> +#define UMC_CHANNEL_NUM	GENMASK(31, 20)
> +static u8 get_cs_inst_id(struct mce *m)
> +{
> +	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
> +}
> +
> +int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
> +{
> +	u8 cs_inst_id = get_cs_inst_id(m);
> +	u8 socket_id = get_socket_id(m);
> +	u64 addr = get_norm_addr(m);
> +	u8 die_id = get_die_id(m);
> +
> +	if (norm_to_sys_addr(socket_id, die_id, cs_inst_id, &addr))
> +		return -EINVAL;
> +
> +	*sys_addr = addr;
> +	return 0;
> +}

PA 0 is an invalid address, right?

So can this function return 0 on error or the actual PA on success so
that you don't need the IO *sys_addr argument?

> +EXPORT_SYMBOL_GPL(umc_mca_addr_to_sys_addr);

That's an AMD-specific function so:

	amd_convert_mca_addr_to_sys_addr();

with a verb in the name and so on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
