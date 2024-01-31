Return-Path: <linux-kernel+bounces-46504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AE8440AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DFF1C251DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA97D400;
	Wed, 31 Jan 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i2aCGLJz"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C77BB10;
	Wed, 31 Jan 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708075; cv=none; b=TMSTKXnJCR9Myxf9VuP6EPzT+b+Xi3TDz8LfPEnL56D8oV+LrvdPrWyxEHgk5g97HsnoN8tdHfD4M+r1PJqcfzKkGLZ2xY5RetctGKJ2iv6FoCcbbh0KTtdtrfbgRsp39Zkrsz9+3WGTBpX4B421WS8a2VK8M9h4AiL5uXsJg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708075; c=relaxed/simple;
	bh=ipB51S4ayXjPdAjDFJrXZRnPCOCc58tiHGNoK3XtmJo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QM5aDUBUji2q/WsGOzqON4pEt/knbxk/e0txPJx83/MZHTBmdLBoLVcL1jltbwXU9NkRrvPYYLNlIk720gpqYP4XZO6ylx4WSiN85m3UAvTRJ0KRRnwNYRfhWgYfLQ45Yv9UP+4iLmYtjBKx4QPSZV0F2TKjlNbifGFjAGgLtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i2aCGLJz; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706707765; bh=3LvlDGqVp2dR5tHsbeJj41RdmcLcttRB0AeyEWvvGzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2aCGLJzWyXKRhu4uyL11CKjUakJspzaoyW0rKL4NkUI3m+lwIXdqNTAw2IQeXbGV
	 6CXEmfuk3SwD0zVJ3cHMfw3lXaCOFIDjH2aHxIEG1oNxjqNXrTKPVIz7M9ijMscHc3
	 i2RoBStwbjpB8z/B5G2RB8r37bVSGphEFbVWhxJU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7039203E; Wed, 31 Jan 2024 21:28:03 +0800
X-QQ-mid: xmsmtpt1706707683t170w99ch
Message-ID: <tencent_6D33089EBD1B9C4BEE1B2425C6BAB4BB9F08@qq.com>
X-QQ-XMAILINFO: OW4JKxETGMY27nXxRGBgayPGLZPP931PdTQSzQ1zill1Akyt95iEkXs+ChWv2F
	 n/HpM4S8NTgrbmkEw81HUfzwMbV3QyRN88d61pS4hhgxXYxwlki1m+FCzR/7uohYdAL3e+rcAwpu
	 XjWW0mLSZNmhdhZJlcWWRrYPEbmwGncPjqt3ccGAQ4VOUtCrlq+J/v7Wka+kTtFwQyzDHPFOmrpn
	 86/yyJ0tMqEeIzoOzCfks+VOzYC+amIaujQAY/SsL6N1lb/uso+i4LenVzJGACPj68Q0e04IbUKG
	 pMx2ZQnCPv9QulEQnstzSmUBouq+B/gj7u/lA9XbV+ThgFkVC5HdfcRFjgY/hFPpHINMY1pDKeVv
	 FyqT9TTPYe0knHqoWuIjp63PtOfKcgfKUiEZJty311vKqCW+GiYihART3eEU3bUTpeV+FfK5T1yi
	 SlSICnN+aWkrVyXDmzY/tlHLwn9X2oLt9uOTjGEpHz1s4vqwfYoL+/9ymeNPkgOzOQ21nFQgf3ia
	 ZpsbGGvWpSAIIFXsoAMZgU6ft5LcAcJ5iX9xxnLrIA2HtppDlvi5bvzliJT/Ne1tjJj3aPwmDB/+
	 DQtHj45SSkTMbatqpOCv0xgEkOLdv5CR6z7KTdb+kmSk7TpYzeRhXXUscJpUdqVab7dH7eQ2QGJ/
	 PPez3v1z80UgHA5G1uDZ3PMbC2x9D4TDj/SoZpvL+6M+PD7Q/a1mSGUhwHq8cosBN3p1VH8iTc19
	 25O3CKulz7AqwjvIcE016grLq0/rkcqYrfqVXmsNx6ayaViMr2mQmCYKka14DiyMUh1pjtKHG3PA
	 EdN6VQD4UZG3iAps4umrYFljISA9iW+UprIl84wat4JXoWLxCQYb9y2TLEwyVN4CE13n2U/XcQ38
	 2QoeA4gBLg2jmII106Xi58Eo3WKzS7jVbq1NXfWwYULy/KZ+b+HkpUyy/fUf3HRn0oitvlfbF3YH
	 ReEJKvVRI=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	dvyukov@google.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	pengfei.xu@intel.com,
	rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] trace/blktrace: fix task hung in blk_trace_remove
Date: Wed, 31 Jan 2024 21:28:04 +0800
X-OQ-MSGID: <20240131132803.1350049-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
References: <0000000000002b1fc7060fca3adf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete critical sections that are time-consuming and protected by other mutexes
to avoid this issue.

Reported-and-tested-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/trace/blktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index d5d94510afd3..4543be718362 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -313,6 +313,7 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 {
+	mutex_unlock(&q->debugfs_mutex);
 	relay_close(bt->rchan);
 
 	/*
@@ -325,6 +326,7 @@ static void blk_trace_free(struct request_queue *q, struct blk_trace *bt)
 	} else {
 		debugfs_remove(bt->dir);
 	}
+	mutex_lock(&q->debugfs_mutex);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
-- 
2.43.0


