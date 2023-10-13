Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5695B7C90A7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJMWtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjJMWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:48:51 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EF7E8;
        Fri, 13 Oct 2023 15:48:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3512c43adebso9684965ab.3;
        Fri, 13 Oct 2023 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237321; x=1697842121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=JwwwGNLPXCQTXpfYi5Ez9wlswWI7xn/H/ippxu7U98xUZjedA3k9DFygRnB0vmA4Qm
         nhr2oLEEvqui2rkjnSrcG8t9aeKXihabYD2cM8adduvG2uNc+GgW8EG9sGE+ziuJ5DoX
         WYxTgukbmmh52rJScqZI/v2lOWJ6dBreGURrIDJLy0N4bZ+47E4b9OHxE2W2XnGWj/oe
         HqqjTFKp9KbZe7QuZdsrb+7wF0jFplWV3Z/ExOgerKt4ixFgMJ2aZihnIGkArr3qBceX
         ZXyHkwemXm54Pvk4SI9Ay6NTYCmgw/l7CIcHTDBJqocpW0iAbWuFFY0DMuySKo0XPFOL
         79uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237321; x=1697842121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Nv87Lg2zXFTsrsMPJe4o1KQfKM5CR/Su7zfjGsbi8=;
        b=N/5wO1jHhNzy8ARj2B8/twLdopGmNMlVB2x5Oq40KtCCKlHEdgaHkTa5Mo4xgOOyCi
         C+e2LuF+4NaTi0aBlLLwKL53Qsg8e8pM2ZdYRsmB23z3EdrlCKIsF0ryjHvVDhIjvHUW
         7s6cO4DK/MF+j0FFAvPhurfYYpCSWIrQho20PI+NcGF/7F67gFEnaOfTpASXr/SkmyE1
         YbHazk5NQGXM6uZ6bUp7hvuTx3hLZYc3eC6x4ErWzjOPzSmlA6vtSmQRMj3C/J5G86fr
         oR4/eMjWR5r3tUpS/uogLIiW6KdVAzf9bAqZm0YCK3LRdpZq7dM+RY+gEuBX613Bb9Tj
         npAw==
X-Gm-Message-State: AOJu0YzXYr1AiHv3gClKXjdSewJ50Cn0FDersvE2xejsFnhocVG+r5GZ
        G3qs+HLaBF8xK/bfL76GDhnFF7T5v2NKRA==
X-Google-Smtp-Source: AGHT+IFi2WfSSyAbjqCpWaNlxupVxRqtj0XluiJVnf5vbLg35Uz1MLSFKUJlsjNrq6Dz1o+F9+CISA==
X-Received: by 2002:a05:6e02:1e02:b0:350:f0bb:6a42 with SMTP id g2-20020a056e021e0200b00350f0bb6a42mr39141991ila.29.1697237321292;
        Fri, 13 Oct 2023 15:48:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:40 -0700 (PDT)
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
Subject: [PATCH v7b 10/25] dyndbg: tighten ddebug_class_name() 1st arg type
Date:   Fri, 13 Oct 2023 16:48:02 -0600
Message-ID: <20231013224818.3456409-11-jim.cromie@gmail.com>
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

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b07aab422604..8158943b350d 100644
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

