Return-Path: <linux-kernel+bounces-5612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC2818D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478502837DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A9208CF;
	Tue, 19 Dec 2023 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bDNTdiLI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D667225D1;
	Tue, 19 Dec 2023 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D90940E00CD;
	Tue, 19 Dec 2023 16:57:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i2lycargX-Gf; Tue, 19 Dec 2023 16:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703005072; bh=uFBtQ4pwrfka36entX/QboXxdbGj0sTJuqXU8rYhtfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDNTdiLItFVQhwOs2NgJ/tuVUokL5PuaE+nApzWU+Tujv/u7ZwBv5NGKOtnJrma9e
	 WHzYH4uHo3WOgTinwdOKUH2lblJ6bAOUFny5TRxeR1oI31TiYMfMUD69Oc6gsDnlbo
	 LgSWqTShzutnuYpLTNV4kfM01mnDv7SEF/6cqhuXVA9+kvXWiALi9oLzaccWTJPMTn
	 rf+CXXgaK29s6oPbxW19grm1tKGozOk81x3eWVQtp/7Z117gmmLzXS0MtWyZ70CKuA
	 qilsP+KERScYsjqNnXuHC9ijlu30C9bSWXASfNDLAuHHjaf9pL9nnA2lVGwbGQQWS6
	 BVtZq+8eigHg9NlF1NnFc2TgiUP0SqJyQHV5GShZ7T5JQSGtXkPJyglvf9yrp7WL/c
	 vtWU3wo0ICmCxcRlHx2KwfpRFsKLu+9N5cqb8X3IQedXiU6EXXOhkq6NeuBaegLru1
	 pLOpCO4M+0TaIXT/pO+DSrU5NWk5dcZmnltTaqgExAu9HaFf0aB3QgtIn+LmlitUal
	 jAVF6SPWpwNxCZseiGMN2PQsI7OW7dF3WJK/glod5BUu1x0+MQ4LiZejqihp0c0qjZ
	 mSBwaDwTbCgxNxaoVnrmN4hQ4y/sICinaOwskrKzzBsgoDKAFdd5C+vqYQJBPHKjBw
	 McoGXMQ45CwEwdLnZ4vp3CPM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3B7840E00C9;
	Tue, 19 Dec 2023 16:57:43 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:57:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
	william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231219165737.GUZYHLgTRNlOohXFFj@fat_crate.local>
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
> +#define atl_debug(fmt, arg...) \
> +	pr_debug("socket_id=%u die_id=%u coh_st_inst_id=%u norm_addr=0x%016llx: " fmt,\
> +		 ctx->inputs.socket_id, ctx->inputs.die_id,\
> +		 ctx->inputs.coh_st_inst_id, ctx->inputs.norm_addr, ##arg)

Yeah, you need to pass in "ctx" as a macro argument - otherwise it is
kinda sneaky and non-obvious to reference a pointer which is hidden
inside the macro definition.

Diff ontop:

---

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 013aaee4e99c..6dc4e06305f7 100644
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
index d160662f534f..2ed477d94b4f 100644
--- a/drivers/ras/amd/atl/map.c
+++ b/drivers/ras/amd/atl/map.c
@@ -140,7 +140,7 @@ static int get_dram_offset(struct addr_ctx *ctx, u64 *norm_offset)
 
 	/* Should not be called for map 0. */
 	if (!ctx->map.num) {
-		atl_debug("Trying to find DRAM offset for map 0");
+		atl_debug(ctx, "Trying to find DRAM offset for map 0");
 		return -EINVAL;
 	}
 
@@ -398,13 +398,13 @@ static int find_normalized_offset(struct addr_ctx *ctx, u64 *norm_offset)
 
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
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 3b6b5a5ddaab..af61f2f1d6de 100644
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

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

