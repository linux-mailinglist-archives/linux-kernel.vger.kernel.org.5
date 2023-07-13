Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7322D7528E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjGMQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjGMQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:23 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43237273E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:02 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso3965105ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266221; x=1691858221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH1hoS5TyoLcmhyYV0xYU1iuMulIPyQc9Z8crXbpYkA=;
        b=dZjKH4hnSpuZ3DTO53o8QKHq0NPNvgYYxlgFp+7pfxVeTTVJHEVyQ+GHQf1R2RPDaG
         dfhJXbMmM9lCQBqsbp+aZqUw4vI54B6tqh7xWJsWp5O+MP1w+ng43Y7IhhTmUj2vFYcb
         Zg2qdshNds5TRWuzHH4Xbe8bq//a2I+qyIjgPTCZIH3CBqFoog97LPA90mgd0eQ7ASyR
         VgIBqaaFrBIFK7Lcg4rEoDOwxLSBP/tdYc2QAnNSfpCSAFt4ozhZPsoD1JrcQgCP+jEI
         OfotqOaBQOSUkrlOLm1b+x/cQI0TxB7x+dsBsQ3sR76vievwTLn9ayR4KOLj8WFRJ4gu
         yJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266221; x=1691858221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH1hoS5TyoLcmhyYV0xYU1iuMulIPyQc9Z8crXbpYkA=;
        b=kDc9M4nmcqpM4jkT5h+O/PvZjsuOaRVwSExp19lvBk+FKXuBozo2E1GmIzJTpIqHCa
         qy3Qmsufepq/9doOCmJAje7vtsvs8f8IF6vWIccCWWWFB4sfKfG9guTDAoWxlrsVQweU
         eZeAr1PpuL2Id7TySQIQ64vtbyp5MAaMl4Capxp/FIun6J0msI/+V5S1T+r4XXbWOHbl
         7XwO7VVLMFgdEBp6cDCuj8mEu25O/kth+BDedqQePFUyP1NZjnDIsBGGywT9Zrf8YX9/
         /5bkB38JVnNGRFKkI23ccLe4GUHyEcDx3Z/YmJtWCwUjzrlEUV1mQp9+Mo901OTHac4t
         DgWQ==
X-Gm-Message-State: ABy/qLYqCwTySEavVq0qaoNqILZAHfzqb3sReZKf0T5tGvuJHqYGnZrU
        R0U8B77GHFqNjdWzWsiNmaQ=
X-Google-Smtp-Source: APBJJlFvBLi5hEov/kmv/k83zFFm7u/g7LY7tseK/2jtSQtpfiGSFRnCP0gXT9Lmz2F8s2b9Ib2K7w==
X-Received: by 2002:a92:c803:0:b0:346:59a1:ce35 with SMTP id v3-20020a92c803000000b0034659a1ce35mr2334271iln.6.1689266221643;
        Thu, 13 Jul 2023 09:37:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 16/21] dyndbg-test: make it build with just CONFIG_DYNAMIC_DEBUG_CORE
Date:   Thu, 13 Jul 2023 10:36:21 -0600
Message-ID: <20230713163626.31338-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the 2 test modules buildable with CONFIG_DYNAMIC_DEBUG_CORE,
add CFLAGS_$ofile defns to supply -DDYNAMIC_DEBUG_MODULE to cc.
And change the Kconfig entry to allow building with just _CORE.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 10 +++++-----
 lib/Makefile      |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..d4fbbcc395d2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2695,12 +2695,12 @@ config TEST_STATIC_KEYS
 	  If unsure, say N.
 
 config TEST_DYNAMIC_DEBUG
-	tristate "Test DYNAMIC_DEBUG"
-	depends on DYNAMIC_DEBUG
+	tristate "Build test-dynamic-debug module"
+	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	help
-	  This module registers a tracer callback to count enabled
-	  pr_debugs in a 'do_debugging' function, then alters their
-	  enablements, calls the function, and compares counts.
+	  This module works/demo's the dyndbg's classmap API, by
+	  creating 2 classes: a DISJOINT classmap (like DRM.debug)
+	  and a LEVELS/VERBOSE classmap (where 2>1).
 
 	  If unsure, say N.
 
diff --git a/lib/Makefile b/lib/Makefile
index f36048371dd2..8411015a57c1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -233,6 +233,8 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
 CFLAGS_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug_submod.o := -DDYNAMIC_DEBUG_MODULE
 
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
-- 
2.41.0

