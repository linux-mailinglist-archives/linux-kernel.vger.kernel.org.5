Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3757C9105
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJMWuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjJMWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:49:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69EA122;
        Fri, 13 Oct 2023 15:48:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3528bc102adso9321425ab.2;
        Fri, 13 Oct 2023 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237334; x=1697842134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdhZKvxYwXdkWkdLVl73JQfyJJ5FbxfJO6rydQUwjqs=;
        b=fkCgiM1qHGJeYwxsBCWruuxcsveP966l3+Fbdau9D1xmWPuOIIjfnud/a3R2w86XaD
         rIVAH9jSotzJ0ZJyLtvm7oU5mhuRrtcSelBBW/YT7hFTI2Ed2bKxoSJZPTbHfANihyI7
         fSuU2dj2fzOHQpkBCczo9LqVeBCiBiudSunMoiRjBqiIgeiQhBqkhZmW+TY+CA+EMe2L
         lZCo5F2pbax68ZKHUMNsiFFBKt92zGCqCwxZ4wS8PhpckISWoAxmLeG3ny8q6iAs1NPF
         B0hO+ZdSXyP5E6wWfZBPnGCCSbAsXW0pJ195AzhxsGbLtYOV8k/j5voJ74WImEsqFTzF
         K+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237334; x=1697842134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdhZKvxYwXdkWkdLVl73JQfyJJ5FbxfJO6rydQUwjqs=;
        b=ZEAqthY9WBdy7DzSFmB9/jr9wNkTaaRBlrTaCo/E9wMSnePhFKf848qJEySHYzejSO
         FFGeAsIksle9xTj2vGQ9k8cuI9MxLoatu3fOXM7uxJeuA97vn4o+6rGhvKp0w25mspGC
         N1IRt8YrqThdEsu9Xwzt4b+gN2+5r4F/Il9XUaw23W1fRHOFSPth1lqfhFh2xEo52Ei0
         /2OHyM+GUZ6C2wvfwjQdmkrZ6Wi1Irs+UZzqgMbRhpOpusJTpOxuTkC3ssPk+jIaa5wh
         XoJ6I+0bMUWdrZ5QVxueUYW+VyafrGEEzVXCkImQf+Ia8uNKh2w60qC4LJg2FeXCbOHe
         fq1A==
X-Gm-Message-State: AOJu0Yy2+RPyd+3iBUEk4RnzmjRmL6r4p0iFFEnsGr7SjHQHgw9k7bq2
        7yCHgj0j6IpfzLxHeTU7R4znsR/Kvmgvjg==
X-Google-Smtp-Source: AGHT+IF3D17mL6y2d13cwyIjmP3+07yGtwbO19SBlnOyYbqXK1NWwD4Cm7hxH5ll2GZm/mnKj3kEZg==
X-Received: by 2002:a05:6e02:1c28:b0:34b:ba9f:679c with SMTP id m8-20020a056e021c2800b0034bba9f679cmr37397493ilh.16.1697237334576;
        Fri, 13 Oct 2023 15:48:54 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 20/25] dyndbg: add _DPRINTK_FLAGS_INCL_LOOKUP
Date:   Fri, 13 Oct 2023 16:48:12 -0600
Message-ID: <20231013224818.3456409-21-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
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

dyndbg's dynamic prefixing (by +tmfsl flags) is needlessly expensive.

When an enabled (with +p) pr_debug is called, _DPRINTK_FLAGS_INCL_ANY
prefix decorations are sprintf'd into stack-mem for every call.

This string (or part of it) could be cached once its 1st generated,
and retrieved thereafter, as long as its deleted any time the
callsite's flags are changed afterwards.

So consider the prefix/decoration flags: 'tmfsl', and what should be
in the cache:

-t  thread-id. not part of the "callsite" info, derived from current.
    doesn't belong in the cache. it would be wrong.
    can be done in outer: dynamic_emit_prefix()

-l  line number
    this could be part of the prefix, but would bloat the cache
    can also be done in outer: dynamic_emit_prefix()

-mfs  module, function, source-file
    we cache these, composed into a sub-string.
    they are "lookups", currently to descriptor fields,
    could be accessor macros to "compressed" tables.
    cache saves more access work.

All enabled together, they compose a prefix string like:

  # outer   -----inner----------   outer
  "[tid] module:function:sourcfile:line: "

So this patch extracts _DPRINTK_FLAGS_INCL_LOOKUP macro out of
_DPRINTK_FLAGS_INCL_ANY macro, then redefs latter.

Next re-refactor dynamic_emit_prefix inner/outer fns accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 927cb14f24e0..2237d454bc19 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,10 +40,12 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
 #define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
-#define _DPRINTK_FLAGS_INCL_ANY		\
-	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
+#define _DPRINTK_FLAGS_INCL_LOOKUP					\
+	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |	\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
+#define _DPRINTK_FLAGS_INCL_ANY						\
+	(_DPRINTK_FLAGS_INCL_LINENO | _DPRINTK_FLAGS_INCL_TID |		\
+	 _DPRINTK_FLAGS_INCL_LOOKUP)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
-- 
2.41.0

