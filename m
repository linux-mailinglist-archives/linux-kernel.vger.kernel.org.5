Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DC57AD876
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjIYNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjIYNAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72BE107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9adca291f99so777695266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695646809; x=1696251609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8bPvgPYa85OE64RYeOWcGAjGkQSeFdTUqTGSpUdX4g=;
        b=A4IpTBhOisx6zqUEyyh86iIyD4NhNjg0FhIqcAp7Yt3dN/SVTC1kdXimsMieLbARa7
         JxXdul0lBQGQLQX7zVP7gPmNSt8/oYVFJc+b2KCWX4CWpFFE0K2TvuUuYZEq25Gnv74z
         iWtVyXfzAh1cgyLo7TXtAOtiX6xzTpbChpTZuI4mOWU6LwFVGAdSTJRATJhIVCtgRkjh
         vWynwrRLypEvDBKvZn8d6uHxVYUBuYWmD074KI1NHilw8TkO7qGmOSLTQyMCmX+J7KIQ
         cUEuB6P635EFK0WjAsJVIJUxfcy1qCIf9GOjPQKvJMOx/Hx2W0+RqVn2s3Yoh6sh+xnA
         T+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695646809; x=1696251609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8bPvgPYa85OE64RYeOWcGAjGkQSeFdTUqTGSpUdX4g=;
        b=T3QOt4ZJaGnXZ7bH1dSNwut2wtsYMK3hhJa2RQWosq8ieFxI/jhBMR0jfUyT2mU+BR
         Y5gIXvkjkWdnNbqpphqSn7PYxKyVwgHPj4q6dETvmigBNnag/LVqC9TCu+jj3KRTYO4S
         zxWIhNEkBp1DzeGf2tF2yZ7VMrPzIroCZq+7EE2d2qNREF7Mn519ldxiC+HfQMU5zqwK
         VYrIp/sPtt6r7sYjyGPOLJ1UyAkyD5aY/3Ac30eT0Y12YpU7iy0iu7slCKRmraijDnCB
         8m8akchMsTRIq0JxHciTKakFvmhPT+T0ZB4/SAjMCC5JPMf7WU52EorG3lP6WSzu7Ai5
         dL9g==
X-Gm-Message-State: AOJu0Yxef20VaFQEW7gFn31wCDWKtT7gWXFIY279KON+2W/GhB4uneIb
        UV0l527uO1c5XPyuiwIPG4k=
X-Google-Smtp-Source: AGHT+IFnWOVutZXesnGJeFlUOf93D0bZFlUGm31cJH9nj19/d1yhTb2TAAICRj+JQH3Ekp8ahBryVQ==
X-Received: by 2002:a17:906:55:b0:9ad:78b7:29ea with SMTP id 21-20020a170906005500b009ad78b729eamr6237656ejg.44.1695646808582;
        Mon, 25 Sep 2023 06:00:08 -0700 (PDT)
Received: from lelloman-5950.. (host-80-182-134-115.pool80182.interbusiness.it. [80.182.134.115])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090685c800b009ad7fc17b2asm6301108ejy.224.2023.09.25.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:00:07 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        akpm@linux-foundation.org, nphamcs@gmail.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v2] mm: zswap: fix potential memory corruption on duplicate store
Date:   Mon, 25 Sep 2023 15:00:02 +0200
Message-Id: <20230925130002.1929369-1-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

V2:
- Added a warning and a comment to the second duplicates check in
zswap_store function (Johannes).

Based on commit ce9ecca0238b ("Linux 6.6-rc2")

Fixes: 42c06a0e8ebe ("mm: kill frontswap")
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 412b1409a0d7..083c693602b8 100644
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
@@ -1333,7 +1346,14 @@ bool zswap_store(struct folio *folio)
 
 	/* map */
 	spin_lock(&tree->lock);
+	/*
+	 * A duplicate entry should have been removed at the beginning of this
+	 * function. Since the swap entry should be pinned, if a duplicate is
+	 * found again here it means that something went wrong in the swap
+	 * cache.
+	 */
 	while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
+		WARN_ON(1);
 		zswap_duplicate_entry++;
 		zswap_invalidate_entry(tree, dupentry);
 	}
-- 
2.34.1

