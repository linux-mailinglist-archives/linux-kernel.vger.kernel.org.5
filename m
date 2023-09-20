Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757B47A7B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjITLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjITLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:50:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA8D8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:50:07 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690ba63891dso1972714b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210607; x=1695815407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViRd+Gr7Vea/QsHKqz0MVpGhjqXSzaa4q8ebpul4oxo=;
        b=jaVMKYsiAri3TRLO/HxbUjKvG2LbeZJKkshmmF/5j4AxmUFaF/LY+tcUzpVW6OoAqM
         9NPVy+tW59XTxp1EHZ6M186BvfMDCQpBjnxD/SPTiDZu2Xvuw9SLaM8RaUB0u98C4sZk
         1zgDp+v2luDYzyL/V+RPtecndc3/lr+BDzZz4/ugf6kc5aPeTzkkNSJyA09xZ7Yx6NMd
         kG3EoPo70qd88beZN4BlF4yWL4xt5Fq6qKV30q2K86eLYEvXKz9PkbYvOlDxX+wLc7HM
         pnu3dGNTK/X+O102HczLR8fKpSoefyGIU4SpZ4/sVZyLYtI8+Sli1Y5C2s4zYqkkvA/2
         B+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210607; x=1695815407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViRd+Gr7Vea/QsHKqz0MVpGhjqXSzaa4q8ebpul4oxo=;
        b=JdemCP6DdE9G/0ylEWzOGRg09BqrzwI7P43y8G9yks66mJtmPHN8/9D8JMeXtYIyRH
         ogf3ZgXYr4zOT9Yo/OGoYsEO2wQqSlN9elTq/j59F+L2S6dHuRFqluvcehltX28tpIiA
         2Y7HwFVUiheFw5FTIvbUzmVDMf8tzHVJ6T6U3hr9EXER0W1pRC7kTrUyMyvjrE6MBDKW
         HHRHD/NHUQi7nl7631t4VgY/dpQEjvidRfjbY7WZ+6ZdmtMdYQDtGG2jqANxISYk+Sgj
         OfjiApBedNNaRMRAdpnYNfl0ARaU6QKr7MFf5kwnlQny9wR3Zpvdu6WBLVwYmbtgRpXM
         bgSg==
X-Gm-Message-State: AOJu0YzYSQPKVpTL6p4w2VDXwuIaVsjEQc5FmVUCoJM2vsAuYjRuc0f8
        28ASH41ZopFrhl4OsJKKZP5mlZfIxbY=
X-Google-Smtp-Source: AGHT+IGuGev2R0kahPW3KV6Hfe7MvELk7GDzooXB6TRzjhqb0HYc5PLdhPuHiY8H7orSuApcq4GavA==
X-Received: by 2002:a05:6a20:dd87:b0:153:616c:7ca4 with SMTP id kw7-20020a056a20dd8700b00153616c7ca4mr1962296pzb.61.1695210606677;
        Wed, 20 Sep 2023 04:50:06 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id dh2-20020a056a00478200b00690bd3c0723sm2917295pfb.99.2023.09.20.04.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:50:06 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] xtensa: boot/lib: fix function prototypes
Date:   Wed, 20 Sep 2023 04:49:34 -0700
Message-Id: <20230920114934.2793310-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function prototype for gunzip() to the boot library code and make
exit() and zalloc() static.

arch/xtensa/boot/lib/zmem.c:8:6: warning: no previous prototype for 'exit' [-Wmissing-prototypes]
    8 | void exit (void)
arch/xtensa/boot/lib/zmem.c:13:7: warning: no previous prototype for 'zalloc' [-Wmissing-prototypes]
   13 | void *zalloc(unsigned size)
arch/xtensa/boot/lib/zmem.c:35:6: warning: no previous prototype for 'gunzip' [-Wmissing-prototypes]
   35 | void gunzip (void *dst, int dstlen, unsigned char *src, int *lenp)

Fixes: 4bedea945451 ("xtensa: Architecture support for Tensilica Xtensa Part 2")
Fixes: e7d163f76665 ("xtensa: Removed local copy of zlib and fixed O= support")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/lib/zmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
index e3ecd743c515..b89189355122 100644
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -4,13 +4,14 @@
 /* bits taken from ppc */
 
 extern void *avail_ram, *end_avail;
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp);
 
-void exit (void)
+static void exit(void)
 {
   for (;;);
 }
 
-void *zalloc(unsigned size)
+static void *zalloc(unsigned int size)
 {
         void *p = avail_ram;
 
-- 
2.30.2

