Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5046C7BB78F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjJFM2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:28:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C8DE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:28:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565334377d0so1571983a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696595320; x=1697200120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf0O6wGIQ+WjBH7olrcq9QdkaS1oq22ED7x1V/JYDqI=;
        b=MJmR6PjjJzVZ1cypFYLT+oXdbVr2AszBXuri7vzuOiTIHvnvDOIGxPWq4EfrvEfF+Z
         qFxWPEnxffxcpxOzJBnEcGePt2KFPAKFGfnNnVYcBxlqi3B/65v8DAsml1iE9ta1ysZc
         4jwgBs6D3IXJscLuc3jTJzVMbbSONVdxS7CltYXGZNIJQ3RyR7S7vBtJ1npjwbVkRfBQ
         SwYkULkSBPSnwkc/zkXdj6xDudfAlwK8hQ9ZuS8mUJhhPa8Ux6mlIprO863qLNPPKTh/
         Pr9p+KgSHiKxQ2b05WVc3ZNhTuZT6kJvow75yWA8935vNvbkvHgqy5NxFWKlVVJ8UY7W
         QchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696595320; x=1697200120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf0O6wGIQ+WjBH7olrcq9QdkaS1oq22ED7x1V/JYDqI=;
        b=L4p1KV1YmeLIJZB4j24YUSW0NMFaJMRDwBffY/2mI/WBemO4f3L8YqgZHYTnqwU1W1
         ykclfyFZst1vC73sYeYG87fYcZVf1xUhEgyR/Rc/qOVicUiZ6i03kiHTZspy6/sD445+
         TRdVGNfl9mXnl1K2O5KiJx48ey2pP8CIrSFM5hvv2+Faw1k3qud1k80tJDlO6E7oYByZ
         fWgf793TJscPiMON4LYCviiUtypW7P6rjREdIr0u34UQNTzUNdThIggePj69txrSGflM
         +TbZB629d8iN7KXmFEsB4T2NlmoHachtHerjRY4IyDuQw69gP5M4QZFVx35Hid0lN5oy
         /WCQ==
X-Gm-Message-State: AOJu0YxN3h3by7Ln9sAeAbWgnchSimGuMkllupWBFesciDZ6hKSm/XSz
        etPlYk0wwaTXnq6qpJvKjTQn6w3jX7QGaw==
X-Google-Smtp-Source: AGHT+IG3pScWU/Wi4lA66lqDsAx5Isxr4tw1HicsuGlhYi8s0lUSwuxoGxUX5govRBkkLE7d8M+x9g==
X-Received: by 2002:a17:90a:12cd:b0:274:6d4e:e0d9 with SMTP id b13-20020a17090a12cd00b002746d4ee0d9mr7865442pjg.45.1696595319907;
        Fri, 06 Oct 2023 05:28:39 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a804a00b00263b9e75aecsm3295117pjw.41.2023.10.06.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:28:39 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH v2] mm: rmap.c: fix kenrel-doc warning
Date:   Fri,  6 Oct 2023 17:28:25 +0500
Message-Id: <20231006122825.54840-1-m.muzzammilashraf@gmail.com>
X-Mailer: git-send-email 2.25.1
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

after running make htmldocs, getting this warning
warning: Function parameter or member 'folio' not described in
'folio_move_anon_rmap'
and this patch resolves this warning

changes since v1:
	- changed page to folio and reverted other changes

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index c1f11c9dbe61..6976fb6feeed 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1129,7 +1129,7 @@ int folio_total_mapcount(struct folio *folio)
 
 /**
  * folio_move_anon_rmap - move a folio to our anon_vma
- * @page:	The folio to move to our anon_vma
+ * @folio:  The folio to move to our anon_vma
  * @vma:	The vma the folio belongs to
  *
  * When a folio belongs exclusively to one process after a COW event,
-- 
2.27.0

