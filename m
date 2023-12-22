Return-Path: <linux-kernel+bounces-9621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E2581C895
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E0287612
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376BB15AE4;
	Fri, 22 Dec 2023 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2vcC4p0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38A14A86;
	Fri, 22 Dec 2023 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3eabe9321so11837855ad.2;
        Fri, 22 Dec 2023 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703242537; x=1703847337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCFzo++LI2ZwW1picHi8lLKPMVx69Hfp8vT3r27uSLU=;
        b=Z2vcC4p0iN9YhUXwmEOEAXciYXu5OxPmfonMorliOWZ3iuOQHmeNEU74leuVez+rXD
         qcNSw4R91D9ym1stU3WviPRnKP5Cs77uwA1PegNEClFYCcYArBr97iwDxX8dPK66OVoz
         JYjiwnSbFZjUWwksoWT5m1MWXUsoGL8V/idH6945Ei7CgdvgcVZ6Tt+uTviy2SFu4Dog
         JtquLv3hI1oyx1CAIhx+q0wr72K2WLJV9SolJDWaF8qd9m72qZnCYUl05dphTDz/agax
         uwr214CyT62+sai7mcSnG9VymAtNmGzZoD9WEN7iwrB/fQT6WEnAUygWhAqDWs1kcbZ9
         QsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703242537; x=1703847337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCFzo++LI2ZwW1picHi8lLKPMVx69Hfp8vT3r27uSLU=;
        b=wowr/ieKlQfPL8950avRtW6q8qxnERS3QnVDxPQ6KNpQ2hpqT3fmCQSxbjrUYb/Yjr
         PKRTF4HVz+kZ/T19PGxOlZ0v/7op71zisv2gR6l8BCfKH7EKMjyJdEBAj70iUFz/wNp7
         79djITocSyFBqMNBxItZgiBOvSLB2aU8IIuWY3vcDQnjv968RsgzeqUpdde77qJ/EuXn
         /Ls2pVHRcmS8m5OMmQoiYTet8WRFKddf2I12xKK2A5FMLZK3lVrFNIBsvWMZmBAGkf1y
         GaNDaSQEa2ASAQTk/2Ztfuzv7UHNmtsvC7RnHdXIzwUtf6lAQeJ2aPn5ZPGOArsRQO05
         e7XQ==
X-Gm-Message-State: AOJu0YzOGdDtLkgT+YEH14J5o2ZkpDfNKDzwoFA3yOBYAcSn8kwL0uwo
	qC/LCkDtVmp6nBYzOJpXF74=
X-Google-Smtp-Source: AGHT+IHe/yw5h2GBRC0KOMQhoptWluh7P/8lB+AswpdPVFaFzGQTpTtUHnCgGULxsphbiJG7LbPimg==
X-Received: by 2002:a17:902:680a:b0:1d4:19c8:582b with SMTP id h10-20020a170902680a00b001d419c8582bmr722741plk.121.1703242537386;
        Fri, 22 Dec 2023 02:55:37 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001d3ef9edfa7sm3188497plb.58.2023.12.22.02.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:55:36 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org,
	BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] Bluetooth: Fix atomicity violation in {conn,adv}_{min,max}_interval_set
Date: Fri, 22 Dec 2023 18:55:26 +0800
Message-Id: <20231222105526.9208-1-2045gemini@gmail.com>
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
set_max funcs which may lead to inconsistent reads and writes of the min
value and the max value. The checks for value validity are ineffective as
the min/max values could change immediately after being checked, raising
the risk of the min value being greater than the max value and causing
invalid settings.

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

Fixes: 3a5c82b78fd28 ("Bluetooth: Move LE debugfs file creation into ...")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
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


