Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAA793212
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjIEWnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIEWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:43:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D043F9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:43:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59222a14ee1so32756267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693953807; x=1694558607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAxkSB4LTMIrDzL3yo0sRFWIBDiM+cwzoHmOo/62+qg=;
        b=aZYbDBBlJolGuBURKRJqryb/WlV62jya+ojvOh6Ae81y9khWB+iHmH3dJV9JZKbi/O
         jiCJ7R2nofJq1inkVkhZgPSQAFvRsGwuG/svMFUfPskJ1Sz1Mn2UqZliRiCyMLPw5GJ2
         jfXSLOxH5XVQFlQZAgBQu3dH+NHoIFqWdij3z9e7ISaPa+zEPxatuAc0r14h+CjN4u81
         bA3etTiYfFwco6rkWHHu6m3YlfX9maMsW4JfdgZ0zgnLjWqd/bpY4+sRST+s8g/+Odw/
         JMSoy0A5owM000odUyxs3Ip1DQYfthb2w51HnOsIYDLzMksbaAKBrfN5KbUmQSqCDLoB
         Fh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693953807; x=1694558607;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAxkSB4LTMIrDzL3yo0sRFWIBDiM+cwzoHmOo/62+qg=;
        b=Dstqfoo8PsHsLDt6HWH/LIEf6ssPgG8Vam50gVWr/tNd2wfytP43BSen5fBz/OLSu5
         wwL1yA7VVjeHuG3AgWPwl7xD6C5h2lpKNMofGYCH2zN9kMLd6CLPbUL5kMffj3xnMEu8
         qzZycKz9eJoLLlljdgPW/qE6oHv7o9+GVDrWwbRCDOtL+ARIBq35hr/bAcGcjdQbMbg1
         ctN0EAjJVWzzZCBzBPGG4mxgJ5FmUekndsx7w1/X5sCtTFxRBgF1zhhoOxrFhblyu9ag
         f7jrWErP4osu1DpuiYjuJJaULPrdSxNI2NW12k4pGvTT9YjBCSpeda+GKyZVBfIlT5GA
         VlQQ==
X-Gm-Message-State: AOJu0YzNThUg7rY8SlHk66nnTIeG2oDpWF2YhXv6xCLvb5SXMQ97qn6C
        xc/BodcMWoKHGWbw/d47k3/+FIOglHISonKlDQ==
X-Google-Smtp-Source: AGHT+IGkfcxguu2oZatlIQqfrDF13+qN7//v0B3M0PVplRmGp4NbwSq2ZDy1TBnvyUxJR74WyHNWu1hz9O+i3hLCyQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:7e02:0:b0:583:9ace:cf41 with SMTP
 id o2-20020a817e02000000b005839acecf41mr339271ywn.0.1693953807393; Tue, 05
 Sep 2023 15:43:27 -0700 (PDT)
Date:   Tue, 05 Sep 2023 22:43:26 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA2v92QC/43NTQqDMBCG4avIrDslP1i1q96juAhxjAOalERCi
 +TuTT1Bl8+3eL8DEkWmBPfmgEiZEwdfoS4N2MV4R8hTNSihtOi1wI1TYu+yiRPZVSF73nEz7NH
 ioCcrhdTz3BuohVekmd9n/TlWL5z2ED/nWZa/9b9uliixHYTozE13qh0eLgS30tWGDcZSyheD2 hyuxwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693953806; l=3280;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=LUHUcMKNyA83dOPlrrmnaWA5i4/IlBY2l6fBfVmfM9U=; b=hVWv1Bl4sMv0LYQIQE82UOWZwQcoZKpU37nCpmcXve6PXSeUAppfnWBKG8o2Sc2QIQM5djeKS
 FnIzN3wgWRnBEpFMC+REdneiZJ3WWh4md4Yq1nG/J3/1IjRnz1CsCLD
X-Mailer: b4 0.12.3
Message-ID: <20230905-missingvardecl2-init-main-c-v2-1-08498a9cf740@google.com>
Subject: [PATCH v2] init: fix -Wmissing-variable-declarations clang warning
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Kees Cook <keescook@chromium.org>,
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

Make `envp_init` static and provide `handle_initrd` its own copy.

This silences the warning and makes the code more readable as you no
longer have to track down extern definitions inside of `handle_initrd`.
It is now more self-contained.

Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
The kernel test robot didn't like v1 of this patch and I prefer Kees'
approach to simplifying this code anyways so I'm sending this v2.
Hopefully the CI builds clean (as I am locally using their repro).

Changes in v2:
- Make envp_init static and provide handle_initrd() with a copy (thanks Kees)
- Rebase onto mainline (2dde18cd1d8fa)
- Link to v1: https://lore.kernel.org/r/20230830-missingvardecl2-init-main-c-v1-1-59007a637259@google.com
---
Note: build-tested only.

It should be noted that `handle_initrd` has been marked as deprecated
and perhaps the entire thing can be removed as per it's own message:
| using deprecated initrd support, will be removed in 2021.
---
 init/do_mounts_initrd.c | 4 ++--
 init/main.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 425f4bcf4b77..154bd0de85a6 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -87,7 +87,7 @@ static void __init handle_initrd(char *root_device_name)
 {
 	struct subprocess_info *info;
 	static char *argv[] = { "linuxrc", NULL, };
-	extern char *envp_init[];
+	static char *envp[] = { "HOME=/", "TERM=linux", NULL, };
 	int error;
 
 	pr_warn("using deprecated initrd support, will be removed in 2021.\n");
@@ -100,7 +100,7 @@ static void __init handle_initrd(char *root_device_name)
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
+	info = call_usermodehelper_setup("/linuxrc", argv, envp,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
 	if (!info)
 		return;
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
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230830-missingvardecl2-init-main-c-93dc1013ff8a

Best regards,
--
Justin Stitt <justinstitt@google.com>

