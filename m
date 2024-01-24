Return-Path: <linux-kernel+bounces-36252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D92A839DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176642871FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608E210F2;
	Wed, 24 Jan 2024 01:03:30 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F910E3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058210; cv=none; b=q2rRH0RIqp5oVXysqjOgfiD1AQZKf7KT+mi7sNv+dSsAiPRwSRyA1eaHKYArTZOEbNTK+wKu6tbzhQ3QfP0i1h5fk0uJZopo2Y5iAe15xtXZ4bDqJq8gd5OGJywf4933zOVvokPFVzANGzpchIeu+E6UkeMCLpKIaZUKjI2unUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058210; c=relaxed/simple;
	bh=hV6NqU0W1+Wf0pkFYtSJr6jS6L+KKlOLwkBT5Tj40U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oRvbsABr+d0mB9sS9dj7myFXiM/LvZGEzB4b2QgzCt9lLCFSoeBZPNx93PzPMLasLrb/Pqjb1I8kxX8PBrAVM+qwY+NazGbQtDbuxfJo6+gBvBmIGTXiY+z+lBUHnrwdKD0s42A/Hn1A3I2ltskIJaxKmjIYA9xi0PgH0nVeXgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W.E7vKj_1706058203;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W.E7vKj_1706058203)
          by smtp.aliyun-inc.com;
          Wed, 24 Jan 2024 09:03:24 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jaharkes@cs.cmu.edu,
	coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: coda: Remove unused variable 'outp' in venus_rmdir
Date: Wed, 24 Jan 2024 09:03:22 +0800
Message-Id: <20240124010322.94782-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'outp' is declared but not used in the venus_rmdir
function within the Coda filesystem module. This causes a compiler
warning about the variable being set but not used.

To clean up the code and address the compiler warning, this patch
removes the declaration of the unused 'outp' variable.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/coda/upcall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index cd6a3721f6f6..d97e0e4374f9 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -303,7 +303,6 @@ int venus_rmdir(struct super_block *sb, struct CodaFid *dirfid,
 		    const char *name, int length)
 {
         union inputArgs *inp;
-        union outputArgs *outp;
         int insize, outsize, error;
         int offset;
 
-- 
2.20.1.7.g153144c


