Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06C76937F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjGaKuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjGaKtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:49:52 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3A10E0;
        Mon, 31 Jul 2023 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800562; bh=JGGtMrE57kUvgv6mo7tmcpGnIHxi87n9B+IU2cOpSMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJxUcEUfQfpGEWROn7cdMw1hixU6L6YhjdHvvkDecF3rT8pSTQh5Tp0WTrjH/ydCS
         aESRGHF6y5yzexM6bTS/U2k6OEDZ+wS9uzLm9vMd6b4VirHzdPamgRZ+xLQy/aSLDr
         VNup9aq9QC0plDwmOo2wXbgbfTwRWZcOo1TfdsrA=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 17D3B6019D;
        Mon, 31 Jul 2023 18:49:22 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 3/5] raid6: test: cosmetic cleanups for the test Makefile
Date:   Mon, 31 Jul 2023 18:49:09 +0800
Message-Id: <20230731104911.411964-4-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731104911.411964-1-kernel@xen0n.name>
References: <20230731104911.411964-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Use tabs/spaces consistently: hard tabs for marking recipe lines only,
spaces for everything else.

Also, the OPTFLAGS declaration actually included the tabs preceding the
line comment, making compiler invocation lines unnecessarily long. As
the entire block of declarations are meant for ad-hoc customization
(otherwise they would probably make use of `?=` instead of `=`), move
the "Adjust as desired" comment above the block too to fix the long
invocation lines.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 lib/raid6/test/Makefile | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 4fb7700a741bd..143cda60faa12 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -6,14 +6,15 @@
 
 pound := \#
 
-CC	 = gcc
-OPTFLAGS = -O2			# Adjust as desired
-CFLAGS	 = -I.. -I ../../../include -g $(OPTFLAGS)
-LD	 = ld
-AWK	 = awk -f
-AR	 = ar
-RANLIB	 = ranlib
-OBJS	 = int1.o int2.o int4.o int8.o int16.o int32.o recov.o algos.o tables.o
+# Adjust as desired
+CC       = gcc
+OPTFLAGS = -O2
+CFLAGS   = -I.. -I ../../../include -g $(OPTFLAGS)
+LD       = ld
+AWK      = awk -f
+AR       = ar
+RANLIB   = ranlib
+OBJS     = int1.o int2.o int4.o int8.o int16.o int32.o recov.o algos.o tables.o
 
 ARCH := $(shell uname -m 2>/dev/null | sed -e /s/i.86/i386/)
 ifeq ($(ARCH),i386)
@@ -37,9 +38,9 @@ endif
 ifeq ($(IS_X86),yes)
         OBJS   += mmx.o sse1.o sse2.o avx2.o recov_ssse3.o recov_avx2.o avx512.o recov_avx512.o
         CFLAGS += -DCONFIG_X86
-	CFLAGS += $(shell echo "vpmovm2b %k1, %zmm5" |          \
-		    gcc -c -x assembler - >/dev/null 2>&1 &&	\
-		    rm ./-.o && echo -DCONFIG_AS_AVX512=1)
+        CFLAGS += $(shell echo "vpmovm2b %k1, %zmm5" |          \
+                    gcc -c -x assembler - >/dev/null 2>&1 &&    \
+                    rm ./-.o && echo -DCONFIG_AS_AVX512=1)
 else ifeq ($(HAS_NEON),yes)
         OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
@@ -63,12 +64,12 @@ endif
 %.uc: ../%.uc
 	cp -f $< $@
 
-all:	raid6.a raid6test
+all: raid6.a raid6test
 
 raid6.a: $(OBJS)
-	 rm -f $@
-	 $(AR) cq $@ $^
-	 $(RANLIB) $@
+	rm -f $@
+	$(AR) cq $@ $^
+	$(RANLIB) $@
 
 raid6test: test.c raid6.a
 	$(CC) $(CFLAGS) -o raid6test $^
-- 
2.40.0

