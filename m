Return-Path: <linux-kernel+bounces-101355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FD987A5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672E41C21C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26239AF8;
	Wed, 13 Mar 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="gjbC+ovf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838253CF74;
	Wed, 13 Mar 2024 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325794; cv=fail; b=F7y7NSmvlKXOg9R+TipmxrYIl9hL6obRZlltV+w8Yw13at9YK+UEWsYSLzHcV3NZHokSQ77fAoBASHxYcgdzvvZPx7Za5kyLTf/rCDtIg6CMj/VE3lyRTV/Q+q/nqAVFPpNE2oJYFtPp8eDphbM6OXbu4xL0LM4chIxjObcplHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325794; c=relaxed/simple;
	bh=f9vQ1kvdzYlX86eT32HukMAsHm7Riy/EpZNOFvW8nO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM5PA1H9nBXqIRRFnonhFiZY2wFRFLAf8VY7i8eU9qlv/nqbb3EbKNfLPo6Y5o8RYgiscyadOuDCFiKa6IqEJE6kqpR5f6eS3FHEQF20JRWv29UhRhKqEs20DUGZzYUcLjlX5l1evG290+rFJSJwNfp0r7KTwOcvw8R5+08l8jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=gjbC+ovf; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ73/xdKklfady8sTHarSDBYP77DKnI6XlPPIpbPCDfsUumQorXEUpfLDR5NyZ3B/0WjFZ+AMv7AEs0JItInbi+xGKBOCZh53IbzuIMI413MyQueG6Gg5Sg18TCiM1XbESIwWvgaMzJkw4b8NlIf6SB0TntfRZz5Kw3pDj/q7Ah++kmai7I4EFc5FS6beFNwR5SRERvAp6ro/rrO53zo/kb4uOYfmNVQq93vGkD8qjC0epYyQqpajn0icn6Tji+b/2dJ/4gjJZKe5c/LMMxLTJ8FcpqEhdJK8D31y5JNM4AOuXOf7DNvTzOc1Xl6xZ2fpPpWi9VnMY+rp2VbyJCZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suUxxneNxNn8KC5bW0kgNjnqDzTwMTG0WXtpd7dvX1I=;
 b=lGJorNlsSNAD0WvwCEVbZna8NIOroijqalKmmjhzlezfctleKIq4uGguYwetR6P4gES/zpfRA7WQK33yk4Q2CYUk2MCV2YWodNFUkcynqW7r+DVj9EUhhRD5C2mo/E2j9vLciLgxSlVqo6bFiXXvLIusi3BkygTg56fxJrMhWaxNwG7j52shUjsDpg/NqH/gAaWfOHni9ZCjaJ0MYRbdq4eVDHEhYlQwfC5pVju4wz/8MREpE3BbZVoItV+wS/jF8tclTT9Oaw609BFSxn84hkqfkgvlzK52u3+jOtCukvkN0tShjzvFCpvn6HEiz/jeSoZVNN1dIU/qxGaIqw61bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suUxxneNxNn8KC5bW0kgNjnqDzTwMTG0WXtpd7dvX1I=;
 b=gjbC+ovfgukReyFZ5WAnrDZ7WhBF9c8B5khSANCjhIFdGI2zA1ujtIPxTKstmcouQEHgFYb1V1vMfVzbaxXeevw37mnQjmaloZ9TynXl0fsdSgm639XL7U53wO2XKLPXY2nNiz+kDpzkT0Zjq1qZTP3yR8mmFCMPoT6oufdo4Dg=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by DM6PR13MB4034.namprd13.prod.outlook.com (2603:10b6:5:2af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:29:49 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::15) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 10:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:29:48 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DATHsH005627;
	Wed, 13 Mar 2024 18:29:30 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DATGrZ019079;
	Wed, 13 Mar 2024 18:29:16 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 689E720C069B; Wed, 13 Mar 2024 15:52:52 +0530 (IST)
Date: Wed, 13 Mar 2024 15:52:52 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v6 2/2] tty/sysrq: Replay kernel log messages on consoles via
 sysrq
Message-ID: <cc3b9b1aae60a236c6aed1dc7b0ffa2c7cd1f183.1710220326.git.sreenath.vijayan@sony.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|DM6PR13MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 97dcc7e3-b661-4e21-2921-08dc434882a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fnMgTi4eM6wXnTTZwcLa5dsPfhJYADE6bGRV28V+QdOrVYS0SCXUV2iiagkvOoDPToUdtLnxScNMJTVudR8fPNxkxTAifnm2iogxkP3wXyKvAL4EchVogXgGdqv7TawoXCDpt/OvKZlCz9Aj8FGWq5Zldt8lbl1MmqVd9gMDQzIT7ej7Yvt9hwBpUGLWQmYgrol32mCArTo9DloQG8cK4O3mymB1GlyG7W+jMYSI2vDN+zDxRfnJR8zG8NjQO/MpqoYiThGq9db1Q3dp5DzFoKxP2QNok/BWhzHvFtgTjyYopkkL4ugxjTAxT0xbAPM4EV3d1F2PWeAV8JuP2OVIgYbzPKsFDcKhEjOXeNhQCfjae0iK2zdIRYIhBbOuzY39fIZZwffjb6raI6+qFnaw0McpHoB2jhUHTlw7CFTVORrO+GVQJVyuhL6r7jM6D5ZCpDy1nv6sR2Q18rJlVAea4kjFQ76h//bU30QcFVPdhlF9iPKS0ExEw7Jar+qHmT7BcAmnnQfmaVfnlMTJObDtD5hxygOOy4wt61hYuwrIpxADUmWU+Gviy9wKw0muh/KBbQBNGL80VpWBKY1NkxFLkBk07as7BnaKtW6L6YRRCEgYJriGSicFCo9pfYSuQnOrnIVMY/4hKeQ3/ZC3AEgRVWThP1yDnF6HcougzdgmcTvtQAvKLH1Fu66vdK55eoJITGnfBDFJ9vbMeGfL1owFpsILZoC6UqRE3S13OVQvgQiyoVQPtpz7hjrkE04/ROab
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:29:48.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dcc7e3-b661-4e21-2921-08dc434882a1
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4034

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
Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
---
 Documentation/admin-guide/sysrq.rst |  9 +++++++++
 drivers/tty/sysrq.c                 | 13 ++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 2f2e5bd440f9..a85b3384d1e7 100644
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
@@ -211,6 +213,13 @@ processes.
 "just thaw ``it(j)``" is useful if your system becomes unresponsive due to a
 frozen (probably root) filesystem via the FIFREEZE ioctl.
 
+``Replay logs(R)`` is useful to view the kernel log messages when system is hung
+or you are not able to use dmesg command to view the messages in printk buffer.
+User may have to press the key combination multiple times if console system is
+busy. If it is completely locked up, then messages won't be printed. Output
+messages depend on current console loglevel, which can be modified using
+sysrq[0-9] (see above).
+
 Sometimes SysRq seems to get 'stuck' after using it, what can I do?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 02217e3c916b..e5974b8239c9 100644
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
+	.action_msg     = "Replay kernel logs on consoles",
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


