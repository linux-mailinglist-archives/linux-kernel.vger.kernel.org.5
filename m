Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D478B77E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjH1Sow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbjH1SoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:17 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2D9BF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:15 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c4de3b9072so2547211fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248254; x=1693853054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUxuuJmutnBiUjopAvOBtd5ZQokj0PqF2sT+wHUEVQ=;
        b=n8BPBVv5GFsq8sQpMbo/Bj2u/NuSLdg3NFz28E9l/HalTwX5Txv6n51n9G2Ilxht22
         5jmopUurPiC8hxynJCovibqENympoNVbWmAvYH26FlUCIxImuACw8tMm9xEnbxfXx8UB
         5bWP+/Iyr5Z39cjfJZV3ibvqPD998zHpw4lz1ALgUax2EHl2tL24tCh+sE7s+Ja34Q9q
         lMYNw68BkinRRYlPi3k7TaIqrfeZTC6EuTmG78NG2mirRe7q/yJsrGhbct1T39cQXsBg
         xwz7ByYR84jGW72ZGGaW4h66df/wWEfa0XJcosBqOXI34JM6f9DltpSj68uMa4uBjrNf
         H7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248254; x=1693853054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKUxuuJmutnBiUjopAvOBtd5ZQokj0PqF2sT+wHUEVQ=;
        b=gUxukYd6W7WjOTTSsuhVpqwMp7eKQh0I8GkINLCq+9hjZ+XNbpnOM+WYTP3CAIKmJw
         Zxryq6QXSy41jATRlHHTRAGGnWdYkm0MaWxxPYcLkc0Gm51gUvv+XV9KqfdAFlYXThLG
         WBrZrhZefiE3xZjul8y/2gvQuxZjYVrhJNloOsa6MRLT2LbGbxyIEEaNt8+VWoeLuC//
         15fvCosCdaO6DBZr5aDvYF5yQpgdq3P7/teKY3Ak+dIP3tyZ+j1HdmBRA3DN3tgBle7I
         tkSODGQGpvgWGpKlr8xFA9/LflDlBc4tU2Nols2vcga/ie3yZzx1vXVg6RFBZ+N8l9fZ
         nUAw==
X-Gm-Message-State: AOJu0YxT/L2oMWyaBjxXOcEpAEj/hvrwAFNIBdNVK2oxO0ODuObLS/Bz
        ijIRuc1PdT1UksNDKtNJyvRbM1Hd+Nk=
X-Google-Smtp-Source: AGHT+IGe8SWO3Za8IRW6WMbijnpg3KbeBjZbb9ElTGnH8ThWF8oneko5wyqajSAeePfhNlSDRIs3yQ==
X-Received: by 2002:a05:6870:7026:b0:1bf:74cc:c815 with SMTP id u38-20020a056870702600b001bf74ccc815mr12874668oae.19.1693248254332;
        Mon, 28 Aug 2023 11:44:14 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id gy18-20020a056870289200b001c4b473581fsm4562420oab.12.2023.08.28.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:14 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 12/12] bitmap: don't count bits from the beginning in bitmap_remap()
Date:   Mon, 28 Aug 2023 11:43:52 -0700
Message-Id: <20230828184353.5145-13-yury.norov@gmail.com>
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

In the remapping part, we count bits in 'old' and 'new' masks from the
beginning for every bit. Complexity of this approach is O(N^2). We can
do it better in O(N), if switch bitmap_remap() to using _from versions
of bitmap_weight() and find_nth_bit().

On kvm/x86_64 it works 9x faster than the current version for the 1000-bit
bitmap in lib/test_bitmap. Because popular distros like Ubuntu has 1024-bit
nodemasks, ~10x performance improvement is expected where bitmap_remap()
is used.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1fca60d54cb4..8bca6bcf2bc5 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -996,7 +996,8 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		unsigned int nbits)
 {
-	unsigned int oldbit, w = 0, n;
+	unsigned int newbit, oldbit, w = 0, n;
+	unsigned int _oldbit, _newbit;
 
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
@@ -1005,8 +1006,17 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 	bitmap_andnot(dst, src, old, nbits);
 
 	/* Remapping part */
+	_oldbit = _newbit = 0;
 	for_each_and_bit(oldbit, src, old, nbits) {
-		n = bitmap_weight(old, oldbit);
+		n = bitmap_weight_from(old, oldbit, _oldbit);
+		newbit = find_nth_bit_from(new, nbits, _newbit, n);
+		if (newbit < nbits)
+			goto set_bit;
+
+		/*
+		 * If we're out of bits in 'new' map, wrap
+		 * around and start from the beginning.
+		 */
 		if (w == 0) { /* if not initialized */
 			w = bitmap_weight(new, nbits);
 			if (w == 0) { /* if empty */
@@ -1014,7 +1024,13 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 				return;
 			}
 		}
-		__set_bit(find_nth_bit(new, nbits, n % w), dst);
+
+		n -= bitmap_weight_from(new, nbits, _newbit);
+		newbit = find_nth_bit(new, nbits, n % w);
+set_bit:
+		__set_bit(newbit, dst);
+		_oldbit = oldbit;
+		_newbit = newbit;
 	}
 }
 EXPORT_SYMBOL(__bitmap_remap);
-- 
2.39.2

