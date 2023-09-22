Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301027AB16C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjIVL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjIVL6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:58:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A3102
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:58:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso1825348276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695383887; x=1695988687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h0+GRB+kxF93/Nxrqq9DKTHDXR03unqAc0mTDy5Q2pw=;
        b=xXgzdGiykEGdO7gpdhGixT6EaLjdbPLg05Vzpnksm1uS9+hVoeETrxg9KdInSjN9lM
         Hb+i9ZpmhETnmvDnFDxd2GKFtkWPXnhUuAqKhP4hT6FAZLZRIFnsUAzs3Oz02g5xPxd+
         glOQTC/Z6RfbZlIAEV8EFlGeIVQj7Kn35z1/4Vmt40lFdnfiFujII1YIcnMWwFOGsHmZ
         Q+A0yatfna2OVDT4iXq5vEp4DvkG+tS3c9OPD4sCGgLmgHyGBluF9K7SLQNGar62RF4d
         LbM/wUvIK7yG29BdNZnsX8o5/KhFIiHsgz55/FBkYKjFUpl3bk9kvTK9t9/+EsmoDyP1
         KzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695383887; x=1695988687;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0+GRB+kxF93/Nxrqq9DKTHDXR03unqAc0mTDy5Q2pw=;
        b=lkPlqXVl3zw3s09PtjjjoqXVYtG9imLuTWNVrgBe9Zn35cXoBspxCHfQlw2uU3wiyV
         GGXSLR6jU6n9THvN2okyAhj6DndIo+Te0dHujEqqfPjTKkQ6+FRO5uBF1zei9LJR5Jtx
         0D9vjipxt5vOjv54QooQI+RfqJm2XtMP3fnLR1QX/nfkmjbAn+hHQEMR8t+Q5Df0QdzI
         DEg5+iwDGJBOce5G/lKjJterfb7bkryAp2aftsMQ2i1UFtPt0efqG3/4nCoz9c7qV6XC
         NBHCJSTB83m2Iqc3jfZqp9yrUbwFV1BBP+fuYZlDouoONaFd29EFMJwFzlxvt0TYw3+D
         yaXg==
X-Gm-Message-State: AOJu0YxicCkn8JU1NJHvM2yqyH/Y7Ay566h5TwXuZn0cl7+OTmaIUb+F
        ysaaBphQgfRiNzgy7cqQxTl8WUKAo6rRgIwlWQ==
X-Google-Smtp-Source: AGHT+IEbPzIrveJKv9UfJMYHneMt6xBfeCXMjJM/4Xg9b8FQJmeVbNjCLwOzytneexB8H+NPUiUgJClGIXPOSbzGpg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9741:0:b0:d7a:c85c:725b with SMTP
 id h1-20020a259741000000b00d7ac85c725bmr109256ybo.7.1695383887432; Fri, 22
 Sep 2023 04:58:07 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:58:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAE2BDWUC/x2NQQqDQAwAvyI5G7DZS9uviAdN0ja0XSUpiyL+v
 YuXgbnM7BDqpgH3ZgfXYmFzrnJpG+DXmJ+KJtWBOkrdjQjj55mXDcWtqAdaSMbvSf7M/EZGkkQ jpenKJFBDi+vD1nPSD8fxB4BlTfR0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695383886; l=1790;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Oo3iG3c8TO02Wzo8/L4n1wYAw1X7zIXchkNPfOOoizQ=; b=yRsRG6F6Sy6wBLDZFduV70TYFbFUt/mHt3pFvitv1JlVnFyXqKKLcbRQHRRF8tJM8ztYtpZ84
 zZ+XOkNjZasBnUV0cajf733+Cz9uanoG9R4Xm3QEw9YBb4ahVvP2mQp
X-Mailer: b4 0.12.3
Message-ID: <20230922-strncpy-drivers-isdn-misdn-clock-c-v1-1-3ba2a5ae627a@google.com>
Subject: [PATCH] isdn: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `iclock->name` to be NUL-terminated based on its use within
printk:
|	printk(KERN_DEBUG "%s: %s %d\n", __func__, iclock->name,
|	       iclock->pri);

`iclock` is zero-initialized and as such is already NUL-padded which
means strncpy is doing extra work here by eagerly NUL-padding the
destination buffer.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/isdn/mISDN/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/mISDN/clock.c b/drivers/isdn/mISDN/clock.c
index 01d878168ef2..f71eb61db131 100644
--- a/drivers/isdn/mISDN/clock.c
+++ b/drivers/isdn/mISDN/clock.c
@@ -96,7 +96,7 @@ struct mISDNclock
 		printk(KERN_ERR "%s: No memory for clock entry.\n", __func__);
 		return NULL;
 	}
-	strncpy(iclock->name, name, sizeof(iclock->name) - 1);
+	strscpy(iclock->name, name, sizeof(iclock->name));
 	iclock->pri = pri;
 	iclock->priv = priv;
 	iclock->ctl = ctl;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230922-strncpy-drivers-isdn-misdn-clock-c-2d32a23b8c2d

Best regards,
--
Justin Stitt <justinstitt@google.com>

