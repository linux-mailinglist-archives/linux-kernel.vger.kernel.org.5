Return-Path: <linux-kernel+bounces-47962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF184554D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9882853F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DE15B96B;
	Thu,  1 Feb 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="kgbHVF4f"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814DA15B11F;
	Thu,  1 Feb 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783237; cv=fail; b=ZXFZWA9iD1EgJiAid7xCA4ITSA3SbEEQzucYr6G948F1lnXKpScnxqGANkNioLoWmYeOWzpPtRVZCOUXcFIw124Ot9SxOq6TuWKsOMiLEdfNdGdBCiXgSucoc4NbAyZ/DCFKqchaCPQqkatXNpyj/FBL9ODLzUp+HZw8H+FXBsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783237; c=relaxed/simple;
	bh=dl7zBQiz00aLa3C0sBijvnGX2voXiyBV3JaHW0N3+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soyuoNjjV/gI5aVAhcvw/uqiEAutGR0pyuuo/GWg4klqHiuRHNpcrozVXsSTrOsTpPmPtjnsQzXjBEF2jlifvuKuHYH2sq7cL8DBAi/xYfPQoCLWCprJfj6WteKPr/nNYoGNt3GcRZqHBjRwR1o9RFnxe56qeFdvrha16B3Y7Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=kgbHVF4f; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3E/hMoxSbTPODboiunyGXb8KREJ5w0jfdD9n1tFFXdKmRnIUJOG5QgHq1GqQkYZ1bAZ6dZqX/ro7LcYFJp6OY4/twrtG1t1OVx6++n8MxwMUbCfTjjhK9DlI4lsppHjUAq51Nf17ceYiC4BSrbMQLIlBPOKyPvBajMDAMnkfmUoTv5qCE34wPmC97x5PnpBZHuvyfjRDD6Rh98dN257Sg0fGXexx3PNKxkR3rjwe7/RJqi8iKqAHKHhrPJLid9BExdVmF5AzpaN1FHQvqsvWzvbWMfBj4+62KumfR6hIzhaoPxRsDw4H8fOx9KuIk/dvz5HpAzjWDeZYD/tEJb39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd6UjDYFfA5A8Fc8/Kuhys73CC0xPe0nBcTw/c6LPAM=;
 b=g6StuBlHK51LKQkHmgpO9lGbiyPdmHNqQPb68dd6DD8BeQjlTezKctUD0zmvMeRCodcp9a1lshVzVb+QW+1R0CYVTXRdRJyYecEfyDZpNOMJEMy2F+1Zj0MfqIFtY7huu+54I2mFNbe8QTZFE16hE3GvwuX0UcxQF/xEMm+5ajrvneCho+jYChhIXGJ9TFQ4W6GgsG6ed4DrfI2Wb0Stw7OPRgNysynlcE6CmazE/G+0qtBHTM5q1jzNWtGOZ4/IXQezR/AwDzWXOERPvGF9Kdj/XvZoDfegFvXIeaHa+HrzGpGEYmxNb6Wd0A7II2dYasxLWkccj1oGuDiW4CTm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd6UjDYFfA5A8Fc8/Kuhys73CC0xPe0nBcTw/c6LPAM=;
 b=kgbHVF4fMGH0wG0JJGMj9vYkkX5YtgrHs7j89nYPrbM2IxdQc7kGQ3Zy4BNpk+zs0OwmuVhQTEl6Qkmqvo7dJ44wiCRBCnZpdnjmeerP+PBCnxj89/E33ukeFTHlOherRZ+MudV+fwzvwBSxfQPtMjWB3hevkRAvV6BflmBepQs=
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by CH2PR13MB3654.namprd13.prod.outlook.com (2603:10b6:610:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 10:27:12 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::a3) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 10:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 10:27:11 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411APj0k019868
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 1 Feb 2024 18:26:52 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 411APD0J010487;
	Thu, 1 Feb 2024 18:25:13 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 981C220C1C4C; Thu,  1 Feb 2024 15:53:40 +0530 (IST)
Date: Thu, 1 Feb 2024 15:53:40 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pmladek@suse.com
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v4 1/2] printk: Add function to dump printk buffer directly
 to consoles
Message-ID: <8cb5936021c5811bd03a6bc18300b1384009ac26.1706772349.git.sreenath.vijayan@sony.com>
References: <cover.1706772349.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706772349.git.sreenath.vijayan@sony.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH2PR13MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e083f83-8344-4e76-6574-08dc23105a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LIjYb8ztzIjwGQUQ5NTdayXHi79KU8yloHwTHXkdAzSHWl6TUbYGh+tC4ovMWCsJh/tane7egKgDBsgfvt5EXVfUiu/Y9LmCDiwmV/GpstABQTHNFd6+buPsNxoxGNLJy5mVilesPVRRhzSzBg+mOe5yUA7RIVYedEyDQzWJvWa7FEdzXNDQXWa+DCjmuvPKzLzRq/63YdDVSS/yp6RQX5A6wFx1reUeDPwF5yRmOpPVmB2sYD1g45wZpuGSAXgt93Iqqy8TFPegf3yULk53kGiKNzvpEOZvwLGf68lXQmAOOsNE0QRj+l92eAzRh9zvW8U1U/zb/rSskWLFG6ztNEHeCBVDOM84l2/VLxQcEB6nxRweMOVIGRHdEhpV5JBz0aycTFKH0gJ88ulrbCjzKJGVr3WnbdfrqZhe2+BFLamFaQPuUfAMB2D62DZ23kCnmgy6qEGoLy+NPHeAmk675hk4cKbJscgGKuGQ22ezC7xrsK+82glilHueMFbySOWlxJHrfpoWbSPMi9/PlPne7LPjOzJZQF5e85S7xM9UfX682Ny1eWAwVFuhhw9azHJY6hLm6BmbybTxnTf7+o9cko61cWCBws1AID+LrfIZYnI65dKu2aU63fGp+k9c3y3Gk5f5koEIJ4SOyCzizsX1D9q6FHCPk4BKknYjeXj8cRj5vcJ8w4/NvF7ZGaqB+tfRY6GJ6YN0avER9mibToibmxA7fwGMYEWE9UcIwmSp3bneGNSeL6uZhSSY7MsjhDBB3RcT+IzhnbCDSJpdry/+yA==
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(44832011)(107886003)(2906002)(6266002)(336012)(5660300002)(2616005)(26005)(70206006)(426003)(42186006)(316002)(8936002)(8676002)(4326008)(47076005)(450100002)(41300700001)(82740400003)(81166007)(36860700001)(478600001)(86362001)(356005)(36756003)(82960400001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:27:11.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e083f83-8344-4e76-6574-08dc23105a31
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3654

It is useful to be able to dump the printk buffer directly to
consoles in some situations so as to not flood the buffer.
To do this, we reuse the CONSOLE_REPLAY_ALL mode code in
console_flush_on_panic() by moving the code to a helper function
console_rewind_all(). This is done because console_flush_on_panic()
sets console_may_schedule to 0 but this should not be done in our
case. Then console_rewind_all() is called from the new function
dump_printk_buffer() with console lock held to set the console
sequence number to oldest record in the buffer for all consoles.
Releasing the console lock will flush the contents of printk buffer
to the consoles.

Suggested-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 include/linux/printk.h |  4 +++
 kernel/printk/printk.c | 61 +++++++++++++++++++++++++-----------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1e..861ff5a545ff 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -192,6 +192,7 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
+void dump_printk_buffer(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -271,6 +272,9 @@ static inline void dump_stack(void)
 static inline void printk_trigger_flush(void)
 {
 }
+static void dump_printk_buffer(void)
+{
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..b05ca9f98e53 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3134,6 +3134,32 @@ void console_unblank(void)
 		pr_flush(1000, true);
 }
 
+static void console_rewind_all(void)
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
+			 * This is an unsynchronized assignment. On
+			 * panic legacy consoles are only best effort.
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
@@ -3162,30 +3188,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
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
+		console_rewind_all();
 
 	console_flush_all(false, &next_seq, &handover);
 }
@@ -4259,6 +4263,15 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
+/**
+ * Dump the printk ring buffer directly to consoles
+ */
+void dump_printk_buffer(void)
+{
+	console_lock();
+	console_rewind_all();
+	console_unlock();
+}
 #endif
 
 #ifdef CONFIG_SMP
-- 
2.43.0


