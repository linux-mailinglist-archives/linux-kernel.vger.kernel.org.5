Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FF76C1A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHBAw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHBAwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:52:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E907E272B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:52:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso6417391276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690937533; x=1691542333;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=obeFRpW8AYhzbmmoq1DiRi4HxlUEfZaLRPLqAl0NRfo=;
        b=thg3NZMh6vjFMBUxAnTa+WDOtVZoZqPpH+eWTTn5TuDaTCKlmgaWk3L4qmanb9Wdly
         jeht+hHTmj2BLgGttxoxJz6osvJ5Ch7o8yDV+HJRPflnZPcfI4t6qVGcHu2J7u9hfOEh
         l9G6BzXCwcEzBWwNQEfNnedP3MPmzrY+Lyg7TUqbcsmUyFmdmSpqs59ZjL19HfzxaEaH
         xT5EN3h8NbZSqQ/0lzdxTR8llRdl5+T/g24BSmguzzYkYmjzJPEO8sl5LEPx+qXAKcPV
         hBR3Htpil+Zck0RqlGB3HdPGcehSjnRaF32rj6l2nNtDd1XizbBdujtdlqIm7qP6er0r
         OApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690937533; x=1691542333;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obeFRpW8AYhzbmmoq1DiRi4HxlUEfZaLRPLqAl0NRfo=;
        b=QvZyX94bN3b1U9fpd+VUunI2t7Z+dkci0qMvuB6DuTBTOTsstbk2pUWnriJO+lCVc5
         hZwrKnE5QzJfTatQWfFuzN0COAne7LoD2/JVK44IUckbSCn5KxYvQbuCfQLQOvr9xOnn
         BHL9jLg0Yb6TprslAq6SVgG2nQP/jG0myFowx7yyH+KqWEDjolXT7egDrkwSTpRee+fa
         jrXOKhtYhmDrgD3ufInokHyMOSV6tAP9bjWB7m39bIhRmvVNsCH9Mmsu+qKvSphdms2A
         b4Gy69fEoR7KHXbiSdMfoWEDB1gWD9Tj6o3xQcPyKkRpsPCnw7O9rF+AwVwtK/NsPHHP
         7g+w==
X-Gm-Message-State: ABy/qLacUHiEikvwivFf6Pvn6oE9Vj+a8wEUN2KI7jR+YRHrbOYCnY6r
        yu1VXt05BSAZsZjeGsLd/Tu+SDiVVF3qv/jjLw==
X-Google-Smtp-Source: APBJJlFhxgPZBdXHw+VY4WvwHlwFkMMfNX8LDv5EjqdJmwxh+ubRjxluBdhj5luHPyA0U7riE7cY7BkON2ePXIPZFw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:160e:b0:d09:6ba9:69ec with
 SMTP id bw14-20020a056902160e00b00d096ba969ecmr104112ybb.4.1690937533495;
 Tue, 01 Aug 2023 17:52:13 -0700 (PDT)
Date:   Wed, 02 Aug 2023 00:51:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK6oyWQC/3WNQQ6CMBBFr0Jm7ZhOkQKuvIdhUesAkyglrQEM4
 e5WEpcu35//36wQOQhHOGcrBJ4kih8S0CED19uhY5R7YtBK56pShLO0gjLOelEKA7fWvXzA1po
 734wzJVtI2zFdZNm91yZxLzHV3vubib7pz6j/GCdCwrwonKGyOtVUXzrvuwcfnX9Cs23bB3Fng mO7AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690937532; l=3595;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=/vqUf7+WVfd2a+zt/8BLX8kVXNwUbb6rD6wWpLczoRM=; b=tXYiNHuAaOT2LMU4DyjPlZlJ2DzI2u88X7o44fKYwYyKMov7zh4fCkZRX6mJrTCXO2710elFc
 /A5y8BASRiTBcET9lU/YL11Bq8DuJup/OUlFO9QUdsB1C3ChRehIUVJ
X-Mailer: b4 0.12.3
Message-ID: <20230802-wifi-ipw2x00-refactor-v1-1-6047659410d4@google.com>
Subject: [PATCH] wifi: ipw2x00: refactor to use kstrtoul
From:   Justin Stitt <justinstitt@google.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation seems to reinvent what `kstrtoul` already does
in terms of functionality and error handling. Remove uses of `simple_strtoul()`
in favor of `kstrtoul()`.

There is the following note at `lib/vsprintf.c:simple_strtoull()` which
further backs this change:
| * This function has caveats. Please use kstrtoull (or kstrtoul) instead.

And here, simple_str* are explicitly deprecated [3].

This patch also removes an instance of the deprecated `strncpy` which helps [2].

Link: https://lore.kernel.org/all/202308011602.3CC1C0244C@keescook/ [1]
Link: https://github.com/KSPP/linux/issues/90 [2]
Link: https://docs.kernel.org/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull [3]
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---


Link: https://lore.kernel.org/all/20230801-drivers-net-wireless-intel-ipw2x00-v1-1-ffd185c91292@google.com/
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 43 +++++++++-------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index dfe0f74369e6..ac10633f593e 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1176,23 +1176,20 @@ static ssize_t debug_level_show(struct device_driver *d, char *buf)
 static ssize_t debug_level_store(struct device_driver *d, const char *buf,
 				 size_t count)
 {
-	char *p = (char *)buf;
-	u32 val;
+	unsigned long *val = NULL;
 
-	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
-		p++;
-		if (p[0] == 'x' || p[0] == 'X')
-			p++;
-		val = simple_strtoul(p, &p, 16);
-	} else
-		val = simple_strtoul(p, &p, 10);
-	if (p == buf)
+	int result = kstrtoul(buf, 0, val);
+
+	if (result == -EINVAL)
 		printk(KERN_INFO DRV_NAME
 		       ": %s is not in hex or decimal form.\n", buf);
+	else if (result == -ERANGE)
+		printk(KERN_INFO DRV_NAME
+			 ": %s has overflowed.\n", buf);
 	else
-		ipw_debug_level = val;
+		ipw_debug_level = *val;
 
-	return strnlen(buf, count);
+	return count;
 }
 static DRIVER_ATTR_RW(debug_level);
 
@@ -1461,33 +1458,21 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
 {
 	struct ipw_priv *priv = dev_get_drvdata(d);
 	struct net_device *dev = priv->net_dev;
-	char buffer[] = "00000000";
-	unsigned long len =
-	    (sizeof(buffer) - 1) > count ? count : sizeof(buffer) - 1;
-	unsigned long val;
-	char *p = buffer;
 
 	IPW_DEBUG_INFO("enter\n");
 
-	strncpy(buffer, buf, len);
-	buffer[len] = 0;
+	unsigned long *val = NULL;
+	int result = kstrtoul(buf, 0, val);
 
-	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
-		p++;
-		if (p[0] == 'x' || p[0] == 'X')
-			p++;
-		val = simple_strtoul(p, &p, 16);
-	} else
-		val = simple_strtoul(p, &p, 10);
-	if (p == buffer) {
+	if (result == -EINVAL || result == -ERANGE) {
 		IPW_DEBUG_INFO("%s: user supplied invalid value.\n", dev->name);
 	} else {
-		priv->ieee->scan_age = val;
+		priv->ieee->scan_age = *val;
 		IPW_DEBUG_INFO("set scan_age = %u\n", priv->ieee->scan_age);
 	}
 
 	IPW_DEBUG_INFO("exit\n");
-	return len;
+	return count;
 }
 
 static DEVICE_ATTR_RW(scan_age);

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230801-wifi-ipw2x00-refactor-fa6deb6c67ea

Best regards,
--
Justin Stitt <justinstitt@google.com>

