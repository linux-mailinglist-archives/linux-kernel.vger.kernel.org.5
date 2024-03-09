Return-Path: <linux-kernel+bounces-97844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FE877070
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813D3281CB7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16389286AD;
	Sat,  9 Mar 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="DHCXEYDV"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A64125DC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980327; cv=none; b=jpbS489U8WWdDOS3wNdrWO3MY6tK9GzYxfQT3AC6AsjJfry2XsIz0X/ZyrV5mkdDsd+kPVF8/NUE3wOuSAsMET90VpommvfOTSBnnzYVcW/7MnlRhTSXbHolz0jIPSlXsHlyqKa8hLXOlzz4x+VEOjD3nYV6U3AAAtCixLRPvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980327; c=relaxed/simple;
	bh=9Gz2RXz51oHRw8OR/4Cz4VUaTiWu8pStV9bUPdYwH/A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JLuIDNRgcPRnWozYvksC9Rxkk5SYmwX/coLOcZNCoNvSDqIFkuCj/WVyNBfmJ4Z/8Okf73NAFjaXkWD1XT++IJjRQkpMXdKxzCeszOWT8sHGwXWCqSkZbk9aifnwtPBi8TSzjJ8OUGCgNlA93GhMrcFQhckWnPZV+CFHCP0GfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=DHCXEYDV; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980322;
	bh=pzUshAmwIhfns0JHddsR8oSXiooWQ8z0An7EKzxYuC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DHCXEYDV4Tv6o7ZSU0ajiGHqpTOrg8n+C1rt7I9DaDztLppGL5VykMwede96gikRG
	 H7uDSTr22RM+BcAu/DK2ZV0j4fEh4UjTZjRyWrbAVj9DV6T+5Pehgw6KeaD7+KNVMx
	 Bklj3PL7M46G4TS/ItcvLEXaejCvxY/KenqumACE=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980317tc1clnse3
Message-ID: <tencent_C7DFF5F3429508354390FDA4487A15F3A506@qq.com>
X-QQ-XMAILINFO: MOwr6TNsEdeBaFuGYQn6N6N5DE6victwVjx6SYJUhQk2/KEqC1f9KqP1J1vVNh
	 9E4tl4A4o58EWyvfGqQmxbBQAUD8sspF9haa4ySYaYaT/Wtn/FZamP6S1GVz1nxwtxH+7zVnhfNT
	 b10igqksu6avnjW+OQZcjRjsBIHGb/Dd8CGTSd0DuvHHfmi7ugA5Cp69SOQMGGP+jNqE271FQrXN
	 RhZJ2z46DUu+I0zLp0/zHt2Ld5ZTGELPNr2qZF3VWKoKAFQXDtCvwD7gCM26yz0tqpsX40wzB/zJ
	 1PaosVn/Ce/zwF6XVyXyL2DXBiShDshvD26dXPMrcVX6qS9GnJ7kSBX8rCi5nycnH9FILvwGRu8c
	 afGCyP4c9TpOGy9J173kAICuP03KBgI2FTP9td2U47NeIaYCNxWXJVlZiMJPQcmHwrym7aJB+Z2x
	 nAm8FjV9ABjhbnwVwXSLUf/MFjjn4s6EjqmQ3gyJer95GDXhyOl2oaNbwHm+96Wf4m5Vl8l/sIJ4
	 BaHVzyTLO9zitqrQlMo6Dw2dpKN++07hmefXTBOu/2AR0VPKNGX7SepvlCt97t3GSfQ21j4oSF9G
	 IyWqclpqjShpQAZcpxkomzJvm/4XnEM6xRJAKScC+0GY+OWCwmF9I4PjIUsmKDc8lUq2SjovngEB
	 GO/H5Nr16vw+wr51ScYg0aorxPN6gFOfXPhBVFMHUNCGn66aFT+GR2nM1uZ6PEXDqJUKOQgT07do
	 q9rQ/Fk3du/kRV5CLFAYZesfv47lCf93lpllZPMjxnDNoKB0zwUF/l7GQoRbGEwQxx8Xtnx3JaT7
	 5qKFy1DnBaS+Lna4nPm70lulZ51ixMZD5o/VAbkd7MVQ8EtC9bqpXuiCEPYVIe9C2qoA+wjMnNCw
	 6OszVBLi7Rk7bQOuxNNnhy8uPqa1F3YRK7XjdyL1zeZXRbMeV857lC652QmubnK11IMcIcNh672z
	 hJY4e+GnM0n2svGP/AKvsoKKwzU889TFhbjllBwrXM0stztFXRU/EjM5Cdw7XASrGUknZwQzfM2E
	 G6pCggPCADxgcJekK7HHB223gvW6bg80kJO4slRWVoRX6GdKt91CAKbfBnTN78RBPMcFfugQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] rxrpc: delete these unnecessary static variables n_65535, four, max_500, etc
Date: Sat,  9 Mar 2024 18:31:20 +0800
X-OQ-MSGID: <c46b595b880e655e52db427bb0ba2a130595c2d8.1709978655.git.wenyang.linux@foxmail.com>
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


