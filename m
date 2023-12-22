Return-Path: <linux-kernel+bounces-9870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57281CC96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD71F22830
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8024206;
	Fri, 22 Dec 2023 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVOJVDHk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8198241E9;
	Fri, 22 Dec 2023 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d940d14d69so1475798b3a.1;
        Fri, 22 Dec 2023 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703261607; x=1703866407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=99ULCHmMQPW0CJChnGzwhjBgSh5TwQvmsncOdf4G9Yo=;
        b=aVOJVDHkM2Aj8HOpA329YBBUjQAN2tSLsQ7C26/BbVeqm0IhzlFA1YfB7WsZ5meYCO
         VCaIPvaRwC73UEOsZ4RSt9U//NqhoteblNVLEAXTbPWprMh9USxIWybgPkrXWzQurF3f
         lpri9zokPKgXnasHISvfrClYwEqJuJ+PO9jIfDlKzl6ABhPSzu/sIEmtH0MoyKZkuDW4
         Xtygm8iUYoAmj4SECtYBNWjST60ZbLh/3hQkl4LRs03M0PEqt+1BwYFIwvEn8QU3RxV0
         Y+V+wG5K/tQ9aRUW0CQgUinDk+XWUAi2T+g6nK0Qsi3aMImjQHa7m3G9QKbNWmvNrTJp
         MPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703261607; x=1703866407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99ULCHmMQPW0CJChnGzwhjBgSh5TwQvmsncOdf4G9Yo=;
        b=CImq8TodsOZ/9MFkbv2yNhczhL8bMVLUShlu4izNKH25qcFO8oQLcbZRw5b3B6VQQm
         7GslewgZPo/+ut52rE5Yb2asoy1d3IZciMALqu6v0ITnmGhizftTSvF70IN1rYSV7Ed+
         dxDO+sl5Om85CNQdizxQMV0Wpq0rRnzjvj64oY4IWoujhmTJWZZ3sjtTqlRqZeaTjYhJ
         m75qhhIx3olgbW++f2vOD6uFYts2V1ncDU0ju9RWgrvRL/uKGuBSjOolCMEFldNsTiOh
         u2/i1Oj3ZQ+x56e2vEjPN1LXuO1nA5D8ySXfYm676h4O89emdp0pTAajBFaKWAlWTINE
         ZZqQ==
X-Gm-Message-State: AOJu0Yya4jvPhu1CLhLIgwUFeupGV0TdbHfeGD3FdlRlyAtEVoM2ECuM
	OAqAbNi0FxyTcRqFY+pjfKc=
X-Google-Smtp-Source: AGHT+IGf1WzsGnUTBjMhkiwhnO4g/ZvIzi3vOEBoXqKsjY3F927muD2KAaLHUzw2CzoFiiSViJ8VTA==
X-Received: by 2002:a05:6a00:1b44:b0:6d9:6577:904 with SMTP id o4-20020a056a001b4400b006d965770904mr1147883pfv.41.1703261606852;
        Fri, 22 Dec 2023 08:13:26 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006ce50876c37sm3570561pfb.100.2023.12.22.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:13:26 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set
Date: Sat, 23 Dec 2023 00:13:17 +0800
Message-Id: <20231222161317.6255-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In {conn,adv}_min_interval_set():
    if (val < ... || val > ... || val > hdev->le_{conn,adv}_max_interval)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->le_{conn,adv}_min_interval = val;
    hci_dev_unlock(hdev);

In {conn,adv}_max_interval_set():
    if (val < ... || val > ... || val < hdev->le_{conn,adv}_min_interval)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->le_{conn,adv}_max_interval
    hci_dev_unlock(hdev);

The atomicity violation occurs due to concurrent execution of set_min and
set_max funcs. Consider a scenario where setmin writes a new, valid 'min'
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

Fixes: 3a5c82b78fd2 ("Bluetooth: Move LE debugfs file creation into ...")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* Adjust the format to pass the CI.
---
 net/bluetooth/hci_debugfs.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6b7741f6e95b..6fdda807f2cf 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -849,11 +849,13 @@ DEFINE_SHOW_ATTRIBUTE(long_term_keys);
 static int conn_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -877,11 +879,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(conn_min_interval_fops, conn_min_interval_get,
 static int conn_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -989,11 +993,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
 static int adv_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -1018,10 +1024,12 @@ static int adv_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 
-- 
2.34.1


