Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51467D1669
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJTTje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjJTTjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:39:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A4D170F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:39:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7a6fd18abso15595547b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697830746; x=1698435546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ApgtBIwM/UT3SKqY+L+66VIK2kG5whPiTDfo769iKqE=;
        b=fymZahB42Jt7DJG2f/jHR8IofMHwz/ta/5lRINoFiRseWXr7Pr8dG5ADbn1Ht5M7NW
         eHTiu6zByuTlWMnSER7itpHo3wMFefGGeTg77XLxOxr/LGqqhUVlc2JJmbh4pAkSYMv6
         cU19bMgVNtkHao5tny5U35qlnW38QKSX67XlFR0C23HGAgkAfwcTynMulRCQp0UiFKd2
         tG589/4x0MN+/0bINH502AMfhROlGJ+liX6+Bg5Vy/DOXnQaRJed+2sCSTeglFyBa3Eh
         OX4BC74mayd3MYNkRt8xhSU9VkiOlZ7v2o7sd89LE0slvkQFrwXSxpJejQ15OLwzvMZO
         U7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830746; x=1698435546;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApgtBIwM/UT3SKqY+L+66VIK2kG5whPiTDfo769iKqE=;
        b=SH6nZmXrU2hnos24L9gD8F8NQbezR+DnGiuw0SM7a+73Zp1VRbhBlj2znWYv/lDlBY
         Vp+2OSjism8kzEPl+HIr3jAu3QQUtcsdp368BzS8CSa9ye1umhOBRZisXsVG2JPKLTiD
         1oZ8VlU15UzqsFVTBAcrUy5Sv56UpFkqzwBMIItot+Xk3qemj3N9kQpUR3YMcqR6SoqG
         2fhfnt6wmNHrbheo+6gHRq5ZT2jz2sPllYjmmfv/RMCM5JhKTlWbVvMx9WG5RGdSDXkm
         du/lat7ZFEIqcixIiE6k/Bw3qEarf8zkgQm9iIJx7hQpZWWG2/j4wMLl4h1c9virc6Kb
         75qw==
X-Gm-Message-State: AOJu0YwJSd8FPVB8IpMfA9HjM5rh2DfZp/BfFgNWlKDc/k08O3JIGz6y
        TsuMSuy+b3MPX+CVoEQ7eoFM682jBmNWqHwM8Q==
X-Google-Smtp-Source: AGHT+IEMURRd+a5veV8jdamkf3IjKiUnn+FpVD4h6z8O/r3QLS9fPuSYUe8nhXkO+H6BxwqrGYE3SZBBG6MGCUhKZQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:6cc3:0:b0:5a7:de61:4d9b with SMTP
 id h186-20020a816cc3000000b005a7de614d9bmr72471ywc.3.1697830746201; Fri, 20
 Oct 2023 12:39:06 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:39:02 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFbXMmUC/52NQQ7CIBBFr9KwdgygrY0r72EaA3TaktRCBkRJ0
 7uLPYKrn/cX760sIFkM7FqtjDDZYN1SQB4qZia1jAi2L8wklyfBJYcQaTE+Q082IQXw7o0E4eX
 9nMvQoAw+tIoRKYMBzU171rxWRrasSD3hYD978N4VnmyIjvLeT+L3/p1KAgQYpRWqmmPTXG6jc +OMR+OerNu27QtczP977QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697830745; l=2480;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zP2JAHf39kTI56frJ1mycRlDlgI+x3V8U7lKpy4JwDA=; b=8lnCfGuxm7KfO7JWZvnLM0jkO3KfBDK4t51JJ/oInHUz0BAWOE3mpSG3NT20U8vZ+oT5gyPB3
 3MX1Z5PX6faDN9OI7yXoH0OvrjC02jZhH08FqCPvJOVLwOuem7lHeCP
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-surface_battery-c-v2-1-29ed16b2caf1@google.com>
Subject: [PATCH v2] power: supply: surface_battery: replace deprecated strncpy
 with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bat->name to be NUL-terminated based on its usage with
strcmp():

power_supply_core.c:
445: return strcmp(psy->desc->name, name) == 0;

... and also by the manual `... - 1` for the length argument of the
original strncpy() invocation.

Furthermore, no NUL-padding is needed as bat is zero-allocated before
calling spwr_battery_init():
826: bat = devm_kzalloc(&sdev->dev, sizeof(*bat), GFP_KERNEL);
827: if (!bat)
828:   return -ENOMEM;
829:
830: spwr_battery_init(bat, sdev, p->registry, p->name);

... this means any further NUL-byte assignments (like the ones that
strncpy() does) are redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of:
(dest, src, sizeof(dest)).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- fix subject line
- Link to v1: https://lore.kernel.org/r/20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/surface_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index 19d2f8834e56..196d290dc596 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -722,7 +722,7 @@ static void spwr_battery_init(struct spwr_battery_device *bat, struct ssam_devic
 			      struct ssam_event_registry registry, const char *name)
 {
 	mutex_init(&bat->lock);
-	strncpy(bat->name, name, ARRAY_SIZE(bat->name) - 1);
+	strscpy(bat->name, name, sizeof(bat->name));
 
 	bat->sdev = sdev;
 

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-surface_battery-c-b0c84b05ac28

Best regards,
--
Justin Stitt <justinstitt@google.com>

