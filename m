Return-Path: <linux-kernel+bounces-134133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7AF89AE0E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D641C21435
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DBF184D;
	Sun,  7 Apr 2024 02:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LrRHmrMR"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA83B3D8E;
	Sun,  7 Apr 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712456898; cv=none; b=KUQnHOhtbFDStSbcNvp7X0B4XsXK1iZ/SwxldGBe1hYGZK2InF+rvK+jGvwKfVn5+F2BOEaW8K8zc0y5nXzBfGr52FHN8hpr3e3bA38ZhuAzAN0ceJnbDR1STCzxXKXjOFj8C9gUxPDFDfw8Fo/O4BSn3L+Oazt0WMT/BfFMeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712456898; c=relaxed/simple;
	bh=5f0Zjyug+xD4ykOosxZAXg2bxN/+a/AUaQR9YyxDaqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fRWGe5zZrfrQhokOT4WMGBuQTvU6nwhWK5L5BuhO0eRpVkLVq5ak7T4m7/0rw46ZJj12MCC9nBTwiYeV1rLf+7wAm9colrfQhyn0c1f5cL/ZUTGsGlTttsblAFtRnvV2ZZlp3hrSaYFGH8F3jSdOZcyd9gNhMw5iNCL8c8TpPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LrRHmrMR; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712456893; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y/enGtSxuq6kBPcEkUjW0NrmRUA2NEWBWYihlUsxgpM=;
	b=LrRHmrMRyyuxZLEqR1GXlJerspPaUf6BKjIFrvhgFJlowrKX37ct9ojbRK5i1kpKMiV8ynnc6ROMKz7Hy8gYgxJYWqRMaGxjUeIhD1xkHyZbWXHl4txYrjWA+4osUTZTHulGluruOT1tkT2tEpoQi6mHJdcvvlmylW/feH2a0zM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4-lTpa_1712456885;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4-lTpa_1712456885)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 10:28:13 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] HID: Remove the unused variable minor
Date: Sun,  7 Apr 2024 10:28:04 +0800
Message-Id: <20240407022804.27081-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable minor is not effectively used, so delete it.

drivers/hid/hid-winwing.c:123:15: warning: variable 'minor' set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8705
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/hid-winwing.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index d895c82a541d..0e224d1a6466 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -120,7 +120,6 @@ static int winwing_init_led(struct hid_device *hdev,
 static int winwing_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
-	unsigned int minor;
 	int ret;
 
 	ret = hid_parse(hdev);
@@ -135,8 +134,6 @@ static int winwing_probe(struct hid_device *hdev,
 		return ret;
 	}
 
-	minor = ((struct hidraw *) hdev->hidraw)->minor;
-
 	return 0;
 }
 
-- 
2.20.1.7.g153144c


