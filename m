Return-Path: <linux-kernel+bounces-17270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B111E824AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120B2B227AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1972C851;
	Thu,  4 Jan 2024 22:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy1rGAQ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF32C84F;
	Thu,  4 Jan 2024 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so850654f8f.2;
        Thu, 04 Jan 2024 14:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704405826; x=1705010626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXXy4XaMx73PQXHAjdjEv87MNa8ZHKFz0AC7Uv3YPaw=;
        b=Oy1rGAQ9x5vGN+PTD56sTjjKl5Qtaphvt2i6xQ+KZybN59gs+P8g+ph9qClImdqTWU
         N9mljp8oeXG2I9DN9lsmgJ8oRx7AnP7dl0OAfqRupOcEFRjp2Vsc5Bb///fz4Uu5ePsY
         pLZKhrS/fcKFPIO8XOK85m+EB6u8DT3Z/x4uHSFxEPh8MA4V81Xgs7YITxwbyjL4ah1i
         qYf8XFyKwKibTfVurlGuJiAiddz10HRz6IaXiz5C5uRGQUE0EgUaWoFDT8dBnyzdWNAp
         Yk2CtEtcy0EIbjlg2bt6OvNZmXn9gNB+XwU8XT3TTq/IGKtJdIpS58XN/8MxP+s9UxLM
         XpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405826; x=1705010626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXXy4XaMx73PQXHAjdjEv87MNa8ZHKFz0AC7Uv3YPaw=;
        b=JXKadd+tDWaBCHs+9foIhIQ7y227Xu2yz5GZw+vg35g11pZMOBPZvx6tiNyGLDUSMk
         QQf+AiVwtLEk9QeXzg4bLvV8uqaerVisk2Xl6CGPhDFfl1Z4jwfrF4oLp30wh2PpZcUX
         RNG8poBehpe3VF2rMwfXTS2IyuXg6pHIygvZvKDu5L9EH/mMOoTzEQn6ZX8wB/SY5sFG
         qS6f98olB61peZ/QlbSYJUYFJah3x6mk6xWEFC3yeDb0vjYDFwGtPA7Wy0q2IL1Hkwc7
         997g3QMiLzzDDZ22M6vV2gfAXdGkwH+mGdA+7GKcf6yKeyVa5MHqRvMoLs6NYJoJ7bhJ
         SGeg==
X-Gm-Message-State: AOJu0Yzo4pfKh70OIuyaUqykyH3NlfXVBNCu+1+/hcFxeVa6P+7qeDcm
	XLYHoiHetJVtJLYDS6crCak=
X-Google-Smtp-Source: AGHT+IHMnzEpSv8bC0DE1jfrn88WRg6WsYB4GValqBRgP/QIHGUfEF/vjn8EDZt4b1kOhthNJNcZ9g==
X-Received: by 2002:a5d:6b12:0:b0:336:62f7:720f with SMTP id v18-20020a5d6b12000000b0033662f7720fmr299156wrw.160.1704405825822;
        Thu, 04 Jan 2024 14:03:45 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.pool80116.interbusiness.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id e18-20020adfe7d2000000b003367a5b6b69sm164286wrn.106.2024.01.04.14.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:03:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [RESEND PATCH 1/2] PM / devfreq: Fix buffer overflow in trans_stat_show
Date: Thu,  4 Jan 2024 22:55:14 +0100
Message-ID: <20240104215521.10772-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix buffer overflow in trans_stat_show().

Convert simple snprintf to the more secure scnprintf with size of
PAGE_SIZE.

Add condition checking if we are exceeding PAGE_SIZE and exit early from
loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
stats is disabled.

Return -EFBIG in the case where we don't have enough space to write the
full transition table.

Also document in the ABI that this function can return -EFBIG error.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq |  3 +
 drivers/devfreq/devfreq.c                     | 57 +++++++++++++------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 5e6b74f30406..1e7e0bb4c14e 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -52,6 +52,9 @@ Description:
 
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
+		If the transition table is bigger than PAGE_SIZE, reading
+		this will return an -EFBIG error.
+
 What:		/sys/class/devfreq/.../available_frequencies
 Date:		October 2012
 Contact:	Nishanth Menon <nm@ti.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 63347a5ae599..8459512d9b07 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1688,7 +1688,7 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	ssize_t len;
+	ssize_t len = 0;
 	int i, j;
 	unsigned int max_state;
 
@@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->max_state;
 
 	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
+		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1707,31 +1707,52 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				df->freq_table[i]);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
+				 df->freq_table[i]);
+	}
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (df->freq_table[i] == df->previous_freq)
-			len += sprintf(buf + len, "*");
+			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
 		else
-			len += sprintf(buf + len, " ");
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+		if (len >= PAGE_SIZE - 1)
+			break;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
+				 df->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
+					 df->stats.trans_table[(i * max_state) + j]);
+		}
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
+				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
 
-		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
-				df->stats.trans_table[(i * max_state) + j]);
+	if (len < PAGE_SIZE - 1)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
+				 df->stats.total_trans);
 
-		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	if (len >= PAGE_SIZE - 1) {
+		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
 	}
 
-	len += sprintf(buf + len, "Total transition : %u\n",
-					df->stats.total_trans);
 	return len;
 }
 
-- 
2.43.0


