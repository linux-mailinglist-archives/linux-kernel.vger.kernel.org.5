Return-Path: <linux-kernel+bounces-101349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0087A5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEA11C21A44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E32539AF5;
	Wed, 13 Mar 2024 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="O2PI34iR"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974E39AC5;
	Wed, 13 Mar 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325673; cv=fail; b=pu76oVgU93x9uetydXV+4vOmqOk8AHsR9ABmTVxilonC2QE8fKwYkW3XCTO2glOk+wx6WN41wTT4YTGgzhU8eRpaIuR8RcnnnRVfYsLfWw4sQdbMvX4AaePHsCtkVctgwPPNnCqdWclBqt91U3cqF/NNSpEcLzEBMpzgdUutk+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325673; c=relaxed/simple;
	bh=7mdZEdyEmhu0MA4svxfOF9RPnqI4uFsajLyI2vgMrTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAKN7Abd14ZgmtueAi0GXE2Ba5P58tZYKeCH6hy0W+jb4RQp8ehplRxKEZZYOi++HxPzE9F/W1gOOlBsrioarITe9UJe7YJNCXsvay9/iiVsxlvKpHb17DaINfQbVMD/YmpLAw6j2npjqDqCIR4mcfDvKwi35rPq0ZjlYwKClVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=O2PI34iR; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nc1js9j4M4jA8u9OEvgM87/3F5xsgkD6j0zp5tG6Cdmfoljp2RUskZ2kRePske6a7EEg2iEb7SiNex7P9X5buKHZtpw8jEEe4e36w8U5jPquNNDEb2gOX05DKOqM/MqHGkSmLXkdLkkewomey5hDABxUMr8htEDJjlo4Bsbn9aBjN61z9tzPnUgdngTJgEs7Q2rW4uLWoRBEK4Xqp/X2D+aly5uSwRUgf7Zb2IHem0CdLiLcvX3sdaD1hYBtRhPVvp+XdLvnsrFQPtms7dXa6zLsduPhWUuYghqJe5Jg8SAsPcH2nhOxQoWDJzbMvQ0TCvOMjGNuS3Mn6MHwGNwbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkGjXogb3y/OurZ8HVAGup2vwhLqTcg2P0uDSDdk1ZY=;
 b=M2QF8Tmg4sTOjgCsuhzvEJg+LnadL3P9SsWQT/d/9p2GULOsK8Yj1NXj9+7TfYlcWXv8tWIzxNRMXN4JiONTjhQV7YhQgXbfCiHEddrnZ1iJmfdRdzxRgFOm6hTyUGVJddQMU+FjIR4HW9sX+ukgYiBucxfYcj/0Gsx4PRNMSirjsuMxkPEyInpvHhLF45BaXsBF3gLzfu4DPilwil/hMGjoeez8qmDS2BHYOnapY36uPxGkqttrPVzYu3JdDyu0KvUF/Rlsoa+EPogRzKKadx8U4h5IG8bVLz8AoS7yHUBTmnYO24trG/SMy9IlaSsSoG6PrZO+44VE/HjLm/tZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkGjXogb3y/OurZ8HVAGup2vwhLqTcg2P0uDSDdk1ZY=;
 b=O2PI34iRrDryfpDFY7GifLrpp5k0TE0qharsD9QJhDnINy+dz+l38PyI1W8AxkmlGAKDd9tgA17bFxQhoSZnaRNk2oOCvc59SD4UpDcgTKtacZr25RTZPm83bLXdWSIt6wUtmbmyly3XXRdSWu3/tY0t6zVUjQLVMMnsKqOtRPE=
Received: from SJ0PR03CA0102.namprd03.prod.outlook.com (2603:10b6:a03:333::17)
 by PH7PR13MB6512.namprd13.prod.outlook.com (2603:10b6:510:2f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:27:48 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::b9) by SJ0PR03CA0102.outlook.office365.com
 (2603:10b6:a03:333::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 10:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:27:47 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DARHuY022307
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Mar 2024 18:27:30 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DARGvN018463;
	Wed, 13 Mar 2024 18:27:16 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 3FDE520C069A; Wed, 13 Mar 2024 15:50:52 +0530 (IST)
Date: Wed, 13 Mar 2024 15:50:52 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v6 1/2] printk: Add function to replay kernel log on consoles
Message-ID: <90ee131c643a5033d117b556c0792de65129d4c3.1710220326.git.sreenath.vijayan@sony.com>
References: <cover.1710220326.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710220326.git.sreenath.vijayan@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR13MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bf26e7-99e6-41c8-17df-08dc43483ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P/4TyA7yZ6NKDw4dV15sGT8uG86OpBp8FC9KR8wV0E2eXQi90hlzRd7jlLV7bCwPZR9xlBfEMojGsDU/BazouXCbk/MDWKoGxiC9Dql1lhjxvsJHI1My6sZM/BZcPMwOuaGflTrmsGMp82tDneQvUuCtcY+fx/4PGu5v++m4waagP3T+P8OvFt3/2IgxOoX02G0XLb9N6/fEwRs86194CrOsz0w4HPxo4dru4qq98lWrc7OZfL3Y8BdgVzVD47sijXg7zb4vpNaf/wvIHGhZzZFqMXfQnuENnmMQPRUENYLInj7OgPWPw8FV2WPr0lFepuvb0mLibGh6kIwcA9n+zrqd089x8juntYH4yoQMKiKP2bD15Cbmd8W2IAVsZ12cESj/rRd31gKD8GvotHg6P8TMwAhg+7A7yHibYq29VJbaKs1mykSImkybMDS2NhbzOwFgrbKi2XYXYImtHqajSan4ehAj1YPlFieRx2+nxw/wUeURvyqOhPaGKWsGYTAELOR3YjKHhchsgsMLUQUe49YFKpgth/blC/D1Rd0HvNkauI+uEZeo1LMgq+XRcWqPwK3fvwvGkxN9BsXWykXCyVmVpk3+hl2o2Get1fCPU+NQov8CUlNQRZrMQTeNW+7vWi9Hs6IobO5XvEGrqWI/jGUL0XB/RxDAjGF0svZFo0QHRakdLu+QdY4xnT/xWoUxK49RsU4BRQwoVmcZ+peRNbR9WMLTpxExVObegwNUmP8iQT2Y9LPlCjAG6EmakRg3
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:27:47.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bf26e7-99e6-41c8-17df-08dc43483ad1
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6512

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
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
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


