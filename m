Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD6779D945
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjILS7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjILS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:59:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A312E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:59:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-795547f055fso200911739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694545187; x=1695149987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3NZo8yB4Jfzajn49o9YjW5WSHG9cyRLxTAyWN0qdE0=;
        b=VjkINM93RKKdGPUXJHi59k680JcJAZwmaotfEEZZAi1zsjpyAEvhom+F2Z54jLY7dQ
         zxicOUkaKA/NFG2A+TBYu/Owlss37j5oQqMryZvKrCIZADFu0IQdDN6fgv42/iHuu7m/
         33SKyWyGGQ22vmWxubMPSgdJPLBXcXdD1XTdygdAFQ/aoyzwtQQW944cifKk1Z/OIjRd
         FtV26nyJBJ6PWVEYOtfW/LuuQGo9lNm9UzA0rKDyi5AbbAgJrCyK8xREu4L6R1St9lmF
         MoSQA6iVygkL7l1ZMhABEgc7uXuLogomq7LblJufqAZbeXd7gK/jBQgRu4yNoeEpY+lq
         vBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694545187; x=1695149987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3NZo8yB4Jfzajn49o9YjW5WSHG9cyRLxTAyWN0qdE0=;
        b=dGE3kzhIjYmPAsvtSAdcSPvaekUN9z9hAErM8Mkx4yOTtyKZHEFU0ut1/2t0gUCHBY
         d8c9uj8OZ5HlvCtkRIr+SYV1hD2abMDtb0Tn4nIWEcmE94dRKXQ7VH7EyT1HriDQwAy6
         1s3LGgl49luoxZoWAlabjxExvt0sgNNeo94NQDserDNAUPaJOf7q5K9QLBJPzhnZoiuw
         7dfBMsKPRdjmCPaDn6yoYE3Rr7v4FL3KhQpp58WDalACLWCravCHKC14fJqTKYzbPoR3
         u4ROpJVtoS7mClzxV9pTIwNlnK4FuOcCtczo425vMp6ppCmVK80vRpChR/d0xBpHA6WV
         zt6g==
X-Gm-Message-State: AOJu0Yy4sJW8v5lhEDK09sG/MbWzw8KhT9eQbsMpeVYvPv131WKlTSx6
        zoNUMD/81qbtS2f6q05FziQIIvHFaIE=
X-Google-Smtp-Source: AGHT+IGqUpaSFVuLueME2TmsqXvWGi49gScsoX8Nm0B2YTv6qpsFxaHE15W/FNGLh28+djKYYVFeCQ==
X-Received: by 2002:a6b:fe14:0:b0:785:ff35:f340 with SMTP id x20-20020a6bfe14000000b00785ff35f340mr772843ioh.14.1694545187004;
        Tue, 12 Sep 2023 11:59:47 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id u9-20020a5ec009000000b00791e6ae3aa4sm3041124iol.23.2023.09.12.11.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:59:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        jbaron@akamai.com
Subject: [RFC PATCH 1/1] dyndbg: WIP stuff _ddebug.{modname,filenam,function} into maple-tree
Date:   Tue, 12 Sep 2023 12:59:39 -0600
Message-ID: <20230912185939.204084-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dyndbg section, a struct _ddebug[], has 3 columns with
substantial repetition: modname, filename, function, with ~90%, ~90%,
40% each, in the builtin table.

This is hierarchically organized; modame spans 1 or more filenames,
each of which spans many functions, which may have many lines/
callsites.

1/2 baked WAG:

ISTM these nested intervals could be carefully packed into a
maple-tree, and efficiently retrieved.

The tree would be basically read-only for the pr-debugs in builtin
modules, its presumed virtue here is primarily size, speed is bonus.

If that worked, it would be trivial to segregate those _ddebug columns
to another struct, copy the intervals into the tree, then reclaim the
whole section.

I'm not sure how nesting might work.  I added the MT_FLAGS_ALLOC_RANGE
flag, thinking maybe I could stuff the nested interval starters (each
distinct function, filename, modname) into the internal RANGE
containing nodes.

So this adds a dd_mt_sites maple-tree, and does 2 things to it:

1- in dynamic_debug_init(), mtree_store_range() on the module's block
of prdbg descriptors, just before calling ddebug_add_module().

2- ddebug_add_module() calls new fn: intervalize_descs(), to scan the
prdbg descriptors, and do mtree_insert() to save each new module,
filename, or function found.

2 probably makes 1 unnecessary, we shall see.

2 happens before 1, though order shouldnt matter, since insert index
does.  intervalize_descs() inserts at index: &descriptor - N, where N
is 1,2,3 for function,filename,modname respectively.

this is intervalize_descs() in action:

[    1.506878] dyndbg: add-module: kobject 10 sites 0.0
[    1.507383] dyndbg:  modname: kobject
[    1.507763] dyndbg:  filename: lib/kobject.c
[    1.507877] dyndbg:  function: kset_release
[    1.508305] dyndbg:  function: dynamic_kobj_release
[    1.508803] dyndbg:  function: kobject_cleanup
[    1.508880] dyndbg:  function: __kobject_del
[    1.509313] dyndbg:  function: kobject_add_internal
[    1.509817] dyndbg:  function: fill_kobj_path
[    1.509882] dyndbg:  10 debug prints in module kobject

That top-down ordering is mostly preserved at test-mod's do_print
traversal of dd_mt_sites.

Whats weird here is that lines 0-309 are the builtins, and for some
reason dont have the inserts of filename and function.  Lines 310
start the modprobed modules, and these include the inserts.  I dont
know why..

[  438.156488] test_dd:   303: mptcp
[  438.156713] test_dd:   304: i386
[  438.156926] test_dd:   305: xen
[  438.157133] test_dd:   306: fixup
[  438.157354] test_dd:   307: irq
[  438.157561] test_dd:   308: decompress
[  438.157808] test_dd:   309: kobject
[  438.158035] test_dd:   310: i2c_piix4
[  438.158282] test_dd:   311: drivers/i2c/busses/i2c-piix4.c
[  438.158637] test_dd:   312: piix4_transaction
[  438.158929] test_dd:   313: piix4_setup_aux
[  438.159207] test_dd:   314: piix4_setup_sb800
[  438.159507] test_dd:   315: piix4_setup
[  438.159769] test_dd:   316: serio_raw
[  438.160018] test_dd:   317: drivers/input/serio/serio_raw.c
[  438.160394] test_dd:   318: serio_raw_reconnect
[  438.160700] test_dd:   319: serio_raw_connect
[  438.161002] test_dd:   320: intel_rapl_common
[  438.161303] test_dd:   321: drivers/powercap/intel_rapl_common.c
[  438.161697] test_dd:   322: rapl_remove_package
[  438.162007] test_dd:   323: rapl_detect_domains
[  438.162412] test_dd:   324: rapl_package_register_powercap
[  438.163008] test_dd:   325: rapl_update_domain_data
[  438.163383] test_dd:   326: rapl_check_unit_tpmi
[  438.163696] test_dd:   327: rapl_check_unit_atom
[  438.164009] test_dd:   328: rapl_check_unit_core
[  438.164333] test_dd:   329: rapl_read_data_raw
[  438.164634] test_dd:   330: contraint_to_pl
[  438.164922] test_dd:   331: intel_rapl_msr
[  438.165199] test_dd:   332: drivers/powercap/intel_rapl_msr.c
[  438.165594] test_dd:   333: rapl_msr_probe
[  438.165875] test_dd:   334: rapl_msr_read_raw
[  438.166162] test_dd:   335: test_dynamic_debug
[  438.166468] test_dd:   336: lib/test_dynamic_debug.c
[  438.166800] test_dd:   337: test_dynamic_debug_exit
[  438.167127] test_dd:   338: test_dynamic_debug_init
[  438.167463] test_dd:   339: do_prints
[  438.167716] test_dd:   340: do_levels
[  438.167965] test_dd:   341: do_cats
[  438.168200] test_dd:   342: test_dynamic_debug_submod
[  438.168549] test_dd:   343: lib/test_dynamic_debug.c
[  438.168890] test_dd:   344: test_dynamic_debug_exit
[  438.169221] test_dd:   345: test_dynamic_debug_init
[  438.169559] test_dd:   346: do_prints
[  438.169810] test_dd:   347: do_levels
[  438.170058] test_dd:   348: do_cats
did do_prints

Then magically, an augmented _find would return a vector of modname,
filename, function when needed.  Or maybe a sequence of calls to
mtree_find_upper_range() could collect the internal node values of the
nested intervals {module, filename, function} a descriptor is part of.

And thats about where the souffle collapses.

Any suggestions ?

And how to get the maple-tree size ?

cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: linux-mm@kvack.org
Cc: jbaron@akamai.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c      | 44 ++++++++++++++++++++++++++++++++++++++++
 lib/test_dynamic_debug.c | 16 +++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a5fe37d2bd01..4cfada8b506b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -25,6 +25,9 @@
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
+
+#include <linux/maple_tree.h>
+
 #include <linux/parser.h>
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
@@ -74,6 +77,10 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+/* try packing site info into a tree */
+struct maple_tree dd_mt_sites;
+EXPORT_SYMBOL(dd_mt_sites);
+
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -1302,6 +1309,36 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	vpr_dt_info(dt, "attach-client-module: ");
 }
 
+static void intervalize_descs(struct _ddebug_info *di)
+{
+	struct _ddebug *dp;
+	char *mod, *src, *fn;
+	int i;
+
+	mod = src = fn = "";
+	for_each_boxed_vector(di, descs, num_descs, i, dp) {
+
+		if (strcmp(mod, dp->modname)) {
+			v3pr_info(" modname: %s\n", dp->modname);
+			mod = dp->modname;
+			mtree_insert(&dd_mt_sites, (unsigned long)dp - 3,
+				     (void*)mod, GFP_KERNEL);
+		}
+		if (strcmp(src, dp->filename)) {
+			v3pr_info(" filename: %s\n", dp->filename);
+			src = dp->filename;
+			mtree_insert(&dd_mt_sites, (unsigned long)dp - 2,
+				     (void*)src, GFP_KERNEL);
+		}
+		if (strcmp(fn, dp->function)) {
+			v3pr_info(" function: %s\n", dp->function);
+			fn = dp->function;
+			mtree_insert(&dd_mt_sites, (unsigned long)dp - 1,
+				     (void*)fn, GFP_KERNEL);
+		}
+	}
+}
+
 /*
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
@@ -1332,6 +1369,8 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->ddebugs = di->descs;
 	dt->num_ddebugs = di->num_descs;
 
+	intervalize_descs(di);
+
 	INIT_LIST_HEAD(&dt->link);
 
 	mutex_lock(&ddebug_lock);
@@ -1507,6 +1546,8 @@ static int __init dynamic_debug_init(void)
 	}
 #endif /* CONFIG_MODULES */
 
+	mt_init_flags(&dd_mt_sites, MT_FLAGS_ALLOC_RANGE);
+
 	if (&__start___dyndbg == &__stop___dyndbg) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1531,6 +1572,9 @@ static int __init dynamic_debug_init(void)
 			if (ret)
 				goto out_err;
 
+			mtree_store_range(&dd_mt_sites, (unsigned long) iter_mod_start,
+					  (unsigned long) iter, (void*) modname, GFP_KERNEL);
+
 			mod_sites = 0;
 			modname = iter->modname;
 			iter_mod_start = iter;
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 84e049c07e77..37de3fdc2bb8 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -14,6 +14,7 @@
 #endif
 
 #include <linux/module.h>
+#include <linux/maple_tree.h>
 
 /* re-gen output by reading or writing sysfs node: do_prints */
 
@@ -150,11 +151,26 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
+extern struct maple_tree dd_mt_sites;
+
+static void do_dd_mt_scan(void)
+{
+	long unsigned int idx;
+	void * ent;
+	int ct = 0;
+
+	mt_for_each(&dd_mt_sites, ent, idx, -1) {
+		pr_info("  %d: %s\n", ct, (char*) ent);
+		ct++;
+	}
+}
+
 static void do_prints(void)
 {
 	pr_debug("do_prints:\n");
 	do_cats();
 	do_levels();
+	do_dd_mt_scan();
 }
 
 static int __init test_dynamic_debug_init(void)
-- 
2.41.0

