Return-Path: <linux-kernel+bounces-15420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1D8822BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585B5B23057
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3018E13;
	Wed,  3 Jan 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B7acPJNm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDC18E0D;
	Wed,  3 Jan 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CAD9540E01CB;
	Wed,  3 Jan 2024 10:59:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rhWWOBUcAl4K; Wed,  3 Jan 2024 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704279582; bh=kWj1r7YWgv/xuCZuac9oYHJ2Ii/q2D59EYfwOqw5nDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7acPJNm7mRSTv6Mii0NETfGyxXgzzVz4ntLc/qNPM07P18RKpz6+8/kceMx/oNpc
	 oImibIN2Z8H04tAS6K/S6VnRw3Pi8SmvpPVLi+Y/HV5GC7ZAND9OmiLvKmZ9LlrRlS
	 fGgqtsxGJktbeO4tB27WlO1v3Fii7Yh1SX9/K8VpwoG2ZZE2NrBkaTdxmR4Fe0M/Hi
	 U7Q/drYXNLtQLSzGc3wMyw+7P8B82Gv3wjThFOqT3tbLTAoYtE+ljlByG+ihQXuD3O
	 bjYbDfUV9qHcCTSpQM3WACJcS+qh4rtfrwQlG+bwLCxqOu+v9qlVqOLjaWJ5sy0hes
	 Juz97AY3DmWr+YTj3rcrQXiWhrm22bRDbWmPzR7avSen1FwD5mcHLjUVIcuYkJjRhR
	 NMy7dQ/PPtb4nJOCWZOu3GcbwWMeArZcNe9uGNcTR9T7MzBHCSqchOQtn3XGoHzpPd
	 UDsSBU7zKBxRMJ5n5NxP1WeWVx1H1ytu6v38rLh1gU2KQZA4bQDIL8xkaRp1Jb1b+N
	 DlQ6PQjeNk2Zss1VaXILMIXWHL8xZw0WCtQQ1mMEyczAh2LEgvSUGXvRcW6k0Rp6/k
	 Y+e7bsTJXwrhWuO1czB40mvLSkpEQl+cLfZA0osFOuOEhwdYE4gaX6DHvF+5L28+iJ
	 sUQ/JYUv9fplWGB6pHHsjaM4=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C4C940E01C5;
	Wed,  3 Jan 2024 10:59:34 +0000 (UTC)
Date: Wed, 3 Jan 2024 11:59:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
	william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 0/3] AMD Address Translation Library
Message-ID: <20240103105933.GBZZU+FRPkBDkIwr4P@fat_crate.local>
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218190406.27479-1-yazen.ghannam@amd.com>

On Mon, Dec 18, 2023 at 01:04:03PM -0600, Yazen Ghannam wrote:
> Hi all,
> 
> This revision addresses comments from Boris for v3. The most substantial
> change is the removal of the library "stub".
> 
> Thanks,
> Yazen
> 
> Yazen Ghannam (3):
>   RAS: Introduce AMD Address Translation Library
>   EDAC/amd64: Use new AMD Address Translation Library
>   Documentation: RAS: Add index and address translation section

Ok, a combo diff of my fixes ontop, below. Lemme queue it - further
fixes can go ontop from now on.

Thx.

---
diff --git a/drivers/ras/amd/atl/access.c b/drivers/ras/amd/atl/access.c
index 1de0460f5e03..f6dd87bb2c35 100644
--- a/drivers/ras/amd/atl/access.c
+++ b/drivers/ras/amd/atl/access.c
@@ -18,12 +18,12 @@ static DEFINE_MUTEX(df_indirect_mutex);
 /*
  * Data Fabric Indirect Access uses FICAA/FICAD.
  *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
+ * Fabric Indirect Configuration Access Address (FICAA): constructed based
  * on the device's Instance Id and the PCI function and register offset of
  * the desired register.
  *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
+ * Fabric Indirect Configuration Access Data (FICAD): there are FICAD
+ * low and high registers but so far only the low register is needed.
  *
  * Use Instance Id 0xFF to indicate a broadcast read.
  */
diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 9cc31c052427..6dc4e06305f7 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -31,7 +31,7 @@ static int addr_over_limit(struct addr_ctx *ctx)
 
 	/* Is calculated system address above DRAM limit address? */
 	if (ctx->ret_addr > dram_limit_addr) {
-		atl_debug("Calculated address (0x%016llx) > DRAM limit (0x%016llx)",
+		atl_debug(ctx, "Calculated address (0x%016llx) > DRAM limit (0x%016llx)",
 			  ctx->ret_addr, dram_limit_addr);
 		return -EINVAL;
 	}
@@ -179,7 +179,7 @@ static void check_for_legacy_df_access(void)
  * are technically independent things.
  *
  * It's possible to match on the PCI IDs of the Data Fabric devices, but this will be
- * an every expanding list. Instead match on the SMCA and Zen features to cover all
+ * an ever expanding list. Instead, match on the SMCA and Zen features to cover all
  * relevant systems.
  */
 static const struct x86_cpu_id amd_atl_cpuids[] = {
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
diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index fb182dd7cca6..01f1d0fb6799 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -339,7 +339,8 @@ static u16 get_logical_coh_st_fabric_id(struct addr_ctx *ctx)
 	}
 
 	if (log_fabric_id == MAX_COH_ST_CHANNELS)
-		atl_debug("COH_ST remap entry not found for 0x%x", log_fabric_id);
+		atl_debug(ctx, "COH_ST remap entry not found for 0x%x",
+			  log_fabric_id);
 
 	/* Get the Node ID bits from the physical and apply to the logical. */
 	return (phys_fabric_id & df_cfg.node_id_mask) | log_fabric_id;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index a1996811aa34..f17c5f5c9950 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -279,10 +279,10 @@ static inline u64 remove_bits(u8 low_bit, u8 high_bit, u64 data)
 	return temp1 | temp2;
 }
 
-#define atl_debug(fmt, arg...) \
+#define atl_debug(ctx, fmt, arg...) \
 	pr_debug("socket_id=%u die_id=%u coh_st_inst_id=%u norm_addr=0x%016llx: " fmt,\
-		 ctx->inputs.socket_id, ctx->inputs.die_id,\
-		 ctx->inputs.coh_st_inst_id, ctx->inputs.norm_addr, ##arg)
+		 (ctx)->inputs.socket_id, (ctx)->inputs.die_id,\
+		 (ctx)->inputs.coh_st_inst_id, (ctx)->inputs.norm_addr, ##arg)
 
 static inline void atl_debug_on_bad_df_rev(void)
 {
@@ -291,7 +291,7 @@ static inline void atl_debug_on_bad_df_rev(void)
 
 static inline void atl_debug_on_bad_intlv_mode(struct addr_ctx *ctx)
 {
-	atl_debug("Unrecognized interleave mode: %u", ctx->map.intlv_mode);
+	atl_debug(ctx, "Unrecognized interleave mode: %u", ctx->map.intlv_mode);
 }
 
 #endif /* __AMD_ATL_INTERNAL_H__ */
diff --git a/drivers/ras/amd/atl/map.c b/drivers/ras/amd/atl/map.c
index 8145b7bb2b40..64e8b1eda1ae 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -140,7 +140,7 @@ static int get_dram_offset(struct addr_ctx *ctx, u64 *norm_offset)
 
 	/* Should not be called for map 0. */
 	if (!ctx->map.num) {
-		atl_debug("Trying to find DRAM offset for map 0");
+		atl_debug(ctx, "Trying to find DRAM offset for map 0");
 		return -EINVAL;
 	}
 
@@ -388,7 +388,6 @@ static int find_normalized_offset(struct addr_ctx *ctx, u64 *norm_offset)
 
 	for (ctx->map.num = 1; ctx->map.num < df_cfg.num_coh_st_maps; ctx->map.num++) {
 		ret = get_dram_offset(ctx, norm_offset);
-
 		if (ret < 0)
 			return ret;
 
@@ -398,13 +397,13 @@ static int find_normalized_offset(struct addr_ctx *ctx, u64 *norm_offset)
 
 		/* Enabled offsets should never be 0. */
 		if (*norm_offset == 0) {
-			atl_debug("Enabled map %u offset is 0", ctx->map.num);
+			atl_debug(ctx, "Enabled map %u offset is 0", ctx->map.num);
 			return -EINVAL;
 		}
 
 		/* Offsets should always increase from one map to the next. */
 		if (*norm_offset <= last_offset) {
-			atl_debug("Map %u offset (0x%016llx) <= previous (0x%016llx)",
+			atl_debug(ctx, "Map %u offset (0x%016llx) <= previous (0x%016llx)",
 				  ctx->map.num, *norm_offset, last_offset);
 			return -EINVAL;
 		}
@@ -650,18 +649,17 @@ static void dump_address_map(struct dram_addr_map *map)
 
 int get_address_map(struct addr_ctx *ctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = get_address_map_common(ctx);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = get_global_map_data(ctx);
 	if (ret)
-		goto out;
+		return ret;
 
 	dump_address_map(&ctx->map);
 
-out:
 	return ret;
 }
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 37ad203bb93e..af61f2f1d6de 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -17,7 +17,7 @@ int determine_node_id(struct addr_ctx *ctx, u8 socket_id, u8 die_id)
 	u16 socket_id_bits, die_id_bits;
 
 	if (socket_id > 0 && df_cfg.socket_id_mask == 0) {
-		atl_debug("Invalid socket inputs: socket_id=%u socket_id_mask=0x%x",
+		atl_debug(ctx, "Invalid socket inputs: socket_id=%u socket_id_mask=0x%x",
 			  socket_id, df_cfg.socket_id_mask);
 		return -EINVAL;
 	}
@@ -28,7 +28,7 @@ int determine_node_id(struct addr_ctx *ctx, u8 socket_id, u8 die_id)
 	socket_id_bits &=	df_cfg.socket_id_mask;
 
 	if (die_id > 0 && df_cfg.die_id_mask == 0) {
-		atl_debug("Invalid die inputs: die_id=%u die_id_mask=0x%x",
+		atl_debug(ctx, "Invalid die inputs: die_id=%u die_id_mask=0x%x",
 			  die_id, df_cfg.die_id_mask);
 		return -EINVAL;
 	}
@@ -225,8 +225,6 @@ static void get_num_maps(void)
 		df_cfg.num_coh_st_maps	= 2;
 		break;
 	case DF4:
-		df_cfg.num_coh_st_maps	= 4;
-		break;
 	case DF4p5:
 		df_cfg.num_coh_st_maps	= 4;
 		break;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

