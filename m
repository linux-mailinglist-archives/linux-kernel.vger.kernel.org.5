Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5426476F4A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHCVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjHCVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:33:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE93581
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:33:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso1488510276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691098431; x=1691703231;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9a1CX278YGq0zGZWP+f0LaA5pxcSpZKfqzUpq5J0Xvg=;
        b=IR5xzMKe8szTmxl4p2ho1ObEqwy8naF4E4qnmDtBq7lAxEtsU16tQj/R4R5qESegez
         PkrsM289xscbVMOJUdfqB4yLgjio6Z6UyTQ5akbsqRMVo/0CI6G846MYZvRY5SnSnkmz
         tLPxmo4niw2nNfzxnBiONXV83evUYWw26lriJf75L9atmgvwAuNI5FQTSgUw4k4iWQrK
         UI9t5ZYCmE3/x2kIcQyQMLaEOC8LoQHmUO9+YULFdo01f+mC99FiBoEx3M4fWkTeeb98
         lRZqa6RGf+ZJ9wu3iOqQHRY2Gzg59Ca7BS8kxvbQPHU1PAbEiHR33FOvMQ5ucfGAtJAx
         QPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691098431; x=1691703231;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9a1CX278YGq0zGZWP+f0LaA5pxcSpZKfqzUpq5J0Xvg=;
        b=LMfUuwzFbO4RpO1QImf4aQOJ205OLjGBZ0BlM3UH7rIn2l5czgJ+tP2bDKY6FLPxMW
         39EgO52ancCIcHRTUbQjzmLH1I2WAqZXEc/6hv6wSTgWRQtiT7mmnwvQOnzZ9c/bGDH4
         BhBVesCh8b2S1MsT0k0ipF8NfiNk+HM8Wty1C4PjPTDxOUnEw1M+zRuD4m0d1UR6Dugo
         C/4yDLMcPDGEB1jFH2FDaOgQdZRfa279pKQDopld/D2f4+GNWxxNhlp1IkobNiDZw4aq
         oFBp+YEJxmVM+PMEJHmXOezPM6fa9sNI6IDEPSMAVPSruxcWaOI/Uk2QiAUMNQEIRzCp
         w2/A==
X-Gm-Message-State: ABy/qLZg46EYG+L77MJOLsraR4qJ8+pQbsVK+giElkZ4BbYE8ad8lEOZ
        DAWKIjcikMBDCpaNrWSxDOie0qFf0aqn+ZQuwg==
X-Google-Smtp-Source: APBJJlEW3o5TROn1f+epZr1wpavKrHKIJTzw/zt8fdpICa5F0hhCkgMlH8XVXr9P//1ALSRc4iTaSp9JZuKiANeApg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d24d:0:b0:d08:ea77:52d4 with SMTP
 id j74-20020a25d24d000000b00d08ea7752d4mr138360ybg.12.1691098431718; Thu, 03
 Aug 2023 14:33:51 -0700 (PDT)
Date:   Thu, 03 Aug 2023 21:33:44 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADcdzGQC/x3MQQqAIBBA0avIrBNMsaKrRAvJsWaRhlok0d2Tl
 m/x/wMJI2GCkT0Q8aJEwVe0DYNlM35FTrYapJBKDELxhMsZKReewx5K4L3Vg9PKKm06qNUR0dH 9H6f5fT/e0nA8YQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691098430; l=1987;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2evVcZK0WP6ax5yAm7AbIZ6ZeQaKrhdt6vD9tIcclH0=; b=ypFgRW0czPyi/GHwpauG42Y9gan08GzQKInJtaElHrzDHwEl74ITApi9Gu8Ptkoi/fv6MXJxT
 Z/witMGLrcwALUkSIWGhNs1KlNn/ZXVqD3fHBSWZbY0yYDhlgIV5Rxe
X-Mailer: b4 0.12.3
Message-ID: <20230803-security-tomoyo-v1-1-c53a17908d2f@google.com>
Subject: [PATCH] tomoyo: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

It should be noted that the destination buffer is zero-initialized and
had a max length of `sizeof(dest) - 1`. There is likely _not_ a bug
present in the current implementation. However, by switching to
`strscpy` we get the benefit of no longer needing the `- 1`'s from the
string copy invocations on top of `strscpy` being a safer interface all
together.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 security/tomoyo/domain.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index ac20c0bdff9d..90b53500a236 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -784,13 +784,12 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		if (!strcmp(domainname, "parent")) {
 			char *cp;
 
-			strncpy(ee->tmp, old_domain->domainname->name,
-				TOMOYO_EXEC_TMPSIZE - 1);
+			strscpy(ee->tmp, old_domain->domainname->name, TOMOYO_EXEC_TMPSIZE);
 			cp = strrchr(ee->tmp, ' ');
 			if (cp)
 				*cp = '\0';
 		} else if (*domainname == '<')
-			strncpy(ee->tmp, domainname, TOMOYO_EXEC_TMPSIZE - 1);
+			strscpy(ee->tmp, domainname, TOMOYO_EXEC_TMPSIZE);
 		else
 			snprintf(ee->tmp, TOMOYO_EXEC_TMPSIZE - 1, "%s %s",
 				 old_domain->domainname->name, domainname);

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230803-security-tomoyo-7d58f53d35a6

Best regards,
--
Justin Stitt <justinstitt@google.com>

