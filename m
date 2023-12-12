Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56A280ED90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346429AbjLLN3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjLLN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:29:22 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC08F7;
        Tue, 12 Dec 2023 05:29:26 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE8B640E0140;
        Tue, 12 Dec 2023 13:29:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vZTxsT0DVDhc; Tue, 12 Dec 2023 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702387761; bh=vtvhVNre6HysdN5zAaUFMbjal8l4WhbojmN9rM2JgwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPG8+1A2kV5eeyxGCKJw6zHrTL9UrX85kyllIPlMbkYY3fxwpps5B7OwcsJnBWid4
         WLRANqI0mr/8glJSQpXzwzyBwzGNpH6+H7Axar9YrW4Pk3w208dthRCsbL1WsLvkiO
         79CZv3erWp+YTUFoGyHUEgL9Ocu8MyTO82Sh+0QTG2SJM1dklNswuWEmI3wZGpUtaF
         F47K8nxYc9NnjI6IidajKPB5UvRsAj/VQch6YcVXV35x9tD0wgHEMOmBuLVOlpstEw
         CS76Mex0u6n7iD/rPQ0EVh8YI/uurQFA5p8urDu+mvGhENpBe0zU/zvjoVjdvWVeZc
         BjNSniUc8HXatSqvyZ0O8jje7gPcpVs1dy/90JqFXNob+WDdayqrMmUdWAU3lcB/lA
         0XaF3f7LFJAzBvKeTJo8j03DZlP0Kd9ZgT04HxJ2CE65w0hKMPOJruUKzxMG3bV7Ro
         vyJ12GZpb29+w3LYiHo4T5y/5O21lmq7uZPEYmqOD+3XjHydXOoLtZoi5sQDmKiXtz
         29ThQo6ixi0n4aV59CKdRA+g/M1hUulh2gnUpV6oq6Ujd8thGi3RtzkOqyOqn29Fiv
         +Hwbo5+N82yfMQtEb2VzvDVv/cDj8HChk47abzSBsgJcoGfffFUDOp6FfO1LQbt9E8
         kJbjZ5UoOaa1UzRNvzBEBKxM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BFE0240E00CD;
        Tue, 12 Dec 2023 13:29:12 +0000 (UTC)
Date:   Tue, 12 Dec 2023 14:29:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231212132907.GJZXhgIyss9eT1MsNb@fat_crate.local>
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
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> new file mode 100644
> index 000000000000..84fe9793694e
> --- /dev/null
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -0,0 +1,446 @@
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
> +static inline bool assert_intlv_bit(struct addr_ctx *ctx, u8 bit1, u8 bit2)
> +{
> +	if (ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)
> +		return false;
> +
> +	warn_on_assert("%s: Invalid interleave bit: %u",
> +		       __func__, ctx->map.intlv_bit_pos);
> +
> +	return true;
> +}
> +
> +static inline bool assert_num_intlv_dies(struct addr_ctx *ctx, u8 num_intlv_dies)
> +{
> +	if (ctx->map.num_intlv_dies <= num_intlv_dies)
> +		return false;
> +
> +	warn_on_assert("%s: Invalid number of interleave dies: %u",
> +		       __func__, ctx->map.num_intlv_dies);
> +
> +	return true;
> +}
> +
> +static inline bool assert_num_intlv_sockets(struct addr_ctx *ctx, u8 num_intlv_sockets)
> +{
> +	if (ctx->map.num_intlv_sockets <= num_intlv_sockets)
> +		return false;
> +
> +	warn_on_assert("%s: Invalid number of interleave sockets: %u",
> +		       __func__, ctx->map.num_intlv_sockets);
> +
> +	return true;
> +}
> +
> +static int df2_dehash_addr(struct addr_ctx *ctx)
> +{
> +	u8 hashed_bit, intlv_bit, intlv_bit_pos;
> +
> +	/* Assert that interleave bit is 8 or 9. */
> +	if (assert_intlv_bit(ctx, 8, 9))
> +		return -EINVAL;

You don't need those homegrown assertions. Instead, you do this:

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 84fe9793694e..11634001702e 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -47,10 +47,12 @@ static inline bool assert_num_intlv_sockets(struct addr_ctx *ctx, u8 num_intlv_s
 
 static int df2_dehash_addr(struct addr_ctx *ctx)
 {
-	u8 hashed_bit, intlv_bit, intlv_bit_pos;
+	u8 hashed_bit, intlv_bit;
+	u8 intlv_bit_pos = ctx->map.intlv_bit_pos;
 
 	/* Assert that interleave bit is 8 or 9. */
-	if (assert_intlv_bit(ctx, 8, 9))
+	if (WARN(intlv_bit_pos != 8 && intlv_bit_pos != 9,
+		 "Invalid interleave bit: %u\n", intlv_bit_pos))
 		return -EINVAL;
 
 	/* Assert that die and socket interleaving are disabled. */
@@ -60,7 +62,6 @@ static int df2_dehash_addr(struct addr_ctx *ctx)
 	if (assert_num_intlv_sockets(ctx, 1))
 		return -EINVAL;
 
-	intlv_bit_pos = ctx->map.intlv_bit_pos;
 	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
 
 	hashed_bit = intlv_bit;

and so on for the other two.

> +	/* Assert that die and socket interleaving are disabled. */
> +	if (assert_num_intlv_dies(ctx, 1))
> +		return -EINVAL;
> +
> +	if (assert_num_intlv_sockets(ctx, 1))
> +		return -EINVAL;
> +
> +	intlv_bit_pos = ctx->map.intlv_bit_pos;
> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);

Can we keep it simple please?

	intlv_bit = !!(BIT_ULL(intlv_bit_pos) & ctx->ret_addr);

That atl_get_bit() is not necessary.

> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(12), ctx->ret_addr);
> +	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr);
> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr);
> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr);
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
> +
> +	return 0;
> +}

<---

> +static int df3_dehash_addr(struct addr_ctx *ctx)
> +{
> +	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
> +	u8 hashed_bit, intlv_bit, intlv_bit_pos;
> +
> +	/* Assert that interleave bit is 8 or 9. */
> +	if (assert_intlv_bit(ctx, 8, 9))
> +		return -EINVAL;
> +
> +	/* Assert that die and socket interleaving are disabled. */
> +	if (assert_num_intlv_dies(ctx, 1))
> +		return -EINVAL;
> +
> +	if (assert_num_intlv_sockets(ctx, 1))
> +		return -EINVAL;

Those assertions keep repeating. Extract them into a separate function
which you call from every *dehash_addr function?

> +	hash_ctl_64k	= FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
> +	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
> +	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);

I believe without the tabs looks good too:

        hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
        hash_ctl_2M  = FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
        hash_ctl_1G  = FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);

> +	intlv_bit_pos = ctx->map.intlv_bit_pos;
> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(14), ctx->ret_addr);
> +	hashed_bit ^= FIELD_GET(BIT_ULL(18), ctx->ret_addr) & hash_ctl_64k;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
> +
> +	/* Calculation complete for 2 channels. Continue for 4 and 8 channels. */
> +	if (ctx->map.intlv_mode == DF3_COD4_2CHAN_HASH)
> +		return 0;
> +
> +	intlv_bit = FIELD_GET(BIT_ULL(12), ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(16), ctx->ret_addr) & hash_ctl_64k;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(12);
> +
> +	/* Calculation complete for 4 channels. Continue for 8 channels. */
> +	if (ctx->map.intlv_mode == DF3_COD2_4CHAN_HASH)
> +		return 0;
> +
> +	intlv_bit = FIELD_GET(BIT_ULL(13), ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(17), ctx->ret_addr) & hash_ctl_64k;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(13);
> +
> +	return 0;
> +}

Also, same comments about this function as for df2_dehash_addr(). Below
too.

> +
> +static int df3_6chan_dehash_addr(struct addr_ctx *ctx)
> +{
> +	u8 intlv_bit_pos = ctx->map.intlv_bit_pos;
> +	u8 hashed_bit, intlv_bit, num_intlv_bits;
> +	bool hash_ctl_2M, hash_ctl_1G;
> +
> +	if (ctx->map.intlv_mode != DF3_6CHAN) {
> +		warn_on_bad_intlv_mode(ctx);
> +		return -EINVAL;
> +	}
> +
> +	num_intlv_bits = ilog2(ctx->map.num_intlv_chan) + 1;
> +
> +	hash_ctl_2M	= FIELD_GET(DF3_HASH_CTL_2M, ctx->map.ctl);
> +	hash_ctl_1G	= FIELD_GET(DF3_HASH_CTL_1G, ctx->map.ctl);
> +
> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= atl_get_bit((intlv_bit_pos + num_intlv_bits), ctx->ret_addr);
> +	hashed_bit ^= FIELD_GET(BIT_ULL(23), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(32), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
> +
> +	intlv_bit_pos++;
> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(21), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(30), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
> +
> +	intlv_bit_pos++;
> +	intlv_bit = atl_get_bit(intlv_bit_pos, ctx->ret_addr);
> +
> +	hashed_bit = intlv_bit;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(22), ctx->ret_addr) & hash_ctl_2M;
> +	hashed_bit ^= FIELD_GET(BIT_ULL(31), ctx->ret_addr) & hash_ctl_1G;
> +
> +	if (hashed_bit != intlv_bit)
> +		ctx->ret_addr ^= BIT_ULL(intlv_bit_pos);
> +
> +	return 0;
> +}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
