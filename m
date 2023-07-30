Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190FF768469
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjG3IR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3IR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:17:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA37E45;
        Sun, 30 Jul 2023 01:17:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-686f25d045cso2291315b3a.0;
        Sun, 30 Jul 2023 01:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690705044; x=1691309844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVTFeC1njEcnyTVKiMbZ60a86a9w2VC1BHkzlkf5gjo=;
        b=HMCIOPvHnssLR6F4I7f40pNoiKpq2e36YsJlgIGfTAsEgxo6C5+1PzBh7Cq9y+XJD6
         yoxymwOaIVSzVm3YP131hIvtFXtP34BBiGfFq0h9VevFg+Ygtiw1HIbZs0Ah/z2XcqV/
         q1pIfqwpcG/n8Hfj8kVXjuLGBl5FMPoSGQeY6qYK1ESdS/VmTi+uPMQvJ5/59+4NYz9a
         om+nUNvbdGd+QBaXVcyTy9f1oB0RE9rBn1W3Cqk62eYQpZAU83ucJniRq8iV44JjGEvx
         TsYCZlQWUBCTz0IgBPnyyCy0q3JolWnYzqYcRA+kg0HcAMRNog5/OkPaIFefz9BPv7Yc
         QvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705044; x=1691309844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVTFeC1njEcnyTVKiMbZ60a86a9w2VC1BHkzlkf5gjo=;
        b=AX6xuEmKrtzyRrZ/AtU5C4t8EfgI/ZnXqFyhzxGGPjwkHv22eBPF3ha4tiX+Bf/94z
         37MYHFOjNOmkqYIGiQK8mgYcPpHH5nfiCgn4zVv2IGdoUEj0ZXxFcHb/MT8ShzBNqKYQ
         HxVqCY6bxSKzm5TIpFXMkYzmv+/UfbzCOEAFmzRqIO5YUs7xg6u0X3eEc+WWCp/aYheA
         lJdbguONTiQtfOwJ4LFBmGMHAnPeS0SFDY7AaMZ1YK4Vsc0VOAeqvjR13poLWpHbxBwk
         4rKVAkY9PoZzuR+wUceT29r9LUic240Bb4prGH19rk1eTv71/i4SUk+YY9ybsju+A5P0
         DqJQ==
X-Gm-Message-State: ABy/qLaThOsIWb8+a9SZwzgHNDzYUUF2rnCEpd8q6PTia/4uEL1Xng4T
        GLyEUFfNrRBD0+OYcke72Ks=
X-Google-Smtp-Source: APBJJlEMYTfIJeXisFEx+NqaYFPOGVHM/Dcm7lZiaoSTIMUA0SpIPe5w3NqQE1wosVJZcKYveWjOWw==
X-Received: by 2002:a05:6a20:ddaf:b0:131:a3b1:5674 with SMTP id kw47-20020a056a20ddaf00b00131a3b15674mr6341184pzb.22.1690705044264;
        Sun, 30 Jul 2023 01:17:24 -0700 (PDT)
Received: from localhost ([2409:8a3c:3642:f381:ef03:9bcc:76f2:538c])
        by smtp.gmail.com with ESMTPSA id i22-20020aa787d6000000b00682669dc19bsm5629437pfo.201.2023.07.30.01.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 01:17:23 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, torvalds@linux-foundation.org,
        unixbhaskar@gmail.com
Cc:     mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] lib/bch.c: using bitrev instead of internal logic
Date:   Sun, 30 Jul 2023 16:17:17 +0800
Message-ID: <20230730081717.1498217-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace internal logic with separate bitrev library.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 lib/Kconfig |  1 +
 lib/bch.c   | 38 ++------------------------------------
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c516..c686f4adc124 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -415,6 +415,7 @@ config REED_SOLOMON_DEC16
 #
 config BCH
 	tristate
+	select BITREVERSE
 
 config BCH_CONST_PARAMS
 	bool
diff --git a/lib/bch.c b/lib/bch.c
index c8095f30f254..5f71fd76eca8 100644
--- a/lib/bch.c
+++ b/lib/bch.c
@@ -71,6 +71,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/bitrev.h>
 #include <asm/byteorder.h>
 #include <linux/bch.h>
 
@@ -114,47 +115,12 @@ struct gf_poly_deg1 {
 	unsigned int   c[2];
 };
 
-static u8 swap_bits_table[] = {
-	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
-	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
-	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
-	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
-	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
-	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
-	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
-	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
-	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
-	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
-	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
-	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
-	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
-	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
-	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
-	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
-	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
-	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
-	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
-	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
-	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
-	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
-	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
-	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
-	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
-	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
-	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
-	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
-	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
-	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
-	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
-	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
-};
-
 static u8 swap_bits(struct bch_control *bch, u8 in)
 {
 	if (!bch->swap_bits)
 		return in;
 
-	return swap_bits_table[in];
+	return bitrev8(in);
 }
 
 /*
-- 
2.41.0

