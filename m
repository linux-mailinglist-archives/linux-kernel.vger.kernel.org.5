Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F34C7B7390
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjJCVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjJCVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:55:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB387A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:55:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdb9fe821so22100777b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696370100; x=1696974900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a34O7D75QLNIsPbv9jkIuZDS2dnhXViv0FrAp24vkuM=;
        b=cwkjOnBp+W/U4LePjLOOq9YqvwuS6aMCmVWov5eBf8yXldJIvG5uFyG85nBHxV4Tq5
         Cb4ola4eYWk5DzF3CLDCqDv10UF+5pBhaA0o5aysiLmqNwWUdBKxVc8eGMo1+a3bApIJ
         BJAIqV5XZ+xIshlU9NqlhTnK4bRTyhfQwAoCwGLenOT6KLI2j9MXVoTQTwsktr1J+0yf
         3xQoqWeG5jijiKdjN3IL+/zKvmdcA5/eNcgnMLP0YWifGloRC0vAPnpVEhJilZTPqgcH
         jJJ4AVBWd8vFSkAX4IUmNeD06XMc+h8GbcLE/emdlvvn3eiGXbShj0WW7eDewKOBSH5e
         eDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370100; x=1696974900;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a34O7D75QLNIsPbv9jkIuZDS2dnhXViv0FrAp24vkuM=;
        b=IIAYnHMzsZ+854epH0KEVDnLqhj4p08NDIVgKmEXxOij5eGA+aiSeawv3eEyBP+zQQ
         qBjao2uqX5PKoNCJqxCZgmdkh0Hxq1rkiUBd1fZRKgE+eYys6hrmMXHd83Vrun/iuK7F
         ZmL3S6uDD8lXMfh6ZWSZsW8GYR4PIX8NFx1zMl3Z8e4G3ohapDfKh51GUKtSFfYD729F
         Sj9zJ3ypU2rSuDgwzWhvSg1K9oIAHPSzRuXH18mZWUDEwPb97spsHzjWQWSZ7gQ/v1F/
         3mEY0uzTw7gE22xFfSYvr2DijspBoS2ubHFCEbfbvggz7TPKF3WUgmuZpJ5FNHgNginj
         XEhA==
X-Gm-Message-State: AOJu0YxCPNZz4h53TjGNFWcZVCNQ4c0bethabZn0GqKd9tcohoTS0CLD
        Fkuv02rFEnbS3Hwh6lhsoIcNBUFGB0WgMKTu1Q==
X-Google-Smtp-Source: AGHT+IF/GguYZiaA3U/0oiqCoh7GmySeKwqqgo51/38ZdR7OW9pjPSqP5Lbons7QQjg3A4OWl3sbt7nu9R/8AnvUiA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:b50:0:b0:d80:904d:c211 with SMTP
 id b16-20020a5b0b50000000b00d80904dc211mr9088ybr.7.1696370100160; Tue, 03 Oct
 2023 14:55:00 -0700 (PDT)
Date:   Tue, 03 Oct 2023 21:54:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALKNHGUC/42NMQ6DMBAEv4KuzkXYBDBU+UdEgQ8DlhIO2ZYFQ
 vw9Di9IscVsMXOAN84aD212gDPRestLAnnLgOZ+mQzaITHIXBZ5IwT64BZad+wdzbipComJMQz
 bNcJG6Vw3VaW1GiBZVmdGu12FV5d4tj6w269gFL/3f3cUKPChCyXKspb1WDwn5ult7sQf6M7z/ AK7Or9wzwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696370099; l=1983;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=PfoJUZKcz8zggS6f4ZS1DBK4K8u1I0Mr9PkhUy/a6XA=; b=EOuTr5sNtf5yNIHhFwCHLi3CcldhMNdQHeDS7LFD2wpobtYnAgSMDEeeIbhtkyPOd5ho0eqOT
 /o+QShgmwW4AlnFbhjd9aWiTIgtw2Af/2mOWekgELZOOoQ0SyJ5p7DG
X-Mailer: b4 0.12.3
Message-ID: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
Subject: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy works perfectly here in all cases, however, it is deprecated and
as such we should prefer more robust and less ambiguous string apis.

Let's use `strtomem_pad` as this matches the functionality of `strncpy`
and is _not_ deprecated.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update subject (thanks Kees)
- update commit message (thanks Dave)
- rebase onto mainline cbf3a2cb156a2c91
- Link to v1: https://lore.kernel.org/r/20230911-strncpy-arch-x86-coco-tdx-tdx-c-v1-1-4b38155727f3@google.com
---
Note: build-tested

Note: Ingo Molnar has some concerns about the comment being out of sync
[1] but I believe the comment still has a place as we can still
theoretically copy 64 bytes into our destination buffer without a
NUL-byte. The extra information about the 65th byte being NUL may serve
helpful to future travelers of this code. What do we think? I can drop
the comment in a v3 if needed.

[1]: https://lore.kernel.org/all/ZRc+JqO7XvyHg%2FnB@gmail.com/
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..2e1be592c220 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -119,7 +119,7 @@ static void __noreturn tdx_panic(const char *msg)
 	} message;
 
 	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
-	strncpy(message.str, msg, 64);
+	strtomem_pad(message.str, msg, '\0');
 
 	args.r8  = message.r8;
 	args.r9  = message.r9;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20230911-strncpy-arch-x86-coco-tdx-tdx-c-98b0b966bb8d

Best regards,
--
Justin Stitt <justinstitt@google.com>

