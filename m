Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4D7B7409
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjJCWPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjJCWPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:15:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C0AB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 15:15:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d859ac9ea15so1757856276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696371347; x=1696976147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=glUGQRb/GBSrrTfvaW6K09zpdeEaoPTJ452gHEUadv0=;
        b=WTKWNT/QY1KIvHBOebCr0+RgxvLLRJczRHQlHgZHKjwz3TVC7f5TpSS+6Al3tU4vmW
         +yaV4kbsIemMjOWfRqCvkb4NHINO1OiwkLdk73sfWIJIaDsNwwQTL4ii7H8ubW9Pub0T
         gJFtSz5E1D44t6vt0cze6YVGdkizEwWxc0LJozy03GiXqAe3xp++mbVOAWr66+tbrwTh
         OkARiPtKX/uGMfzIK4otS7aybV3G7EQDZqP72gPCLvt4Pazw0r2At7xp4Nvyvwibtqs9
         rDT8TkZfvsZwvtR1nfsP8UPYaAXAZRj+qmne4RJjR4IIJi/+g37N0GYkx5pdB2OaJwoo
         ADVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371347; x=1696976147;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glUGQRb/GBSrrTfvaW6K09zpdeEaoPTJ452gHEUadv0=;
        b=tvzPa9rR33HZJYM5pTa5CggKdFHu7MoMQLgBy1qpoKsJOqnS+Yk99JaJQDIekildZt
         k3ZgTZ3ttK6wIhq8LdhaTMyPti2UX98PSffnxdWKNPzkIv/JDyxLfhKOyrU4hzXgiC3f
         u0p2+sj9tTaW5OdqIcXOiSt3BgDoNSxX4w3NSdaaPk63yZO+GsuV3t1bZkMkdLeqVPrK
         4zQ5B3D+ZW0iMG17S4u9EekWPXvMVKmtyPq3IwwFNKDcu3gS+sojJkUe9FHILAokBpKK
         wvwJw157V+THn4R+nBPQoUeMQJie/802LH9oClrTznKV1Bge8ZXhbnbPcbmq5n93rA8G
         uJ+g==
X-Gm-Message-State: AOJu0Yw+P955HSrhr+zEAsSi9RDZMgv1dSjUtvqxNJ10VuT5FjXCOd13
        1oM5usvCu1RY7YKVKqsj83+RImmU5W3J8nphzg==
X-Google-Smtp-Source: AGHT+IGdGCAuJA1wNrRfEOEXy8YnXpaqALyFXNbFGW3k419izX+ExXkii771wp0CrG+9MTGjPzGAAKtV27pphMrZug==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1603:b0:d7a:bfcf:2d7 with
 SMTP id bw3-20020a056902160300b00d7abfcf02d7mr8207ybb.6.1696371347547; Tue,
 03 Oct 2023 15:15:47 -0700 (PDT)
Date:   Tue, 03 Oct 2023 22:15:45 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJCSHGUC/5WNQQ6CMBBFr0K6dkw7iigr72FYNO0ATYSSGWwkh
 LtbuIHL9/P/f6sS4kCi6mJVTClIiGMGPBXK9XbsCILPrFDjRT+wApl5dNMCnkMiFhhIxOZa+9m
 nMEyzWAEHLaIv7VXfkVDlt4mpDd/D9Goy90HmyMshTmZP/3ckAwbIW3crna+00c8uxu5NZxcH1 Wzb9gOuMsAt3wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696371346; l=3172;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=D6TnBFlTL+yFDnhyUKzZ8WPpEO6pZlaPy5QQBmG4HnE=; b=+DWq/nrZH1zk08S36hWN94OBXnhx03M+unNMnYLjJ+uFT7PHncocUUu4CY/RrIzw97eg07gGy
 UkHDufSUfF+CmRjkJLcW6IfcMUxy+o1rN7x/Ga2VZV3RcaabL63ZD3j
X-Mailer: b4 0.12.3
Message-ID: <20231003-strncpy-drivers-message-fusion-mptsas-c-v2-1-5ce07e60bd21@google.com>
Subject: [PATCH v2] scsi: message: fusion: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

The only caller of mptsas_exp_repmanufacture_info() is
mptsas_probe_one_phy() which can allocate rphy in either
sas_end_device_alloc() or sas_expander_alloc(). Both of which
zero-allocate:
|       rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
... this is supplied to mptsas_exp_repmanufacture_info() as edev meaning
that no future NUL-padding of edev members is needed.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Also use the more idiomatic strscpy pattern of (dest, src, sizeof(dest))

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use sizeof(dest) pattern (thanks Kees)
- rebase onto mainline cbf3a2cb156a2c91
- Link to v1: https://lore.kernel.org/r/20230927-strncpy-drivers-message-fusion-mptsas-c-v1-1-edac65cd7010@google.com
---
Note: build-tested only.

Note: similar to drivers/scsi/mpi3mr/mpi3mr_transport.c +212 which uses
strscpy
---
 drivers/message/fusion/mptsas.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 86f16f3ea478..300f8e955a53 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2964,17 +2964,17 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 			goto out_free;
 
 		manufacture_reply = data_out + sizeof(struct rep_manu_request);
-		strncpy(edev->vendor_id, manufacture_reply->vendor_id,
-			SAS_EXPANDER_VENDOR_ID_LEN);
-		strncpy(edev->product_id, manufacture_reply->product_id,
-			SAS_EXPANDER_PRODUCT_ID_LEN);
-		strncpy(edev->product_rev, manufacture_reply->product_rev,
-			SAS_EXPANDER_PRODUCT_REV_LEN);
+		strscpy(edev->vendor_id, manufacture_reply->vendor_id,
+			sizeof(edev->vendor_id));
+		strscpy(edev->product_id, manufacture_reply->product_id,
+			sizeof(edev->product_id));
+		strscpy(edev->product_rev, manufacture_reply->product_rev,
+			sizeof(edev->product_rev));
 		edev->level = manufacture_reply->sas_format;
 		if (manufacture_reply->sas_format) {
-			strncpy(edev->component_vendor_id,
+			strscpy(edev->component_vendor_id,
 				manufacture_reply->component_vendor_id,
-				SAS_EXPANDER_COMPONENT_VENDOR_ID_LEN);
+				sizeof(edev->component_vendor_id));
 			tmp = (u8 *)&manufacture_reply->component_id;
 			edev->component_id = tmp[0] << 8 | tmp[1];
 			edev->component_revision_id =

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20230927-strncpy-drivers-message-fusion-mptsas-c-f22d5a4082e2

Best regards,
--
Justin Stitt <justinstitt@google.com>

