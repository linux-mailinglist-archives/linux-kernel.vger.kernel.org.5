Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660F7772B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHGQvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:51:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32EB9D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 09:50:59 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586a5ac5c29so41664667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691427059; x=1692031859;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DH1RGsmuAo7vrM49oUA1O8QELPBtiixKmknDzKlrMs=;
        b=UcHqa2R41JL5C38LwWIBt1mJ8uByZE/Xlbtryhjq0yCeZ6PnmszUdnIGGJIDIeCLi8
         izw5ctPRXAuigX+MwUivoQlyykmafMQntoahk+xwngh3F3EGGkXCPyGtgs7pDJHUztcc
         KgP4bdF8yo/CXbiMEgD74mER7n9AKk1iGRVqBEq7wfXQoeiJ+xiH7ifIbrHM4f5b2k4l
         IOoba3EUMrJutY0FqS3n3c6i49D0hNSdz7Q+U3XzX3L9+0JhBUN87PvlQGHGV67XrqX6
         aqL2eFZEpykmK3Mg3eJCmPZlMl3hQE0z+z7JMNgBk1YUtISVT/vwtxVMll1SH7S/k/41
         l7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427059; x=1692031859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DH1RGsmuAo7vrM49oUA1O8QELPBtiixKmknDzKlrMs=;
        b=gr+yac4XzebsQCnewZMgWEUieIhh9JEztH6QgTdBlpBQuOUg6YO+bCFx6vNFWGBqFu
         RJROBchOkwSF6h+gl5arpBd3NiMmM0GBSE6ITa9HThqp3Rfw/D6fYC7hcEZKMXol49yd
         knkOEDWXR8Oc17DnsMbhJZz1IvzG92ORlGx+7DmuZiX1Q/tv3XV4OUejBTLuzU7PsaRM
         8vQw4anfFi1H8dQ0EGy88vTrfGnoWZ2mT/iixio+dH0hiXWnSvRDewD1g+ARWkJ5NT7r
         /6WFCSqahqYBIPJJkA19z/Q4/TcEr81SebG7EQ7qJUXPJ8piZAvwOhbej2/uClNl/I9P
         49Tw==
X-Gm-Message-State: AOJu0YxN0w1V5Te9wgViyMmFE3v7duFJ1NAaJ6rcXF6PcjQqFybgMMgO
        yi7dMatPK05JTpVajspjLFqCfZd3SZGSL1FvVvU=
X-Google-Smtp-Source: AGHT+IGuAP8rnQ8ZbxkJ9M/ve9RTC6jY6Usa6MkjZJQMxI+QRocRxszMBKkMFRYH6dyg+LQrAT7iExlQ5heullsOMDA=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:4746:957d:1a28:5104])
 (user=ndesaulniers job=sendgmr) by 2002:a81:b144:0:b0:56f:f77c:3c7d with SMTP
 id p65-20020a81b144000000b0056ff77c3c7dmr77675ywh.3.1691427058981; Mon, 07
 Aug 2023 09:50:58 -0700 (PDT)
Date:   Mon, 07 Aug 2023 09:50:32 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANcg0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3dzM4uLMvPT4gqL8knxdg+QkS4PUZDMTU5NkJaCegqLUtMwKsHn RsbW1AANxIeRfAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691427057; l=1415;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=3s6B3WRHZwONDqr660gEy+YqAcQ7kOQd/SC/ue2x6Kc=; b=o9mPOXezO1m1peqnQnJ9Xh9NmpG6OGUleGqyCPai/FHu3L5j1iHQdxfIhbIC4aYIa1C1emYrj
 fT1jBNQi6XgDsLGtvc8W9xWd9BF1MF+sBN52XQfIibvFQNPns+iYt/y
X-Mailer: b4 0.12.3
Message-ID: <20230807-missing_proto-v1-1-7f566b7ba5ca@google.com>
Subject: [PATCH] Makefile.extrawarn: enable -Wmissing-variable-declarations
 for W=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
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

I noticed Tom was sending patches where smatch was recommending
annotating functions as static when no previous declaration existed.
Surely the compiler could make such recommendations as well, I thought.

Looks like -Wmissing-variable-declarations can make such
recommendations.

GCC just added support for this warning (gcc 14.1.0 will ship with
support), and all versions of clang relevant to building the kernel
support this flag.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 40cd13eca82e..617739eb84e2 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -32,6 +32,7 @@ KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
 KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
+KBUILD_CFLAGS += $(call cc-option, -Wmissing-varibale-declarations)
 # The following turn off the warnings enabled by -Wextra
 KBUILD_CFLAGS += -Wno-missing-field-initializers
 KBUILD_CFLAGS += -Wno-sign-compare

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230807-missing_proto-0cb90ec6454c

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

