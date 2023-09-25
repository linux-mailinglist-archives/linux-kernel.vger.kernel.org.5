Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404B07AD10A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjIYHGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjIYHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:06:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3D6A3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:06:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8315aabfso14673627b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695625566; x=1696230366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qo6OQpCE04pWWcsadpkT68s/JdHKPH3Fz0vzZ7bj3RM=;
        b=U3tOSA50yRAnJsQQyEYyFvOuYdSiWyjubrEvwLOKX8h5cZ0MQ+YdZcBTgfTguIHbm2
         tm6AEAwZWLDP2kjjfKsIa/AfPHAgZvsFkjQPBHQLtJ8Z8fRvtuteiUPrCqYrmzU4iq8f
         48HJ/if7f7M5n1JJ3pyOwrntCATUc2X9EjhEDDP13jMiXcTKatjANPN7LBYBimWxb6Ur
         XYvzdxtZBS5765p8HmOVHkZl++iXGHTlOC0I1ofV+OygGmYtZtEcGiyUjMHaaDwaSaPi
         u1etatg1I2NpOlZvsq4zPyEAMZP4b0vnIR9/IKYGA48Ld87Ry+N5epmTiHzm7VBwDVqa
         XPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695625566; x=1696230366;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qo6OQpCE04pWWcsadpkT68s/JdHKPH3Fz0vzZ7bj3RM=;
        b=ets+ZnKDYdQBqdHkZQhPU50H8YfxD9x6Vuya6JU09XZ3OiSq3vBVZN6JrfZsR5MXKa
         7G5ZNyRkJCq+28geC0qHUm2se4SqGQmgTgB2eaQpuz/q098r/KnBUf2RTomJYbON8CZb
         DIGtwTjKjWPkaDrfGRJ37rq1PswxU+9XEvSXlw2P23wmNOWuZJnHuwnnnURqs5lAfnY4
         ABWrw4ECnf45bYBKOYAxlbrQx+EuQPETx3BK3WSEmv3xubKpI8HCYw4Bw5ZXD9ScEyd6
         ydhh2GYARnyJq8OexKdYhGiqzdRSI8nv8qAvQK05Ui7o7yu5Xgz7U9uVasmWM9PkkjW9
         c2mQ==
X-Gm-Message-State: AOJu0Yzd8bwqO4U6KeFsVSOqFtPe5q3KitqEstnznVZZi6Lz+FVNR2XZ
        xUtU6SJmRUIVjDSb9pwmS4jdUVhUO8VRFoqutg==
X-Google-Smtp-Source: AGHT+IFL6RcLEbqF4P22oc8KJthtgJZ9I4gjnelF8DLVDruqhPbX4JycAc0dVu2g6PwkxJz9KG5Vnb8BbiVa784GOQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:abac:0:b0:d7a:c85c:725b with SMTP
 id v41-20020a25abac000000b00d7ac85c725bmr50744ybi.7.1695625565925; Mon, 25
 Sep 2023 00:06:05 -0700 (PDT)
Date:   Mon, 25 Sep 2023 07:06:03 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFoxEWUC/x3NwQ6CMAyA4VchPdsEhwvMVzEe5lqwiYylRaIhv
 LuLx//y/TsYq7DBtdlBeROTJdc4nxpIz5gnRqHa4FrXtcF5tFVzKl8klY3VcCakGV/LhO9KWYm J8RGNMeHge98HCkN3GaGCRXmUz392ux/HD7dkJu58AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695625564; l=1779;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/oJWFABMzt7p+74DCkUM9oNwgT1wgj/iJtocYZ9umPE=; b=aJltci5reHJ/m8Bl/fua5gmnn3LHr/vrCoxC6FkKpLlZloqYPwsgN7m+WzQ/bTCl2oTwryUfE
 4vAxdwy5r4MB2/Vog4MR9HvDyl+0FGAW4WZIsC/HKj48oacyV+kqUry
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-log-userspace-base-c-v1-1-030d7bcf1004@google.com>
Subject: [PATCH] dm log userspace: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`lc` is already zero-allocated:
|       lc = kzalloc(sizeof(*lc), GFP_KERNEL);
... as such, any future NUL-padding is superfluous.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Let's also go with the more idiomatic `dest, src, sizeof(dest)` pattern
for destination buffers that the compiler can calculate the size for.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/md/dm-log-userspace-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-log-userspace-base.c b/drivers/md/dm-log-userspace-base.c
index 5aace6ee6d47..7e4f27e86150 100644
--- a/drivers/md/dm-log-userspace-base.c
+++ b/drivers/md/dm-log-userspace-base.c
@@ -224,7 +224,7 @@ static int userspace_ctr(struct dm_dirty_log *log, struct dm_target *ti,
 
 	lc->usr_argc = argc;
 
-	strncpy(lc->uuid, argv[0], DM_UUID_LEN);
+	strscpy(lc->uuid, argv[0], sizeof(lc->uuid));
 	argc--;
 	argv++;
 	spin_lock_init(&lc->flush_lock);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-log-userspace-base-c-857579d9834f

Best regards,
--
Justin Stitt <justinstitt@google.com>

