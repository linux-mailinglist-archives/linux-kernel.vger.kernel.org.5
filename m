Return-Path: <linux-kernel+bounces-8510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B181B8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9421C25BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E37D883;
	Thu, 21 Dec 2023 13:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="hTdXKxLp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2108.outbound.protection.outlook.com [40.107.212.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46576DDA;
	Thu, 21 Dec 2023 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGe5GOouJOYOrfJw7oOTO6cPpgN1ULhj0Jw8wlBcvqMlRB02aE6gINqELbAkpY2IZt06/G5Sksm9rIaMT5LBVJ5HcLZXY0sOtv98rtitZcn+NWCjImAyldbKXwyzzKIOzNkNx0B6s2P+WhJsVE2S9YR3vBalz31O8y/OIGIJIWk4YMBDIbIhRjqk1yAbLKyyqqsIa+tGNyjnO+YtN8OOw8qMjase51/YWWNKd3h/qiG8FsCZMP4B37y8PTMpv5Edzp3Keo2MDrNK717pNOW3QUT6ZTfrtjlmI/7YahbXMTQxJbvlgoJpGEGpDihopauwwxoUMsdqdKlnHnntrnyQRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8XwtCSxGPzTQdHIx5TxffiqY0PWTaS/zWVcjiJ5q8Q=;
 b=BJ/LXBB4Mn1pVRYRxa91GgSLwvPwNaM7Uh9yrBSJi3BB4gTreVQhiKXMUtoBKRYD1okwzszNmED5iQLmVHpp1DUPM2ciz9dioAeDaID8v26edliJWUUNhR5nEs8elc9tTiqFKWNJj+50tKPmyslc5YOCGh98vg6d/sgRM49qng8AXA/nO1Vf2B5/kplAFZVV4bXQyL9pt2Lx80XJN89yLXtGC3w52K44h8okvjtcbNJrGLD98bTEg92UE40Walp3Phwxl3La7mhTeJxDdEL1soRsouYupcH3glqLDlG2sPnjJYCENHoPqiNcpgvMRU7Xy31NjVfcq95aHM/Ms1xczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8XwtCSxGPzTQdHIx5TxffiqY0PWTaS/zWVcjiJ5q8Q=;
 b=hTdXKxLpBlVBLxWkZmxby3XCiizxaEuxoGDMoQCjtvHwWqrVSItzX2Ybz+2jct9KN0F9WWmwwS5ZufFHQoftKRbsXUmGxAOiq0pLQjcn48+LNXsREwjfk9ZZQbn/n0VGRLDRBDKP832RPIbqQhHqYA4GJdr0/OJANmxNqRW3ZqA=
Received: from DM6PR02CA0153.namprd02.prod.outlook.com (2603:10b6:5:332::20)
 by BL0PR13MB4548.namprd13.prod.outlook.com (2603:10b6:208:1cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 13:41:27 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::8) by DM6PR02CA0153.outlook.office365.com
 (2603:10b6:5:332::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 13:41:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 13:41:26 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 3BLDeoI5021753;
	Thu, 21 Dec 2023 21:41:07 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 3BLDeGmO019292;
	Thu, 21 Dec 2023 21:40:16 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 3E87320C224A; Thu, 21 Dec 2023 19:10:06 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org, anandakumar.balasubramaniam@sony.com,
        Sreenath Vijayan <sreenath.vijayan@sony.com>,
        Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Subject: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Date: Thu, 21 Dec 2023 19:09:53 +0530
Message-ID: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|BL0PR13MB4548:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dbc1de9d-2385-4def-2bb5-08dc022a8829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PKWX52Dqt9dqXCxEa8S4g2LkHFdiCknGWnIiJ9fqFGzFCIBBc6G1iUXozUAs+fjdNd1u9QIhIvCHtjWZmyuibufPe23u/yfpgXycoAv9jLCSL1cWvQb8weYhk2G67ySWhTDkyit6y8vY/RY5N6h4/c7Nqj9z0PqkDHVVJFKGKjSoXUsQMcpKWYqiC1ZQmWBP0zNmfxMgwpJJm8gxy9YVFAPOgpolXxeadJcTY0VKSBKnPey+KXHQw6UpTEsCMPgYCc4WCCMfeiYMwb9e+na6iMvrSD2q1VRiYZDQYp2ogZxPRUndKQ1DZCtz5KBQZv+kWuu8+01vnhhASLpMDB42T73feZsOnL2fxjDqBIiQFcnD99Lqz+6Ik18kj3rn6BewH/0mUEfe2Yut41mX4dzgWTi5D8BbsBtJJxDkSWS4D91XSCXjm20jtlhxfmR4l+yMdZJoHM48Mre1y7+5ktE31/KH4pLwTl3YfrfngBOYqfn74XPJimfcAv7oeUcNZEI12pylpfNd7TPcuBFH18rkfR0ccHRT8W0xOCSHqg6hs5S3PtYsyhel7eI33H89cU0LmtOh2gxS5Cz8173t9mYS22PU68BAU93MoAiy0AB4AJ7QmFnbc/+FKuBjgyuF5yz1wAvQgyS3Oeo+CW2KxA9NyUxeKbp5YXfj27aRTkKakR/LxTfwk6dh7wXgSMlkzao/2SyL2FmIkdlJCcaszH40uLxDUakpp5pJl0JX/h8QmV+rgNZammuyO2u+lpZXAcH6
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(40480700001)(6266002)(26005)(1076003)(2616005)(336012)(426003)(6666004)(107886003)(36756003)(82740400003)(82960400001)(83170400001)(81166007)(356005)(35950700001)(8936002)(8676002)(4326008)(41300700001)(83380400001)(44832011)(5660300002)(47076005)(54906003)(42186006)(15650500001)(70206006)(70586007)(2906002)(316002)(450100002)(498600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 13:41:26.9174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc1de9d-2385-4def-2bb5-08dc022a8829
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4548

When terminal is unresponsive, one cannot use dmesg to view kernel
ring buffer messages. Also, syslog services may be disabled,
to check them after a reboot, especially on embedded systems.
In this scenario, dump the kernel ring buffer messages via sysrq
by pressing sysrq+D.

Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 43 ++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..464c4e138b9d 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -161,6 +161,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``D``	    Dump the kernel ring buffer
 =========== ===================================================================
 
 Okay, so what can I use them for?
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..aa43cb40c117 100644
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
@@ -450,6 +452,45 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void dmesg_dump_callback(struct work_struct *work)
+{
+	struct kmsg_dump_iter iter;
+	size_t len;
+	char buf[1024];
+	struct console *con;
+	int cookie;
+
+	kmsg_dump_rewind(&iter);
+	while (kmsg_dump_get_line(&iter, 1, buf, sizeof(buf), &len)) {
+		/*
+		 * Since using printk() or pr_*() will append the message to the
+		 * kernel ring buffer, they cannot be used to display the retrieved
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
 
@@ -505,7 +546,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* A */
 	NULL,				/* B */
 	NULL,				/* C */
-	NULL,				/* D */
+	&sysrq_dmesg_dump_op,		/* D */
 	NULL,				/* E */
 	NULL,				/* F */
 	NULL,				/* G */
-- 
2.42.0


