Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120AF7AB4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjIVP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjIVP1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:27:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26A8199
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:27:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so2811650276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695396438; x=1696001238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yx7UXzctOd2GGBJ46MDq+/W8zRb8/97PbfKpOmbNRf0=;
        b=sb12I//8gdjw5oaEDIJtIciZtGFg0h9rcFpt5ZUmbzOb0slqLwdSPbNjbOAlJUcd2x
         CbKSnO05ZR4pfumMbNWdNgWogZ9gNECI0chhNnghiowRoETc6YORJfgwyNNImS0y4EtL
         gI5oxqau9LFVbb1v9DJu2wZqmz/GJAk/uG6AN+NFHshZo+W1xPCl+zxcD8iQjpam0ju6
         lVC3GyDAr+1Jr0pOds9kSiwG85Jyexf15LEBBilg6rZXSRN54kX2gHjwIjtKSnHN/4WI
         5IatoDDedspua/oaYEsOx0XsUDZs9nsen/k3p0MNBaMGUkNhUXELFHiRtPQZXYNe2MfK
         NDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695396438; x=1696001238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yx7UXzctOd2GGBJ46MDq+/W8zRb8/97PbfKpOmbNRf0=;
        b=rT4CFAbOzsCbQdlf/p17MOqRsAZzOzf1JX+j2DTPrg5jWotTuzuFHYgYWxQ2CIkQOk
         qgqh4O3nDS/pBmiGUjYklIdBXyGYsRClAq2UslWTrwgjEsQWRNGuMAhOXsOfK6stUf6Z
         vnIRKOe2L4fnQs5j6mv44n2zUnHW/N7F1TcCC1MJWDRpS7Stz4QhJ2VfAX8TacW6wlFj
         s5DvJA/7uX1OCIbqfw9zbyO9rYJoML2a9UrB1X9xCPZGn8Q7HVpF2UUnaj1uVVXsK4qB
         clwGCV5MnDG7Ymgkfv6Gp96H1MHO+NHX40u8W0mx8i7l9Gk7DNXJgeCE9YQVTxri2jWG
         F8dQ==
X-Gm-Message-State: AOJu0YzMwTq4IQnKUbZQDVILUmlclHCquDBKiZpaD/D02TEshdtIuoBv
        hgcDO31d384f/bQD8PGbEEWPhhHsLvUJ3PkdXQ==
X-Google-Smtp-Source: AGHT+IGhilpQEKV9O207YDv1J0qcSmizheQgufZAYvlFGhdU6rhX28q78Gv+I6sxf+lQ2mrUQRJLbz3S0PtHE/WGmA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:562:b0:d85:ae1e:f696 with
 SMTP id a2-20020a056902056200b00d85ae1ef696mr116487ybt.0.1695396438208; Fri,
 22 Sep 2023 08:27:18 -0700 (PDT)
Date:   Fri, 22 Sep 2023 15:27:17 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFSyDWUC/zWNwQrCMBAFf6Xs2YW6pYH6K+KhTV50QWLYlaKU/
 rtB6GVgLjMbOUzhdOk2Mqzq+ipNzqeO4mMud7Cm5iS9DP0kwv62EuuXk+kKc34iHajDNApHDiH kmOcFWBK1UDVk/fwn19u+/wBIt94ddAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695396437; l=1995;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=aH/Nw0wgXmPofMn8+msmli+1RTvUcNQ+NVlfyvVDvCQ=; b=ZWRxzHHGGdhrY8rSZAUGiKrWyLXM756BR/zKBvIX99dEWy6+GTHX00h/IgVVA6bNhrmDfH8cn
 7IfSxl4KYjvBBbUfHKpbcjv9tL4vZ5rcDPVYRGc6Nfp33Bo/GSGKYLe
X-Mailer: b4 0.12.3
Message-ID: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
Subject: [PATCH] leds: lp3952: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect `dest` to be NUL-terminated due to its use with dev_err.

lp3952_get_label()'s  dest argument is priv->leds[i].name:
|    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
|                                priv->leds[i].name);
... which is then assigned to:
|    priv->leds[i].cdev.name = priv->leds[i].name;
... which is used with a format string
|    dev_err(&priv->client->dev,
|            "couldn't register LED %s\n",
|            priv->leds[i].cdev.name);

There is no indication that NUL-padding is required but if it is let's
opt for strscpy_pad.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/leds/leds-lp3952.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
index 3bd55652a706..62ade3f05a87 100644
--- a/drivers/leds/leds-lp3952.c
+++ b/drivers/leds/leds-lp3952.c
@@ -101,7 +101,7 @@ static int lp3952_get_label(struct device *dev, const char *label, char *dest)
 	if (ret)
 		return ret;
 
-	strncpy(dest, str, LP3952_LABEL_MAX_LEN);
+	strscpy(dest, str, LP3952_LABEL_MAX_LEN);
 	return 0;
 }
 

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230922-strncpy-drivers-leds-leds-lp3952-c-666fcfabeebd

Best regards,
--
Justin Stitt <justinstitt@google.com>

