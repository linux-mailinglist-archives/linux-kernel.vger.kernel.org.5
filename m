Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D527D3FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjJWTOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJWTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE894;
        Mon, 23 Oct 2023 12:14:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A82605C018F;
        Mon, 23 Oct 2023 15:14:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 15:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698088448; x=
        1698174848; bh=JcLDvuqq+aysWCP3Ln7wvhxjBzjiN4xGl+qlurq8eWo=; b=I
        x0p+2hKhV36+4kxFBgV2uF8sSW6C4x69W+mtWJXEdvPAWto1YepIDQ0VLeNztiOy
        TsdHIAJ2MCIgslaZ/jyovjW3xfK7Tj/xTV1OjQLfk4bYeKMBADXHkGnZBAi4p95H
        tSRVEt1TW2MB+cM2GqkPpieceXZQGWO8xZcm3GY/uKmiCiy1ks0S1nY+k/jri1P9
        +kaguMc+AIj3JkTdyhcaqn/vMJAilalWuu23yAznevMf5YTcrw/RReu6aBEtYvJd
        W+paPhXs5wjGLcJMbPfA94VnJ62FDyc0kGyzrF4Q8amKqu8YTgEwSDxuWvhmHqo4
        7AKC+dOLMdb2zIHhSQ7yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698088448; x=
        1698174848; bh=JcLDvuqq+aysWCP3Ln7wvhxjBzjiN4xGl+qlurq8eWo=; b=B
        zlIWe1pfXF0bQItm3SOz+AYb1PVnv0OmdRHmQQCn3Cb1YUkHrxz43StuPqog4Q6O
        W+WpxrKC5H5/mtMrgiUicF5ueXbX+x6HE2EW5VJO1dwcRw+eSz6MGciNRqaRhxe8
        b9lrxfZFROiCViLN0CnyC3VWqsPdO9kUJQxH/j1YHx7aVypsayH/lm3P3+7QkS66
        GTyPwS8VjalNqRZbyUrvfYatIASl5x6rv6x1KlqjYk9blSI8fAaweBI6s34wVNYu
        jsOp7OZwaPhcYZtGN0EE25UxacTGOSl8A/bJOMbxCHXkx3L9iyB5yTUdjRYjhp2N
        YW6KykmCDB+OatRkizI5A==
X-ME-Sender: <xms:AMY2Zdrp2L19g0i8x31HvZhSnVkC9s7nYRNNNcDXgAISMrjHrvLFlA>
    <xme:AMY2ZfqJY6DNLyqJPFQbNDaUZzIAzagJ4p87CukB3PsSxXt1hG3QCzKRZQPEgZy9e
    HuhF7JKo4aXcnJSx4I>
X-ME-Received: <xmr:AMY2ZaOzMK5FN71Ipod_HbZhUWbgyjSLBprO7P2p-WcBQNnr4dkGWsGBID5fcCjOF3HdCt_49oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepieevkeevgeelfffhue
    efgeetkeehffffuddtvdelieeghedvheegkedvudeltdfhnecuffhomhgrihhnpehgvghn
    vgigrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:AMY2ZY5aSCUv2d5wCyvGHD6s1liFiOxixZirI98SDRXb9FlBpecu-w>
    <xmx:AMY2Zc7mVbx8z8XrJxJZcg3GmZP2ge0R9o5e4rgm78tosPlaZxFDlw>
    <xmx:AMY2ZQj2vkhUsJjcB0hZ28SJroFxIHQj6VeL0P_jNvUJg-dJ6voYvQ>
    <xmx:AMY2ZX1B8bSRIKcxMHMur--zALRT5dkO-ggCWqeF2780xnJ24nR9lA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:07 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/5] MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
Date:   Mon, 23 Oct 2023 20:13:57 +0100
Message-Id: <20231023191400.170052-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use {highest, higher, hi, lo} immediate loading sequence
to load 64 bit jump address for handler when kernel is
loaded to XKPHYS.

Co-developed-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Co-developed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/genex.S | 19 +++++++++++++++----
 arch/mips/kernel/traps.c | 34 ++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index b6de8e88c1bd..fd765ad9ecac 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -272,11 +272,22 @@ NESTED(except_vec_vi, 0, sp)
 	.set	push
 	.set	noreorder
 	PTR_LA	v1, except_vec_vi_handler
-FEXPORT(except_vec_vi_lui)
-	lui	v0, 0		/* Patched */
+#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
+FEXPORT(except_vec_vi_hi)
+	lui	v0, 0			/* Patched */
+#else
+FEXPORT(except_vec_vi_highest)
+	lui	v0, 0			/* Patched */
+FEXPORT(except_vec_vi_higher)
+	daddiu	v0, 0			/* Patched */
+	dsll	v0, 16
+FEXPORT(except_vec_vi_hi)
+	daddiu	v0, 0			/* Patched */
+	dsll	v0, 16
+#endif
 	jr	v1
-FEXPORT(except_vec_vi_ori)
-	 ori	v0, 0		/* Patched */
+FEXPORT(except_vec_vi_lo)
+	PTR_ADDIU	v0, 0		/* Patched */
 	.set	pop
 	END(except_vec_vi)
 EXPORT(except_vec_vi_end)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b0261..60c513c51684 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2091,18 +2091,26 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 		 * If no shadow set is selected then use the default handler
 		 * that does normal register saving and standard interrupt exit
 		 */
-		extern const u8 except_vec_vi[], except_vec_vi_lui[];
-		extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
+		extern const u8 except_vec_vi[], except_vec_vi_hi[];
+		extern const u8 except_vec_vi_lo[], except_vec_vi_end[];
+#if defined(CONFIG_64BIT) && !defined(KBUILD_64BIT_SYM32)
+		extern const u8 except_vec_vi_highest[], except_vec_vi_higher[];
+#endif
 		extern const u8 rollback_except_vec_vi[];
 		const u8 *vec_start = using_rollback_handler() ?
 				      rollback_except_vec_vi : except_vec_vi;
 #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
-		const int lui_offset = except_vec_vi_lui - vec_start + 2;
-		const int ori_offset = except_vec_vi_ori - vec_start + 2;
+		const int imm_offset = 2;
 #else
-		const int lui_offset = except_vec_vi_lui - vec_start;
-		const int ori_offset = except_vec_vi_ori - vec_start;
+		const int imm_offset = 0;
+#endif
+#if defined(CONFIG_64BIT) && !defined(KBUILD_64BIT_SYM32)
+		const int highest_offset = except_vec_vi_highest - vec_start + imm_offset;
+		const int higher_offset = except_vec_vi_higher - vec_start + imm_offset;
 #endif
+		const int hi_offset = except_vec_vi_hi - vec_start + imm_offset;
+		const int lo_offset = except_vec_vi_lo - vec_start + imm_offset;
+
 		const int handler_len = except_vec_vi_end - vec_start;
 
 		if (handler_len > VECTORSPACING) {
@@ -2119,10 +2127,16 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
 #else
 				handler_len);
 #endif
-		h = (u16 *)(b + lui_offset);
-		*h = (handler >> 16) & 0xffff;
-		h = (u16 *)(b + ori_offset);
-		*h = (handler & 0xffff);
+#if defined(CONFIG_64BIT) && !defined(KBUILD_64BIT_SYM32)
+		h = (u16 *)(b + highest_offset);
+		*h = uasm_rel_highest(handler);
+		h = (u16 *)(b + higher_offset);
+		*h = uasm_rel_higher(handler);
+#endif
+		h = (u16 *)(b + hi_offset);
+		*h = uasm_rel_hi(handler);
+		h = (u16 *)(b + lo_offset);
+		*h = uasm_rel_lo(handler);
 		local_flush_icache_range((unsigned long)b,
 					 (unsigned long)(b+handler_len));
 	}
-- 
2.34.1

