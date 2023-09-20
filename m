Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8647A7B28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjITLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjITLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:49:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A490DD6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:49:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-274736d0f64so3972124a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695210567; x=1695815367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/8PZWUPuda+ZQQwAeWfXpYiv/2viHxcEiF7//a7Xh4=;
        b=U4c4BOHINgPedw1tFVd0+EZ/3zi4+7jCY6/nPswZz6RvJ5vsFyCS1bk+nE7FWsWOfl
         o+Qmj5BTgpByodjXiBOfPm1SkCWAHTjW4qV7IOaxCOtTpHraCATV5XcYP7x7ZOp7U5Er
         ApdP8JC2p18JF41Wu3uxCPkmeHqZ2TFbctbfnZzdzFY0npuHNimq8aNZ9FA1tepl0y4V
         HAxWaXXA7PPSe8xH6BUn5y0P6eUd+O9GLfHh4/0uWpkZ+ymGLo8k1fl5TWV6eAQv+WKC
         sCrIlTsBYbqctZhkgGycAv2aLkEIFnv+yMIPYSX3rRyx1VbNeFPuY8ac5wh+n4lnwuQW
         g+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695210567; x=1695815367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/8PZWUPuda+ZQQwAeWfXpYiv/2viHxcEiF7//a7Xh4=;
        b=RFY3XZojrm7M1LKgMXXmcFDooZ60L3yyiRUZAoa9MCjgiDRSybx+mOtIM30xln2Kub
         9eZ/oJ9906nQLcM65ViN7X5JpzQ0qQCyrMDwWnpdfaFztv9+eYus7IKeF+crRD4XVXHu
         PegKIfY747RowsIrMZgWjQJA0+64qH7v/mMlbSTv03JmUlVJydXwRKb9YIsWExzJMJYk
         xcfXhI38vWQbIq9sw6fYGLR1t6jILvov6bijTnC7bWjqnYbgk9pGy/exOYkjnqIiR3l5
         JX1UBu4it4hM4y/BUG3Mkzx2XBpFUHbe8JkipcTPrBfdJiDk+ZqqIWTQiOuI0QFsCAV6
         Si0A==
X-Gm-Message-State: AOJu0Yy0gNHLlDSs04MaKvjk6GtuUMfvfoPC8kn3XCeiAqrCH8bkvVQQ
        JHj0EF9VPn62VVwZWSi93kLMkWQLaBo=
X-Google-Smtp-Source: AGHT+IFmzx3xf+hs33ILf5/gTMht1n0M1UHToe+04qf6B7SAq9QVz1gAXVPonqfUruHj2JnwYwuugw==
X-Received: by 2002:a17:90a:ce96:b0:26d:2ae0:9b63 with SMTP id g22-20020a17090ace9600b0026d2ae09b63mr2390425pju.16.1695210566731;
        Wed, 20 Sep 2023 04:49:26 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:9ca3:318f:421e:68cb])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a458900b00274c541ac9esm1180511pjg.48.2023.09.20.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:49:25 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] xtensa: add default definition for XCHAL_HAVE_DIV32
Date:   Wed, 20 Sep 2023 04:49:12 -0700
Message-Id: <20230920114912.2793258-1-jcmvbkbc@gmail.com>
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

When variant FSF is set, XCHAL_HAVE_DIV32 is not defined. Add default
definition for that macro to prevent build warnings:

arch/xtensa/lib/divsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32
arch/xtensa/lib/modsi3.S:9:5: warning: "XCHAL_HAVE_DIV32" is not defined, evaluates to 0 [-Wundef]
    9 | #if XCHAL_HAVE_DIV32

Fixes: 173d6681380a ("xtensa: remove extra header files")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202309150556.t0yCdv3g-lkp@intel.com
---
 arch/xtensa/include/asm/core.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index 3f5ffae89b58..6f02f6f21890 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
-- 
2.30.2

