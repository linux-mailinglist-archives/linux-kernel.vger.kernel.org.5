Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F117643A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjG0CCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjG0CCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9052D5B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8b2b60731so2690435ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423350; x=1691028150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wwm/gViyZb0bI4gStUbGLvXclrv40DnexcC/4FNgNg=;
        b=I4QhlzEZJlABhRD76RVW081j9KS4wZlXMNp1tfW9qOESs4AkH8mwhul7Cw2pccxsEF
         OsPfe+gWS86FA9QMRI/IQsmTQpF5+OVlJdIwaPW5MrJmAj2RuDmylTX5+gDWq8qIsL7G
         27jO0Cj5P8VJwFXhC844c1eToOC9Oc0sRQDtxW6NR4eeFvKaZRIVMMwwDC9r4P3QVB1H
         eE/9V7VKNlbDUtkIidiLr6izLK+KGMBaWdbbqgYmCJ71Ds8Q+r3WW++hoWCJy+HZLlCc
         T4XJF3nAdZ6xKM8WtB8U0VcKyavpP0ivb9bvs/a6pTs8mO33vOAkrpaZ82/c1jnukDRi
         o3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423350; x=1691028150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wwm/gViyZb0bI4gStUbGLvXclrv40DnexcC/4FNgNg=;
        b=OwbA+SvffwXS6GS0BPPyM4KuwksUea7mXWNFjW2QDua12qkHC5wN6i8Up/bvzu5jtD
         anBSYZG9vRtfm/vwtqjtq6ms0ao8YnSQoFZCrsIRL9drA/GqFsXm2JlTnmny2IaGYr/Q
         DrZb7V7NYfglq+opigtSJZQKCn0G+1PuYGxqDXEm3zZWOkioORNGpAbavfNGRXm8VCNR
         lxlV5HfEaY8JFgDhp9Qn3ABTBencauGkgSXKS+QuRd3uQ8YGGiF4Wz116ZgWsDHFsLmI
         Ivh52dM1vpVBgt5MIDVBvOiLFVuBHA8B5M/E9law8T9LTwJxlNZnjtwPiDuZCR2Q4Wlo
         3zEg==
X-Gm-Message-State: ABy/qLaAKd1R/QhDH3oC3EYlImO2ZuAuBZbvu/Ou21bRz82LMBq9Pa2N
        3hUtvK8RnTk23NiA3yEcPTjtYwPIJO7zEg==
X-Google-Smtp-Source: APBJJlGrLuH2xSAYirx4M4reqqRMO2+z6djClfgPE1ZE1DGAILZmcKksxVxU+/dlGPo0nhJryMhe2g==
X-Received: by 2002:a17:902:d4c1:b0:1b8:1b79:a76d with SMTP id o1-20020a170902d4c100b001b81b79a76dmr3185315plg.44.1690423350179;
        Wed, 26 Jul 2023 19:02:30 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id jf4-20020a170903268400b001b53953f306sm221850plb.178.2023.07.26.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:29 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/6] bitmap: drop _reg_op() function
Date:   Wed, 26 Jul 2023 19:02:06 -0700
Message-Id: <20230727020207.36314-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727020207.36314-1-yury.norov@gmail.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all _reg_op() users are switched alternative functions, _reg_op()
machinery is not needed anymore.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index e0c3bba79181..7cfe0b442c73 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,82 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 }
 #endif /* CONFIG_NUMA */
 
-/*
- * Common code for bitmap_*_region() routines.
- *	bitmap: array of unsigned longs corresponding to the bitmap
- *	pos: the beginning of the region
- *	order: region size (log base 2 of number of bits)
- *	reg_op: operation(s) to perform on that region of bitmap
- *
- * Can set, verify and/or release a region of bits in a bitmap,
- * depending on which combination of REG_OP_* flag bits is set.
- *
- * A region of a bitmap is a sequence of bits in the bitmap, of
- * some size '1 << order' (a power of two), aligned to that same
- * '1 << order' power of two.
- *
- * Returns 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- * Returns 0 in all other cases and reg_ops.
- */
-
-enum {
-	REG_OP_ISFREE,		/* true if region is all zero bits */
-	REG_OP_ALLOC,		/* set all bits in region */
-	REG_OP_RELEASE,		/* clear all bits in region */
-};
-
-static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_op)
-{
-	int nbits_reg;		/* number of bits in region */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nlongs_reg;		/* num longs spanned by region in bitmap */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask for one long of region */
-	int i;			/* scans bitmap by longs */
-	int ret = 0;		/* return value */
-
-	/*
-	 * Either nlongs_reg == 1 (for small orders that fit in one long)
-	 * or (offset == 0 && mask == ~0UL) (for larger multiword orders.)
-	 */
-	nbits_reg = 1 << order;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-	nlongs_reg = BITS_TO_LONGS(nbits_reg);
-	nbitsinlong = min(nbits_reg,  BITS_PER_LONG);
-
-	/*
-	 * Can't do "mask = (1UL << nbitsinlong) - 1", as that
-	 * overflows if nbitsinlong == BITS_PER_LONG.
-	 */
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-	mask <<= offset;
-
-	switch (reg_op) {
-	case REG_OP_ISFREE:
-		for (i = 0; i < nlongs_reg; i++) {
-			if (bitmap[index + i] & mask)
-				goto done;
-		}
-		ret = 1;	/* all bits in region free (zero) */
-		break;
-
-	case REG_OP_ALLOC:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] |= mask;
-		break;
-
-	case REG_OP_RELEASE:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] &= ~mask;
-		break;
-	}
-done:
-	return ret;
-}
-
 /**
  * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: array of unsigned longs corresponding to the bitmap
-- 
2.39.2

