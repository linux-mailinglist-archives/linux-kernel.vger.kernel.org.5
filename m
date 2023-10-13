Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E027C7C90F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjJMWtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjJMWt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:49:26 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782B1A1;
        Fri, 13 Oct 2023 15:48:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3574f99d260so9971015ab.3;
        Fri, 13 Oct 2023 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237328; x=1697842128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXsSOg8f2yCgJEL2pCIM6ReAyW7r5JJg4FpT0/i3350=;
        b=K765wMgCqbEjZAKtUlWjVfrGv1zh7n8FRW5t3kE+vLK7fLyyJiISbUBerhe769f6p7
         J3KMN/PNX3Rid62XhH9prP/fo1qNx0cy9G/Z0sZaiNpTNzq+lTupVHhonkNF2ErDxUH8
         1ZWdtTkWUNBWOt5SF0WuBKEkN2SAIVrynPdBAmbo1m2wE3ZNZH4xlZVYiKa1a+W/SVWZ
         XYBBPaBooEaH/Dd5NaZ2HUA7kjQVmp5nkt586rSWsD1rVmrl2rf9ANxwVZaqKkS0L7et
         lazjUp3zJruy4rxsTKDH1ilORU14vJe3j7lYZmwiU+rKOH+BvOfSWDw09iNBsMdzo/1w
         3BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237328; x=1697842128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXsSOg8f2yCgJEL2pCIM6ReAyW7r5JJg4FpT0/i3350=;
        b=S/ZcSK0RiI5zxvHZuf1y3fDentmgginQgKwx7iN3EjfovrdoZiYuXw1zZG/H+GTGPc
         tuy9w9M+LbHs/estaPutR17eDjFlqlEsnzo9VPKKUIkPCqW8LAtGC4pN+u1RJA+ua5hE
         RcGiTJupmv5IskO2fMdMq+yYKSIkQdQoLGTS4CHMpPpJvI7Z478D8kwvCBhf0B/EwZsT
         oEZJbgq4J6WnH+QYdmuFkMjmMsnF7Li+ZNtS97jl2dMlQlo2Yfe6jebsudypC9qzgH/C
         DwV34mDKwMhpzX2zp5tzeeolPMcESuA54lpKu3t3Xn/gOv8l75Ia7TrMfCoqyR6iPTKE
         cHbQ==
X-Gm-Message-State: AOJu0Yx+AeoaEJlmTVHlWG3HlO6DEwWJBchdsQDoRaK/1B7Xmbtahmig
        GaA4sluY2AoBdblecTgEK0APBD+LGJUB7A==
X-Google-Smtp-Source: AGHT+IE9rlOoTxWanAIhwXH3c3A7MPp5nT4G7OQtkPlxA2nnFxv/BQDSaMbqdKcAurhuWGzqbDPnaw==
X-Received: by 2002:a05:6e02:3201:b0:34f:ef94:c803 with SMTP id cd1-20020a056e02320100b0034fef94c803mr27776695ilb.25.1697237328040;
        Fri, 13 Oct 2023 15:48:48 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:47 -0700 (PDT)
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
Subject: [PATCH v7b 15/25] dyndbg: add for_each_boxed_vector
Date:   Fri, 13 Oct 2023 16:48:07 -0600
Message-ID: <20231013224818.3456409-16-jim.cromie@gmail.com>
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

Add a for_each iterator to walk a counted vector member in a struct
(ie the box), and use it to replace 8 open-coded loops.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5- parens-on-box-force-precedence
---
 lib/dynamic_debug.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index be49e104ec76..c11feca70d6f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -158,6 +158,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  _dt->num_class_users);				\
 	})
 
+#define for_each_boxed_vector(_box, _vec, _len, _ct, _curs)		\
+	for (_ct = 0, _curs = (_box)->_vec; _ct < (_box)->_len; _ct++, _curs++)
+
 #define __outvar /* filled by callee */
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
@@ -167,7 +170,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_user *cli;
 	int i, idx;
 
-	for (i = 0, map = dt->classes; i < dt->num_classes; i++, map++) {
+	for_each_boxed_vector(dt, classes, num_classes, i, map) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -175,7 +178,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 			return map;
 		}
 	}
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++) {
+	for_each_boxed_vector(dt, class_users, num_class_users, i, cli) {
 		idx = match_string(cli->map->class_names, cli->map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + cli->map->base;
@@ -1058,11 +1061,11 @@ static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp
 	struct ddebug_class_user *cli = dt->class_users;
 	int i;
 
-	for (i = 0; i < dt->num_classes; i++, map++)
+	for_each_boxed_vector(dt, classes, num_classes, i, map)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
-	for (i = 0; i < dt->num_class_users; i++, cli++)
+	for_each_boxed_vector(dt, class_users, num_class_users, i, cli)
 		if (class_in_range(dp->class_id, cli->map))
 			return cli->map->class_names[dp->class_id - cli->map->base];
 
@@ -1216,7 +1219,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	struct ddebug_class_map *cm;
 	int i, nc = 0;
 
-	for (i = 0, cm = di->classes; i < di->num_classes; i++, cm++) {
+	for_each_boxed_vector(di, classes, num_classes, i, cm) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			vpr_cm_info(cm, "classes[%d]:", i);
@@ -1230,7 +1233,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 	dt->num_classes = nc;
 
-	for (i = 0, cm = dt->classes; i < dt->num_classes; i++, cm++)
+	for_each_boxed_vector(di, classes, num_classes, i, cm)
 		ddebug_apply_params(cm, cm->mod_name);
 }
 
@@ -1250,7 +1253,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	 * module's refs, save to dt.  For loadables, this is the
 	 * whole array.
 	 */
-	for (i = 0, cli = di->class_users; i < di->num_class_users; i++, cli++) {
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli) {
 
 		if (WARN_ON(!cli || !cli->map || !cli->user_mod_name))
 			continue;
@@ -1268,8 +1271,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 
 	dt->num_class_users = nc;
 
-	/* now iterate dt */
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++)
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli)
 		ddebug_apply_params(cli->map, cli->user_mod_name);
 
 	vpr_dt_info(dt, "attach-client-module: ");
-- 
2.41.0

