Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182137B6C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjJCOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:49:05 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9417EAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:49:02 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 006d021491bc7-57bbb38d5d4so548306eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344542; x=1696949342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+b4EtjPouuLro3RPQ2u+6EnaEB6T6SR+sicsyHJKMSU=;
        b=U4PDonQhm/9gDByRCTsOOTTZ0G+YEQoTmYEA1FyAC+wWrcE8ReraJuzc+bnyTLhND3
         TddJNk1AYhdIuPlw3UIv+K9GyrVrx5XSgEbM39azTe5tzTrh2Rr/Y2PwL775pCDoCkju
         zPtbOQLluij/8nP9gCByxfzSGC9l7qvTIavmGmSjuZFkHrOOE/p/MvqRXhsHVoqtcXkA
         YqsYRL8t9q+H+gpMl2bsGFCruwV/PndG7AB3ZfAp2uW6bB9vqpzaitByQh142aXRk2cP
         Um5nMM0jmjou5VDGvHXJzPiphvOY1Ydrz3unZ+Hs9sqfUBiVVWWhn4mWcKOAOTJhLaea
         R3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344542; x=1696949342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b4EtjPouuLro3RPQ2u+6EnaEB6T6SR+sicsyHJKMSU=;
        b=O0E2gJe1/x7IFqhlGCnvHuUPopF9TMxrF/CL4T6NTBof95xE8nYMwIdc7RjOnzUr9H
         Bt4Ah3EaCW3g091IA7CRELI/cBMKOeT0EO2zOcuZTy41xoRDDZNx6lGSU0lmBjmVjk/b
         I7+qO3WKWlz0g0/GOa1FHqVpmjkKLwkPr7OrH9SpOaPcjzTp+Pl40gX3BSgeuYwe9UDX
         k/cKhEpUQt/kvd5jHozQy18KrMXuw/7/v9in3toCBGRTwc0NSN4d2hFzLloL8Owezh0V
         +fPywylZ0uC8wKoydx/jGrlce35DMkz4SrWqw21YMYZc5sZFxYoea1yzo4QUC9pe9c/H
         fMcA==
X-Gm-Message-State: AOJu0YzTCq1Fw3o23c64+X8J86f1g58zwCdpBzZbqnPFO+zyiOtQIHYc
        a/cFBmnmlOkEl58msnuk/88C6DdGcRgeALA=
X-Google-Smtp-Source: AGHT+IHwXZ8gHdJJX/lcyMp5I8mG80fjmHLetl/aHXgjiax+vDvRmpwELVC+UPeAF0qyrj2dvvoYyg==
X-Received: by 2002:a4a:d21d:0:b0:57b:469d:8af6 with SMTP id c29-20020a4ad21d000000b0057b469d8af6mr12475644oos.4.1696344541655;
        Tue, 03 Oct 2023 07:49:01 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d137-20020a4a528f000000b0057de3e449c8sm228889oob.8.2023.10.03.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:49:01 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] mm/migrate: fix do_pages_move for compat pointers
Date:   Tue,  3 Oct 2023 10:48:56 -0400
Message-Id: <20231003144857.752952-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
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

do_pages_move does not handle compat pointers for the page list.
correctly.  Add in_compat_syscall check and appropriate get_user
fetch when iterating the page list.

Fixes: 5b1b561ba73c ("mm: simplify compat_sys_move_pages")

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/migrate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2053b54556ca..06086dc9da28 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2162,6 +2162,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			 const int __user *nodes,
 			 int __user *status, int flags)
 {
+	compat_uptr_t __user *compat_pages = (void __user *)pages;
 	int current_node = NUMA_NO_NODE;
 	LIST_HEAD(pagelist);
 	int start, i;
@@ -2174,8 +2175,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		int node;
 
 		err = -EFAULT;
-		if (get_user(p, pages + i))
-			goto out_flush;
+		if (in_compat_syscall()) {
+			compat_uptr_t cp;
+
+			if (get_user(cp, compat_pages + i))
+				goto out_flush;
+
+			p = compat_ptr(cp);
+		} else {
+			if (get_user(p, pages + i))
+				goto out_flush;
+		}
 		if (get_user(node, nodes + i))
 			goto out_flush;
 
-- 
2.39.1

