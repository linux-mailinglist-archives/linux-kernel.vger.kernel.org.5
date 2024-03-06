Return-Path: <linux-kernel+bounces-93262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11468872D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FF11C2323B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC4EDF49;
	Wed,  6 Mar 2024 03:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qAzJNIG1"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1DD173;
	Wed,  6 Mar 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694328; cv=none; b=H9kgC9pQVQKE6N9cAhd04PHuPKjtQAxyfqNV0YSy1Txe+gYZRbWMjl1E0P22I512JcpEbiJkOc6Ocaf7M0oh3ezIg8tFNOuvNgJI6hLuCW3rllQ4TyV3Yi8kUf9L7KRhpzI1wqmltJ2z2Q9RtLHr3Iss9cQqWD900QIeIVCPsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694328; c=relaxed/simple;
	bh=+6dHN2SSImxbZVsLMYu8GjPrXgMt14/8zzaKZLLtt6w=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=J9IoSGVGpwFJ90DlGnxTLa0hKormeHQoCBUVFJKFP7bv8tStMhLwpGyEWm/um2udnSqIqBSOBCxtxXl/p5vFv/KFj1RWKW7/2v+TH2Dq/vSQL6FQHGfW8PAAbpP06MNSpvrcwZWEQGlfeNvWG+saSurgl1zxl7kXTzscmGbTCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qAzJNIG1; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709694320; bh=C1CCOEGfxwvS0ORC18PbykbGWEcGm+e5TlS2qTiTC8M=;
	h=From:To:Cc:Subject:Date;
	b=qAzJNIG1GjapQ/ruL6Gk2OIxfzaaElejbgO/E8VXY5hUwN9fKxlPPROwXsKulo3Uh
	 IYjvcl3cgBbv7cGIeQc26o9J7hSdgkWoq+Sj/qolWEjKuJvsoSobUkol/oNdnfE5w0
	 MwM3OnbitvZbyR6uk3fFJV2iaZl4qqYYpv7ADxh8=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id EB629EBA; Wed, 06 Mar 2024 10:58:54 +0800
X-QQ-mid: xmsmtpt1709693934tgba4zn3s
Message-ID: <tencent_BA1473492BC618B473864561EA3AB1418908@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4ynehAJEBEIWe8kG3QjwIOBAAFjtzj/bi2QqEXFKL/S0q3DtlSLDJP
	 BSQ1mTkDMHeN2FDx2PpEyPWS+EZvcrvr9opjubjS1khLEHyACXUzhs6ImoJi3R+dcAxX5wuvQEhg
	 bDc1CGQC+rNI+P0tEL7pFcI97ZZWuMK2hjcYuQ74eoEsEPmK656+dtO6EFYyY7xDkWV68PnC28F8
	 QVcXabTYCVwWNfFlyq4hZNfxSxjvIf9hXTFfy+4z2ZIWLiKXLvBeZZIs9u5FJmT8uYU2AFi1d8ja
	 WmQb1U24QeArVysoV7/afaOElbGEZptRK51F7dBKOTuxGBqz4sZxhkukVuRwZkr93r2vHyojzMuF
	 K/5fvUetXJfqHmTLCpsmvHOQgaaMjW/i8lI12o4aHaM/W7hEsoMEZRrDE9qTuDQwERR+vzm0zS0G
	 mgeuM08ijapmyO/Cb6QKWz7DrFtjpSAm89AZf2Rq7T7CNoifpgI7bEz0c1QKMoxntQzeI0zXd24F
	 7KkudePX2InU0iabP2J6UHXS6swI1jHtMbrb3Ty1FHFYFaKD3zLKElG1bZDf3V9mc0PRqNkRVI5J
	 SubW5Opks1Y+LMYWnxYJ9Qqyqm8XsROdZDVf5vKhUyT+vJZRYuDqHQ+r5h7X6XQk0eZXNlKXWFvS
	 a5l9OsYQeNnOJIoRBxMChUnOGkpgXjatisEbgAwu6NeJVEtM7JD5Zd0i8e2Xv1fcjNbMmJI84EGc
	 iHVWEWEaKAWWSKQxTbQm7ZUfkWk0pcYPEBzEHfLZ+lUyjvG0muxKfBF4lMFHhdh3ztBfqZ7VIi43
	 3F7zaRgMUUDIR8J6UtH66Ik8zRQGKT2rXNdyRXvy+FQRwzZkKJ0yWd0AbvJMmGTIH0/l4BMowHtV
	 +heYewETaagm7CfFxxek4zgMbHjYZxvrnAcWFfS7jxxGvZg0C4e4iTzxO+ddX9BKMP8eCvt48Rbz
	 UTbfUusx93/iresHxmihJaNw2j4DpD6UxsPfoudIm587AI8qTxd/kBote8auyJOo+0FYCgb6n089
	 7AcTDDnOohg7b9wPWXYYE0wexUbBtgbp2hfbCM+9SSgBQddk1VNpkYXfatTjE=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: mark racy accesses on work->wait_index
Date: Wed,  6 Mar 2024 10:55:34 +0800
X-OQ-MSGID: <20240306025534.49139-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark data races to work->wait_index as benign using READ_ONCE and WRITE_ONCE. These accesses are expected to be racy.

Signed-off-by: linke li <lilinke99@qq.com>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0699027b4f4c..a47e9e9750cc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -798,7 +798,7 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-	rbwork->wait_index++;
+	WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
@@ -906,7 +906,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 
 		/* Make sure to see the new wait index */
 		smp_rmb();
-		if (wait_index != work->wait_index)
+		if (wait_index != READ_ONCE(work->wait_index))
 			break;
 	}
 
-- 
2.39.3 (Apple Git-145)


