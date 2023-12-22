Return-Path: <linux-kernel+bounces-9629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B47081C8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B934928A092
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F61642B;
	Fri, 22 Dec 2023 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLd86w9h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4875DF42;
	Fri, 22 Dec 2023 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d427518d52so1262685ad.0;
        Fri, 22 Dec 2023 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703243048; x=1703847848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccwKVzWPangyqXrlucZn9H9/x6STLFmmKbiFlyVdJGs=;
        b=ZLd86w9hCqxRTlT8aKrVQSN7jssjxmDlyYysTWgu/65tHZURyJCFSKh2iLjDUVq5uW
         68Jyco1wwvTxbVvz7k0SfMRs+aTjPxGUIaylZKsCBvSS/COwOWpQOHJc/NxwZrVYKI+H
         JNsqdsxitawQrdrZQtge8UW5Tr3P2TFNadSHU+A0qeD4jEPY6K5mCKXbaNxvV6fU9dsH
         ZZI/2uxMLYw8YbmYR7RiOVVvBlm6CJGwQVTUGGZX2n+rm1JIYBuv9XFscLJp/WZqI+g6
         WGyHtFAFJIN7KVJkVCXdJq5pmqo1oYDu9Z64N2vzMMqEfKWRLZPCixVK2M+vUTZnDp3K
         5MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243048; x=1703847848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccwKVzWPangyqXrlucZn9H9/x6STLFmmKbiFlyVdJGs=;
        b=BokwkiMi817uTbZeMFJbUvn3GQPQ8jZrsLM6Qhdz+9I/izKFl76Wq4fPDh7j2LLdyO
         JExhC8G+9Tv7PFK1yCSse6Gho1xvGREGFJAgDzchgkGVMM8UHSIn8HM4GRE1ZS41x7mC
         H8A2OGhxgenh8AI2ReZq+wItgG7B+ZMJV1UllnCd/VACJzu7W9SkisPos1GCYQwe77uk
         /HivkVFM2g0voh9MxYrl/N9doVoUV3cZZy+bY/IqyC5+NALeOmYOwB6onqyjoKAd3UeP
         gkdb8VNzJOlf2KxTxvd/+ZUPQpEAWMmxc47ld8esRbU/npjh0BpSSIQSAZVX5j3WjKJr
         CBFw==
X-Gm-Message-State: AOJu0Ywj2kjpiXBlUF9VqalgD6CzivHxQeMB/+ff4pX310OHGm85v6SU
	Z/y3Lwy+9Bp3h5zlzSwKrBs=
X-Google-Smtp-Source: AGHT+IH0QZ9c+a8el4NSx+nwOrLhNLgEABgRjYUvxscb3xEa88e+Dung4gsE9CtAvyyU3mXQWWfm8g==
X-Received: by 2002:a17:903:2344:b0:1d4:8a6:831f with SMTP id c4-20020a170903234400b001d408a6831fmr2961028plh.6.1703243048181;
        Fri, 22 Dec 2023 03:04:08 -0800 (PST)
Received: from g2039B650.. ([2001:da8:203:a502:3221:f470:cca0:93b2])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d3ff083d58sm3187596plb.254.2023.12.22.03.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:04:07 -0800 (PST)
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
Subject: [PATCH] Bluetooth: Fix atomicity violation in conn_info_{min,max}_age_set
Date: Fri, 22 Dec 2023 19:04:01 +0800
Message-Id: <20231222110401.9322-1-2045gemini@gmail.com>
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

Fixes: 40ce72b1951c5 ("Bluetooth: Move common debugfs file creation ...")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
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


