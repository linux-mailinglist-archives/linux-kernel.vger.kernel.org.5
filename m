Return-Path: <linux-kernel+bounces-163309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA798B6935
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6FCB20E68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE51429A;
	Tue, 30 Apr 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RGcuuWzG"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153F10965;
	Tue, 30 Apr 2024 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448871; cv=none; b=gfs124IZjfY1n6M/5BVAB1m+ook9ERE2WZRoYFIkpbxVWsYPSTA8mnlueExrYXNJgfohgPZQ7NT7iirT6ZYREVgjjOgle3dHKrGUte1cdTN4JMxehCecwBwipz9zQeCdo+SiNVKht26xwvVs5iSvvrneCtEXSxZ/KWhe3V48EOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448871; c=relaxed/simple;
	bh=Mo0Pfq0A8u0WgoYsEWiaKzNz4YXl0RQNy5c1b2zgnWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VpDhs0qPxRv9YmsJmqEoxU3o7a/JRK7446BIWqf6vNziEufihge09ArpceRqkYQoa8qXq1PmZdRJ/VEGy2V8eYHY8xo686dL52eCqHM2PcA7ynpjE2m+LBT92INU8uGe97GwVSfiEJv+X0SxBUhfLuSwiKRfanpBDOIQ+TOC1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RGcuuWzG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714448859; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6EoYFnnrRx9Ut/tDax0nPzU21beFw383jDxbtRqkCXk=;
	b=RGcuuWzGo/a0jmR1dp9SALfywD/ZlehIMBZ9dBDN5DcSRyHikbjGRO0uDFIzDux5sIUr7HEXz1m2/Ga7pFH6jdKSlE0AuiMZRWO04N9y24vDqTUhiOLSReQrPhn0oLI3AkYfQSSg/gkTCdnPy42j1D5yWM/XvUpqZfoXF92PqHY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5ayAjS_1714448850;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5ayAjS_1714448850)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 11:47:39 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] xfs: Remove duplicate xfs_da_format.h header
Date: Tue, 30 Apr 2024 11:47:27 +0800
Message-Id: <20240430034728.86811-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/fs/xfs/libxfs/xfs_trans_resv.c: xfs_da_format.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8931
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 6dbe6e7251e7..3dc8f785bf29 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,7 +22,6 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
-#include "xfs_da_format.h"
 
 #define _ALLOC	true
 #define _FREE	false
-- 
2.20.1.7.g153144c


