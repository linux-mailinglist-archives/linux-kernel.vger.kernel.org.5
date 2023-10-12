Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79897C7730
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442637AbjJLTrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442412AbjJLTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:47:29 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD8DA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:27 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa2dbd793so56869439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140046; x=1697744846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdFWb7R/lDvUnWmGrNZ1doFLmbR1Cvf7k7ETF/HiAfA=;
        b=aAyPZf4aITbV46VAzmJnxmgzIjkI7iFozBrX1LhNMd9PX9qpy7KksZMuOs8Gxafz2A
         zOWJHiVTEfNMS5WSLsehJCAj/eTHsgpsg9xBes8oUP0EheYmrKUyanyJkjWk/05S+JgQ
         4I4RkgO/1erEBkb5IsfpFGlrnNIEJO45sgeWbs7qq19GRQWgQVo823XBuI9HqHF5Besl
         Zsg/cBq9OGuSFGWNdFPVlsDP9INtQTIL43fd9JawBUiWDzQHQDNuE8OW4xWulZJ5/Rec
         90LAWnQOkjj5IScBobpIZzvT/0zVlY7XQPWMz9XL5NW2iJqBD4qcAeksk3AwBdUANZuJ
         nsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140046; x=1697744846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdFWb7R/lDvUnWmGrNZ1doFLmbR1Cvf7k7ETF/HiAfA=;
        b=iTN2m6uafHNcwaXncD4NopbWXU9gNJSUR1JtGr+WbUJUgXeeZHOaSaX5FjGz8k7ZxW
         PJOaJ+27nM5YMiLRygCp0N4vmCcSR/YnDbZXi4kycUZw26EtEZ8mN/ytwU6Ard3L+y+m
         NGZ8uv0ANEok/heu7oljIWKCHGSxnGOGlec0VwrtH7GH7CtYNGLvTe+NtniXGdih05F1
         +veBbMmoPWbXhS1T/duiTbBOsGShz1wIB12tgyXyDyzzFODpTZjJBIPFwXADhP+3dHKD
         ZWIGR/KXKrGpWwe5fcybMB8SHB5Nz2JJvq0AsxsnZERKS0JAFSK58Wtnbs7ej9yfnJfp
         gO5g==
X-Gm-Message-State: AOJu0Yzo8H0jsUE6c/qeMy/XPk7dD9cRgoFST+3DzjURTe7+nlykInKj
        AOp0SvRFksTT5iCemGrYFMYQBQdO6/c4Pg==
X-Google-Smtp-Source: AGHT+IH0UOfRQ4ikz9Hk4rM8RmqNySf3YxcTrIhFIo+68DbLkG/CP9qB7HHORAuGhOuprlMeJ8JdHQ==
X-Received: by 2002:a05:6602:2012:b0:787:1568:5df7 with SMTP id y18-20020a056602201200b0078715685df7mr27961322iod.9.1697140046416;
        Thu, 12 Oct 2023 12:47:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z7-20020a5ec907000000b0079fbb834232sm4351002iol.19.2023.10.12.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:47:25 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     david@redhat.com, Liam.Howlett@Oracle.com, linux-mm@kvack.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 05/10] dyndbg: avoid _ddebug.site in ddebug_condense_sites
Date:   Thu, 12 Oct 2023 13:47:06 -0600
Message-ID: <20231012194711.3288031-6-jim.cromie@gmail.com>
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

Modify the for-loop in ddebug_condense_sites() to walk thru both
vectors: descs, sites in parallel.

This requires a 2nd set of cursor variables (*_ds) that mark the
start-of-range in the sites vector for the intervals to be
dd_store_range()d.  So also rename the old cursors (*_dd) for better
consistency and readability.

This is a partial step.  It still uses the desc_*() macros to provide
the values, and the macros use the site pointer.  Next, we replace the
macros with site_*(), passing the *_ds vars.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3dc17922a1d1..563d373224ba 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1426,32 +1426,41 @@ static void dd_store_range(struct maple_tree *mt, const struct _ddebug *start,
 		v4pr_info("  ok %s at %lx\n", val, first);
 }
 
+
 static void ddebug_condense_sites(struct _ddebug_info *di)
 {
-	struct _ddebug *cur, *funcp, *filep, *modp;
+	struct _ddebug_site *cur_ds, *func_ds, *file_ds, *mod_ds;
+	struct _ddebug      *cur_dd, *func_dd, *file_dd, *mod_dd;
 	int i;
 
-	funcp = filep = modp = di->descs;
-	for_each_boxed_vector(di, descs, num_descs, i, cur) {
+	cur_dd = func_dd = file_dd = mod_dd = di->descs;
+	cur_ds = func_ds = file_ds = mod_ds = di->sites;
+	i = 0;
+	for (; i < di->num_descs; i++, cur_dd++, cur_ds++) {
+
+		BUG_ON(site_function(cur_ds) != desc_function(cur_dd));
 
-		if (!strcmp(desc_function(cur), desc_function(funcp)))
+		if (!strcmp(desc_function(cur_dd), desc_function(func_dd)))
 			continue;
-		dd_store_range(&mt_funcs, funcp, cur, "func", desc_function(funcp));
-		funcp = cur;
+		dd_store_range(&mt_funcs, func_dd, cur_dd, "func", desc_function(func_dd));
+		func_dd = cur_dd;
+		func_ds = cur_ds;
 
-		if (!strcmp(desc_filename(cur), desc_filename(filep)))
+		if (!strcmp(desc_filename(cur_dd), desc_filename(file_dd)))
 			continue;
-		dd_store_range(&mt_files, filep, cur, "file", desc_filename(filep));
-		filep = cur;
+		dd_store_range(&mt_files, file_dd, cur_dd, "file", desc_filename(file_dd));
+		file_dd = cur_dd;
+		file_ds = cur_ds;
 
-		if (!strcmp(desc_modname(cur), desc_modname(modp)))
+		if (!strcmp(desc_modname(cur_dd), desc_modname(mod_dd)))
 			continue;
-		dd_store_range(&mt_mods, modp, cur, "mod", desc_modname(modp));
-		modp = cur;
+		dd_store_range(&mt_mods, mod_dd, cur_dd, "mod", desc_modname(mod_dd));
+		mod_dd = cur_dd;
+		mod_ds = cur_ds;
 	}
-	dd_store_range(&mt_funcs, funcp, cur, "func:", desc_function(funcp));
-	dd_store_range(&mt_files, filep, cur, "file:", desc_filename(filep));
-	dd_store_range(&mt_mods, modp, cur, "mod:", desc_modname(modp));
+	dd_store_range(&mt_funcs, func_dd, cur_dd, "func:", desc_function(func_dd));
+	dd_store_range(&mt_files, file_dd, cur_dd, "file:", desc_filename(file_dd));
+	dd_store_range(&mt_mods, mod_dd, cur_dd, "mod:", desc_modname(mod_dd));
 }
 
 /*
-- 
2.41.0

