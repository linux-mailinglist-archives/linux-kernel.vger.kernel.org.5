Return-Path: <linux-kernel+bounces-148045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8A8A7D04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF94A1C20D38
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718C69E0C;
	Wed, 17 Apr 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H7HkIH1g"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13D6A346
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338638; cv=none; b=cHPmcMuOZ38M9FGg4K/GNwouU8mSsE6Nsk0ZG6/Qadxg+GimlXqJRiDMB/aawlqUqU10yaPqmWYUiIbBlgPtWdjS+S92CpkSoDDRc5PxSY8F3sh69NqGHynGmaPkrYkzQZIczD4vAqsphkmltiRyXXlCIFKTps1H1KhSWd8oW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338638; c=relaxed/simple;
	bh=WtxoiuJV3m6GyJpzAN6XL5BPcbwUDVyIU91NC8DMQLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXcqfBxuHIf9o0xVE1FD8n/fcVfBBvX25o+jPv7KUXVShuoV4I5YWSTJ2ePQj2fqTpyOi34F549PnqapvvYcz1pRdqmS1FnF6HO7PCIBshqqZJhMs8YC7lQicgyU5KCEl3498b3rtHNCq9cKDr5i2yz1NlQYm0GKkLF5kEXBmX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H7HkIH1g; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713338632; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=j2jYpWryi+GGWqXApoA91DWagz9UYmW+FLd2EdL1TPY=;
	b=H7HkIH1gZWo9jNDdcwzYBLvGB5zM3V205IZcyhDxLylbnAabdRPQp34ot5j/XyI0ucLfTEaE3p6w9A/MMlEd4nk2vyM4IDVkCuRMSUTvfP+d5wn0k26Ne7O/N+FmNcx2RG3272RT5lqw70DJDQamJ/52SYu6wQwalUiNI1g+v3Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W4ke0di_1713338624;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W4ke0di_1713338624)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 15:23:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] hrtimer: Remove unused function hrtimer_hres_active
Date: Wed, 17 Apr 2024 15:23:42 +0800
Message-Id: <20240417072342.113756-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the hrtimer.c file, but not called
elsewhere, so delete the unused function.

kernel/time/hrtimer.c:653:19: warning: unused function 'hrtimer_hres_active'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8778
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/time/hrtimer.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index cae9d04b5584..bdaf23356d4b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -650,11 +650,6 @@ static inline int __hrtimer_hres_active(struct hrtimer_cpu_base *cpu_base)
 		cpu_base->hres_active : 0;
 }
 
-static inline int hrtimer_hres_active(void)
-{
-	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
-}
-
 static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
 				struct hrtimer *next_timer,
 				ktime_t expires_next)
-- 
2.20.1.7.g153144c


