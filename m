Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0275A688
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGTGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjGTGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:32:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2E73C03
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:31:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942442eb0so5177907b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689834620; x=1690439420;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJUwQzbRztLLTSTi35hLHWvFJlOvZKlmG5YMI9kdOKM=;
        b=exzMRciz6q57iZ3LnCISvUalCcqN+3UGW0dNiMEU6Ux+IUuc78gOhlVYUkJBW2O0V5
         ej5vDC2rgGJhAdjVu26+fOkYdw5ptSu2dD6vQOgndW5uTqXTMg+MdWzZgt5jcDSvP4zA
         FSMCRNvOtH9sE9JDwS+96mV+vQyPUcAZs2SnNkOFZNqalPWZ6NwHXxQW/jt03bBjRL88
         SZL1IEnTHd9I+3F0BkHkh60a04LAf6ZKKJdXG3/qtlAWJipsHM7nNq/Z7GA+dSEzree9
         PzrQ16O/PhOSKgEvbVEghQg84fQXQN1cHCZW6PQjs4Omr5MUE3noZpyRCv82OvBbctsd
         52tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834620; x=1690439420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJUwQzbRztLLTSTi35hLHWvFJlOvZKlmG5YMI9kdOKM=;
        b=YdZq5hjzT1C+8E43FAFomBuBWp6LdoKQOTDQYjkXV52GMWuOSbGYMS5ZeMspokvV86
         J7Hxn2W2yzLDIU2aa82fssMryEAhsuAo+qnfZdaS9Ns08Ji1YMgkLqpgELAFC6sZqCXF
         cRNOgjnCpVsVJQRz0PAdWpJA8s1+LH+ZkZdjmsBcCBbGKlUBXJZi9ZuyfJSd97SavPm/
         rfjtq4X404aAkZrUn8NIF+weEr6rJCdFWJK9dMJCDLh9M3BWdfm0/LBQffBiLnE7bzSe
         ZczkmXl0JsWLiNqVGmwDLShBJDIZJ9HuVkVVXjLvGQOqFOpJf7oU/UsQTh3OipOipm7n
         /blA==
X-Gm-Message-State: ABy/qLbIiSCLO3R9Grt/Ui4D1rvFzv93a6/DwbKvKcGoHJL2ZeobrkSK
        NkIMNpnkqogtMSGrHsNpff/FUStNVy+HMA==
X-Google-Smtp-Source: APBJJlE9Or/WvU1LyYLL5e7PUIkswIIqACTJZXRrrefvubcmzh9/DrI2y+dUq4RV8PFzuza7opwPGWPwyrD8Ww==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:4423:0:b0:57a:118a:f31 with SMTP id
 r35-20020a814423000000b0057a118a0f31mr56270ywa.7.1689834619846; Wed, 19 Jul
 2023 23:30:19 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:29:37 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720062939.2411889-1-davidgow@google.com>
Subject: [PATCH] rust: doctests: Use tabs for indentation in generated C code
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While Rust uses 4 spaces for indentation, we should use tabs in the
generated C code. This does result in some scary-looking tab characters
in a .rs file, but they're in a string literal, so shouldn't make
anything complain too much.

Fixes: a66d733da801 ("rust: support running Rust documentation tests as KUnit ones")
Signed-off-by: David Gow <davidgow@google.com>
---
 scripts/rustdoc_test_gen.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4a3f..a625cf3517c0 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -242,13 +242,13 @@ macro_rules! assert_eq {{
 {c_test_declarations}
 
 static struct kunit_case test_cases[] = {{
-    {c_test_cases}
-    {{ }}
+	{c_test_cases}
+	{{ }}
 }};
 
 static struct kunit_suite test_suite = {{
-    .name = "rust_doctests_kernel",
-    .test_cases = test_cases,
+	.name = "rust_doctests_kernel",
+	.test_cases = test_cases,
 }};
 
 kunit_test_suite(test_suite);
-- 
2.41.0.255.g8b1d071c50-goog

