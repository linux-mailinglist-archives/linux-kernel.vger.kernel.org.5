Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5873177311B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHGVSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHGVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:18:08 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255EEE68
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:18:07 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1bf94d4d2f4so6503337fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=iXvXoonIYBdhMFviyOkoygmsJIyTGeBeq4/AOnBxytLBvQQhjalGqFzg7pCH7KQxfF
         eKRi5WxgelqBpHePErOT2Bt5zN88BKI9miy34Avnyz48BfPkNp3qp1t/NvRGeLfMSMBu
         ZKa+3pwQi71GXW9fVgOgw5fIB079W+CRsJHTp+GUGaJsCoY+4M1QuK58KCYVKIgKNQhZ
         MDzIdOWmfwnJvoSd7P4iHZp6p3yo4EwP6d7k43C+57isSu04UsZzVLz9k1QVhs9iHeMp
         JDzFnnEmAS8cBGV9g1gv2aE9flzX+CV9jCKD2QZUmxpSkE8tujbKDIBT7w8/Lgv1ixP2
         1iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443085; x=1692047885;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mfCIyPm2aO7x0iXfdEGub/+bSKhcssAHTeROw2F55I=;
        b=e/OkIZZFovgapgdV1o+hx2igl+Dj+eoscXiMdX9182gOyTVS3/03ylLY7T5/DHwmvJ
         DnuGMFpTC1K09/uYwkGk/TqRv+uppfF5dYpRxMli1owjiEt8TSZ0QetaPBVXbzokwhrS
         Zf94IZkBQeAAC3cjUQGEDo75pgj1kyt/0UJU87gwS1k/uQYe/UzGbZ4ckPz8fz5y6thy
         bFuJnHWASPwWecf4kxQTrRu8r6F6CL+DINZeAqJvxMFOWTiuoiwn1GeCZxfiBRgU7h+9
         hX/jDJE2ST6PE/bIuNK4G8b4as7zPyWYJZDDvaFguOW4+05wp6/uRmexcE0Tc++0UolM
         pc5A==
X-Gm-Message-State: AOJu0YwWFrM23nGjuejJu4Gfl9scjIMfA83WACyoohATS0/sguHQhHGK
        4+GwmZS9sgldN+boLMzNdRcSGHuDSAJDij62xg==
X-Google-Smtp-Source: AGHT+IGr5rwXC6cUJHtMMxiCQlU0uuF7YpzxMjNzb/DWy220WGAU/2ZgbGEhlaruYZWPZNrBVnzaPnyS5y+0Klm1ew==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:3a0f:b0:1bf:d7b9:9960 with
 SMTP id du15-20020a0568703a0f00b001bfd7b99960mr7527734oab.2.1691443085255;
 Mon, 07 Aug 2023 14:18:05 -0700 (PDT)
Date:   Mon, 07 Aug 2023 21:17:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAINf0WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3cSi5Azd0lxd49Q0IxMTQ2MTI/NUJaDqgqLUtMwKsEnRsbW1AHb 5zV9ZAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691443084; l=1886;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=29NvDKooXX0ph89b44s4wsreDRVLQpWCZn8WSLtPy8Y=; b=E9ZtbxM3R6Zqci4MF+SDmmhn3TxUgdCPU66xW4h3e6fKqBfhSZq9iL/ienwg97ORyGw56fXX+
 9sD/afEHAV+BT4wvqLe0apqEsuO1EjSbbcyG+J/cbR93lW9E0n3XX51
X-Mailer: b4 0.12.3
Message-ID: <20230807-arch-um-v1-1-86dbbfb59709@google.com>
Subject: [PATCH] um: refactor deprecated strncpy to strtomem
From:   Justin Stitt <justinstitt@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `strtomem` here since `console_buf` is not expected to be
NUL-terminated. We should probably also just use `MCONSOLE_MAX_DATA`
instead of using `ARRAY_SIZE()` for every iteration of the loop.

Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]

Finally, follow checkpatch's recommendation of using `min_t` over `min`

Link: https://github.com/KSPP/linux/issues/90 [1]
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Notes:
I only build tested this patch.
---
 arch/um/drivers/mconsole_kern.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..fd4c024202ae 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include "linux/compiler_attributes.h"
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -554,7 +555,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -566,8 +567,8 @@ static void console_write(struct console *console, const char *string,
 		return;
 
 	while (len > 0) {
-		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		n = min_t(size_t, len, MCONSOLE_MAX_DATA);
+		strtomem(console_buf, string);
 		string += n;
 		len -= n;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-3ef24413427e

Best regards,
--
Justin Stitt <justinstitt@google.com>

