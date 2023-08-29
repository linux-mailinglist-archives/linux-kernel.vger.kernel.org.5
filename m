Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8865778D0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbjH2Xiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbjH2Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:38:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA5CD5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:38:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7493303b5cso5576656276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693352312; x=1693957112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbqhUxk3XJw1e+A4t7lsmYAPl18T2q+RlEuDduG9BdM=;
        b=qhIHUNSkTODabhO0nDjLZ/kSQVeFOktZdNA43gFAkGN4gj1m7eSxKmeX6JA1dI+00w
         mSgUiOjnpWkKJYf+0HR9lwuFJqfM7RzAwzXMyIPKXJdyt799e9HHSVxgiotgV1KoUCar
         bMoAvamOSNH0MsWJAS0QPV6n86KuhemouTU63UuICZ4MLFaqpIO+Y9MLhOynhNXbcqaP
         /aR69+YmiHM4f1WtbmkXTgE6wTagqfNCOSn0JO7DJQfoBacV2LXunsBEfeqcrzs4F/0H
         sGDcxJ3McWHmwnPMtbYp8G4KORZlYo0h9roZhTrfpZL9cpxbRWR9VqzRBP+MGN2SPP07
         nu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693352312; x=1693957112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbqhUxk3XJw1e+A4t7lsmYAPl18T2q+RlEuDduG9BdM=;
        b=MNrXlpyiJj4nYGq3lyDfPrDDTksPmhxXNRl+ahmrtJbW+pCrucopcsjFMyj2HNProQ
         9kLKUYNCWePPgvW7EnSSCloH9cZ8Iu8H981IRPO7fBr3VfnX1ACdB53Qsixau3TzKU+X
         HSOMVDDJqdhHw3dvTOeVJOnylrPQ4xkhn52+f2mwhNTcE/LS26sr0hOIRi9vx1iRvVFA
         YjDUqfdwG22/Z2KvUpxWf48pBib2+WmyKL2Gbt7cb8q77s8nZS52bQY3uoz5fRLILeA/
         5sdt7lsBjlJKvXIqWFMY/ab+axntbqr0DPrJUNlZ4YvP17WcT185PqjON9jXP6wRHkFs
         kvPQ==
X-Gm-Message-State: AOJu0YyNkH/LguyI8FaATseHj92qWIqitxgNFklktidj89SJy4KuTdQf
        owqNz5LesjgrvyafbZ1qB5TSMswVWdrSZwm7aA==
X-Google-Smtp-Source: AGHT+IG0i29yCeJNWGDvgkhn5P4cGCTob/N6JmX2ceISwe34Yp/gc6LV0oNlEh++3Fizgxv1CWrToMky1ip88xcjlg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d1d4:0:b0:d46:45a1:b775 with SMTP
 id i203-20020a25d1d4000000b00d4645a1b775mr17759ybg.3.1693352312545; Tue, 29
 Aug 2023 16:38:32 -0700 (PDT)
Date:   Tue, 29 Aug 2023 23:38:31 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHaB7mQC/x3MMQqDQBAF0KvI1BlwJyk0reAB0oYUyzqaD3GUH
 ZGAePcsKV/zDnLNUKd7dVDWHY7FCsKlovSONiljKCap5Vo30vIMd9i0xzxo+jAMG88RxolDHEW DNLfQKpVgzTri+8+f9Og7ep3nD64BOGZxAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693352311; l=3109;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=5HjtNq8MgBa1E9HQZr8o9ch/Gsru/UDsHmWMCBaxx6M=; b=0PeQHkUcML8AD1uRsbwY92H7Jt2DVdL+c22t5CO157b05/0M5SywN0VMOvIKUiCdVUqqHYiJr
 DdDwqUsNolKAJbewkvaFWrtk78RX/Od7O+xUvq9L5caQGWLcOjitrQ9
X-Mailer: b4 0.12.3
Message-ID: <20230829-missingvardecl-init-main-c-v1-1-ddf0f1a71215@google.com>
Subject: [PATCH RFC] init: fix -Wmissing-variable-declarations warning
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was looking to get some help on solving this -Wmissing-variable-declarations
warning as there is some hope to turn it on for W=1 soon [1].

When building x86/defconfig with Clang-18 I encounter the following warning:
| init/main.c:189:13: warning: no previous extern declaration for non-static variable 'envp_init' [-Wmissing-variable-declarations]
|   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
|       |             ^
| init/main.c:189:7: note: declare 'static' if the variable is not intended to be used outside of this translation unit
|   189 | const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
|       |       ^

It seems like the obvious solution is to just add the `static` keyword
and be done with it. I suspect, however, that it is not so simple for
the following reasons:

Firstly, `envp_init` is surrounded by two other variables that have been
explicitly marked as `static` which leads me to believe that this one
was intentionally _not_ marked as static for some reason:
| static const char *argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
| static const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
| static const char *panic_later, *panic_param;

Secondly, there exists this `extern` declaration for `envp_init`:
| init/do_mounts_initrd.c
| 90:     extern char *envp_init[];

This one is tricky because it seems like I can rename (effectively
remove) this extern symbol entirely and still build a kernel image.

If it truly is the case that this extern declaration works then why does
Clang produce the warning at all?

FWIW, I've tried moving `extern char *envp_init[];` to top-level scope
inside of `do_mounts_initrd.c` which did _not_ work in fixing the
warning.

So all in all, it looks like just adding `static` fixes the warning
(which it does) but I am not sure about the other ramifications of this
patch especially considering the second point I brought up above
regarding the extern declaration already existing (but seemingly not
doing anything).

Any help here would be appreciated!

Link: https://github.com/ClangBuiltLinux/linux/issues/1920 [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index ad920fac325c..9a473107bb8f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -186,7 +186,7 @@ static int __init set_reset_devices(char *str)
 __setup("reset_devices", set_reset_devices);
 
 static const char *argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
-const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
+static const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 static const char *panic_later, *panic_param;
 
 static bool __init obsolete_checksetup(char *line)

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230829-missingvardecl-init-main-c-1af2e128419e

Best regards,
--
Justin Stitt <justinstitt@google.com>

