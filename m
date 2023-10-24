Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394637D5A88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjJXSai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbjJXSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:30:33 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2398510DA;
        Tue, 24 Oct 2023 11:30:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40859c464daso28641205e9.1;
        Tue, 24 Oct 2023 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698172228; x=1698777028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hF7zP0f/Mn0tTvjiWJ3Eyd/SPL1O3qQ0GEKkSgjjIvs=;
        b=jM1aJrjHae18CHZS4OkNgvx13jIkvDH2gwHlHmA4PDQ43PLLLWWJvqwRSaOCervUD8
         2AcZGKMdLwOzMIWqoQ4NQBAMNkhdSgPG8jQEXqTYLppLfFywQ0jgeyg/WO+KGrL7GcLA
         oGgT1N2aRUzPlvTECu0amEAAR9p8TAqIeG1HOo44C7n9xsiIDVabtZCLNhp7gqCz0dM4
         sIBIqmOJhCWzsHVnewswLNi5MXTm3bmj+RlEGzcAUAXcz0Z+EiU0EVPEGDJQ/A8w7qcU
         DG0QEXYCg5whxu59oE6BSI/OK3u7zp6lyZsLVl4sKJJvI5d2DAa9L4Csj5pUPlvFUBcj
         PhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172228; x=1698777028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hF7zP0f/Mn0tTvjiWJ3Eyd/SPL1O3qQ0GEKkSgjjIvs=;
        b=PXLSX82KJKe6fofPDH1XMb4E/5oWDno6ouvDn/EL6yU5YHQFG84rzAZZlto9MOxnka
         RV13ajLLF3X0kCYhIDbfIsxu71cI3HVHs1ANGgvJAWltkA5EhbpOuViZrovHKz2s5lwi
         4saMb9hKs6Nm3XcoMTLzF2foIES7rztXiYwpaybXm/miJmqvKPfyr5MkbSbn0AGiPUvg
         l4H3M79jwY1ds3IItNqusQgGXXQ52PvoVq/fh71/CplyJMK3u/StHsxdVeST42rchx+t
         Sm5J0ybyxyDrZjzbObLxc62xUzUVP3H9swatnPRDL6mOBdir+gsNcTD/sSjrYh2z/FlK
         Sn6Q==
X-Gm-Message-State: AOJu0YxoUT16z35wRnm57K0lNFeEKao8r9i3HD0ZNS3H6/XbdXc7tAIg
        klgAngz5zcyUDiVuq8C82mY=
X-Google-Smtp-Source: AGHT+IGiSOePp2D5auQEDtZp5YDgtt1FOb+wFT8RexVUX2AkldDLz2PCkqXRAuKj+rHcLVphqXTNGg==
X-Received: by 2002:a05:600c:1e0d:b0:405:3d83:2b76 with SMTP id ay13-20020a05600c1e0d00b004053d832b76mr10368419wmb.13.1698172228334;
        Tue, 24 Oct 2023 11:30:28 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l22-20020a05600c4f1600b003fef5e76f2csm1150398wmq.0.2023.10.24.11.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:30:27 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] PM / devfreq: Convert to use sysfs_emit_at() API
Date:   Tue, 24 Oct 2023 20:30:16 +0200
Message-Id: <20231024183016.14648-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231024183016.14648-1-ansuelsmth@gmail.com>
References: <20231024183016.14648-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/devfreq/devfreq.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 81d9df89dde6..2345c86cf19b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->max_state;
 
 	if (max_state == 0)
-		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
+		return sysfs_emit(buf, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1707,47 +1707,44 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	len += sysfs_emit_at(buf, len, "     From  :   To\n");
+	len += sysfs_emit_at(buf, len, "           :");
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
-				 df->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%10lu",
+				     df->freq_table[i]);
 	}
+
 	if (len >= PAGE_SIZE - 1)
 		return PAGE_SIZE - 1;
-
-	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
+	len += sysfs_emit_at(buf, len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[i] == df->previous_freq)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
+		if (df->freq_table[2] == df->previous_freq)
+			len += sysfs_emit_at(buf, len, "*");
 		else
-			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+			len += sysfs_emit_at(buf, len, " ");
 		if (len >= PAGE_SIZE - 1)
 			break;
-
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
-				 df->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%10lu:", df->freq_table[i]);
 		for (j = 0; j < max_state; j++) {
 			if (len >= PAGE_SIZE - 1)
 				break;
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
-					 df->stats.trans_table[(i * max_state) + j]);
+			len += sysfs_emit_at(buf, len, "%10u",
+				df->stats.trans_table[(i * max_state) + j]);
 		}
 		if (len >= PAGE_SIZE - 1)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
-				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+		len += sysfs_emit_at(buf, len, "%10llu\n", (u64)
+				     jiffies64_to_msecs(df->stats.time_in_state[i]));
 	}
 
 	if (len < PAGE_SIZE - 1)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
-				 df->stats.total_trans);
-
+		len += sysfs_emit_at(buf, len, "Total transition : %u\n",
+				     df->stats.total_trans);
 	if (len >= PAGE_SIZE - 1) {
 		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
 		return -EFBIG;
-- 
2.40.1

