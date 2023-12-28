Return-Path: <linux-kernel+bounces-12808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E3881FA46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9571C21201
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E2F9CD;
	Thu, 28 Dec 2023 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AYdZSgZd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A8C101C6;
	Thu, 28 Dec 2023 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB06F40E00CB;
	Thu, 28 Dec 2023 17:16:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JZC2WfEArAqo; Thu, 28 Dec 2023 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703783798; bh=dsap5p+SmiLZ81gmU91jhtmpljCaxwick/4WWHQpoZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYdZSgZdz7DxzCX8CY8Vbq4R9HZyRbZO7/KHdoQsnOBGyKCR66Jt7mZwruNJC8E8r
	 rvWWRRM20vxqQiQHbtBiPcTJFMpZf4ru0I8sGepXRvBi13y+AiLnPYn+QVVkUwiBnq
	 eBmrbm6a7TZ0XwcM+fgpjLXNhZ4N6xW9yWBQhd35ZdaRZCrgGMU9lykV8JaAsaWjHX
	 SBqHLslNeEspw0np7Eg+cYz2uuiXLk4nkhgQqcV+HtwuPRVcpugmzQqffC1P0nkc/f
	 FoMrkgmlCWwfJqHsoYBnP0TrcfEMbmuR7gUnX1ayZCFMv5jfG5/AXEzGisYQYan0+l
	 rvY8MZ+tveQYC8hLBCi6e6Kl+QRr4VbP2uGNVRVhzNwaCt8tvnqfN45kSvs4wdjbCQ
	 a0fx7EMNAyTclE7BzzEcNcl1Gp6R7ln/1IVNxXdxcgDBS0uxaMEVKu4qjPUlXv7mT0
	 F4UE6u0KpcxcrtTYa3hRBDPVUdnAU40mMzV+seIht0qY/OGKvvn9NqDtgr5fxyZnkb
	 th+qKXaF0q8eVWIE371CFkwBq1hbFx3iJK64elb8ycHSn+VIrUOd40TZdlKXFa4V8b
	 l7M2eUlglvodnXdMzPgnwUEfD60ZrbDlBeYZBiNXWc6OKRxBJDQwfF8H7ghMwlGYEP
	 VNcdYJ//kwIMV6XyODvFHSJU=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD9A140E01A9;
	Thu, 28 Dec 2023 17:16:30 +0000 (UTC)
Date: Thu, 28 Dec 2023 18:16:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
	william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231228171625.GAZY2taVm+C0rM7x1M@fat_crate.local>
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
 <20231218190406.27479-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>

On Mon, Dec 18, 2023 at 01:04:04PM -0600, Yazen Ghannam wrote:
> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
> new file mode 100644
> index 000000000000..51721094dd06
> --- /dev/null
> +++ b/drivers/ras/amd/atl/dehash.c
> @@ -0,0 +1,416 @@
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
> +static inline bool valid_map_bits(struct addr_ctx *ctx, u8 bit1, u8 bit2,
> +				  u8 num_intlv_dies, u8 num_intlv_sockets)
> +{
> +	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
> +		pr_debug("Invalid interleave bit: %u", ctx->map.intlv_bit_pos);
> +		return false;
> +	}
> +
> +	if (ctx->map.num_intlv_dies > num_intlv_dies) {
> +		pr_debug("Invalid number of interleave dies: %u", ctx->map.num_intlv_dies);
> +		return false;
> +	}
> +
> +	if (ctx->map.num_intlv_sockets > num_intlv_sockets) {
> +		pr_debug("Invalid number of interleave sockets: %u", ctx->map.num_intlv_sockets);
> +		return false;
> +	}
> +
> +	return true;
> +}

Ontop:

diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
index 51721094dd06..6f414926e6fe 100644
--- a/drivers/ras/amd/atl/dehash.c
+++ b/drivers/ras/amd/atl/dehash.c
@@ -12,7 +12,14 @@
 
 #include "internal.h"
 
-static inline bool valid_map_bits(struct addr_ctx *ctx, u8 bit1, u8 bit2,
+/*
+ * Verify the interleave bits are correct in the different interleaving
+ * settings.
+ *
+ * If @num_intlv_dies and/or @num_intlv_sockets are 1, it means the
+ * respective interleaving is disabled.
+ */
+static inline bool map_bits_valid(struct addr_ctx *ctx, u8 bit1, u8 bit2,
 				  u8 num_intlv_dies, u8 num_intlv_sockets)
 {
 	if (!(ctx->map.intlv_bit_pos == bit1 || ctx->map.intlv_bit_pos == bit2)) {
@@ -37,11 +44,7 @@ static int df2_dehash_addr(struct addr_ctx *ctx)
 {
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	/*
-	 * Assert that interleave bit is 8 or 9 and that die and socket
-	 * interleaving are disabled.
-	 */
-	if (!valid_map_bits(ctx, 8, 9, 1, 1))
+	if (!map_bits_valid(ctx, 8, 9, 1, 1))
 		return -EINVAL;
 
 	intlv_bit_pos = ctx->map.intlv_bit_pos;
@@ -64,11 +67,7 @@ static int df3_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit, intlv_bit_pos;
 
-	/*
-	 * Assert that interleave bit is 8 or 9 and that die and socket
-	 * interleaving are disabled.
-	 */
-	if (!valid_map_bits(ctx, 8, 9, 1, 1))
+	if (!map_bits_valid(ctx, 8, 9, 1, 1))
 		return -EINVAL;
 
 	hash_ctl_64k = FIELD_GET(DF3_HASH_CTL_64K, ctx->map.ctl);
@@ -172,11 +171,7 @@ static int df4_dehash_addr(struct addr_ctx *ctx)
 	bool hash_ctl_64k, hash_ctl_2M, hash_ctl_1G;
 	u8 hashed_bit, intlv_bit;
 
-	/*
-	 * Assert that interleave bit is 8, die interleaving is disabled,
-	 * and no more than 2 sockets are interleaved.
-	 */
-	if (!valid_map_bits(ctx, 8, 8, 1, 2))
+	if (!map_bits_valid(ctx, 8, 8, 1, 2))
 		return -EINVAL;
 
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);
@@ -252,11 +247,7 @@ static int df4p5_dehash_addr(struct addr_ctx *ctx)
 	u8 hashed_bit, intlv_bit;
 	u64 rehash_vector;
 
-	/*
-	 * Assert that interleave bit is 8, die interleaving is disabled,
-	 * and no more than 2 sockets are interleaved.
-	 */
-	if (!valid_map_bits(ctx, 8, 8, 1, 2))
+	if (!map_bits_valid(ctx, 8, 8, 1, 2))
 		return -EINVAL;
 
 	hash_ctl_64k = FIELD_GET(DF4_HASH_CTL_64K, ctx->map.ctl);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

