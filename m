Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9B80DB26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbjLKT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjLKT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:57:55 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC63D5;
        Mon, 11 Dec 2023 11:58:01 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12BBA40E00CC;
        Mon, 11 Dec 2023 19:57:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zj-MLt3KMPAk; Mon, 11 Dec 2023 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702324675; bh=IVpOW3xZoonpLNrLg9Is3P4VLEpRfDjVNUSGnDcGk3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFPwmABA+SdHS4h79qRKi8hIpca46T03af5ECVgolQ9Jpi5dThDVQsccNh0pW96hE
         RNQj1C5Cst6+HseJi9QHo2xMkzFY3CiA40/gdu64eK8AgisbuaomM/BZIL9fa2b5sN
         Wa2xBl5itkXRlpkMHgsp38mnJqHxzwOLmyp+rb0j1fUc+Jt1fjS+kZbL3MefYdcmTF
         +KkT3EVvOOBihHynbQC7/5vGJF2qfymZ42qhUVW7EAioHvhgT9WRhAuCgkDzrLsMHC
         ArK2jwYNeOOmJ3YKJT+JYJHRrPV4M5pyED20csf4MZlXQTvl/niqo393/nVnspyv+g
         g+P3vTPV+tCnDgu/jYUr3GgSyWdKNdtAY5Q+2qG1B5cclZkh0azBw0t2MRHJfKzJeI
         c4BBZe1/G0i8V9+5MHoSl2x2+6JCUBjnE31+qR5CvEl9qENX0AhRLu3Xh0JSaVdcm3
         EaKWVMvX1TMpxEgedkTucL00Mcf6dSbAir2kPhTCkbpQoogS0iHE25y4EKs7IVAdeC
         wazPWnbIhSvZaQPnqLmxLaAThjolpNKt/wd9Qhj7cEKTebsVXCe8JPIC/00vc+XERj
         Z2isvMQJTifBYQNj02hZUOjZlqTJp6khIe/OTbVV3+kEWDhCpF/91lW9xoZw0YD9n2
         JR0zJyaE7CASCalQ+ruPNBS8=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5A0B40E00C6;
        Mon, 11 Dec 2023 19:57:45 +0000 (UTC)
Date:   Mon, 11 Dec 2023 20:57:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231211195739.GIZXdps9DNvOgCR5Xs@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210194932.43992-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> new file mode 100644
> index 000000000000..6a6220fef81f
> --- /dev/null
> +++ b/drivers/ras/amd/atl/core.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Address Translation Library
> + *
> + * core.c : Module init and base translation functions
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#include <linux/module.h>
> +#include <asm/cpu_device_id.h>
> +
> +#include "internal.h"
> +
> +struct df_config df_cfg __read_mostly;
> +
> +static int addr_over_limit(struct addr_ctx *ctx)
> +{
> +	u64 dram_limit_addr;
> +
> +	if (df_cfg.rev >= DF4)
> +		dram_limit_addr  = FIELD_GET(DF4_DRAM_LIMIT_ADDR, ctx->map.limit);
> +	else
> +		dram_limit_addr  = FIELD_GET(DF2_DRAM_LIMIT_ADDR, ctx->map.limit);

One too many spaces before the '='.

> +
> +	dram_limit_addr <<= DF_DRAM_BASE_LIMIT_LSB;
> +	dram_limit_addr |= GENMASK(DF_DRAM_BASE_LIMIT_LSB - 1, 0);
> +
> +	/* Is calculated system address above DRAM limit address? */
> +	if (ctx->ret_addr > dram_limit_addr) {
> +		warn_on_assert("Calculated address (0x%016llx) > DRAM limit (0x%016llx)",

Hmm, where is the "assert" aspect of that macro?

It looks to me more like atl_warn() type thing which you define for your
driver to do special stuff.

Also, are you sure you want to dump it here on every attempted SPA
conversion?

I guess yes. I'm just worried that it might become too noisy but we'll
fix it later if that turns out to be the case...

> +			       ctx->ret_addr, dram_limit_addr);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool legacy_hole_en(struct addr_ctx *ctx)
> +{
> +	u32 reg = ctx->map.base;
> +
> +	if (df_cfg.rev >= DF4)
> +		reg = ctx->map.ctl;
> +
> +	return FIELD_GET(DF_LEGACY_MMIO_HOLE_EN, reg);
> +}
> +
> +static int add_legacy_hole(struct addr_ctx *ctx)
> +{
> +	u32 dram_hole_base;
> +	u8 func = 0;
> +
> +	if (!legacy_hole_en(ctx))
> +		return 0;
> +
> +	if (df_cfg.rev >= DF4)
> +		func = 7;
> +
> +	if (df_indirect_read_broadcast(ctx->node_id, func, 0x104, &dram_hole_base))
> +		return -EINVAL;
> +
> +	dram_hole_base &= DF_DRAM_HOLE_BASE_MASK;
> +
> +	if (ctx->ret_addr >= dram_hole_base)
> +		ctx->ret_addr += (BIT_ULL(32) - dram_hole_base);
> +
> +	return 0;
> +}
> +
> +static u64 get_base_addr(struct addr_ctx *ctx)
> +{
> +	u64 base_addr;
> +
> +	if (df_cfg.rev >= DF4)
> +		base_addr = FIELD_GET(DF4_BASE_ADDR, ctx->map.base);
> +	else
> +		base_addr = FIELD_GET(DF2_BASE_ADDR, ctx->map.base);
> +
> +	return base_addr << DF_DRAM_BASE_LIMIT_LSB;
> +}
> +
> +static int add_base_and_hole(struct addr_ctx *ctx)
> +{
> +	ctx->ret_addr += get_base_addr(ctx);
> +
> +	if (add_legacy_hole(ctx))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static bool late_hole_remove(struct addr_ctx *ctx)
> +{
> +	if (df_cfg.rev == DF3p5)
> +		return true;
> +
> +	if (df_cfg.rev == DF4)
> +		return true;
> +
> +	if (ctx->map.intlv_mode == DF3_6CHAN)
> +		return true;
> +
> +	return false;
> +}
> +
> +int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
								^^^^^^^^^

Can we not do that? Output function parameters.

Are all addr values valid or is there an invalid one - -1 for example
- which you can use as an error value?

And then you can turn this into:

unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, unsigned long addr)

and callers can do IS_ERR_VALUE(ret) on the return value.

See include/linux/err.h

> +{
> +	struct addr_ctx ctx;
> +
> +	if (df_cfg.rev == UNKNOWN)
> +		return -EINVAL;
> +
> +	memset(&ctx, 0, sizeof(ctx));
> +
> +	/* We start from the normalized address */

s/We start/Start/

> +	ctx.ret_addr = *addr;
> +	ctx.inst_id = cs_inst_id;
> +
> +	ctx.inputs.norm_addr = *addr;
> +	ctx.inputs.socket_id = socket_id;
> +	ctx.inputs.die_id = die_id;
> +	ctx.inputs.cs_inst_id = cs_inst_id;
> +
> +	if (determine_node_id(&ctx, socket_id, die_id))
> +		return -EINVAL;
> +
> +	if (get_address_map(&ctx))
> +		return -EINVAL;
> +
> +	if (denormalize_address(&ctx))
> +		return -EINVAL;
> +
> +	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> +		return -EINVAL;
> +
> +	if (dehash_address(&ctx))
> +		return -EINVAL;
> +
> +	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx))
> +		return -EINVAL;
> +
> +	if (addr_over_limit(&ctx))
> +		return -EINVAL;
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
> +static const struct x86_cpu_id amd_atl_cpuids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_SMCA, NULL),

I'd expect for only this one to be needed, but not those below.

> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),
> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN2, NULL),
> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN3, NULL),
> +	X86_MATCH_FEATURE(X86_FEATURE_ZEN4, NULL),
> +	{ }
> +};

To be continued...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
