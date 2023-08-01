Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3E76BAB8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjHARFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjHAREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB252D48
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:04:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbff6b2679so19331865ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909421; x=1691514221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqTzNELHRtLIMmnQe4IjBi2Pg9cHOtSAwPPFPZ1pbxQ=;
        b=DqQYslUARFkvpK1vwVZZmKxOQSYTZOhPIzf+014DE3xPfhfS2z+eEgQ2Epz5O3LqlA
         7BOeyJeELxsdiat2q/p9KY1PIpat7Bk7pEvC6Ty1ZpzBoRp85q9IxWo9qhfE6I1W6YZo
         DRCR18HwB4rx8quTql2hLfzZceDC1weH0j/72kCqR37ctCKr0kWMjb4fokiTaun7U0NI
         ifhA5ukAVoD8lQ9AzK56Bg1n46jA5c65QerE/eKK9kwfTF4SaPIcTUX5ocUwF2M8vgO+
         DvPikXjIaYxXAQfX+Q3HGflzXFkCWuzsBgtzfzdOM/SOTKlVv17KwOY4cg+v3458AB2Q
         y3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909421; x=1691514221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqTzNELHRtLIMmnQe4IjBi2Pg9cHOtSAwPPFPZ1pbxQ=;
        b=eqbTi1c8zM6nJbruFvvpf2G4lNeQm6OFf7Npfw08W4P2NPeKULt9y87xrmPASrrWYM
         +QpPQbyjh+W72MDTROw3wU7QRdqgBpMCGDkmKrDFfg49ta94C7VgwNLhBJzxxDwcp3QA
         varSkPCofYH16gbko/JmC9/9qNwyjcVhBIa409ep165IkFLUY85X3b31FVA9KdBE5d6b
         a2lAKf6RyiezPO2IsJQL1EenOyUxGE3MAee64wHL8yp4RP8W8CtXayJVs0dReWcbH09D
         icIFFsk7PMaEb50cDfslv40myuxNqvMegOr3c9pglqM2YR0vNybRUukyLuX2SEeD0Dke
         6KKw==
X-Gm-Message-State: ABy/qLZytPjUvx3YlyZZJUqzmyrORFqX8m906lr3OnGd7sJYgsn2tVVU
        VLDasAV4Q1/ZWOd77bP8a28=
X-Google-Smtp-Source: APBJJlGBC/pkTqfaofa3HRqJHDYvxiYCmGJoY97jdUvLmblEt0DaAuSeyNfKmxlve04DiaFeZ/p56A==
X-Received: by 2002:a17:902:700c:b0:1bc:2036:2219 with SMTP id y12-20020a170902700c00b001bc20362219mr3106819plk.41.1690909420776;
        Tue, 01 Aug 2023 10:03:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:40 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 18/22] dyndbg-test: build it with just CONFIG_DYNAMIC_DEBUG_CORE
Date:   Tue,  1 Aug 2023 11:02:51 -0600
Message-ID: <20230801170255.163237-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801170255.163237-1-jim.cromie@gmail.com>
References: <20230801170255.163237-1-jim.cromie@gmail.com>
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

Make the test-module buildable with CONFIG_DYNAMIC_DEBUG_CORE; add
CFLAGS_$ofile defns to supply -DDYNAMIC_DEBUG_MODULE to cc.  Change
the Kconfig entry to allow building with just _CORE, and fix the help
text.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 10 +++++-----
 lib/Makefile      |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..22e022ceb9a1 100644
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
+	  and a LEVELS/VERBOSE classmap (like verbose2 > verbose1).
 
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

