Return-Path: <linux-kernel+bounces-9625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88C781C8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6746E1F21DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F41156F7;
	Fri, 22 Dec 2023 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPtrCmhq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B617730;
	Fri, 22 Dec 2023 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b86f3cdca0so1250200b6e.3;
        Fri, 22 Dec 2023 02:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703242760; x=1703847560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpmaJRutT2X0CphAnurM2d5NRf7Tv9tPXlI+dm5PHac=;
        b=kPtrCmhqWU0+2AS4xPlKkAbKa3z/3Wg4+O3bUCOfgNk54/kojbu2AXWv/D83cTPD7z
         N0VadvkOcvTdaEgxQO1fdInDZMdslC1ZAk+2WJGYLfxHtWcoqlyn6PrVLu7q7Tvqfo6n
         TUib9eZecCdWW++JK2bPN2PqDlVM4NYMRqyOjD3nUQnxgWLMrFu3pgaA83GZSRjlmfIf
         CjbiFrXxaOtpsMRzbx+winJi9yYg5B4OBjRQrH12z38/MK+N0cobFiBh5xyF8UkzcWhD
         7ihYkTMlMhyyaA/Bjwl5rVoiQ0tp/SYo5Aw0bPg7tEYams/ozIIeNRg55GEwnxmv8KIV
         DjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703242760; x=1703847560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpmaJRutT2X0CphAnurM2d5NRf7Tv9tPXlI+dm5PHac=;
        b=sFof91GwyRBxHNoLy/IiQMpRkVZogcbgIdSNsBiYU6Nr5DtjnvOfpHuAyKNWCBN+uf
         wjXOGHSSdYq0Yx63tJzcK0RvHddr1eL/nLZTuNGFoKUo8NTNmNUvqW7Wu7iwYvDOoZZS
         EXx/RI/Alk45FlUoRDaUq4Z9LGGbSQMLXLuEH4HmUpJgKyTstCI5hhSZCwY+Xkf2zNHi
         6oPdOq/6QSVIpMjEY2YiQCHnlJMp3xXbfsbv4TLFdw6k+T1U45/DhGhTCv99SARdwYRK
         q2i/tgThDZjfPEm7NN76svu9U5oDbEAcMFlchCOD6KbWBnLKJmvUbwPzKNtwtsSK4D6K
         /rZg==
X-Gm-Message-State: AOJu0YyT0KVj/sATDLDCr+8O1BN4+HPLK0MfLHnNShH5PVCxIMILa8r1
	WE2DWQk7n0qSMY6hj0kKYGI=
X-Google-Smtp-Source: AGHT+IGmoLx1hmp5eCag91kzrpqnxuTSLmQwlz6Yx32yVP+m8Rti93EKdN+VQU8F7fZhMUk6fdd7Kg==
X-Received: by 2002:a05:6808:20a0:b0:3b8:b063:8243 with SMTP id s32-20020a05680820a000b003b8b0638243mr1368877oiw.69.1703242760003;
        Fri, 22 Dec 2023 02:59:20 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id x27-20020a056a000bdb00b006d9926b93dasm317437pfu.17.2023.12.22.02.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:59:19 -0800 (PST)
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
Subject: [PATCH] Bluetooth: Fix atomicity violation in {min,max}_key_size_set
Date: Fri, 22 Dec 2023 18:58:13 +0800
Message-Id: <20231222105813.9245-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In min_key_size_set():
	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)
		return -EINVAL;
	hci_dev_lock(hdev);
	hdev->le_min_key_size = val;
	hci_dev_unlock(hdev);

In max_key_size_set():
	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)
		return -EINVAL;
	hci_dev_lock(hdev);
	hdev->le_max_key_size = val;
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

Fixes: 18f81241b74fb ("Bluetooth: Move {min,max}_key_size debugfs ...")
Cc: stable@vger.kernel.org
Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
 net/bluetooth/hci_debugfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 6b7741f6e95b..3ffbf3f25363 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -1045,11 +1045,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
 static int min_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE)
+	
+	hci_dev_lock(hdev);
+	if (val > hdev->le_max_key_size || val < SMP_MIN_ENC_KEY_SIZE) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_min_key_size = val;
 	hci_dev_unlock(hdev);
 
@@ -1073,11 +1075,13 @@ DEFINE_DEBUGFS_ATTRIBUTE(min_key_size_fops, min_key_size_get,
 static int max_key_size_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
-
-	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size)
+	
+	hci_dev_lock(hdev);
+	if (val > SMP_MAX_ENC_KEY_SIZE || val < hdev->le_min_key_size) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_max_key_size = val;
 	hci_dev_unlock(hdev);
 
-- 
2.34.1


