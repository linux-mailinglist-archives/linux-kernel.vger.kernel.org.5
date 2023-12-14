Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C7F813322
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573481AbjLNOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:30:19 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A190132;
        Thu, 14 Dec 2023 06:30:25 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1393F40E0140;
        Thu, 14 Dec 2023 14:30:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gAPdoYuNOTGW; Thu, 14 Dec 2023 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702564221; bh=LK/AU/A+aF7T8cXp3zZKCi7x8DkBYfCbgQoPPthBTN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFYbKciB1F2hqGU/NaNH5wSl7D3an8RkGmtHn38OvfNloOSgg0pPqMr85BKCRE6kO
         WmIVFxZdB/VHOqrDLnxcJ0iK2Pd03njhB/oP4gLuzZ+yLqQld3GdQ1Ij/R0uCJ4v25
         wdGQ2RMZ6BCfDvw89suYoIgtikqSax2S4vJkIj5RyCww9EP/JDx27tA1Uqkea12lLH
         L3JX7WMElth6Zl+X0+E3C0e2FmcCagartPcHZHBLRkHBNWS8uzxskk12wjT7tJwLX1
         P998+6ZfEfTbreH2d1l3p91gfQLPPBJB0Rxkb+K68Rt+A9qwK1tGjVFoF+uOhoo3fW
         xJASeqqZOrGbzOi+XBPRPdlzDjDf8o+IU+M4rCp76BWsJqKKu3iruQXXdVzaKyYkmY
         +u5Yg8v5vge7UtNSoRqQ0AaCJ7sOvj1qwKRknZSv06hHlHh2j7AmGEuiGFQipQs6Xh
         1CVnsLo4H4b3ecLkmc19s+z8Spgb1l4jTEK+VeH9HNUHCKsSeakj+2wvcomAYf6MdR
         KuFoiR76UesmnaMLZAhmVUfCx5NXIdyU2C7vQ2Wbcf8RwGEJqN5BVufCAEUavdpsl2
         Ti513mNkem82OebKfJuoc0NJv9QmdZuenHULqBfBG1O5RBlbKqKas/f/OQI3O4IpSE
         Yn2JtH4oW7qbYSoDD4GCBN08=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E8B0C40E00CD;
        Thu, 14 Dec 2023 14:30:11 +0000 (UTC)
Date:   Thu, 14 Dec 2023 15:30:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231214143005.GNZXsRbcALa1/TW2OK@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210194932.43992-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
> +/*
> + * Some, but not all, cases have asserts.
> + * So use return values to indicate failure where needed.
> + */

No need for that comment.

> +static int get_intlv_mode(struct addr_ctx *ctx)
> +{
> +	switch (df_cfg.rev) {
> +	case DF2:	return df2_get_intlv_mode(ctx);
> +	case DF3:	return df3_get_intlv_mode(ctx);
> +	case DF3p5:	return df3p5_get_intlv_mode(ctx);
> +	case DF4:	return df4_get_intlv_mode(ctx);
> +	case DF4p5:	return df4p5_get_intlv_mode(ctx);
> +	default:
> +			warn_on_bad_df_rev();
> +			return -EINVAL;
> +	}

You can warn once here instead of the callers:

	int ret;

	switch () {
		... ret = ...get_intlv_mode();
		...
	default:
		ret = -EINVAL;
	}

	if (ret)
		warn_on_bad_df_rev();

	return ret;

and save some text lines.

> +}
> +
> +static u64 get_hi_addr_offset(u32 reg_dram_offset)
> +{
> +	u8 shift = DF_DRAM_BASE_LIMIT_LSB;
> +	u64 hi_addr_offset = 0;

Move that assignment to 0...

> +
> +	switch (df_cfg.rev) {
> +	case DF2:
> +		hi_addr_offset = FIELD_GET(DF2_HI_ADDR_OFFSET, reg_dram_offset);
> +		break;
> +	case DF3:
> +	case DF3p5:
> +		hi_addr_offset = FIELD_GET(DF3_HI_ADDR_OFFSET, reg_dram_offset);
> +		break;
> +	case DF4:
> +	case DF4p5:
> +		hi_addr_offset = FIELD_GET(DF4_HI_ADDR_OFFSET, reg_dram_offset);
> +		break;
> +	default:

... here.

<---

> +		warn_on_bad_df_rev();
> +	}
> +
> +	return hi_addr_offset << shift;
> +}
> +
> +static int get_dram_offset(struct addr_ctx *ctx, bool *enabled, u64 *norm_offset)
> +{

You don't need *enabled. The retval can be:

< 0: fail
0: disabled
>0: enabled

and then you get rid of the IO param.

> +	u32 reg_dram_offset;
> +	u8 map_num;
> +
> +	/* Should not be called for map 0. */
> +	if (!ctx->map.num) {
> +		warn_on_assert("Trying to find DRAM offset for map 0");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * DramOffset registers don't exist for map 0, so the base register
> +	 * actually refers to map 1.
> +	 * Adjust the map_num for the register offsets.
> +	 */
> +	map_num = ctx->map.num - 1;
> +
> +	if (df_cfg.rev >= DF4) {
> +		/* Read D18F7x140 (DramOffset) */
> +		if (df_indirect_read_instance(ctx->node_id, 7, 0x140 + (4 * map_num),
> +					      ctx->inst_id, &reg_dram_offset))
> +			return -EINVAL;
> +
> +	} else {
> +		/* Read D18F0x1B4 (DramOffset) */
> +		if (df_indirect_read_instance(ctx->node_id, 0, 0x1B4 + (4 * map_num),
> +					      ctx->inst_id, &reg_dram_offset))
> +			return -EINVAL;
> +	}
> +
> +	if (!FIELD_GET(DF_HI_ADDR_OFFSET_EN, reg_dram_offset))
> +		return 0;
> +
> +	*enabled = true;
> +	*norm_offset = get_hi_addr_offset(reg_dram_offset);
> +
> +	return 0;
> +}

...

> +static int get_cs_fabric_id(struct addr_ctx *ctx)
> +{
> +	return lookup_cs_fabric_id(ctx);
> +}

Get rid of that silly helper.

> +
> +static bool valid_map(struct addr_ctx *ctx)
> +{
> +	if (df_cfg.rev >= DF4)
> +		return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.ctl);
> +
> +	return FIELD_GET(DF_ADDR_RANGE_VAL, ctx->map.base);

	if (... )
		return
	else
		return

Balanced.


> +int get_address_map(struct addr_ctx *ctx)
> +{
> +	int ret = 0;
> +
> +	ret = get_address_map_common(ctx);
> +	if (ret)
> +		return ret;
> +
> +	if (get_global_map_data(ctx))
> +		return -EINVAL;

Use ret here too.

> +
> +	dump_address_map(&ctx->map);
> +
> +	return ret;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
