Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2F7ACF20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjIYEbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYEbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:31:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B80EE1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:31:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f616f4660so48149717b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695616268; x=1696221068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9uHumzTyf+gjmcuSq47+yVY/ogRXox3AvMpCppjL8A=;
        b=L/5s9hS+tgCT2x3dMNT6z9FXQPlt6oZJn2ctzmnys3Nubs7O+NOlwJvHa0NqJMz7co
         QLeQbpZgRyXETyg1V7rJqQLAkqv/g6YJgs0u2g+XY1WGuo7zu1g5U9KHfgeg9kyEoZ7L
         /O1KPPNFAPH+RUk3mM5VppU1WixW2VRqla5TK1A8F34YyEj8ykzAJtl8A4fRyuln4uCI
         302kH3kfDLsi9ZNMdR94zUOskb4Bk7kfi5eA95zgoRZpQBO58QVsDHQ8jB09J/qNB+9m
         bm6jQd/6j6qQ09o8zw1AtmLzxk/1DWpcjbUMhIasHxfzHxfDQmSKyh7okAk7KVIiGOqS
         5Rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695616268; x=1696221068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9uHumzTyf+gjmcuSq47+yVY/ogRXox3AvMpCppjL8A=;
        b=TM+08jghDzHHqydphKdQ+GZICwpdP7p5rC27qWTYB6jpIhAam4EFiLF6IupFrl+rxn
         KSpopxHKKHfmKmYj4PmULagqcAzQPGTuGNbGjh/qe6imxadmW6aYto+z5pykTTpSU5z8
         MsdTXfQZEfHTDUjs+ZEKkcZFFu/KNDW6kS4mCL+/XFAADHCS+sMp1oGmDqcsQx/fq2kr
         +qu+wzcXayP9nfbknt6JQRQBuzEwDXaB8lpjtKROZKZA1GdbLPTKYYS6iZhhm4aZ8EuZ
         FvAEImF3EXzRq4HNMYcl6Ods58+z9Ckl5e00/DNJ+9J2mgjgMmcZIN+ejhMmvDodukai
         sJCw==
X-Gm-Message-State: AOJu0Yyt5GPboIiD4rJlxiFvMIq43Fk879dK9U6LXD8I+OKWdbip2SXM
        j3/n7dMQat/f8jXGEDmhTE2vQc6X2xx56jcbdA==
X-Google-Smtp-Source: AGHT+IHPf37TtcAQw/kZ/if+wxjiRYYEoKTZ/EE11hWMdLINb9IuxCcKQ3MtEWuw4p0np8qDJEFrJ0n1xqFOgQcaNA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:eb0c:0:b0:58c:7cb1:10f with SMTP
 id n12-20020a81eb0c000000b0058c7cb1010fmr64056ywm.9.1695616268339; Sun, 24
 Sep 2023 21:31:08 -0700 (PDT)
Date:   Mon, 25 Sep 2023 04:31:05 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAgNEWUC/5XNSw6DIBSF4a0Yxr0NoK2PUffROFC86E0rELBEY
 9x7qTvo8D+D8+0soCcMrMl25jFSIGtSyEvG1NSZEYGG1ExymfNaCgiLN8ptMHiK6AOQcZ8FZgo
 KutVJvoLDFyjIVVHyqpZF3w8svTmPmtZTerapJwqL9dsJR/Fb/zeiAAG61HdddDelK/EYrR3fe FV2Zu1xHF9KMXl23wAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695616267; l=2212;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Sw+ZJKnGZ+JwKov1VeH3ACtZRgGvZ2w/x0E7T3CskvA=; b=DqRU49YR3wzheuEpQc3E2ii9tcBqhXWtzvAnZX/mi6knIBj7UivaiZux27mnaODzfuwNsJ4jT
 6pgb6ayjgqFBTY47ZtK16xtYWzLYXRTlLuAQyXIH0qqWIODFqN7j+W7
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-input-misc-axp20x-pek-c-v2-1-ff7abe8498d6@google.com>
Subject: [PATCH v2] Input: axp20x-pek - avoid needless newline removal
From:   Justin Stitt <justinstitt@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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

This code is doing more work than it needs to.

Before handing off `val_str` to `kstrtouint()` we are eagerly removing
any trailing newline which requires copying `buf`, validating it's
length and checking/replacing any potential newlines.

kstrtouint() handles this implicitly:
kstrtouint ->
  kstrotoull -> (documentation)
|   /**
|    * kstrtoull - convert a string to an unsigned long long
|    * @s: The start of the string. The string must be null-terminated, and may also
|    *  include a single newline before its terminating null. The first character
|    ...

Let's remove the redundant functionality and let kstrtouint handle it.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- remove eager newline removal (thanks Kees)
- use better subject line (thanks Kees)
- rebase on 6465e260f4879080
- Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-input-misc-axp20x-pek-c-v1-1-f7f6f4a5cf81@google.com
---
Note: build-tested only.
---
 drivers/input/misc/axp20x-pek.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 4581606a28d6..24f9e9d893de 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -133,20 +133,11 @@ static ssize_t axp20x_store_attr(struct device *dev,
 				 size_t count)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
-	char val_str[20];
-	size_t len;
 	int ret, i;
 	unsigned int val, idx = 0;
 	unsigned int best_err = UINT_MAX;
 
-	val_str[sizeof(val_str) - 1] = '\0';
-	strncpy(val_str, buf, sizeof(val_str) - 1);
-	len = strlen(val_str);
-
-	if (len && val_str[len - 1] == '\n')
-		val_str[len - 1] = '\0';
-
-	ret = kstrtouint(val_str, 10, &val);
+	ret = kstrtouint(buf, 10, &val);
 	if (ret)
 		return ret;
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230921-strncpy-drivers-input-misc-axp20x-pek-c-3c4708924bbd

Best regards,
--
Justin Stitt <justinstitt@google.com>

