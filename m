Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3DA7F228F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjKUAwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjKUAwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:52:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C3E19A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:52:03 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cf669b711fso8239815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527923; x=1701132723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOpdM/jsZ8uGT6Q420XJikJy5NZAADH40odTXJj1nGY=;
        b=L0ZIl0dJ39MZwXWiqZaL+ipZ2QNtCX5BbPcVjfWcgZ2dQH1WBPTHzsK0G3j30lIXKW
         l8WcnAzn2pDJdxjj+LrF2sKkwiXGgz8DZt6MGa78Fpz+Wt5dOH5BgAd86zrtxj9Y9JlC
         cbrTqcr3XNQvBUt1P4qIFWy8av5zilELqT3zU82deW0AmI6dTKjxOSd3WPUzhLFrK8Uq
         PJQHgdXU6k5URRrt3D2GSvMLPbrsglggbIEZJz+w1SSTfBrcC6H7s5VXgL6IDFw+QwZq
         WH8rg8vQfFpeJn63HoRzGFv9HGedKiSVj8OYFMGPtqVF32Vr/lVj3sH51FYGGMaJf36X
         EuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527923; x=1701132723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOpdM/jsZ8uGT6Q420XJikJy5NZAADH40odTXJj1nGY=;
        b=mPbE7xeZfJGJ1h/109MXBNtiGto0gG0dHE/m/wUWEikkTenNx25XdMTh27afsU0ahX
         RJqSxGeaYGlG8kPwjAvJvrKU0uSLixxB4nqA8LjKHEfVApToVRmQjwniMNpnQ32DON4r
         3O4G7fbw2SMMWgvrhqe3pYsFtl7RHxS8LDKaO9B+webSCkg2ibcK3KILunXhcXZgfa4T
         rGn7DbYaSjs12SeAbCI8F6Q8wGebTo+HsZTgkzNKCCkz6hd6vZRGZhNGva/LE0ZZiYva
         G+iT2D27NAO4w7cJx8iRU5DhQJJ+Gy9N8Ov8oWp7z965J626de61v2SG+vZegua6VgPQ
         gqVA==
X-Gm-Message-State: AOJu0YywEgPlxGpi+/+2nIJkJMzrBZL+skOrixuaO2JHIvykO/hMsGLo
        05ciAqHbv0jPdPFlMqn6fu4pruactPg=
X-Google-Smtp-Source: AGHT+IGgo026zQyp3gKxOv/fbqnSS7aECIhUGN4DtymScXmA2hl8vr1wgItSDJtdmeKwhPDkEjMCVg==
X-Received: by 2002:a17:902:9b89:b0:1cf:5543:a96 with SMTP id y9-20020a1709029b8900b001cf55430a96mr5744411plp.51.1700527922986;
        Mon, 20 Nov 2023 16:52:02 -0800 (PST)
Received: from nickserv.taila7d40.ts.net (c-24-5-149-91.hsd1.ca.comcast.net. [24.5.149.91])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902ee8c00b001c74876f018sm6705936pld.18.2023.11.20.16.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:52:02 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yann Collet <cyan@meta.com>, Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>
Subject: [PATCH 2/2] zstd: Backport Huffman speed improvement from upstream
Date:   Mon, 20 Nov 2023 17:03:18 -0800
Message-ID: <20231121010318.524570-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121010318.524570-1-nickrterrell@gmail.com>
References: <20231121010318.524570-1-nickrterrell@gmail.com>
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

From: Nick Terrell <terrelln@meta.com>

Backport upstream commit c7269ad [0] to improve zstd decoding speed.

Updating the kernel to zstd v1.5.5 earlier in this patch series
regressed zstd decoding speed. This turned out to be because gcc was not
unrolling the inner loops of the Huffman decoder which are executed a
constant number of times [1]. This really hurts performance, as we expect
this loop to be completely branch-free. This commit fixes the issue by
unrolling the loop manually [2].

The commit fixes one more minor issue, which is to mask a variable shift
by 0x3F. The shift was guaranteed to be less than 64, but gcc couldn't
prove that, and emitted suboptimal code.

Finally, the upstream commit added a build macro
`HUF_DISABLE_FAST_DECODE` which is not used in the kernel, but is
maintained to keep a clean import from upstream.

This commit was generated from upstream signed tag v1.5.5-kernel [3] by:

  export ZSTD=/path/to/repo/zstd/
  export LINUX=/path/to/repo/linux/
  cd "$ZSTD/contrib/linux-kernel"
  git checkout v1.5.5-kernel
  make import LINUX="$LINUX"

I ran my benchmark & test suite before and after this commit to measure
the overall decompression speed benefit. It benchmarks zstd at several
compression levels. These benchmarks measure the total time it takes to
read data from the compressed filesystem.

Component,	Level,	Read time delta
Btrfs    ,	    1,	-7.0%
Btrfs    ,	    3,	-3.9%
Btrfs    ,	    5,	-4.7%
Btrfs    ,	    7,	-5.5%
Btrfs    ,	    9,	-2.4%
Squashfs ,	    1,	-9.1%

Link: https://github.com/facebook/zstd/commit/c7269add7eaf028ed828d9af41e732cf01993aad
Link: https://gist.github.com/terrelln/2e14ff1fb197102a08d7823d8044978d
Link: https://gist.github.com/terrelln/a70bde22a2abc800691fb65c21eabc2a
Link: https://github.com/facebook/zstd/tree/v1.5.5-kernel
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/zstd/decompress/huf_decompress.c | 171 ++++++++++++++++-----------
 1 file changed, 105 insertions(+), 66 deletions(-)

diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index d172e35fbd9a..db670d71fdab 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -35,6 +35,12 @@
 *  Macros
 ****************************************************************/
 
+#ifdef HUF_DISABLE_FAST_DECODE
+# define HUF_ENABLE_FAST_DECODE 0
+#else
+# define HUF_ENABLE_FAST_DECODE 1
+#endif
+
 /* These two optional macros force the use one way or another of the two
  * Huffman decompression implementations. You can't force in both directions
  * at the same time.
@@ -289,6 +295,24 @@ static size_t HUF_initRemainingDStream(BIT_DStream_t* bit, HUF_DecompressFastArg
     return 0;
 }
 
+/* Calls X(N) for each stream 0, 1, 2, 3. */
+#define HUF_4X_FOR_EACH_STREAM(X) \
+    {                             \
+        X(0)                      \
+        X(1)                      \
+        X(2)                      \
+        X(3)                      \
+    }
+
+/* Calls X(N, var) for each stream 0, 1, 2, 3. */
+#define HUF_4X_FOR_EACH_STREAM_WITH_VAR(X, var) \
+    {                                           \
+        X(0, (var))                             \
+        X(1, (var))                             \
+        X(2, (var))                             \
+        X(3, (var))                             \
+    }
+
 
 #ifndef HUF_FORCE_DECOMPRESS_X2
 
@@ -702,7 +726,6 @@ void HUF_decompress4X1_usingDTable_internal_fast_c_loop(HUF_DecompressFastArgs*
     for (;;) {
         BYTE* olimit;
         int stream;
-        int symbol;
 
         /* Assert loop preconditions */
 #ifndef NDEBUG
@@ -749,27 +772,42 @@ void HUF_decompress4X1_usingDTable_internal_fast_c_loop(HUF_DecompressFastArgs*
         }
 #endif
 
+#define HUF_4X1_DECODE_SYMBOL(_stream, _symbol)                 \
+    {                                                           \
+        int const index = (int)(bits[(_stream)] >> 53);         \
+        int const entry = (int)dtable[index];                   \
+        bits[(_stream)] <<= (entry & 0x3F);                     \
+        op[(_stream)][(_symbol)] = (BYTE)((entry >> 8) & 0xFF); \
+    }
+
+#define HUF_4X1_RELOAD_STREAM(_stream)                              \
+    {                                                               \
+        int const ctz = ZSTD_countTrailingZeros64(bits[(_stream)]); \
+        int const nbBits = ctz & 7;                                 \
+        int const nbBytes = ctz >> 3;                               \
+        op[(_stream)] += 5;                                         \
+        ip[(_stream)] -= nbBytes;                                   \
+        bits[(_stream)] = MEM_read64(ip[(_stream)]) | 1;            \
+        bits[(_stream)] <<= nbBits;                                 \
+    }
+
+        /* Manually unroll the loop because compilers don't consistently
+         * unroll the inner loops, which destroys performance.
+         */
         do {
             /* Decode 5 symbols in each of the 4 streams */
-            for (symbol = 0; symbol < 5; ++symbol) {
-                for (stream = 0; stream < 4; ++stream) {
-                    int const index = (int)(bits[stream] >> 53);
-                    int const entry = (int)dtable[index];
-                    bits[stream] <<= (entry & 63);
-                    op[stream][symbol] = (BYTE)((entry >> 8) & 0xFF);
-                }
-            }
-            /* Reload the bitstreams */
-            for (stream = 0; stream < 4; ++stream) {
-                int const ctz = ZSTD_countTrailingZeros64(bits[stream]);
-                int const nbBits = ctz & 7;
-                int const nbBytes = ctz >> 3;
-                op[stream] += 5;
-                ip[stream] -= nbBytes;
-                bits[stream] = MEM_read64(ip[stream]) | 1;
-                bits[stream] <<= nbBits;
-            }
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 0)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 1)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 2)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 3)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X1_DECODE_SYMBOL, 4)
+
+            /* Reload each of the 4 the bitstreams */
+            HUF_4X_FOR_EACH_STREAM(HUF_4X1_RELOAD_STREAM)
         } while (op[3] < olimit);
+
+#undef HUF_4X1_DECODE_SYMBOL
+#undef HUF_4X1_RELOAD_STREAM
     }
 
 _out:
@@ -865,7 +903,7 @@ static size_t HUF_decompress4X1_usingDTable_internal(void* dst, size_t dstSize,
     }
 #endif
 
-    if (!(flags & HUF_flags_disableFast)) {
+    if (HUF_ENABLE_FAST_DECODE && !(flags & HUF_flags_disableFast)) {
         size_t const ret = HUF_decompress4X1_usingDTable_internal_fast(dst, dstSize, cSrc, cSrcSize, DTable, loopFn);
         if (ret != 0)
             return ret;
@@ -1487,7 +1525,6 @@ void HUF_decompress4X2_usingDTable_internal_fast_c_loop(HUF_DecompressFastArgs*
     for (;;) {
         BYTE* olimit;
         int stream;
-        int symbol;
 
         /* Assert loop preconditions */
 #ifndef NDEBUG
@@ -1544,54 +1581,56 @@ void HUF_decompress4X2_usingDTable_internal_fast_c_loop(HUF_DecompressFastArgs*
         }
 #endif
 
+#define HUF_4X2_DECODE_SYMBOL(_stream, _decode3)        \
+    if ((_decode3) || (_stream) != 3) {                 \
+        int const index = (int)(bits[(_stream)] >> 53); \
+        HUF_DEltX2 const entry = dtable[index];         \
+        MEM_write16(op[(_stream)], entry.sequence);     \
+        bits[(_stream)] <<= (entry.nbBits) & 0x3F;      \
+        op[(_stream)] += (entry.length);                \
+    }
+
+#define HUF_4X2_RELOAD_STREAM(_stream)                                  \
+    {                                                                   \
+        HUF_4X2_DECODE_SYMBOL(3, 1)                                     \
+        {                                                               \
+            int const ctz = ZSTD_countTrailingZeros64(bits[(_stream)]); \
+            int const nbBits = ctz & 7;                                 \
+            int const nbBytes = ctz >> 3;                               \
+            ip[(_stream)] -= nbBytes;                                   \
+            bits[(_stream)] = MEM_read64(ip[(_stream)]) | 1;            \
+            bits[(_stream)] <<= nbBits;                                 \
+        }                                                               \
+    }
+
+        /* Manually unroll the loop because compilers don't consistently
+         * unroll the inner loops, which destroys performance.
+         */
         do {
-            /* Do 5 table lookups for each of the first 3 streams */
-            for (symbol = 0; symbol < 5; ++symbol) {
-                for (stream = 0; stream < 3; ++stream) {
-                    int const index = (int)(bits[stream] >> 53);
-                    HUF_DEltX2 const entry = dtable[index];
-                    MEM_write16(op[stream], entry.sequence);
-                    bits[stream] <<= (entry.nbBits);
-                    op[stream] += (entry.length);
-                }
-            }
-            /* Do 1 table lookup from the final stream */
-            {
-                int const index = (int)(bits[3] >> 53);
-                HUF_DEltX2 const entry = dtable[index];
-                MEM_write16(op[3], entry.sequence);
-                bits[3] <<= (entry.nbBits);
-                op[3] += (entry.length);
-            }
-            /* Do 4 table lookups from the final stream & reload bitstreams */
-            for (stream = 0; stream < 4; ++stream) {
-                /* Do a table lookup from the final stream.
-                 * This is interleaved with the reloading to reduce register
-                 * pressure. This shouldn't be necessary, but compilers can
-                 * struggle with codegen with high register pressure.
-                 */
-                {
-                    int const index = (int)(bits[3] >> 53);
-                    HUF_DEltX2 const entry = dtable[index];
-                    MEM_write16(op[3], entry.sequence);
-                    bits[3] <<= (entry.nbBits);
-                    op[3] += (entry.length);
-                }
-                /* Reload the bistreams. The final bitstream must be reloaded
-                 * after the 5th symbol was decoded.
-                 */
-                {
-                    int const ctz = ZSTD_countTrailingZeros64(bits[stream]);
-                    int const nbBits = ctz & 7;
-                    int const nbBytes = ctz >> 3;
-                    ip[stream] -= nbBytes;
-                    bits[stream] = MEM_read64(ip[stream]) | 1;
-                    bits[stream] <<= nbBits;
-                }
-            }
+            /* Decode 5 symbols from each of the first 3 streams.
+             * The final stream will be decoded during the reload phase
+             * to reduce register pressure.
+             */
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0)
+            HUF_4X_FOR_EACH_STREAM_WITH_VAR(HUF_4X2_DECODE_SYMBOL, 0)
+
+            /* Decode one symbol from the final stream */
+            HUF_4X2_DECODE_SYMBOL(3, 1)
+
+            /* Decode 4 symbols from the final stream & reload bitstreams.
+             * The final stream is reloaded last, meaning that all 5 symbols
+             * are decoded from the final stream before it is reloaded.
+             */
+            HUF_4X_FOR_EACH_STREAM(HUF_4X2_RELOAD_STREAM)
         } while (op[3] < olimit);
     }
 
+#undef HUF_4X2_DECODE_SYMBOL
+#undef HUF_4X2_RELOAD_STREAM
+
 _out:
 
     /* Save the final values of each of the state variables back to args. */
@@ -1676,7 +1715,7 @@ static size_t HUF_decompress4X2_usingDTable_internal(void* dst, size_t dstSize,
     }
 #endif
 
-    if (!(flags & HUF_flags_disableFast)) {
+    if (HUF_ENABLE_FAST_DECODE && !(flags & HUF_flags_disableFast)) {
         size_t const ret = HUF_decompress4X2_usingDTable_internal_fast(dst, dstSize, cSrc, cSrcSize, DTable, loopFn);
         if (ret != 0)
             return ret;
-- 
2.42.1

