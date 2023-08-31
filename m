Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0A78F5DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbjHaW4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjHaW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:56:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63913E8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:56:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d37b541a2so16304387b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693522561; x=1694127361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H79tqtkFxOTIaPm0anlf53bqJoiLdlNKrFELszTm5Gw=;
        b=MseydaOssGZssQj55x2ePVsV3i9nHAIcKwjwVQJ3UI/Z0+1VutiL7oqxlPrPUzoRT5
         jZqgBPcweOyNPvHFiAGsGuZLAmexCTaGbYJ6+vm9PpG3NOSn2jDk/FR+/NCLrLmAXz4A
         tpjco/lhDacNV1/Ob8jo8mt8UuFK+719g2edEHfCwBR9VAtubRBFugBpknKO8HRHLW4m
         FlG3d6MYb6Zg/QmzQ4fCdIrtQX0VzDJ+K5K6b2dX8dz7a0ujivOM4lRZ1o1IhQ2P9XcK
         TY+2WOrcUqlwUmvtPB0qYNhp7kXVC1PIEv0fgk8EF5JUHu5MtPuWikiiACex9jZNU1Oq
         hGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693522561; x=1694127361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H79tqtkFxOTIaPm0anlf53bqJoiLdlNKrFELszTm5Gw=;
        b=INhWaGtJ6tDQFKFG9oURsCaF0hJ0AKeKJzUOlug0bIy0Z8MgvMZZNIVTrMsrATJKLQ
         /zCWEfUBxaQ+NtA3liRHsqjalgolmW7H1zujbJEGVFEUglLyduCmYJJjivrxbc9sJYD6
         mHaMGB0j4WFC1pjQlkHoAc1jbVlw5YE7UBoz/aj+KAOatZh1mk81dCkEIOimMLUhuogU
         613MSk1HL4dLYZm6+FDKwgYAtf2fqkpZgyrGV4SZQsuWvzT0Td4ToUYtSh77eyFpJTuO
         5EnMowxsoyWTu/FkRBhOS/5Lb7PRo2pLoBj5mgHxHd7nXRdICWmy7c4wVDElVgcQA4Kl
         31Ww==
X-Gm-Message-State: AOJu0YyyGH9llG0QpgCZZfEpDYhuny38BSVXJN9XOBCDzwMuunnCQFnE
        yDRZ3kwyh2xjICxlXVuEC93+Fb1lnjC+cyTKyw==
X-Google-Smtp-Source: AGHT+IGj8I2gApCT6f0stLt5hwiS0cmyXd8XpszKLFXEY1w1ikE4ddIOWtE3uTUZFkU94/ZHLrW2jX+3UtI6UXsEqA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:ec51:0:b0:58c:74ec:3397 with SMTP
 id r17-20020a0dec51000000b0058c74ec3397mr21288ywn.1.1693522561645; Thu, 31
 Aug 2023 15:56:01 -0700 (PDT)
Date:   Thu, 31 Aug 2023 22:55:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH4a8WQC/33NSwrCMBCA4auUWRtpkhqjK+8hLvKYtAHblKQES
 +ndTbtSEDcD/8B8s0DC6DHBtVogYvbJh6EEP1RgOjW0SLwtDaxmvJa0JmmKgxlnoqLpyuhFQ6j
 jljOp7UVLKIdjROdfO3p/lO58mkKc9x+Zbtu/XKaEEifOjgt5MlY0tzaE9olHE3rYvMw+DfrTY MXQSjaotHPK6i9jXdc3c5yyZPkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693522560; l=2344;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=jcftR3X/PMbZ42L+D1HsjAvA7HB7jpnc40CSZbF0QLc=; b=h9yAgZACyhn/QolvVgpLQwN1MmOek1G4ASoDPs3JEfR47C1tq6QP596bWShg4JXHPFCRpg4CC
 hnGxOeJBfv5D1KAxBM75rhrATRH/Xeau4sTmix922O0vfSx3uBSnS4i
X-Mailer: b4 0.12.3
Message-ID: <20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com>
Subject: [PATCH v3] arm64/sysreg: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mostafa Saleh <smostafa@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
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

strncpy is deprecated [1] and should not be used if the src string is
not NUL-terminated.

When dealing with `cmdline` we are counting the number of characters
until a space then copying these over into `buf`. Let's not use any of
the str*() functions since the src string is not necessarily NUL-terminated.

Prefer `memcpy()` alongside a forced NUL-termination as it more
accurately describes what is going on within this function, i.e: copying
from non NUL-terminated buffer into a NUL-terminated buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Here's a quick rundown on the history of this patch:
1) v1 (changes requested)
2) v2 (applied to arm64 (for-next/misc))
3) v2 reverted (https://lore.kernel.org/all/20230831162227.2307863-1-smostafa@google.com/)
4) v3 (fixes problems with both v1 and v2)

Changes in v3:
- Fix faulty logic and use memcpy over strscpy (thanks Mostafa and Kees)
- Use '\0' instead of 0 to make it abundantly clear that `buf` is a NUL-terminated string
- Link to v2: https://lore.kernel.org/r/20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com

Changes in v2:
- Utilize return value from strscpy and check for truncation (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com
---
 arch/arm64/kernel/idreg-override.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2fe2491b692c..3addc09f8746 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -263,8 +263,8 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 			return;
 
 		len = min(len, ARRAY_SIZE(buf) - 1);
-		strncpy(buf, cmdline, len);
-		buf[len] = 0;
+		memcpy(buf, cmdline, len);
+		buf[len] = '\0';
 
 		if (strcmp(buf, "--") == 0)
 			return;

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Best regards,
--
Justin Stitt <justinstitt@google.com>

