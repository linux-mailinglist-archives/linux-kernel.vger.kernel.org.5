Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B29772DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjHGSXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjHGSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:23:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF13B1BF4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:23:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so5053933276.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691432555; x=1692037355;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7jgUB0WpU0M7afNXyKboaaIvZf92Ty700IWf8lOD30o=;
        b=i8J/Xe7MJ9rD7NzJZFsQtFMkGeXqS2bJrxxhlpaKBuExNEjWUEFdkeosztI64kxSPx
         JF/4yQsv6CuDK9TeNysNuDl1pWk3Jx0dVBOx20Puce26jnhznarZ9FVuQbeHT+hc8uXe
         tto4hAfhiuqVDUbQD3Ws1uohuYH9VueQp1VY1fEeGfb2u5P8Xfvy8nchwO6vIVLW1pF8
         xL4RHZvhfwT4h4gl8ZO9cL9lwd/ulYYkVns29wq9LO2G8VEskQ+zZFfHSBMxJmOAyCCa
         4oo+vmDEYtCEGBluOi6X4e3MVj8kue3KR3SOyDDwB6epZiLljw6W6stVuH8djTbLZBww
         XBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432555; x=1692037355;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jgUB0WpU0M7afNXyKboaaIvZf92Ty700IWf8lOD30o=;
        b=flu8EMRBQdoz1ogLy+oM0HOMJm+GGVOjeg/TNb/xTQWafqqpliHJCIXeopxqjGV3VS
         px43MVnWV+3ceFoydSv1wPL6BnGLht4EMNv9RXHFSxkJ3KPe0Hqm1Q2pOT1cb2+zwSU8
         6kTgUfe9fIMwsRUnqYmTkxbTUoRtRerPMfbkd7LnGkwLcaeGMazZD7YK0Y9yUFpsEKgT
         eB+8Xlaefk/n1S+Lqav0wmvix9KH9kYSMMbWMZppiLgeYfundVl0PU1zDKtQNO4bhJtc
         5OS03151pXiOurtDtyXfIxVT7Eb1giGeFLBiKCBkbrg3lsbpLgoElmK4r7uGNS2jvEYx
         49Mg==
X-Gm-Message-State: AOJu0YxOXNYqZP/o/49bnoi6+8LUwaQTbtl2decfOhHlvWVgzk3Z7ccv
        LBxJ+i6MDuoeG4yL+NuERoVa/2J3yQCguB4Tbw==
X-Google-Smtp-Source: AGHT+IE3EsW86Yh8dtPgXOL32nHWwf9iJWr3DyWFMH7EYJdokxnbYqC4oE8Kpzq82cS9iBtHL5aEgmyQTD1Dn3nOAA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3446:0:b0:d47:f09c:cc8e with SMTP
 id b67-20020a253446000000b00d47f09ccc8emr49064yba.10.1691432555654; Mon, 07
 Aug 2023 11:22:35 -0700 (PDT)
Date:   Mon, 07 Aug 2023 18:22:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGU20WQC/x3MPQqAMAxA4auUzAaitli8ijgUGzWDP6RYBPHuF
 sdveO+BxCqcoDcPKGdJcuwFdWVgWsO+MEoshoaaljx1GHRa8dowqmTWhCFaS468d5GgVKfyLPd /HMb3/QB6UkMCYQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691432554; l=2334;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=2oYTjCvV17po6xXOpfrY+INCIA0i2CXq/pTmWjU9YB4=; b=exkU3+X8smSe8ECTT7ic4ouZhlLEph4CCWwgj+Qr8gJ7jaZ+O6d3w5WFRk4LnzhbsR+9W5UPI
 rWdniopikbWBVCbiSSFM+aTHyahPN1VBvuH0AKGOn4ZvnvUjjusU85N
X-Mailer: b4 0.12.3
Message-ID: <20230807-arch-um-drivers-v1-1-10d602c5577a@google.com>
Subject: [PATCH] um: vector: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

In this case, we are able to drop the now superfluous `... - 1`
instances because `strscpy` will automatically truncate the last byte by
setting it to a NUL byte if the source size exceeds the destination size
or if the source string is not NUL-terminated.

I've also opted to remove the seemingly useless char* casts. I'm not
sure why they're present at all since (after expanding the `ifr_name`
macro) `ifr.ifr_ifrn.ifrn_name` is a char* already.

All in all, `strscpy` is a more robust and less ambiguous interface
while also letting us remove some `... -1`'s which cleans things up a
bit.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/um/drivers/vector_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index c650e428432b..c719e1ec4645 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -141,7 +141,7 @@ static int create_tap_fd(char *iface)
 	}
 	memset(&ifr, 0, sizeof(ifr));
 	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
 
 	err = ioctl(fd, TUNSETIFF, (void *) &ifr);
 	if (err != 0) {
@@ -171,7 +171,7 @@ static int create_raw_fd(char *iface, int flags, int proto)
 		goto raw_fd_cleanup;
 	}
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy((char *)&ifr.ifr_name, iface, sizeof(ifr.ifr_name) - 1);
+	strscpy(ifr.ifr_name, iface, sizeof(ifr.ifr_name));
 	if (ioctl(fd, SIOCGIFINDEX, (void *) &ifr) < 0) {
 		err = -errno;
 		goto raw_fd_cleanup;

---
base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
change-id: 20230807-arch-um-drivers-ad44050885d0

Best regards,
--
Justin Stitt <justinstitt@google.com>

