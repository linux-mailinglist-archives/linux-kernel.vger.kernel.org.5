Return-Path: <linux-kernel+bounces-97847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18819877073
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E19B20DAF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1774B2576F;
	Sat,  9 Mar 2024 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KDTwK+AV"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4149134BC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980340; cv=none; b=WwYHmCpz8uPmfFRCSrwKZwQQNcUdiGCEaLNgKZvHKnAKmFTulEX0Z/XOlTIWom1kLZQsongM9ViAmTR0Nxe7ByUWWUVUslmA+iKVlm5REUlyXe3XkmKfI/KZnidQOBbkH0WfKK7CLXmRUEFRPqjR6YLBJS1P8YRguSfI3Jfvu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980340; c=relaxed/simple;
	bh=zlIWbJfvd/AikIfWNp9cyeVLD3JixwOsMUEl/SMnHHQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pkUJSIIkCDVnNhD58MFLlzxWfJCYUyhRB9lP6t9OfZSkk9m5HKXF7l7nlRIeEx2qDXR3usECvfWhRX5X8wN0XlzPW4vrnH2YPV8mhgqldRl2JQpWM/nzRpqJJseP0ZHQLhirdkINwFBfixEkhrG9yV1di5uxXrKezWZEdimFdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KDTwK+AV; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980329;
	bh=DxyBLVjpfnxukK2thKG7gUTZdlVeeTVCdm35Y9whOV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KDTwK+AVZV+9PS+n0QdZTwD66wJnMoU/+fkDtkxf1ii8j8J04mlW4OuWTaMyLJ3ZQ
	 xSEtiPGV/uVZL7gbg7wvddsBtZbQxy2Iwcf8JYVwNG9wqHr7Lj+cX+uDIVvCt4mOL+
	 9RxC2JuBDV7LttxlKY/NvybUKzd54zrNeJFqfJ0A=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980324tjq890cum
Message-ID: <tencent_AE6183E8272FD2DD98F5FCC69E05AA54A809@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NoMDoO+PclOWYTf6CorrPV7vS9y/P7mmaA4ow1fI+9uGifRj+Jhr
	 lRDQi1TgavlERlMX7BceS4aaboLPcREbIxu24UnM8dVN+DM3+nZjXcPpt/eiSKNSsRMpKat2i/Pg
	 QhWnhedoiemG8izhPczvHnLFbbA8wHbCRR0HvHpF4xnJt8RXlPznIEEYHuz7LA7PJ8VSKoGgWqgT
	 PJ7a3VN8wbUemOrJwieb9sWwAh9qqfD3HyKbbpkFRv9RKVnJuULiDnOE2yGMVelvDGHbWWYyWme7
	 3OIgvgk6zxuchvKGh1/XfeiS9K0pYgmJogLJOhbEm8zwd0dFnPr95tb/oA4rRSH0zxj9cvW3Qema
	 1d8eI/rZlKE4wdvcRKKLuv/4XG1BY6jILL9XaGjDlv+TSkXdR4tzmdGA54e/kCqu6pkhOgmiCqDx
	 b9UrWvAwPIXZLr8APZc6MRWGJD3dQVGlu1FkBifm7GXjB3xNdNOuiRP+2HZs3Uo4c1WfGPy8hS1G
	 LZm7pBtNrFJAbCKdtXPngpQCA9yuJdB4THIpNm7WD3kJMsk9NOKbCKHq0aG5XM22sLf6dyJocQil
	 8KY9FLyi5czaUNL8vwIl8id38Eqo+NWVoeR85Hj1wedNJ+4BgYmRfWktqlQGQNpxx+cSVtFfLwuJ
	 5dYMA3h63pOqn0NjUVn/5OD4Gr+NaGqJNyJ6QoulphWftYn8ZPWLQis4rw58nqB2vno1ck/x3WzU
	 hraEsFGZgCwuJ6QB3ybJN2TODhrpF7w0zWCijuxunKbPY9bSiv7BHtc8Hy55mBuxU3E52iNVpnaF
	 DRegYPIeXOdVQHwDGexJ+EqW0I+8fpV8K+PTl07QwDon++tSTDnXhoXJWxcjgIohJIE08sPPjJfr
	 VCQbFiZk+yFnA+ia8TxVTdK5MS6yPTu1wBrxZ9wzqMB9tmSzbhJCOmVxBR+kRD6l2NXk+pvXsOnb
	 ZvFycOTf2gIgZFT8FzWxQnvb9d2zW2ZcJvohP4R8e0XNhfTZ96iT4U1Ncyst5eYkxfQB3qXaRupd
	 l62ZZlwmp9A2kwK/1ZlrSA2aB+VQSpF3XU5FubdolaahdndewerqOZ7m+d6HSPsrNXTG89ug==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] svcrdma: delete these unnecessary static variables min_ord, max_ord, etc
Date: Sat,  9 Mar 2024 18:31:22 +0800
X-OQ-MSGID: <207c6718412fdc6a2e17ebf7393dcd21e9719511.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1709978655.git.wenyang.linux@foxmail.com>
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
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


