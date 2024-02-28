Return-Path: <linux-kernel+bounces-84491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE8786A767
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4901F2306F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A86208A8;
	Wed, 28 Feb 2024 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EmK0YJ6R"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB301CFB9;
	Wed, 28 Feb 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092601; cv=none; b=s64FFohHL487iCkNTuoW3aIiGyHBdGrAUsKToI5hj9Jmar1VJPgHlYg+jfdkGtvhTR0cyztN+0lGsw+kL7emsY+duOHvZ2m+15fuHDD1Ou9J5eakqY6DTq8c1ofje5ntxJugrXwMeOMMxuWqifA9iVqY+TDaVpPRE94nhLsVQz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092601; c=relaxed/simple;
	bh=bj0FcVYHIdjuyNJ2yuc5WuczVrKV4bWGoKvXT/wLmqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EN0Aqs0VdnrhJhuOVe7D44YDBlo6DeNadw0vNkMI8PHINgpBhDs1SKXHRt2W6Tv63zbDa7gXvM5QESxxQnDsHazLGMWwkPp84LQX/pvjhcJTOGe+ichPeqp9QXvO/hFotJdGOLksEKZKqbjeaoS267WTzINpHXk3KJKSGTJM3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EmK0YJ6R; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709092590; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sThGFJm4vZ7TTmVQhzEMYhZBFsbcMEazBfs4I2acUqk=;
	b=EmK0YJ6RS2l2yMzExEPyN8cY8VsS5pA9hqsyTXS5axBQGJFb2Veg7kFISq3u0iH8Q3pMDDhaH4vLlcjx8xAOYckCofV40B9com1/TaLLKvaKHhatfyvEyE2DtJLdoFiYT1LK6IoQc40KpUWy8lDkGubUCf3xe/TvVpD4My3UrHI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1OXFW7_1709092577;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W1OXFW7_1709092577)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 11:56:30 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] xfs: Remove duplicate include
Date: Wed, 28 Feb 2024 11:56:11 +0800
Message-Id: <20240228035612.25396-1-jiapeng.chong@linux.alibaba.com>
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


