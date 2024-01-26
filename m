Return-Path: <linux-kernel+bounces-39467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8183D1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6364928FD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661F10FF;
	Fri, 26 Jan 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iaI9Cwd3"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B9D38C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229899; cv=none; b=c0tUakhLdkjtxGYplWeWKIANM6g4B8jKGJ80y128YtBupLXZVZCCGu1/VHmh6d+UKeZwV+4GTUcj8SVX8mRA/FX/hfNjs8kVBKsUjBUBoiyJ+9fJmrK9dCLq67+562CrdK+6Qk38m1wSpi847ZJRtvI3sURHF/PkLm8PKwrEJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229899; c=relaxed/simple;
	bh=smv9ZgAMHVcJCdSo6yEoIvqCUvZ86MybPCC8WR+Hbcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFrlr5mcrQ9t+6Zs5wygeiyIXHxH2ZPcVJ75oWgoo2lSIGOIDQW48tqrZzY14lUVGaQz7uOrSLjZJj8fwfUEAHstCJGWD84ZWQyg6hl624uXyIJhXukiulFiNfj567pI1wSd45t0Qj1q7JiN7bd4J1PWYAGLdWzCaGVEVc0l6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iaI9Cwd3; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706229892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+N/pFFnbRnIeU4+MPRCb+blT+dqZFUYtBiOeotMx7lQ=;
	b=iaI9Cwd3xFxBh4/P4UYF6r9R1w6swqJYPrNurRPwe4JzW8qdBEQ2nak8HMru0uiyhqzG6dQeFj20Fy4kK917brPNeCXcn9eyPCMa25LYyfDUw2wDtiNTwDIeMtoTPy/HL1VjEG37Djoy8bmvLuvEPGC4g8wlcKFzUUf7tSNQCj0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.Ld43r_1706229891;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.Ld43r_1706229891)
          by smtp.aliyun-inc.com;
          Fri, 26 Jan 2024 08:44:52 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] kexec: Remove duplicated include in crash_reserve.c
Date: Fri, 26 Jan 2024 08:44:49 +0800
Message-Id: <20240126004449.118407-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files kexec.h is included twice in crash_reserve.c,
so one inclusion can be removed.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index bbb6c3cb00e4..db8bdf47a2c0 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.20.1.7.g153144c


