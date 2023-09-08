Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7379918A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbjIHVcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjIHVcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:32:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD11FE7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:32:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7edc01fdc9so2537581276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694208726; x=1694813526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WrSybFetHPfn0OxZQ180UMQcEGO5bVxxCcuiMkmcKr8=;
        b=S2Jj/pzkU8oCOk/hz+Y71QRYsp6C+ebfO4NY+tZZdl1CJFKorcMp8xonSlPRU1XYRd
         egZxU58iPzmoA/dAgNglOdxMQLXSXwQFuMvLzCBhaYjT5M+i5Dq9fLgd8KblOj1xvMKy
         paw7+n3mXP6qbtsjgEkuSDhEBQoRaUhqPAWhPDZmfhkzKIm0neF1RGu2MQH/ZBOuClRJ
         fTvkhNbWlMoy+QIbHhdKn98CL8UfCveSRDXMy9UAHAut8aXeNMKPapDs2TYCA3Kt4v9S
         uK/w4VuHBY19ruYNqFFI2iT/QsBcMJ7TBL5/dLF5ZVfoRB0Pf2m8w/CqG+07fWx3xza5
         y8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694208726; x=1694813526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrSybFetHPfn0OxZQ180UMQcEGO5bVxxCcuiMkmcKr8=;
        b=V8ZH31zBPiWos8+J/9u5PWPXC3gGH41crR1ne6PsoiulRyZd2beaqLaJ3F6F9XqSNg
         rLj0e6A1AQx5mFZf9KdXIjWQWZA0HlEgnGSzBRaAu8FSdCFsl4a1RVAMZ54y44pWIAUh
         3TRG3L6MBkvElijqRBytTntxcFLoe6TbkBIXn5y/LBAUEKdY5Ld86sfigWBZG/2IpYyb
         74jl1e9jlJK1Sy7GMSsKCShx+Tgz8GiYPf8YCB88OXKj1kKObaQD4FHrB3wNMDKbZDnM
         O6GEVEjPodnXF0ZCQVSdzqDYToQeaZ2z5ZJhkH8YbyjK/m/s18NDg+10FTs/Dr4d/8EE
         0XEA==
X-Gm-Message-State: AOJu0Yx9znqPkKuyMhepT1shJ2rF5/R2x4FOBsXNc8+8dY6inDx6mw/a
        XJCP6rMGijrnV2039UylzabGwz/alg==
X-Google-Smtp-Source: AGHT+IHG7fQnlP8xDXo7SMz8La6WUcW4q4a4Z3CTA2AhPgnjq1WxXweSG3cbdfplTYuhvZxDVIArjC7iTQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:2749:0:b0:d46:45a1:b775 with SMTP id
 n70-20020a252749000000b00d4645a1b775mr72079ybn.3.1694208726055; Fri, 08 Sep
 2023 14:32:06 -0700 (PDT)
Date:   Fri,  8 Sep 2023 21:31:48 +0000
In-Reply-To: <20230908213148.3610108-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230908213148.3610108-1-rmoar@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908213148.3610108-2-rmoar@google.com>
Subject: [PATCH v2 2/2] Documentation: Add debugfs docs with run after boot
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Co-developed-by: Sadiya Kazi <sadiyakazi@google.com>
Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
 Documentation/dev-tools/kunit/run_manual.rst | 45 ++++++++++++++++++--
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
index e7b46421f247..613385c5ba5b 100644
--- a/Documentation/dev-tools/kunit/run_manual.rst
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -49,9 +49,46 @@ loaded.
 
 The results will appear in TAP format in ``dmesg``.
 
+debugfs
+=======
+
+``debugfs`` is a file system that enables user interaction with the files to
+make kernel information available to user space. A user can interact with
+the debugfs filesystem using a variety of file operations, such as open,
+read, and write.
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
 .. note ::
 
-	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
-	be accessible from the ``debugfs`` filesystem (if mounted).
-	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
-	TAP format.
+	The contents written to the debugfs file
+	``/sys/kernel/debug/kunit/<test_suite>/run`` are not saved.
-- 
2.42.0.283.g2d96d420d3-goog

