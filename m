Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8197A7564
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjITIJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjITIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:09:01 -0400
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A3CD6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:08:54 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1c02d6efee4so10246619fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695197334; x=1695802134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=REAWAikAYJXQC/q1dB6BWiV4dg8+qBHJA6pZo9MKtrQ=;
        b=d4stG3mmwMKvayPoqNJywOfduTCqejfe/ff/r2PSb9wIzh5m3uYpvcOLm352qPmUbs
         TA0voN4bBdkzl5U0ihgFuC3TGrC8ghqplRUA+PL5PXRX0rwUuyaXhHfs703Y7qW7oJOJ
         K+H0pEhMVGdIRWLPDfOmhsQe9sr4DCZuJSXvCefYKTG/qatI9Rszfr43o0hbxHkypZ4s
         UdE9pjtU31ax5EFJ5Qf00o//vh+vQKZvRUEYdoCYbkAhCE2DJbLnSI49aR59aA7yxz0i
         oRAfugO+2HFEobV7eO6BA8k2mqZ0Pd6f8xIowXuKZRNDXH0q92NuIIRHBJ7FyFE6/VYc
         GwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695197334; x=1695802134;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REAWAikAYJXQC/q1dB6BWiV4dg8+qBHJA6pZo9MKtrQ=;
        b=BTeRROFZdAdu/NAN5drj6DzfDC7ndqrLUuJjFmTpMjT8C0+kxXBQWV90wLD9Gl34do
         fqTCbIA4aHoU4x6miQa9ZcFaCnP4xWqT89KW6yqk6ayR6dCLmx4gNp38ej2kQpIM6xkQ
         lGZx6eRYKwlb9U7X+TZCShZJzJDu+2jbIcGoP/a0BN90YuKFJEMYOSYQNgLLOKBHj1Dd
         oEN+f1MIV7PiYnweOiy6C1mR/LIFJuNob+/YNFxEHvVWfALVfFctRGI5ptYv9ZrEAPNO
         feFZzPkWg0uzxOisHmWZNnTPwILbTxOep+ijjbXjv1pQT7EwGYtd2JQusvvuIYwTmX02
         dWvg==
X-Gm-Message-State: AOJu0Yxsl61UD62+opHcEatimpXgqfFi+/oBrnwDMwkeHhiC5IJrm4Me
        8Q9ypt0nXIjdFEeohp+/e91Ijjfs4jYXoW+IMw==
X-Google-Smtp-Source: AGHT+IEprTy2S7DDywHlMknBrYSwbbE1mFZmKv4PQM+CHnVjbh7wziEtHIiWVjrM4IRkiEMalxvMkv2HUNQB8D7/PQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:76ae:b0:1d6:aa05:c733 with
 SMTP id dx46-20020a05687076ae00b001d6aa05c733mr683064oab.5.1695197334295;
 Wed, 20 Sep 2023 01:08:54 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:08:52 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJOoCmUC/yWNMQ7CMAwAv1J5xlJiVBB8BTEYxwUvIbKhAlX9O
 1HZ7pa7BULdNOA8LOA6W9izdsm7AeTB9a5opTtQon06UcJ4eZX2xeI2qwcaCd7eEfpHaXTIIwo yF06TEvMxQ68118k+2+lyXdcfp11yS3kAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695197333; l=1890;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=peY/eB5hS5lFuPdGG7LKSdDML84Nket0C8FattpjfI8=; b=sgpIFQ7oSn1XZ9OMjko5WEhP6Q5ktCLe0KgZ/OEqR0rGjxM+3HnxdRCXnTgkCRJYoMtT4Lgoj
 TqIRI/KQxrPBTsdjEtbmnlrYumsTKSf/bIFwMnGkJPmXrDcEd5SfvOX
X-Mailer: b4 0.12.3
Message-ID: <20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-v1-1-11406a996794@google.com>
Subject: [PATCH] i2c: cp2615: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     "=?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=" <bence98@sch.bme.hu>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
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

We should prefer more robust and less ambiguous string interfaces.

We expect name to be NUL-terminated based on its numerous uses with
functions that expect NUL-terminated strings.

For example in i2c-core-base.c +1533:
| dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);

NUL-padding is not required as `adap` is already zero-alloacted with:
| adap = devm_kzalloc(&usbif->dev, sizeof(struct i2c_adapter), GFP_KERNEL);

With the above in mind, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/i2c/busses/i2c-cp2615.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 3ded28632e4c..20f8f7c9a8cd 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,7 +298,7 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
-	strncpy(adap->name, usbdev->serial, sizeof(adap->name) - 1);
+	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
 	adap->dev.of_node = usbif->dev.of_node;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230920-strncpy-drivers-i2c-busses-i2c-cp2615-c-aada0fe2aa71

Best regards,
--
Justin Stitt <justinstitt@google.com>

