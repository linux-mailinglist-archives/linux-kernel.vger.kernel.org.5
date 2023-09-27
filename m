Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF87AFA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjI0FYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjI0FXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:23:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79F4205
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:21:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so15177536276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695792059; x=1696396859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lz/tzt2FhoJSlisVyBotc0Kj5HYUeKExNXWDpILSgIc=;
        b=jxPSRuCh2GiA5ml2AR0opCZ88ky6+UTpPBhYDJpn5sXvyQwKuI/mwdBIZOaYL7wPtu
         i3FzcUZ4jj65FV/lLI1grLztvVU44S5nygVz7YhgY7+8ZKaPHbUw70ciOMexYtYJb2c0
         obnHNiTmphB52b7IoHuoOz+KZV+Wkli92J2JazC8U/ZoyEZIB+lydEqI+GRitHeTwqIL
         bxUHGZxMECI0AqCkcSBdLgJAHYPzQWQoBYMn1dQqldu6zSyAJNJBcXtcqI/PgnVNFa7T
         gFH2s8OJzbJfmJo15bwRGJ1PI1z0ZbXPqRxkJe9lVf1EgDnZYT4uwzk266g3Cr9zUesi
         X7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695792059; x=1696396859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lz/tzt2FhoJSlisVyBotc0Kj5HYUeKExNXWDpILSgIc=;
        b=wJnhf6U3Sl0nYSaEu52aEMI/tXXmgAMkJL4tKh935IJvXpk1cQtuh5ajYQ2ZPid+ue
         gvDREWkU8R5hNy3UYG5CbRgzk78n2ONi0eS37KTCodjq1dwd9fGJYKXYeqgVrwk7YgJD
         dMosGzqd+URTF9XjugBHcF0e4HIysHIPPwOrMzavPlXERTRNu6cGDaVilDFAGt4MnNrP
         6PqRwvjOeQXLYiFA6byWQDnLfykmBspgTtM3agUKhIaglZ3c2RCh5VK4PktG+yskRLkF
         O50DTbvIf5Se73SvvIkwhGr3dj7ioUHQvMaq4/fqItxf6hp/jh7VYReLRqy9cbpFmk8h
         K/wg==
X-Gm-Message-State: AOJu0YxRhJaRCp9p00cPMFQeOsJYCbJ1gClcpuDx7w64CKu8qQmt6mLD
        9oi74kld278ZUqGMZOngRvg8xK8OmPfm5sWKFg==
X-Google-Smtp-Source: AGHT+IGQ4S6InwXRWTgaURsWBQh6RxYVFt/Bp+IrO6ECsGXqShMbbeNAl9naPNeF/L8Wg9aHddRgZy3gQ/CyC+vwJA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:aa09:0:b0:d7a:6a4c:b657 with SMTP
 id s9-20020a25aa09000000b00d7a6a4cb657mr12365ybi.0.1695792059592; Tue, 26 Sep
 2023 22:20:59 -0700 (PDT)
Date:   Wed, 27 Sep 2023 05:20:58 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALm7E2UC/x3NQQqEMAxA0atI1gZsZRS9irgoMc5kYVsSEUW8u
 2WWb/P/DcYqbDBWNygfYpJigasroF+IX0ZZisE3vm0G36PtGilfuKgcrIabGCH5nHRHSspIGII burZzK9MHSigrr3L+J9P8PC9p7qJ0dAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695792058; l=1837;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=yQqGrF2k0OLEIxxzfq32VFlgneWmvHqUwZOd9GeKl9Q=; b=GcVEbzE3m6R3BQuN95/HUu/Su4qXiV7N+d85g46JeEu4i/Hy5Trt6MURz/eeYNCmmQt/TOPsI
 UCr87Jtq+Y9D+Uya8HayxqfYkZrp7eEP4oaqYAlYThIOw6C2MGCel/P
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-misc-c2port-core-c-v1-1-978f6d220a54@google.com>
Subject: [PATCH] c2port: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `c2dev->name` to be NUL-terminated based on its usage with
format strings:
|       dev_info(c2dev->dev, "C2 port %s removed\n", c2dev->name);

Moreover, NUL-padding is _not_ required as c2dev is zero-allocated:
|       c2dev = kzalloc(sizeof(struct c2port_device), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also drop `C2PORT_NAME_LEN - 1` for `sizeof(dest)` which is more
idiomatic strscpy usage.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/misc/c2port/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index f574c83b82cf..2bb1dd2511f9 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
 	}
 	dev_set_drvdata(c2dev->dev, c2dev);
 
-	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
+	strscpy(c2dev->name, name, sizeof(c2dev->name));
 	c2dev->ops = ops;
 	mutex_init(&c2dev->mutex);
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-misc-c2port-core-c-aa196361fec5

Best regards,
--
Justin Stitt <justinstitt@google.com>

