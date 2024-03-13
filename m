Return-Path: <linux-kernel+bounces-101344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E030687A5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD631F23C06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B3739AF5;
	Wed, 13 Mar 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="kAj6Uo1B"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250C3D56B;
	Wed, 13 Mar 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325461; cv=fail; b=S2a7T3aovb1LmzLlr7QtsQGe3/pI8VlCDhCOwZ5NtkInjC5zAdKAXlp2K/9i5ZN7BnRiIupKOLCMCD2YR1q/vqHoMQT7i8IfYt9Aib/p3l3Axtu+ET4moD1oQ/L1PO3/rGKVGv7JNFwYZ3d+P8X4w/nozrsUHygVJaNAD3xWFcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325461; c=relaxed/simple;
	bh=DUj820UV1QkUlLBBDlS5w5PHrDRtfz0R6c2x+kz236w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KzcqrGH3lkOG7NUSxTKRiKFkkGaf+iNUkBAirIlxuK+XO4On4xyoG2iqcvfxkUfOolH5g+WCAHBnn03rIMoKIl/cmtdB17pSqSNsK9CyrLLup6oTlWaNSNdtY2Ll+0Rzr6zg3x+U+t/0fUj/+xY591WFPaUWSWgEAlkMOrDcIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=kAj6Uo1B; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqPj17y+d49lIUCZQjUq59lwjeZZoPqMIluAIUVOjD9WBlG0jqFa7kpW8yMyX5IVPihY9abv0nKtFn15B9DIf3SubBmEmYCGm0e8KxuecONp+R4G4EKcqQXWZtJx/keo1aWiybRDLaTkORG/OW9bkCEo92BEze3uLYGxQM3lR55caxmkFCG7S96ZsthF3XWyU82ACYTXk5pMB1D7HGStPqMWzeMigs3KLRI8y6tkixAi4WtGOzWq5k8ROT67XA8SZhWM+Y5zyz4XyUBDQ7rG7EJhvLTmVkVFmk8WCyiVcMnaGG/l90SdlA10V+5OJqbBAqKfiTyZ3kHo7zhofNAjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIUdnfGq8Ak5YEUySXrbyvDHDJhRKCJl3uAqhiKtj4Q=;
 b=oFqOFENT6+8X+wFH4N9WogLKnIXdS/cJ6HiWadWGWxFQMuyIheUq7lOkFz4dUeJnalKEOZfuRx7AKNTu4vLteVY3otiqn4xR3oMy3anc6O2RlV8xAQfTRQbM4aAbQLAXnqfuGXaPVqSwG4ccWeYXgmibVERLcCor4O8hAw5TN1VKYKpQHao3vgtUnm6baiQHfWTQRovO4ySVBjCChLNUfXG3kcBDJAzxG/0fJYcvJhqLfeA2hFHlzJ5lb0pkLLBVGGiLnvdqZqRv22BMtGWuNwzQEyUlZrGuEMW2iNzep+eo5QmYUWcqAjZBoJD0aDECZDYRNCEG7iBjQbI4O9GHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIUdnfGq8Ak5YEUySXrbyvDHDJhRKCJl3uAqhiKtj4Q=;
 b=kAj6Uo1BTigR5sCWitB2yIPKphbv+SUCni96An8YJRLdqUK7wrqSyd0Lu79B8afiRocdI/i/69s40lhkyiS1PecyZsS/TMDcdjrMCQ+5e1Fn9KBKHHSxybjqoPuHCHTp2+wNtAUpALbDfKx9fgzbeMHNofVsWFbAGL5aq/9OpWc=
Received: from CY5PR15CA0164.namprd15.prod.outlook.com (2603:10b6:930:81::6)
 by MN2PR13MB3806.namprd13.prod.outlook.com (2603:10b6:208:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 13 Mar
 2024 10:24:16 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::ee) by CY5PR15CA0164.outlook.office365.com
 (2603:10b6:930:81::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:24:15 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DANjhD004377;
	Wed, 13 Mar 2024 18:23:57 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 42DANi8d017452;
	Wed, 13 Mar 2024 18:23:44 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 0A55F20C0698; Wed, 13 Mar 2024 15:47:20 +0530 (IST)
Date: Wed, 13 Mar 2024 15:47:19 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v6 0/2] Add support to replay kernel log on consoles via sysrq
Message-ID: <cover.1710220326.git.sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MN2PR13MB3806:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de70ab3-fbd1-48f4-8cb3-08dc4347bc8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4+b/OytEZ6P0CynZDoi8VLGzMBuJOCrFiJXnkRo2qMjKxCJ7mPoaolSaknX4fQSUtY+/2KX5FrOgQ174hc5kvEuWH1jYDqyAwl1jcLRdBVq9y6d0JpMNq6zoSRENn9+vBPTZUQZVRKWgJCFWFLfy9Ow2CoAXwzHNZD9FHrpW0VVaek8ZU4FEOdy+iN8pLKqiKfZsOMr3AXgnHIj8O1nu+ZGCLX6jratjgFImlSh5ksKjYwRQ8TSP4XwHjbIG5YeXiIuMEYdtBH9Uu39zjcRJNofvR9D8RbRkR4ZdiIGKVG9etn9vHDSqZSVz7nr98b+4Zhvo08RoI7P7sxPhGv6k/8XLVkd4Ly11n2eQx1eG7I1rMm5Qm6YwN1hjwlILRKgT8cy6LHDZktbYQTHBmtQV13wz/ojB4ycHKgsw/J2CvUVuGmKgAT4dB0h9OOzubTT2rvuCUZTSIaodhOzDhnaZSzpk++cOPsztR3o338tMw/9GG9j6TMqlPdX0Yt31eYfaPLI4IdigoUWHTI1Pu/s4oi1P3TcBNnN17tVODJFXc4B9KlVPlRcK59ujFrovld9iB9TiJZ+SaZR/h24AYI5bRT2ya7Z9KIi8FPmLwosYOmwtoX/sCjUrYYhWK2c/nE0rvQ0B3UkwHjsP8cCTQNfdwIKEG0pWntzZjaCB8EFSGfvNsdhdXb7vTIBNLmxq6E42BMBC0cCvCVRN+nJ2WNn+4w==
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:24:15.8199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de70ab3-fbd1-48f4-8cb3-08dc4347bc8e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3806

Hi,

This patch series enables one to replay the kernel log messages
in printk ring buffer on consoles via sysrq. This is useful to
view the kernel messages when terminal is unresponsive to enter
commands like dmesg and syslog services are also disabled,
especially on embedded targets. Although debug features like
kdb/kgdb already allow this, these debug configs should be
enabled which is often not the case.

In the first commit, a generic function console_replay_all()
is added that replays the kernel log messages on consoles.
To do this, code under CONSOLE_REPLAY_ALL mode in
console_flush_on_panic() is taken out to a helper function
__console_rewind_all() to set the console sequence number to
oldest record in the printk buffer. This function can be called
safely under console_lock(). console_replay_all() tries to get
console subsystem lock using console_trylock() and if successful,
calls __console_rewind_all() to reset the sequence number.
Finally it calls console_unlock() which flushes out the contents
of printk buffer to consoles. The console loglevel will determine
which all kernel log messages are displayed.

In the second commit, code is added to call console_replay_all()
from the sysrq key handler when sysrq+R is pressed. Document is
also updated describing the use case and limitations.

Limitations:
- User may have to press the key combination multiple times if
console lock is not obtained at the time of key press.
- If console lock owner is stuck, console_trylock() will fail
continuously and messages won't be displayed.

These limitations can be overcome once atomic consoles are
available. Currently, it is best effort.

Links to previous discussion:
- https://lore.kernel.org/all/cover.1709277332.git.sreenath.vijayan@sony.com/T/#t
- https://lore.kernel.org/all/ZcyWU0V6Kmq0Txqr@sony.com/T/#t
- https://lore.kernel.org/all/cover.1705331453.git.sreenath.vijayan@sony.com/T/#t
- https://lore.kernel.org/linux-serial/20231221133953.1507021-1-sreenath.vijayan@sony.com/

Changelog:
V5 -> V6:
- added reference to sysrq[0-9] to change loglevel
- fixed action_msg by using Replay instead of replay

V4 -> V5:
- renamed console_rewind_all() to __console_rewind_all()
- modified comments for __console_rewind_all()
- renamed dump_printk_buffer() to console_replay_all()
- used sysrq+R instead of sysrq+D
- removed workqueue based implementation and used console_trylock()

V3 -> V4:
- refactor code in console_flush_on_panic() under CONSOLE_REPLAY_ALL mode
- add new function console_rewind_all()
- use console_rewind_all() instead of ksmg_dump*() in dump_printk_buffer()

V2 -> V3:
- split the implementation into two commits
- added function in printk.c to dump printk buffer to consoles
- added Suggested-by tag
- removed code to dump printk buffer from sysrq.c and called
new function

V1 -> V2:
- modified kernel ring buffer to printk ring buffer
- allocated buf dynamically to prevent stack frame size warnings
- used buf of size 2048 to match PRINTK_MESSAGE_MAX and added comment

-- Sreenath

Sreenath Vijayan (2):
  printk: Add function to replay kernel log on consoles
  tty/sysrq: Replay kernel log messages on consoles via sysrq

 Documentation/admin-guide/sysrq.rst |  9 ++++
 drivers/tty/sysrq.c                 | 13 ++++-
 include/linux/printk.h              |  4 ++
 kernel/printk/printk.c              | 77 ++++++++++++++++++++---------
 4 files changed, 78 insertions(+), 25 deletions(-)

-- 
2.25.1


