Return-Path: <linux-kernel+bounces-163308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B198B6933
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF7428284A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29A11185;
	Tue, 30 Apr 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IcbDiX5r"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B6DDA6;
	Tue, 30 Apr 2024 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448869; cv=none; b=UoXOVPDp6qymc7Y4I3paZO+a2fyGSfXC88ObSZ93VMvvO4MEtRDpaQoUTGvXBS3BNtXlvZ1xv8tmo36dVCTqJ/11t5enIjNEQX7H2ECAtucRNONKiXoIiw9+SzvBEP4KDVGQg+X5ZpPa6VXZY7lwKlUBqmOqzO72wFqBNxEsVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448869; c=relaxed/simple;
	bh=jUs9XgpaOa7DxLf3I0tsnTGWIU0jUYW5+Lq9rL+rIVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=knMznN7S4y07fEaSlQRYRdeChHKh6pzc0V6iwrrZT/9v+7NVV94HLaHYKH1KCP/EC2ocXBcd16zhHXRVEFlFTxOQ+++cR3ERpNI17PFXty9X7IJ/pz8xzRr/C7dW4UEz8izz9zLSr1DQc7sZjtnIotMHsM7D3/Qcjl6jEDodNis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IcbDiX5r; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714448863; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/CsF+Y2IP+3jZ5bkwA2pggt8f+Xx33IGI6tV8P3LBv8=;
	b=IcbDiX5r/pAZCCT8flZ4BGElBcp1P2NEmX+6VBEVn6Xg/TEHLJKig38iqDn8wcB2falxxOl13o7OXoYwOAP6jMEJ53ttOwReUMNOWRr5tftBP5MofB5cNsomEaJlTyxysMCZYFDJXjpNM/DTcLdrDR99h1XUA0Jv+XXp7sEseU4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5b.701_1714448859;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5b.701_1714448859)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 11:47:42 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 2/2] xfs: Remove duplicate xfs_da_btree.h header
Date: Tue, 30 Apr 2024 11:47:28 +0800
Message-Id: <20240430034728.86811-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240430034728.86811-1-jiapeng.chong@linux.alibaba.com>
References: <20240430034728.86811-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/fs/xfs/xfs_handle.c: xfs_da_btree.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8930
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/xfs_handle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index c8785ed59543..234b2c965fb6 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -21,7 +21,6 @@
 #include "xfs_attr.h"
 #include "xfs_ioctl.h"
 #include "xfs_parent.h"
-#include "xfs_da_btree.h"
 #include "xfs_handle.h"
 #include "xfs_health.h"
 #include "xfs_icache.h"
-- 
2.20.1.7.g153144c


