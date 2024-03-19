Return-Path: <linux-kernel+bounces-107761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2E880155
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478B1284A48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04C80020;
	Tue, 19 Mar 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mz/QiRN7"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF57F7F6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864215; cv=none; b=qXyRqVoPsYnpBtLD9W48oimDsFDxjn7H1voxRa56gWaa+IC+Bydgo24n5i8i6relsLhVyRZs1cPG0rPqwFCKxXAqBtM8mwYQKjlA/UcpXx09Q3AxhsbT0B8QtwN5lRzYG5zlJBJ793ClrlDQXZqw0FmLrIk++8j3yCXNru7A1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864215; c=relaxed/simple;
	bh=zlIWbJfvd/AikIfWNp9cyeVLD3JixwOsMUEl/SMnHHQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oBQWrcY35hkYJz1kQW5pPkoMTYOtHnKDNkYqRATXCelFv13hs1bzPkREB5zMaQxNwJ9KNPzcHbk66MHlZ4EELsHEijJGQ9Rh0c7miJ8T91rZAlddTaIOEvsGcvTwNdqq4CT6TEd/j32vO1ESaF/fQFMoNI0ouTggRsUynY3wqcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mz/QiRN7; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863903;
	bh=DxyBLVjpfnxukK2thKG7gUTZdlVeeTVCdm35Y9whOV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mz/QiRN7s6y/Lf6Mm6oG51tmrhyHAiPT7h3siBJefm68lHndDrdWDZHyIA+vh7ZqG
	 1AaWcGap3LYgp10HmYDcZHna9alpHd9YnFsdnEKc8qdnuTbNAo435N2tC9XkE+o3nq
	 2+cHbJNECPKdoK7q7cXBSknOgkI+V8soYVMO7Nus=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863900t5klrhap6
Message-ID: <tencent_DEA0A6C9C1F45C66383FB767F7AA51EAB207@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeXwUCIYCfOd/G1JlnjD4TgMrZMOYcFdH1tKXQYmhKfBMTcd5lEN
	 9TdqBn10jBOi3VcLRXl7cvoDgN3o4Yf399DsesGneh816IEc8l6dXMVDuraoin+DvZHThC5qNiem
	 3XHvH0HTEM/0VmM2SB5RLHQcQklG+6v0O/9tx4M3naDGnr4SokDzv+SGnzkoJXhmoOobCBC1+GVQ
	 KziTQi01mEOwGOVMt1sHF7L6JA64lZkXTpGZpdOTFpLCPZ1IZ6Ta9gNWhQGvWC32SVluyUIXe4D+
	 YFK49Z4jGgIdmg8HJ7+TYZFAaZLvLUSTsfWGIPBcbbGx6gO9pgqqcIlaJ/1idrFTKyRsS4WcCAkX
	 vZKvQGVK2+2efTHtBNR9lGMjJ5WYAPdEdxtlUYxOHFppz3U+ebmtpjFrVo5QmdwWk9ApDocR2FPT
	 JfyktK2nYvyQGXD4O3C0cg7/xz1WvyvbbfK52+6kPC7xUJaMIXBmoxs45Lh8acl9ZDIxKFTZ2+iw
	 8WF9IxqMM96G8apgSTcP1xRDmiwquTyLMV3dmtDYhLY5t8KCPeixKv5ZrIVUrUabDA0KhTd3gTaq
	 ViWhAhNsnSpGGkwz9UKITy0xU60d9UOJ8m8u6uaL6HLT7F2nT2eNhmsjHyZF0qSQXlkL9Sa6/4SE
	 /PfSfeEf+XHPK2QAZ2GQ5a072J9XyKIgkQGU+3AJLBdUG1lTSoTVwd+iUgLtRzT1mUHj+DHG9Pkw
	 XiZMq7mtGwIBshr7xbiRjmLTobFts0dz37jaEYAhrLJgfWUUcPtz6WA9pnJrhZegc3uO+JN/LPvn
	 05j6poogk6dhH45P5BaJ2NiOf+SyK/sZAg/482to+8Cas0eXuRT6N2++y64OjZf+0arjfNFTpaix
	 0axs3GnfhLNaLpIDu84/CBn4NbhiijyYuz02AHkRJY3SJ2qBQWuORlLGpA3+daY0O8Q4nPU69G39
	 nDQXrItl1m9p3XKwqd210TCeeusU11PLwrGg6eZRR9yA62nMWCfZSswBl1ZLf96x8mziuqVfo7XF
	 Yez7sVgtq2tU3KGtRgzKY2i/nCAvN9BS9mJYlDWrQ4zHILOuIeKEIsnJ01y+E=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 5/9] svcrdma: delete these unnecessary static variables min_ord, max_ord, etc
Date: Tue, 19 Mar 2024 23:57:46 +0800
X-OQ-MSGID: <9ff013657a6ed7ad81d7b99c7b0e03d54577f315.1710863674.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Delete unnecessary static variables (min_ord, max_ord, etc.)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 net/sunrpc/xprtrdma/svc_rdma.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f86970733eb0..98cde9c2bf5a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -53,15 +53,9 @@
 
 /* RPC/RDMA parameters */
 unsigned int svcrdma_ord = 16;	/* historical default */
-static unsigned int min_ord = 1;
-static unsigned int max_ord = 255;
 unsigned int svcrdma_max_requests = RPCRDMA_MAX_REQUESTS;
 unsigned int svcrdma_max_bc_requests = RPCRDMA_MAX_BC_REQUESTS;
-static unsigned int min_max_requests = 4;
-static unsigned int max_max_requests = 16384;
 unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
-static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
-static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 static unsigned int svcrdma_stat_unused;
 static unsigned int zero;
 
@@ -114,8 +108,9 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_max_requests,
-		.extra2		= &max_max_requests
+		.min		= SYSCTL_NUMERIC_FOUR,
+		.max		= SYSCTL_NUMERIC_16K,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "max_req_size",
@@ -123,8 +118,9 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_max_inline,
-		.extra2		= &max_max_inline
+		.min		= RPCRDMA_DEF_INLINE_THRESH,
+		.max		= RPCRDMA_MAX_INLINE_THRESH,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 	{
 		.procname	= "max_outbound_read_requests",
@@ -132,8 +128,9 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &min_ord,
-		.extra2		= &max_ord,
+		.min		= SYSCTL_NUMERIC_ONE,
+		.max		= SYSCTL_NUMERIC_U8_MAX,
+		.extra_flags	= SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,
 	},
 
 	{
-- 
2.25.1


