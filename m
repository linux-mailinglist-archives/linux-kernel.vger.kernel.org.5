Return-Path: <linux-kernel+bounces-134132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9252289AE01
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD26E1C213B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96FA935;
	Sun,  7 Apr 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TeDNNbNl"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A06FC3;
	Sun,  7 Apr 2024 02:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712455883; cv=none; b=l8fR3UwkLD94zwZJJ3PcMK+QTQMs0ipMXcbLx7Os0UuENbInDXegTPIeHNmrbVemKxY687VUmihxS0hYoGhsEQI8g2v80REs+DTXlBFd8vT5Ghm4KTkyKVvi6w2oT1iRoEhY0wU+/zOxKVK09396PMsidP6BBwiCzDyPrpVkhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712455883; c=relaxed/simple;
	bh=XztiP7qhsDLFY59o4xv4cTdCfiJGUNSRda6ur/rRzOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqiorBmKZyAvwKrAMI/Bn36an7gYid41wdKki3QaR3jQvAd6KMiWcqyTut7fZuE8b5dgiixi5Kpcg14INjD4ty6C9zy6iIubGRc0VQpCNLb6C8ShPC+TietDhqwtEKosKCalrY+sPYkbocetQym4qDftOYGDWy6CLLEuglkLjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TeDNNbNl; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712455871; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=s2KtBfHHviokBcHSgkOQlh45M49zqLSi4jdgDDhe/O8=;
	b=TeDNNbNl3W29gczN5+sqqhtY9aSz5ypYTUXdRkVVGSruH7ynWXcr1X58o76Bp9+180mg1aozYJvXOQXaKHYI57QE1GcxRoAPLheP/oehpDMD/OlUi6oqINcoG2oZf6ubP7K0ibp4h0Yhu8jVuJtGPYEi79HsaTxU3DL4PYncM7Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W4-m7yc_1712455867;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4-m7yc_1712455867)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 10:11:10 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: djogorchock@gmail.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] HID: nintendo: Remove unused function
Date: Sun,  7 Apr 2024 10:11:00 +0800
Message-Id: <20240407021100.48008-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the hid-nintendo.c file, but not called
elsewhere, so delete the unused function.

drivers/hid/hid-nintendo.c:697:20: warning: unused function 'joycon_device_has_usb'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8704
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/hid/hid-nintendo.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 4b4ca990f968..b4a97803eca3 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -694,15 +694,6 @@ static inline bool joycon_device_is_n64con(struct joycon_ctlr *ctlr)
 	return ctlr->hdev->product == USB_DEVICE_ID_NINTENDO_N64CON;
 }
 
-static inline bool joycon_device_has_usb(struct joycon_ctlr *ctlr)
-{
-	return joycon_device_is_procon(ctlr) ||
-	       joycon_device_is_chrggrip(ctlr) ||
-	       joycon_device_is_snescon(ctlr) ||
-	       joycon_device_is_gencon(ctlr) ||
-	       joycon_device_is_n64con(ctlr);
-}
-
 /*
  * Controller type helpers
  *
-- 
2.20.1.7.g153144c


