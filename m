Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853937AF9A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjI0Epm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjI0Eoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:44:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755F361A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:06:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e78032ef9so212072327b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695787583; x=1696392383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muQRz7J2lzpUyBnJLzYwr4LEEEw5RWh2QZi+e4QQ9Ck=;
        b=0XzGvJa1L+yZh4aZHanhTfTUEnsEt27cRpli89EBL0zcaXPqvll0mmqDOnRPV6e+8i
         7/0Zwa3xX8xy/xuFQiQESpcmJe7o8iYldMbYe6IKDJXpz3lEvIG3+C8Xc4G7G5OFrS6m
         V2ZrrR+/q6ye6xKeNOjEynx/wvAGdjIK4WUlIBthOCKZBr78jQzbEPODyM56D+u2hjGn
         G0Iju5uho8/jtuMCy5xnQgKIOK1BAc18DWL4rSKFdRNP0xxv/vjxmii8gKMaMvwGeRlj
         DII6zuOWUjS9qUfFK9jzI8LenEnCDqOoqQh/KMagyXC0ZKYmBUBpghB/+czd/69x+X7L
         RcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787583; x=1696392383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muQRz7J2lzpUyBnJLzYwr4LEEEw5RWh2QZi+e4QQ9Ck=;
        b=p34kdwllEiKxxgMKgZW9DFgHtiI7vMKBkcD+YZSQ1xcT5yJKwV8uoBUk9P+1zBiE/I
         +4odGrSSP22kneIpuWeLt4bfHTWzICyty750u85EHaicf8tlJirR+YwPZyIvhsHG6T9S
         /7Z/zfabIMBPWPkF7xV6eJDUaYSA2V6afrB5ZvZ2s2uxr8K7CiAVj/NyGepdytXnBBpL
         L86W9tDX5yRD4nJpwHPjJvHm91wy9J955z5Ve1mTfpcyFCQ8CdH6NbHteto/f5UqqhWB
         lAaKqjEaqGEqw9U7yCe9lP8a4gdEgyy3wK5fVNi/bwuADPf2mspK7sXkaHX8DalaNXrz
         e+Ng==
X-Gm-Message-State: AOJu0Yxr8jWw8VE1hhr5S95ubkTYT1ULw9TEr3Qq6pMY0uCW9edyf3+Y
        8XawcfRJqv07hEkwQHcCI0ZewCS+5QRaGn80UQ==
X-Google-Smtp-Source: AGHT+IGsXNoWWYJOPzCYKtauH719o/KetAshJi2wOaDvi+H+P1j+pOhifslLD+fTpHe+INzB6DLUTvY3yrJWyDOwWg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:e308:0:b0:59f:2323:acb5 with SMTP
 id q8-20020a81e308000000b0059f2323acb5mr12644ywl.3.1695787583729; Tue, 26 Sep
 2023 21:06:23 -0700 (PDT)
Date:   Wed, 27 Sep 2023 04:06:09 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADCqE2UC/x2N0QrCMAxFf2Xk2cDsKHP+ivhQ00wDrpakG8rYv
 9vt8cA996xgrMIG12YF5UVMPqnC+dQAvUJ6MkqsDK51XTu4Hq1oovzDqLKwGk5sFupsnHcVp1y ovJHQc+/9heLQhQfUt6w8yvco3e7b9gcnFoW+eQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695787582; l=4204;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=QWt5IYuPT1K3lDjtegiynEZCkUucvHzztTM0T9agtnc=; b=ZCWCZUT8EBoFkt5LsljAQshOVImItYimTU2LI5U7jKMuSeL2a2rUgBRthWA0DILUqU9Q4gtrl
 GBz5dkv7YDvDJrqmtxK8mN5zTIdRo5Im4nuTxY5F8Kh4Vm6KQRy8MCY
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-message-fusion-mptctl-c-v1-1-bb2eddc1743c@google.com>
Subject: [PATCH] scsi: message: fusion: replace deprecated strncpy with strscpy_pad
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Since all these structs are copied out to userspace let's keep them
NUL-padded by using `strscpy_pad` which guarantees NUL-termination of
the destination buffer while also providing the NUL-padding behavior
that strncpy has.

Let's also opt to use the more idiomatic strscpy usage of:
`dest, src, sizeof(dest)` in cases where the compiler can determine the
size of the destination buffer. Do this for all cases of strscpy...() in
this file.

To be abundantly sure we don't leak stack data out to user space let's
also change a strscpy to strscpy_pad. This strscpy was introduced in
Commit dbe37c71d1246ec2 ("scsi: message: fusion: Replace all
non-returning strlcpy() with strscpy()")

Note that since we are creating these structs with a copy_from_user()
and modifying fields and then copying back out to the user it is
probably OK not to explicitly NUL-pad everything as any data leak is
probably just data from the user themselves. If this is too eager, let's
opt for `strscpy` which is still in the spirit of removing deprecated
strncpy usage treewide.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/message/fusion/mptctl.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index dd028df4b283..9f3999750c23 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1328,8 +1328,8 @@ mptctl_getiocinfo (MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 
 	/* Set the Version Strings.
 	 */
-	strncpy (karg->driverVersion, MPT_LINUX_PACKAGE_NAME, MPT_IOCTL_VERSION_LENGTH);
-	karg->driverVersion[MPT_IOCTL_VERSION_LENGTH-1]='\0';
+	strscpy_pad(karg->driverVersion, MPT_LINUX_PACKAGE_NAME,
+		    sizeof(karg->driverVersion));
 
 	karg->busChangeEvent = 0;
 	karg->hostId = ioc->pfacts[port].PortSCSIID;
@@ -1493,10 +1493,8 @@ mptctl_readtest (MPT_ADAPTER *ioc, unsigned long arg)
 #else
 	karg.chip_type = ioc->pcidev->device;
 #endif
-	strncpy (karg.name, ioc->name, MPT_MAX_NAME);
-	karg.name[MPT_MAX_NAME-1]='\0';
-	strncpy (karg.product, ioc->prod_name, MPT_PRODUCT_LENGTH);
-	karg.product[MPT_PRODUCT_LENGTH-1]='\0';
+	strscpy_pad(karg.name, ioc->name, sizeof(karg.name));
+	strscpy_pad(karg.product, ioc->prod_name, sizeof(karg.product));
 
 	/* Copy the data from kernel memory to user memory
 	 */
@@ -2394,7 +2392,7 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	cfg.dir = 0;	/* read */
 	cfg.timeout = 10;
 
-	strncpy(karg.serial_number, " ", 24);
+	strscpy_pad(karg.serial_number, " ", sizeof(karg.serial_number));
 	if (mpt_config(ioc, &cfg) == 0) {
 		if (cfg.cfghdr.hdr->PageLength > 0) {
 			/* Issue the second config page request */
@@ -2408,8 +2406,9 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 				if (mpt_config(ioc, &cfg) == 0) {
 					ManufacturingPage0_t *pdata = (ManufacturingPage0_t *) pbuf;
 					if (strlen(pdata->BoardTracerNumber) > 1) {
-						strscpy(karg.serial_number,
-							pdata->BoardTracerNumber, 24);
+						strscpy_pad(karg.serial_number,
+							pdata->BoardTracerNumber,
+							sizeof(karg.serial_number));
 					}
 				}
 				dma_free_coherent(&ioc->pcidev->dev,
@@ -2456,7 +2455,7 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 		}
 	}
 
-	/* 
+	/*
 	 * Gather ISTWI(Industry Standard Two Wire Interface) Data
 	 */
 	if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL) {

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-message-fusion-mptctl-c-5e7558cd93ab

Best regards,
--
Justin Stitt <justinstitt@google.com>

