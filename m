Return-Path: <linux-kernel+bounces-95563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A914874F87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14F0B20D25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7073812BF03;
	Thu,  7 Mar 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="DBWgy54J"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50FA5F86B;
	Thu,  7 Mar 2024 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816320; cv=fail; b=A9bhcosW1ndKa5mITlvWqqyZHedUM6ZiMBn/z3nDZaqkAkwQRZy4jwsxZLnFu5ig0Kqb5ZFQ8GLAySpjkmkCgWudwcNm0jGjFwx9irsyIVCnPSSu0yo+oS4j1WvUS3Ej5pQhqSsjFe9TvXCEH0R3nlT+HLToe2mWRI33WSIaex4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816320; c=relaxed/simple;
	bh=3Q9VXWZwIjLoPlqxV40TnMmz1AK9CoM9okZZcvIcw+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RN9NwcMjMuCzZmKg7aIGal9sofbldPt0Ge672jiQ5jPsGH70AKz9XNbGfVBy2nnIzJV+ZaB0DPB67P1CdF6h6iska1A8p787bsRRjbakTOhUcmx0M9V1CMRXVSI/LHZxLGbvjyah0r3UznEux/T5wxUk3Y0Xjmzh09z+7zOAjHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b=DBWgy54J; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAoPZvK+TAjB7yylyRggUN6TRk81t4MYvPYxxmaEh1zyfAsSfGtq+LRgLuRcKYRHjfVhLrvEbjK42pCkFq4RgN2+fsPhcw8hrgxsllsDAWUzLSY+2iBUc8EjZX6wTArKMKGzQqp+eWyTZWYbM3V2L8az1DcP7zM5h3KtSzHsHu2Vir5QRqYf3mPvvfIpvsg92SQbsx70YVCmUEPDhJWlx4w6oVPDV0xhAb6GSuIrP0C4twpWaA+MmCAdJY+EiKPLC6c3GEJPf8CZk6bsAsmaO7wx1ewByGMDblGm3OzJ1m26ApwwlM24iXrHkzJ2QSCJHb6tKu0MHr3s2/D8E0Dyjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Gh1XAvEogIiz40pV3xFhSuEGuxmyhoVK/yvbzqKkHw=;
 b=Ao6KBuXSp9njfpEN1DG3hst4RCU9D6/Rykb8qIuc2neGIy0jPxy7WRRGcMSlkgf6eDwP56oGnXbW3IFD8gYSmiJOkhTUUT0FLcQ/2Sr+5Q0Ccw/jS8DWBAwjN2vl5LN6JXbgQP+2qNFcRwNaHETmKbBdvyVLHr/7W0iJcGzPiQbVDHOcIme3y9fOzUKfS5LHMqp6ZX8uuje4jV9h/txLn8xgCxkDSHCHgrFzPjcj594F0QJsEo5nRy2/2o/oxHUyrKdQg4lADVBPCdzCKp+9gX1RNWXI6vnU8gIEUJds9m+hHu+ql2GTRG0OpdGuVw5lnWhNSjnSY7uVAuM9W/skKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gh1XAvEogIiz40pV3xFhSuEGuxmyhoVK/yvbzqKkHw=;
 b=DBWgy54Jl8dMjcbVlxTEmp/oeRzZxU9LCG/7SGM1/VyK2NoYUnJpQtJMejFel7a1cd33npxeGgC1y0WzibiqVncbnaqgKY8ws4dVyk7q3D65cXI/V5gk7cbPaIKWkzeF+8/MUgqdtSElyqPgtp03sOolk1VkWN+EKGZswNl7KAs=
Received: from BN9PR03CA0888.namprd03.prod.outlook.com (2603:10b6:408:13c::23)
 by SA0PR13MB3966.namprd13.prod.outlook.com (2603:10b6:806:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 12:58:34 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::c6) by BN9PR03CA0888.outlook.office365.com
 (2603:10b6:408:13c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 7 Mar 2024 12:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.0 via Frontend Transport; Thu, 7 Mar 2024 12:58:33 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427Cuixg002353;
	Thu, 7 Mar 2024 20:58:15 +0800
Received: from mail.sony.com ([43.88.80.246])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 427CuBNl030938;
	Thu, 7 Mar 2024 20:56:11 +0800
Received: by mail.sony.com (Postfix, from userid 1000)
	id 7528B20C0686; Thu,  7 Mar 2024 18:19:45 +0530 (IST)
Date: Thu, 7 Mar 2024 18:19:45 +0530
From: Sreenath Vijayan <sreenath.vijayan@sony.com>
To: pmladek@suse.com, john.ogness@linutronix.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: rdunlap@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, taichi.shimoyashiki@sony.com,
        daniel.palmer@sony.com, anandakumar.balasubramaniam@sony.com,
        sreenath.vijayan@sony.com
Subject: [PATCH v5 0/2] Add support to replay kernel log on console via sysrq
Message-ID: <cover.1709277332.git.sreenath.vijayan@sony.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA0PR13MB3966:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d3578a-389c-4368-272f-08dc3ea64c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ruys2Nm5/Dbs+jXIwScOy03MPcxfy5nXHKhaVfP0V+5a6VrvPwNx430JzKANFHwC9HrXxw7uPo1AoH+9yyY6m0PlEnQyXc1DlP6DRImNQgrdbJUrB7YYe28PEDBQt838NF3YuO6VIInr23CgRc2QQta/WeP3OeCHaPIs9wQEaOZNzYr0LSJITLgiyalBTBjgcCHrscTfzwKFXXO8KaoxZE9e0RHvrmYZ8hDvO4FHbEYtQpvlQXvZajGtAckcG8/KVSRvcMeX1/yJKd2dx0epIR68glvYEt0AlmoNq1W/eZ3aMaQBRlWpoUs78lqWQNeOMMOvvN4X7W7zdYsuHjvnKrtHI44/da/gmv9/hKNyLRoJp9nSBKlXz8ZSk7QbBvwk2RAZXQmeJoTnMIqK/y0WTzRTjaxwdXSiXk9sO7DDifzmzhbBcc7BCgasM6ubEqaUj7RhPP9ImRmne7hbaqX7A4sDhPiuVNCq6JTbhZZ9ryyv2W6qoEF+EL4R+EtSe59EdJn98TziryBdqUS1sCPuwWqENb4LafldLCJnr2LrDRsZD83MvAWd6L2bIIFHKhs6WvqKudgt2Y6z3Li1zTNjO84msb13wvAtnf2SK25kOVa2JOj4E8wy9EAnqMlYPwFFKnw4baummhgfc2DzOzDNqT4j06FDfNTuKLNjxH46sikm8CTxRkz4msMwhcycpy/2rpTkM8ImgcrXxEaWS9U3sQ==
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 12:58:33.3822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d3578a-389c-4368-272f-08dc3ea64c0f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB3966

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
- https://lore.kernel.org/all/ZcyWU0V6Kmq0Txqr@sony.com/T/#t
- https://lore.kernel.org/all/cover.1705331453.git.sreenath.vijayan@sony.com/T/#t
- https://lore.kernel.org/linux-serial/20231221133953.1507021-1-sreenath.vijayan@sony.com/

Changelog:
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

 Documentation/admin-guide/sysrq.rst |  8 +++
 drivers/tty/sysrq.c                 | 13 ++++-
 include/linux/printk.h              |  4 ++
 kernel/printk/printk.c              | 77 ++++++++++++++++++++---------
 4 files changed, 77 insertions(+), 25 deletions(-)

-- 
2.25.1


