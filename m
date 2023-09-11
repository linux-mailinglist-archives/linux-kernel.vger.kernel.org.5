Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0401979C1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjILBhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjILBgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:36:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AC150D07;
        Mon, 11 Sep 2023 16:49:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58fb8963617so49917987b3.3;
        Mon, 11 Sep 2023 16:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694476099; x=1695080899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXZWG/nA8iNczDldd6SjpWfFw/ABPHN8JU5LNr6qz3s=;
        b=kLJ2MN9OpGb/NemUrNokXi/UxN2oQKQ+opDVjm/kssPMm7ZpqATbViieq1uAajoJPN
         O6/VQh9ifUYwBokFoM9QdlCy57iyKYTksmcIcnWVDFj6gwVhVhES49DYKHF+7GSKPHIR
         IOHqbrLFi0gCwqg17dh8fHx6cc0M/mFBTgmexnjlSg28LnC4nXeVKkJsxy5bry0AlUCf
         1qxF6eNYKGerPLDqAjhettKP6fOmLwB8flV+BcHyaII6iT5Ky/bSa+/hZKxe0YcnYu97
         R6k2aS4p3tX3MYYIDMp379SPIz4bg5E8fawCChRZTzZw/JsoDt2O9if1qD2ZfQyENWJd
         4ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694476099; x=1695080899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXZWG/nA8iNczDldd6SjpWfFw/ABPHN8JU5LNr6qz3s=;
        b=dNXWjWB1P+XIK29BAReB3b203XrOeMXkDgrIB7qeg+NZQiI1EPpmZ/kEepOFdTZze5
         cbwus1+/0xlUu0AgJh/oCC7eAVARNoIGcnwUiSu2cmA4zObmoYA4S67KzO/W5IFRpZSr
         P7arin9eJq5yBNw8M4FmaV3sPkNaDdo389mot6JhfclwYsvj66RRv/B2d0uSR9UkWoNs
         Hkw7yD00Lp+RkxJ/zuI4vGZzpbuAhagiGFgH/T6FIZ6zeKxE4iI8/hL0mpqxwqh8UNzq
         5a/FjU/wW3Q7vkdTO9NqdO5dX3zTRUAK2I5sL7QvyuvNw1n3HIJYrEBelOMhUISEaPCV
         twBg==
X-Gm-Message-State: AOJu0YzC6dxTU/Uk4LRlHUOJ5QKBL206itNh8wfKSMJiw/WjHFYpldob
        Zld48v2fiH9PJFnswx6YcBEgmbpOI3+tiA==
X-Google-Smtp-Source: AGHT+IGY+Y9DO+vyrjnMRL7HVOugzwFjUd7HmRNBSMbrU8a8Upu6hXUK9+5a2CqGJ5tFV3wuipMVBQ==
X-Received: by 2002:a05:6602:388c:b0:798:2665:8939 with SMTP id br12-20020a056602388c00b0079826658939mr5726278iob.20.1694473741943;
        Mon, 11 Sep 2023 16:09:01 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:01 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 16/22] dyndbg-test: build it with just CONFIG_DYNAMIC_DEBUG_CORE
Date:   Mon, 11 Sep 2023 17:08:32 -0600
Message-ID: <20230911230838.14461-17-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
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

Make the test-module buildable with just CONFIG_DYNAMIC_DEBUG_CORE;
add CFLAGS_$ofile defns to supply -DDYNAMIC_DEBUG_MODULE to cc.
Change the Kconfig entry to allow building with just _CORE, and fix
the help text.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/Kconfig.debug | 10 +++++-----
 lib/Makefile      |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d6798513a8c2..a40bc9ab689a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2794,12 +2794,12 @@ config TEST_STATIC_KEYS
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
index 31195c75f5a0..943492d94771 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -239,6 +239,8 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
 CFLAGS_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug_submod.o := -DDYNAMIC_DEBUG_MODULE
 
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
-- 
2.41.0

