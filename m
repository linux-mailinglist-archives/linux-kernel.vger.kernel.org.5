Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0079D133
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjILMhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjILMhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:53 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71419F;
        Tue, 12 Sep 2023 05:37:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso60012835e9.0;
        Tue, 12 Sep 2023 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522267; x=1695127067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPgIpG5TOZNPAt8S1evljl9V3lEAQHO8eSzeI6GnXt4=;
        b=QUvvzmsHcWrsb7/vMtgO4JlEG+7lILTzCtRWevxVBXxSOldldIUp3nCeZUUzASYHwJ
         vB+Tey3lHIIrwfJ7UFnElFPlZGHoTcXjFG3TQTtDRpXyT3Lgtu0nt7sGkfzZDXrlTtdh
         Hvjd414+Z1Xff1FYLyQCIqior4Dhx3Wqvz/Sxwcw7sy/iKaabJZz2yDHF4357xLQoszr
         uotDK399JGEbBhKKT0OtDAYyNCdSHuHxM5hN3NTkLcz5GwDH5j58jm657gOd0oUwfvun
         6dBL7wCUcDUdXAbSYfFQOVUwz0qUqGaoqRYhadshgSDAj4xkiBwt97SSFjyupPkmq5zH
         zPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522267; x=1695127067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPgIpG5TOZNPAt8S1evljl9V3lEAQHO8eSzeI6GnXt4=;
        b=q+VrSZs0OyTmdRq1vHAFpg8goYdK4NE5yyfc6PBxxojA1PXiK5sa3yoraePAU36ILd
         tH/sX3fBF8grNBmF+5PjEnkIt3Ph1ROHHSQl/9TUQW+ZoOMoaFkCR91B8e53Uwk35eva
         ZpHOokYnkqEgg5hxPnyvpj9KbdP+lXrmuXMj34ZjbchvqRMcOp96I3HC47tT6lfDB5tK
         msVe23TcidThCSHNvwWsVPsr+ZOVhRcIFUDqldxRrLTaZwr+0TkBqvJtffjDTqY6uBLp
         iuIQpi+xrVPPD7SvfHGshUEmShihnXZedCNAMJpLKYwNCbFsJut+1vXWESqaER3DilWy
         2GGA==
X-Gm-Message-State: AOJu0YzLhNHtWpzKHQkUmo25K7CrXMbnWgSRQ7H6NzvYkVNc5e/G8IiO
        2YgAbxOI5/2A8A9aUFb++vM=
X-Google-Smtp-Source: AGHT+IGLbUH2Z4MFC9hO43WmWIhDOXRou/I+QOr4ZR8s1bVOyzOUZrD8TLyAlTqwj93v0teYLODyVw==
X-Received: by 2002:a5d:4ac3:0:b0:31a:e772:ddf6 with SMTP id y3-20020a5d4ac3000000b0031ae772ddf6mr10792700wrs.39.1694522267081;
        Tue, 12 Sep 2023 05:37:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j6-20020adfb306000000b003142c85fbcdsm8184474wrd.11.2023.09.12.05.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5][next] bcachefs: remove redundant initialization of pointer d
Date:   Tue, 12 Sep 2023 13:37:40 +0100
Message-Id: <20230912123744.3929609-2-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer d is being initialized with a value that is never read,
it is being re-assigned later on when it is used in a for-loop.
The initialization is redundant and can be removed.

Cleans up clang-scan build warning:
fs/bcachefs/buckets.c:1303:25: warning: Value stored to 'd' during its
initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/bcachefs/btree_update_interior.c | 2 +-
 fs/bcachefs/buckets.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/btree_update_interior.c b/fs/bcachefs/btree_update_interior.c
index 73c950d2788e..35f7af297ac0 100644
--- a/fs/bcachefs/btree_update_interior.c
+++ b/fs/bcachefs/btree_update_interior.c
@@ -143,7 +143,7 @@ static size_t btree_node_u64s_with_format(struct btree *b,
 }
 
 /**
- * btree_node_format_fits - check if we could rewrite node with a new format
+ * bch2_btree_node_format_fits - check if we could rewrite node with a new format
  *
  * This assumes all keys can pack with the new format -- it just checks if
  * the re-packed keys would fit inside the node itself.
diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index c02c8c917a29..951f945bbc22 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -1300,7 +1300,7 @@ int bch2_trans_fs_usage_apply(struct btree_trans *trans,
 	static int warned_disk_usage = 0;
 	bool warn = false;
 	unsigned disk_res_sectors = trans->disk_res ? trans->disk_res->sectors : 0;
-	struct replicas_delta *d = deltas->d, *d2;
+	struct replicas_delta *d, *d2;
 	struct replicas_delta *top = (void *) deltas->d + deltas->used;
 	struct bch_fs_usage *dst;
 	s64 added = 0, should_not_have_added;
-- 
2.39.2

