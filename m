Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDD774D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjHHV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbjHHV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:28:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F18526D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:17:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d07cb52a768so6583422276.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691529458; x=1692134258;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3FDxtd5TTI0yB6OcEaflPtTwnfjpX0FPpXrLyaUzpnI=;
        b=ym9wbg9V5cG40hCkLxqz65tC4ED2P5AeQdHne3t/UygEjzZr8/a5m8SwO/AKizXomx
         u8fEjD+U7gQowx2Dzh3O8+5wk3+PNe7gLkjAJevXZ83D5L8qAAo1cTMY/xAm2FCva8Uo
         lbE0sLMOv4JtHE0YJU0tm49XmoGTvbj9P5GejXYtzRdmdWTFMl8J4dkbFKPaogpQoiER
         4M7ck4LYlq5wCT989oZGduI+9Gx1DkTpCRIQQwzp5P3YARB34JJpq8lPHe9TEaOgr2F/
         xvcUIK3cM/5fqej6ththcBfzqr0IbuQZnZCPkRH12fbhzkri0s6VksUok8wtQMbszUG9
         vFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529458; x=1692134258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3FDxtd5TTI0yB6OcEaflPtTwnfjpX0FPpXrLyaUzpnI=;
        b=WKSq/blrjx+f2Tg0lvqJeLczqM4n+b9pfkJqrJewPWXrE3D9JWxKNZ2U+CdePcN7Mj
         N0Xjhz94KaFnFIELN/RdJjQkhz5jnfh6/tQx3s0svkIlJGWz2Sfz+pMp0ne03iJdY8C2
         1aF3RBG1lwd3UyRzFQ/ksvsAMZ8pEg5Surd3ilpmu1oSU4naMEiTlIagiCwc7Tr7tmNJ
         CWAo+pYGdU8PljHk7caXcMpXfVLv3UY2jRgu5kr2wfFVTw+Y47c+HtnzXqQmoAUz+lTO
         Y5j0UBBz+DqvLphIWZglJlw7kCo8BR5oxV96Q9WE0QssrFVuVtG5jv0bfHcox9h3pDVN
         +3Ug==
X-Gm-Message-State: AOJu0YwSXL3/PM08OS1ua/f/bRH8XMbAPtxOl0CYsQhTH6MtHUZQnBWM
        ZZwuyKioID+h9z0dw1iSGsdMpbDJNNDE8NyEOw==
X-Google-Smtp-Source: AGHT+IHRpFBahWyCsqDq2Jymqy4KmoaI/LjbwJfXSlsnxSeNP0O276Z+TuKwYj/2pYJWPJENuDtYuJ/tH9GWqqAQXw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:e78e:0:b0:d0a:86fc:536c with SMTP
 id e136-20020a25e78e000000b00d0a86fc536cmr15189ybh.2.1691529457883; Tue, 08
 Aug 2023 14:17:37 -0700 (PDT)
Date:   Tue, 08 Aug 2023 21:17:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAO6w0mQC/2XMSw7CIBSF4a00dyyGl9I6ch+mg0Ivj8QWA0o0D
 XsXO3X4n5x8G2RMATNcug0SlpBDXFvwQwfGT6tDEubWwCkXtKeKTMl48lqIQMulZEJyhdDej4Q 2vHfpNrb2IT9j+uxwYb/13yiMMNKfZ62tPg2KDlcXo7vj0cQFxlrrFxsjY9GfAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691529456; l=1882;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tgWFws4763lrVU2WbDNesL8iVYR+q5vLBUC0Li+5Ak0=; b=vgzwPI9m0aHfamLtzCxThUgHXsLWmmm/NJ8qfrQFiLO/W00KK2zwHm+9PrMop2SNbVKZcF4s5
 FZtwZaG/Ic9CA3qj/qsfoXSdwko4/YOOl7N7PSyX01aDoDWnVNxCuru
X-Mailer: b4 0.12.3
Message-ID: <20230808-arch-um-v2-1-5fbe76eaf853@google.com>
Subject: [PATCH v2] um: refactor deprecated strncpy to strtomem
From:   Justin Stitt <justinstitt@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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

Favor a more robust and less ambiguous interface over `strncpy`.

Use `strtomem` here since `console_buf` is not expected to be
NUL-terminated.

Also mark char buffer as `__nonstring` as per Kees' suggestion here [1]

Link: https://github.com/KSPP/linux/issues/90 [1]
Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Keep usage of ARRAY_SIZE (thanks Bill)
- Remove unnecessary import (thanks Kees and Bill)
- Link to v1: https://lore.kernel.org/r/20230807-arch-um-v1-1-86dbbfb59709@google.com
---
Notes:
I only build tested this patch.

I am also making an assumption that `console_buf` need not be
NUL-terminated. Am I right in believing this?
---
 arch/um/drivers/mconsole_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 5026e7b9adfe..d5fa9c8dcd18 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -554,7 +554,7 @@ struct mconsole_output {
 
 static DEFINE_SPINLOCK(client_lock);
 static LIST_HEAD(clients);
-static char console_buf[MCONSOLE_MAX_DATA];
+static char console_buf[MCONSOLE_MAX_DATA] __nonstring;
 
 static void console_write(struct console *console, const char *string,
 			  unsigned int len)
@@ -567,7 +567,7 @@ static void console_write(struct console *console, const char *string,
 
 	while (len > 0) {
 		n = min((size_t) len, ARRAY_SIZE(console_buf));
-		strncpy(console_buf, string, n);
+		strtomem(console_buf, string);
 		string += n;
 		len -= n;
 

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-3ef24413427e

Best regards,
--
Justin Stitt <justinstitt@google.com>

