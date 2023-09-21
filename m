Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1777A9EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjIUULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIUUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78791B9F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:00:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-274d62ab09bso1113179a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322846; x=1695927646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LPoF8K9D4p8OcXev9tyojzk8WlpW/tXHjjMiYBVvNg8=;
        b=4cjR3J3rA5GvlgyawvRc6MduAcCuz1YKdBACdk61Be99jvNBl0BnLRxn+mzKW5yH0R
         GIP1e9rRquMvRbb+UGnqwsBjgxUee9keCxMVNWsnLfBYjpolD7aJqQtGra1FITTb/TRp
         DqNnbNOn753KZ5faGU9cF29BNlb9smdwHpKoZiywyd/Pj0x4WlNTs6bXPyH6A9bCq2Yl
         u1LPaocnOWM0ECYwmpXZs9gTb1z3Hazur+f+Xg+xe91/iGGjo55o54UE+p+mEMxY5yND
         nUbA7HAr1s+LRhYl/gZwH7UjW68bq9zC66+ohU7lxBufSyUIkLZsojnEiMN0xcEzpzY5
         331g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322846; x=1695927646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPoF8K9D4p8OcXev9tyojzk8WlpW/tXHjjMiYBVvNg8=;
        b=OVyKoKN3oKj1jrpFlOXosvBHpnbLopavW+WTvECcykE1u1HFVelIyl4nVAYspiTH8v
         EInnGIsnphel6kK4qqwMb8AzUyB+EICXlNw3sYTPBco4AJPNOwVgdBFG19J0zWyre0ed
         lcPNnRSjHMqR8Xr1OBU/LVngBbFL27Cz5CDN2Btk74Oo+jBhCsxDTZDvOsDATwGozBgS
         YNdtCa2Hhy0Btbthwtl+NbgQS+qu+nBWvA/WhKSFoyXd7oycITxvbSvZRCym0eYzZJNi
         I0BFKWUQYEBgcT0uP4GGfdELf4/53RuQwSFV5qh1SiCH03+hH4yCUTVYHiupH2SgF7CI
         evmQ==
X-Gm-Message-State: AOJu0YxncYJR+NYwfNTN/dZ9ZDkmrF5vJb0GgyygIJ3cPBTO54BFNGW7
        xetIBzgfoAUGnphey2ezcEyk0K5Z8gVusl5Ugw==
X-Google-Smtp-Source: AGHT+IHT7CJnaySUbMIPKL1jnYALwLZyqTPGkyzcPwgXmRZSchWzDvWM0lRHHGjniwwFkTToRpEGV75RBXft9qAaLg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8ca:0:b0:d13:856b:c10a with SMTP
 id 193-20020a2508ca000000b00d13856bc10amr65938ybi.3.1695287846713; Thu, 21
 Sep 2023 02:17:26 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:17:25 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACQKDGUC/x3NQQrCQAxA0auUrA1M04LWq4iLdiZqEMeQ1DJSe
 vcOXb7N/ys4m7DDtVnBeBGXb65oTw3E15ifjJKqgQJ1YaAWfbYc9Y/JZGFzlKy/GT/iEceiFAo qvzFiF/tzuAzUT1OCWlPjh5TjdLtv2w6OsGzyeQAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695287845; l=2368;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=atTHwoOS3ax7JJoTHqO0Ih64Objj21oOjS1ymiaTpOM=; b=CzS67ZEeOOLd2kKtKJHGJgC5Pd6bB/JpQ7ZFhdM3DO2Y3bTZopyE9hqqeykaMwcB9uPwxcM/Q
 PEwK3UJgOzGA86AZCv6t/FGU40dAcrqJp4OWV8hS0LdNF4kYJ6BqAQZ
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-input-misc-axp20x-pek-c-v1-1-f7f6f4a5cf81@google.com>
Subject: [PATCH] Input: axp20x-pek - refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Ensuring we have a trailing NUL-byte and checking the length of bytes
copied are both intrinsic behavior of strscpy.

Therefore, a suitable replacement is `strscpy` [2] due to the fact that
it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

It should be noted that the original code can silently truncate and so
can this refactoring. However, a check could be added if truncation
is an issue:
| len = strscpy(val_str, buf, sizeof(val_str));
| if (len < 0) { // add this
|   return -E2BIG; // or -EINVAL
| }

Also, now check for `len > 0` instead of just a truthy `len` because
`len` is now a signed type and we could run into problems if strscpy
returned -E2BIG which would pass the truthy test.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/input/misc/axp20x-pek.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 4581606a28d6..abcf78785b45 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -134,16 +134,14 @@ static ssize_t axp20x_store_attr(struct device *dev,
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 	char val_str[20];
-	size_t len;
+	ssize_t len;
 	int ret, i;
 	unsigned int val, idx = 0;
 	unsigned int best_err = UINT_MAX;
 
-	val_str[sizeof(val_str) - 1] = '\0';
-	strncpy(val_str, buf, sizeof(val_str) - 1);
-	len = strlen(val_str);
+	len = strscpy(val_str, buf, sizeof(val_str));
 
-	if (len && val_str[len - 1] == '\n')
+	if (len > 0 && val_str[len - 1] == '\n')
 		val_str[len - 1] = '\0';
 
 	ret = kstrtouint(val_str, 10, &val);

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-input-misc-axp20x-pek-c-3c4708924bbd

Best regards,
--
Justin Stitt <justinstitt@google.com>

