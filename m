Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B49F76C224
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHBBXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHBBXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:23:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571326AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:23:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d05883d850fso7108466276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690939395; x=1691544195;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIHsj8XoFwDRolbPTByFLPNXyk7/+zhE5+wWIRLN6Lo=;
        b=H8Pz5e5cFzI5oJDwICKHGMhU3aoVAHffL5w/OGlv2mumGY89AiC3+vmNrVqUq3XE5c
         L415CZHlkHw7U28EfSPVE0GU5nr5YQUHuk6BfAzGOqb1Qpt3wLiBmHLFJSF6eVsCLUGZ
         yGGIsanfQZ7oOO5/ZhxjJ1C5VzOjwZYQ1K2h4hg81Sh5b5xThd+JkjqBd5/NegQXnhDj
         Q5kwiptlnJIB4VTHnUdUj3jWvT2ADKLlOeIRKqLB2VGFoXRNj/63Lm/wQXBY8jOE6FSC
         psZdL9fdN9/RJGn1NyQgBfYcc2N/Ii50oEiZEDzyMFiTe30gDNPemGNUX2YKFmjawmS2
         wV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690939395; x=1691544195;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIHsj8XoFwDRolbPTByFLPNXyk7/+zhE5+wWIRLN6Lo=;
        b=XePOGL4GyY/DT7Fmg0+hMmqReWA/07FRyrRUAvgWJbt5usPTdiBz1P/caFbqCgn3fm
         nLqqKVZz5h3IrbWbJa/3OGd+zEMObcRALBo+9dc+MRk7CUEOmgrr+UKmh5YzRfGz8jq2
         gd9J8XSEAnera/2aSCcga+vbkP5CgMzhm4nSQ0xKa1cgFirEDPhkdDeCI5tXimV8fjdW
         Mh1yzuJ10QrPt2ATW1k0lQBTD6htqxUPbIae47Dyyl7+JRDNauoeoZNQKZIk2/EMifQ2
         YO85ACIYr7MmSG5787spPBxxTAQw45RtZzYJhiwt1+WZfQXTxX5ru4SBLDHmY2a8jMH8
         Ue9Q==
X-Gm-Message-State: ABy/qLbRwHXJICscoOh6vJFMa3a2YDsbv6s4oLjDE1GFTbSMzK0NFOLP
        vz1hpNXJlviRjNZ7YysXOTzzTC20oMHsWJczqw==
X-Google-Smtp-Source: APBJJlHqErLc5z0h9PfqAfzH+l9ess1fhoZJ1yPU4u1hILNke890O9MuppqvSUColB9rOySqe3Zw2wssDNMI9xc0gA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:69c7:0:b0:d07:f1ed:521a with SMTP
 id e190-20020a2569c7000000b00d07f1ed521amr92177ybc.4.1690939395731; Tue, 01
 Aug 2023 18:23:15 -0700 (PDT)
Date:   Wed, 02 Aug 2023 01:23:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPmvyWQC/42NywqDMBBFf0Wy7pQkxvhY9T+KizSOOtAaSYpax
 H9vFArdFLo8M/fcu7KAnjCwKlmZx4kCuSGCPCXM9mboEKiJzCSXKS+4gJlaAhpnuXAOHltjn85
 Da3SDN211joZFd4wfWo7eax25pxBjr2NmEvv10yh/NE4CBKRZZrXIC1WK8tI5193xbN1jX/hH1 1zlOiuV4I361utt294UggXs+gAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690939394; l=3748;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=g2L2WspPFLuzcaRk8qw4bGi3vzHIuHbW4yJAfdaLlnE=; b=YpPx3Ks0t64Zm8TmW6fpMsm4qnMsOvKhw3BlkoNW6xRuXjFDrgFrSv9CHD7qQ+tzcr9huNHcv
 GGaE44SBO6gAfGWrwh59cbIOX0pcCGhrZpxCqWTOho9JYDlX3POIRpy
X-Mailer: b4 0.12.3
Message-ID: <20230802-wifi-ipw2x00-refactor-v2-1-d33f765e9cd5@google.com>
Subject: [PATCH v2] wifi: ipw2x00: refactor to use kstrtoul
From:   Justin Stitt <justinstitt@google.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v2:
- Create unsigned long and pass reference to kstrtoul (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230802-wifi-ipw2x00-refactor-v1-1-6047659410d4@google.com
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 39 +++++++++-------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index dfe0f74369e6..820100cac491 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -1176,23 +1176,20 @@ static ssize_t debug_level_show(struct device_driver *d, char *buf)
 static ssize_t debug_level_store(struct device_driver *d, const char *buf,
 				 size_t count)
 {
-	char *p = (char *)buf;
-	u32 val;
+	unsigned long val;
 
-	if (p[1] == 'x' || p[1] == 'X' || p[0] == 'x' || p[0] == 'X') {
-		p++;
-		if (p[0] == 'x' || p[0] == 'X')
-			p++;
-		val = simple_strtoul(p, &p, 16);
-	} else
-		val = simple_strtoul(p, &p, 10);
-	if (p == buf)
+	int result = kstrtoul(buf, 0, &val);
+
+	if (result == -EINVAL)
 		printk(KERN_INFO DRV_NAME
 		       ": %s is not in hex or decimal form.\n", buf);
+	else if (result == -ERANGE)
+		printk(KERN_INFO DRV_NAME
+			 ": %s has overflowed.\n", buf);
 	else
 		ipw_debug_level = val;
 
-	return strnlen(buf, count);
+	return count;
 }
 static DRIVER_ATTR_RW(debug_level);
 
@@ -1461,25 +1458,13 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
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
+	unsigned long val;
+	int result = kstrtoul(buf, 0, &val);
 
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
 		priv->ieee->scan_age = val;
@@ -1487,7 +1472,7 @@ static ssize_t scan_age_store(struct device *d, struct device_attribute *attr,
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

