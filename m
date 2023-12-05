Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DCF805FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbjLEU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:59:06 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13431B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:59:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d340a9cf07so93308617b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701809951; x=1702414751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W7RafG7nAWDAAGrW/jUsNIHCRJDj/ZzkUDLX/nKv/hI=;
        b=bSbhY2ad88ELW9pZX6M9AVWET1WR1YpZt6ZhCraQIsAHFtR6oNI766yKez9B63i7mx
         xJWbbWx3qgK3UijO9Pygn/w4RBZtjT6kZgqav6NczRR9WBTQUjh48ShBfnf40Owp5KHM
         QYT5AK4ajSMzwUCXJdeN5zK1LqO/LTPg71Qlla74G5prsTGhz1hDqDaQm7ye+oaWIuOU
         iqzwVNZVFjSDp2blKgrGvKdBJnz3ZJNOVDbmKsf+fhdLISkiXAO0M+eaPYPkZQSIC/HW
         PxFb76uCZwNNfQVYCcLAXSKwnfNui6H3yfOB2uR4QMusQtgpTVjfReVg9Fivp+73jDZi
         Vdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809951; x=1702414751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7RafG7nAWDAAGrW/jUsNIHCRJDj/ZzkUDLX/nKv/hI=;
        b=tzXkxkazaetM4PV+LsWprBFlz2n3fcpxsl6ue62kXSR9tjtPHZ3OqhpKiAIyzGyz2H
         b3HWHxFhb79pxLS1iVSg4rmsdN4dcHXO83WQwv7NCkv3zTto0SN8t4US2k0cVdZ+qxXo
         2cFZtaZxC4L53QHMwO8uQ8oOadAXUvWNbR0Qj78bjxr01fy8y82D2+tTN3/Q5ycuG0Pg
         X29c++/oGKdz09/2yx6t4XpCk0O+xhdkD/TFDFVC9nLkud/kp7VbqPJNGkG1/In1jWHG
         vt0Jl7SDP0N92YEBQV49673nWApFE7FqaNLw9ltQ104stLHbq/5UKguLEdUmnVoVeZLk
         O4GA==
X-Gm-Message-State: AOJu0Yw/ZDO+5N2J/ejRGRinBHHngE3L0HolXjtvQJAB+Cs5+IUXTizg
        aJF0JFw+dlsEsPCaDenMuNRIdLMVroo4
X-Google-Smtp-Source: AGHT+IEOHHHkQHCm04ytFMnKqd50M5Z2PyFwnofksHuvbSlF0wfs0twpe2H4x1KbIfv/MfMzuensmACLCWaX
X-Received: from tanz.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:c4a])
 (user=tanzirh job=sendgmr) by 2002:a81:6d91:0:b0:5d8:39ca:4824 with SMTP id
 i139-20020a816d91000000b005d839ca4824mr138285ywc.4.1701809950939; Tue, 05 Dec
 2023 12:59:10 -0800 (PST)
Date:   Tue, 05 Dec 2023 20:58:53 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAyPb2UC/4XSS2rDMBCA4asEreuiGT2nq9yjdGFJI0eQxMEOp
 iXk7pWzaetQtBzB9wsNuomZp8KzeNvdxMRLmct4rgO87EQ89OeBu5LqLFCiApS6O5YwX6dyHg7
 cJ546RuUZ+2yYo6jqMnEun4/i+0edD2W+jtPX44IF1tP/Wwt00EWblLY9BnK0H8ZxOPJrHE9ij
 S3YCOAaCFm5iBqk0fvh1Jfjj1cNr6rXxjvpU/YUzNbrhterzwF0BHI689abhjfV5wyeNAUL2m6
 9/e3Ns7erR8uYQWYfaetdw7vq2UoEZcFzTFvvG95Xj30kip4gxKf3U8NT9VJlhLo7pSluPchGA GQtkO0JrbSerX8qQKuwfkLrTWDjZEjpzw7u9/s33ZJMGjMDAAA=
X-Developer-Key: i=tanzirhasanhasan@gmail.com; a=ed25519; pk=UeRjcUcv5W9AeLGEbAe2+0LptQpcY+o1Zg0LHHo7VN4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701809949; l=1597;
 i=tanzirhasanhasan@gmail.com; s=20231204; h=from:subject:message-id;
 bh=OpBF4JO9qEH0eFq9aQn9Qy1e2TtS+Dvl+rfyupEM/hU=; b=G2C30+8JBiyLP+brqVYCFRKKsEOwWYcODMl+8oBzBX4I1wKHBpcIzqzsZmbtSf8ei4tm2bXDd
 3Pj/70/QYYoBhZTVzJcLoI/enQ4fP7Pa/1o5uPYJUjjXNAO3gnbLJiY
X-Mailer: b4 0.12.3
Message-ID: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
Subject: [PATCH] lib/string: shrink lib/string.i via IWYU
From:   tanzirh@google.com
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        llvm@lists.linux.dev, Tanzir Hasan <tanzirh@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This diff uses an open source tool include-what-you-use (IWYU) to modify
the include list changing indirect includes to direct includes.
IWYU is implemented using the IWYUScripts github repository which is a tool that is
currently undergoing development. These changes seek to improve build times.

This change to lib/string.c resulted in a preprocessed size of
lib/string.i from 26371 lines to 5232 lines (-80%).

If there are any problems with the output of the tool please raise an
issue on the github.

Link: https://github.com/ClangBuiltLinux/IWYUScripts

Signed-off-by: Tanzir Hasan <tanzirh@google.com>
---

---
 lib/string.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index be26623953d2..aff066e9da9f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -16,16 +16,16 @@
 
 #define __NO_FORTIFY
 #include <linux/types.h>
+#include <asm/bitsperlong.h>
+#include <asm/bug.h>
+#include <asm/errno.h>
+#include <asm/rwonce.h>
+#include <linux/linkage.h>
+#include <linux/stddef.h>
+#include <vdso/limits.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/bug.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-
 #include <asm/unaligned.h>
-#include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
 #include <asm/page.h>
 

---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231204-libstringheader-e238e2af5eec

Best regards,
-- 
Tanzir Hasan <tanzirhasanhasan@gmail.com>

