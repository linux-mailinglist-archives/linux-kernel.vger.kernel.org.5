Return-Path: <linux-kernel+bounces-79953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1014A8628ED
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A0AB212BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF44C96;
	Sun, 25 Feb 2024 03:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mk/W/+vb"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AA63A5;
	Sun, 25 Feb 2024 03:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708830333; cv=none; b=D/ES1/qeGtRZKxREA7TChSTAn1b2jCKOnFV7CFIPuLnJMKgiCtEAC/dwFBjZ0OAQZzvZ08gTIjT50pftTStYMkLQzoNLZ6MXFc5CAr1De1puqroJozbyHU3dD4rSpnQcNiJZ3EmNrDVc2iuVj9FgPkvWe7QD3jJUxvQ8W+aMr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708830333; c=relaxed/simple;
	bh=L20Dun7FleQn4bkO5h+YiLlfoH0K6st2YbTELaAGEqM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iVm7ZdP0dGWMAWmzMOlGW+ot/FGaXoC3IeLWhOVonQq275X/rbVEpssWPFSxpPpWqE+lSmP8t5f2a6cEy5+kHNQIpx4YvYAqfGmC16+j8jZG9SdxXgmIk0PVH2eG4UJoaes92k7Obrg5po6U/pl5BnWljaF0qkTOYqIizemYUXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mk/W/+vb; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708830328; bh=HoHJVcHPbLUtsuObsC+KQhu8jDUrXcUZFTBUuEmCeaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mk/W/+vbGbtOzQQN6i5kEQAxaNlNJZ1/n4jYnPCu4GSW0NjfXAuSBUPS61digJoVd
	 JqB3dwpgACXtFeNWeV1rPTTO9426b1GktJlN51qSxDF4CzQNm4tHq8yeCM8b682DNl
	 0qgnTh2XioMUi1+PtEUT4URIeM5btqD6vjoZnNMI=
Received: from localhost.localdomain ([153.3.164.50])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 15A1B477; Sun, 25 Feb 2024 11:05:26 +0800
X-QQ-mid: xmsmtpt1708830326tp7ufxdrg
Message-ID: <tencent_5EC64EB49686EE61593AE541DB14CE490A08@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCgVxZIjut2UWdWGFmMiPQDVVN+2H3V+OxYT5Nqc+gbRQEf/z8pD
	 9TWf4TPSWy5Xmdu/12ppK37qbc9/wJ1LqFOKIixGIOr8Fip2tn09TtwYcp35UARxggvJyveKRhXA
	 qlHe+73mDD7q1qknJGDShXFcNbUcBWgRepwawvTaGIRcp9dt2jrYrOMUyBvRp7ajx0F1IGCuW4Zb
	 +h/CweK4mNQXlZ2t6KGOse0OKaCcocegTrjSJS18tAWN/XIHxDnYk+0CgETK+vYmkEBCrWqU9M1C
	 /e9GNcpAsbaX9T+wZF4jCem/XSbAjugQrH2kp4Q5FMDwkV+XKAJotN1SJkxTYnHaxok7AnkuKvcY
	 qRUo+xN/lFq1JuC00khm6P4++pEseQo6/Pfy9gyxTqaPKrmQrk+0YmsDqfpjETsT48QX9CQxphmk
	 /EDI/D03I43Lkv9YnQTEDdq8ldUkJHwq5OFFK7wdie01XzrkXeo5CCiHenXdKnegDZvF4sawuV+2
	 TxAZRGCr4Kgz3AuX7/HvxZoKEKJsYB7gh8+IGNgXUfHcZhVBWg+B9hf0VBdi0CfNYpIR79thlOl2
	 sbSJzJ+rgcDFnydIUcpJJu0nrYVg/SyZjcFdMgl7WMeO+R2tQG4yya6F3KsjgeTuW8ehjZgdGGQB
	 +gqb3/b/HM5AxzZ+HzpVfJo3J6l4VEQhh2x/gUOjop38vg6mAVzpVUFwNkR1/j23C7LJ6oGf87ox
	 tLyS6SNAEbaaJoXdOSRHo9+O4xpQCG8U+6O70bD9VT1MzxQd+MhFUqiMmxOz6J4Wt058x9FMRJZn
	 Nv04yR/Bso4LpuXwTwgSj32QWJSV1SPSCiKRmpMgJ8xLmU9jXQMTmsrY7DbGLB48xgZxbMDcbbAL
	 LZHfJEkfOkbG75gNxS74uVSsqra6nYZj3PdCdnwcHvlJIA05Q7Kgx5VMYzSeXfd/OZlmrM9BHb4k
	 PWK/NGIW65EUURpT6ecCqYXf/x0FbJsYTZvQZdoiQHxjsjODJW3PX+mCbYkCDh1fejzaa8PBI=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment
Date: Sun, 25 Feb 2024 11:05:06 +0800
X-OQ-MSGID: <20240225030507.97911-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <lilinke99@qq.com>
References: <lilinke99@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function ring_buffer_iter_empty(), cpu_buffer->commit_page and
curr_commit_page->page->time_stamp is read using READ_ONCE() in 
line 4354, 4355

4354    curr_commit_page = READ_ONCE(cpu_buffer->commit_page);
4355    curr_commit_ts = READ_ONCE(curr_commit_page->page->time_stamp);

while they are read directly in line 4340, 4341

4340    commit_page = cpu_buffer->commit_page;
4341    commit_ts = commit_page->page->time_stamp;

There is patch similar to this. commit c1c0ce31b242 ("r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx")
This patch find two read of same variable while one is protected, another
is not. And READ_ONCE() is added to protect.

Signed-off-by: linke li <lilinke99@qq.com>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0699027b4f4c..eb3fa629b837 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4337,8 +4337,8 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	cpu_buffer = iter->cpu_buffer;
 	reader = cpu_buffer->reader_page;
 	head_page = cpu_buffer->head_page;
-	commit_page = cpu_buffer->commit_page;
-	commit_ts = commit_page->page->time_stamp;
+	commit_page = READ_ONCE(cpu_buffer->commit_page);
+	commit_ts = READ_ONCE(commit_page->page->time_stamp);
 
 	/*
 	 * When the writer goes across pages, it issues a cmpxchg which
-- 
2.39.3 (Apple Git-145)


