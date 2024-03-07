Return-Path: <linux-kernel+bounces-95564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E865874F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65521F23590
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059412BEBA;
	Thu,  7 Mar 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="TN8Au/bg"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEA1D680;
	Thu,  7 Mar 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816646; cv=fail; b=LKGvSPNmQOvqiTYyQVghFkki7t/h3RzxTxl1HTq5lkTuFXmimdNQTVV6TFa2f3SmhHOoGEmntooHzVF1gFMQFDOFrbTXD2MHZvOa/txTkk95htc+qGB6VDh5W8GRBCE7WxnsV0EIXrp7pJ8YUBG4e68AYqlXQrhHUoUbmWa262c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816646; c=relaxed/simple;
	bh=Xh/c9RjmLyxJvBnciLI+8V/U4PdTzrLWNH6fbTg7OxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTgVhB1loMmGcWnpXXdxitbgrRil0DCOFFSCZjPnCwQxaGoGVxsB2sXr4Cx0E9tDMSOqbWcKPmskEWP1Kblyj45dGtE3a4AhWgmp0ywpsiRYRHhSZhGILoUeEubqXhnhcAPsu80+DsAB/BYUXMs1ozzTYLGYE6PEuB3kZt9vLMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=TN8Au/bg; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFkXXUF3Jo1FjMOQfhBpnL3XXti66q0uzVZlG9DLojEsYox6/T0k1FNjXko6ZnvJZE3Ck5uTymqOAqM2w2Hj+jgaFboD0g7kCvZKFFAB0XwgGp+JR6xqR1HWgA1K1OklWOB5xHKz/PTAutRiu0JSleveBZQudhps8lT12OYHUYd+Cd4quClDEoaQnvfQ58SAgkaklSReRqJ+lWkm2nHaCmQOkpcFbBz8VBf5uhyQUnGktGMesYVJLeQXBhILEAkGE+r+OVB/wCP3WCDNxQJfc+3d/v3URHg3FymcuuQjnHLBwL2eE1nxpqGjh0tY08WPz5l1W99Ad9D37Xx++3pcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41uFhNyJnV5dNdTqvnpQsAPsEhpYnin366tB4YwVud0=;
 b=QzJZl5v1Ki1We2YLspmGA+rpzFBxnp909EdYug8tmRx1/YOOvw0MFMmziKJsUT9gOSoglfBlDF2Xg3MXj6ZYZXShR6mLll6b3pRpwCjFF90snVyAxwYdwHr9aPGMQq2AXl2CWWnrLvb3uHlJLLerGhRRYIuxyacun9FClZxrEITiVgZWmoWq+qM/G2NjaIxIVB2hjPuqY8kjHSdvZYPNf5t3xBbixbDmhrR0cCzXr7o9jmaGM6drDuAcCzfM/EtPdzkw06Z8ZvrKyNyTW9Q+zbJw25wHso4EBb5pBNoCfzLx7M5JipJzWSAZapJ4D0+74lDSIpjHsOaywxibJJV3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41uFhNyJnV5dNdTqvnpQsAPsEhpYnin366tB4YwVud0=;
 b=TN8Au/bgSIWGrCft63simGS8ITEDFpGOQNej6hgK+2r083vjG9d9Vdg8MxrzHb9eI1/ikh+gXN6ux0dqzJqD+pNwnxAkS0R4jjW5Jn1BIQgLoDUwV5YYn+Q3C72LWRBoSz8wcnpgZU+N0Lj79WWaS5xYRPAPby/Xq7aVDbiplfM=
Received: from SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13)
 by SJ0PR13MB5845.namprd13.prod.outlook.com (2603:10b6:a03:431::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 13:04:00 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::40) by SJ0PR05CA0008.outlook.office365.com
 (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8 via Frontend
 Transport; Thu, 7 Mar 2024 13:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 13:03:58 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427D2A7x004570;
	Thu, 7 Mar 2024 21:03:41 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427D1b5v032552;
	Thu, 7 Mar 2024 21:01:37 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 255EA20C0687; Thu,  7 Mar 2024 18:25:11 +0530 (IST)
Date: Thu, 7 Mar 2024 18:25:11 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v5 1/2] printk: Add function to replay kernel log on consoles
Message-ID: <7ca188a59ef016c7730031c10f072d478434c04a.1709277332.git.sreenath.vijayan@sony.com>
References: <cover.1709277332.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709277332.git.sreenath.vijayan@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ0PR13MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: fa40011f-0ce7-4e72-b4e8-08dc3ea70df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dUMNtcmIOG8+N69cut2u8HwkMyUocD/APPtQIssSJE8AvbXymzL/SxibhRgc5qp8GV45gp+HfhPBbGHaz7hh7SjFM8HhCu3ehmsMtdGrKI272u7mIY0XDJ11jvKcKYrCiV9xP9qc/vyKI77KBhyONZOxX4XwL+7TcadVb9Sm6pRg0yaeZ4TgVp1bq7Idqg0bLd3Osdhy3zh0ve819h6VnRwDs1qnA+eTW2+sXdu84qBGyOlp8o9AsCBoWigtlzN8UGFt1Sjf8W2EzlSG74egC/jY1UNCrpBB9+AuA3hz2ijCLB9e+DA5OlDhQv95AEUiCDsGe++SiTWQuVeei4dFfSwYcdoN8dFpDR8Lj+zdVfYa5oGEXtLmCILs9K+oYCICGtKz0ATzJQLsz7XU/Uj4BNZW1KB/d0G2MbaupOb/V1wpJxJmEousHfhGKRTfYHln3opiUR7LTXP5mBlbnf7WPZXtggde5JElMZKM3ihmWN9RgOYLj1dnZUnE9n2vxXptrkCj0S9mTEWTlyCo1n4Gekg49lFST9yDZ5TKq8G1IJgtAjlhsqL72TeKKspWCazEcjmKY7nXc5UiOLM1LapYzph3OaDAsyjbsu99W79T4buwnAo7/L+FuvjAoRgUThSKztES2S4UaXc1TYvzOuJUaf0cE58iomGVEv6cf3zScYwXiV8HS5+nYhhUhe572tou+BkQkC0jDG/VA96fnHwpNmy3c2B0YIFiF4wdpm80i/WBdnU6VBJepkMMHD2To6LO
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:03:58.8638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa40011f-0ce7-4e72-b4e8-08dc3ea70df0
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5845

Add a generic function console_replay_all() for replaying
the kernel log on consoles, in any context. It would allow
viewing the logs on an unresponsive terminal via sysrq.

Reuse the existing code from console_flush_on_panic() for
resetting the sequence numbers, by introducing a new helper
function __console_rewind_all(). It is safe to be called
under console_lock().

Try to acquire lock on the console subsystem without waiting.
If successful, reset the sequence number to oldest available
record on all consoles and call console_unlock() which will
automatically flush the messages to the consoles.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 include/linux/printk.h |  4 +++
 kernel/printk/printk.c | 77 +++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..8df2ac6c0e1f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void console_replay_all(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +272,9 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+static inline void console_replay_all(void)
+{
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..9e38cf0c1002 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3134,6 +3134,40 @@ void console_unblank(void)
 		pr_flush(1000, true);
 }
 
+/*
+ * Rewind all consoles to the oldest available record.
+ *
+ * IMPORTANT: The function is safe only when called under
+ *            console_lock(). It is not enforced because
+ *            it is used as a best effort in panic().
+ */
+static void __console_rewind_all(void)
+{
+	struct console *c;
+	short flags;
+	int cookie;
+	u64 seq;
+
+	seq = prb_first_valid_seq(prb);
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		flags = console_srcu_read_flags(c);
+
+		if (flags & CON_NBCON) {
+			nbcon_seq_force(c, seq);
+		} else {
+			/*
+			 * This assignment is safe only when called under
+			 * console_lock(). On panic, legacy consoles are
+			 * only best effort.
+			 */
+			c->seq = seq;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+}
+
 /**
  * console_flush_on_panic - flush console content on panic
  * @mode: flush all messages in buffer or just the pending ones
@@ -3162,30 +3196,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 */
 	console_may_schedule = 0;
 
-	if (mode == CONSOLE_REPLAY_ALL) {
-		struct console *c;
-		short flags;
-		int cookie;
-		u64 seq;
-
-		seq = prb_first_valid_seq(prb);
-
-		cookie = console_srcu_read_lock();
-		for_each_console_srcu(c) {
-			flags = console_srcu_read_flags(c);
-
-			if (flags & CON_NBCON) {
-				nbcon_seq_force(c, seq);
-			} else {
-				/*
-				 * This is an unsynchronized assignment. On
-				 * panic legacy consoles are only best effort.
-				 */
-				c->seq = seq;
-			}
-		}
-		console_srcu_read_unlock(cookie);
-	}
+	if (mode == CONSOLE_REPLAY_ALL)
+		__console_rewind_all();
 
 	console_flush_all(false, &next_seq, &handover);
 }
@@ -4259,6 +4271,23 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+/**
+ * console_replay_all - replay kernel log on consoles
+ *
+ * Try to obtain lock on console subsystem and replay all
+ * available records in printk buffer on the consoles.
+ * Does nothing if lock is not obtained.
+ *
+ * Context: Any context.
+ */
+void console_replay_all(void)
+{
+	if (console_trylock()) {
+		__console_rewind_all();
+		/* Consoles are flushed as part of console_unlock(). */
+		console_unlock();
+	}
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.25.1


