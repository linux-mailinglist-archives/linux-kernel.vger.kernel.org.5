Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496017AB720
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjIVRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVRW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:22:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C3CF1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:22:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-530a6cbbb47so2988243a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695403339; x=1696008139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EstAJdqqJobGtsfoo9iGZ9EtBqPSgDnFgltPzivwLhc=;
        b=TUlzMh7QMLdS1+XnuZpb6bb0aUAgCKcLOCcyn9Low3j/5vfU8JTDQT611SSNrHYF5i
         kHd222WzzLlnpfBTt6ItdW/otpq24EJIxlcgD3hTMs8weBc+FToW9s6AB6RHk6WQceLV
         2OI/iQ0Au6a8CUjiC7i0t9P3PhADD/mCIupwZQ1LCzh3B7ThyjgEsF2kE6DkXCSS7fpm
         5RAMj48+86+AfdvIWiIXINl100hoWZOHCWiMV2ncCQEtYZeb8JtoCso6LXkgHBvRo0Io
         A5nJAAvo5qwuez7zu9/NNVFtEgtC++v36b6QouJEH4oWRMmC1/GTyImpNWcSJnXdxwll
         6/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695403339; x=1696008139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EstAJdqqJobGtsfoo9iGZ9EtBqPSgDnFgltPzivwLhc=;
        b=rxyQOwVYp0wQ8z9jAh1+5Tw2dQLeiPD8m+6/QOXp0OizPYuQ/+aRU4ZKpSUKt30zds
         K7p2nxTa/wPw686hPT7yvch+RLI8UD8GRZvbzF3yVTtMPEwQeewd/dmQpYQXB9oXwNkp
         Iej1y1IzeLIxC7SgteaMWvd/CCxN9dPFEZfaijaArVQvsIQMd104pgzIi/BpFpm+YTSq
         zfAkhH1DKUD+q3F4QyUfOrdRgEZYxI9aTjVMNMpUNCO8PoCBNAe8G5nebUhMoG9+YGpA
         9SyWflP3D3zLtzcuYMXGHNH8uBEAYiXi+hWDpGgvCA8cflOmO8oFL9LCqaOnDYSK/EDj
         9lvg==
X-Gm-Message-State: AOJu0YxwfAxX0ukNyNp02qM8d8Jf2aKZpf4wdm304ySQpBCUtx9akTHa
        1XD6I7UNYVQMAOj3LQbftDg=
X-Google-Smtp-Source: AGHT+IG1U1pWgWNzY9WfNfFnz7+R7yJGswXrGJyI4sJ/Ocv0ubp+uYs/lvXeVtKxmLczO5P1zbhfbQ==
X-Received: by 2002:a17:906:da86:b0:9ae:5db5:149 with SMTP id xh6-20020a170906da8600b009ae5db50149mr33223ejb.35.1695403339445;
        Fri, 22 Sep 2023 10:22:19 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-115.pool80182.interbusiness.it. [80.182.134.115])
        by smtp.gmail.com with ESMTPSA id t20-20020a170906949400b0099bd5d28dc4sm2982466ejx.195.2023.09.22.10.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:22:18 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, nphamcs@gmail.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH] mm: zswap: fix potential memory corruption on duplicate store
Date:   Fri, 22 Sep 2023 19:22:11 +0200
Message-Id: <20230922172211.1704917-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
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

While stress-testing zswap a memory corruption was happening when writing
back pages. __frontswap_store used to check for duplicate entries before
attempting to store a page in zswap, this was because if the store fails
the old entry isn't removed from the tree. This change removes duplicate
entries in zswap_store before the actual attempt.

Based on commit ce9ecca0238b ("Linux 6.6-rc2")

Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 412b1409a0d7..9146f9f19061 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1218,6 +1218,19 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_enabled || !tree)
 		return false;
 
+	/*
+	 * If this is a duplicate, it must be removed before attempting to store
+	 * it, otherwise, if the store fails the old page won't be removed from
+	 * the tree, and it might be written back overriding the new data.
+	 */
+	spin_lock(&tree->lock);
+	dupentry = zswap_rb_search(&tree->rbroot, offset);
+	if (dupentry) {
+		zswap_duplicate_entry++;
+		zswap_invalidate_entry(tree, dupentry);
+	}
+	spin_unlock(&tree->lock);
+
 	/*
 	 * XXX: zswap reclaim does not work with cgroups yet. Without a
 	 * cgroup-aware entry LRU, we will push out entries system-wide based on
-- 
2.34.1

