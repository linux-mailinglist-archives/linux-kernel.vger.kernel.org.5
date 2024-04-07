Return-Path: <linux-kernel+bounces-134301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9914F89B012
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C181C20EDB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36214295;
	Sun,  7 Apr 2024 09:27:53 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCC12E48
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482072; cv=none; b=hqI+yvFLWNPrHgumc7O9DcaCp6GqyKNp/GqekfhcAWtv5IioBQcLNrfwc5y0JHzizwlyGR1A6RjW1UaudrFtyFgEyR3JuSn9DBJChTL5QxCZAuxIomoUWNuhhxErrRZuxROxYoPtsE1kkdXMQyW+SaKbBBJAIbcopGBjO/5lzHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482072; c=relaxed/simple;
	bh=XH4IO8ROXZSJkIGQB+J4bURjmXRrKSfRRiZvs3sJwvU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6iwR1Cq76mCNvVHIthpm4DKy0NdnxHPpGPiUZ0TBOVMNfFx6qbMH1RGGiO9eODCetVdqIG5Z9LOoGxbrcj+r7je81IuI5zKHghKcxThv4eSN+CvLV/tnCya3vjNsWI5LtVkYTbPBOvEkpNXgsNSUZYqvktZc+06MwVifY3B0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4379QxkF089922;
	Sun, 7 Apr 2024 17:26:59 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VC6J70vMVz2K5rcL;
	Sun,  7 Apr 2024 17:24:55 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sun, 7 Apr 2024 17:26:32 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: fix some ambiguous comments
Date: Sun, 7 Apr 2024 17:26:23 +0800
Message-ID: <1712481983-7721-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4379QxkF089922

Some comments are confused and just correct with block size is 4KB.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 include/linux/f2fs_fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index a357287..4a56d18 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -424,8 +424,8 @@ struct f2fs_sit_block {
 /*
  * For segment summary
  *
- * One summary block contains exactly 512 summary entries, which represents
- * exactly one segment by default. Not allow to change the basic units.
+ * One summary block with 4KB size contains exactly 512 summary entries, which
+ * represents exactly one segment with 2MB size. Not allow to change the basic units.
  *
  * NOTE: For initializing fields, you must use set_summary
  *
@@ -556,6 +556,7 @@ struct f2fs_summary_block {
 
 /*
  * space utilization of regular dentry and inline dentry (w/o extra reservation)
+ * when block size is 4KB.
  *		regular dentry		inline dentry (def)	inline dentry (min)
  * bitmap	1 * 27 = 27		1 * 23 = 23		1 * 1 = 1
  * reserved	1 * 3 = 3		1 * 7 = 7		1 * 1 = 1
-- 
1.9.1


