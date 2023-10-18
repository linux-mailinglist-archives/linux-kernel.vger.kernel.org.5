Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285C7CEA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjJRVjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjJRVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:37:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702918F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:36:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3942461aso10683133276.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697665017; x=1698269817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Apw+K3wbh3OZXkFJF9ttgUhZ1/KMfhepE/h3Z/nrhhg=;
        b=sOMYCpovTxS5U3soGKsPsDhphKBQqQ7pFNpxGbliZWa3duJDcX4NPvNvPCPZXc5TEO
         ALx6sxQUupyBFqtPFN+2he6wwVGU5JmEP8y2OQx9ZpiAFKAT7r6RISQwkgOCFqZJc7Pg
         YOzo5eY0/wAXmSfapFuUFRGYOcOq97e1ZjHM5UKmn+8DnWzki3O5Zh5KVJzpRuVvw2nB
         WQsHhcBg8js8LLsPAWqNgyYRwlDwhskg9TQZ+8v3l0BY0DN6eWDiy9cIWnqzxZ1Rvt7S
         55G4P82nmsJOcvks6cYr4CILy0q0d1IdAXorKwhVDNJglSMmBrnlrTRUJ5Y39P9eTboC
         Nnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697665017; x=1698269817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Apw+K3wbh3OZXkFJF9ttgUhZ1/KMfhepE/h3Z/nrhhg=;
        b=Jx0AvPCjW/PpOtPaZ+//rbvXjqKThSATVOIkx/D1vHYBzR8z2oLTSENYi/KaHz6P4+
         R8zA/z4N5p9G1ngZ7o5STK2GU4VZNCOrgSbD9y45njMGMFsIOvvrU2FM84QBJBhGuOiY
         PZLZ/V3vI8xJ4mboVwYkWaGrAdvZdSnLZzO3TBnDNr6vVT+jY2oMCynr6Z7cdN7kAadN
         r7tVVA+t7ZZs8ONzSOF5IIS+MO2a2KFxmgazdH6iMAVnx9l/+hOER+3mZywjp1nHNFW8
         NSrwGEDfikFg6xTeZsphH53MD/RVxPXYd4wtajJ6lP3KJZUnM2Jgd4yD7nyiVoSWqHNX
         7nXA==
X-Gm-Message-State: AOJu0YxjEoxfV4ew4tQn/s7RdNEHEOPspPzSjP68fXCaxsWZnJNILqG8
        Ra7lYgTZl5ANn6Ky5nozN5OryTo2Qvz+7J+CGA==
X-Google-Smtp-Source: AGHT+IGSlprorlyl1mgbo8vGOacNcFePZOft5yeMt5sY8BpvBoW5KTqkMCOXwEmrGdwrXiVAPLHmL8tY9DH0ADPQMA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3612:0:b0:d77:f6f9:159 with SMTP
 id d18-20020a253612000000b00d77f6f90159mr12678yba.9.1697665017365; Wed, 18
 Oct 2023 14:36:57 -0700 (PDT)
Date:   Wed, 18 Oct 2023 21:36:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPdPMGUC/x3NQQqDMBBG4avIrPuDUWjSXqV0oXHaDkgiM0Et4
 t0buvw27x1krMJG9+Yg5VVMcqpwl4biZ0hvhkzV1LVd71oXYEVTXL6YVFZWQ+KCTZRnNkMRbHP MyhhzLogYexeGcPXe33qqzUX5Jfv/93ie5w8UCQwlfwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697665016; l=2407;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=1sn8QWCZ44RCQzErWJdYQ+n26NCaZzNSi8s/QrSSU98=; b=YvRIzw5H0MFncQuWWs8NbUgiTTAS31UhNBIMEPaFLJXfQmn3tCuNoRcDOJgfhNL1sZanZ+MIn
 k4D3fVgBDSWDd5XXtq+Z2KKqnyS9aoZg0rsaxahj8wROyIki3p5554Q
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
Subject: [PATCH] wifi: wlcore: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
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

We expect wl->chip.fw_ver_str to be NUL-terminated based on its usage
with DRIVER_STATE_PRINT_STR() in debugfs.c:
491 | DRIVER_STATE_PRINT_STR(chip.fw_ver_str);
... which uses DRIVER_STATE_PRINT():
444 | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
... which relies on scnprintf:
434 | #define DRIVER_STATE_PRINT(x, fmt)   \
435 | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
436 | 			  #x " = " fmt "\n", wl->x))

Moreover, NUL-padding is not required.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/ti/wlcore/boot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/boot.c b/drivers/net/wireless/ti/wlcore/boot.c
index 85abd0a2d1c9..f481c2e3dbc8 100644
--- a/drivers/net/wireless/ti/wlcore/boot.c
+++ b/drivers/net/wireless/ti/wlcore/boot.c
@@ -41,12 +41,9 @@ static int wlcore_boot_parse_fw_ver(struct wl1271 *wl,
 {
 	int ret;
 
-	strncpy(wl->chip.fw_ver_str, static_data->fw_version,
+	strscpy(wl->chip.fw_ver_str, static_data->fw_version,
 		sizeof(wl->chip.fw_ver_str));
 
-	/* make sure the string is NULL-terminated */
-	wl->chip.fw_ver_str[sizeof(wl->chip.fw_ver_str) - 1] = '\0';
-
 	ret = sscanf(wl->chip.fw_ver_str + 4, "%u.%u.%u.%u.%u",
 		     &wl->chip.fw_ver[0], &wl->chip.fw_ver[1],
 		     &wl->chip.fw_ver[2], &wl->chip.fw_ver[3],

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-b318a8677793

Best regards,
--
Justin Stitt <justinstitt@google.com>

