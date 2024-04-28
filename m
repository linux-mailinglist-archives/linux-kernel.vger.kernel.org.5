Return-Path: <linux-kernel+bounces-161410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016858B4BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C16281A77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACA76A35D;
	Sun, 28 Apr 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lhLuPV9e"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3A69D3C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714306169; cv=none; b=WMby7z/e83SdGcQlX4sB4LeV8YpWkCOzFP38mYnYVkpRbF2WhAMQwdpTVWk18ZccqphBlog4cSO3XNSKx7Hrn41oqH4YgHF/53GhEvGPutzbf1Lm1TnSOXQnEPHSXTU1EwXqXDZCdfM4MaAi84TVIjFFiRVMb8837IcjNIx79xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714306169; c=relaxed/simple;
	bh=Q7qt3C3e8Sz0adbPLGC2b2xvUM5rG5ice7wMqSasy/s=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=bvtLOPzOGroqyNRgUjsYgaL4c9u/2UEffUTOpPLDJZjh0k+1b3398dcCZ4uq0dQVSXJ/RJznT7mY0eiSFf1SYqKsfVgaYssxZ0HsZIJHYemNqaCEfza3Ad3612zSZEACObSZlX+mkG9dmb9ukfYlT4/Os19MsxQS3S1sKRqKVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lhLuPV9e; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714306165; bh=mFST7TMJ05crdWVunyn9uP3vT4PSN6bGrjFjaEmUd3w=;
	h=From:To:Subject:Date;
	b=lhLuPV9efdGz/KLYpRHQTV3VRxkwAc71Z/wsubNc2/NupdkQaHmvHQJyzy+9i36du
	 8nu66n/Wvrvt18xtxx0X6lu5eKzz3y/TddYhKDWOYCPgponO73bnzsGNqvxHgfNdMM
	 NaLzAcRUQVUCzadXnY7ZDxVOdW8m3MksxCN0syFA=
Received: from pipishuo-OMEN-by-HP-Laptop-16-b0xxx.. ([123.115.148.131])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 1248DCD1; Sun, 28 Apr 2024 20:04:36 +0800
X-QQ-mid: xmsmtpt1714305876tragndlwu
Message-ID: <tencent_58C9EBCB7FA35A38EAD077080863D46A5D06@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTVMWYhpd3J9vwYPaSVcVUPRxAyX20+aXCr8H2JqL5qh65ZFf662
	 Pabhgujxl0eSRippeqaGaBgwLh4wjW3PukZPNdRrv2ihGqORBNyaSECu4MhiNpGVaCTNE1Bq3K/o
	 s+DowjfzSq8k38U1nIR0Hi3Z/JTCzMtAkLa3jgjMo/N58GK3XCg9HjUEdBR6LHR86ipbbU2cDwpq
	 AXICMt8V/sdYddKlFK8BqpKPx2gFg9201Hzo3/WY+kj4bMqcMZlDS2XXlh5VjgAHiNMEQdViUQhp
	 lcJ5YMRyLZM6fYvk8KRhmS3wcTc1sRPZvTpuIF43w9Jo6EQpASe20DYdP0evsvqdgVcH5m0O1fsW
	 NlHRzAGLjQCwm/dlj5IgfKltlzkILEZo1MIYADBPR24ukibA2FRuP18CkkBFNLTUCctfedaO14dt
	 18YXJxJkIMGRAovQCz2nlKgTV+e4+lqLBKryq0ixyyyuLmKg5WdvNcfvB76jiGVlwT2rKtcK7jN8
	 /gBwoqRwAb21KOsu6ZGZjoYhz2X83a4uMpH/+/4KGX9QQxHOB5fShjfWSZNeCpI0CRsGZPMBFcft
	 LtVIEJiiu7+CEpxqbo/hl9D82KxiExokSEwjNrpwNe4VUwBrcjURQGreA6hYAMzvcE3o4mlE3aHw
	 2qbd6ogvazSmsgp5hThxaYFAeLvbIKCN0ak8vgBoeYSNmiWhM0I6U6bk5zYukC5zPd0mXzB9ksTq
	 lLXvLAxM8ODndrp9EIAA9HRy4bevjhzUSqMpqvNG06NbM7Q/RFBdB0RrSgyzWSIf92nMaqrvBZlS
	 HF7k7oJh4sO1SEuaJNoYDvRGne9IAlKV0o8uO9nBAK3CpHJsrAVEgAf48150swFm4hmCvkl6V2uV
	 Tfbqv3HlIHcFWELZ1i9kvsEyfK3PVlvyq4s9NhxWWdelB3nfdkoMwEFN7i+9CWOX0IcYVkqk3758
	 yy7+cO5D5Q7D5MLzm67Sjw1M+PWhgN84nHxvfIJFc4I9V+KCFWBW8tT4RznFnYVyVPxCND068=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: pipishuo <1289151713@qq.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	1289151713@qq.com
Subject: [PATCH] staging: axis-fifo: fixes alignment should match open parenthesis
Date: Sun, 28 Apr 2024 20:04:34 +0800
X-OQ-MSGID: <20240428120434.10615-1-1289151713@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the checks reported by checkpatch.pl
for alignment should match open parenthesis

Signed-off-by: pipishuo <1289151713@qq.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c51818c56dd2..04f0e5b45a8b 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -376,7 +376,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
 			read_timeout);
 
 		if (ret <= 0) {
-- 
2.34.1


