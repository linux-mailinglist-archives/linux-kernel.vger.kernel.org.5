Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B4792F9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbjIEULF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjIEULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:11:04 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C8180
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:10:30 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1bf00c27c39so3314040fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693944623; x=1694549423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4pmzv+LLCuNutmWDx5XVz6vIet3weuj1okr6x6iIDqs=;
        b=TPU6mE8hSKglsyJ4Nxkp5or/4zoZ5VLI2BO/lYaPBoQ7YKnDiXYRSojEB+RYItZQN8
         AHBoIHmcYPUJRBKEnulPf40GcFHIC22nUzTIJjPlQyY5b52wFm51WQxVgl1tChM7Wglw
         UBWmKRkOftMZgqVJ6pCsekrCRQgSIVFjXbEghL8FDKin5IGUR3KNDKgnIHi3dlH9QVvX
         60CWj5JEymFV9um6Mfz73g/n8Rs8Wi5UR0buM6ohElkLFhmksKxIBOIvXFw+gO4vb66X
         GgS9tE3CKoF0DhU+XuatGRzvztaJ5MRjwW9/Zs2W0/44BJ3s1ackmB/WdWiQcPqTZ7HE
         harg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693944623; x=1694549423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pmzv+LLCuNutmWDx5XVz6vIet3weuj1okr6x6iIDqs=;
        b=EL99nhIDky6GDNEHQq8PgKeLiyAtbyvA5gHgTnLOUce07hGNGhBK+nbSeKYSj7ClcG
         XXnmp7leiiFa/KS9el71n0OAh476QYiAF1IsDbA3aXh2YopKwQzxPeFoXqjJE0CqEJtY
         +GMEcZaphiTeLyePJ4o+48Eq2uDeWYB0NgZQ1qmOv3ugJEvwzr27s28KnnjxSr9bt+ir
         W3ie/F9h8NJSDOOAfC3lUlUUVhkBdZKGESD3CP+rULi7RNFjCezqOR8c4pm3JwYXIwhe
         usE1PnpIghkBoBXPZbA6SaoS7rqjY/deiHI6JHx8hn0+Mmy08qShIVwW2qAMmGf2M413
         cq6g==
X-Gm-Message-State: AOJu0Yz1BJk+X5U0CHrsI2Ork9KtGTPaLVZamZdaGdmGW5NJrhWJbdhJ
        aE7h7GYt2ui5DBDAI/B02qLjVD55eNC0EHgFvw==
X-Google-Smtp-Source: AGHT+IH0UAhU/aEXaLYwKV529bYDq2+IrLYFkojxcQXZZrpNvgRPipYWy3B0aEIwkrHJxkLEyoHB42gmo8sADZGiSQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:98b3:b0:1c6:7d66:d47 with
 SMTP id eg51-20020a05687098b300b001c67d660d47mr350044oab.3.1693944623730;
 Tue, 05 Sep 2023 13:10:23 -0700 (PDT)
Date:   Tue, 05 Sep 2023 20:10:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC2L92QC/33NSwqDMBCA4atI1k0xDzXtqvcoXeQx0UBrJJFQE
 e/e6MpS6WbgH5hvZhQhOIjoWswoQHLR+T4HPxVId7JvATuTG9GSslKQEscx9HqYsAy6y+NVc0w
 sM4wKZS5KoHw4BLDuvaH3R+7OxdGHafuRyLr9yyWCCbZ1Y1ktKm1qfmu9b59w1v6FVi/RvUEOD ZoNJQUHqayVRv0YbGewY4NlQxulCDQgKyBfxrIsH3BtrsE9AQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693944622; l=2237;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=t/5OxQrRWKo7ANfBmo93SLcVLgmcGRCwdycJFf2MN74=; b=3u23MHg/jPWsU7x0jAafSrxxG4WZqrLPGQs34EinIy6nacmqUYB0HuRg2pkyCwTWc6oyA62E7
 wNCh34KUVbPDkbS3QVngsClDPBUK9kMKubaBgFgZcoSnQY/jTofVttO
X-Mailer: b4 0.12.3
Message-ID: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com>
Subject: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
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
Changes in v4:
- rebase onto mainline (thanks Will)
- Link to v3: https://lore.kernel.org/r/20230831-strncpy-arch-arm64-v3-1-cdbb1e7ea5e1@google.com

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
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230810-strncpy-arch-arm64-1f3d328bd9b8

Best regards,
--
Justin Stitt <justinstitt@google.com>

