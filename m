Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D94784CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjHVWcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjHVWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:32:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7962DCDA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:32:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c8cbf0a0dso112330827b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692743569; x=1693348369;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fA58y6kJgzBHzfnsVn7PP55Ko6zDNeHiyaptbP8hBPM=;
        b=fVPPQwps4FuwglPNt5JJFXiIeIxvkJBkEGQ5P8yQGP8R7s+olUjq6t6ZD37LvtazaL
         K8CO58xXz+fZybqremaTuWMkv5p090AM9iHAakMCRCjcY2xgMBozFOEnUYXKi5tv0b4Y
         Ub/o6JhDwTN280Z9zuNc6VyWtySYjCl8jlR1a+Z6WwPiKYZpWiCsNgp5vXfO/eWtnbP4
         zY3usLdlChaPSdh7b/utdY58A2nTL3rdDXYVFZLt4HLNgTGliw/Y6FL1BVeWTbHIMcbM
         X+NKgj48aQrsv7ve6vPyrizjMRYA0CRUhrk3o5jzvEODgh4H+PFBTPvpULeLmbhO1mfv
         JwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692743569; x=1693348369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fA58y6kJgzBHzfnsVn7PP55Ko6zDNeHiyaptbP8hBPM=;
        b=aHp+wowh2+OQtbpa+Ld3jg/z5r6iq0OPDFGc6dlQiGSFI8Cjld1kQncw7ey/67fD8T
         A8ADjWJm/ogxj7hzPzr18YGWFPbJwUCodm3dgRVm5dnIpJld1MefNQ8QSAA6pV17ngJw
         OGUxeDoofUXW8984Z2A0CiNj//LkjcfykziVZXUoU6jyXvvXJjheE48ClgyNPzvENneF
         qjkYjEgCqTCmPJu2mko3oJRXoF4XIf3fhBdjtpc8W+RZ4VLXpgk7XB5qS5SuAVRj47Qn
         PkxNGwEi3C27uGlKrE49Po55uY1832p53MUXq+pQhZyHtX8cVU4ZLPJuijOUHZrnSTu8
         Ax7Q==
X-Gm-Message-State: AOJu0YxSYlNu+EcvV7uza0UPennkSTVds9/I9H/t2nW0OtNHl0zs83AR
        wkh7zrOi0hDIG3vJDguGcAAU4/+QKANWbUXIvA==
X-Google-Smtp-Source: AGHT+IFZh0rQ7VuJczmk5l7oidSEWV9g6zpecivRffcuI6BXSpcfbfLlTEvKUrgkt9QiU8W9z3jXcCeRR0Qrag2oQA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:b4e:0:b0:ca3:3341:6315 with SMTP
 id b14-20020a5b0b4e000000b00ca333416315mr173718ybr.0.1692743569748; Tue, 22
 Aug 2023 15:32:49 -0700 (PDT)
Date:   Tue, 22 Aug 2023 22:32:46 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI035WQC/x2NywqDQAwAf0VybkBTX+2vlCJLjBqo65K1ooj/3
 qUwl7nMnBDFVCI8sxNMNo26+CTFLQOenB8FtU8OlNM9b4kwruY5HOiMJ9zbGsPHrcNiM363ROd nxbIppaJHxcQFpFIwGXT/X17v6/oBxRVA73UAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692743569; l=2229;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=B99ciXRRjoy3rLzQ8ENp8FS9W+ufqjPTXj71k+5hv3U=; b=XfVh8Zjl7oJmA1k34uAMv1fhcAtT4ZZlHRTtGO9ApKXNk3paDJ/q2D9TxrSuNtUcTPYcyDNJu
 lz584UxU/ayBLfS3LQUQlwZczp1uALuzvQpjOvi2ASI3zSg4zesxct1
X-Mailer: b4 0.12.3
Message-ID: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
Subject: [PATCH] x86/platform/uv: refactor deprecated strcpy and strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy` or `strcpy`!

In this case, we can drop both the forced NUL-termination and the `... -1` from:
|       strncpy(arg, val, ACTION_LEN - 1);
as `strscpy` implicitly has this behavior.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only
---
 arch/x86/platform/uv/uv_nmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af0230e27..45d784143a13 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -205,8 +205,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 	char arg[ACTION_LEN], *p;
 
 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
+	strscpy(arg, val, ACTION_LEN);
 	p = strchr(arg, '\n');
 	if (p)
 		*p = '\0';
@@ -216,7 +215,7 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 			break;
 
 	if (i < n) {
-		strcpy(uv_nmi_action, arg);
+		strscpy(uv_nmi_action, arg, strlen(uv_nmi_action));
 		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
 		return 0;
 	}
@@ -959,7 +958,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 
 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
+			strscpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
 	}
 
 	/* Pause as all CPU's enter the NMI handler */

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-arch-x86-platform-uv-uv_nmi-474e5295c2c1

Best regards,
--
Justin Stitt <justinstitt@google.com>

