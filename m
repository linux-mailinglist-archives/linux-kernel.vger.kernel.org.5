Return-Path: <linux-kernel+bounces-91564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF28713B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D063B21B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B869F28DCF;
	Tue,  5 Mar 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ieC8Ipyd"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180724B52;
	Tue,  5 Mar 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606430; cv=none; b=rQrMaJUnDQzOQy32dvAVGfT6nT53+jL6GisK/WCH0zkQXwlpMufrGfyQv5ob/CnpwLdnFQfMjMXDG87nuIrXsfBM/PkVfn0RYqAXE5dQ/z3rB3Copcjbt49qRRJ8V+gI7TMdO2jBCRk4CMsQCxX37Cra/7AMnHvCldsCsbfI2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606430; c=relaxed/simple;
	bh=fRWHMTQjwFJaqzyN0S174X822Byn+QS1kRwDKkogl1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oS/k8VE0VEy+IwKjK0dJxnpz2ju0e4HM2jJ9eLzlYHc9qjLKFJoSr38Zg6063GlwpPljIEBsjFFo4a4oxlKLz1kwPHdK++HMiL8FStP6PACXiWzabZkkfei/AakO86XSK2ru3bcHpew36skdCA3bD6x4fBItnZ4O+ZoegIocCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ieC8Ipyd; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709606424; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rK3JGV3L6aU8lG9JCL3Cyx+JMEoubCfoyYpxxgs2Cls=;
	b=ieC8IpydKMEnqe3+xcGDvVlwSzxB9uPphkh87/YaN21QNgINViD4OEG8HQQTsScUlUxgKHxrJQ0at7RP905TL+eLcHgt7dIc5LE1h18hsdjHWea38w62nusx8ldSrwb1PUfdG7rty4p1s3aWTfQzwSJFmkhj6s+d7C5NP9/tfC8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1sbyKp_1709606421;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1sbyKp_1709606421)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 10:40:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2 2/2] xfs: Remove duplicate include
Date: Tue,  5 Mar 2024 10:40:09 +0800
Message-Id: <20240305024009.52931-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>
References: <20240305024009.52931-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/fs/xfs/xfs_trace.c: xfs_bmap.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8385
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Remove the second #include.

 fs/xfs/xfs_trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index 1a963382e5e9..3f253884fe5b 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -38,7 +38,6 @@
 #include "xfs_iomap.h"
 #include "xfs_buf_mem.h"
 #include "xfs_btree_mem.h"
-#include "xfs_bmap.h"
 
 /*
  * We include this last to have the helpers above available for the trace
-- 
2.20.1.7.g153144c


