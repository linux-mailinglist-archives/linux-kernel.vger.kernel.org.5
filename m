Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E6C7C7732
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442598AbjJLTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442547AbjJLTrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7151CE3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fb78e297bso55715839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140048; x=1697744848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIhMRd3PEDx8wYJmsgE6KV38zHdcvoV+qxdam6F9QaA=;
        b=FC4QLyOJRlysc3HjghprjDJxMGT6XL9QQJ+XPhay431QhiHkI8nFNDJSCvOSvnoKkD
         RWRdaiYUWUmoq0SvkdN8ZlC58LdqR40fPH1Z5FnbDs/6pCgldwUU1rJpbBgvTKGycIf7
         SqRjZKqUg2ayv5mG9/cg57BWwO2vQRFJlSxxyvDEtb2RIWzrZ5kWhN7F7GqgntAb/U9V
         pfPwyxmBzpVt3HmqPfuSB4dq96KSDILE8AqTnEEsx6btjRGznX/IlRNQMJ3eVYQUZOp9
         PZ5cSOAZEkt1PQbaWH60iU1WJVTZfpj/ySWQZzXvc2P07e5wRbZgNJKLzwb4s8Y2teIr
         kcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140048; x=1697744848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIhMRd3PEDx8wYJmsgE6KV38zHdcvoV+qxdam6F9QaA=;
        b=jpfaxrEC25t9JAUnfXEhkmhWBfidO0xyjgWDe5tHu72yvYIwjpQSfeqjik4ZUdv+TG
         Ul8QhbAo3AbCYYCM4OWmw9ZuWRmiG7C051rrKphNp7l22IfpTCU35KSHwRkmywGbd4Q2
         DJRTbFqCaCOt0YGJjkqlUrczqK+Hq7RXmmAdq0lydMWQadszeSwcVzfIBej0a9CKq27f
         x+TVxRHh9B8EhhmnSKSRm3/nhRN1IWDYkWFNXNxzyBJS1sog5raVDZxtV1DrBhvgbrG1
         7734b6l47YplVIz1uC5fhwx57gvCwu5yJvP3QdfTr5LLjAjq5aMGK4Uz9dKFoumAhKAI
         FKww==
X-Gm-Message-State: AOJu0YzcS2CKFg8L1A1uHER6r78LinEsv67DKUizzl4fX2L8mB2hFsjo
        wKHeCF6LLyO8xOfFvby7m3VKAFMkDPlUow==
X-Google-Smtp-Source: AGHT+IHwXqweWhb1lxAAh/8nmrZo53I7KZ+f3cHS+05xFDAlJj11wM8cG2c9g1NHaGlPQ1kNha+MpQ==
X-Received: by 2002:a5e:de4a:0:b0:794:eb37:b0c4 with SMTP id e10-20020a5ede4a000000b00794eb37b0c4mr24029604ioq.21.1697140048511;
        Thu, 12 Oct 2023 12:47:28 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 07/10] dyndbg: wire in __desc_*() functions
Date:   Thu, 12 Oct 2023 13:47:08 -0600
Message-ID: <20231012194711.3288031-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194711.3288031-1-jim.cromie@gmail.com>
References: <20231012194711.3288031-1-jim.cromie@gmail.com>
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

change desc_*() macros to call __desc_*() functions, and #if 0 the
comparisons to the site->_* ref.  This makes the _ddebug.site pointer
unneccesary.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 48564625a37e..fb72a7b05b01 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -223,9 +223,9 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define desc_modname(d)		(d)->site->_modname
-#define desc_filename(d)	(d)->site->_filename
-#define desc_function(d)	(d)->site->_function
+#define desc_modname(d)		__desc_modname(d)
+#define desc_filename(d)	__desc_filename(d)
+#define desc_function(d)	__desc_function(d)
 /*
  * tmp accessors, they cheat and seek a match in builtins.  Obviously
  * this wont work for loaded modules, but doesnt work at all yet.
@@ -235,11 +235,11 @@ static const char * __desc_function(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_funcs;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_function(dp))
 		pr_err("mt-load func %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_function(dp));
-
+#endif
 	return ret;
 }
 
@@ -248,11 +248,11 @@ static const char * __desc_filename(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_files;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_filename(dp))
 		pr_err("mt-load file %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_filename(dp));
-
+#endif
 	return ret;
 }
 
@@ -261,11 +261,11 @@ static const char * __desc_modname(struct _ddebug const *dp)
 	struct maple_tree *mt = &mt_mods;
 
 	void *ret = mtree_load(mt, (unsigned long)dp);
-
+#if 0
 	if (ret != desc_modname(dp))
 		pr_err("mt-load mod %lx got %s want %s\n",
 		       (unsigned long)dp, (char*)ret, desc_modname(dp));
-
+#endif
 	return ret;
 }
 
@@ -1441,7 +1441,7 @@ static void ddebug_condense_sites(struct _ddebug_info *di)
 	i = 0;
 	for (; i < di->num_descs; i++, cur_dd++, cur_ds++) {
 
-		BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
+		//BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
 
 		if (!strcmp(site_function(cur_ds), site_function(func_ds)))
 			continue;
-- 
2.41.0

