Return-Path: <linux-kernel+bounces-40440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3EB83E026
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF53B1F22EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77946200DD;
	Fri, 26 Jan 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBTQ2bGE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUM9LzSF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D81F604;
	Fri, 26 Jan 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290344; cv=none; b=K1PHWTq1ONXHmnoTOL2SSYbWhaAZ9d47Kvg7zGstk1AnI6GJ9o01TbmaNUXoc9NfTT6vb9rE5dVz552YZVrEGM7Dk7XSlafjc04/o4UdZGV3vAkQFi/k1ioRybOHzC1rj6d7Zdnb1hlOWYZhowx3WstvB0hnbESzjxjaOuTjkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290344; c=relaxed/simple;
	bh=QFSl57GoT1mnNeJ/HMxVSCJPvVRimquz48qqqG2TeqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cjz0iGc/WxVPdsJbD66KlsLl2WMDALcmOAwT/S4xBb0pyzcV77BUdTdZRu52gP5maR5x9j35SVkTZcYbnH9EnRWZpFGgSDWiNXi8/uU8CyRHPdevljrs2cimbRYhnzcbQ4RGsyIViOjIscu25Kq34/ah7NjQ8Ayyqa6IoyPSW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBTQ2bGE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUM9LzSF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 17:32:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706290341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QejlsgoBDr6NwQEmZk8veFSYKUKfp91Ic69JmCreQ2w=;
	b=BBTQ2bGEWvP9n0T31XVoV/OEvBAO/PcGAKJ5KrtD7r6sI2pkQnBQOr9vmmFndKTwCuefAF
	iWGUgEDHVHJM1SoqtEPjhTBtpiozOZ58D9u1TJBNs0y+AmTA8Yqk+34qcIg1jPOsk9rsU/
	O5I19D47QJz5VpZHdacm98wUEJSYefniEVspVmn5438g4AwPqeaFdetxnfIOolP9HQODcb
	saYDTssjxezrK3f+/cY9xf1wUr9uQLzsapPI3lXQpfrJY8XEOllCZjqtA86Wx78+bQdQxz
	B+76u5o1SurdxL10yaTkciN7dWih33Xo1W62w1lAVZKVIfoYFhXhsLMZho9+0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706290341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QejlsgoBDr6NwQEmZk8veFSYKUKfp91Ic69JmCreQ2w=;
	b=aUM9LzSFzs/BlA8FSZkGEtDPIyDtCQd6xipZJj0bxOvGK29m9rWnqrgMM11LYoUrQ7jcMh
	ZPRwwAerHaaZU8CA==
From: "tip-bot2 for Li Zhijian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] kernel/cpu: Convert snprintf() to sysfs_emit()
Cc: Li Zhijian <lizhijian@fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240116045151.3940401-40-lizhijian@fujitsu.com>
References: <20240116045151.3940401-40-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170629034015.398.17590522685927916785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     effe6d278e06f85289b6ada0402a6d16ebc149a5
Gitweb:        https://git.kernel.org/tip/effe6d278e06f85289b6ada0402a6d16ebc149a5
Author:        Li Zhijian <lizhijian@fujitsu.com>
AuthorDate:    Tue, 16 Jan 2024 12:51:51 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 18:25:16 +01:00

kernel/cpu: Convert snprintf() to sysfs_emit()

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

No functional change intended.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240116045151.3940401-40-lizhijian@fujitsu.com

---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f059375..ad7d0b0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3004,7 +3004,7 @@ static ssize_t control_show(struct device *dev,
 		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
 #endif
 
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
+	return sysfs_emit(buf, "%s\n", state);
 }
 
 static ssize_t control_store(struct device *dev, struct device_attribute *attr,
@@ -3017,7 +3017,7 @@ static DEVICE_ATTR_RW(control);
 static ssize_t active_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
+	return sysfs_emit(buf, "%d\n", sched_smt_active());
 }
 static DEVICE_ATTR_RO(active);
 

