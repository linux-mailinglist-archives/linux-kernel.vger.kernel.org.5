Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535B787845
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbjHXSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbjHXSwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:52:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4C1FC1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:52:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d72f3290e6eso180110276.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692903139; x=1693507939;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X26WvOzy5oJ3MeqlsYjn2koOcuAQQ3KEg2XfToQOxXw=;
        b=WHN+Eefh6bKrD9RWcqtDuywPxsQoonS9cjh2KaLTSVyshwXlT+KepgMTEwFJt36len
         pK/m85tQwzbyNh/5ig2PfstaXcTo31MT1xZ9hDNJp8ljRblqd0kcBs8cXYDXXa+HzxJK
         SLG0U+P9ffPbYeYlkn7/PYcutQprryagMherff3gSF1uc8ixqJUv04fT1dAhDJwJtZyL
         f8p9eXpgVb8wjYTH2k3Bj17fAQwnO0uW/WYFYuBX2u3/GYFOiXaWZvTMJ3cZqQnE0+9q
         +bB9N029QEkNY+qi5fPAsE4BjExnQTUeP4i9Gm9nbm3pE4NDXcKdFZsA46BeXI/j5Rly
         FpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692903139; x=1693507939;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X26WvOzy5oJ3MeqlsYjn2koOcuAQQ3KEg2XfToQOxXw=;
        b=d0OvTZX5G4I1BuYCHOs81hI3R8CViWZ2qKZod6DN3jSQgDh8kW3aRem11LdaatIX3I
         CtCqo0e7t6QBGo6f2czSkd40v8LApBU2VnJso9DN8rqwG7Hhd/7SPd4SeT3vGD4inR+j
         d9dOktCDZeK1iF+oNLEOrEE2octJi77q18cE52mZ252IaMda0zerbirJGho5ZYNIL9ID
         VSeDBf9vLUZyEyaALeY+kNCCoVMgwJj5w5XWLYnuv9JNKkBPQd2WO90vDUseUs5+KR+v
         T6rdTsfbPNdEUHLuHAw7rCoECj5rL8rCAWwzYzWXH7oGocb1ICepIjqD5456kAjtvU6M
         0R2Q==
X-Gm-Message-State: AOJu0Yy4h1b2GuL5C8d/G/jbCIGF0M4JAjHL8sx2G+z0qLEXT08PhQV5
        uoScdYmjLJuc3Zu1q4zQ1uX1x0Gzd2BxElrgFw==
X-Google-Smtp-Source: AGHT+IE+JiRZwWrLWvtRDI0jKIK2Z0+jDYHzkX+1eVQb7ZeOGGU1kMrCDY//zkdFEp6Gk/TjP2vGDgxa0BNolPEFzw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:24d8:0:b0:d3f:5b2:e89e with SMTP
 id k207-20020a2524d8000000b00d3f05b2e89emr223020ybk.6.1692903139428; Thu, 24
 Aug 2023 11:52:19 -0700 (PDT)
Date:   Thu, 24 Aug 2023 18:52:18 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOGm52QC/5WNQQqDMBBFryKz7hQzaqtd9R5FisRRBzSRxAZFv
 HtTb1D4m/cX7+3g2Ql7eCQ7OA7ixZoIdElAD43pGaWNDJRSlpZE6Bdn9Lxh4/SAa3nDeWyWzro
 JPyHubSbB/J5zQVWhSSuIptlxJ+tZedWRB/GLddsZDer3/ucPChVWmeqoyrOW0/bZW9uPfNV2g vo4ji+9LS721wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692903138; l=3362;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ew5SyseFI+/34xeeHZRp+glk59V46DA9p5hpUEsbe4Q=; b=X6W0Xg6w2Sz0OjN2608y1zuc9ebtDeA76/E4FRwcXuXjB1OWEazDVEl+K9drE1HtPXOmbpdza
 uyxvM/APzMwCAcN39JjEYCwBsc2Oz6qgb0KflN+TrfK1IH1qesmw10y
X-Mailer: b4 0.12.3
Message-ID: <20230824-strncpy-arch-x86-platform-uv-uv_nmi-v2-1-e16d9a3ec570@google.com>
Subject: [PATCH v2] x86/platform/uv: refactor deprecated strcpy and strncpy
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
        Yang Yang <yang.yang29@zte.com.cn>,
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

Also include slight refactor to code removing possible new-line chars as
per Yang Yang's work at [3]. This reduces code size and complexity by
using more robust and better understood interfaces.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://lore.kernel.org/all/202212091545310085328@zte.com.cn/ [3]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use `sizeof` on destination string instead of `strlen` (thanks Andy, Kees and Dimitri)
- refactor code to remove potential new-line chars (thanks Yang Yang and Andy)
- Link to v1: https://lore.kernel.org/r/20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com
---
Note: build-tested only

Another thing, Yang Yang's patch [3] had some review from Andy regarding
the use of `-1` and `+1` in and around the strnchrnul invocation. I
believe Yang Yang's original implementation is correct but let's also
just use sizeof(arg) instead of ACTION_LEN.

Here's a godbolt link detailing some findings around the new-line
refactor in response to Andy's feedback: https://godbolt.org/z/K8drG3oq5
---
 arch/x86/platform/uv/uv_nmi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index a60af0230e27..913347b2b9ab 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -202,21 +202,17 @@ static int param_set_action(const char *val, const struct kernel_param *kp)
 {
 	int i;
 	int n = ARRAY_SIZE(valid_acts);
-	char arg[ACTION_LEN], *p;
+	char arg[ACTION_LEN];
 
 	/* (remove possible '\n') */
-	strncpy(arg, val, ACTION_LEN - 1);
-	arg[ACTION_LEN - 1] = '\0';
-	p = strchr(arg, '\n');
-	if (p)
-		*p = '\0';
+	strscpy(arg, val, strnchrnul(val, sizeof(arg) - 1, '\n') - val + 1);
 
 	for (i = 0; i < n; i++)
 		if (!strcmp(arg, valid_acts[i].action))
 			break;
 
 	if (i < n) {
-		strcpy(uv_nmi_action, arg);
+		strscpy(uv_nmi_action, arg, sizeof(uv_nmi_action));
 		pr_info("UV: New NMI action:%s\n", uv_nmi_action);
 		return 0;
 	}
@@ -959,7 +955,7 @@ static int uv_handle_nmi(unsigned int reason, struct pt_regs *regs)
 
 		/* Unexpected return, revert action to "dump" */
 		if (master)
-			strncpy(uv_nmi_action, "dump", strlen(uv_nmi_action));
+			strscpy(uv_nmi_action, "dump", sizeof(uv_nmi_action));
 	}
 
 	/* Pause as all CPU's enter the NMI handler */

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230822-strncpy-arch-x86-platform-uv-uv_nmi-474e5295c2c1

Best regards,
--
Justin Stitt <justinstitt@google.com>

