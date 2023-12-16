Return-Path: <linux-kernel+bounces-2357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF9815B92
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A631F23D42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065632C6B;
	Sat, 16 Dec 2023 20:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CcrN//bi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8032C62
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5HNf2pNOsYAPbPm8o6cVcuB7lS1TciZuaWkSB6ieFu8=; b=CcrN//biXgpX2OOTxTzZNx0Ncx
	S51CtZCOMqf+3R3x3XW9lKUulHRtwWYw+/UhNg40Px7R0QFHdHBxViHI5+ZE4oAgMxXNduuHBjAEs
	P8GeJSQ6NxFvshnyaZ7/5klGyvpoKHbLsgQ87PjhlBYsXsq2iZ25fzeQtlw84T+coxFqtLb/00w+Z
	XadlUPJWCyGUIgM2c0nFX3EC27/FGGlB1K7qBKT3qVZdukBmiK3v8af97w9Ggjq0Cmd3JjhwCbVXb
	gucz4XHphcfBNRRlZX19kZ2Vnziqbt2Qs3YTa8oKtKjM7NHCWi2h6zD1mLgbAoIVXZx4026ynSoDJ
	UgPMUtDw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEb0r-006ftn-1m;
	Sat, 16 Dec 2023 20:11:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/nouveau/bios/init: drop kernel-doc notation
Date: Sat, 16 Dec 2023 12:11:52 -0800
Message-ID: <20231216201152.31376-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "/**" comments in this file are not kernel-doc comments. They are
used on static functions which can have kernel-doc comments, but that
is not the primary focus of kernel-doc comments.
Since these comments are incomplete for kernel-doc notation, remove
the kernel-doc "/**" markers and make them common comments.

This prevents scripts/kernel-doc from issuing 68 warnings:

init.c:584: warning: Function parameter or member 'init' not described in 'init_reserved'

and 67 warnings like this one:
init.c:611: warning: expecting prototype for INIT_DONE(). Prototype was for init_done() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c |  136 +++++++-------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff -- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -575,7 +575,7 @@ init_tmds_reg(struct nvbios_init *init,
  * init opcode handlers
  *****************************************************************************/
 
-/**
+/*
  * init_reserved - stub for various unknown/unused single-byte opcodes
  *
  */
@@ -602,7 +602,7 @@ init_reserved(struct nvbios_init *init)
 	init->offset += length;
 }
 
-/**
+/*
  * INIT_DONE - opcode 0x71
  *
  */
@@ -613,7 +613,7 @@ init_done(struct nvbios_init *init)
 	init->offset = 0x0000;
 }
 
-/**
+/*
  * INIT_IO_RESTRICT_PROG - opcode 0x32
  *
  */
@@ -650,7 +650,7 @@ init_io_restrict_prog(struct nvbios_init
 	trace("}]\n");
 }
 
-/**
+/*
  * INIT_REPEAT - opcode 0x33
  *
  */
@@ -676,7 +676,7 @@ init_repeat(struct nvbios_init *init)
 	init->repeat = repeat;
 }
 
-/**
+/*
  * INIT_IO_RESTRICT_PLL - opcode 0x34
  *
  */
@@ -716,7 +716,7 @@ init_io_restrict_pll(struct nvbios_init
 	trace("}]\n");
 }
 
-/**
+/*
  * INIT_END_REPEAT - opcode 0x36
  *
  */
@@ -732,7 +732,7 @@ init_end_repeat(struct nvbios_init *init
 	}
 }
 
-/**
+/*
  * INIT_COPY - opcode 0x37
  *
  */
@@ -759,7 +759,7 @@ init_copy(struct nvbios_init *init)
 	init_wrvgai(init, port, index, data);
 }
 
-/**
+/*
  * INIT_NOT - opcode 0x38
  *
  */
@@ -771,7 +771,7 @@ init_not(struct nvbios_init *init)
 	init_exec_inv(init);
 }
 
-/**
+/*
  * INIT_IO_FLAG_CONDITION - opcode 0x39
  *
  */
@@ -788,7 +788,7 @@ init_io_flag_condition(struct nvbios_ini
 		init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_GENERIC_CONDITION - opcode 0x3a
  *
  */
@@ -840,7 +840,7 @@ init_generic_condition(struct nvbios_ini
 	}
 }
 
-/**
+/*
  * INIT_IO_MASK_OR - opcode 0x3b
  *
  */
@@ -859,7 +859,7 @@ init_io_mask_or(struct nvbios_init *init
 	init_wrvgai(init, 0x03d4, index, data &= ~(1 << or));
 }
 
-/**
+/*
  * INIT_IO_OR - opcode 0x3c
  *
  */
@@ -878,7 +878,7 @@ init_io_or(struct nvbios_init *init)
 	init_wrvgai(init, 0x03d4, index, data | (1 << or));
 }
 
-/**
+/*
  * INIT_ANDN_REG - opcode 0x47
  *
  */
@@ -895,7 +895,7 @@ init_andn_reg(struct nvbios_init *init)
 	init_mask(init, reg, mask, 0);
 }
 
-/**
+/*
  * INIT_OR_REG - opcode 0x48
  *
  */
@@ -912,7 +912,7 @@ init_or_reg(struct nvbios_init *init)
 	init_mask(init, reg, 0, mask);
 }
 
-/**
+/*
  * INIT_INDEX_ADDRESS_LATCHED - opcode 0x49
  *
  */
@@ -942,7 +942,7 @@ init_idx_addr_latched(struct nvbios_init
 	}
 }
 
-/**
+/*
  * INIT_IO_RESTRICT_PLL2 - opcode 0x4a
  *
  */
@@ -977,7 +977,7 @@ init_io_restrict_pll2(struct nvbios_init
 	trace("}]\n");
 }
 
-/**
+/*
  * INIT_PLL2 - opcode 0x4b
  *
  */
@@ -994,7 +994,7 @@ init_pll2(struct nvbios_init *init)
 	init_prog_pll(init, reg, freq);
 }
 
-/**
+/*
  * INIT_I2C_BYTE - opcode 0x4c
  *
  */
@@ -1025,7 +1025,7 @@ init_i2c_byte(struct nvbios_init *init)
 	}
 }
 
-/**
+/*
  * INIT_ZM_I2C_BYTE - opcode 0x4d
  *
  */
@@ -1051,7 +1051,7 @@ init_zm_i2c_byte(struct nvbios_init *ini
 	}
 }
 
-/**
+/*
  * INIT_ZM_I2C - opcode 0x4e
  *
  */
@@ -1085,7 +1085,7 @@ init_zm_i2c(struct nvbios_init *init)
 	}
 }
 
-/**
+/*
  * INIT_TMDS - opcode 0x4f
  *
  */
@@ -1111,7 +1111,7 @@ init_tmds(struct nvbios_init *init)
 	init_wr32(init, reg + 0, addr);
 }
 
-/**
+/*
  * INIT_ZM_TMDS_GROUP - opcode 0x50
  *
  */
@@ -1138,7 +1138,7 @@ init_zm_tmds_group(struct nvbios_init *i
 	}
 }
 
-/**
+/*
  * INIT_CR_INDEX_ADDRESS_LATCHED - opcode 0x51
  *
  */
@@ -1168,7 +1168,7 @@ init_cr_idx_adr_latch(struct nvbios_init
 	init_wrvgai(init, 0x03d4, addr0, save0);
 }
 
-/**
+/*
  * INIT_CR - opcode 0x52
  *
  */
@@ -1188,7 +1188,7 @@ init_cr(struct nvbios_init *init)
 	init_wrvgai(init, 0x03d4, addr, val | data);
 }
 
-/**
+/*
  * INIT_ZM_CR - opcode 0x53
  *
  */
@@ -1205,7 +1205,7 @@ init_zm_cr(struct nvbios_init *init)
 	init_wrvgai(init, 0x03d4, addr, data);
 }
 
-/**
+/*
  * INIT_ZM_CR_GROUP - opcode 0x54
  *
  */
@@ -1229,7 +1229,7 @@ init_zm_cr_group(struct nvbios_init *ini
 	}
 }
 
-/**
+/*
  * INIT_CONDITION_TIME - opcode 0x56
  *
  */
@@ -1256,7 +1256,7 @@ init_condition_time(struct nvbios_init *
 	init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_LTIME - opcode 0x57
  *
  */
@@ -1273,7 +1273,7 @@ init_ltime(struct nvbios_init *init)
 		mdelay(msec);
 }
 
-/**
+/*
  * INIT_ZM_REG_SEQUENCE - opcode 0x58
  *
  */
@@ -1298,7 +1298,7 @@ init_zm_reg_sequence(struct nvbios_init
 	}
 }
 
-/**
+/*
  * INIT_PLL_INDIRECT - opcode 0x59
  *
  */
@@ -1317,7 +1317,7 @@ init_pll_indirect(struct nvbios_init *in
 	init_prog_pll(init, reg, freq);
 }
 
-/**
+/*
  * INIT_ZM_REG_INDIRECT - opcode 0x5a
  *
  */
@@ -1336,7 +1336,7 @@ init_zm_reg_indirect(struct nvbios_init
 	init_wr32(init, addr, data);
 }
 
-/**
+/*
  * INIT_SUB_DIRECT - opcode 0x5b
  *
  */
@@ -1362,7 +1362,7 @@ init_sub_direct(struct nvbios_init *init
 	init->offset += 3;
 }
 
-/**
+/*
  * INIT_JUMP - opcode 0x5c
  *
  */
@@ -1380,7 +1380,7 @@ init_jump(struct nvbios_init *init)
 		init->offset += 3;
 }
 
-/**
+/*
  * INIT_I2C_IF - opcode 0x5e
  *
  */
@@ -1407,7 +1407,7 @@ init_i2c_if(struct nvbios_init *init)
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_COPY_NV_REG - opcode 0x5f
  *
  */
@@ -1433,7 +1433,7 @@ init_copy_nv_reg(struct nvbios_init *ini
 	init_mask(init, dreg, ~dmask, (data & smask) ^ sxor);
 }
 
-/**
+/*
  * INIT_ZM_INDEX_IO - opcode 0x62
  *
  */
@@ -1451,7 +1451,7 @@ init_zm_index_io(struct nvbios_init *ini
 	init_wrvgai(init, port, index, data);
 }
 
-/**
+/*
  * INIT_COMPUTE_MEM - opcode 0x63
  *
  */
@@ -1469,7 +1469,7 @@ init_compute_mem(struct nvbios_init *ini
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_RESET - opcode 0x65
  *
  */
@@ -1496,7 +1496,7 @@ init_reset(struct nvbios_init *init)
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_CONFIGURE_MEM - opcode 0x66
  *
  */
@@ -1555,7 +1555,7 @@ init_configure_mem(struct nvbios_init *i
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_CONFIGURE_CLK - opcode 0x67
  *
  */
@@ -1589,7 +1589,7 @@ init_configure_clk(struct nvbios_init *i
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_CONFIGURE_PREINIT - opcode 0x68
  *
  */
@@ -1615,7 +1615,7 @@ init_configure_preinit(struct nvbios_ini
 	init_exec_force(init, false);
 }
 
-/**
+/*
  * INIT_IO - opcode 0x69
  *
  */
@@ -1655,7 +1655,7 @@ init_io(struct nvbios_init *init)
 	init_wrport(init, port, data | value);
 }
 
-/**
+/*
  * INIT_SUB - opcode 0x6b
  *
  */
@@ -1682,7 +1682,7 @@ init_sub(struct nvbios_init *init)
 	init->offset += 2;
 }
 
-/**
+/*
  * INIT_RAM_CONDITION - opcode 0x6d
  *
  */
@@ -1701,7 +1701,7 @@ init_ram_condition(struct nvbios_init *i
 		init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_NV_REG - opcode 0x6e
  *
  */
@@ -1719,7 +1719,7 @@ init_nv_reg(struct nvbios_init *init)
 	init_mask(init, reg, ~mask, data);
 }
 
-/**
+/*
  * INIT_MACRO - opcode 0x6f
  *
  */
@@ -1743,7 +1743,7 @@ init_macro(struct nvbios_init *init)
 	init->offset += 2;
 }
 
-/**
+/*
  * INIT_RESUME - opcode 0x72
  *
  */
@@ -1755,7 +1755,7 @@ init_resume(struct nvbios_init *init)
 	init_exec_set(init, true);
 }
 
-/**
+/*
  * INIT_STRAP_CONDITION - opcode 0x73
  *
  */
@@ -1773,7 +1773,7 @@ init_strap_condition(struct nvbios_init
 		init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_TIME - opcode 0x74
  *
  */
@@ -1794,7 +1794,7 @@ init_time(struct nvbios_init *init)
 	}
 }
 
-/**
+/*
  * INIT_CONDITION - opcode 0x75
  *
  */
@@ -1811,7 +1811,7 @@ init_condition(struct nvbios_init *init)
 		init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_IO_CONDITION - opcode 0x76
  *
  */
@@ -1828,7 +1828,7 @@ init_io_condition(struct nvbios_init *in
 		init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_ZM_REG16 - opcode 0x77
  *
  */
@@ -1845,7 +1845,7 @@ init_zm_reg16(struct nvbios_init *init)
 	init_wr32(init, addr, data);
 }
 
-/**
+/*
  * INIT_INDEX_IO - opcode 0x78
  *
  */
@@ -1867,7 +1867,7 @@ init_index_io(struct nvbios_init *init)
 	init_wrvgai(init, port, index, data | value);
 }
 
-/**
+/*
  * INIT_PLL - opcode 0x79
  *
  */
@@ -1884,7 +1884,7 @@ init_pll(struct nvbios_init *init)
 	init_prog_pll(init, reg, freq);
 }
 
-/**
+/*
  * INIT_ZM_REG - opcode 0x7a
  *
  */
@@ -1904,7 +1904,7 @@ init_zm_reg(struct nvbios_init *init)
 	init_wr32(init, addr, data);
 }
 
-/**
+/*
  * INIT_RAM_RESTRICT_PLL - opcde 0x87
  *
  */
@@ -1934,7 +1934,7 @@ init_ram_restrict_pll(struct nvbios_init
 	}
 }
 
-/**
+/*
  * INIT_RESET_BEGUN - opcode 0x8c
  *
  */
@@ -1945,7 +1945,7 @@ init_reset_begun(struct nvbios_init *ini
 	init->offset += 1;
 }
 
-/**
+/*
  * INIT_RESET_END - opcode 0x8d
  *
  */
@@ -1956,7 +1956,7 @@ init_reset_end(struct nvbios_init *init)
 	init->offset += 1;
 }
 
-/**
+/*
  * INIT_GPIO - opcode 0x8e
  *
  */
@@ -1972,7 +1972,7 @@ init_gpio(struct nvbios_init *init)
 		nvkm_gpio_reset(gpio, DCB_GPIO_UNUSED);
 }
 
-/**
+/*
  * INIT_RAM_RESTRICT_ZM_GROUP - opcode 0x8f
  *
  */
@@ -2010,7 +2010,7 @@ init_ram_restrict_zm_reg_group(struct nv
 	}
 }
 
-/**
+/*
  * INIT_COPY_ZM_REG - opcode 0x90
  *
  */
@@ -2027,7 +2027,7 @@ init_copy_zm_reg(struct nvbios_init *ini
 	init_wr32(init, dreg, init_rd32(init, sreg));
 }
 
-/**
+/*
  * INIT_ZM_REG_GROUP - opcode 0x91
  *
  */
@@ -2049,7 +2049,7 @@ init_zm_reg_group(struct nvbios_init *in
 	}
 }
 
-/**
+/*
  * INIT_XLAT - opcode 0x96
  *
  */
@@ -2077,7 +2077,7 @@ init_xlat(struct nvbios_init *init)
 	init_mask(init, daddr, ~dmask, data);
 }
 
-/**
+/*
  * INIT_ZM_MASK_ADD - opcode 0x97
  *
  */
@@ -2098,7 +2098,7 @@ init_zm_mask_add(struct nvbios_init *ini
 	init_wr32(init, addr, data);
 }
 
-/**
+/*
  * INIT_AUXCH - opcode 0x98
  *
  */
@@ -2122,7 +2122,7 @@ init_auxch(struct nvbios_init *init)
 	}
 }
 
-/**
+/*
  * INIT_AUXCH - opcode 0x99
  *
  */
@@ -2144,7 +2144,7 @@ init_zm_auxch(struct nvbios_init *init)
 	}
 }
 
-/**
+/*
  * INIT_I2C_LONG_IF - opcode 0x9a
  *
  */
@@ -2183,7 +2183,7 @@ init_i2c_long_if(struct nvbios_init *ini
 	init_exec_set(init, false);
 }
 
-/**
+/*
  * INIT_GPIO_NE - opcode 0xa9
  *
  */

