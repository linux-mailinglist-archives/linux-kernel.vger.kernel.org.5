Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA83B77994E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbjHKVTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:19:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784542129
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so28358587b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691788766; x=1692393566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vokOFglu6CNVFlD6jFxpsLrBcNE5errPjKaL6LUnglg=;
        b=tOsdQnkRdFPySXJ7aBEL+kY5112HthEEIawDywYABXxp9YXRYroZTrYNW87VUbeR6w
         gnfsPvSydIxNPCx/RPtTkwb6RerMKsEuJIyl7U/C3waNbaU7wr0JImPoka2YzlVj0Ih8
         6pjOc1L9fBFcSIVBUDCD8S6uX7hs8crgEnCNZot4mKk3eGHefKgu8OYgILc1VkUwX0Wl
         H7pBqE0CQNiBloC4RhooFEGfnMWOFZzd60L6EAZXRDFhGV2IqF04UdrS/6MXav7kuvc8
         66Sk1UukGjP11WxYjJFMcVJQXQF9NcICKPD23LYMz+JPCT1jjKnprYFqeweidJ1zEKsy
         tNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691788766; x=1692393566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vokOFglu6CNVFlD6jFxpsLrBcNE5errPjKaL6LUnglg=;
        b=KLfZY0y1wLY6IbA8RCrSoNdm75jiuWB2ujQVvMfg9UYG9qPxFE1iOxV+84Azt+QxAW
         Q/NUzxXCXK8bxmnrzho8t18vDY8BvGEVMXf7Bmr1zmoTJY2BS5IzIT2Pl9YRXKtHfSMx
         z68tYc/7KhCinxhAagzsRVyo/Zl8HSKxpER6/OzMSee5kL6KaSPZoCWvcvuCtBGelVMm
         dLsvWNzo1M+ps1QuSTWd1lkHC6T6WWHJd0CfK3j0jDYDXZUg/GB/bcO61CDxU3kyVs5J
         iYAXZMBw9dLrI9/QG6ocPxFkwnPJF+NhKk8hoTgRkZs31MDEP2S8saHv7CqEuSNq69oq
         F25Q==
X-Gm-Message-State: AOJu0YygRBjpTKypA2yaoNgnnfst4LMg/2zF4UvrdhJlfagSpN74r+co
        FfjsmbmM2afUJHh9Pkx2sXZ5Vxg6k50j5Gl01A==
X-Google-Smtp-Source: AGHT+IH3i5ZHuMThcQNM8zp+I7k8FNd7+Of/quUCUxdMUbD/p45+H7KNRGfsu23iJhRFAio31HZ5RFrQ44ATxZZpGQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dcc2:0:b0:d12:d6e4:a08f with SMTP
 id y185-20020a25dcc2000000b00d12d6e4a08fmr47833ybe.6.1691788766690; Fri, 11
 Aug 2023 14:19:26 -0700 (PDT)
Date:   Fri, 11 Aug 2023 21:19:19 +0000
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
Mime-Version: 1.0
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691788764; l=878;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rykhGlCJgq/28Gofw5R06xkjvMhLluFR9H0cPPJUQmM=; b=dqa+uC3ZSEDoM05puhWT3wolaXk7hfvs4+6yIWB8tO66gB9QZCYN9RSLwV2BvBVVbMLw1tvkc
 4a2Vy7MXx8vCn44O2/F7Pbs8dDN7gJ5VA3oINrtf5Q66VN6jNZDUZnG
X-Mailer: b4 0.12.3
Message-ID: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-1-301052a5663e@google.com>
Subject: [PATCH RFC 1/3] powerpc/ps3: refactor strncpy usage attempt 1
From:   Justin Stitt <justinstitt@google.com>
To:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
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

This approach simply replicates the implementation of `make_field` which
means we drop `strncpy` for `memcpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/powerpc/platforms/ps3/repository.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 205763061a2d..1abe33fbe529 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -73,9 +73,9 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 
 static u64 make_first_field(const char *text, u64 index)
 {
-	u64 n;
+	u64 n = 0;
 
-	strncpy((char *)&n, text, 8);
+	memcpy((char *)&n, text, strnlen(text, sizeof(n)));
 	return PS3_VENDOR_ID_NONE + (n >> 32) + index;
 }
 

-- 
2.41.0.640.ga95def55d0-goog

