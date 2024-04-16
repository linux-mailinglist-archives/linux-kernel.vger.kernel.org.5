Return-Path: <linux-kernel+bounces-146413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51218A64EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A64D1F22BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF87E563;
	Tue, 16 Apr 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBG7Ntgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE07602B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252075; cv=none; b=RtPhRqXIOSCn4scRVVn+XFqkE42pCABvQ+YcrgGl9raBgHw6IYOZiTdavOahmwDTn/ZHR0k5CzoDRQ/uFBANLByFIfeIZetyp/rRnlCobhSTyAjNio+vq+dWkFJA7P1dtA9a/DrucND2z3KXdECZdBJs0+VKEf7k50ZUDbzjoFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252075; c=relaxed/simple;
	bh=0eAYPFz5NJz8CvYb2+reHHZOCHtdyUHNHA7JFN9scDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lSYMyyDhetL5ijbyfXqxad0+NT4Hw1jRDwkIHoA1SynAEBY3f3/q1Ecg0WDmcIXofaYmNG2RPJ41Y0JHl5V8SMpS7GzD2ReOLayat+3H/3/1Y1zHK6fkSnErIfLGjXV53okS7cnxlK+XlATp2WgKZ3KEiOTOjTlbw6g7x35yuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBG7Ntgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F64C113CE;
	Tue, 16 Apr 2024 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713252075;
	bh=0eAYPFz5NJz8CvYb2+reHHZOCHtdyUHNHA7JFN9scDM=;
	h=From:To:Cc:Subject:Date:From;
	b=XBG7NtgcrQECr0YpoPjUOFyUyw2eqNUa6jVQRPDU3MaoW3IouNXXIHJ8kjMy3n81O
	 XXS7DknigjgoYcLCtZe0+lCTSxQOrbNHKR4s2pLNEVJ25vlZ6anG6oMO4fYNNmLjqs
	 v6VEEgbvfZhTWxifnycvVWkzVEshrl82iK6c744yo2hfzBHRdpvahYBS68hqKPx5Op
	 +yqhcsFO4FVFu6U1TjzOsRtkcukDpP9VRco+z8g2Z+lmQozIS/fiXO4iur/ciZ7ODx
	 QEhbxMQ8W3e2PvxyBIUJNfwyEnC5ukc9rvhkhPvBE61r7gP/lLwRMymtU69gRWt8U+
	 56xngnOpHXVpQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix comment in sanity_check_raw_super()
Date: Tue, 16 Apr 2024 15:21:07 +0800
Message-Id: <20240416072108.5819-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d7e9a9037de2 ("f2fs: Support Block Size == Page Size") missed to
adjust comment in sanity_check_raw_super(), fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0a34c8746782..6d1e4fc629e2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3456,7 +3456,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	/* Currently, support only 4KB block size */
+	/* only support block_size equals to PAGE_SIZE */
 	if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS) {
 		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
 			  le32_to_cpu(raw_super->log_blocksize),
-- 
2.40.1


