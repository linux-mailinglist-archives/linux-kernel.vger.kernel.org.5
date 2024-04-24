Return-Path: <linux-kernel+bounces-156132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883118AFE54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A911F23544
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B914277;
	Wed, 24 Apr 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cSi2dipu"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C7BE4F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925476; cv=none; b=Pv2HFH2E+NOQChm3+25t+Jq1CsgibZHjDJAQC7hgWq1DxK4sjxPq3L/kpCrAJPet2rnNI9DWI/syV2yBCGjEj5jQNMw1IJ84LxSvyFhoSC6FKlfw1zVZis4MRmqcUNZfhVjuwoq+qS88MEdRwqnOpepLZieiIxwA9cd9bzQZhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925476; c=relaxed/simple;
	bh=stsLE/ioWFHLUMl+EIX2C3BtBelVYljca7jsZ9GceiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBQ2CRtuvo0HZ2YG2jLjW0ftUj7Ekh9GrIfYvuuILm6nU75lM3HsAfblJXLoAoisIJW4fkPUHpyg4CbNg2WRMSTfSJytLGWkqTgVATyviVSQp7WkeSM/yk+EfHQhpbd7kHl0axwkYu8v62XaKPx3jOMfqLvaYSXtQNH3ncRN0CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cSi2dipu; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713925471; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9Xo5LfY4b86VJZShQBakMByowni6YMcaFhpg9b0P14A=;
	b=cSi2dipuB2t8XWc+KpOFInJHwWE4vE5Gb7CygDrvhuhKI/SVbkQoPtVaIDTu81QPrzTS8sPT+BuGx3F2DU8ww17tQ0ALKO9uIU/lFHjfQX7IKeVCwNt85/AAJZdmZo/blkbJTsSCz1dLO0c6hW0BNMZL2oXMB07KJmKPaA0fq5E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W5AZw7N_1713925461;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5AZw7N_1713925461)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:24:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@arm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] coresight: Remove duplicate linux/amba/bus.h header
Date: Wed, 24 Apr 2024 10:24:20 +0800
Message-Id: <20240424022420.58516-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/include/linux/coresight.h: linux/amba/bus.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8869
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 include/linux/coresight.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 653f1712eb77..f09ace92176e 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
-#include <linux/amba/bus.h>
 #include <linux/platform_device.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
-- 
2.20.1.7.g153144c


