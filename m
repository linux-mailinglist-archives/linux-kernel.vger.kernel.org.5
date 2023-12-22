Return-Path: <linux-kernel+bounces-9833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6476181CC07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029771F284C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989928DD3;
	Fri, 22 Dec 2023 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+92oErG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC828DBE;
	Fri, 22 Dec 2023 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28c1e079b20so151984a91.1;
        Fri, 22 Dec 2023 07:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257971; x=1703862771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mG5yQh5BmZ/+SdEVtHHTaLKN3jITKnFSk1eVPrGgKM0=;
        b=i+92oErG7BUf8YyMKD2pcuF4HgC/A1uevv2lIInkJySYQzbom0tr1lFXHzJWkVnpuP
         wb5YKZb5+yCYrGHUCJ4NN2j+r/1xUEH9YFu5nPdCRlVadeFX0e+FK+xXQnIlwLYHa8y+
         px+iMM6H2bF+Bjar0ega0n3MZBpi4ByXuuG5d8ypXzhAzZfxCKAP4kK6pi613H48ZGQu
         fiYUTkPnqp6u9vX/7gXrBC5A2XzbytwehTbt672inygHtlLkSUVdLG9r8Fezr5n60nK/
         +z4EXPpndQO5bOAGaOsIlaAf5d2N8HBfaMANLY3t8uyXsa5ho23V2tNTkwMcNEM+3BGx
         AcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257971; x=1703862771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mG5yQh5BmZ/+SdEVtHHTaLKN3jITKnFSk1eVPrGgKM0=;
        b=k4fbyWreSAn/Oz+FSsrTuru/O+fBaWwpFNhfg9bSJnnbx3z+lYTDZe9udp11KAF5QT
         k+lQXMPp9drOAO8VDjOnZYgI8zt+321g+zse/Nb2xFYkWqCH++ILkQl2+q43wh/PkZP7
         8wSKUAIYVxJqB9XtYbZ4+xjpdkszYB2+bMmqT92DtRpk8zrABokyBx/cWIEgcZQgW4y/
         jCOVvXc3T3ovAG98V4cuhxsUhITYGmaN1TRKeGTGwO/Rk16hpRxkgTlUOGqb0ala8vd+
         b/ATdQ2NdLSEHX4Vu0Lrsm6Lgt9CJkw/D+HTRHyNWMyen72lUOWAWOwl+7JVTwiy0fth
         N70Q==
X-Gm-Message-State: AOJu0YwAIRLt9SgVHUCh2dOZAaC0j/6Sg+74ja5vs9lLwhvn3OSDt9X0
	VJSLSFI+3Zc8Cd8t+8mpLBE=
X-Google-Smtp-Source: AGHT+IEn6GnyGhoNKzdzJqZBh3Pzoaoc5HSi7iJzx80sJF+LA+cDrpsnrGtG92Oxvse40S35Oow6gw==
X-Received: by 2002:a17:90a:2dcf:b0:28c:4a7:b0da with SMTP id q15-20020a17090a2dcf00b0028c04a7b0damr846479pjm.86.1703257971300;
        Fri, 22 Dec 2023 07:12:51 -0800 (PST)
Received: from g2039B650.. ([106.39.42.144])
        by smtp.gmail.com with ESMTPSA id go18-20020a17090b03d200b0028c1807cbf0sm889333pjb.54.2023.12.22.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:51 -0800 (PST)
From: Gui-Dong Han <2045gemini@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com,
	Gui-Dong Han <2045gemini@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix atomicity violation in {min,max}_key_size_set
Date: Fri, 22 Dec 2023 23:12:41 +0800
Message-Id: <20231222151241.4331-1-2045gemini@gmail.com>
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

Fixes: 18f81241b74f ("Bluetooth: Move {min,max}_key_size debugfs ...")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
---
v2:
* Adjust the format to pass the CI.
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


