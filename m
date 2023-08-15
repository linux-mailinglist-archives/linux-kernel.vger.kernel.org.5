Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D2377D6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjHOXhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjHOXg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9CD13E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:56 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdf98a6086so10087105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142615; x=1692747415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsmgxI2dDLH2ymR4KmGzcaJe1p1eps4K+t7hMi45DJo=;
        b=MsphCzpuYX4idGa4Gi885hd0RX7AwhMSkXR2PLk4+bJxfiMg9pdrme+8Zw9XFWv6uK
         vPcUdkTLAjEPSHYYVOzznjhMf+bFaad2WFL9JG+tCzzUJBgJkxgNpXytYGxZPKA2Vsij
         CRyeDZtCGWy3Iko+bRdJ9shEtXnhTpXZf5rGXaK5BPqfNxFlTBI6/gndcQPO7vdbbdca
         NbMWHurgoBToBk3r4ZmZnEz8iFCinEPDhBrH491pbfSYSUa0ihwTWm5szLp0N3+XvNFQ
         bxm2hmbJexZZC2QGRcfiYtmWkC4Z10jrE8n2Aiogqulj2NU+3EC2ck7cJeq9V0htFQDd
         S7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142615; x=1692747415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsmgxI2dDLH2ymR4KmGzcaJe1p1eps4K+t7hMi45DJo=;
        b=bad6WuOwQQuUyr7BZ2Teo3Kp1fahWSPbkO+YDIsy6itXrX0pDq3X6/dCGKN6dDmjRA
         Af6Y0usoC0krW79XHK72cU0SLVG8WgpM7HkTbFezNbGJAfg0SMB6BOoFN85BkryLnaQQ
         pSjnFoi5uVL+bMKDiVppRBRSMmSji1s/OWhJZ42nxcTYbPnsGJOSk4to0sRcgSIp9w48
         4RiOIZR207cgi6j/TFPTnejLmQQ+Ipzbkcjux8aTNh4QG5Dja+F4DygMBU+3PbE6v45m
         vb6g4bV5kSlGLwWbOIxFtLt9cIonPt29nN7GCrgC+YJ+cZ7tXj5Sd99OYOsDLZ+PoJRc
         PTZA==
X-Gm-Message-State: AOJu0Yy9IB8TWH0hjLjjGUW8J/JS3FydIe4m1eV+OTEqowOQh+eFjs0b
        d9bOqxoQg9NUjHB9FCwx65Z2rxQwu7M=
X-Google-Smtp-Source: AGHT+IFLlpS4ukwyWWebufIvWo7oJDgo1x/KiX17zl8SGMHl2wrSmmRAJC5D202okZpWXFkemugIMw==
X-Received: by 2002:a17:902:d2cb:b0:1bd:ae9e:62ea with SMTP id n11-20020a170902d2cb00b001bdae9e62eamr492121plc.8.1692142615155;
        Tue, 15 Aug 2023 16:36:55 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id m11-20020a170902768b00b001bb750189desm11607799pll.255.2023.08.15.16.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:54 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 7/8] bitmap: drop _reg_op() function
Date:   Tue, 15 Aug 2023 16:36:27 -0700
Message-Id: <20230815233628.45016-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all _reg_op() users are switched to alternative functions,
_reg_op() machinery is not needed anymore.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index c29140e27d20..ffbd400605ac 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1224,82 +1224,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
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
- * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- *	   0 in all other cases and reg_ops.
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

