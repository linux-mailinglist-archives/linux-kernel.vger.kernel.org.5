Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98507C7744
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442834AbjJLTtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442748AbjJLTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:49:01 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30BED60
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:40 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fce245bf6so53220739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140120; x=1697744920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=071vttQwsRtHTk9tdWp1lQy+KTSRjIxShniNeq+GU3Y=;
        b=YP9WCCUPD3xLbCS1byqspoYlcu640BonoiUex3iSArjbquqRDyZeuGIihLURzg8IyK
         JX1PxWE3CNYryK7JBU1fBjckc2IZPWRJhpHK/TvwWZohwO+Eyhedm37HFyqjws5HIDf+
         +x3OCKyTk0t/1IsHElBt45anTdy9v19I3oLMwFHbysuBQFcvQsKDCNe8A9E36UxGlVyQ
         mR8HLKx7MrCCp4D+TBTfpQNrF6msy2GxG8NZ1AnfMTy4/oQZefAHYuyyQ+LWsWqdteFu
         LpOY66xBiyrJKAKi7rPwD1+CU5/atbdPuOM5end9eBdjoLqwPtZXId1xlYArJy5cmOB6
         XIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140120; x=1697744920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=071vttQwsRtHTk9tdWp1lQy+KTSRjIxShniNeq+GU3Y=;
        b=McfCikM8bZZMfGc//noC6jRNyku/gGQ8Npn/v+J4iYv9IL4Q1qhG7kGtOCa1mpDMzF
         w/8QbZTTA4uQKaiwfPeesHca3xiRqGfrRfNFGZX0bpcMcR2RC4hkQ3ZUcEQiFx01ac1r
         ZrcbwjKbxdzACYgYlpRHui/hRbAesni4rLwa/baqNDnWTmnMGI9ngxPX5RcUZGA/OYsS
         IgxA9ykYMgxBJMgS4d82+LFJCP+96Rc4ARUqZZG9bSTOFGc2sx8ZguhrwVY2IlqJYRFO
         2DgRr5ekraY2EgYtEf+g6DnvCzdZdu1WDMqgVevE8+GcEZ4sW5hBySD4f9gmnUxwDbAI
         8m3w==
X-Gm-Message-State: AOJu0YwlfOeVil60g7/vS7JAMqqPnTZUSdsQOZhLsc8SKOW4PcQVarzu
        uqoH/HnJzFrjDOY29hHidgx2CTbxKweoFw==
X-Google-Smtp-Source: AGHT+IECRXAFW385uWrPn0wiuesUrL7Wi11XXQJywiummqTkx/9vrEOfgiOGgMFRJ0iACAXIrGO8vw==
X-Received: by 2002:a5d:990f:0:b0:794:d833:4a8a with SMTP id x15-20020a5d990f000000b00794d8334a8amr26752167iol.0.1697140120027;
        Thu, 12 Oct 2023 12:48:40 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id h6-20020a5d9e06000000b007a25540c49bsm4307891ioh.27.2023.10.12.12.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:48:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org
Cc:     david@redhat.com, lb@semihalf.com, linux@rasmusvillemoes.dk,
        joe@perches.com, mcgrof@kernel.org, Liam.Howlett@Oracle.com,
        linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 03/10] dyndbg: add 2nd cursor pair to init-fn
Date:   Thu, 12 Oct 2023 13:48:27 -0600
Message-ID: <20231012194834.3288085-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012194834.3288085-1-jim.cromie@gmail.com>
References: <20231012194834.3288085-1-jim.cromie@gmail.com>
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

In dynamic_debug_init(), add 2nd cursor pair to walk the
__dyndbg_sites section in parallel with the __dyndbg section.

This avoids using the _ddebug.site pointer during initialization,
which is a 1st step towards dropping the member entirely, and reducing
the struct size and section footprint.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0ad9f1bc00f0..51af6a75ae92 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1501,6 +1501,7 @@ static int __init dynamic_debug_init_control(void)
 
 static int __init dynamic_debug_init(void)
 {
+	struct _ddebug_site *site, *site_mod_start;
 	struct _ddebug *iter, *iter_mod_start;
 	int ret, i, mod_sites, mod_ct;
 	const char *modname;
@@ -1508,9 +1509,11 @@ static int __init dynamic_debug_init(void)
 
 	struct _ddebug_info di = {
 		.descs = __start___dyndbg,
+		.sites = __start___dyndbg_sites,
 		.classes = __start___dyndbg_classes,
 		.class_users = __start___dyndbg_class_users,
 		.num_descs = __stop___dyndbg - __start___dyndbg,
+		.num_sites = __stop___dyndbg_sites - __start___dyndbg_sites,
 		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
 		.num_class_users = __stop___dyndbg_class_users - __start___dyndbg_class_users,
 	};
@@ -1533,16 +1536,19 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 
+	site = site_mod_start = di.sites;
 	iter = iter_mod_start = __start___dyndbg;
 	modname = desc_modname(iter);
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
 
 		if (strcmp(modname, desc_modname(iter))) {
 			mod_ct++;
 			di.num_descs = mod_sites;
+			di.num_sites = mod_sites;
 			di.descs = iter_mod_start;
+			di.sites = site_mod_start;
 			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
@@ -1550,10 +1556,13 @@ static int __init dynamic_debug_init(void)
 			mod_sites = 0;
 			modname = desc_modname(iter);
 			iter_mod_start = iter;
+			site_mod_start = site;
 		}
 	}
 	di.num_descs = mod_sites;
+	di.num_sites = mod_sites;
 	di.descs = iter_mod_start;
+	di.sites = site_mod_start;
 	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
-- 
2.41.0

