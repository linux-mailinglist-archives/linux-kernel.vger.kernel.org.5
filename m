Return-Path: <linux-kernel+bounces-59772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8984FB97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1991C25229
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9D127B69;
	Fri,  9 Feb 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="dc1U1F4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vn1APbAN"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD684A50;
	Fri,  9 Feb 2024 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502088; cv=none; b=C8SaEnEDraE/QWTM2pXp1VXvmP4cs3bzWuxjITrU3zMkh6ouUVTSjkpTtoLr7ekDnHRmHvxzV7wYTVhNJgJ701odqVLOm7yt5oUWRapFWSxPB1tf2bqlbZ0Oqp0zxmnv0nGphuBE1dEBZqbmEhPca1zEYjOjfk2x+RGTGHn+GQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502088; c=relaxed/simple;
	bh=U59qFELCgrV/R3QuGSA+/5l8zGuhaS8ricquO0KyPO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqsQ0PzkztGTi4sXdZnHXqC15jpV1LsyiT3qzJBS5CR2lykvY94nIuaBKrCys159Cp9Bu+1DTxWxYhmFL6/XaLNKwF4XQ186PCHN/kRFDG/aElxQdptJmml/Oa0QIlGvgks6a6QWpRWYTMG2fICX/r1dfIrj4WNgFkGOHCXljf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=dc1U1F4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vn1APbAN; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id DC2335C0154;
	Fri,  9 Feb 2024 13:08:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Feb 2024 13:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1707502084;
	 x=1707588484; bh=TTB1IY9VvEjaszu/AtF8BJTEXlJf6fHxvsuI+4EegIE=; b=
	dc1U1F4cb9aMCdYz60lVNz/E3BA2pJKlADxorJqwOGzjnq8pCjIZx9EP3GQzqWdL
	riwfwCAUoOlgmg6FOfanX2qBw2CktbBxIP+43WFbGwoZgOwfyfxni7JiSCl33hfc
	dPQayjbYc0i0QArTf5MfaEQiwq7U9ZtZvQqt0x1+TJCqBZScBV+69HRKCYaMUcYU
	cNoLQAmc5Rgdf6MQSrCI8QcJwfzTlVk3VlAQVlANjUP2ecLjTKeeaz4CYTm7/4K8
	Bek1k79GNiyA2ZFJv59tykSZwaosb5hc+0raoacL8iiIuBga+M/b9FviPQrOj6Ib
	leePElSrN1TfLw4dx87Byg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707502084; x=
	1707588484; bh=TTB1IY9VvEjaszu/AtF8BJTEXlJf6fHxvsuI+4EegIE=; b=V
	n1APbANilaxDNjel3BwXrvhzRVsHMfiUeWPikqAwJj1NTrocmW9ZDZIGTOgnZ8nN
	4g3Za6wckRo9HCLUlqh+F1JqqlLJIX9bak8B9Y++NeJHnDhUbE+nwX8fbpJ8uraS
	BMtLvuEIeSovXv6pTBU+n+nC9JuvD1tew2cymN2+75qlnTvowsmm+ffqCFcXt3T2
	8nB7VDSsW4HP996yIeZKkwe7AJ2znHV7fgkzMDvILMICJLRbEeshjWUviYSqMP//
	raQjnoMZ09/P6GOlWoFj09fX07jYQCweWtyf0J+WCOJ2uwAqWnyIYd1RB3TSuAYI
	nGuQXCVcBLSYtRYlwNbCg==
X-ME-Sender: <xms:BGrGZSywaLaKN0-wpP9_dphDP99w8-h5sPiISEEzFpQDBpjKCCvn4g>
    <xme:BGrGZeSmYJHS0T0ejwgydUzhUiHRGcNY1SskUvu_Hu0q0-4Oa8byPzYfJxRXNP1-5
    otdEQA49qrV-onyd0I>
X-ME-Received: <xmr:BGrGZUU_qEUopZxYWwQXlRB5YfgFrB-y_I2kXUDVufRylYe-9vxnYFShgTHCNBv0AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:BGrGZYha-j_98XO0FsAtYKaCGC7qJukyiplaNeLSvSUzHwJEB9nrgg>
    <xmx:BGrGZUCAksx4Y4BgB9yPmHjuG7ri1SBkjaWDEqPuz-HIEC9IfbuGgw>
    <xmx:BGrGZZK3gPUK3GWV-5GGjhRnpkVw-1IZI51ik80wFgSPcMLKZYNNVg>
    <xmx:BGrGZX-bts9nRiYWF9tcbOAO9ppVm81IINB9qrykJG3JVY5jgVB1dg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 13:08:03 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Feb 2024 18:07:51 +0000
Subject: [PATCH 5/8] MIPS: page: Use GPR number macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-regname-v1-5-2125efa016ef@flygoat.com>
References: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
In-Reply-To: <20240209-regname-v1-0-2125efa016ef@flygoat.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=16105;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=U59qFELCgrV/R3QuGSA+/5l8zGuhaS8ricquO0KyPO8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhtRjmX/ZHnHq/JR5Ozuz6vbT0HfOb3+I2aRJ3r+8daK4h
 /cms8INHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRPRIM/6NOL6zu/zI7Qf+E
 /vKSacnljLeOr99amhdxvvk7V+1yfmOGPzx+V7PiXVkZp37j/nW/tqqB66PzhIdHnv/kDtmntOG
 SKi8A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Use GPR number macros in uasm code generation parts to
reduce code duplication.

No functional change.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mm/page.c | 202 ++++++++++++++++++++++++----------------------------
 1 file changed, 95 insertions(+), 107 deletions(-)

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index d3b4459d0fe8..1df237bd4a72 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -24,6 +24,7 @@
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
+#include <asm/regdef.h>
 #include <asm/cpu.h>
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
@@ -34,19 +35,6 @@
 
 #include <asm/uasm.h>
 
-/* Registers used in the assembled routines. */
-#define ZERO 0
-#define AT 2
-#define A0 4
-#define A1 5
-#define A2 6
-#define T0 8
-#define T1 9
-#define T2 10
-#define T3 11
-#define T9 25
-#define RA 31
-
 /* Handle labels (which must be positive integers). */
 enum label_id {
 	label_clear_nopref = 1,
@@ -106,16 +94,16 @@ pg_addiu(u32 **buf, unsigned int reg1, unsigned int reg2, unsigned int off)
 	    IS_ENABLED(CONFIG_CPU_DADDI_WORKAROUNDS) &&
 	    r4k_daddiu_bug()) {
 		if (off > 0x7fff) {
-			uasm_i_lui(buf, T9, uasm_rel_hi(off));
-			uasm_i_addiu(buf, T9, T9, uasm_rel_lo(off));
+			uasm_i_lui(buf, GPR_T9, uasm_rel_hi(off));
+			uasm_i_addiu(buf, GPR_T9, GPR_T9, uasm_rel_lo(off));
 		} else
-			uasm_i_addiu(buf, T9, ZERO, off);
-		uasm_i_daddu(buf, reg1, reg2, T9);
+			uasm_i_addiu(buf, GPR_T9, GPR_ZERO, off);
+		uasm_i_daddu(buf, reg1, reg2, GPR_T9);
 	} else {
 		if (off > 0x7fff) {
-			uasm_i_lui(buf, T9, uasm_rel_hi(off));
-			uasm_i_addiu(buf, T9, T9, uasm_rel_lo(off));
-			UASM_i_ADDU(buf, reg1, reg2, T9);
+			uasm_i_lui(buf, GPR_T9, uasm_rel_hi(off));
+			uasm_i_addiu(buf, GPR_T9, GPR_T9, uasm_rel_lo(off));
+			UASM_i_ADDU(buf, reg1, reg2, GPR_T9);
 		} else
 			UASM_i_ADDIU(buf, reg1, reg2, off);
 	}
@@ -233,9 +221,9 @@ static void set_prefetch_parameters(void)
 static void build_clear_store(u32 **buf, int off)
 {
 	if (cpu_has_64bit_gp_regs || cpu_has_64bit_zero_reg) {
-		uasm_i_sd(buf, ZERO, off, A0);
+		uasm_i_sd(buf, GPR_ZERO, off, GPR_A0);
 	} else {
-		uasm_i_sw(buf, ZERO, off, A0);
+		uasm_i_sw(buf, GPR_ZERO, off, GPR_A0);
 	}
 }
 
@@ -246,10 +234,10 @@ static inline void build_clear_pref(u32 **buf, int off)
 
 	if (pref_bias_clear_store) {
 		_uasm_i_pref(buf, pref_dst_mode, pref_bias_clear_store + off,
-			    A0);
+			    GPR_A0);
 	} else if (cache_line_size == (half_clear_loop_size << 1)) {
 		if (cpu_has_cache_cdex_s) {
-			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, GPR_A0);
 		} else if (cpu_has_cache_cdex_p) {
 			if (IS_ENABLED(CONFIG_WAR_R4600_V1_HIT_CACHEOP) &&
 			    cpu_is_r4600_v1_x()) {
@@ -261,9 +249,9 @@ static inline void build_clear_pref(u32 **buf, int off)
 
 			if (IS_ENABLED(CONFIG_WAR_R4600_V2_HIT_CACHEOP) &&
 			    cpu_is_r4600_v2_x())
-				uasm_i_lw(buf, ZERO, ZERO, AT);
+				uasm_i_lw(buf, GPR_ZERO, GPR_ZERO, GPR_AT);
 
-			uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+			uasm_i_cache(buf, Create_Dirty_Excl_D, off, GPR_A0);
 		}
 	}
 }
@@ -301,12 +289,12 @@ void build_clear_page(void)
 
 	off = PAGE_SIZE - pref_bias_clear_store;
 	if (off > 0xffff || !pref_bias_clear_store)
-		pg_addiu(&buf, A2, A0, off);
+		pg_addiu(&buf, GPR_A2, GPR_A0, off);
 	else
-		uasm_i_ori(&buf, A2, A0, off);
+		uasm_i_ori(&buf, GPR_A2, GPR_A0, off);
 
 	if (IS_ENABLED(CONFIG_WAR_R4600_V2_HIT_CACHEOP) && cpu_is_r4600_v2_x())
-		uasm_i_lui(&buf, AT, uasm_rel_hi(0xa0000000));
+		uasm_i_lui(&buf, GPR_AT, uasm_rel_hi(0xa0000000));
 
 	off = cache_line_size ? min(8, pref_bias_clear_store / cache_line_size)
 				* cache_line_size : 0;
@@ -320,36 +308,36 @@ void build_clear_page(void)
 		build_clear_store(&buf, off);
 		off += clear_word_size;
 	} while (off < half_clear_loop_size);
-	pg_addiu(&buf, A0, A0, 2 * off);
+	pg_addiu(&buf, GPR_A0, GPR_A0, 2 * off);
 	off = -off;
 	do {
 		build_clear_pref(&buf, off);
 		if (off == -clear_word_size)
-			uasm_il_bne(&buf, &r, A0, A2, label_clear_pref);
+			uasm_il_bne(&buf, &r, GPR_A0, GPR_A2, label_clear_pref);
 		build_clear_store(&buf, off);
 		off += clear_word_size;
 	} while (off < 0);
 
 	if (pref_bias_clear_store) {
-		pg_addiu(&buf, A2, A0, pref_bias_clear_store);
+		pg_addiu(&buf, GPR_A2, GPR_A0, pref_bias_clear_store);
 		uasm_l_clear_nopref(&l, buf);
 		off = 0;
 		do {
 			build_clear_store(&buf, off);
 			off += clear_word_size;
 		} while (off < half_clear_loop_size);
-		pg_addiu(&buf, A0, A0, 2 * off);
+		pg_addiu(&buf, GPR_A0, GPR_A0, 2 * off);
 		off = -off;
 		do {
 			if (off == -clear_word_size)
-				uasm_il_bne(&buf, &r, A0, A2,
+				uasm_il_bne(&buf, &r, GPR_A0, GPR_A2,
 					    label_clear_nopref);
 			build_clear_store(&buf, off);
 			off += clear_word_size;
 		} while (off < 0);
 	}
 
-	uasm_i_jr(&buf, RA);
+	uasm_i_jr(&buf, GPR_RA);
 	uasm_i_nop(&buf);
 
 	BUG_ON(buf > &__clear_page_end);
@@ -369,18 +357,18 @@ void build_clear_page(void)
 static void build_copy_load(u32 **buf, int reg, int off)
 {
 	if (cpu_has_64bit_gp_regs) {
-		uasm_i_ld(buf, reg, off, A1);
+		uasm_i_ld(buf, reg, off, GPR_A1);
 	} else {
-		uasm_i_lw(buf, reg, off, A1);
+		uasm_i_lw(buf, reg, off, GPR_A1);
 	}
 }
 
 static void build_copy_store(u32 **buf, int reg, int off)
 {
 	if (cpu_has_64bit_gp_regs) {
-		uasm_i_sd(buf, reg, off, A0);
+		uasm_i_sd(buf, reg, off, GPR_A0);
 	} else {
-		uasm_i_sw(buf, reg, off, A0);
+		uasm_i_sw(buf, reg, off, GPR_A0);
 	}
 }
 
@@ -390,7 +378,7 @@ static inline void build_copy_load_pref(u32 **buf, int off)
 		return;
 
 	if (pref_bias_copy_load)
-		_uasm_i_pref(buf, pref_src_mode, pref_bias_copy_load + off, A1);
+		_uasm_i_pref(buf, pref_src_mode, pref_bias_copy_load + off, GPR_A1);
 }
 
 static inline void build_copy_store_pref(u32 **buf, int off)
@@ -400,10 +388,10 @@ static inline void build_copy_store_pref(u32 **buf, int off)
 
 	if (pref_bias_copy_store) {
 		_uasm_i_pref(buf, pref_dst_mode, pref_bias_copy_store + off,
-			    A0);
+			    GPR_A0);
 	} else if (cache_line_size == (half_copy_loop_size << 1)) {
 		if (cpu_has_cache_cdex_s) {
-			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, A0);
+			uasm_i_cache(buf, Create_Dirty_Excl_SD, off, GPR_A0);
 		} else if (cpu_has_cache_cdex_p) {
 			if (IS_ENABLED(CONFIG_WAR_R4600_V1_HIT_CACHEOP) &&
 			    cpu_is_r4600_v1_x()) {
@@ -415,9 +403,9 @@ static inline void build_copy_store_pref(u32 **buf, int off)
 
 			if (IS_ENABLED(CONFIG_WAR_R4600_V2_HIT_CACHEOP) &&
 			    cpu_is_r4600_v2_x())
-				uasm_i_lw(buf, ZERO, ZERO, AT);
+				uasm_i_lw(buf, GPR_ZERO, GPR_ZERO, GPR_AT);
 
-			uasm_i_cache(buf, Create_Dirty_Excl_D, off, A0);
+			uasm_i_cache(buf, Create_Dirty_Excl_D, off, GPR_A0);
 		}
 	}
 }
@@ -454,12 +442,12 @@ void build_copy_page(void)
 
 	off = PAGE_SIZE - pref_bias_copy_load;
 	if (off > 0xffff || !pref_bias_copy_load)
-		pg_addiu(&buf, A2, A0, off);
+		pg_addiu(&buf, GPR_A2, GPR_A0, off);
 	else
-		uasm_i_ori(&buf, A2, A0, off);
+		uasm_i_ori(&buf, GPR_A2, GPR_A0, off);
 
 	if (IS_ENABLED(CONFIG_WAR_R4600_V2_HIT_CACHEOP) && cpu_is_r4600_v2_x())
-		uasm_i_lui(&buf, AT, uasm_rel_hi(0xa0000000));
+		uasm_i_lui(&buf, GPR_AT, uasm_rel_hi(0xa0000000));
 
 	off = cache_line_size ? min(8, pref_bias_copy_load / cache_line_size) *
 				cache_line_size : 0;
@@ -476,126 +464,126 @@ void build_copy_page(void)
 	uasm_l_copy_pref_both(&l, buf);
 	do {
 		build_copy_load_pref(&buf, off);
-		build_copy_load(&buf, T0, off);
+		build_copy_load(&buf, GPR_T0, off);
 		build_copy_load_pref(&buf, off + copy_word_size);
-		build_copy_load(&buf, T1, off + copy_word_size);
+		build_copy_load(&buf, GPR_T1, off + copy_word_size);
 		build_copy_load_pref(&buf, off + 2 * copy_word_size);
-		build_copy_load(&buf, T2, off + 2 * copy_word_size);
+		build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
 		build_copy_load_pref(&buf, off + 3 * copy_word_size);
-		build_copy_load(&buf, T3, off + 3 * copy_word_size);
+		build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
 		build_copy_store_pref(&buf, off);
-		build_copy_store(&buf, T0, off);
+		build_copy_store(&buf, GPR_T0, off);
 		build_copy_store_pref(&buf, off + copy_word_size);
-		build_copy_store(&buf, T1, off + copy_word_size);
+		build_copy_store(&buf, GPR_T1, off + copy_word_size);
 		build_copy_store_pref(&buf, off + 2 * copy_word_size);
-		build_copy_store(&buf, T2, off + 2 * copy_word_size);
+		build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
 		build_copy_store_pref(&buf, off + 3 * copy_word_size);
-		build_copy_store(&buf, T3, off + 3 * copy_word_size);
+		build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 		off += 4 * copy_word_size;
 	} while (off < half_copy_loop_size);
-	pg_addiu(&buf, A1, A1, 2 * off);
-	pg_addiu(&buf, A0, A0, 2 * off);
+	pg_addiu(&buf, GPR_A1, GPR_A1, 2 * off);
+	pg_addiu(&buf, GPR_A0, GPR_A0, 2 * off);
 	off = -off;
 	do {
 		build_copy_load_pref(&buf, off);
-		build_copy_load(&buf, T0, off);
+		build_copy_load(&buf, GPR_T0, off);
 		build_copy_load_pref(&buf, off + copy_word_size);
-		build_copy_load(&buf, T1, off + copy_word_size);
+		build_copy_load(&buf, GPR_T1, off + copy_word_size);
 		build_copy_load_pref(&buf, off + 2 * copy_word_size);
-		build_copy_load(&buf, T2, off + 2 * copy_word_size);
+		build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
 		build_copy_load_pref(&buf, off + 3 * copy_word_size);
-		build_copy_load(&buf, T3, off + 3 * copy_word_size);
+		build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
 		build_copy_store_pref(&buf, off);
-		build_copy_store(&buf, T0, off);
+		build_copy_store(&buf, GPR_T0, off);
 		build_copy_store_pref(&buf, off + copy_word_size);
-		build_copy_store(&buf, T1, off + copy_word_size);
+		build_copy_store(&buf, GPR_T1, off + copy_word_size);
 		build_copy_store_pref(&buf, off + 2 * copy_word_size);
-		build_copy_store(&buf, T2, off + 2 * copy_word_size);
+		build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
 		build_copy_store_pref(&buf, off + 3 * copy_word_size);
 		if (off == -(4 * copy_word_size))
-			uasm_il_bne(&buf, &r, A2, A0, label_copy_pref_both);
-		build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			uasm_il_bne(&buf, &r, GPR_A2, GPR_A0, label_copy_pref_both);
+		build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 		off += 4 * copy_word_size;
 	} while (off < 0);
 
 	if (pref_bias_copy_load - pref_bias_copy_store) {
-		pg_addiu(&buf, A2, A0,
+		pg_addiu(&buf, GPR_A2, GPR_A0,
 			 pref_bias_copy_load - pref_bias_copy_store);
 		uasm_l_copy_pref_store(&l, buf);
 		off = 0;
 		do {
-			build_copy_load(&buf, T0, off);
-			build_copy_load(&buf, T1, off + copy_word_size);
-			build_copy_load(&buf, T2, off + 2 * copy_word_size);
-			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_load(&buf, GPR_T0, off);
+			build_copy_load(&buf, GPR_T1, off + copy_word_size);
+			build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
 			build_copy_store_pref(&buf, off);
-			build_copy_store(&buf, T0, off);
+			build_copy_store(&buf, GPR_T0, off);
 			build_copy_store_pref(&buf, off + copy_word_size);
-			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store(&buf, GPR_T1, off + copy_word_size);
 			build_copy_store_pref(&buf, off + 2 * copy_word_size);
-			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
 			build_copy_store_pref(&buf, off + 3 * copy_word_size);
-			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 			off += 4 * copy_word_size;
 		} while (off < half_copy_loop_size);
-		pg_addiu(&buf, A1, A1, 2 * off);
-		pg_addiu(&buf, A0, A0, 2 * off);
+		pg_addiu(&buf, GPR_A1, GPR_A1, 2 * off);
+		pg_addiu(&buf, GPR_A0, GPR_A0, 2 * off);
 		off = -off;
 		do {
-			build_copy_load(&buf, T0, off);
-			build_copy_load(&buf, T1, off + copy_word_size);
-			build_copy_load(&buf, T2, off + 2 * copy_word_size);
-			build_copy_load(&buf, T3, off + 3 * copy_word_size);
+			build_copy_load(&buf, GPR_T0, off);
+			build_copy_load(&buf, GPR_T1, off + copy_word_size);
+			build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
 			build_copy_store_pref(&buf, off);
-			build_copy_store(&buf, T0, off);
+			build_copy_store(&buf, GPR_T0, off);
 			build_copy_store_pref(&buf, off + copy_word_size);
-			build_copy_store(&buf, T1, off + copy_word_size);
+			build_copy_store(&buf, GPR_T1, off + copy_word_size);
 			build_copy_store_pref(&buf, off + 2 * copy_word_size);
-			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
 			build_copy_store_pref(&buf, off + 3 * copy_word_size);
 			if (off == -(4 * copy_word_size))
-				uasm_il_bne(&buf, &r, A2, A0,
+				uasm_il_bne(&buf, &r, GPR_A2, GPR_A0,
 					    label_copy_pref_store);
-			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 			off += 4 * copy_word_size;
 		} while (off < 0);
 	}
 
 	if (pref_bias_copy_store) {
-		pg_addiu(&buf, A2, A0, pref_bias_copy_store);
+		pg_addiu(&buf, GPR_A2, GPR_A0, pref_bias_copy_store);
 		uasm_l_copy_nopref(&l, buf);
 		off = 0;
 		do {
-			build_copy_load(&buf, T0, off);
-			build_copy_load(&buf, T1, off + copy_word_size);
-			build_copy_load(&buf, T2, off + 2 * copy_word_size);
-			build_copy_load(&buf, T3, off + 3 * copy_word_size);
-			build_copy_store(&buf, T0, off);
-			build_copy_store(&buf, T1, off + copy_word_size);
-			build_copy_store(&buf, T2, off + 2 * copy_word_size);
-			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			build_copy_load(&buf, GPR_T0, off);
+			build_copy_load(&buf, GPR_T1, off + copy_word_size);
+			build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, GPR_T0, off);
+			build_copy_store(&buf, GPR_T1, off + copy_word_size);
+			build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
+			build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 			off += 4 * copy_word_size;
 		} while (off < half_copy_loop_size);
-		pg_addiu(&buf, A1, A1, 2 * off);
-		pg_addiu(&buf, A0, A0, 2 * off);
+		pg_addiu(&buf, GPR_A1, GPR_A1, 2 * off);
+		pg_addiu(&buf, GPR_A0, GPR_A0, 2 * off);
 		off = -off;
 		do {
-			build_copy_load(&buf, T0, off);
-			build_copy_load(&buf, T1, off + copy_word_size);
-			build_copy_load(&buf, T2, off + 2 * copy_word_size);
-			build_copy_load(&buf, T3, off + 3 * copy_word_size);
-			build_copy_store(&buf, T0, off);
-			build_copy_store(&buf, T1, off + copy_word_size);
-			build_copy_store(&buf, T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, GPR_T0, off);
+			build_copy_load(&buf, GPR_T1, off + copy_word_size);
+			build_copy_load(&buf, GPR_T2, off + 2 * copy_word_size);
+			build_copy_load(&buf, GPR_T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, GPR_T0, off);
+			build_copy_store(&buf, GPR_T1, off + copy_word_size);
+			build_copy_store(&buf, GPR_T2, off + 2 * copy_word_size);
 			if (off == -(4 * copy_word_size))
-				uasm_il_bne(&buf, &r, A2, A0,
+				uasm_il_bne(&buf, &r, GPR_A2, GPR_A0,
 					    label_copy_nopref);
-			build_copy_store(&buf, T3, off + 3 * copy_word_size);
+			build_copy_store(&buf, GPR_T3, off + 3 * copy_word_size);
 			off += 4 * copy_word_size;
 		} while (off < 0);
 	}
 
-	uasm_i_jr(&buf, RA);
+	uasm_i_jr(&buf, GPR_RA);
 	uasm_i_nop(&buf);
 
 	BUG_ON(buf > &__copy_page_end);

-- 
2.43.0


