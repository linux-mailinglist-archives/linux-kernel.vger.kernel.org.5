Return-Path: <linux-kernel+bounces-95573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE25874FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E041B1C224BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26C12BF03;
	Thu,  7 Mar 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="cJ3HZVCa"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB5F12B141;
	Thu,  7 Mar 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816887; cv=fail; b=E1HRvtANwIHqJ8Ga5LMJEMzattYWi27vy5cXW7uwED9evpKLVtDacFamQ9Ia03FnhLNqcZIwGmu0EaUNk7Noc9Ln4R2SKqSF7Kv8EzSb9GBm8POwMNckhgJj4bFAyfU7NVALjDvpu/WIZOJdCOGbpCDGHqDdSrImPNeEc6jdbjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816887; c=relaxed/simple;
	bh=fXYwY8E4kjwRMfO5iYy9stk+qoWzPJKSXKg4B/4wtOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7iJMa/1u29TFGKhJ5g+H74Sh3XoPdyrXFI8mFqbdcAISFn/lnriQfGUlSDcuc3xHHxvsEAJtMW9SJiZp3W8EWtu4I6ED/b/KYyDyxvEDaTPNmfRB0QHBlFqhgKavYOaB32DVpB6Q3lcphHCRpONj6ltv6Tx4YgvLw4ZfcQi8/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=cJ3HZVCa; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6s77I6XgKZLmEMz49ZG7Uwq+nwgSx4FgOS+beDd6Ry1yUVPuQU+EFs6Blgl/1VJBfctzll2D9ALf7OuO5lRLJ9YQv2lFW5pR2poKLf1F1OfMqTM9gFIfnavr8MspYLLsuketjKtwgLxQp/TLHaoa8KsRBpyJdGCHZ1EXwkUDMrD17VF6H+NeYSWBPYEmrGvbYzVmJCUwSiIJt6SBRoY0z2OFa5HurudF0316O2l+EeC+GOrgeT6d3aR3/zlv8vKW95Z+BWsD7e8sLTbb4xcSCFhHvwZ33pmMcCJP8ni3e0xIgTe7iPQ7Tk/mS7MnsHs+o3mPQ3h1WvyO2I1KDiFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ij4iF5rOPAZzFwjp7vIZA1hf4Y/j5ioiegmA69B8UZk=;
 b=JDSGWZCWwy1wNpXGfaXiKxFs2xgJ3lpxHEE041x24sFoNBsn9xWHME4hOxQ3dqT4hA4W2C0ZnsEdrvwhgL519HUE4CsDG/m2AcyZ2eGJ6L9TFoZ1yqGIY4e4QY2Pe4KIkllVzRRawjatbMXi0pisIDTO4yActjLMi5ZO0faeYrvTn4S46NwiEe0SQvDVDoqo4nLEBp6bV2uaDI6YkGKqD1BeoxtgLgEmyf6l66lL2gys3aOVKS73WGk02v/GE/fXEUy3POKlIDJMjqrdH8wUX/v3K4lRHJBbV25tp2QrVX1NXO/wZMldFyM3gjEk35G6bYkkRpuPbpSbZ1AVHIF0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij4iF5rOPAZzFwjp7vIZA1hf4Y/j5ioiegmA69B8UZk=;
 b=cJ3HZVCaHJ+JoIrttbQcuFsvZNzmRSvtH6clATk4wb/shsk6lzQ6ebR+dMJOXBPPhaNcG4NxjP3BEx5DDuyQS/CPoEMqE1ZRv87r5+9pn2Vtosn6DRbaT+qts55wSMY32Zz8krvKv4cNVIBn6tjU8U1HPJhpAAg7ZJW6pHDhxqo=
Received: from BYAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:c0::28)
 by DM6PR13MB4445.namprd13.prod.outlook.com (2603:10b6:5:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:08:00 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::31) by BYAPR05CA0015.outlook.office365.com
 (2603:10b6:a03:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 7 Mar 2024 13:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 13:07:59 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427D6A3t005712;
	Thu, 7 Mar 2024 21:07:41 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427D5bRn001636;
	Thu, 7 Mar 2024 21:05:37 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 7CE2720C0688; Thu,  7 Mar 2024 18:29:11 +0530 (IST)
Date: Thu, 7 Mar 2024 18:29:11 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v5 2/2] tty/sysrq: Replay kernel log messages on consoles via
 sysrq
Message-ID: <bf9829e1b3785aca8b7e2d018fac0935522d00dc.1709277332.git.sreenath.vijayan@sony.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM6PR13MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cd797d4-4c5c-43b4-b437-08dc3ea79d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	osa+gW/U++IgEtF4D6Rx5TEgfJJg9KDeUoOL39b32B7R2KclV9annTPpkBTy0TAVSinyah3CulSM132CCkVK+pwjktCtj7x7dfn8LTHLHs4wgQvfi+n3c/6kRZi+k9MypRlOLgrNNd4IQN8LhTOUwNl8ONwf3UkDcvmj26scIgkTAjZvlYtGGp1Oi/2AIW/VewCptoddOCeQ0FhrALdXm44Jcn5yJMzrEbqALKVyzXmc8POA3cAWds1vGiq/+2SB5+fBam2bIxUnKFwf/jrPFPH93iltYUqwb6q4OIHfnG4YSQcf/HIIPEAOGTKVhal5jWWm3A50D93981Ce3xQVrnli8ma6P5NNXvNXkBorvCkqEPGYDDImG8RaXLhhPSDgg6D3kbLZ4dvX1Xcjq8E3uQOP2W3lwl5Z2DdT7itTg4DgJNH+CTyYSDGFuUb/2Ra7FaXBSdVyoSV6B/t0CjhB7A9rb0QCcPCBR8vTeuCNfHD2CmFHnr9EAvd3UMUlpf+bZC9phll1XLwIUwCCbkZb+MvlsQuO93X8fEA7DQS93dkd64kDh9DbumlJB/oph3HLrSkyXNNNiVMERQUy87tXQRPLc/QgzRPBCDH3VGSSJGEcxhg4YNDuzqFAOitZwmn4XFu7wdhV7J4KfZXhGfb4RrP4HqoRa19x+BCUwuB2jMnQxz0dNat8Z2AW70Kyd0XXuxAdLSnX+Xi5x0ssX1U3jT/Er7efgUf4rR8CtR0Y+fv43uNwbSpk7K5YuiUEhGMu
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:07:59.2513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd797d4-4c5c-43b4-b437-08dc3ea79d3d
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4445

When terminal is unresponsive, one cannot use dmesg to view
the printk ring buffer messages. Also, syslog services may be
disabled, especially on embedded systems, to check the messages
after a reboot. In this scenario, replay the messages in printk
ring buffer on consoles via sysrq by pressing sysrq+R.

The console loglevel will determine which all kernel log messages
are displayed. The messages will be displayed only when
console_trylock() succeeds. Users could repeat the sysrq key when
it fails. If the owner of console subsystem lock is stuck,
repeating the key won't work.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  8 ++++++++
 drivers/tty/sysrq.c                 | 13 ++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..8098a1b4908d 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -161,6 +161,8 @@ Command	    Function
             will be printed to your console. (``0``, for example would make
             it so that only emergency messages like PANICs or OOPSes would
             make it to your console.)
+
+``R``	    Replay the kernel log messages on consoles.
 =========== ===================================================================
 
 Okay, so what can I use them for?
@@ -211,6 +213,12 @@ processes.
 "just thaw ``it(j)``" is useful if your system becomes unresponsive due to a
 frozen (probably root) filesystem via the FIFREEZE ioctl.
 
+``Replay logs(R)`` is useful to view the kernel log messages when system is hung
+or you are not able to use dmesg command to view the messages in printk buffer.
+User may have to press the key combination multiple times if console system is
+busy. If it is completely locked up, then messages won't be printed. Output
+messages depend on current console loglevel.
+
 Sometimes SysRq seems to get 'stuck' after using it, what can I do?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..c4deea41a8b5 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -450,6 +450,17 @@ static const struct sysrq_key_op sysrq_unrt_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void sysrq_handle_replay_logs(u8 key)
+{
+	console_replay_all();
+}
+static struct sysrq_key_op sysrq_replay_logs_op = {
+	.handler        = sysrq_handle_replay_logs,
+	.help_msg       = "replay-kernel-logs(R)",
+	.action_msg     = "replay kernel logs on consoles",
+	.enable_mask    = SYSRQ_ENABLE_DUMP,
+};
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 
@@ -519,7 +530,7 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 	NULL,				/* O */
 	NULL,				/* P */
 	NULL,				/* Q */
-	NULL,				/* R */
+	&sysrq_replay_logs_op,		/* R */
 	NULL,				/* S */
 	NULL,				/* T */
 	NULL,				/* U */
-- 
2.25.1


