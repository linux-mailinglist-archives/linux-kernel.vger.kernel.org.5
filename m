Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE557B6C11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbjJCOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjJCOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:49:07 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9FA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:49:04 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-57bb6b1f764so637041eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344544; x=1696949344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgsSVYjb3XoR+vDJQ0/loW/0uRGU+RS/FfCjIxPZwtk=;
        b=Hk6t0rwPj4YIuATQHLgefNXPr4kxITiipFjb/pIVNGJA0N79JDKH6WizkmUKQ5mtk7
         UWWQWJ9mVKNaQFMp8+Lk+LMlrwx5OPr3zyM47UVfuMujSg3L8etZK0/r3Q44SVPcrvCo
         34+ns2pSNzV2CWpH0jhzyoUzsbcObgoY2oTzCVbcOdN78ggHzJTtXty2KRoK16zwv+uh
         JAp0FtdXJlyYTigT/FGP4UQRK6lnKmoj+dhZDcJZk0hna+MlMck2+BN3VUUVoXjT99eZ
         /5Bpt+lv2megDLezTAjU2WHrqoGfc6f61S5O/Y2wuMT8IeLH0WBoK3+sl36AH0t0tnMj
         jJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344544; x=1696949344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgsSVYjb3XoR+vDJQ0/loW/0uRGU+RS/FfCjIxPZwtk=;
        b=NygBX8Ywn7uQBwsxZ89C/cDTEZgCUcj5F6O2S86GoSdH/4Q5UvYEJCNY6axSRF33I6
         NivhSh9//ksikPKOavigBIzz/okaZ+XuoWXIt6HZ5sdoT4pjGpx9UsCrK2iB7ymJIgml
         1XkvZWxwKanjf6FWH1WuNtI1D5No2rrr8DSaEtYns4gKNiuAXc0FV+djV1UHzKaxKI4/
         7rkz5n/y7gU9yzqbRAmz7dCbCBfHqGOqdSZ0Au66Hq5DE8yPQQIMho+GcqXqBU8Zy2o4
         FJVeHJYN4EE/g72TnUmaajSPpmmLblAPwbfXP1HYBCRxFAAf447Ma4gC50baNYiNtfcN
         3DZw==
X-Gm-Message-State: AOJu0YwQ5DxMHgeO8T2/EyEcuDHX/9WHzLVcEzhfnFtQC4oKKHyPn/Jl
        NYr3i/Dy4zlDxbNE8mNN5Uxo3Zus/UyXZD0=
X-Google-Smtp-Source: AGHT+IF+/hxRPMv5BoIKJfzhv6QpR7MnuFfeVe9NeMSUik9/rP+tv/ZLcPG9oeaQHrXXDoo1JSGIsA==
X-Received: by 2002:a4a:d206:0:b0:576:8c2c:c865 with SMTP id c6-20020a4ad206000000b005768c2cc865mr14643350oos.8.1696344544057;
        Tue, 03 Oct 2023 07:49:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d137-20020a4a528f000000b0057de3e449c8sm228889oob.8.2023.10.03.07.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:49:03 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] mm/migrate: remove unused mm argument from do_move_pages_to_node
Date:   Tue,  3 Oct 2023 10:48:57 -0400
Message-Id: <20231003144857.752952-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231003144857.752952-1-gregory.price@memverge.com>
References: <20231003144857.752952-1-gregory.price@memverge.com>
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

This function does not actively use the mm_struct, it can be removed.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 mm/migrate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 06086dc9da28..4e8368408b17 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2029,8 +2029,7 @@ static int store_status(int __user *status, int start, int value, int nr)
 	return 0;
 }
 
-static int do_move_pages_to_node(struct mm_struct *mm,
-		struct list_head *pagelist, int node)
+static int do_move_pages_to_node(struct list_head *pagelist, int node)
 {
 	int err;
 	struct migration_target_control mtc = {
@@ -2126,7 +2125,7 @@ static int add_page_for_migration(struct mm_struct *mm, const void __user *p,
 	return err;
 }
 
-static int move_pages_and_store_status(struct mm_struct *mm, int node,
+static int move_pages_and_store_status(int node,
 		struct list_head *pagelist, int __user *status,
 		int start, int i, unsigned long nr_pages)
 {
@@ -2135,7 +2134,7 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 	if (list_empty(pagelist))
 		return 0;
 
-	err = do_move_pages_to_node(mm, pagelist, node);
+	err = do_move_pages_to_node(pagelist, node);
 	if (err) {
 		/*
 		 * Positive err means the number of failed
@@ -2203,7 +2202,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = move_pages_and_store_status(mm, current_node,
+			err = move_pages_and_store_status(current_node,
 					&pagelist, status, start, i, nr_pages);
 			if (err)
 				goto out;
@@ -2238,7 +2237,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = move_pages_and_store_status(mm, current_node, &pagelist,
+		err = move_pages_and_store_status(current_node, &pagelist,
 				status, start, i, nr_pages);
 		if (err) {
 			/* We have accounted for page i */
@@ -2250,7 +2249,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	}
 out_flush:
 	/* Make sure we do not overwrite the existing error */
-	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
+	err1 = move_pages_and_store_status(current_node, &pagelist,
 				status, start, i, nr_pages);
 	if (err >= 0)
 		err = err1;
-- 
2.39.1

