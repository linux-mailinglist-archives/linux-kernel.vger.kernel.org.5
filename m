Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531307CB491
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjJPUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJPUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:22:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D883
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:22:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b53a48e5so81075907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697487766; x=1698092566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsgTw1CJMHDMphse0HPVrCXoGi6YQMkmWaeP25eKZWc=;
        b=o8+sNLy08emDvAq4aklEG6lmCDYopFWxnU4+TK1JRj10qWhxodXmgheUSa6MsScsjf
         +ImxPMh3noRohUmbScTUrnNOzHBQdlAdHi0wdAwU2PiLgBDqV/k/RbZsfdoI9iVJBHDb
         8d9lfoWXsNOtFLqSEo0NHu9JgJkWgQ8c8X0Q9NKQ3tLDHPpmC/G7Agnv4GlhkNqPAICy
         CLzmDQP4tp8sTJ73GgGBevE9i1TlE3QcJ5bnl0AIjZXyB3koG/MtYrWERl22y1TuSXUl
         fas+Pt/LjtjtpqOxLE98ETH7AtsrUt5Doi3XvhzTHAgM8nyEHq0467GWqQ7ynRhw4YiO
         5/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487766; x=1698092566;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsgTw1CJMHDMphse0HPVrCXoGi6YQMkmWaeP25eKZWc=;
        b=AXbKiEe1zneL21a6og2iBPlhgezGHDaVNQbHN7FP4waps2pvNTHAO5rXFAYHxxbKTq
         +ciD3sddnYjAyyD0lSR2hThSg8izzljDsTscX8A6sOzGbELdoP/3cQsNSZJhF+B+yv6Y
         xF+P90Em4p55Ng4bpf2qPyWsUsiocjIFyxWYGYuRb5tMGX06XaTjd+I8lSTHiTSIKiG8
         tmVXCeSBVpIhlbuuCtLY3NXdAImoeTfkl0ExuYqfySGIuQwzXbm05YokIxlN6nP/RmlV
         gblJsHLnTgyiKdeWVVzbIsYYsDE6hLC8L5uDCfth78Q96FLow+5ObMNlvK+lCqJfnAGs
         OmZw==
X-Gm-Message-State: AOJu0Yz5bAOlsEzWF1c0n+fhAos3bBRSs2HOWDNtcsaVE+ERQAst7RFt
        3iArvS8xSKv+vUPbuF2eTir8nOLM9GCshY2nXA==
X-Google-Smtp-Source: AGHT+IHQ5wdWI2ysVEyvwpliX52H0WBhxPQy/yEdkoI8j0clA4li6U5CriNyDxKoH6VQ/TdPRKg1iyGE3HtskTtPgA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:8a8b:0:b0:d9a:cc6b:cf1a with SMTP
 id h11-20020a258a8b000000b00d9acc6bcf1amr2518ybl.8.1697487765639; Mon, 16 Oct
 2023 13:22:45 -0700 (PDT)
Date:   Mon, 16 Oct 2023 20:22:45 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJSbLWUC/y2NwQrCQAwFf6XkbKBbqUV/RTws6VsN1LUkS1VK/
 72LeBmYy8xKDlM4XZqVDIu6vnKVcGhIHjHfwTpWp67tjqENJ/ZiWeYvj6YLzDmj8FsNE9w5lie mP4UHiec+SBokRarB2ZD085tdb9u2A/j+Z9J8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697487764; l=2957;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=1+nNVSjnJRHuqWkXwql7HcWOFbNymzy4VcgSRCyCDGA=; b=55/2gEWyZRObYYt9U34T3z95iBbqHlCwUtlamFUm66VwEpc8DS5kSyJPPs7za29bOe/oMzu+s
 SQnU4HCklRvCzbBqjqBR0DvcqPrXnOhw6GF3Vg/DHoA169r0wl1nUkI
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-net-wireless-atmel-atmel-c-v1-1-038d0e73c402@google.com>
Subject: [PATCH] atmel: replace deprecated strncpy/strcpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
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

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. strcpy() is also deprecated [2] and shouldn't be used.

We expect priv->firmware_id to be NUL-terminated based on its usage
with seq_printf() and strlen() in atmel.c:
1420 |       seq_printf(m, "%s loaded by host\n", priv->firmware_id);
...
3884 |       if (strlen(priv->firmware_id) == 0) {

NUL-padding is not required, which is evident by the usage of a plain
strcpy():
3891 |   strcpy(priv->firmware_id, "atmel_at76c502.bin");

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also replace hard-coded lengths to be `sizeof(...)` for buffers
that the compiler can detect the size for as this is less error prone.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [2]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/atmel/atmel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
index 7c2d1c588156..199b9144ef63 100644
--- a/drivers/net/wireless/atmel/atmel.c
+++ b/drivers/net/wireless/atmel/atmel.c
@@ -2011,7 +2011,7 @@ static int atmel_get_name(struct net_device *dev,
 			  union iwreq_data *wrqu,
 			  char *extra)
 {
-	strcpy(wrqu->name, "IEEE 802.11-DS");
+	strscpy(wrqu->name, "IEEE 802.11-DS", sizeof(wrqu->name));
 	return 0;
 }
 
@@ -2651,8 +2651,7 @@ static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 		priv->firmware = new_firmware;
 		priv->firmware_length = com.len;
-		strncpy(priv->firmware_id, com.id, 31);
-		priv->firmware_id[31] = '\0';
+		strscpy(priv->firmware_id, com.id, sizeof(priv->firmware_id));
 		break;
 
 	case ATMELRD:
@@ -3889,7 +3888,8 @@ static int reset_atmel_card(struct net_device *dev)
 					printk(KERN_INFO
 					       "%s: if not, use the firmware= module parameter.\n",
 					       dev->name);
-					strcpy(priv->firmware_id, "atmel_at76c502.bin");
+					strscpy(priv->firmware_id, "atmel_at76c502.bin",
+						sizeof(priv->firmware_id));
 				}
 				err = request_firmware(&fw_entry, priv->firmware_id, priv->sys_dev);
 				if (err != 0) {

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-atmel-atmel-c-7ca951cf7cfa

Best regards,
--
Justin Stitt <justinstitt@google.com>

