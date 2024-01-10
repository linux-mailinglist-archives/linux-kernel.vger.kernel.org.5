Return-Path: <linux-kernel+bounces-21848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A7829530
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 069ADB25CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2AF3EA71;
	Wed, 10 Jan 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="CTj0PJjP"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2116.outbound.protection.outlook.com [40.107.220.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299C63EA6D;
	Wed, 10 Jan 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLC4to3/H2qYN0PhmHBAKvlKiEpZtwvIU6q0E97IUhy6qxd53U1f2m8kzdYSZmCybeZISvpzkgneywGCPawSbxxUriA1EVNfWxxkZuix89NHPEjdVb7WDegKxnQ6kJaqyk0F0hMgcjIc+a/7voM33EugaAMs7qWSZpnN1FAmCCO1XnhZZ5E6n0iisvTE3qtT+zdDvpJAB9rwl2RvBfrNWKa7i2I1tan57nMV3m36JrI/mBbxU85ucFKI24llP3FT3pj+1zWSLxY0vthngorgY1Ok2YiVheuJVXcIrtmAWKe6u4WHumrFKOh6X+JaTvnR4JP+Iw5FbqLZkTaFzCHldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp26z+uLeN7ydlt7DezirCNE6FU2m7ozzoIjD51MmlM=;
 b=F2mu63dok8ENRcbWY8X+D8KhwkyuSMl/fMHLYDONuohDL97izGFrP2Hpq4dJs7lKTq9EQmyw4eU3XfrKvi9I+ODvBn1PRrzhPtQS8nEaYEtJjotJNAe6C6OMnplJevYTi+LIkgtRmmO0PkhzHV7o6JYVHDI4YkvNSng+m2I/wRa3cFm6ngpbX8DDfaHts87TFiN6sxtnL/aA0uK884DHRTL1ueagWsJ0Vo7WNlT9+qiaDFjJ9NBjQG85c19jk/23xD/Xrro9L4ZmwIVhEAaMaK8ttdBjeIg58IafQ1r/8cs2kzHKfyOn12jbf5uHEmd1O6pDDQZqAJzBujp0xGJWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp26z+uLeN7ydlt7DezirCNE6FU2m7ozzoIjD51MmlM=;
 b=CTj0PJjPR4TGRlB7I0ZfB3Db5sPgvKku5LfNcRlbk+5+rrtsRP3FpWhxJKmZThWUuK2Gl/E/3yyJ2RR13pxJdcJZJI0bMpiGvw/I9Py9Y86fEVbbd2EMDWQ8A/det63vzD8EOqMs1cSLmuYqW+c4/60f8xqPvYKT57dNgBKqw/I=
Received: from SA9PR11CA0024.namprd11.prod.outlook.com (2603:10b6:806:6e::29)
 by SA1PR13MB4784.namprd13.prod.outlook.com (2603:10b6:806:18b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 08:29:13 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::cb) by SA9PR11CA0024.outlook.office365.com
 (2603:10b6:806:6e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24 via Frontend
 Transport; Wed, 10 Jan 2024 08:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 08:29:12 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40A8RWjB022818;
	Wed, 10 Jan 2024 16:28:47 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40A8QLi9030704;
	Wed, 10 Jan 2024 16:26:21 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 38B5220C1B94; Wed, 10 Jan 2024 21:27:18 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: sreenath.vijayan@sony.com, rdunlap@infradead.org
Cc: anandakumar.balasubramaniam@sony.com, taichi.shimoyashiki@sony.com,
        john.ogness@linutronix.de, pmladek@suse.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2] tty/sysrq: Dump printk ring buffer messages via sysrq
Date: Wed, 10 Jan 2024 21:24:38 +0530
Message-ID: <20240110155634.1685656-1-sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
References: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA1PR13MB4784:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ec94b56-db9a-443b-d13a-08dc11b639c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aKvrGjHr3aHP09QGUEt0/DMDcLwCwIp+j8kHyt7Kx6LO9r8vgj8nwJJhdyRU1TYc3gCw4hXaAF2a51kEX28nLwESnfxvY8ptAjEUZbTzyoGOFXsOItYf3G/XNK0pRTidM7zHHy5mRCdDb0PJEHJkuvFLnbvbAjHG01oMUpJ1zJTN1bUfJvrHRsbsQqKMqJhCpaRn0WadELAwooCUdlVOw+7jzv+yju6nzYbkUFajAzVdaSKjnK9/ZGgrTZ3qbv0/4ywE5dnmIWXT7sd0dqKVIrBWNvhOuMTAgxKc2wnsDil3roOcmYjqWRy+XIYBNNg/GIGH81LTn6GNgELADa1Av2yK96Xh3EKamViMhKlwW6UuKAS+Qb1XLB6t3/aBrx9vSndzriwaV7iwh/Ms6bVicwNpbCCLmGAYnVZ6Ww9sZjDNgQx8TpXBPBYLgFjPDwydR1xQi7pRvfQXYe1M8Tvgo7BRNjdNYSMKUSyT2dE5FmGR0YQKPFOn1FufJR1A+Tt0jTpspOn/J1yl5q1IyGtY92VCoF1SFijp/lGZX0T3a/q0IC3sBC+kusMQv6wpiNvu8axnnF4hiI1CQlEHUeityBDJFRCP7EPheIV6VAuGOWYkdj5EwP/mXv0XopRnMngP6SBP7/OXTv4I2Trm8DzlC/hqVVoVgmUpcxY5MpFlLK5xtW+WtSfqC2PwWnGRs2TNRaluQpfuhV2Aiw370Ig2D2QmZv+EkDcROD1U6cWyT0KUi1aNht1GEaC6NbG6tNmaeXVzCRdrJnSULRGAinCviZczZFmzjWGvzXSXdQnWsKOQRYNzww3hQK9Sx550dAFRpMq2m1PPm0UfGku1haxKvg==
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(70206006)(41300700001)(70586007)(36756003)(82960400001)(81166007)(356005)(83170400001)(82740400003)(47076005)(35950700001)(426003)(26005)(336012)(2616005)(1076003)(450100002)(2906002)(15650500001)(6666004)(42186006)(316002)(498600001)(8676002)(8936002)(6266002)(4326008)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:29:12.3631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec94b56-db9a-443b-d13a-08dc11b639c6
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4784

When terminal is unresponsive, one cannot use dmesg to view printk
ring buffer messages. Also, syslog services may be disabled,
to check them after a reboot, especially on embedded systems.
In this scenario, dump the printk ring buffer messages via sysrq
by pressing sysrq+D.

Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
V2: - modified kernel ring buffer to printk ring buffer
    - allocated buf dynamically to prevent stack frame size warnings
    - used buf of size 2048 to match PRINTK_MESSAGE_MAX and added comment

 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 49 ++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..c634e8b4cea2 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -161,6 +161,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``D``	    Dump the printk ring buffer
 =========== ===================================================================
 
 Okay, so what can I use them for?
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..62b3911f03b5 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,8 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/kmsg_dump.h>
+#include <linux/console.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -450,6 +452,51 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void dmesg_dump_callback(struct work_struct *work)
+{
+	struct kmsg_dump_iter iter;
+	size_t len;
+	char *buf;
+	struct console *con;
+	int cookie;
+
+	/* Size to be updated if PRINTK_MESSAGE_MAX changes */
+	buf = kzalloc(2048, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, 2048, &len)) {
+		/*
+		 * Since using printk() or pr_*() will append the message to the
+		 * printk ring buffer, they cannot be used to display the retrieved
+		 * message. Hence console_write() of serial drivers is used.
+		 */
+		console_lock();
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(con) {
+			if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)
+				con->write(con, buf, len);
+		}
+		console_srcu_read_unlock(cookie);
+		console_unlock();
+	}
+	kfree(buf);
+}
+
+static DECLARE_WORK(sysrq_dmesg_work, dmesg_dump_callback);
+
+static void sysrq_handle_dmesg_dump(u8 key)
+{
+	queue_work(system_unbound_wq, &sysrq_dmesg_work);
+}
+static struct sysrq_key_op sysrq_dmesg_dump_op = {
+	.handler        = sysrq_handle_dmesg_dump,
+	.help_msg       = "dump-dmesg(D)",
+	.action_msg     = "Dump dmesg",
+	.enable_mask    = SYSRQ_ENABLE_DUMP,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -505,7 +552,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* A */
 	NULL,				/* B */
 	NULL,				/* C */
-	NULL,				/* D */
+	&sysrq_dmesg_dump_op,		/* D */
 	NULL,				/* E */
 	NULL,				/* F */
 	NULL,				/* G */
-- 
2.43.0


