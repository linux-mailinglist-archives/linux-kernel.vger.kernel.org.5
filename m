Return-Path: <linux-kernel+bounces-9902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0581CD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2548B1C21BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1028E32;
	Fri, 22 Dec 2023 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj2yIKSs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CF41AA3;
	Fri, 22 Dec 2023 16:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3eabe9321so13961115ad.2;
        Fri, 22 Dec 2023 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703262209; x=1703867009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6rOctl0yz+TrOI/he0cOkWKN+3TOYc+MuASu10g+3c=;
        b=Zj2yIKSsgBxrrMjQJOph/BbSbZnZB9WUtvhYkl0/++Fs0Y/mgA4Bi5Wcl39hH8bVO+
         T4PDrwGeZv6KzMflf7rbRj7ckBp/CJcS8EBno90nhBYel7PQGvvwm2YWtLq52r+KWC/X
         gh1ydartl43IwlYf1RrspJ467DeF/oo/JVA+EociWJiavrJFJZ7KVXK9O64lAMAxu0f/
         VlNL9Af3v/7fdtQGuOlsGEt08tGsWV72tBgeAETXKmvS+KRJ5SHteKBaUVq0a0jGJCV1
         n60Bl8x/dUxuwyZRpmAvF+aAhTeNU0R5Yh+YBO7yPUPuf/R0ozZ46WpEfGyfIwTwTJ6p
         WODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703262209; x=1703867009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6rOctl0yz+TrOI/he0cOkWKN+3TOYc+MuASu10g+3c=;
        b=u1MjEOpq1I47W7Kx0p6gFJ8D9kvhvBATJl0rpDImwOLyMzv9IvG9qm+jC2ujfcESOj
         gXgXja3HBL3+/tsfPwNy5Kw+/006Oyq6DArXhsMM8AYvHpandamczVXKWGlXAsF3ZWO1
         +toH6Qo03qQSEb1xsjIjg842ItqZN04leHl5rgCDNUcaS6y/5TBFcfdoZ8muzCjCbN5j
         gbe2Vb095n7yT3rJlHzM0Pf+I8XTxNHCvc8tAk5/f4O8U1bDJZ/9aGPG/BaEnaT3cfKq
         zcpWXr9T0zTBljM8mswaRiw2NUTEYjKmK6WLIVYxg9n9GAUgHvyUYVqCf5Qr52w6lced
         ROHA==
X-Gm-Message-State: AOJu0YwxhL3oejdsyyz2ZnonPClq61ktGurAi/BkExqCa3x4s58PdXrD
	rHhKwZbNKGdv5dd3LCv3oOI=
X-Google-Smtp-Source: AGHT+IFJeShx7ay4cJiYK/PnE9DgKekhrDyZ0yeKWvlTdXkdQtnmmHPu291CJWQEqC0OgEf2ZXcnjw==
X-Received: by 2002:a17:903:2601:b0:1cf:5760:43f9 with SMTP id jd1-20020a170903260100b001cf576043f9mr1316332plb.64.1703262209526;
        Fri, 22 Dec 2023 08:23:29 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001d096757ac1sm3609327plo.47.2023.12.22.08.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:23:29 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set
Date: Sat, 23 Dec 2023 00:23:10 +0800
Message-Id: <20231222162310.6461-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In conn_info_min_age_set():
    if (val == 0 || val > hdev->conn_info_max_age)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->conn_info_min_age = val;
    hci_dev_unlock(hdev);

In conn_info_max_age_set():
    if (val == 0 || val < hdev->conn_info_min_age)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->conn_info_max_age = val;
    hci_dev_unlock(hdev);

The atomicity violation occurs due to concurrent execution of set_min and
set_max funcs.Consider a scenario where setmin writes a new, valid 'min'
value, and concurrently, setmax writes a value that is greater than the
old 'min' but smaller than the new 'min'. In this case, setmax might check
against the old 'min' value (before acquiring the lock) but write its
value after the 'min' has been updated by setmin. This leads to a
situation where the 'max' value ends up being smaller than the 'min'
value, which is an inconsistency.

This possible bug is found by an experimental static analysis tool
developed by our team, BassCheck[1]. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations. The above
possible bug is reported when our tool analyzes the source code of
Linux 5.17.

To resolve this issue, it is suggested to encompass the validity checks
within the locked sections in both set_min and set_max funcs. The
modification ensures that the validation of 'val' against the
current min/max values is atomic, thus maintaining the integrity of the
settings. With this patch applied, our tool no longer reports the bug,
with the kernel configuration allyesconfig for x86_64. Due to the lack of
associated hardware, we cannot test the patch in runtime testing, and just
verify it according to the code logic.

[1] https://sites.google.com/view/basscheck/

Fixes: 40ce72b1951c ("Bluetooth: Move common debugfs file creation ...")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* Adjust the format to pass the CI.
---
 net/bluetooth/hci_debugfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6b7741f6e95b..d4ce2769c939 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -217,11 +217,13 @@ DEFINE_SHOW_ATTRIBUTE(remote_oob);
 static int conn_info_min_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val > hdev->conn_info_max_age)
+
+	hci_dev_lock(hdev);
+	if (val == 0 || val > hdev->conn_info_max_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -245,11 +247,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_info_min_age_fops, conn_info_min_age_get,
 static int conn_info_max_age_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val < hdev->conn_info_min_age)
+
+	hci_dev_lock(hdev);
+	if (val == 0 || val < hdev->conn_info_min_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
-- 
2.34.1


