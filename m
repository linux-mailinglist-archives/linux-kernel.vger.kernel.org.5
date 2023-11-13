Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3BB7E9C75
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjKMMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKMMza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:55:30 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB8D7E;
        Mon, 13 Nov 2023 04:55:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9becde9ea7bso1118219666b.0;
        Mon, 13 Nov 2023 04:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699880125; x=1700484925; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwl76K5ocpl2kjJi2q4viEo/K6bLb+9wkUvBOg8UQZQ=;
        b=kAWMVza+etWHpxx7xiD5wupQtH3tunLXymVycD8A5Ye76E/IJy7v0hva+yZvCDsQhv
         wtLWc42Zx2jt1KOs8C++YxOVO36xc17rpu7wZuPB53WEMOdhNWcIAd4ecU1hznJ62o/V
         yQR7o9I0Kf+4kRKc1eD10SI+u0TNusF8jJzF1Uk36f7Bv/+X1YOLK1gmXRibaehLjK2L
         a+E0Q0a7lwEqE4Q8pDHq4ChV41zZn5dYfxcjZPOY/EtOXYcFxw5gG5jfJxUWCXiyzmf+
         //p2MpkLsgAnIDUehl9jAFTLm1McO8lCsySMFFCaGD0QNilgeKctCurk1dlPene5dU5z
         9euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699880125; x=1700484925;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwl76K5ocpl2kjJi2q4viEo/K6bLb+9wkUvBOg8UQZQ=;
        b=BLk41a2PUoiASsuqCD3W2p7Aw8alld6p4Zvezh957AHWcUuqiU5N7zOrJxGGZn6tFj
         yfquTK5/+LaMu278S7UOqMsCuR1FxP2PUrX4eT3mac5qqtH2BHAamuJsvRLpwtXIhTGP
         jlmNx2wscqB8hTOJXMKxDN5elO9ZN2zUail3kpRoh0N/Sv6cyu+/nu1wNKZE2WVYKL+t
         lRHjAIAvx7uPItOH/durHiBkwpAAWI4WMEB/UW1FdVhS9Fes1baUj0Ak1wItJaIPRX9H
         YZ8nn3MkOeE8dbyoA/SS2eqZExiiZ8v2nAdrTyJKt6SlMzE0q/HrtF8sbQNl7C/SPPrr
         1maA==
X-Gm-Message-State: AOJu0YyhWP3XlPNncL7Ow/96Cb8ERzGvtTuaS/WqXbAw7SdaYIjUoMaq
        q4JsnIIp9xfApykdjH6pB8Y=
X-Google-Smtp-Source: AGHT+IEm6foKg/8kyjvtKRtucvdqm1moHWBkrq/4hE+WHtpo5AepiI/6UQK+yob7u6EyCvqfs7Gdew==
X-Received: by 2002:a17:906:a40f:b0:9e4:dc3f:ddae with SMTP id l15-20020a170906a40f00b009e4dc3fddaemr6358562ejz.33.1699880124963;
        Mon, 13 Nov 2023 04:55:24 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d4a9:adca:9d2f:e54c])
        by smtp.gmail.com with ESMTPSA id h8-20020a170906260800b009dd98089a48sm4002220ejc.43.2023.11.13.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 04:55:24 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] lib/xz: remove IA-64 support from library
Date:   Mon, 13 Nov 2023 13:55:22 +0100
Message-Id: <20231113125522.8943-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Among many removals, commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture") removes the config XZ_DEC_IA64, but does not remove the code
for IA64 architecture support in lib/xz/.

Remove the definitions XZ_DEC_IA64, bcj_ia64(), BCJ_IA64 and all its
references.

Note that in the ifdef expression for architectures to enable the generic
support for BCJ encoders, XZ_DEC_ARM was listed twice, so drop this
duplicated conditional while removing XZ_DEC_IA64 from the condition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/xz/xz_dec_bcj.c | 94 ---------------------------------------------
 lib/xz/xz_private.h |  4 --
 2 files changed, 98 deletions(-)

diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index ef449e97d1a1..3c8e7135b0e4 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -21,7 +21,6 @@ struct xz_dec_bcj {
 	enum {
 		BCJ_X86 = 4,        /* x86 or x86-64 */
 		BCJ_POWERPC = 5,    /* Big endian only */
-		BCJ_IA64 = 6,       /* Big or little endian */
 		BCJ_ARM = 7,        /* Little endian only */
 		BCJ_ARMTHUMB = 8,   /* Little endian only */
 		BCJ_SPARC = 9       /* Big or little endian */
@@ -66,7 +65,6 @@ struct xz_dec_bcj {
 		 * Type         Alignment   Look-ahead
 		 * x86              1           4
 		 * PowerPC          4           0
-		 * IA-64           16           0
 		 * ARM              4           0
 		 * ARM-Thumb        2           2
 		 * SPARC            4           0
@@ -177,90 +175,6 @@ static size_t bcj_powerpc(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 }
 #endif
 
-#ifdef XZ_DEC_IA64
-static size_t bcj_ia64(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
-{
-	static const uint8_t branch_table[32] = {
-		0, 0, 0, 0, 0, 0, 0, 0,
-		0, 0, 0, 0, 0, 0, 0, 0,
-		4, 4, 6, 6, 0, 0, 7, 7,
-		4, 4, 0, 0, 4, 4, 0, 0
-	};
-
-	/*
-	 * The local variables take a little bit stack space, but it's less
-	 * than what LZMA2 decoder takes, so it doesn't make sense to reduce
-	 * stack usage here without doing that for the LZMA2 decoder too.
-	 */
-
-	/* Loop counters */
-	size_t i;
-	size_t j;
-
-	/* Instruction slot (0, 1, or 2) in the 128-bit instruction word */
-	uint32_t slot;
-
-	/* Bitwise offset of the instruction indicated by slot */
-	uint32_t bit_pos;
-
-	/* bit_pos split into byte and bit parts */
-	uint32_t byte_pos;
-	uint32_t bit_res;
-
-	/* Address part of an instruction */
-	uint32_t addr;
-
-	/* Mask used to detect which instructions to convert */
-	uint32_t mask;
-
-	/* 41-bit instruction stored somewhere in the lowest 48 bits */
-	uint64_t instr;
-
-	/* Instruction normalized with bit_res for easier manipulation */
-	uint64_t norm;
-
-	for (i = 0; i + 16 <= size; i += 16) {
-		mask = branch_table[buf[i] & 0x1F];
-		for (slot = 0, bit_pos = 5; slot < 3; ++slot, bit_pos += 41) {
-			if (((mask >> slot) & 1) == 0)
-				continue;
-
-			byte_pos = bit_pos >> 3;
-			bit_res = bit_pos & 7;
-			instr = 0;
-			for (j = 0; j < 6; ++j)
-				instr |= (uint64_t)(buf[i + j + byte_pos])
-						<< (8 * j);
-
-			norm = instr >> bit_res;
-
-			if (((norm >> 37) & 0x0F) == 0x05
-					&& ((norm >> 9) & 0x07) == 0) {
-				addr = (norm >> 13) & 0x0FFFFF;
-				addr |= ((uint32_t)(norm >> 36) & 1) << 20;
-				addr <<= 4;
-				addr -= s->pos + (uint32_t)i;
-				addr >>= 4;
-
-				norm &= ~((uint64_t)0x8FFFFF << 13);
-				norm |= (uint64_t)(addr & 0x0FFFFF) << 13;
-				norm |= (uint64_t)(addr & 0x100000)
-						<< (36 - 20);
-
-				instr &= (1 << bit_res) - 1;
-				instr |= norm << bit_res;
-
-				for (j = 0; j < 6; j++)
-					buf[i + j + byte_pos]
-						= (uint8_t)(instr >> (8 * j));
-			}
-		}
-	}
-
-	return i;
-}
-#endif
-
 #ifdef XZ_DEC_ARM
 static size_t bcj_arm(struct xz_dec_bcj *s, uint8_t *buf, size_t size)
 {
@@ -361,11 +275,6 @@ static void bcj_apply(struct xz_dec_bcj *s,
 		filtered = bcj_powerpc(s, buf, size);
 		break;
 #endif
-#ifdef XZ_DEC_IA64
-	case BCJ_IA64:
-		filtered = bcj_ia64(s, buf, size);
-		break;
-#endif
 #ifdef XZ_DEC_ARM
 	case BCJ_ARM:
 		filtered = bcj_arm(s, buf, size);
@@ -542,9 +451,6 @@ XZ_EXTERN enum xz_ret xz_dec_bcj_reset(struct xz_dec_bcj *s, uint8_t id)
 #ifdef XZ_DEC_POWERPC
 	case BCJ_POWERPC:
 #endif
-#ifdef XZ_DEC_IA64
-	case BCJ_IA64:
-#endif
 #ifdef XZ_DEC_ARM
 	case BCJ_ARM:
 #endif
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index bf1e94ec7873..dd22671c4941 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -25,9 +25,6 @@
 #		ifdef CONFIG_XZ_DEC_POWERPC
 #			define XZ_DEC_POWERPC
 #		endif
-#		ifdef CONFIG_XZ_DEC_IA64
-#			define XZ_DEC_IA64
-#		endif
 #		ifdef CONFIG_XZ_DEC_ARM
 #			define XZ_DEC_ARM
 #		endif
@@ -98,7 +95,6 @@
  */
 #ifndef XZ_DEC_BCJ
 #	if defined(XZ_DEC_X86) || defined(XZ_DEC_POWERPC) \
-			|| defined(XZ_DEC_IA64) || defined(XZ_DEC_ARM) \
 			|| defined(XZ_DEC_ARM) || defined(XZ_DEC_ARMTHUMB) \
 			|| defined(XZ_DEC_SPARC)
 #		define XZ_DEC_BCJ
-- 
2.17.1

