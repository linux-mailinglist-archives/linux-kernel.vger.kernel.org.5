Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48D7794B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjHKQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHKQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:33:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C218F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:33:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so2096614276.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691771637; x=1692376437;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M6OUxq5MRWIwo820poqhdTN5aSCn+WIZs4Yefeliges=;
        b=00HrlpQ2j2D+1J0rPvMY83N/fK7KS2utURj8FbcclPYbcpqVBq52Dyk5uoyPNEq1yH
         1ZldUo/0x4j6NTq4J/0TDa1V+wTrRwphrZFwH94vWHMBV62uY6j/Hw2Ey1W+RQiGx8mK
         cp1Q1JgV5qpzuX4Y95uJbjq+92tS9ZLe6FVfLDgLOTrEyIbz8Mnh/e800N3pi5WIkkIe
         q/qcVSqisR1EBTG++6AKQDTO2ic+T6ES/Hh00r1/knUlHk5lrFGCHKt0mzv5MmHMEfEX
         7PP1eV6xk5W+fB5Kokb+exOQbz1vVpLLSm4cETk7vLdfiw566tPv3hxHUjDQXZBizGPY
         1oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771637; x=1692376437;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6OUxq5MRWIwo820poqhdTN5aSCn+WIZs4Yefeliges=;
        b=KaZROSotXsLewBi8I5UawiGyhYbyixl4O8tmOg0KlQ54d+ARHxmepeEgoO62W/xKil
         qAQLTPeIGxdYuBZnCPUPsviKWx67wsf4RhoKJuwR8MPWPkss3XrMmxzoRxNGKk8eMvVB
         Hrb/bOtkJRGOHteQhRxdmSjE/XKLkD27jvn5c/OWXlV1I5RjlGZ1ghUZGCBtdUb9lSFV
         bKxL85Agd7abTRxvCcUEQZwEd0Zid629XoLDdTORDMOchI7Kuj5wAtDie3M8px4wi+0n
         gHM09PwGa1HUCnrjklhlGLqwC241I1ekO9qdSLffirtdjKQXSYoqjVMhDvNtQK9h+i+Z
         ZMzA==
X-Gm-Message-State: AOJu0YxaXTFx35faPzuOkpGwJy150zqs41+Vy8yK3ga5CO3h3i0//aXX
        frIKLnY9zVTea+wp8H7x3WX4WJcA+wg2nwmiJA==
X-Google-Smtp-Source: AGHT+IG2n+cZRj98+MXV3Srxy52M5SH6ZVNgiFpcuwQQnUPFy5Ohyjbx9lT+2aYY08RyVtB7NWtTaVQRb9zBRtWOdA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4ca:0:b0:d47:f09c:cc8e with SMTP
 id 193-20020a2504ca000000b00d47f09ccc8emr35802ybe.10.1691771637249; Fri, 11
 Aug 2023 09:33:57 -0700 (PDT)
Date:   Fri, 11 Aug 2023 16:33:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO5i1mQC/32NSwqDMBiEryL/uil52DR11XsUF5o31EQSCRXJ3
 Zt6gG4GvoH55oCsk9cZhu6ApIvPPoYG9NKBdFOwGnnVGCimDAuCUd5SkOuOpiRdi4X3iBimGBW
 zeswC2nBN2vjPKX2NjZ3PW0z7+VHIr/2rKwQRZPjdMC5uUvH+aWO0b32VcYGx1voFUfuvfLUAA AA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691771636; l=2211;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=6DzOCDhVK8QrlXFdb8qJxWTXZA/HZ69ASisG5d0HdUE=; b=UluTDfd96B3b7YGEMVMhWFJDv4OqE5Gk8RMCyISg7TZSa7p9jrkSHI8K6SYDWfn34DYlMDcXA
 OEQdku5MxTVBe7+kmDLsEXusbKTldqz+v6/B2F2mQ2c4CpxFm3hpWwL
X-Mailer: b4 0.12.3
Message-ID: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
Subject: [PATCH v2] arm64/sysreg: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1]. Which seems to be the case here due to the forceful setting of `buf`'s
tail to 0.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, we can simplify the logic and also check for any silent
truncation by using `strscpy`'s return value.

This should have no functional change and yet uses a more robust and
less ambiguous interface whilst reducing code complexity.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Suggested-by: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Utilize return value from strscpy and check for truncation (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230810-strncpy-arch-arm64-v1-1-f67f3685cd64@google.com
---
For reference, see a part of `strscpy`'s implementation here:

|	/* Hit buffer length without finding a NUL; force NUL-termination. */
|	if (res)
|		dest[res-1] = '\0';

Note: compile tested
---
 arch/arm64/kernel/idreg-override.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 2fe2491b692c..aee12c75b738 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -262,9 +262,9 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 		if (!len)
 			return;
 
-		len = min(len, ARRAY_SIZE(buf) - 1);
-		strncpy(buf, cmdline, len);
-		buf[len] = 0;
+		len = strscpy(buf, cmdline, ARRAY_SIZE(buf));
+		if (len == -E2BIG)
+			len = ARRAY_SIZE(buf) - 1;
 
 		if (strcmp(buf, "--") == 0)
 			return;

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Best regards,
--
Justin Stitt <justinstitt@google.com>

