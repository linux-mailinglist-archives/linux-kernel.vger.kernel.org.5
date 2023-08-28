Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9737778B774
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjH1So2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjH1SoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:07 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64612B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bd0c953fd9so2395783a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248244; x=1693853044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/Y8i6gIDTHVwj3Z5niTajyyTF4DBIPiiGSuA7TZ+wQ=;
        b=K8G2e9KfnaqVbMn1Jelcp12cieSMO7xTNCXcGKOzt8PCmMbD4md099MNbUdW8DbRVU
         rmqAW16qU126oFQ9fXVv0EWDAmvyu2bvChMWuZsfPfFZ3z+QXgTw9fNOfnY9JwJYu95E
         cjQKG3/jF9UASdS1h0dgzVxx4vvkf0AUEanV73ArdyjIs+8e0Le1isANXDtQMWOfuB4i
         fcWIh7u6FNWRckMZ28sknrPgaJKh1mK9pSdV8HdsRSrcFdWB8NZBCb1YX/5RQKAiNlQv
         EwpjLW0yCPSdNZutQOBvDLRMpIL1OC8YIRkAyzjLboD7pyqM7qFT+N8GP0uQ71t8KIHO
         TwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248244; x=1693853044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/Y8i6gIDTHVwj3Z5niTajyyTF4DBIPiiGSuA7TZ+wQ=;
        b=fxdeyZfM014lh2BadbIzM+GO9hIOloj7Im1DIUgLYeVJH7XU98DqreZo31Q7GlxyRT
         Sx5odsTKpYn/xQmd+4ALfP28Y3OFwlpS/PUoioc7+psimrr9UMyoqyRopb9vUG1mhm25
         01uoKMLbTOeeGtnxKthhzyrUkliSdsDYnIU8FVal6Ga5WX6MSlzTAhB1FclSGZxig0RM
         4Ankok1NJBzLOhQ10QZ8w/HmHjaDxidpwl8smSxYhlocH+oLbdZXYO4miS0iyVE1nqEp
         Flz2ASkWZDf1Zbow9/NWCfeDuOQYPpwpWvejxjRSjXjrcgc5zxGAGcvvk4ISYaczF7/x
         rQpQ==
X-Gm-Message-State: AOJu0Yx5UGUwUROZmvxUiHMf4MAxP1FW79YKY4Hceuv2vHeoq1RelTi6
        Way70POfmLyDIM1deJdDXl4pjhBDzGw=
X-Google-Smtp-Source: AGHT+IHz3qRzaYR2hOVsuV3+n7ed6OCxVXp9nXdCDYDHjFXkPaxQkg5VfbWLNbMHRjB/aX4C6fF9sw==
X-Received: by 2002:a9d:5e8b:0:b0:6b9:4516:7d1e with SMTP id f11-20020a9d5e8b000000b006b945167d1emr13536044otl.30.1693248244227;
        Mon, 28 Aug 2023 11:44:04 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id n15-20020a9d4d0f000000b006b94a14b52asm3729568otf.9.2023.08.28.11.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:03 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 05/12] bitmap: update comment for bitmap_{bit,}remap()
Date:   Mon, 28 Aug 2023 11:43:45 -0700
Message-Id: <20230828184353.5145-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an illustrated example for bitmap_remap(), and drop duplicated wording
in bitmap_bitremap(). This exact example is tested in lib/test_bitmap.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 54 +++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 65c64911c92f..30c375bffe8b 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1002,10 +1002,30 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
  *
  * Let @old and @new define a mapping of bit positions, such that
  * whatever position is held by the n-th set bit in @old is mapped
- * to the n-th set bit in @new.  In the more general case, allowing
- * for the possibility that the weight 'w' of @new is less than the
- * weight of @old, map the position of the n-th set bit in @old to
- * the position of the m-th set bit in @new, where m == n % w.
+ * to the n-th set bit in @new. For example lets say that @old has
+ * bits 2 through 4 set, and @new has bits 3 through 5 set:
+ *
+ *	old: 00011100
+ *	     |||///||
+ *	new: 00111000
+ *
+ * This defines the mapping of bit position 2 to 3, 3 to 4 and 4 to 5,
+ * and of all other bit positions unchanged. So if say @src comes into
+ * this routine with bits 1, 3 and 5 set, then @dst should leave with
+ * bits 1, 4 and 5 set:
+ *
+ *	src: 00101010
+ *	       v v v
+ *	old: 00011100
+ *	     |||///||
+ *	new: 00111000
+ *	       vv  v
+ *	dst: 00110010
+ *
+ * In the more general case, allowing for the possibility that the weight
+ * 'w' of @new is less than the weight of @old, map the position of the
+ * n-th set bit in @old to the position of the m-th set bit in @new, where
+ * m == n % w.
  *
  * If either of the @old and @new bitmaps are empty, or if @src and
  * @dst point to the same location, then this routine copies @src
@@ -1016,13 +1036,6 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
  *
  * Apply the above specified mapping to @src, placing the result in
  * @dst, clearing any bits previously set in @dst.
- *
- * For example, lets say that @old has bits 4 through 7 set, and
- * @new has bits 12 through 15 set.  This defines the mapping of bit
- * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
- * bit positions unchanged.  So if say @src comes into this routine
- * with bits 1, 5 and 7 set, then @dst should leave with bits 1,
- * 13 and 15 set.
  */
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
@@ -1053,24 +1066,9 @@ EXPORT_SYMBOL(bitmap_remap);
  *	@new: defines range of map
  *	@bits: number of bits in each of these bitmaps
  *
- * Let @old and @new define a mapping of bit positions, such that
- * whatever position is held by the n-th set bit in @old is mapped
- * to the n-th set bit in @new.  In the more general case, allowing
- * for the possibility that the weight 'w' of @new is less than the
- * weight of @old, map the position of the n-th set bit in @old to
- * the position of the m-th set bit in @new, where m == n % w.
- *
- * The positions of unset bits in @old are mapped to themselves
- * (the identity map).
- *
- * Apply the above specified mapping to bit position @oldbit, returning
- * the new bit position.
+ * A special case of bitmap_remap(), when a single bit remapping is needed.
  *
- * For example, lets say that @old has bits 4 through 7 set, and
- * @new has bits 12 through 15 set.  This defines the mapping of bit
- * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
- * bit positions unchanged.  So if say @oldbit is 5, then this routine
- * returns 13.
+ * Returns: position of remapped bit
  */
 int bitmap_bitremap(int oldbit, const unsigned long *old,
 				const unsigned long *new, int bits)
-- 
2.39.2

