Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCD581241E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442930AbjLNAsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442898AbjLNAr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:47:57 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54A9A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:48:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702514881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCFM+nFcyoFd/gCQWZCb7EKvVZ+qSBSDeoPEA8Jfh0A=;
        b=chtz44aTYYSc5cpdlXhKLUKTZ86AJYhUci1b1n4MvFn6OsB2ibs7ZQcAic22uNrBAd8YVr
        Eaf1Gto/kQeCtiRuJu5GHpZr6mJXhZ9iHzXRU8IBsCW4j6J1IghuG97ROmbXrolwlXm6SD
        iEGh8YGKXQ0g7vJ2SGCdtWFc78uL3S4=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH -v2 mm 4/4] lib/stackdepot: fix comment in include/linux/stackdepot.h
Date:   Thu, 14 Dec 2023 01:47:54 +0100
Message-Id: <4123304d92b1ca3831113be5be7771fd225cddf9.1702514411.git.andreyknvl@google.com>
In-Reply-To: <cover.1702514411.git.andreyknvl@google.com>
References: <cover.1702514411.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

As stack traces can now be evicted from the stack depot, remove the
comment saying that they are never removed.

Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index a6796f178913..adcbb8f23600 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -11,8 +11,6 @@
  * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
  * stack traces often repeat, using stack depot allows to save about 100x space.
  *
- * Stack traces are never removed from the stack depot.
- *
  * Author: Alexander Potapenko <glider@google.com>
  * Copyright (C) 2016 Google, Inc.
  *
-- 
2.25.1

