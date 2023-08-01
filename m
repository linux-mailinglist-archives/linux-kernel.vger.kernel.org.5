Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C9276BAB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHARFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjHAREh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:04:37 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2F268E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:03:58 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bc479cc815so2495799fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690909416; x=1691514216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1qxtL28qFpEv5tjq5E0J9oH4XrNxsFVniuDXF72/f4=;
        b=iY2lO+tSKTdIIpIKLeh0hvOSJa3JrjyeYoRVTnezwv4Y8WFIeqBoTrIG+12Mg+Ta2p
         kFTu77QOYHp04cNMr1qVvty3YwZ2C470s41+vnCK5dSAl1vEuqkkzBoO5MjTOlaRCFIG
         o/jTVLCDBPxewt+4Mh9SFEqHTUvYpeU6mbnRdT5IU4y9SSTlrd0f63or6qwuqpXqhMmd
         KNkgFTudXzWehq7zSSc0GrTOxb5JFXy6EvwHOxyVpF6QYM+sZ/a8KeuS69u9O664oKLP
         9rGOY8/gPm0RhQjLFs0Y0jI6Id7dWUdWs60CK/9m5WlM1VJIoPFg3B9NF2KQYDrnIvLm
         S7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909416; x=1691514216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1qxtL28qFpEv5tjq5E0J9oH4XrNxsFVniuDXF72/f4=;
        b=X802ZA6ua4FpLgITceJRtWMAHGnKao5sQeUgBG5mDrO2fnZ6CWB/YF2vN/R67RQP9I
         ZdSYL4ZywK/QnnMNkf7a8iymCt2caDz+lcCD33P12OwW1chGUr6KYfKVVTyXrNVfpUZh
         GiAWIAJ12rHMgHimxoc+wwOfwagJ+YheOK9dQjq7DMVSWnP2/tWR81Q9RRxEtSRfEqGs
         z7NIdtWyPAbBCg5K7tRsfuEuT5UjajHok4TwLhZf2yzOabqr9/uEuSI7XZ7sqkYnp2VO
         9IdTR4gAPuGgqlON/VSYcffUn0HxXtRaEnGkMrwkz3G7HteShGjxEHaliAKqHtCAkGEL
         Yprg==
X-Gm-Message-State: ABy/qLZd1tW1ecGLIi3ANXzVuh+MvKA585As+n8Az7OmtGkTBBu54BwQ
        MKzI4YoaImzaO2oiw2RjiUk=
X-Google-Smtp-Source: APBJJlGCYlVfv/sDt+StfVsOSfK7k0IR0izFIadz5vnVfXT7zcBrlD6BUQWkJxBa+vF5i6CF/m9PDg==
X-Received: by 2002:a05:6870:f102:b0:1bb:7e37:ff1b with SMTP id k2-20020a056870f10200b001bb7e37ff1bmr13869537oac.30.1690909416477;
        Tue, 01 Aug 2023 10:03:36 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o20-20020a02c6b4000000b0042b144abf71sm3768577jan.179.2023.08.01.10.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 10:03:36 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     daniel.vetter@ffwll.ch, daniel@ffwll.ch, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     linux@rasmusvillemoes.dk, joe@perches.com, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 15/22] dyndbg: add for_each_boxed_vector
Date:   Tue,  1 Aug 2023 11:02:48 -0600
Message-ID: <20230801170255.163237-17-jim.cromie@gmail.com>
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

Add a for_each iterator to walk a counted vector member in a struct
(ie the box), and use it to replace 8 open-coded loops.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d78e48d3af1c..c4d7a70a0723 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -157,6 +157,9 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  _dt->num_class_users);				\
 	})
 
+#define for_each_boxed_vector(_box, _vec, _len, _ct, _curs)		\
+	for (_ct = 0, _curs = _box->_vec; _ct < _box->_len; _ct++, _curs++)
+
 #define __outvar /* filled by callee */
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
@@ -166,7 +169,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	struct ddebug_class_user *cli;
 	int i, idx;
 
-	for (i = 0, map = dt->classes; i < dt->num_classes; i++, map++) {
+	for_each_boxed_vector(dt, classes, num_classes, i, map) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -174,7 +177,7 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 			return map;
 		}
 	}
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++) {
+	for_each_boxed_vector(dt, class_users, num_class_users, i, cli) {
 		idx = match_string(cli->map->class_names, cli->map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + cli->map->base;
@@ -1053,11 +1056,11 @@ static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp
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
 
@@ -1211,7 +1214,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	struct ddebug_class_map *cm;
 	int i, nc = 0;
 
-	for (i = 0, cm = di->classes; i < di->num_classes; i++, cm++) {
+	for_each_boxed_vector(di, classes, num_classes, i, cm) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			vpr_cm_info(cm, "classes[%d]:", i);
@@ -1224,7 +1227,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 
 	/* now iterate dt */
-	for (i = 0, cm = dt->classes; i < dt->num_classes; i++, cm++)
+	for_each_boxed_vector(di, classes, num_classes, i, cm)
 		ddebug_apply_params(cm, cm->mod_name);
 }
 
@@ -1244,7 +1247,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	 * module's refs, save to dt.  For loadables, this is the
 	 * whole array.
 	 */
-	for (i = 0, cli = di->class_users; i < di->num_class_users; i++, cli++) {
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli) {
 
 		if (WARN_ON(!cli || !cli->map || !cli->user_mod_name))
 			continue;
@@ -1259,8 +1262,7 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	}
 	dt->num_class_users = nc;
 
-	/* now iterate dt */
-	for (i = 0, cli = dt->class_users; i < dt->num_class_users; i++, cli++)
+	for_each_boxed_vector(di, class_users, num_class_users, i, cli)
 		ddebug_apply_params(cli->map, cli->user_mod_name);
 
 	vpr_dt_info(dt, "attach-client-module: ");
-- 
2.41.0

