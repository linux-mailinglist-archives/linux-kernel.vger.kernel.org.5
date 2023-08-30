Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276778E028
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjH3UFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjH3UFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:05:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F35298664
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:48:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7814efcccbso7079529276.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693424849; x=1694029649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JE+0J4LE2Y9WLJA4sbzDU6bKkGcfTw3IfTNM4aZ8RZg=;
        b=PqdZ8KaaSnkkn5TOnRYNzK4qbtGvGk+xfoms7rwsaHQci8OqcdlxIqWYnW9ObzV6ub
         y6v7pCMn4a21vvTXQvqL6ow+fP3MMuhfCXly49t/IQ6XaUkUQwpbUopA/+2FbSeCMeIi
         hS1D7PrndnFMVua6MC/qaJSuD3ywlx+zvC//+MGeccE55nmAwsP7lP3qG8dO8G1dmbNg
         04Xm4nxUzXdFwwS3OPgsZsAXbt9+jYx9qDxCP5mwmXBkZmfYhZIz4WrEwBl3BXLJ8tyk
         iH1EMix4gPiZk/0MwrUT0fZ6WdZ7tWy2cL96yxubBHlwy1Gi+NDgI2VOLPfsJnk4V0/B
         QMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424849; x=1694029649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE+0J4LE2Y9WLJA4sbzDU6bKkGcfTw3IfTNM4aZ8RZg=;
        b=BZLT/emeMQnMxTKoE0+bjDfi2nFkGZY/c7KdAAa+5A81W4q2Fitkz2/JCa3bw84Nmu
         k8Tk6JFDOA0jJ47yNLtE7o8cP8/kyuniko2mXc3cE+lcHTcgyVAjwLCupxGk4+yXzmwk
         b+/H72YbxMDN2UbNtfSAoR2IHf2IHjkRmkPllrmc/XYHeYH3fGN5BzviCHYRV5/UvW1u
         3J8rD4zLBjwk8K6wUFx+chIZ0UQtFi12LMZqQ0b9jQCOy3AsrCL9gG55M2WVD5qjeb7c
         kEoYFanNwCa4oUhDNYwydOZ+3knWZZ6EZ/ompTG9qztsZbCZg9VS+8o7ajFl7ZknBf5r
         y7Bg==
X-Gm-Message-State: AOJu0YzpMLG3MGoq7I18417cLPgR1oqctPfnlC9O/5ePQNH1gU97Ac91
        Z/YCYYshelXIKXmx5BCjVlRwidU+T2zLmmnNAA==
X-Google-Smtp-Source: AGHT+IHs+RWMaNtA93jfYo5odypjlgOLH3hb204BRKjTj2NCRouc7VuVWQozkwCmR1nmpUaVeTHB/jrtkwAiF+KhVg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1287:b0:d7b:92d7:5629 with
 SMTP id i7-20020a056902128700b00d7b92d75629mr109004ybu.8.1693424849002; Wed,
 30 Aug 2023 12:47:29 -0700 (PDT)
Date:   Wed, 30 Aug 2023 19:47:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALmc72QC/x3MTQqDMBAG0KvIrDuQn43tVYqLkEz0gzotGZGCe
 HeDy7d5B5k0iNFrOKjJDsNXO/xjoLwknYVRuim4EN0YHa8wg857akXyJzAUG68JypmfsWTvfKx 1TNSHX5OK/72/p/O8AFfl655tAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693424848; l=2357;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=GIGvI2tq5BYA3OyOut6s0LymlGqm3neCSz8tHLPc2Nw=; b=4KSwwoIvqS8EU5l3yCMv60/x1oUuI+qdr3mOXLmSXbCSA/rG1Q6mfxjytKCd/Cwa5MZki1/Tt
 u3meMQNbnlwBfXxiAse3Eqxqa2iuxvKCHAz+Iqtn37lXFZ85ufdHtch
X-Mailer: b4 0.12.3
Message-ID: <20230830-missingvardecl2-init-main-c-v1-1-59007a637259@google.com>
Subject: [PATCH] init: fix -Wmissing-variable-declarations clang warning
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building x86/defconfig with Clang-18 I encounter the following warning:
| init/main.c:189:13: warning: no previous extern declaration for non-static variable 'envp_init' [-Wmissing-variable-declarations]
|   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
| init/main.c:189:7: note: declare 'static' if the variable is not intended to be used outside of this translation unit
|   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };

Move the extern declaration to a header file so that the compiler can find it
when compiling init/main.c.

Add `const` qualifier to extern declaration so that the types match and
we follow the One-Definition Rule (ODR).

Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

There's a previous RFC [1] wherein the kernel test robot reported some
build errors which lead me to creating this patch which both fixes the
errors as well as the -Wmissing-variable-declarations warning.

[1]: https://lore.kernel.org/all/20230829-missingvardecl-init-main-c-v1-1-ddf0f1a71215@google.com/

Also, get_maintainer.pl had a hard time finding folks to Cc here, not sure why.
---
 include/linux/initrd.h  | 2 ++
 init/do_mounts_initrd.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index f1a1f4c92ded..0114f1acbb45 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -34,4 +34,6 @@ extern unsigned long __initramfs_size;
 
 void console_on_rootfs(void);
 
+extern const char *envp_init[];
+
 #endif /* __LINUX_INITRD_H */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 425f4bcf4b77..b35c1b0babc2 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -87,7 +87,6 @@ static void __init handle_initrd(char *root_device_name)
 {
 	struct subprocess_info *info;
 	static char *argv[] = { "linuxrc", NULL, };
-	extern char *envp_init[];
 	int error;
 
 	pr_warn("using deprecated initrd support, will be removed in 2021.\n");

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230830-missingvardecl2-init-main-c-93dc1013ff8a

Best regards,
--
Justin Stitt <justinstitt@google.com>

