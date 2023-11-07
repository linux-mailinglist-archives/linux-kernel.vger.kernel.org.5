Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E9D7E4A14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbjKGUtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGUtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:49:11 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2027.outbound.protection.outlook.com [40.92.64.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F09137;
        Tue,  7 Nov 2023 12:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la779b/t01xjaBIE/5uFHz5GT7hX7wsHGJTdcCcUsqUyML7QRNn//mKXF+EyJyx6Pnr7+hebuoIAT1EXkeyXSH8eiSHXZfksqdWZyF6bd6fvAZdbH2sti+WzlYhhL9BwgOWsWgKxTmJq4WgvHV6fWmAqNmt6cRPsuwBUa03/YCvJaG8mtz2tvuLKCBpDpRj+PctQ1waQN4+MMPoNMhgbJmh3FwrFwYJQQ/HxWCm7JhTJOuwNLWPm6qDVzDYeWNNfsIrbEfSMBvWo+z4ddOS2cRGh16f/PuM0o1xccE7QNGMnWxxnuvYdpJYzsKqcqsn8xFj2nUukgCu5QJ1rcVcfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef5iHiCKbRYWS5/Qdr3Ca5Osk+32uM084HHn4E63OBQ=;
 b=cppQCEqaS31ue5xaa2XRUX2O7f3ptk7NWVNlQqEn/ZFWvjVJeVMcZz2Mwa2ZO1sWA4L9wKpgPHy5hKTDGi0MnnlTfXd37uMACYq167cK1rBS8pLS6tvB1JoBJJwRKl0KDEOE33I8SU/lvLsPEenG9hHaMQgA+2EAKqpwBzBjB9a2KDoZoJrtO8fmIf6zzNBAvCxg/1plirxk8BQaPq04rOOsfdTP16qzA8p/87Njp95WfBsD6WgYjtSa3MTWqeNtDf3oXK28Kwk7CX1nxv/23z/fDiF3rv8GO/1yK8e26fYeLDdSLWg9IsXrxn9zjbafamjDrbAsUvNCZENpDW/hpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef5iHiCKbRYWS5/Qdr3Ca5Osk+32uM084HHn4E63OBQ=;
 b=hqSXVrbA+ZHIFdYaA6S1NmolrQTqqs9HrNzNkNsSw4q8gohMBP1bq6/VFI/lbGrenfg6mJtVMR00VDsfaFygA6ZFOpYwmqM5tnhCzsZorSg0tXzI9SoogsT6npsdtpC5T4aeTAK7uNzYdfJ1uIh/RvxSVb2ozqtM8C5gLXPRrLrKEs4ExvWWr0ryAZW0zYpto8aNu4rejcKx+XFrcYYylvNpiFxV8zzW1t61W4D7uczo7XoWhWf3xEE2AqKT1PZwlo6KWOL3PLTDG5wBxyHDN91ym6KVZR/HdEyIa9k5mixHgj23XajzUYtWLlpUWCIRU/eIlvLNuXa8qXjKb9z+dg==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by AS4PR10MB6277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 20:49:06 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 20:49:06 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     richardcochran@gmail.com, netdev@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>, eadavis@qq.com,
        davem@davemloft.net, reibax@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Subject: [PATCH RESEND] ptp: Fixes a null pointer dereference in ptp_ioctl
Date:   Wed,  8 Nov 2023 02:18:36 +0530
Message-ID: <DB3PR10MB6835D68E7E632532155AE585E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [B6YInlTCs1itY/5b2VoSgRX8XVO9e89Q]
X-ClientProxiedBy: JNAP275CA0047.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::8)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231107204836.1849214-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|AS4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efd67a0-a413-4c91-51d1-08dbdfd2fbc4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBOAbIPrBjHr6/Z7piI0E4eatt5N+ejzLjXWNDC6i0B/NaVdqq3AK3xAlBG8YB6SJDsrZinmneZrrXk4zVpfoksKvt39cZ/l7Ls6yiDec3VENs6HvhlDECcmhVVA8XgDyNPCwvQLxT3KQUu1X1/MzI9JyYjYBa+J1gCfihZIdMG2hW4KQ1+V45N/g13AG7QjR8V2cPM2JTQAPG1cVHDpURxdQsQjP+qOdXhEjuepcOrUJ4Th7YeabfIja46BiwVMDAHOBoHaWk4lTYWSMPMzOgdMAo20nx+yx6PDU2cVaKMiYzSRPsurcF9BJcPh3Ha3q9xtT/7+3DOGIoQ8T00GUf9lHa/pMPse6GogjWq+YtwJ0RGCZMCRnx0I31bQuGTzCZ2y7JaBCF2TUj7NX2drc/JDnXb9XQSNJGVSV7vUqH8cSrqZZ1ikLcDb34bIlcQC4jzYYj0PDiYO2x0IvyN4YFgvCBoixwo//qABOZtN9rG22gGzaEOD+R8FQEr4v1kaTEtaSHlhQkviG3PlCqZzjIMp+skUAbRIHHlxsOZT1qe1BTKtmxwjc6iuVM/Rvxfo73YN5+3sfeqhHFp4AXmt5woO7gclLaHgvEdkEJujv8fUAIoBOcMgqoooMQs95Bzn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4krEYX4C6kZRUJfnQm2GgGxaATTS2ck86KNE6G/RL23bYyNfCbSNVLHF5z1?=
 =?us-ascii?Q?KPWlddNXjoym1Vhy4ixAM3RZAPul6a6MgQ/IBBYKwESzZ5b6kQa0/ok+WLTc?=
 =?us-ascii?Q?LKAdDVmBd4ZcCZHfdP1MzrumfYRhoOZbDLYBSBv/PWlIGND+j/sLIQv7t757?=
 =?us-ascii?Q?H1HGMsN/YMNxStUFoT095mt0d+oQFzy4eDjTfYj82ySEh7xwfRYuhRgx+fEE?=
 =?us-ascii?Q?RJ5A3K+DnHobISWc/VokVHT8W3/wiUQW9ft3Inv6Ifrpe6E/S0Py4A3PyfNl?=
 =?us-ascii?Q?xiqAFTJnJIde2u5lTx0robLJ+Kv06PODSyuvM4Zwz+hyMDQBDiha8TbFTDHX?=
 =?us-ascii?Q?qKs/j3h80OnGYz5kk/GiMZH7tHFlWb9eKBC9CNz4zxyqYfpnY5H0/N8hJW8c?=
 =?us-ascii?Q?cNvlk2Rq08kZpXPVAjz6nhjqvbcBmPw3yXhhgLDCTJJCUP0sKydoho4KdC5T?=
 =?us-ascii?Q?sJTC4/0y6OEzh3vkjT3XtUpWtbkuD3USbkHMoBBGdIGwU3mGFVjXL4Hivz3E?=
 =?us-ascii?Q?YYv0UfM+linU++8cLMwg1PZK7gHodwERC/3klnQ76vwQIe6pKX+uCUCIa2Zk?=
 =?us-ascii?Q?zSOi4o6KdRwHRQuZJPC0meOYgo9WRWRQg1n+OkSxP8Ru8n1VCPRfC0t69vr7?=
 =?us-ascii?Q?AI+fW72sy2iYi+rvmPe3s0PsM9Hp3XDUMT+rTKeGZ9ffTQM9SZDtUViP9Pmb?=
 =?us-ascii?Q?ArDsTLbtBzzcyCO30wB3+LhM84HcmO5i3YhkezZWnP6hYazn9DIV2obePtE6?=
 =?us-ascii?Q?mgruUzia4LJPYobHbCvr9D9IrWQWXbRerCWVbckoDTx2j266lpsxwEIdwfS0?=
 =?us-ascii?Q?a9NtkNz4E1EoRcciK34LJL6gOScN/uQiteq7ipst3fg1N2cE00SPpL9NJEjZ?=
 =?us-ascii?Q?Pcccr2nbwtDJG93ZjNsMtc9dx8pgmOcIvhLMDxSJHZHvnB8zFSbbdGg0MsQO?=
 =?us-ascii?Q?PjDbqaOmr6OkrOWWEG6csyf739GBu1q02/86T8Tm/3p7XPEihkx7uWjHhppk?=
 =?us-ascii?Q?kwenoDNPhb7+ZlOaTTErfEyaTYO1/pOu2hA/3iRDCsuOOHjyQXIHraHrTVSJ?=
 =?us-ascii?Q?C5dv32W0bMAh3SJMkZuKo8p4yAOLVfKqDGqljNT/d88pktHPhnr9Z6RJBE8+?=
 =?us-ascii?Q?V+cAV8RAjt+mzRUMW4cB7CQK12COsG3lKQHnt6j6BLRE8iirCIF3l6mO9Eyw?=
 =?us-ascii?Q?Nq9ocTMI5dYe14e9d4v/WtGgdAxwWuNqHTJfL8dtu+Zp22VLnZT4fP9svSU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efd67a0-a413-4c91-51d1-08dbdfd2fbc4
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 20:49:06.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6277
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller found a null pointer dereference in ptp_ioctl
originating from the lack of a null check for tsevq.

```
general protection fault, probably for non-canonical
	address 0xdffffc000000020b: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range
	[0x0000000000001058-0x000000000000105f]
CPU: 0 PID: 5053 Comm: syz-executor353 Not tainted
	6.6.0-syzkaller-10396-g4652b8e4f3ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
	BIOS Google 10/09/2023
RIP: 0010:ptp_ioctl+0xcb7/0x1d10 drivers/ptp/ptp_chardev.c:476
...
Call Trace:
 <TASK>
 posix_clock_ioctl+0xf8/0x160 kernel/time/posix-clock.c:86
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
```

This patch fixes the issue by adding a check for tsevq and
ensuring ptp_ioctl returns with an error if tsevq is null.

Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
Fixes: c5a445b1e934 ("ptp: support event queue reader channel masks")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 drivers/ptp/ptp_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..5b36c34629a0 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -173,6 +173,8 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	int enable, err = 0;
 
 	tsevq = pccontext->private_clkdata;
+	if (!tsevq)
+		return -EINVAL;
 
 	switch (cmd) {
 
-- 
2.25.1

