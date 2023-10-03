Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF347B72FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjJCVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjJCVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:02:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBAB0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:02:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d868842eda1so1814893276.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696366921; x=1696971721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9OlLlHc2AYiWsThRdc3PqfHZGtUph4N7so6saZ8WNZY=;
        b=ciA6jMiVZFrxHCY0rquKorgXufiRCKFG+cQDCTz4GBxmMwnxBGra5kD71Lyua9/LEi
         6Vji2YdIcbe2T3YpCqlgBjKdohwq06Np+VeUXKZCA7d4ZXUvuYkO8jSRM/KRQI+dk+K3
         0k8LGAC+4Ploy6UYT9q5msGBCcgHdyKcPcYxDRFbeEzcRVKbcpGCoXDuEu6BvDBn+2JF
         ppXmGYR5cJQjzvutGY07sWIW5jRA52qLMuB0Fk3Q9dnG5FlqUbj9MeoV/ybTd3sc6gDv
         eOO3TjpMd9mpOmo69LIfZWGppkvhsfEi5LeKDTz6VEwo4HkolvKbB2pihoJeDxkMHdqq
         oy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696366921; x=1696971721;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OlLlHc2AYiWsThRdc3PqfHZGtUph4N7so6saZ8WNZY=;
        b=rbX2CHjG71qeCRmKiEx0Pvrnt9FcyE77jpfYqH+MekMMR3SeK4lAaFuN/JrzgHs7cj
         bK+IsTHrv65gAEV3d+x95mu1Rei1RVLAORpXaAJAPc0eNytdmFd8uzabBiu4SKy2gphr
         GBEGxMvIo7itCRJQ8jXZrYmk8HIoCeipW3AsMBnOtPWsSalLWc3pkuvQoMmJlEUsUb+w
         LEvzHILdVBYrW2CGUspvy3C0/M5qK1a5XKmPbfzO1tn/sVQdAaLFZ7XXECgrukf3oNci
         ZPZ57Hgjlp8Fh3qRZh/Q9efaI3Ve52DA/vTNSJoyoPNQaS3y+AWnF4VFtrYGfobPVHMD
         MkAQ==
X-Gm-Message-State: AOJu0Yzz0ij6GQ/r+FD9HdPKrC5+UicCUX9szXEtM9nCL/xCyar8/YkL
        IWz4SRh1raHs1RgL/PwCMNW7pgrTjxp2pV7EHw==
X-Google-Smtp-Source: AGHT+IGI158dW+NTAxIrRXdLLEfJH1mjzfkpBb1kd0Unh+SwwUQRS9YHJxm2lmimr4dpsxqJq3mX6DWEeBXweRzNRg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:212:b0:d89:b072:d06f with
 SMTP id j18-20020a056902021200b00d89b072d06fmr6867ybs.7.1696366921501; Tue,
 03 Oct 2023 14:02:01 -0700 (PDT)
Date:   Tue, 03 Oct 2023 21:01:58 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEWBHGUC/42NQQqDMBBFryKz7pRErbVd9R7FhWRGHWiNTGyoi
 Hdv9ATlw4f3F++vEFiFA9yzFZSjBPFjgvyUgRvasWcUSgy5yQtzsyWGWUc3LUgqkTXgIISfvRy
 2ZXXpCr7WJREkwaTcyfeQP5vEg4TZ63J8Rbuvf2mjxZS6tTdjKkM1PXrv+xefnX9Ds23bD8box cjFAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696366920; l=2843;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=fPTrIY2uQ734r/+gbDBG2QG/Vp0F9Llz6laPStW03L4=; b=ix0M1cN1JC7FZ8ld1+Vt91xRDUNU/CZiyhxc6Hf8g7BcWGtYE678ITzZyYtAutza+nAvpgGHn
 s6qhBc5/ZwzB9TsSz7H51MzEGlkeJtCYd7EQ/PpJ8q9tWFPBbpbOjWN
X-Mailer: b4 0.12.3
Message-ID: <20231003-strncpy-drivers-hid-uhid-c-v2-1-6a501402581e@google.com>
Subject: [PATCH v2] HID: uhid: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        David Rheinsberg <david@readahead.eu>,
        linux-hardening@vger.kernel.org,
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

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Furthermore, let's make sure `hid->xyz` and `ev->u.create2.xyz` are the
same size at compile time to prevent silent truncation.

With these changes, it is abundantly clear what the intent and behavior
of the code is -- We are getting a string to string copy with
NUL-termination and no truncation.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update subject + commit message (thanks Kees)
- use BUILD_BUG_ON size mismatch (thanks Kees and David)
- Link to v1: https://lore.kernel.org/r/20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com
---
 drivers/hid/uhid.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 4588d2cd4ea4..a54c7995b9be 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -490,7 +490,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 			    const struct uhid_event *ev)
 {
 	struct hid_device *hid;
-	size_t rd_size, len;
+	size_t rd_size;
 	void *rd_data;
 	int ret;
 
@@ -514,13 +514,12 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
-	strncpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
-	strncpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
-	strncpy(hid->uniq, ev->u.create2.uniq, len);
+	BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
+	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
+	BUILD_BUG_ON(sizeof(hid->phys) != sizeof(ev->u.create2.phys));
+	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
+	BUILD_BUG_ON(sizeof(hid->uniq) != sizeof(ev->u.create2.uniq));
+	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hid-uhid-c-a465f3e784dd

Best regards,
--
Justin Stitt <justinstitt@google.com>

