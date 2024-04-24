Return-Path: <linux-kernel+bounces-156122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D28AFE31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A239F2824B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B31BF37;
	Wed, 24 Apr 2024 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vLEXkhX2"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF931A716;
	Wed, 24 Apr 2024 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924417; cv=none; b=cUhYINIRDkl7lnSE05ySSUtchpbq4w6ft2FtwECNXyLFcJZ4eVVFmCt/NbzJN0SkJJzi8dAeJ2ZrJYVq1XATWaL0LIA5dsYMsJnkdU7qmw4+gOhb8ugbQMr2ZiNAzPEZ/NwxOfGdHV0MypXAcJ75003pZ3fNmEndFVSdrYUuf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924417; c=relaxed/simple;
	bh=1uIB8Djgu2opDW8zJGbQrnwtQSobfaX9bM0LV2IjT9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b71JmOHK3BIb1zzHebOnDFMu+EJ8oGtKXneJ3Q7xBogsyy379S1jZ9mM6PrJcJxdILcyCpVi0ki17NQ690l7sH4CCZ28bWXHd5fWLlcnwel2D46BZLejHuMK8h46Wej0MOSrlT/PUVS1+P21pjjksMZItwJH/RXBdEnQBaREmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vLEXkhX2; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713924410; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AsvxfKD5Ttu7vZmsRdGtb3GoFi3Ym87cXlOdkwJGalQ=;
	b=vLEXkhX28Kaj2t55RvhqJjZ0lD8mka591ZdZVKxqunDFMz+prFF/SL53hN4mFODf1yvSXAI+fr9vjychOWvhGpuYeQjSUrHciZYkjxuNI9yyOazLTGexj7Q+aDGbCVr8zlJilKzBnPdF5BGxEwhQBInXacwzd6mQRO9hO1Ey2YM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W5Abekw_1713924398;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W5Abekw_1713924398)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 10:06:49 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: chandan.babu@oracle.com
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] xfs: Remove unused function xrep_dir_self_parent
Date: Wed, 24 Apr 2024 10:06:38 +0800
Message-Id: <20240424020638.81487-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function are defined in the dir_repair.c file, but not called
elsewhere, so delete the unused function.

fs/xfs/scrub/dir_repair.c:186:1: warning: unused function 'xrep_dir_self_parent'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8867
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/xfs/scrub/dir_repair.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 38957da26b94..f8450c7f99f4 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -176,27 +176,6 @@ xrep_setup_directory(
 	return 0;
 }
 
-/*
- * If we're the root of a directory tree, we are our own parent.  If we're an
- * unlinked directory, the parent /won't/ have a link to us.  Set the parent
- * directory to the root for both cases.  Returns NULLFSINO if we don't know
- * what to do.
- */
-static inline xfs_ino_t
-xrep_dir_self_parent(
-	struct xrep_dir		*rd)
-{
-	struct xfs_scrub	*sc = rd->sc;
-
-	if (sc->ip->i_ino == sc->mp->m_sb.sb_rootino)
-		return sc->mp->m_sb.sb_rootino;
-
-	if (VFS_I(sc->ip)->i_nlink == 0)
-		return sc->mp->m_sb.sb_rootino;
-
-	return NULLFSINO;
-}
-
 /*
  * Look up the dotdot entry and confirm that it's really the parent.
  * Returns NULLFSINO if we don't know what to do.
-- 
2.20.1.7.g153144c


