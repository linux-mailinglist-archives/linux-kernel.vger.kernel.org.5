Return-Path: <linux-kernel+bounces-136689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE389D723
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E489B2298C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3C81725;
	Tue,  9 Apr 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfy/ZUS4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="13rwBrAo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5474297;
	Tue,  9 Apr 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659166; cv=none; b=Dad9Rz3K8jKblkDPJBM5h8BPOhP/2/Gvm6vEfPZs1CTdICKuLfHWtIgVWwYeLe+EkTM4mS3CP+IKWFX7AIcQpxdndjlkhKy/NtYN6u8oJ7M5mfJHlKLGDdE3fiWfExHVavo39SpSGIi8MY/Vi5dvIxx0b/AG2qPPEOzTduIxmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659166; c=relaxed/simple;
	bh=Oue1vvv3t8RNqqfsd9+m1SGcPcqXAB7/Ojb26cFRGYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CCiUmmOY263d6DCcpKpFFnqp9aOvWdyAIoxikaPOYi0+lDARg8TeSRQ6lOSdS5W0yPIJyM+vEI8fne6BwEBfPE8egrc+VTYR0LdwQ65x8+j88vnETP/yV+yOFadoRAWDWEUlqvJ74Dtcie14NJPD2GqOTbq+jDZVr0bC/pV31Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfy/ZUS4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=13rwBrAo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 10:39:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712659163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tS+WETtfbo/F4LumeHfjtrvS/k4/oo81bxw/y11U9NM=;
	b=sfy/ZUS4Qjk6KQpGywwyj07UrDCAGpV8c40ga8EKVP6d9YmDgwq5W458GGYR05rYNjUGQF
	Bw0yQXA9HgevEdgD4pxSj30PCUQ14oLrMkUZWkecp3vFckpxDa90mMB+voOmHhMv5ZUgfs
	YYjxFOSJt2WcPUNzwUkFJjpsYHAS1XZN28BwYEdeHf3WIe9UoiToXEY8kKj8RDAa3Mgydz
	VEPlRI23JGPOk+oYuEu38VBzNRDK37SzAnkpDHp8JUF+Bae7FR/ai2iqZV2IsZqTqd9lpt
	u/TemgzKrKISlZcR4wzZ0tRUmIv5BtpL88ESEL6u00wf+axvp986MocbeSUGEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712659163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tS+WETtfbo/F4LumeHfjtrvS/k4/oo81bxw/y11U9NM=;
	b=13rwBrAovbSPrKVF16TQOUDa0lgsFyvoYBl5lCCqTFGCR49GX5AoRvj1QIfOkt8hJNDaCt
	+xxhQQK9K+uQaZCQ==
From: "tip-bot2 for Li Zhijian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Convert s[n]printf() to sysfs_emit()
Cc: Li Zhijian <lizhijian@fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240314100402.1326582-1-lizhijian@fujitsu.com>
References: <20240314100402.1326582-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265916214.10875.3347725424369083508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8f0acb7f3a1331559e325566c00c26d1523dfe06
Gitweb:        https://git.kernel.org/tip/8f0acb7f3a1331559e325566c00c26d1523dfe06
Author:        Li Zhijian <lizhijian@fujitsu.com>
AuthorDate:    Thu, 14 Mar 2024 18:04:01 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Apr 2024 12:32:37 +02:00

clocksource: Convert s[n]printf() to sysfs_emit()

Per filesystems/sysfs.rst, show() should only use sysfs_emit() or
sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240314100402.1326582-1-lizhijian@fujitsu.com
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4d50d53..d25ba49 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1334,7 +1334,7 @@ static ssize_t current_clocksource_show(struct device *dev,
 	ssize_t count = 0;
 
 	mutex_lock(&clocksource_mutex);
-	count = snprintf(buf, PAGE_SIZE, "%s\n", curr_clocksource->name);
+	count = sysfs_emit(buf, "%s\n", curr_clocksource->name);
 	mutex_unlock(&clocksource_mutex);
 
 	return count;

