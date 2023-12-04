Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418080419D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjLDWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjLDWTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:19:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E898199
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:19:47 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db548aff7baso4725134276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728386; x=1702333186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXInaHt13KB+V9pIyuwZVrz/xxGvGn/o8w1U8yLGi6Y=;
        b=qU2haV9NZiWWVLABx/42Qw6bHDcwmIVttFsTWErKV2+dEnYdLgZ+2TRmJMtjHg6CRV
         84BVrL1H/dOc/zNGxYiwjEfLx4Z/vapizGqdFFSo57xaD8g+utjtDBh7KpAXOrbiPeoe
         tGs9orevXgwD0chywh9iKzsXOHZAiukgw/iwoaFMrBiIN2cpvqS0h+k/zpLbGv7ElqwO
         juqHcQiw29xGXOB56g0wCQZInqJr3nB9DSsilB4u5+CboW5Uku3WIC/zkd3v9v1s/gWj
         8WMqDEo75rwkVI93/cIBmIERegDqg0YR87MVtJuXi62ufduUfqauTgB2jeWCy5qGzDcw
         KCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728386; x=1702333186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXInaHt13KB+V9pIyuwZVrz/xxGvGn/o8w1U8yLGi6Y=;
        b=f8ExmHNlI4FbcjLLS94QGYIBgBvtNz84GXLzKrx3Zb8OZtjZ6b3zy4Tw7xu7acwaDm
         UCq7fJpOJMx4Q3Or/mMCnfWdkMowi9NbHZCIhRiwDFcDm1jkHwaTq/NuTnsWBKOEY5Do
         c/ttc2ENosiqjY9hUhaImbRMHf5BE488+bxK4hyPukMSctN4Kw2YS4St1Lcf5y+Hk9iH
         LmSLJnre5kMF5pRKaxIQLw6uLWG5ayK4x+WL2HusBUHr4HTraA2nL3I9jeGmsJNDIWLF
         hnSOWUMEsTzrrMlmqe09JxeaXyCCqIvcF522ytu/v/4YpTsQ/+PnlcyzWlt0C1zTjf9I
         VXxw==
X-Gm-Message-State: AOJu0YwHcbERdtGKnUt9LnKoLMSqApvrq2AvfH3EfYMxjgJz8QuzZ4gJ
        2vADyQH8MnElN1HltT7NxBIyWf0bVw==
X-Google-Smtp-Source: AGHT+IHynJIC5QGUDpxsV5RmDAee4mt7x7k1mIDUotJWtWP+9oiPNk2RReFWkIP59RbKajgfBsafs1HFcA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:c50:0:b0:db7:e75c:24c1 with SMTP id
 d16-20020a5b0c50000000b00db7e75c24c1mr172123ybr.9.1701728386307; Mon, 04 Dec
 2023 14:19:46 -0800 (PST)
Date:   Mon,  4 Dec 2023 22:19:31 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-6-rmoar@google.com>
Subject: [PATCH v3 6/6] Documentation: Add debugfs docs with run after boot
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand the documentation on the KUnit debugfs filesystem on the
run_manual.rst page.

Add section describing how to access results using debugfs.

Add section describing how to run tests after boot using debugfs.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v2:
- Add info to documentation about cleaning up data, init tests, and
  running tests concurrently

 Documentation/dev-tools/kunit/run_manual.rst | 49 ++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index e7b46421f247..aebb52ba9605 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -49,9 +49,50 @@ loaded.
 
 The results will appear in TAP format in ``dmesg``.
 
+debugfs
+=======
+
+``debugfs`` is a file system that enables user interaction with the files to
+make kernel information available to user space (See more information at
+Documentation/filesystems/debugfs.html)
+
+By default, only the root user has access to the debugfs directory.
+
+If ``CONFIG_KUNIT_DEBUGFS`` is enabled, you can use KUnit debugfs
+filesystem to perform the following actions.
+
+Retrieve Test Results
+=====================
+
+You can use debugfs to retrieve KUnit test results. The test results are
+accessible from the debugfs filesystem in the following read-only file:
+
+.. code-block :: bash
+
+	/sys/kernel/debug/kunit/<test_suite>/results
+
+The test results are available in KTAP format.
+
+Run Tests After Kernel Has Booted
+=================================
+
+You can use the debugfs filesystem to trigger built-in tests to run after
+boot. To run the test suite, you can use the following command to write to
+the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
+
+.. code-block :: bash
+
+	echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
+
+As a result, the test suite runs and the results are printed to the kernel
+log.
+
+However, this feature is not available with KUnit tests that use init data.
+
+Also, you cannot use this feature to run tests concurrently as there is a
+mutex lock around running KUnit tests at the same time.
+
 .. note ::
 
-	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
-	be accessible from the ``debugfs`` filesystem (if mounted).
-	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
-	TAP format.
+	For test authors, to use this feature, tests will need to correctly initialise
+	and/or clean up any data, so the test runs correctly a second time.
-- 
2.43.0.rc2.451.g8631bc7472-goog

