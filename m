Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B5F7D164D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjJTTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjJTTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:35:47 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA2D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:35:45 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-581e2fc1178so1585519eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697830544; x=1698435344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9+iAGOL8fBcRKregm2UatJBSjxVyGVTi97qzrD87J/M=;
        b=aRyQvAni2EHDC0yRsExYndr00a4pAr2Rtc9NCVfSzpCdgmvO5I5cL6jHXAntyhyxL2
         FI9KRSEINv+Hs6h/g1KbBbbso/zbisELGQolS1SFa35WUNcqQ2iZ9dnMyQAqQ1/QUCF7
         klwPq5O8MSJFKEYZ0DM3XcZwQh3+MzdWqiLmcC1ojS+1CtCn1Xw7Mek462kLySxhoc4h
         FehbPwXpxTs61coqrVJ9RGMalTRWJN0Ymdl4kSyOZGeAJpjLzdsOzlUIta2TRhogRJve
         +P1QXvrg5VOCNk4mHO7U2CSk6Zhiezr8zxVyhIj8LTgfHtEwoGataffKbvaUqYufSGtR
         eGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830544; x=1698435344;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+iAGOL8fBcRKregm2UatJBSjxVyGVTi97qzrD87J/M=;
        b=tqciglbmKg1Lmo4pCJfTBH6K7KSTMUCCxtlc2W+9x5u4ZlKc2osrcSBL02YjKdrXvb
         9xJh3c6lJLa88QcoOJqo2JkJrgYO678tIMKWxWwvU3adn0hiqvUoc/wnekLANYVs1T7J
         koa6owmixrMciwyGtQsEX8DM2mCwEfIgak1KyXAR3RoFXUzqCz+CcZh3rlyERAFhbAJ6
         y377ehH24UFOCv/oU2X2d7mEssHgEV/pt4eGCRatCQiWgLh6buJmi4OvNMII4dBpJFp0
         z2vBjHcsUBD4CZUEuDFy98rh6zIF2k0amupaPmJ8lOueWbym1opS1KgeGL5i77E9n2p6
         YeLQ==
X-Gm-Message-State: AOJu0Yxrtlxsm8fmfNGRnlrCYBBKc9JWEDAtFEC6mP0IDFkc6SlBX0aH
        pUp6IiqCbXvivNTHQogv7lZnEwk0tt+p86QOGw==
X-Google-Smtp-Source: AGHT+IHZQUY9baCehYvzXAaS7x9nNF6uHCQ2/74bV2qdNWPoNwNQLv1R/Hn9zc2YRsn/RnRPDVOTLR2TZ+Z8Sxp5Ag==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:448f:b0:3ad:da36:1dd6 with
 SMTP id eq15-20020a056808448f00b003adda361dd6mr1891601oib.1.1697830544173;
 Fri, 20 Oct 2023 12:35:44 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:35:43 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAI7WMmUC/x2N0QrCMAwAf2Xk2UBXJwx/RUTaLNOAdCWp0zL27
 ys+Hfdyt4GxChtcuw2UVzFZUpP+1AG9QnoyytQcvPPn3nmHVjRRrjiprKyGefmyon1yftcGnQP xI4ZSWCsSRkfjEN0lkB+hRbPyLL//8Hbf9wN9+HSXgAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697830543; l=2313;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zmP6Agkd7BUv41JUTgaRBkw1r6Q9BZkiPWT2tLR0LAQ=; b=qUt1cyoTbXs6qmJVgPAXz5mbtcGQzIOLTkM7z8UR/GVWZ8gVAAzFiOhg9+1gcHscXS/bles5K
 Hd71E9a1vbbDBn24xeS1hMCC89N3IDNnw1W+pJJ4CZNXEiLH5v1sOMH
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-surface_battery-c-v1-1-cabaea50e667@google.com>
Subject: [PATCH] platform/surface: aggregator: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

