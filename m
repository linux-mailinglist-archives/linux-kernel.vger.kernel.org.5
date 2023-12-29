Return-Path: <linux-kernel+bounces-13212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0D820131
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11471F22EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E1134AA;
	Fri, 29 Dec 2023 19:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJoD8EJz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEBE134A0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7815c5b69e1so182702985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703877760; x=1704482560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ex2AAmaqL61crdOZzKotmNuAI8B6uFdUN9DkX79OhY=;
        b=FJoD8EJzCxa2BDqivXgmsT6BjNxV7z7FEpCXHKFpJ6gn9wHG5kQs5IJxxawlNg3hRg
         AQLE3uRHBBXjKzkzH3yXU8eQmSFIP9EaHARpYkCKkEc0I+chdQANh0nThPgllf9+30Im
         9eWRaQaVvStG9//+Esa8fQ9ih72HZp2skDt8JkAc3/D2KJ0Kr/88m5vyy7zeVy7vUHQv
         lV5Y3JohhAD5jp3vQFpvhPLtlbN5e2hVgiiWu33uLB7uKIOqsnVO64ISC/dv4cW8KxN8
         eAVaxOK8k79wybpPLFZsOMoLjDFFyW7xpyfkM2yQnrgVEJH44mRZSZGCwz3VVMBkHimp
         9a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703877760; x=1704482560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ex2AAmaqL61crdOZzKotmNuAI8B6uFdUN9DkX79OhY=;
        b=N1p2KLGyIGbHlFmC5W/UvWnYVJR3xW+pE/zzYxpRzDFG/dzOUQtktWhd9P3pLru8bI
         C+gPkWjVZdQVeHZFC2Zgg9J30DKt7vWcEzPL8lavF9DzRvNZOK8r7IbifxnRE65C0+r1
         uJm/aOlU9GCn0wgOH6GTw8ulDIJtP4cKhur6DuwhDzILEPe7ERwmMx3aO1qfAdkIKQ6s
         Lb1S9EF/+ot8KEOgbqfGw+GsXrGNhqsCsvDqTqEP4wAYglaWcBoqJ5R+VUbkgP9TuA84
         wn33X8+JH+prSiNTjo8BJf8GE9Km8nHPTRE01twkMEZeM/FT6fmiFUjOnn25WDzyyIUy
         UjCQ==
X-Gm-Message-State: AOJu0YxyKTg3W5PreblDv7JUUKkBgeOOdcVOz0YBdM9i/WrbZLRJ/wHV
	mlXvfTjhKp/BqDu5irmtYdCXRyw3Wunfsw==
X-Google-Smtp-Source: AGHT+IFfiAOXckxSMyLvrcE+ouUUlJ2tuypgB3BNXNpxctofQPQ67X8And23TQMb91oF8GtH3ZR16w==
X-Received: by 2002:a05:620a:8121:b0:781:9e1d:df3b with SMTP id os33-20020a05620a812100b007819e1ddf3bmr793469qkn.40.1703877760066;
        Fri, 29 Dec 2023 11:22:40 -0800 (PST)
Received: from localhost.localdomain (pool-108-6-203-26.nycmny.fios.verizon.net. [108.6.203.26])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a056700b007815a63082bsm2625541qkp.130.2023.12.29.11.22.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 Dec 2023 11:22:39 -0800 (PST)
From: Elliot Gorokhovsky <elliot.gorokhovsky@gmail.com>
To: nickrterrell@gmail.com,
	terrelln@meta.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Cc: Elliot Gorokhovsky <elliot.gorokhovsky@gmail.com>
Subject: [PATCH] zstd: support external sequence producer API
Date: Fri, 29 Dec 2023 14:21:58 -0500
Message-Id: <20231229192158.44227-1-elliot.gorokhovsky@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cherry-picks support for using zstd's external sequence producer API in the
kernel. This unblocks the use of QuickAssist hardware acceleration for zstd in
applications such as BTRFS.

Some context: the kernel uses ZSTD_initStaticCCtx() to create compression
contexts. This function builds the compression context in a user-provided buffer
which must be sized according to the compression parameters. zstd provides size
estimation functions for this purpose, but until now they were not compatible
with the external sequence producer API.

This cherry-pick fixes that incompatibility. More specifically, it pulls in zstd
upstream PRs #3839 and #3854. PR #3854 includes a unit test (upstream only)
which validates that the external sequence producer API works correctly in
conjunction with ZSTD_initStaticCCtx().

To build this commit, I first cherry-picked the relevant upstream commits onto
the upstream v1.5.5-kernel tag:
  cd ~/repos/zstd
  git checkout tags/v1.5.5-kernel
  git cherry-pick -m 1 126ec2669c927b24acd38ea903a211c1b5416588
  git cherry-pick c6cabf94417d84ebb5da62e05d8b8a9623763585

I then ran "make import" to copy the changes into my fork of Linux:
  cd ~/repos/zstd/contrib/linux-kernel/
  make import

Signed-off-by: Elliot Gorokhovsky <elliot.gorokhovsky@gmail.com>
---
 include/linux/zstd_lib.h                   | 23 +++++--
 lib/zstd/compress/zstd_compress.c          | 77 ++++++++++++----------
 lib/zstd/compress/zstd_compress_internal.h | 26 ++++----
 3 files changed, 72 insertions(+), 54 deletions(-)

diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index 8b4ffe649df5..610a90ff5af6 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -1632,9 +1632,6 @@ ZSTDLIB_API unsigned ZSTD_isSkippableFrame(const void* buffer, size_t size);
  *
  *  Note : only single-threaded compression is supported.
  *  ZSTD_estimateCCtxSize_usingCCtxParams() will return an error code if ZSTD_c_nbWorkers is >= 1.
- *
- *  Note 2 : ZSTD_estimateCCtxSize* functions are not compatible with the Block-Level Sequence Producer API at this time.
- *  Size estimates assume that no external sequence producer is registered.
  */
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize(int compressionLevel);
 ZSTDLIB_STATIC_API size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compressionParameters cParams);
@@ -2736,7 +2733,7 @@ ZSTDLIB_STATIC_API size_t ZSTD_resetDStream(ZSTD_DStream* zds);
 
 #define ZSTD_SEQUENCE_PRODUCER_ERROR ((size_t)(-1))
 
-typedef size_t ZSTD_sequenceProducer_F (
+typedef size_t (*ZSTD_sequenceProducer_F) (
   void* sequenceProducerState,
   ZSTD_Sequence* outSeqs, size_t outSeqsCapacity,
   const void* src, size_t srcSize,
@@ -2768,7 +2765,23 @@ ZSTDLIB_STATIC_API void
 ZSTD_registerSequenceProducer(
   ZSTD_CCtx* cctx,
   void* sequenceProducerState,
-  ZSTD_sequenceProducer_F* sequenceProducer
+  ZSTD_sequenceProducer_F sequenceProducer
+);
+
+/*! ZSTD_CCtxParams_registerSequenceProducer() :
+ * Same as ZSTD_registerSequenceProducer(), but operates on ZSTD_CCtx_params.
+ * This is used for accurate size estimation with ZSTD_estimateCCtxSize_usingCCtxParams(),
+ * which is needed when creating a ZSTD_CCtx with ZSTD_initStaticCCtx().
+ *
+ * If you are using the external sequence producer API in a scenario where ZSTD_initStaticCCtx()
+ * is required, then this function is for you. Otherwise, you probably don't need it.
+ *
+ * See tests/zstreamtest.c for example usage. */
+ZSTDLIB_STATIC_API void
+ZSTD_CCtxParams_registerSequenceProducer(
+  ZSTD_CCtx_params* params,
+  void* sequenceProducerState,
+  ZSTD_sequenceProducer_F sequenceProducer
 );
 
 
diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
index c1c316e9e289..d1c0c6690784 100644
--- a/lib/zstd/compress/zstd_compress.c
+++ b/lib/zstd/compress/zstd_compress.c
@@ -1295,7 +1295,6 @@ size_t ZSTD_CCtx_reset(ZSTD_CCtx* cctx, ZSTD_ResetDirective reset)
         RETURN_ERROR_IF(cctx->streamStage != zcss_init, stage_wrong,
                         "Reset parameters is only possible during init stage.");
         ZSTD_clearAllDicts(cctx);
-        ZSTD_memset(&cctx->externalMatchCtx, 0, sizeof(cctx->externalMatchCtx));
         return ZSTD_CCtxParams_reset(&cctx->requestedParams);
     }
     return 0;
@@ -1639,7 +1638,7 @@ size_t ZSTD_estimateCCtxSize_usingCCtxParams(const ZSTD_CCtx_params* params)
      * be needed. However, we still allocate two 0-sized buffers, which can
      * take space under ASAN. */
     return ZSTD_estimateCCtxSize_usingCCtxParams_internal(
-        &cParams, &params->ldmParams, 1, useRowMatchFinder, 0, 0, ZSTD_CONTENTSIZE_UNKNOWN, params->useSequenceProducer, params->maxBlockSize);
+        &cParams, &params->ldmParams, 1, useRowMatchFinder, 0, 0, ZSTD_CONTENTSIZE_UNKNOWN, ZSTD_hasExtSeqProd(params), params->maxBlockSize);
 }
 
 size_t ZSTD_estimateCCtxSize_usingCParams(ZSTD_compressionParameters cParams)
@@ -1700,7 +1699,7 @@ size_t ZSTD_estimateCStreamSize_usingCCtxParams(const ZSTD_CCtx_params* params)
 
         return ZSTD_estimateCCtxSize_usingCCtxParams_internal(
             &cParams, &params->ldmParams, 1, useRowMatchFinder, inBuffSize, outBuffSize,
-            ZSTD_CONTENTSIZE_UNKNOWN, params->useSequenceProducer, params->maxBlockSize);
+            ZSTD_CONTENTSIZE_UNKNOWN, ZSTD_hasExtSeqProd(params), params->maxBlockSize);
     }
 }
 
@@ -1996,7 +1995,7 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
 
     {   size_t const windowSize = MAX(1, (size_t)MIN(((U64)1 << params->cParams.windowLog), pledgedSrcSize));
         size_t const blockSize = MIN(params->maxBlockSize, windowSize);
-        size_t const maxNbSeq = ZSTD_maxNbSeq(blockSize, params->cParams.minMatch, params->useSequenceProducer);
+        size_t const maxNbSeq = ZSTD_maxNbSeq(blockSize, params->cParams.minMatch, ZSTD_hasExtSeqProd(params));
         size_t const buffOutSize = (zbuff == ZSTDb_buffered && params->outBufferMode == ZSTD_bm_buffered)
                 ? ZSTD_compressBound(blockSize) + 1
                 : 0;
@@ -2013,7 +2012,7 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
         size_t const neededSpace =
             ZSTD_estimateCCtxSize_usingCCtxParams_internal(
                 &params->cParams, &params->ldmParams, zc->staticSize != 0, params->useRowMatchFinder,
-                buffInSize, buffOutSize, pledgedSrcSize, params->useSequenceProducer, params->maxBlockSize);
+                buffInSize, buffOutSize, pledgedSrcSize, ZSTD_hasExtSeqProd(params), params->maxBlockSize);
         int resizeWorkspace;
 
         FORWARD_IF_ERROR(neededSpace, "cctx size estimate failed!");
@@ -2098,10 +2097,10 @@ static size_t ZSTD_resetCCtx_internal(ZSTD_CCtx* zc,
         }
 
         /* reserve space for block-level external sequences */
-        if (params->useSequenceProducer) {
+        if (ZSTD_hasExtSeqProd(params)) {
             size_t const maxNbExternalSeq = ZSTD_sequenceBound(blockSize);
-            zc->externalMatchCtx.seqBufferCapacity = maxNbExternalSeq;
-            zc->externalMatchCtx.seqBuffer =
+            zc->extSeqBufCapacity = maxNbExternalSeq;
+            zc->extSeqBuf =
                 (ZSTD_Sequence*)ZSTD_cwksp_reserve_aligned(ws, maxNbExternalSeq * sizeof(ZSTD_Sequence));
         }
 
@@ -3102,7 +3101,7 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
             /* External matchfinder + LDM is technically possible, just not implemented yet.
              * We need to revisit soon and implement it. */
             RETURN_ERROR_IF(
-                zc->appliedParams.useSequenceProducer,
+                ZSTD_hasExtSeqProd(&zc->appliedParams),
                 parameter_combination_unsupported,
                 "Long-distance matching with external sequence producer enabled is not currently supported."
             );
@@ -3121,7 +3120,7 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
             /* External matchfinder + LDM is technically possible, just not implemented yet.
              * We need to revisit soon and implement it. */
             RETURN_ERROR_IF(
-                zc->appliedParams.useSequenceProducer,
+                ZSTD_hasExtSeqProd(&zc->appliedParams),
                 parameter_combination_unsupported,
                 "Long-distance matching with external sequence producer enabled is not currently supported."
             );
@@ -3140,18 +3139,18 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
                                        zc->appliedParams.useRowMatchFinder,
                                        src, srcSize);
             assert(ldmSeqStore.pos == ldmSeqStore.size);
-        } else if (zc->appliedParams.useSequenceProducer) {
+        } else if (ZSTD_hasExtSeqProd(&zc->appliedParams)) {
             assert(
-                zc->externalMatchCtx.seqBufferCapacity >= ZSTD_sequenceBound(srcSize)
+                zc->extSeqBufCapacity >= ZSTD_sequenceBound(srcSize)
             );
-            assert(zc->externalMatchCtx.mFinder != NULL);
+            assert(zc->appliedParams.extSeqProdFunc != NULL);
 
             {   U32 const windowSize = (U32)1 << zc->appliedParams.cParams.windowLog;
 
-                size_t const nbExternalSeqs = (zc->externalMatchCtx.mFinder)(
-                    zc->externalMatchCtx.mState,
-                    zc->externalMatchCtx.seqBuffer,
-                    zc->externalMatchCtx.seqBufferCapacity,
+                size_t const nbExternalSeqs = (zc->appliedParams.extSeqProdFunc)(
+                    zc->appliedParams.extSeqProdState,
+                    zc->extSeqBuf,
+                    zc->extSeqBufCapacity,
                     src, srcSize,
                     NULL, 0,  /* dict and dictSize, currently not supported */
                     zc->appliedParams.compressionLevel,
@@ -3159,21 +3158,21 @@ static size_t ZSTD_buildSeqStore(ZSTD_CCtx* zc, const void* src, size_t srcSize)
                 );
 
                 size_t const nbPostProcessedSeqs = ZSTD_postProcessSequenceProducerResult(
-                    zc->externalMatchCtx.seqBuffer,
+                    zc->extSeqBuf,
                     nbExternalSeqs,
-                    zc->externalMatchCtx.seqBufferCapacity,
+                    zc->extSeqBufCapacity,
                     srcSize
                 );
 
                 /* Return early if there is no error, since we don't need to worry about last literals */
                 if (!ZSTD_isError(nbPostProcessedSeqs)) {
                     ZSTD_sequencePosition seqPos = {0,0,0};
-                    size_t const seqLenSum = ZSTD_fastSequenceLengthSum(zc->externalMatchCtx.seqBuffer, nbPostProcessedSeqs);
+                    size_t const seqLenSum = ZSTD_fastSequenceLengthSum(zc->extSeqBuf, nbPostProcessedSeqs);
                     RETURN_ERROR_IF(seqLenSum > srcSize, externalSequences_invalid, "External sequences imply too large a block!");
                     FORWARD_IF_ERROR(
                         ZSTD_copySequencesToSeqStoreExplicitBlockDelim(
                             zc, &seqPos,
-                            zc->externalMatchCtx.seqBuffer, nbPostProcessedSeqs,
+                            zc->extSeqBuf, nbPostProcessedSeqs,
                             src, srcSize,
                             zc->appliedParams.searchForExternalRepcodes
                         ),
@@ -6217,7 +6216,7 @@ ZSTD_copySequencesToSeqStoreExplicitBlockDelim(ZSTD_CCtx* cctx,
         if (cctx->appliedParams.validateSequences) {
             seqPos->posInSrc += litLength + matchLength;
             FORWARD_IF_ERROR(ZSTD_validateSequence(offBase, matchLength, cctx->appliedParams.cParams.minMatch, seqPos->posInSrc,
-                                                cctx->appliedParams.cParams.windowLog, dictSize, cctx->appliedParams.useSequenceProducer),
+                                                cctx->appliedParams.cParams.windowLog, dictSize, ZSTD_hasExtSeqProd(&cctx->appliedParams)),
                                                 "Sequence validation failed");
         }
         RETURN_ERROR_IF(idx - seqPos->idx >= cctx->seqStore.maxNbSeq, externalSequences_invalid,
@@ -6355,7 +6354,7 @@ ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_sequencePosition*
         if (cctx->appliedParams.validateSequences) {
             seqPos->posInSrc += litLength + matchLength;
             FORWARD_IF_ERROR(ZSTD_validateSequence(offBase, matchLength, cctx->appliedParams.cParams.minMatch, seqPos->posInSrc,
-                                                   cctx->appliedParams.cParams.windowLog, dictSize, cctx->appliedParams.useSequenceProducer),
+                                                   cctx->appliedParams.cParams.windowLog, dictSize, ZSTD_hasExtSeqProd(&cctx->appliedParams)),
                                                    "Sequence validation failed");
         }
         DEBUGLOG(6, "Storing sequence: (of: %u, ml: %u, ll: %u)", offBase, matchLength, litLength);
@@ -6801,19 +6800,27 @@ ZSTD_parameters ZSTD_getParams(int compressionLevel, unsigned long long srcSizeH
 }
 
 void ZSTD_registerSequenceProducer(
-    ZSTD_CCtx* zc, void* mState,
-    ZSTD_sequenceProducer_F* mFinder
+    ZSTD_CCtx* zc,
+    void* extSeqProdState,
+    ZSTD_sequenceProducer_F extSeqProdFunc
 ) {
-    if (mFinder != NULL) {
-        ZSTD_externalMatchCtx emctx;
-        emctx.mState = mState;
-        emctx.mFinder = mFinder;
-        emctx.seqBuffer = NULL;
-        emctx.seqBufferCapacity = 0;
-        zc->externalMatchCtx = emctx;
-        zc->requestedParams.useSequenceProducer = 1;
+    assert(zc != NULL);
+    ZSTD_CCtxParams_registerSequenceProducer(
+        &zc->requestedParams, extSeqProdState, extSeqProdFunc
+    );
+}
+
+void ZSTD_CCtxParams_registerSequenceProducer(
+  ZSTD_CCtx_params* params,
+  void* extSeqProdState,
+  ZSTD_sequenceProducer_F extSeqProdFunc
+) {
+    assert(params != NULL);
+    if (extSeqProdFunc != NULL) {
+        params->extSeqProdFunc = extSeqProdFunc;
+        params->extSeqProdState = extSeqProdState;
     } else {
-        ZSTD_memset(&zc->externalMatchCtx, 0, sizeof(zc->externalMatchCtx));
-        zc->requestedParams.useSequenceProducer = 0;
+        params->extSeqProdFunc = NULL;
+        params->extSeqProdState = NULL;
     }
 }
diff --git a/lib/zstd/compress/zstd_compress_internal.h b/lib/zstd/compress/zstd_compress_internal.h
index 899f5e2de8e9..d029b6f9edd6 100644
--- a/lib/zstd/compress/zstd_compress_internal.h
+++ b/lib/zstd/compress/zstd_compress_internal.h
@@ -355,10 +355,11 @@ struct ZSTD_CCtx_params_s {
      * if the external matchfinder returns an error code. */
     int enableMatchFinderFallback;
 
-    /* Indicates whether an external matchfinder has been referenced.
-     * Users can't set this externally.
-     * It is set internally in ZSTD_registerSequenceProducer(). */
-    int useSequenceProducer;
+    /* Parameters for the external sequence producer API.
+     * Users set these parameters through ZSTD_registerSequenceProducer().
+     * It is not possible to set these parameters individually through the public API. */
+    void* extSeqProdState;
+    ZSTD_sequenceProducer_F extSeqProdFunc;
 
     /* Adjust the max block size*/
     size_t maxBlockSize;
@@ -396,14 +397,6 @@ typedef struct {
     ZSTD_entropyCTablesMetadata_t entropyMetadata;
 } ZSTD_blockSplitCtx;
 
-/* Context for block-level external matchfinder API */
-typedef struct {
-  void* mState;
-  ZSTD_sequenceProducer_F* mFinder;
-  ZSTD_Sequence* seqBuffer;
-  size_t seqBufferCapacity;
-} ZSTD_externalMatchCtx;
-
 struct ZSTD_CCtx_s {
     ZSTD_compressionStage_e stage;
     int cParamsChanged;                  /* == 1 if cParams(except wlog) or compression level are changed in requestedParams. Triggers transmission of new params to ZSTDMT (if available) then reset to 0. */
@@ -468,8 +461,9 @@ struct ZSTD_CCtx_s {
     /* Workspace for block splitter */
     ZSTD_blockSplitCtx blockSplitCtx;
 
-    /* Workspace for external matchfinder */
-    ZSTD_externalMatchCtx externalMatchCtx;
+    /* Buffer for output from external sequence producer */
+    ZSTD_Sequence* extSeqBuf;
+    size_t extSeqBufCapacity;
 };
 
 typedef enum { ZSTD_dtlm_fast, ZSTD_dtlm_full } ZSTD_dictTableLoadMethod_e;
@@ -1495,6 +1489,10 @@ ZSTD_copySequencesToSeqStoreNoBlockDelim(ZSTD_CCtx* cctx, ZSTD_sequencePosition*
                                    const ZSTD_Sequence* const inSeqs, size_t inSeqsSize,
                                    const void* src, size_t blockSize, ZSTD_paramSwitch_e externalRepSearch);
 
+/* Returns 1 if an external sequence producer is registered, otherwise returns 0. */
+MEM_STATIC int ZSTD_hasExtSeqProd(const ZSTD_CCtx_params* params) {
+    return params->extSeqProdFunc != NULL;
+}
 
 /* ===============================================================
  * Deprecated definitions that are still used internally to avoid
-- 
2.39.2 (Apple Git-143)


