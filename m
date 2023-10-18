Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0567CEB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJRWfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:35:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B8113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:35:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a5a3f2d4fso10179877276.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697668548; x=1698273348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U1aLFdy4LtlPdLdmsrELCrrPTI/o77pTc9HEh1RET2I=;
        b=2p2deGNHebLT4omQqAuYtJ4sY0mclka+JFK43mbygOfC0S3ELvUQIZJy2zK8/e0xau
         htu9nWxPiycgejEvsZhGPBgA5GBH27pu1j0qirCXPgQeO1fWl9aLh+qcCiO+x1baE22x
         jhWuDcbkIM+4occcsxqZ4u4j8E4FQ8BzRZgeL0DBSNkcoF3U55iqT7OvlSMyEaOR1HCF
         +ixVsEtDtDdPCsoZGath00LU4eXoC/m78Mh6Vz2KWlCEL/vGJtIkOZlk59i+34N46BHc
         fHExU/qYYf7CEzND76rpM8W/HQ60Iwx+WVghUWB+l+qXf6MDsaj6/bWxCCbW8fnaDQd5
         wCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668548; x=1698273348;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1aLFdy4LtlPdLdmsrELCrrPTI/o77pTc9HEh1RET2I=;
        b=dLyXcjRW6ZLeBxY60tB/U9vvsvJNVUipWGHlCYgKCWDh0x0eo3yWKmObGNyon8Zxer
         Al2thMNvKVM25D3UjYX+A5Cq3Gmll5IYadBJPVuzdD3w6p/03IcKF6+NSyDlwGm69Bpc
         MB4+YN12P+/VxJIbDqCJ5DPsi8lZm6IfyeKV8cyue2R6IFBZRsqHOQMQrgxVhL+NyGc1
         9Ap0kzbL+91fIwmzPMVHtcFWXiYotjKvbeTcZXrsDmO+4vFs+CMQHHQMMzc64Y2Czs0T
         A1jl4XUNdDDYw0qxWJ+SEPB6R9Rb8LB3Wdwxx7dXZ4WOZgfVap84hfzmObbRwSZZ9M+T
         uRIg==
X-Gm-Message-State: AOJu0YzN9F+3vz0FuNYf+3MQimPvT4OVgbPTKkrgBxmCmoYKZXkjIvRZ
        7I5rWX5gSZOKAt7scsbu3eZ6qoAl4CBA+KvuDw==
X-Google-Smtp-Source: AGHT+IHwV2J0r/LBLvfNxSR2yGnXuXn3OeZ4+CSobU/6GKBkVZsitkQV2vNVMQqnN+mNHOCCvKr7NZw07FSmbv3F3g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b0a8:0:b0:d9a:3a14:a5a2 with SMTP
 id f40-20020a25b0a8000000b00d9a3a14a5a2mr15465ybj.13.1697668548155; Wed, 18
 Oct 2023 15:35:48 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:35:47 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMJdMGUC/x3MwQqDMAwA0F+RnA20yljrr4iH2cYth3aSlOIQ/
 92y47u8E5SESWHqThCqrPzNDbbvIHxe+U3IsRkGM4zWWIdaJIf9h1G4kijmGjklXEvBgPax+dE 9vXeeoBW70MbHv5+X67oBjezIGm4AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697668547; l=2405;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wIXUkCLacDcvyYmWwXYlHGDFUt9BdHJS6MZL7uBj9BA=; b=n6GHlGhf250MWDnVuic43BVfEnftE5cYh9pXrKoHjqf2BnIxPPqvucB7iOWWF8tO9siLtvPfq
 0GZIeKqaZp+DOlGpq6Beb706YYhYEaXrCt36mqglIArldQsjrnrBK+2
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com>
Subject: [PATCH] block: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect super->signature to be NUL-terminated based on its usage with
memcpy against a NUL-term'd buffer:
btt_devs.c:
253 | if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
btt.h:
13  | #define BTT_SIG "BTT_ARENA_INFO\0"

NUL-padding is not required as `super` is already zero-allocated:
btt.c:
985 | super = kzalloc(sizeof(struct btt_sb), GFP_NOIO);
... rendering any additional NUL-padding superfluous.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also use the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) instead of (dest, src, XYZ_LEN) for buffers that the
compiler can determine the size of. This more tightly correlates the
destination buffer to the amount of bytes copied.

Side note, this pattern of memcmp() on two NUL-terminated strings should
really be changed to just a strncmp(), if i'm not mistaken? I see
multiple instances of this pattern in this system.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/nvdimm/btt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d5593b0dc700..9372c36e8f76 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -986,7 +986,7 @@ static int btt_arena_write_layout(struct arena_info *arena)
 	if (!super)
 		return -ENOMEM;
 
-	strncpy(super->signature, BTT_SIG, BTT_SIG_LEN);
+	strscpy(super->signature, BTT_SIG, sizeof(super->signature));
 	export_uuid(super->uuid, nd_btt->uuid);
 	export_uuid(super->parent_uuid, parent_uuid);
 	super->flags = cpu_to_le32(arena->flags);

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-nvdimm-btt-c-15f93879989e

Best regards,
--
Justin Stitt <justinstitt@google.com>

