Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E57C90C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJMWtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjJMWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72F112;
        Fri, 13 Oct 2023 15:48:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35749078a59so9752005ab.3;
        Fri, 13 Oct 2023 15:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237324; x=1697842124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=T5B3lqmrSz3HZTe4mwtayPTRDvSlo/hmCogGPiFwtaP2aGtwjP3ZPS7+RCLMAApMdj
         ofBhkukl7aiMtSem0t6IFG63mqkeDcJbBY7U36U9oDSYhWNoTGumFJ79aRqyOFUqeMZk
         +nPC+sGPgx4VlRFFpHf2ZpJQAlK2K5MDZxofvYq3WmuUmacx94R7ZaFH//+Ya7wULiZw
         9zeJnPDzVWAvgLPpbT4JgCI8whf5frl1NkE0adQlGd5NehVzuMHb6+of3IWoR7cj62Wh
         OJ0gxfz5iENV+HEBctPcfaWoh/ntLx+w8WDlB3HQsBRweMe6Tvr/r0JmE/KvCb1u87z7
         axpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237324; x=1697842124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=lLwp0CjFLBN4GNZDffO3JEgMAysqd7+zyR7fIpz+QoPMXbmggVFF8+8tvkPJaQt3ga
         E9T4TdszuR8LdYY+vqfSwAu8yTluKEqOHZDhg+7S0C6OH+ysomd6gU8k/ruZhddVWE1T
         sviBwgy1pYU3PAOQ9TtulYli9r/RuGhyqzPMdGzTstxb9SIASnESG19IjlpE3QqBz2no
         OV0qI1wtdshnfJyT762nI9NJAGkeV+u7gJnzwIuu49zNvSL2QwU6cR+wh/SKVWfdJhOf
         PNJ/ZxoMQ1s7RPPyKAGlbdJ5p51nfipG2PtoRNjrbKE5EYZTk1GT4+R+K1bJEkr5IrQ4
         sr3w==
X-Gm-Message-State: AOJu0YytZomtng6sMqYN+UVJTd7HdneaWA6GzfOkvHszgLBxuHFD6LXA
        6iQcSGARaLEdFYNkc/bPc1JM9P8xazKk+w==
X-Google-Smtp-Source: AGHT+IHQw2wXhC/2oHYIYAGyvyYiqI1YXiorq4KT58Qv5KODmOPOVfx0/unPtKoAepPcMV4mVMSdQQ==
X-Received: by 2002:a92:c56b:0:b0:34f:f5a4:3e68 with SMTP id b11-20020a92c56b000000b0034ff5a43e68mr37534070ilj.30.1697237323880;
        Fri, 13 Oct 2023 15:48:43 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:43 -0700 (PDT)
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
Subject: [PATCH v7b 12/25] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date:   Fri, 13 Oct 2023 16:48:04 -0600
Message-ID: <20231013224818.3456409-13-jim.cromie@gmail.com>
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

The fn currently says "add-module", then "skipping" if the module has
no prdbgs.  Just check 1st and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8beb98a831f5..45870a699507 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1242,11 +1242,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.41.0

