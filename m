Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479C27AAF36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjIVKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjIVKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:12:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6F91
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:12:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so15432945e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 03:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695377529; x=1695982329; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BXbvml9cBGqT+sftWBWJbMCLyf1ZwTgcv8jDvifsZus=;
        b=QvdtjfwHTlyTSuHCDFB4AVaP/Btl9bm5jAJAvFeVNFZsJQoAB+IbaUoUyrnoOfKgp5
         NsNTTW8+Sata5pnxmom37AH0Yw4YxMykCWgXk0nnoU7yHeJDL5p9d76QqfHWCz5zurHN
         23SGrQV2ki0D1l53IHECQ85KzyIWblIctCfnBafENHbcg/QmfQ1E7+u3gaoIhrphc5Ny
         mksxKerr+nLVsPR7Kduos2OIDxomN6Lh6BhIkEpBZJ/CaHYdpgaTiQdjNoyh6ArrYgQI
         QYTS5pcbrU3f/ZEaq9dYtvYM53+Tt6+cljKueo3ZbK6GC+SwYWbe929HmeI1hzX17JgL
         k4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695377529; x=1695982329;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXbvml9cBGqT+sftWBWJbMCLyf1ZwTgcv8jDvifsZus=;
        b=dhxkxrEeSG/XNuUhQr7izEU6hKHcOmtxC2RSdfQ4f0nUNE32Vzg4R6RITVKbsuZlV6
         YbkooeVP4w0iOx/++cUS4suMmFax0Pj9k9MFSkxuc6wjM8dhftmD2RRr6Xd8SnsRJdsC
         AxGS/22I7UOGVk0KwSaquZU9gA6cmLc4C6nJGALG0yUZ/wJys18vMpSUioW6f4zObYI3
         eZRz/vsuwF9Xy5xeNxMxRsQuBwiDRNpoig6NP1zTGxLvo6eJvH0Gf2T4OQf2/Qm7spUk
         gn7drQ7pEj5dHT+s/w73EUwUd9vROr1Fns4TfKTkkDceJwnhMbMhidjzoh26mrKPqplS
         JtOA==
X-Gm-Message-State: AOJu0YxaoZulfBA61lIWEABM8pyW97/qEy+Wa5TREdSlI7XlB44wedKo
        PrzmsmbsVcgrBT38d2rVgQI=
X-Google-Smtp-Source: AGHT+IHCDEioYZS+MAbnzew8lPvde7v9frtpcWbfEtdo4YR8nOLlfWnkYctecp4UywSu4YLQLlsu3A==
X-Received: by 2002:adf:f54d:0:b0:317:4ef8:1659 with SMTP id j13-20020adff54d000000b003174ef81659mr6613718wrp.28.1695377528989;
        Fri, 22 Sep 2023 03:12:08 -0700 (PDT)
Received: from gmail.com (1F2EF49C.nat.pool.telekom.hu. [31.46.244.156])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b0031ffa453affsm4055120wru.17.2023.09.22.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 03:12:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 22 Sep 2023 12:12:06 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [GIT PULL] locking fixes
Message-ID: <ZQ1odhFD+Kz1Eutj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-09-22

   # HEAD: 41b43b6c6e30a832c790b010a06772e793bca193 locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()

Fix a include/linux/atomic/atomic-arch-fallback.h breakage that generated
incorrect code, and fix a lockdep reporting race that may result in lockups.

 Thanks,

	Ingo

------------------>
Mark Rutland (1):
      locking/atomic: scripts: fix fallback ifdeffery

Sebastian Andrzej Siewior (1):
      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()


 include/linux/atomic/atomic-arch-fallback.h | 10 +---------
 include/linux/seqlock.h                     |  2 +-
 scripts/atomic/gen-atomic-fallback.sh       |  2 +-
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d..b83ef19da13d 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -459,8 +459,6 @@ raw_atomic_read_acquire(const atomic_t *v)
 {
 #if defined(arch_atomic_read_acquire)
 	return arch_atomic_read_acquire(v);
-#elif defined(arch_atomic_read)
-	return arch_atomic_read(v);
 #else
 	int ret;
 
@@ -508,8 +506,6 @@ raw_atomic_set_release(atomic_t *v, int i)
 {
 #if defined(arch_atomic_set_release)
 	arch_atomic_set_release(v, i);
-#elif defined(arch_atomic_set)
-	arch_atomic_set(v, i);
 #else
 	if (__native_word(atomic_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -2575,8 +2571,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 {
 #if defined(arch_atomic64_read_acquire)
 	return arch_atomic64_read_acquire(v);
-#elif defined(arch_atomic64_read)
-	return arch_atomic64_read(v);
 #else
 	s64 ret;
 
@@ -2624,8 +2618,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
 #if defined(arch_atomic64_set_release)
 	arch_atomic64_set_release(v, i);
-#elif defined(arch_atomic64_set)
-	arch_atomic64_set(v, i);
 #else
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -4657,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 2fdd6702823fa842f9cea57a002e6e4476ae780c
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 987a59d977c5..e9bd2f65d7f4 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -512,8 +512,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index c0c8a85d7c81..a45154cefa48 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -102,7 +102,7 @@ gen_proto_order_variant()
 	fi
 
 	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
-	if [ ! -z "${order}" ]; then
+	if [ ! -z "${order}" ] && ! meta_is_implicitly_relaxed "${meta}"; then
 		printf "#elif defined(arch_${basename})\n"
 		printf "\t${retstmt}arch_${basename}(${args});\n"
 	fi
