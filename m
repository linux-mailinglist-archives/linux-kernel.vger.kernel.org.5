Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6B7BBBA4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjJFPTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjJFPS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:18:57 -0400
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23265ED
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:18:55 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696605532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Er5Jgf/mIYSvRRXnkgZed7EeXQhYo+vHYR723lnpJKc=;
        b=cvyFNI4OAQwUs9v5CXlxdA9g8c/2WH3s2QRoom6vGRHGmwdYyvDiHToyN+AYxM9Ci36Rn6
        G1xgcus15AvmXMADgyyr9qAyGVRSVnGdIbkzmsjobLylVDc8diW7WYeuuJdLTIxeuC5AVN
        VydDkx4lcdhG6KPp3nlS/FWhQRXxrKQ=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 5/5] Documentation: *san: drop "the" from article titles
Date:   Fri,  6 Oct 2023 17:18:46 +0200
Message-Id: <1c4eb354a3a7b8ab56bf0c2fc6157c22050793ca.1696605143.git.andreyknvl@google.com>
In-Reply-To: <cover.1696605143.git.andreyknvl@google.com>
References: <cover.1696605143.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Drop "the" from the titles of documentation articles for KASAN, KCSAN,
and KMSAN, as it is redundant.

Also add SPDX-License-Identifier for kasan.rst.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 7 +++++--
 Documentation/dev-tools/kcsan.rst | 4 ++--
 Documentation/dev-tools/kmsan.rst | 6 +++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 382818a7197a..858c77fe7dc4 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -1,5 +1,8 @@
-The Kernel Address Sanitizer (KASAN)
-====================================
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2023, Google LLC.
+
+Kernel Address Sanitizer (KASAN)
+================================
 
 Overview
 --------
diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 3ae866dcc924..94b6802ab0ab 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2019, Google LLC.
 
-The Kernel Concurrency Sanitizer (KCSAN)
-========================================
+Kernel Concurrency Sanitizer (KCSAN)
+====================================
 
 The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector, which
 relies on compile-time instrumentation, and uses a watchpoint-based sampling
diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
index 55fa82212eb2..323eedad53cd 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2022, Google LLC.
 
-===================================
-The Kernel Memory Sanitizer (KMSAN)
-===================================
+===============================
+Kernel Memory Sanitizer (KMSAN)
+===============================
 
 KMSAN is a dynamic error detector aimed at finding uses of uninitialized
 values. It is based on compiler instrumentation, and is quite similar to the
-- 
2.25.1

