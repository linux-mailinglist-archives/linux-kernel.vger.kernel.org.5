Return-Path: <linux-kernel+bounces-54610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001C84B17B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31711C227F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC8F12D769;
	Tue,  6 Feb 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DN2sTFai"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDD12D146;
	Tue,  6 Feb 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212350; cv=none; b=GEyYyGXZIxVvEfRk5Gwt5HQC0GU2nJ/PkeUy7Ve8p2lkdMuATfbcSSB1OUB8dMi+vrLBwU6p+SBYNVcLjMVfltCgT8R+YaF9ToGGwjnGHxCj2bSATpM+KgEy+ZqyuzV3L6/+yNsdjmi5J/6mvBgdCmOBUfwgvyg4VBjcYHxbkVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212350; c=relaxed/simple;
	bh=vOlUYbXqj6PLt5HGut6v/zsqfogoygFiPio5B13aQPs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TYZS54Tu6AazjrMGp3nWyz/YnMz2CpoxJNRA0aoPHMvbEo+RB6awSx3NJn0ZrE6ljM/v4l8aw76TQhQd8PaGgwnspxHoH9uGB/YuUbGxB/deoNWThIo/NVR6uEEEpWWpVRz21uOc/qROG4P7YlvrgbSXp31O0SGA4QD3csX04iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DN2sTFai; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707212339; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=toWhO0GkKnpG8md0AYP6xrKSj5a2GVH2yOYl3wdcLGw=;
	b=DN2sTFaiG9lQwH7ajrsAtjnKt/z2IeXvS7Gyr5QSesfzlC4FHvbZY6zkcnkEU1sVoD3skhr0NIG8dL3ZK4GyiBO/FAx4q4/JpBTStF5Te3V5cYQML3rxEmBDCTQtWbTEPiptqJnD9+K8rboiFbKRAkENFtgGWdHtQHBDm7M6Z+8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W0D7L1b_1707212338;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W0D7L1b_1707212338)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 17:38:58 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] watchdog: Add kernel-doc for wdt_set_timeout()
Date: Tue,  6 Feb 2024 17:38:57 +0800
Message-Id: <20240206093857.62444-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wdt_set_timeout function lacked a complete kernel-doc
description. This patch adds missing parameter and return
value descriptions in accordance with kernel-doc standards.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/watchdog/it87_wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 9297a5891912..3e8c15138edd 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -213,12 +213,16 @@ static int wdt_stop(struct watchdog_device *wdd)
 
 /**
  *	wdt_set_timeout - set a new timeout value with watchdog ioctl
+ *	@wdd: pointer to the watchdog_device structure
  *	@t: timeout value in seconds
  *
  *	The hardware device has a 8 or 16 bit watchdog timer (depends on
  *	chip version) that can be configured to count seconds or minutes.
  *
  *	Used within WDIOC_SETTIMEOUT watchdog device ioctl.
+ *
+ *	Return: 0 if the timeout was set successfully, or a negative error code on
+ *	failure.
  */
 
 static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
-- 
2.20.1.7.g153144c


