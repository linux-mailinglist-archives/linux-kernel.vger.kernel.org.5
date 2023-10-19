Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323557D0102
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjJSRyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjJSRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:54:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E3E8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:54:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so7688780276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 10:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697738059; x=1698342859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wCaHYSvOMmjyjjo+2DaJHIApqUGU3SdaqxSKwGR/sus=;
        b=NZc9I8HD5Mbv3+kaOY8h3qn1a4tHq979zp/1L+q+oUGb3mnBXZ02OyWWp3sDxfvsML
         XAZMTnzqH7+0O1qxB6Vdx4coiXRgIrlBV5mAOTxPSz91jgkS5VMBTvrJktrxnFZt//Hf
         T/Fg6AkKFql4BkxAHme12JIbu4I48cEOnpAyqhKaAqjkzCt1zHiqlmmOamjCvklzrvV8
         1msXByhXEi+640ucGLwqAYgyaXwYVIa/DW8YxYYMLutHNsZ9lkkfrUbUbV/94Fo63JGm
         72BLnEUys5MchCBh07/IoHPHd8Ydjjeas1breSM6dK09KXmHShAmZVeJcw0o7DNMIZYa
         TdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697738059; x=1698342859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCaHYSvOMmjyjjo+2DaJHIApqUGU3SdaqxSKwGR/sus=;
        b=kmoIY9PUn+XyLdqiCNXXZ3+F48QSrzzmrBqy0fR6vs8Pe5mtm0u7xGWeIjcgCM28EX
         S93S14+8ksP/1g3ztfecb9yCjIm1Zvq97uJd8833bZnIafZOIaiZ8BZ/+Y8+kNBT2/9E
         csZhI5cBKdkbAQS27XP0dHBKAVCzbAFmd+c4ZSxLUvUCtjUsXYKZaPYHeqnbIYb6kZyp
         7YCVNPD1KoHIPNtm2nxYymCSN2N51eteIHkfL4t8OdNskXopbwhzCsQUgoNerolvF6yh
         4jpBOXEe3hZ4jN66+0r2bmW/VyWk0FjmhMSV4AxsGxuOgl1QL/YvNnJ/qzlOX1ohVlZz
         yfEA==
X-Gm-Message-State: AOJu0YwkEnbRcPw4VoEeydiSuJfuhQRdM4DS9dhFlUC82pwQzt5QShrI
        OydC6axjXk8rX4xm9i2n1s3/lkaPTCcFsOKjiA==
X-Google-Smtp-Source: AGHT+IFW/KpAD1OE2SUfMXnmaGMOttDNK0DgS3TLSfp4LYGTFI6KheySPCzP33IWgQ3o4jh68J7qlmtIbH4Cu9rxSg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:738b:0:b0:d9c:c9a8:8c27 with SMTP
 id o133-20020a25738b000000b00d9cc9a88c27mr31838ybc.13.1697738058988; Thu, 19
 Oct 2023 10:54:18 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:54:15 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEZtMWUC/43NQQ6DIBCF4asY1p0GMEboqvdoXLQw6iQVzEBIj
 fHupZ6gy+8t/reLhEyYxK3ZBWOhRDFU6Esj3PwMEwL5aqGlbpVUBlLm4NYNPFNBThCKp2WBV87
 gQHWjbU1vrbEoamJlHOlz5h9D9UwpR97Ot6J+65/hokBBZ2Qvx967ztn7FOP0xquLixiO4/gCb mF4u8kAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697738058; l=2904;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rw760A6im3UPDmPb1PvvzFcADO0t8QLqJon9lALd7qU=; b=NYE7eTw9PMvTw2M5a8Bn23YgudGYR1Uir+9aU2nJN/yFHTP0niBKIS6Z6tV2vKAW3CaEGvUBt
 56mAEMPR1qFCvf/IQUE+DNmLbFA7xeXjbNcSzdE6VeR+EPpGWLVtRMF
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-nvdimm-btt-c-v2-1-366993878cf0@google.com>
Subject: [PATCH v2] nvdimm/btt: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>
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

Found with grep.

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect super->signature to be NUL-terminated based on its usage with
memcmp against a NUL-term'd buffer:
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
multiple instances of this pattern in this system:

|       if (memcmp(super->signature, BTT_SIG, BTT_SIG_LEN) != 0)
|               return false;

where BIT_SIG is defined (weirdly) as a double NUL-terminated string:

|       #define BTT_SIG "BTT_ARENA_INFO\0"

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changes in v2:
- provide more details about memcmp()
- fix typos in commit msg (thanks Kees)
- fix subject line (thanks Alison)
- Link to v1: https://lore.kernel.org/r/20231018-strncpy-drivers-nvdimm-btt-c-v1-1-58070f7dc5c9@google.com
---
Note: build-tested only.
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

