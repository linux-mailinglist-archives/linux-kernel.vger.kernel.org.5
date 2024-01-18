Return-Path: <linux-kernel+bounces-29724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD35B831286
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 06:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C761C20970
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176139447;
	Thu, 18 Jan 2024 05:50:23 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDE8F40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705557022; cv=none; b=gQGvjqLiDfXRGSTzDIfpAz5FifhENzJ7vDjXSbeMQCK21A9YiHDL/lAunKnicBsaN/V01A881e7wbyBpooQPZXi8cq+M6CqVEloSy7L3/IGJSdaWehWtjUncD+TZWsC06LWNN6lXdmRHojWbVL8ZHVeERpRu7oplCDDji3CklLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705557022; c=relaxed/simple;
	bh=L0pqLWLULcpvX8//vSMhr+PD1g8TavhtuH8ROEBiUp0=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-MAIL; b=UpK9jbt4xkPvjv1Fgkx86OvRKtt91Gx2/v/EsPd0zzb5wt7MgpQLWzVIxcgRUlUUPde+sgMyKZUEXuxXQm2yOd/9LqQqjh6yDzLUlIeiZvf9UWqE9RGc9jVjXmXvw0vwoGi0+qCWBMmA64sLobJw3BNVePSBrIaupK4tc0CRQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40I5nDeo046157;
	Thu, 18 Jan 2024 13:49:13 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TFs7t2BQSz2RRs0w;
	Thu, 18 Jan 2024 13:42:02 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 18 Jan 2024 13:49:11 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: compress: remove some redundant codes in f2fs_cache_compressed_page
Date: Thu, 18 Jan 2024 13:48:31 +0800
Message-ID: <1705556911-24117-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40I5nDeo046157

Just remove some redundant codes, no logic change.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/compress.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ff26b49..624212d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1889,12 +1889,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 
 	set_page_private_data(cpage, ino);
 
-	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
-		goto out;
-
 	memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
 	SetPageUptodate(cpage);
-out:
 	f2fs_put_page(cpage, 1);
 }
 
-- 
1.9.1


