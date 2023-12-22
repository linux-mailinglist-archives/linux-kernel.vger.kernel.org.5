Return-Path: <linux-kernel+bounces-9905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE66481CD18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A7E1F21FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C728DDF;
	Fri, 22 Dec 2023 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfyo3f+T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAA28DC3;
	Fri, 22 Dec 2023 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d2f1cecf89so12070505ad.1;
        Fri, 22 Dec 2023 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703262587; x=1703867387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RbqJTx4YutVd115r4RHwitlguWbX65XpAS/E08N+Xtc=;
        b=gfyo3f+TNSLHlenMq712cOlXJKJpESQt9gCAit67X7I7FgCPGWwTPv3+vb0wv+frY+
         WLTZJ/4S9T/rt8+760INWX8gFVlin4xOZgKmL9BVROrzlzQU7dv31pRISEIUFoBJhkjb
         /wRKe7wEU6YEBUUiKpaBOnPxLGUfNhV9eC/XrcBKUqpn2+EHWlwAD3PvgV+jmICMGlrG
         XG/ItAMIW3VPtGNhu9xHd+tZcp1lrkrSCpfB/wR830QuUDiXqJCRjAg5sjsMI6ZxgQLl
         bbCNQVhkN89j60Jsa6OpFs+I+kMH4YBg+s05USgVibtZaDVANYM4Cm+J419afmmMoIYI
         SSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703262587; x=1703867387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbqJTx4YutVd115r4RHwitlguWbX65XpAS/E08N+Xtc=;
        b=cRwgoKcWHkj+Xlixtg/JkHJn55LDFUVPqdDF6KzHUx98vaJWyX28rqbc2Heps8cgLW
         C76TD4bZGLcVShR6A5bEMN1Iq580//8kc/N3mbnZu1LlcFjWc1iyvIMxYJDLtIpJvHLk
         gfDO8Ot445C9SVp86AEH7yFlmJ+hARIN9KVx9sGL7QvhGU6fIL5LeNqW6rfcfxTvegtP
         g7DXtL7oDusVQgiagwE9KcYT5WTd93cKFI2B0SNqotKLe2aAZImnTQ60VAJcc00/IRap
         VVDuQEMYq52wfgubBcIbCl2W7mekvG/y9/WTWgf/9UpxgZWT4CQt8KwJzMKdAQnhAmSr
         /QXw==
X-Gm-Message-State: AOJu0YxjBigq6YVYuZ1CxLWiQ2ZViF2H5qBoQapUp6M2iNZmXZp+stxy
	Rw5Jt88eLWtn2ixd+t7bkVA6qWR8BI+7X3hQ
X-Google-Smtp-Source: AGHT+IEu/UhjtH1FjQjtz59VUgRFFDMHCN1iOv7t9JbmakJH3DMDzc0tE+RqMvbwRUgIMCgwDdS81g==
X-Received: by 2002:a17:902:eb8b:b0:1d3:2a94:cb33 with SMTP id q11-20020a170902eb8b00b001d32a94cb33mr1122049plg.8.1703262587285;
        Fri, 22 Dec 2023 08:29:47 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id iz11-20020a170902ef8b00b001d076c2e336sm3649546plb.100.2023.12.22.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 08:29:46 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix atomicity violation in sniff_{min,max}_interval_set
Date: Sat, 23 Dec 2023 00:29:31 +0800
Message-Id: <20231222162931.6553-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sniff_min_interval_set():
    if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->sniff_min_interval = val;
    hci_dev_unlock(hdev);

In sniff_max_interval_set():
    if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
        return -EINVAL;
    hci_dev_lock(hdev);
    hdev->sniff_max_interval = val;
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

Fixes: 71c3b60ec6d2 ("Bluetooth: Move BR/EDR debugfs file creation ...")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* Adjust the format to pass the CI.
---
 net/bluetooth/hci_debugfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6b7741f6e95b..f032fdf8f481 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -566,11 +566,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(idle_timeout_fops, idle_timeout_get,
 static int sniff_min_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -594,11 +596,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(sniff_min_interval_fops, sniff_min_interval_get,
 static int sniff_max_interval_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
-- 
2.34.1


