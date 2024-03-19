Return-Path: <linux-kernel+bounces-107766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23543880167
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0EC282E35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05780611;
	Tue, 19 Mar 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TXkmPfgm"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E945915E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864408; cv=none; b=oCtSiE1y6BmwspArASVfekzMHy7qSbjsU+H8enesFNe9zFW3o1XAjkA6lYg2gKcpCG+HQxkOS73t7KWSIlYtpCUuJ9fp70PNlCFX7f907jHVaQJbUjasqQDPyoz/V1jaqEJVNfDKA2nAbVc2xaGzyroGcme3tOu30FUxzTVfCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864408; c=relaxed/simple;
	bh=9Gz2RXz51oHRw8OR/4Cz4VUaTiWu8pStV9bUPdYwH/A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qx27FJRTITa2Vttf+KAvr4Gl4zyq5QtHuAIFe+3Kn7EcKaTeoBq42KZlNRgz6faPQjqhsQauFQ1q6lDtm8PCoKs2sZSNHCYzTDpKombWZHnsDD0q6CuSO7rtONGLOWGrn3MtngpdwF82bAbqrgTSBxGnOorhq8awCRMOW9nsyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TXkmPfgm; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710864404;
	bh=pzUshAmwIhfns0JHddsR8oSXiooWQ8z0An7EKzxYuC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXkmPfgm7mhlO717TyTDtGyNaDtZlMLy0Fu9BxoI4Yzbs8UZgZ8jjq/LKT6nWxsPP
	 0OuVpLVRLZzGomeobY/OY1uW6WVxoe2wkO4qCYLeaeoG3em7mcpJZjMc4LUZtYQgcU
	 u6NRlX4TeeZjvJ7jU5Bn8Z/KDDn/BkSMECG/Wi84=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863894t22ri8u26
Message-ID: <tencent_093C67575151D704214D42A68332A7F9F50A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9/9vdW8nlMOL6LAgsFq9dYIsrVHStc265nfl1wF7GtnkDr3SmY6
	 J6eJf5Bm4n3DL6irk2pY3o5Pjf7M8iIqZzB7kuZ6PQ3ldaGWsd1+bJT2VamcuxrQgL9W94XZmCS2
	 DANo5KvlXf0O3fk8eu2b6oCKVymeZkDB4HwEMrg8NA0tZ9ydYgPVKBtcX0ZrCYbD36HVlvQX0Ndb
	 0u4Ayb1rJbnntiDYAreNQ+HmD6kOpz0vskmmdS+CF63s55SufHrCxUHMSbk9dHYXcxQrCkzx5k8x
	 RSjwD/yL6bkumMurE1Q4PhYzcGF3o9ot7ZcwmcsTvwVWqq1tFYPkscS7Q5AuhWfTY1LK9BXJPnJn
	 Z8L54DbxXFBTV89alQQbIS/uf2kfV+V9FqqFSCdQUQDF/qTEsRo8I4+eFMStPeGs8FqlsCvQUwu5
	 OCHj4xCHsmCylJmj/5CmwOBJR9RWx36XqYpm2W7zvJzF0UdnprLQJW9nEGam6dUPARh02/SqOwVj
	 b69qyGdJT3bBhorwMAETctgv5FiyPI/nb21tsOzrDlNiIU6qxh+AuqDDGT1lK4RhLkHUmWhbTZxq
	 gtUv1HorOmG/WqavZRjXKx3effyzCk6EP2yDtVNVimVS9OZKJTkcHptpbW/dITgg1RsL9LM2TAJC
	 qtngSfxg2seKftLcOVd5HmFqySkEhdHmw9N2ooGB6DNHf4Gd+Z9jZd1viwaKCEBqn84CIA7OMe3v
	 EhoKBJqDiFOxoNDhw+k6jWqbdOhUwMeCKM/975bdkwqR5xFQ9+chi9zPvdyJRSQTzC5pigYSPPIF
	 FXHtxzrWe6vbQcQBNW1gsC9V625JB/vr/nQGurzb/vYgpuXpwttrJD5gn42Sy0I8sJLNTLAFgo3y
	 84s2G4/I0Ixr24i///RqTgAom9E5APcBeywcYA73pEYlLeMziGY9p2EzqSGGJ65JFCqnrWeK21TN
	 QpElVlz0ftTL7xEzD7k9ZmTKGof/9Lp1D8NMNmtLO5lomMESbMCJJXdatk/cuQmSEGojxYBGFPJ/
	 U7VKmgYgCqoGCQqFdw5ZveCTNsLM/eH/fjbaZV9Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 3/9] rxrpc: delete these unnecessary static variables n_65535, four, max_500, etc
Date: Tue, 19 Mar 2024 23:57:44 +0800
X-OQ-MSGID: <99e5c01e90cdad6dc78ae62d08bd3c47fe53974f.1710863674.git.wenyang.linux@foxmail.com>
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

Delete unnecessary static variables(n_65535, four, max_500, etc.)
and encode them directly in the table entry.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 net/rxrpc/sysctl.c | 169 +++++++++++++++++++--------------------------
 1 file changed, 70 insertions(+), 99 deletions(-)

diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index ecaeb4ecfb58..26ec6eff8402 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -11,15 +11,6 @@
 #include "ar-internal.h"
 
 static struct ctl_table_header *rxrpc_sysctl_reg_table;
-static const unsigned int four = 4;
-static const unsigned int max_backlog = RXRPC_BACKLOG_MAX - 1;
-static const unsigned int n_65535 = 65535;
-static const unsigned int n_max_acks = 255;
-static const unsigned long one_jiffy = 1;
-static const unsigned long max_jiffies = MAX_JIFFY_OFFSET;
-#ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
-static const unsigned long max_500 = 500;
-#endif
 
 /*
  * RxRPC operating parameters.
@@ -29,102 +20,82 @@ static const unsigned long max_500 = 500;
  */
 static struct ctl_table rxrpc_sysctl_table[] = {
 	/* Values measured in milliseconds but used in jiffies */
-	{
-		.procname	= "soft_ack_delay",
-		.data		= &rxrpc_soft_ack_delay,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
-	},
-	{
-		.procname	= "idle_ack_delay",
-		.data		= &rxrpc_idle_ack_delay,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
-	},
-	{
-		.procname	= "idle_conn_expiry",
-		.data		= &rxrpc_conn_idle_client_expiry,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
-	},
-	{
-		.procname	= "idle_conn_fast_expiry",
-		.data		= &rxrpc_conn_idle_client_fast_expiry,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_ms_jiffies_minmax,
-		.extra1		= (void *)&one_jiffy,
-		.extra2		= (void *)&max_jiffies,
-	},
+	CTL_TABLE_ENTRY_MINMAX("soft_ack_delay",
+			       &rxrpc_soft_ack_delay,
+			       sizeof(unsigned long),
+			       0644,
+			       proc_doulongvec_ms_jiffies_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       MAX_JIFFY_OFFSET),
+	CTL_TABLE_ENTRY_MINMAX("idle_ack_delay",
+			       &rxrpc_idle_ack_delay,
+			       sizeof(unsigned long),
+			       0644,
+			       proc_doulongvec_ms_jiffies_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       MAX_JIFFY_OFFSET),
+	CTL_TABLE_ENTRY_MINMAX("idle_conn_expiry",
+			       &rxrpc_conn_idle_client_expiry,
+			       sizeof(unsigned long),
+			       0644,
+			       proc_doulongvec_ms_jiffies_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       MAX_JIFFY_OFFSET),
+	CTL_TABLE_ENTRY_MINMAX("idle_conn_fast_expiry",
+			       &rxrpc_conn_idle_client_fast_expiry,
+			       sizeof(unsigned long),
+			       0644,
+			       proc_doulongvec_ms_jiffies_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       MAX_JIFFY_OFFSET),
 
 	/* Values used in milliseconds */
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
-	{
-		.procname	= "inject_rx_delay",
-		.data		= &rxrpc_inject_rx_delay,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (void *)SYSCTL_LONG_ZERO,
-		.extra2		= (void *)&max_500,
-	},
+	CTL_TABLE_ENTRY_MINMAX("inject_rx_delay",
+			       &rxrpc_inject_rx_delay,
+			       sizeof(unsigned long),
+			       0644,
+			       proc_doulongvec_minmax,
+			       SYSCTL_NUMERIC_ZERO,
+			       SYSCTL_NUMERIC_FIVE_HUNDRED),
 #endif
 
 	/* Non-time values */
-	{
-		.procname	= "reap_client_conns",
-		.data		= &rxrpc_reap_client_connections,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_65535,
-	},
-	{
-		.procname	= "max_backlog",
-		.data		= &rxrpc_max_backlog,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)&four,
-		.extra2		= (void *)&max_backlog,
-	},
-	{
-		.procname	= "rx_window_size",
-		.data		= &rxrpc_rx_window_size,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_max_acks,
-	},
-	{
-		.procname	= "rx_mtu",
-		.data		= &rxrpc_rx_mtu,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&n_65535,
-	},
-	{
-		.procname	= "rx_jumbo_max",
-		.data		= &rxrpc_rx_jumbo_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&four,
-	},
+	CTL_TABLE_ENTRY_MINMAX("reap_client_conns",
+			       &rxrpc_reap_client_connections,
+			       sizeof(unsigned int),
+			       0644,
+			       proc_dointvec_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       SYSCTL_NUMERIC_U16_MAX),
+	CTL_TABLE_ENTRY_MINMAX("max_backlog",
+			       &rxrpc_max_backlog,
+			       sizeof(unsigned int),
+			       0644,
+			       proc_dointvec_minmax,
+			       SYSCTL_NUMERIC_FOUR,
+			       RXRPC_BACKLOG_MAX - 1),
+	CTL_TABLE_ENTRY_MINMAX("rx_window_size",
+			       &rxrpc_rx_window_size,
+			       sizeof(unsigned int),
+			       0644,
+			       proc_dointvec_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       SYSCTL_NUMERIC_U8_MAX),
+	CTL_TABLE_ENTRY_MINMAX("rx_mtu",
+			       &rxrpc_rx_mtu,
+			       sizeof(unsigned int),
+			       0644,
+			       proc_dointvec_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       SYSCTL_NUMERIC_U16_MAX),
+	CTL_TABLE_ENTRY_MINMAX("rx_jumbo_max",
+			       &rxrpc_rx_jumbo_max,
+			       sizeof(unsigned int),
+			       0644,
+			       proc_dointvec_minmax,
+			       SYSCTL_NUMERIC_ONE,
+			       SYSCTL_NUMERIC_FOUR),
 	{ }
 };
 
-- 
2.25.1


