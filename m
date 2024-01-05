Return-Path: <linux-kernel+bounces-17941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CCB825575
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E4A284B26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B22E407;
	Fri,  5 Jan 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnpWzyDl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F32E629;
	Fri,  5 Jan 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso15458815e9.2;
        Fri, 05 Jan 2024 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704465409; x=1705070209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqHAz2Xd1ngk6xpnbEUa/1afBSe7yN4Mad/JN4+bPaM=;
        b=QnpWzyDlUsRmVq78hKp2poG7vYaN8LAYEtHcGpeY1NgGsuo+zUGq08BYoALvLe0ufz
         TaT353YRdvqksSDQfoIC28UMPRv/Yl82s5oX08ndJhC4K8l3PouIFx6pnIYzdV7yEnbE
         +Wznb/jnyTv4Bea2MYA5EUqJF1acsFXz/5NqB4AmeLO7xQyILITW5CpBckYMQiz5G+7k
         mimKB2TneLcv3E1i7bkffmZiPwdQC54VdZZmA489RD43RUuNMcrfgmz8tswCWDRK26fP
         9pZYwrWpFWVQ4n95xpjKULF7NHlNTlDXwLwbZxlKCirBdFObeHRzpEvgS5ibGO/1DXRR
         Y8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704465409; x=1705070209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqHAz2Xd1ngk6xpnbEUa/1afBSe7yN4Mad/JN4+bPaM=;
        b=Y1nn0ZJCiZWqVU1AbWVGXmvuaonH4a9+nICGjDSoIq3/zJ74zW7MKCAsFkly8sWe0I
         tIEjy0JGkZ3ndimB/5mGfLzQv4tud6JarNXwSw4DMmGdjFrGCYbEKfGqOpgzS3eLlMpP
         1XAsv4GMQ+/Mp4AHb7hpANaDLma43wlvlkkq4IxqODcRFrnoAgJcL4aFaENu4+ETJ8X8
         piT0TBqv8fBoTJbu7NGn5BQmM5xwWS3WrOau/cgco9Z8CP98C+umegcO7BJaIIIvIpZ/
         QjzVYKyOvCshAh0HOHKETC6APfCbGecH0slZMIHTg2dh18Rmq7NRkZFdLmPqeqceQLTB
         vLxQ==
X-Gm-Message-State: AOJu0Yw0BpKSrcGZmVI3NZ8IbtG71XSveCVkySiSIVsXFdBDaR/xjNPZ
	F1ni0wxh2tvNq1+G2cwU9wpmulpWCiY=
X-Google-Smtp-Source: AGHT+IGtYm+CC1Qfcz8Yi5UqbCz4ZDJpp31y2l7p+kHmorxqfPDRZGIPBCQB53rw+oO0swheZhN+Kw==
X-Received: by 2002:a05:600c:524f:b0:40e:35d8:5fe2 with SMTP id fc15-20020a05600c524f00b0040e35d85fe2mr865045wmb.158.1704465409111;
        Fri, 05 Jan 2024 06:36:49 -0800 (PST)
Received: from localhost.localdomain (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.googlemail.com with ESMTPSA id fm26-20020a05600c0c1a00b0040d5e53d7c3sm1800809wmb.23.2024.01.05.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:36:48 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: Fix buffer overflow in trans_stat_show
Date: Fri,  5 Jan 2024 15:35:59 +0100
Message-ID: <20240105143600.12811-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix buffer overflow in trans_stat_show().

Convert simple snprintf to the more secure sysfs_emit.

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
Changes v2:
- Squash and use directly sysfs_emit
- Fix typo for df->freq_table[2]
- Reduce check of PAGE_SIZE to only at the start of for loops

 Documentation/ABI/testing/sysfs-class-devfreq |  3 ++
 drivers/devfreq/devfreq.c                     | 47 ++++++++++++-------
 2 files changed, 33 insertions(+), 17 deletions(-)

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
index 63347a5ae599..3b8019ab523d 100644
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
+		return sysfs_emit(buf, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1707,31 +1707,44 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				df->freq_table[i]);
+	len += sysfs_emit_at(buf, len, "     From  :   To\n");
+	len += sysfs_emit_at(buf, len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += sysfs_emit_at(buf, len, "%10lu",
+				     df->freq_table[i]);
+	}
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += sysfs_emit_at(buf, len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (df->freq_table[i] == df->previous_freq)
-			len += sprintf(buf + len, "*");
+			len += sysfs_emit_at(buf, len, "*");
 		else
-			len += sprintf(buf + len, " ");
+			len += sysfs_emit_at(buf, len, " ");
 
-		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
+		len += sysfs_emit_at(buf, len, "%10lu:", df->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += sysfs_emit_at(buf, len, "%10u",
 				df->stats.trans_table[(i * max_state) + j]);
+		}
+
+		len += sysfs_emit_at(buf, len, "%10llu\n", (u64)
+				     jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
 
-		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	len += sysfs_emit_at(buf, len, "Total transition : %u\n",
+			     df->stats.total_trans);
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


