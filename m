Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95146784DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjHWAXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjHWAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:23:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3800CE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:23:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c4d30c349so70537247b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692750191; x=1693354991;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3x3tBh3Vf50HGlTpal2RTIKo4CsU3ox4YMR66KiQTBI=;
        b=MyV/oC/BRK6jmaCE8J0LYC+vBsViNV/rFbxlApV69c53BzPTkFtKqQhpOFBMO2sZpy
         N/jnvEXz4gXC/Qcl4GBcy01zh8S5isviuJiMZo2tbLBEIigP3zT47ApEz7IbO7pfcL18
         qi5AhX9iKyK+o9HSXR13mg8leBFAawwBYUWYC3epJ6wKBLwo1u3RnNDCnBceoTeLzP+v
         rUqW3yth6kiX8gHa8imjKFoV+UY7Fe+XnpqucDVNirpBSK87V4rlwE3mf1tfh4OL23tU
         XIN9b8uvQVRtSs0ZM5eU9f0kscZaCkkyyLTYez+IHJjYj5QODg2WXFp62Llql/5lIKJT
         Fj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692750191; x=1693354991;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3x3tBh3Vf50HGlTpal2RTIKo4CsU3ox4YMR66KiQTBI=;
        b=AU9RmnksxwowXuYQjvAxYG2OSOMDDrg+3iTYoq4MS8EPgYq9Q6lairTRwxU9zTxGNy
         o8M7v8Qu2A1dG0OsMIvzLisJMhuwCwKiG7zkX81LmIQOU8LPxwlv4GcXiaeIYNH06JYp
         sfut8oGSiDpH2hee66cjbAHfovTNg7hp+nh6kdMZr5YiNZAS687oz/JbMxrEMmXJLz3j
         3lt7qOWmDKWtwD1VJV7pSpaNQUylDBVvPVFKrak1cPCe62GuxtOcOSJo1wIz4MfxlFPf
         5UiedkxGdnRfL89r1WMA7n1WNNLDBb07imdWrJMSJmYWy5WXwTuqL+FtsmxsCNlMrIpM
         9IPQ==
X-Gm-Message-State: AOJu0YyMz5xXzOLlOvmHKzkQLbUih+IWfjjMwP7c70qG3L00XQFVBsh1
        sBGcDPwfPv44dv0x8yTPbkI9fyY0djcpyy8YxA==
X-Google-Smtp-Source: AGHT+IGw2PPH1jOdI89Gh9dba9yEpLmOP5/IEYkom5E98zWneFiQ+DiLyvpEvOed/xWs0x4fPinQAJSWQauH35Ds2w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae46:0:b0:581:3939:59a2 with SMTP
 id g6-20020a81ae46000000b00581393959a2mr131731ywk.3.1692750191202; Tue, 22
 Aug 2023 17:23:11 -0700 (PDT)
Date:   Wed, 23 Aug 2023 00:23:08 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGtR5WQC/02NQQrCMBAAv1L27EJNQYNfEZF0s7ELbVJ2S1BK/
 27w5HHmMLODsQob3LodlKuYlNzgfOqAppBfjBIbg+vd0Hs3oG2aaf1gVKmshoGIZ5zCGHKYw2h IZVlK/jPPqBWvKTGli/eOI7T4qpzk/RvfH8fxBdHIWX+IAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692750190; l=2756;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WYGpuHoW945FOta5XAIWUuvSqbMRDz8VPn8OBeiDyDg=; b=T+2ld1hmB/HimoMnEMvAWegFZsg7hBRbBkRPBx2pRcmQQo7bNpifXR7ceVvT+pDClKJqzSWjK
 9XcDpC1slyLBKFpYKIt4Av8qs+VbjMcUL9QXtIzhy+Tu0LhylztG1Rn
X-Mailer: b4 0.12.3
Message-ID: <20230823-strncpy-drivers-accel-habanalabs-common-habanalabs_drv-v1-1-147656947586@google.com>
Subject: [PATCH] accel/habanalabs: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

There is likely no bug happening in this case since HL_STR_MAX is
strictly larger than all source strings. Nonetheless, prefer a safer and
more robust interface.

It should also be noted that `strscpy` will not pad like `strncpy`. If
this NUL-padding behavior is _required_ we should use `strscpy_pad`
instead of `strscpy`.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/accel/habanalabs/common/habanalabs_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 7263e84c1a4d..d9a3418b5ae4 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -408,13 +408,13 @@ static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 	hdev->pdev = pdev;
 
 	/* Assign status description string */
-	strncpy(hdev->status[HL_DEVICE_STATUS_OPERATIONAL], "operational", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET], "in reset", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION], "disabled", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET], "needs reset", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_IN_DEVICE_CREATION],
-					"in device creation", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE],
+	strscpy(hdev->status[HL_DEVICE_STATUS_OPERATIONAL], "operational", HL_STR_MAX);
+	strscpy(hdev->status[HL_DEVICE_STATUS_IN_RESET], "in reset", HL_STR_MAX);
+	strscpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION], "disabled", HL_STR_MAX);
+	strscpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET], "needs reset", HL_STR_MAX);
+	strscpy(hdev->status[HL_DEVICE_STATUS_IN_DEVICE_CREATION],
+		  		"in device creation", HL_STR_MAX);
+	strscpy(hdev->status[HL_DEVICE_STATUS_IN_RESET_AFTER_DEVICE_RELEASE],
 					"in reset after device release", HL_STR_MAX);
 
 

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230823-strncpy-drivers-accel-habanalabs-common-habanalabs_drv-7ffecf6882ed

Best regards,
--
Justin Stitt <justinstitt@google.com>

