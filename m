Return-Path: <linux-kernel+bounces-80394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87A8667BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4BE1C2083E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED54EAC2;
	Mon, 26 Feb 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cxm1fqLW"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2BD53C;
	Mon, 26 Feb 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913392; cv=none; b=I8fpm8nG/+7gAdedlKYyNFqpjMbnl2N34bm1Vc1Jm5Lks20KUYXyR5ij5Yh/opXvfMFD98wVZ6k4LZ54E1n/FnWpO6FJ/dXTtTUWVJtkcPzHHzZnCK4Ix5vxLatUKvfV6syYdl6p+YT8GsQpe6aOPLYiv5/ztuMNHjQNfUXfvxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913392; c=relaxed/simple;
	bh=lvgBpJeiNO4JZFhHCp3nkqQsW03Xio7lH2pdcYGihLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ry+aUhI534S8uIbVFkFyRC240j5NlJWhkn1t/Wh6aUyQswrH3hW8y4cJz5Oa68qDbimoqRo2/E5x0nrbNJE/iE0VIF0h7Ida8Epk+6CuvvfxS73ZQcSOQ80d+vUM74a1lj0/DHS7oVX2YpyqvlPqN5T5ZAYsqVrwWmtw/z2nOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cxm1fqLW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708913381; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4QkB4mdIbmJS3piWDwWiFV9dkhjomMatkolXiaczfHs=;
	b=cxm1fqLWfOS32CvZ34dbomdZ/sanxtDLcyuFXRWtOGX+FRYo+S0Yj+juPPp+ujC6UjFS8GqK3+O2jHrxgTm3Npgj1tOedbZQDa1kV4XpJjxnJPW6m75LxN86tCOnQdzTHhom0wlD+vpa1FYLYFyfQ+yiGsTEevJamLMll0WHFuM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1A3lZ5_1708913368;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1A3lZ5_1708913368)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 10:09:40 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: fancer.lancer@gmail.com
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] bus: bt1-apb: Remove duplicate include
Date: Mon, 26 Feb 2024 10:09:27 +0800
Message-Id: <20240226020927.111091-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/bus/bt1-apb.c: linux/clk.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8312
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index e97c1d1c7578..595fb22b73e0 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
-- 
2.20.1.7.g153144c


