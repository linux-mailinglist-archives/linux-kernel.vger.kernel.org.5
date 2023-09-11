Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA979C108
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjIKX4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 19:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbjIKXyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 19:54:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37E1249AD;
        Mon, 11 Sep 2023 16:35:31 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c92a2c52dso47247447b3.2;
        Mon, 11 Sep 2023 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694475250; x=1695080050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIIYUwBsaiu36WnKQykm9kj4fLnG9Ddt/hz9ZLesgf0=;
        b=sa6qDk65HhA2zDz3TSk4R8oQvuZokDPgC/DVRWbl2pa1UFukGMk0q2V4FDJZ2UGG77
         +8g8qw49P30op5bjAqpJNTFH46auCP7PJYO/xDjBWzrFl2Du/MYJR2dp1VAq3hclvR98
         +kOUkaCoJguSXqGBLG9J617BOQ55Lx6zR7TmDuTeTb7zG0Z5tRvQH8xatYtlhFiQS2aa
         t0Q+B5ZIGbYSh7ett/iaF3KNMZ6i1oEjtEuIscIrqkvL5zyirZYKbHM1R8Cz5GNNNNmv
         2stShTRX/krApSXvoAS0+uqgNc405wpa/5RGqFLaTPCKkaPeYFUR4YpNTUlmWwbHnfmp
         iSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475250; x=1695080050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIIYUwBsaiu36WnKQykm9kj4fLnG9Ddt/hz9ZLesgf0=;
        b=OLSmb6LfI9EIFuYCnaaXdngIJswqDkLzAUj39E4s56onkiLYXKrYh3KXsUZ6LSDOT3
         08alyDTJt/c5HIbTll77RKNp/KQB71eYMhToFnNXYvA7tLwDRtHnemO8QypdTlAy/wMh
         wLXX5zRQLNqGE6IboK1/J1V/ewkiwzmb2bAbbWMwmvMcvd31Ow4HfdqWrdynaCMxxJVo
         oLX4HXqti1g8h5i3hpgtO5JCaMX7AyirhwXrD3P3pyC4O+6zJ5E4pcEKhrsS/ncxdXWR
         fTx6e2eDXfqJNWPYS0jccZ9tNbYvArvRx75ynaXxvk04k89ZFksoPy6CwSxTYkYoCMTc
         SIKw==
X-Gm-Message-State: AOJu0YymYh8+5tzwm50Y/Of+QuVjS8XoQuaYz7tgULHXYi3ILdyDrFYQ
        MRTuTzLeXz+Ql6l8WiEc+svG6TEoBjGWkw==
X-Google-Smtp-Source: AGHT+IH4lvM9n3Sq9J/JyIhbgS3K6eNigqCkdj6RF5icXfyb3Ss3T/pl8jMa+w92YftWgv11YJIzZQ==
X-Received: by 2002:a6b:fe07:0:b0:795:12b0:c2a1 with SMTP id x7-20020a6bfe07000000b0079512b0c2a1mr13897349ioh.10.1694473732975;
        Mon, 11 Sep 2023 16:08:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 09/22] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Mon, 11 Sep 2023 17:08:25 -0600
Message-ID: <20230911230838.14461-10-jim.cromie@gmail.com>
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

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 05c777dedf27..e8bade6c6c06 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1117,12 +1117,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1156,7 +1156,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.41.0

