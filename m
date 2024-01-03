Return-Path: <linux-kernel+bounces-15456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D73822C40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D367EB2284C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA218EDA;
	Wed,  3 Jan 2024 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhJYQXjY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQD0yvY8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3C18EBD;
	Wed,  3 Jan 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jan 2024 11:36:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704281818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PSXzF4RWlkFjbFMG6BEIthVKbwiwcMVTSEGjwCWVbE=;
	b=bhJYQXjYsVFd1pRrTXj7U/ZrJKqaZfFwEhAGEPZdrMHg8FvGElTSJC4nvofd2+nCi28q3g
	FjeIn2ItiNKuPsIcZ5mKuXr2N1lemxBorVHe2gMvEFdYZ8aFDgcw3ZbV8D0CmbtdNEwxQP
	sqNc8zZD3NECVplfpL6v3DUwlujeA6uJLSV0J4ZuvegSUD6FVFAPQJCOAYSZN/7NT6/Ob9
	4riBfDiYx19+GmyPn9GhouJdVdwbEuI9qbEHCkujO89UIW9FY/aVZQcFXqW1cvEX0nMqXa
	XcKJfAFNITgaoOsmFvUlGKRVqAdqz2v83z/hlAeU8uEQKCi3kSpjpn8hDvOw1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704281818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PSXzF4RWlkFjbFMG6BEIthVKbwiwcMVTSEGjwCWVbE=;
	b=yQD0yvY8oWJxBLFUQv9pNRM2CrNX2XhpUJ2+SySi6qhWKOZtrhDznskU6HE4v95RPGYLzb
	meipmluloJ+JwFDA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Use new AMD Address Translation Library
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231218190406.27479-3-yazen.ghannam@amd.com>
References: <20231218190406.27479-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170428181803.398.8554076481896379456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e8f4799f5c719f6454d80c7ceb8923b9d21fd8b6
Gitweb:        https://git.kernel.org/tip/e8f4799f5c719f6454d80c7ceb8923b9d21fd8b6
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 18 Dec 2023 13:04:05 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Jan 2024 12:29:20 +01:00

EDAC/amd64: Use new AMD Address Translation Library

Remove old address translation code and use the new AMD Address
Translation Library.

Use "imply" in Kconfig so that the "AMD_ATL" config option takes the
value of "EDAC_AMD64" as its default.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231218190406.27479-3-yazen.ghannam@amd.com
---
 drivers/edac/Kconfig      |   1 +-
 drivers/edac/amd64_edac.c | 282 +-------------------------------------
 2 files changed, 6 insertions(+), 277 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 5a7f3fa..16c8de5 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -78,6 +78,7 @@ config EDAC_GHES
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
 	depends on AMD_NB && EDAC_DECODE_MCE
+	imply AMD_ATL
 	help
 	  Support for error detection and correction of DRAM ECC errors on
 	  the AMD64 families (>= K8) of memory controllers.
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 9b6642d..91c343e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/ras.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
 
@@ -1043,281 +1044,6 @@ static int fixup_node_id(int node_id, struct mce *m)
 	return nid - gpu_node_map.base_node_id + 1;
 }
 
-/* Protect the PCI config register pairs used for DF indirect access. */
-static DEFINE_MUTEX(df_indirect_mutex);
-
-/*
- * Data Fabric Indirect Access uses FICAA/FICAD.
- *
- * Fabric Indirect Configuration Access Address (FICAA): Constructed based
- * on the device's Instance Id and the PCI function and register offset of
- * the desired register.
- *
- * Fabric Indirect Configuration Access Data (FICAD): There are FICAD LO
- * and FICAD HI registers but so far we only need the LO register.
- *
- * Use Instance Id 0xFF to indicate a broadcast read.
- */
-#define DF_BROADCAST	0xFF
-static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	struct pci_dev *F4;
-	u32 ficaa;
-	int err = -ENODEV;
-
-	if (node >= amd_nb_num())
-		goto out;
-
-	F4 = node_to_amd_nb(node)->link;
-	if (!F4)
-		goto out;
-
-	ficaa  = (instance_id == DF_BROADCAST) ? 0 : 1;
-	ficaa |= reg & 0x3FC;
-	ficaa |= (func & 0x7) << 11;
-	ficaa |= instance_id << 16;
-
-	mutex_lock(&df_indirect_mutex);
-
-	err = pci_write_config_dword(F4, 0x5C, ficaa);
-	if (err) {
-		pr_warn("Error writing DF Indirect FICAA, FICAA=0x%x\n", ficaa);
-		goto out_unlock;
-	}
-
-	err = pci_read_config_dword(F4, 0x98, lo);
-	if (err)
-		pr_warn("Error reading DF Indirect FICAD LO, FICAA=0x%x.\n", ficaa);
-
-out_unlock:
-	mutex_unlock(&df_indirect_mutex);
-
-out:
-	return err;
-}
-
-static int df_indirect_read_instance(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, instance_id, lo);
-}
-
-static int df_indirect_read_broadcast(u16 node, u8 func, u16 reg, u32 *lo)
-{
-	return __df_indirect_read(node, func, reg, DF_BROADCAST, lo);
-}
-
-struct addr_ctx {
-	u64 ret_addr;
-	u32 tmp;
-	u16 nid;
-	u8 inst_id;
-};
-
-static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
-{
-	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
-
-	u8 die_id_shift, die_id_mask, socket_id_shift, socket_id_mask;
-	u8 intlv_num_dies, intlv_num_chan, intlv_num_sockets;
-	u8 intlv_addr_sel, intlv_addr_bit;
-	u8 num_intlv_bits, hashed_bit;
-	u8 lgcy_mmio_hole_en, base = 0;
-	u8 cs_mask, cs_id = 0;
-	bool hash_enabled = false;
-
-	struct addr_ctx ctx;
-
-	memset(&ctx, 0, sizeof(ctx));
-
-	/* Start from the normalized address */
-	ctx.ret_addr = norm_addr;
-
-	ctx.nid = nid;
-	ctx.inst_id = umc;
-
-	/* Read D18F0x1B4 (DramOffset), check if base 1 is used. */
-	if (df_indirect_read_instance(nid, 0, 0x1B4, umc, &ctx.tmp))
-		goto out_err;
-
-	/* Remove HiAddrOffset from normalized address, if enabled: */
-	if (ctx.tmp & BIT(0)) {
-		u64 hi_addr_offset = (ctx.tmp & GENMASK_ULL(31, 20)) << 8;
-
-		if (norm_addr >= hi_addr_offset) {
-			ctx.ret_addr -= hi_addr_offset;
-			base = 1;
-		}
-	}
-
-	/* Read D18F0x110 (DramBaseAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x110 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	/* Check if address range is valid. */
-	if (!(ctx.tmp & BIT(0))) {
-		pr_err("%s: Invalid DramBaseAddress range: 0x%x.\n",
-			__func__, ctx.tmp);
-		goto out_err;
-	}
-
-	lgcy_mmio_hole_en = ctx.tmp & BIT(1);
-	intlv_num_chan	  = (ctx.tmp >> 4) & 0xF;
-	intlv_addr_sel	  = (ctx.tmp >> 8) & 0x7;
-	dram_base_addr	  = (ctx.tmp & GENMASK_ULL(31, 12)) << 16;
-
-	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
-	if (intlv_addr_sel > 3) {
-		pr_err("%s: Invalid interleave address select %d.\n",
-			__func__, intlv_addr_sel);
-		goto out_err;
-	}
-
-	/* Read D18F0x114 (DramLimitAddress). */
-	if (df_indirect_read_instance(nid, 0, 0x114 + (8 * base), umc, &ctx.tmp))
-		goto out_err;
-
-	intlv_num_sockets = (ctx.tmp >> 8) & 0x1;
-	intlv_num_dies	  = (ctx.tmp >> 10) & 0x3;
-	dram_limit_addr	  = ((ctx.tmp & GENMASK_ULL(31, 12)) << 16) | GENMASK_ULL(27, 0);
-
-	intlv_addr_bit = intlv_addr_sel + 8;
-
-	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-	switch (intlv_num_chan) {
-	case 0:	intlv_num_chan = 0; break;
-	case 1: intlv_num_chan = 1; break;
-	case 3: intlv_num_chan = 2; break;
-	case 5:	intlv_num_chan = 3; break;
-	case 7:	intlv_num_chan = 4; break;
-
-	case 8: intlv_num_chan = 1;
-		hash_enabled = true;
-		break;
-	default:
-		pr_err("%s: Invalid number of interleaved channels %d.\n",
-			__func__, intlv_num_chan);
-		goto out_err;
-	}
-
-	num_intlv_bits = intlv_num_chan;
-
-	if (intlv_num_dies > 2) {
-		pr_err("%s: Invalid number of interleaved nodes/dies %d.\n",
-			__func__, intlv_num_dies);
-		goto out_err;
-	}
-
-	num_intlv_bits += intlv_num_dies;
-
-	/* Add a bit if sockets are interleaved. */
-	num_intlv_bits += intlv_num_sockets;
-
-	/* Assert num_intlv_bits <= 4 */
-	if (num_intlv_bits > 4) {
-		pr_err("%s: Invalid interleave bits %d.\n",
-			__func__, num_intlv_bits);
-		goto out_err;
-	}
-
-	if (num_intlv_bits > 0) {
-		u64 temp_addr_x, temp_addr_i, temp_addr_y;
-		u8 die_id_bit, sock_id_bit, cs_fabric_id;
-
-		/*
-		 * Read FabricBlockInstanceInformation3_CS[BlockFabricID].
-		 * This is the fabric id for this coherent slave. Use
-		 * umc/channel# as instance id of the coherent slave
-		 * for FICAA.
-		 */
-		if (df_indirect_read_instance(nid, 0, 0x50, umc, &ctx.tmp))
-			goto out_err;
-
-		cs_fabric_id = (ctx.tmp >> 8) & 0xFF;
-		die_id_bit   = 0;
-
-		/* If interleaved over more than 1 channel: */
-		if (intlv_num_chan) {
-			die_id_bit = intlv_num_chan;
-			cs_mask	   = (1 << die_id_bit) - 1;
-			cs_id	   = cs_fabric_id & cs_mask;
-		}
-
-		sock_id_bit = die_id_bit;
-
-		/* Read D18F1x208 (SystemFabricIdMask). */
-		if (intlv_num_dies || intlv_num_sockets)
-			if (df_indirect_read_broadcast(nid, 1, 0x208, &ctx.tmp))
-				goto out_err;
-
-		/* If interleaved over more than 1 die. */
-		if (intlv_num_dies) {
-			sock_id_bit  = die_id_bit + intlv_num_dies;
-			die_id_shift = (ctx.tmp >> 24) & 0xF;
-			die_id_mask  = (ctx.tmp >> 8) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & die_id_mask) >> die_id_shift) << die_id_bit;
-		}
-
-		/* If interleaved over more than 1 socket. */
-		if (intlv_num_sockets) {
-			socket_id_shift	= (ctx.tmp >> 28) & 0xF;
-			socket_id_mask	= (ctx.tmp >> 16) & 0xFF;
-
-			cs_id |= ((cs_fabric_id & socket_id_mask) >> socket_id_shift) << sock_id_bit;
-		}
-
-		/*
-		 * The pre-interleaved address consists of XXXXXXIIIYYYYY
-		 * where III is the ID for this CS, and XXXXXXYYYYY are the
-		 * address bits from the post-interleaved address.
-		 * "num_intlv_bits" has been calculated to tell us how many "I"
-		 * bits there are. "intlv_addr_bit" tells us how many "Y" bits
-		 * there are (where "I" starts).
-		 */
-		temp_addr_y = ctx.ret_addr & GENMASK_ULL(intlv_addr_bit - 1, 0);
-		temp_addr_i = (cs_id << intlv_addr_bit);
-		temp_addr_x = (ctx.ret_addr & GENMASK_ULL(63, intlv_addr_bit)) << num_intlv_bits;
-		ctx.ret_addr    = temp_addr_x | temp_addr_i | temp_addr_y;
-	}
-
-	/* Add dram base address */
-	ctx.ret_addr += dram_base_addr;
-
-	/* If legacy MMIO hole enabled */
-	if (lgcy_mmio_hole_en) {
-		if (df_indirect_read_broadcast(nid, 0, 0x104, &ctx.tmp))
-			goto out_err;
-
-		dram_hole_base = ctx.tmp & GENMASK(31, 24);
-		if (ctx.ret_addr >= dram_hole_base)
-			ctx.ret_addr += (BIT_ULL(32) - dram_hole_base);
-	}
-
-	if (hash_enabled) {
-		/* Save some parentheses and grab ls-bit at the end. */
-		hashed_bit =	(ctx.ret_addr >> 12) ^
-				(ctx.ret_addr >> 18) ^
-				(ctx.ret_addr >> 21) ^
-				(ctx.ret_addr >> 30) ^
-				cs_id;
-
-		hashed_bit &= BIT(0);
-
-		if (hashed_bit != ((ctx.ret_addr >> intlv_addr_bit) & BIT(0)))
-			ctx.ret_addr ^= BIT(intlv_addr_bit);
-	}
-
-	/* Is calculated system address is above DRAM limit address? */
-	if (ctx.ret_addr > dram_limit_addr)
-		goto out_err;
-
-	*sys_addr = ctx.ret_addr;
-	return 0;
-
-out_err:
-	return -EINVAL;
-}
-
 static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
 
 /*
@@ -3065,9 +2791,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
 	struct mem_ctl_info *mci;
+	unsigned long sys_addr;
 	struct amd64_pvt *pvt;
 	struct err_info err;
-	u64 sys_addr;
 
 	node_id = fixup_node_id(node_id, m);
 
@@ -3098,7 +2824,9 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt->ops->get_err_info(m, &err);
 
-	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
+	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(m);
+
+	if (IS_ERR_VALUE(sys_addr)) {
 		err.err_code = ERR_NORM_ADDR;
 		goto log_error;
 	}

