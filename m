Return-Path: <linux-kernel+bounces-79973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1721D862911
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FD01C20C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928088F49;
	Sun, 25 Feb 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="gx/nL4oI"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396AD7476
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834104; cv=none; b=dlSDOKh0u0NeYjqZK760/U68IQo3Z52ZVW3N2focZRrSGxjt4v5KB/2ks4PlWGp5KZTMJnWuJCyfGvdlasvezCbo/bOsG5vbWdYZhk7IWzHB5E9DXm3ex/DmLtZZsS16HzihEnSmtGrBrKoh6dUsiUtrxXfCfPOhMkfdPkdJtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834104; c=relaxed/simple;
	bh=q4dKeuWe6W4Noz1+d/7Yfs/ZMDZdDCxYAicIx07p0Fw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FnVcC6xtrQDxUWPB8KuNd/JToF5yOOau3bFFi54Ku1aCR/UD0Zr+1JpsUg4CY5uCAEZeRn8gSvHL0ZyaUvqcHbjg1bGhc+SbFMaIZItyWqCm41nq0dwsRYN1SSEy7wmBCipEdNayvOxgt5JzNgNMOjLHtC//hrg/Byeakf+bbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=gx/nL4oI; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834092;
	bh=VLgh3i1HLl4qsZsnPo2rlFAeoCtuGCX5i0c6X8Lsfio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gx/nL4oITRUCY3wlbj7biUDuf2rPh1l+GoqFgparHYAHxgESkRawhxhjSGlg3gDnU
	 3FV91cdnBwFr5xTVB9CIOhsgbgWYj127m+YgZdo1FOeXQJphM3k6XyIUnuvwWxSEy5
	 32FwJZeq991ZEcca2I3kbsD3DP9M3ZI10jwdIlWM=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708834004tx0ivesbr
Message-ID: <tencent_A7FD9E9E75AA74A87583A427F5D20F988B09@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt9c0H52Jz366tiakHJ3gYHewk0A//04bB4zWcvxj0dGp5YbLv6C
	 FGtFQ8Y/PXdjyK2qk/u4xSOuFL7zwAGNaOmhXXpV3IwXHJsAbiY/Di5b/G6kK4eUzrgyPrknbUWS
	 UBr/IC4wtS6nAwFGBsnBEiDkexwhWmWKLoRnXj3ekg1cX7EYxleemBTi4dPIjOtf4zyX+i+4ot5W
	 7MQuhTDBfpQVSUkwADIIQv7SZVtyUg8cPu7P1ZMblMIaWjVHDKBRc/jD6mEplPM9bb7YaDIosqeq
	 1Q2JW2XUcWEifiy04qzBbUEadc11O6dhPbJ6TdHEG3/vLLTFSMtdlsExY214kPZtXvcErUTRf5Pk
	 F5q7XC00fw4fSlKdGEhGXtNdhvnMPsa1CDI/QrkD68O6lx4Vv1pdEtclvH3ygKBrW6G6Gc/VITPR
	 4xwfIDSbwp0D/0PiZD2kK8bQjFbYBUFmEWDKrZFsB2hk/36MPOJ1EJhgztQiP2ePikJjZ1YkK6WF
	 JSMh3RrN/+l2eeD0YxtlzhoCr5EG9Viky8379KlPNVMuagUeEgb80A07M5K6VgtXieqyypQXfYwN
	 0pbYB9pVyxD/8ITWyX5jf/EICKD+mE6LZvebLO/CHUNF1qD8+ryXRzMhCLCfCZdFFbcqkOXkk1hm
	 i1MeMdO3UAzGxwcI5K6vyREUATt5AXgGP86Q4LCvBdM/cRmYiVrNcHuaM5WLIW6kVuxd7Wxr5NUJ
	 vwdpn/AQOm+1mTowMxjvQOZS5nlGEGC6WnGfEKjy/yQEan87waQspiyH9HRVqxX/KbYyQ83IsZTw
	 H5qmRLIA9UgBi4JLi9TJxrENsIEp2FPwcgMs5GkePXXBcJqzVQFpGvTJ2ITFlYxyrOJj1ilmRuzZ
	 JpGdRXTmSfJkzpHbK1uoo6dgrfsgpagPeP2mPxQ1scqLYPR5xIrlv7Ik6kQ390WpsrYDKbB4Wu7U
	 N8/+18UZl+IQNvC+6Iv+k8nmoxNdS981uZl/by0DZzdeVpRTdG4Hp8j56rZMfX9FcxBOszZvdYFn
	 hLw6UdnTK7Ad/J2XEXXeQiOx4LC3s84hgZ3q5atCF6ZwzcdC+NRtHzMa0eSpkf8783YPkcHvmPlr
	 tutj8l
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] svcrdma: delete the duplicate static variables zero
Date: Sun, 25 Feb 2024 12:05:34 +0800
X-OQ-MSGID: <20240225040538.845899-5-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variable zero is only used for boundary checks and
will not be changed, remove it and use the ones in our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/sunrpc/xprtrdma/svc_rdma.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f86970733eb0..5e4cd17eeb5a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -63,7 +63,6 @@ unsigned int svcrdma_max_req_size = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int min_max_inline = RPCRDMA_DEF_INLINE_THRESH;
 static unsigned int max_max_inline = RPCRDMA_MAX_INLINE_THRESH;
 static unsigned int svcrdma_stat_unused;
-static unsigned int zero;
 
 struct percpu_counter svcrdma_stat_read;
 struct percpu_counter svcrdma_stat_recv;
@@ -170,8 +169,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "rdma_stat_rq_poll",
@@ -179,8 +178,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "rdma_stat_rq_prod",
@@ -188,8 +187,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "rdma_stat_sq_poll",
@@ -197,8 +196,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
 	},
 	{
 		.procname	= "rdma_stat_sq_prod",
@@ -206,8 +205,8 @@ static struct ctl_table svcrdma_parm_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &zero,
-		.extra2		= &zero,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
 	},
 	{ },
 };
-- 
2.25.1


