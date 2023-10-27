Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93567DA330
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbjJ0WLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbjJ0WLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:22 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4651B9;
        Fri, 27 Oct 2023 15:11:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0D05E3200930;
        Fri, 27 Oct 2023 18:11:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 18:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444678; x=
        1698531078; bh=JcLDvuqq+aysWCP3Ln7wvhxjBzjiN4xGl+qlurq8eWo=; b=I
        HoYk5b3fVp4rsN5Fq+3FfYElLjRacfsGjWAOBn+q/4r9URgWVxABRQAHygc7PKm8
        BBz11S7wsWLaZ79RrRf9Jk5AGQ2sShaMD2oMGfSzGE5BpvLdKZrnpWiig3GFjMXn
        CNRsksMOv1eA/AHxozvixxATwtzNKsezZl7q2Zw2Ra3Xo7USVEmmSYU6YRhV5klh
        gyRG9TMjnKukgbuHxp6MfRlPXS5OwNwaIhMgu31Of9ljT66o9SpiBxiFtWQT78vD
        T7zpQ9ICItVdoDCovppnkDKSBo0ocp25NemDmjl+kfALb4x1yx8ScUuGjYlw+xox
        WYWgzVTvCu5Ue6V7cvcTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444678; x=
        1698531078; bh=JcLDvuqq+aysWCP3Ln7wvhxjBzjiN4xGl+qlurq8eWo=; b=n
        929qJ+dflF17rVICz5mADaJbZqcxuvXiB0RCM2k2fdJAcIAYlUXgO/D6RfVpZiX1
        Q6+RtWMBnkXXc/ykAmUy0MF/GOD4yhKru5dlRRJRdOMt1FEL1ROcTHublV1ym+fy
        evMECJZ/92eLmr819kD1QJZLGMOHiOyuZDbSHfBVNQ9YBpNhsTKrpozsk6xOOsHZ
        sq+Bt8deQUtJ4N7NVzy4++ehVwoZO7aRS0VkgZHuoo/twh3F2LDjDesI3M0hxRiE
        LPVJCNsru+vGIlB+n29aChgelrg5pHSWkny5cXJE5F7cJOuLnspjx7fASjsO46dV
        Dv8jdUdUJ6T6+FmTzVdFg==
X-ME-Sender: <xms:hjU8ZfX1wAcfzAM5BrJij1f1-clfrsxiIowA8K_zYWq7abjBoI_4Tg>
    <xme:hjU8ZXnz9CUYe5vncjW6tVhDbV11ha7mkjUSWN9lRev9PH36BEu--YmIikq5T3O3u
    hHGJc1DWGEs1WbeafU>
X-ME-Received: <xmr:hjU8Zba49pQ2EHyTuE5RnuaKBA-5Q2G9d0WhKKtx5zaaEqW7-kRr9ZG35bOmxnwZ3tdEEKK1CFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeiveekveegleffhfeufe
    egteekheffffdutddvleeigeehvdehgeekvdduledthfenucffohhmrghinhepghgvnhgv
    gidrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:hjU8ZaWVq3elbVQgOnqmWMUQLQ-833NeADM36gnINraD0GYHg8JZDw>
    <xmx:hjU8ZZm54GJMT8rivhYO1ldTSw3VupL-5T-h7eibsmiZfI0LFn4RkQ>
    <xmx:hjU8ZXcYYUiX-qWVb-beprrNa8UmWEcFVEZye_O8oHGAUudTYcW75g>
    <xmx:hjU8ZSCqHwltXOHE62-ww2sqYdG7sPjbKO6gH3Ko9WLpT4kBRFPj9g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:17 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 03/10] MIPS: genex: Fix except_vec_vi for kernel in XKPHYS
Date:   Fri, 27 Oct 2023 23:10:59 +0100
Message-Id: <20231027221106.405666-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

