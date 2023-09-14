Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7557A1141
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjINWrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjINWra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:47:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9B2711
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:47:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81873bf443so1607542276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694731645; x=1695336445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WlEmBKsST15BXxXfgVar1XzghXpy2BhN9U0IxRoXCQE=;
        b=PaYMZoQzQ6DiCCY1Khy+ts0DFKWlN5CH+6GQOuWvaoucwuopd5LO7fmc/OKtZF/QXO
         pU0r607zjhM8We2E93VejyCu2XgYzY7tBCNVI1Ke5rWM8K7bRchg/YkqSF2IJTDo9kw+
         eX4MKOxy9CPsHqdARDzdGFQhSi/9mVpdVfugsaSO1JhZmmGtpaSKaxh+uJoABzAlnHwX
         cD+fJZnheQHSG+L06RZeNlh9B2dSEKcM1nl/Ur7e+prSSeTexZlegtuXAeKU0KzLKUWq
         cVbwpnyiPj2yGXD5Acjy80DAiVBKnagdVBs3m4qWbrS766Be+JYUpF5SDRcfWBWv5VLh
         VSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694731645; x=1695336445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlEmBKsST15BXxXfgVar1XzghXpy2BhN9U0IxRoXCQE=;
        b=mEFykHIqgn0gQd8i20yYf+HOIRV6hlbS7oOdH6A5HvFmDUQ7CZa/W8arwrstLs8w5T
         Z1RBIaP52nclZccISJC9WTiFmdZH3ECBM6+HXl8QhNkcIYccBfOaZ9uKQUZL6/ZZJP8l
         UEj/rieqX+6khGs+4XCyNsyeYS0rdRMD6Q1ResJBbxdOkpQNVA4NqJhQY+D3cnNKcWd6
         MFFCtx0mVtI+OpGEWk24Zs/egBnfiBXhNyTt+3ts2qP0+kJ+ts+U1nd1Jl/tw0HEEH4v
         6VtyVZJnqFD3pXfWJq0WGJnKLOjQ3V8Nq4/m0WxdQ3MXpG+DSoulWKb1SfqqwHet9WES
         8vLw==
X-Gm-Message-State: AOJu0YyS9mSJZ0F30HDrGxgntfliQTrrmWqRvBW5ss1bX7MpxqZeJzw2
        /RSOrSLuJKP17lFXAHfNEBbU7SRVZ7X423AsIA==
X-Google-Smtp-Source: AGHT+IGkdKJsDoRPj6iOAbB6G6mb6EbzU9PdlEfuupjk+OmoelGiAAQezQx06Su0QGHeD/GXGFFXlSq//vqRnmROdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:481:0:b0:d80:bea:ca87 with SMTP id
 n1-20020a5b0481000000b00d800beaca87mr170215ybp.1.1694731645064; Thu, 14 Sep
 2023 15:47:25 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:47:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHmNA2UC/x3MPQqEQAxA4atIagP+jLrrVRYLmURNM0riiiLe3
 dHmwde8E4xV2KBNTlDexGQOEXmagJ/6MDIKRUORFWX2zR3aqsEvB5LKxmo4CeH/icfe1dVQcvN xRBAHi/Ig+zv/ddd1A6Gwul9sAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694731644; l=2748;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Ro3W2l30+BkUgaszKfSJpsko0I3zSOwBNarLcip1Cv0=; b=+Ja/3VwcQv8Olj4st1v7gaQMddtIhh5AF/TwEtWpW6owvTXLz0/I8erXLOUpXoFmb5Z9njm4T
 vZydOgdhr/SDE99w0xuyh/SH2rl1X/0la8SdmEemgGQah5zf2h7fMX+
X-Mailer: b4 0.12.3
Message-ID: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
Subject: [PATCH] HID: uhid: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Looking at: Commit 4d26d1d1e806 ("Revert "HID: uhid: use strlcpy() instead of strncpy()"")
we see referenced the fact that many attempts have been made to change
these strncpy's into strlcpy to no success. I think strscpy is an
objectively better interface here as it doesn't unnecessarily NUL-pad
the destination buffer whilst allowing us to drop the `len = min(...)`
pattern as strscpy will implicitly limit the number of bytes copied by
the smaller of its dest and src arguments.

So while the existing code may not have a bug (i.e: overread problems)
we should still favor strscpy due to readability (plus a very slight
performance boost).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/hid/uhid.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 4588d2cd4ea4..00e1566ad37b 100644
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
 
@@ -514,13 +514,9 @@ static int uhid_dev_create2(struct uhid_device *uhid,
 		goto err_free;
 	}
 
-	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
-	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
-	strncpy(hid->name, ev->u.create2.name, len);
-	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
-	strncpy(hid->phys, ev->u.create2.phys, len);
-	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
-	strncpy(hid->uniq, ev->u.create2.uniq, len);
+	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
+	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
+	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
 
 	hid->ll_driver = &uhid_hid_driver;
 	hid->bus = ev->u.create2.bus;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-strncpy-drivers-hid-uhid-c-a465f3e784dd

Best regards,
--
Justin Stitt <justinstitt@google.com>

