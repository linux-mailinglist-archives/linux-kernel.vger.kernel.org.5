Return-Path: <linux-kernel+bounces-28904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD983046E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FA728786D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D71DDDA;
	Wed, 17 Jan 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="W742/1UG"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2121.outbound.protection.outlook.com [40.107.100.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFE11D697;
	Wed, 17 Jan 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490489; cv=fail; b=UDq/7wkJYAdCQabe1rnsf5tGBMTc4zJQyrYXh+zeaCm/YC9bTYXUL+ql79+3lLrWHLB/wun2gQAFyhCMv58h/GpF5dIxryKBR7xHnMOB/d1X4OiIxCpfKrccMMY7p7FnhYRoKEeDvHro15eG2/UaYax2gfnHIdBF0+Vw8F/CVlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490489; c=relaxed/simple;
	bh=BCh2q5Tk2/R59h3MSewVzFJoLeEuMsWynLM8dyMpfA8=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=jxws8FON25ydWeT8+YStNdeUqxXVIAkAw635cxRzsAvZpSuKV3Z+1tnuq2PSVrdQb1qp1yVwF0HQCfGDJaaGQa86247C2+iVfEoMXKhW0QAvyG5nMmFwLuutyJtr/fPobhMAdOhJ9/A08Nsdipflu8zXQdRZrEfUrRmZ51D/xpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=Sony.onmicrosoft.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=W742/1UG; arc=fail smtp.client-ip=40.107.100.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Sony.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X53tbEx631u30xHyXgdcMcUg1s80YZwVEwNg/0yHIkitumL6RqGnZSUZ7Yr26h/WcmpUnV0rQsUx/hnolbTrpzOWbG1ECzWdMXvVGjKrDll0AqkBgMzaROS5cUDeZzJPSFhT3KsPnpGCQHgRt5C0p501GSoaZ2iNLVlaCDFCbl/ON69SLjOrCMoqInx5Dl2pLj13GxXpRKuoUkaZDEWwJK9RKv/yU/V7/Gv4eBt65eN8q39ulnSyfj3ibztC8IakywgSEgMCoGfR6SrG9MNKXf8qchmST2+SYplqN43gY8por/VwPXDi5zRo6EpNz7PWFP27mKa8su8aI3DxckA3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLRaZ2XnB9Rpbe5Pr/xd1PmmB0yRDEZ04eKbHFb+Ibo=;
 b=KiDoYUbQTlaGsj0bNxchPVHqfdvgAcjX56aH1Hxk2rLXJdR7TjEwTT9w29WeFuLdVSmH6adG9taMy3DQQEgzw+06q1OgiY6LtV5Z/VHUsI5gwDZNxY4iDYmCS6yXzKIEUoR6t0+914E1/rlbRfQPCOiT0YEghMqPLW6Cqt7m5z1rDbdJqwCrr5VXQiqCIugSujYgfZ3fnc+qdtaKs2q1VideaAWPQl8AYiTWAo597ekHBJE1KgbsLPcq2zG3gwAEBT72I4wTMF+bjPwBIWMlk8dGBB9lUQJy6tcl0DFBptU7G31gvRpbK7+ESkcCvTab90TPsneBdMyEF5Mq2D8yxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=mail.sony.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=sony.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLRaZ2XnB9Rpbe5Pr/xd1PmmB0yRDEZ04eKbHFb+Ibo=;
 b=W742/1UGxuSsmI88dqxEgWVa+AAHgjwyMVtXYVLI+xnn8doOBzz8BI3Zx8A3utglx1rsImabz1n7szM2P15dbcgA6m/CTqI++SOv62KZxWiNzj0MbvUWWgRLB7tVER4c1bDR6Ln0U7T4G/acVw6EXt5VsEgV+uGcHh2OM8WF0/Y=
Received: from CY5PR22CA0061.namprd22.prod.outlook.com (2603:10b6:930:80::6)
 by SA1PR13MB4878.namprd13.prod.outlook.com (2603:10b6:806:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 11:21:23 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::b9) by CY5PR22CA0061.outlook.office365.com
 (2603:10b6:930:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 11:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=mail.sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of mail.sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Wed, 17 Jan 2024 11:21:23 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HBL5YJ004733
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 17 Jan 2024 19:21:05 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 40HBFsxD021765;
	Wed, 17 Jan 2024 19:15:54 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id C59B920C0300; Wed, 17 Jan 2024 16:44:13 +0530 (IST)
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: john.ogness@linutronix.de, corbet@lwn.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, rdunlap@infradead.org, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        taichi.shimoyashiki@sony.com, daniel.palmer@sony.com,
        anandakumar.balasubramaniam@sony.com, sreenath.vijayan@sony.com
Subject: [PATCH v3 2/2] tty/sysrq: Dump printk ring buffer messages via sysrq
Date: Wed, 17 Jan 2024 16:43:52 +0530
Message-ID: <57daf43c5270f7532b269b9f0e90d126ca012354.1705331453.git.sreenath.vijayan@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705331453.git.sreenath.vijayan@sony.com>
References: <cover.1705331453.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR13MB4878:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 43f05b76-3282-4d73-3a1d-08dc174e703e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Q4fOTTI5kIXPzkJhxQMN/W+/70PFScFTjillhpY5FshjnSONS/w7Xp3BI+vOHAuh0+oXvC3yaucl07M8UywIqUsWWvssOODQ0tONzzBlovcfK7BDM2wjbohMNJ8TBwxgdeJtes/z75qMaJS6HoE3wNkMTUp/x0btUmGb++nv5FKCQwnv6DRUoOyP9vBBkJM0AlyrqrGMbK2l69zLEHexk1ldTPA9B4kDDB2erSXqL75c01hh90rHU214kBT0AJXOTSRbLCiwBaF6VPv43UzlV2TPtSs8qng9mb4beJlHsdtw2GG9dpUmSvXH3VwYWo/aX8DVT9pqeBiVrHNC+LY5y025E7DGVIHGOdogin9i0Gkuyo5Fcl0ZokFsg8ST1WvmQRUgZt8wkf6bGQ66CA6Crysgj1OiT4O5u9XA+9CPQBoxdSaMkd2ADQJElawmPNhEq9oytte7jM5xUa9/eO5swo+Lo4Vr0FZ+LF/ew/tJlBnJr8pDkBrond1r7TVeye1eHrIH0q9K/xFwRIyrwWECtzDy2yUNIjaRE8Wa5CfK3e4sD+OrZN+LjHdY++LaI8n3Bedz+SXWXhdm6mV1aIxVmafI7n44gERZOMhggnkT+KeBLvzzU7P0VVvzL8a+dVsBOuJOGP4FoYkfKLMOsunsek4/kHBPmSROLC7hkVjinp7nNCmHCfcVIUrDOoWb6Dv+BBLCpRwzvuf9oB9qwiR1mtzc4T9tohiu2Iw6mRs6fYTqChOFqAglDrq3UB8ZNqU
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(336012)(426003)(6266002)(26005)(83380400001)(107886003)(6666004)(2616005)(47076005)(35950700001)(5660300002)(44832011)(4326008)(8676002)(15650500001)(41300700001)(2906002)(8936002)(498600001)(316002)(450100002)(42186006)(70206006)(70586007)(36756003)(83170400001)(82740400003)(81166007)(356005)(82960400001)(40480700001)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 11:21:23.0594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f05b76-3282-4d73-3a1d-08dc174e703e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4878

When terminal is unresponsive, one cannot use dmesg to view printk
ring buffer messages. Also, syslog services may be disabled,
to check the messages after a reboot, especially on embedded systems.
In this scenario, dump the printk ring buffer messages via sysrq
by pressing sysrq+D.

Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  2 ++
 drivers/tty/sysrq.c                 | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 51906e47327b..246a7b61a0eb 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -152,6 +152,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``D``	    Dump the printk ring buffer
 =========== ===================================================================
 
 Okay, so what can I use them for?
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6b4a28bcf2f5..1976412706a4 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -450,6 +450,24 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void dmesg_dump_callback(struct work_struct *work)
+{
+	dump_printk_buffer();
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
 
@@ -505,7 +523,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
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


