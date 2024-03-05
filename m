Return-Path: <linux-kernel+bounces-91565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756098713B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D1FB22305
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326729422;
	Tue,  5 Mar 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ccFlRb4n"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581126AF3;
	Tue,  5 Mar 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606431; cv=none; b=fbVwWCa13Uz7orxE5R8BsNj0+tiA6U3QxuVwlcCUzhQz8WnaOZcfC6DMKJI6aluCnZcUdcfml/32mCiwAO+zzvnwQ5xNGgckAXpAe1cEn0Hzf5CXWVqTNk41IRpEyemTu03YFuwOU6bs4EUJmgb3PMIAVwuHq+64kG0PXHMzncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606431; c=relaxed/simple;
	bh=bj0FcVYHIdjuyNJ2yuc5WuczVrKV4bWGoKvXT/wLmqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WGfl6dBPKq06H68taGK8XKhRIwt707/swsYWh11WMdcpVoOM64R4N3fQ2hLtJyDEx7R6oh7jGaac5DZLRksFQJE2tnjuvND4PLEAQjjzs9AFg/wVNM4ouumyHVJyPt6J0tYQrJcwDSydsDQFgJeg0VbbFoQqxpYXQYSnSEqyppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ccFlRb4n; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709606420; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sThGFJm4vZ7TTmVQhzEMYhZBFsbcMEazBfs4I2acUqk=;
	b=ccFlRb4n/GOUHo8pXKF1YKN3fE8piHk1DMhQNmPA56BnWEsYOSZeNQG3kjkx6abituptBVoobFyJ3XqXcJA76YMQYU7pdUSHX/cdRFVyyaYYGPBAl4au4uFgA+s2GYWBNxqnVaY6HgPuN2fZbRNHlAzpgerIOubfIDVYAdTLSyU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1scfX-_1709606410;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1scfX-_1709606410)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 10:40:20 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2 1/2] xfs: Remove duplicate include
Date: Tue,  5 Mar 2024 10:40:08 +0800
Message-Id: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/fs/xfs/xfs_qm_bhv.c: xfs_mount.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8386
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/xfs_qm_bhv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
index 271c1021c733..a11436579877 100644
--- a/fs/xfs/xfs_qm_bhv.c
+++ b/fs/xfs/xfs_qm_bhv.c
@@ -11,7 +11,6 @@
 #include "xfs_trans_resv.h"
 #include "xfs_mount.h"
 #include "xfs_quota.h"
-#include "xfs_mount.h"
 #include "xfs_inode.h"
 #include "xfs_trans.h"
 #include "xfs_qm.h"
-- 
2.20.1.7.g153144c


