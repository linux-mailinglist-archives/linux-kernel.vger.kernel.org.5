Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616EE7E1833
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 01:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjKFAs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 19:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjKFAsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 19:48:54 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2078.outbound.protection.outlook.com [40.92.66.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBFE6;
        Sun,  5 Nov 2023 16:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5dEGCnnIx0zhTij+rxwvCezb+TzYqJS1OdwG5kZSQFZuXjrbuWdSDE3bokUd2I+GFs5kazr4NwEezqB3hdwx3IRQuJkLgtZsAJJPz6PNChWSZAf/ysDucIz38yZLHrW9cR5q8ossEadhbROdCIyr+Y63QE3yK6QkA4d0zHg1IVuh1ApcH0h3EwmEZUuH9drCfxcoL9VvfwDGgsBPwbNjbXYx3nU53TG92eXaslEgXMZfvtTPBKe1ioLVg3YQaV/h7uucj8fc1xd42JOVoc5bSPMME7PMFhgnx+JStWwUsmTl1O8xR1AGn2dPlsFeQ+k564cnhL6O13HYI/b3bzJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1xgs2hBl2+O7OTROe3pEMi5ZTZC4DqC/vNTz7mTcdY=;
 b=MNbGyl72ETYufh+iWNI2H1ZGteGes5Umo+2E8eNr9gejZl430bKBADrguuwdApcDZ+Dho1REXpoWng1nGgrU+j0yMI/pys4nDzzUL/IeqZmp6+wqHP3omC1fpsloiGZ+7eQnVwRuLI5e1/almizhJyDu/q0P+RsGsQO5oDxPXfCQ5G9eZn4e8U3QFWLNlr0h5zBe4JOmZuWBtQ6tjs3VQrnwnHnwfo32ulshYYP8wbTO647sN+ePWFvpFFMujNn0W5kEN5U/ljQP6qxMpArG3G3hyt1IPNa/pGGyUlhfJWHNCEC0JAr1IWOX3y2G6ctB0cFtAXDlemj8KS84U79IVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1xgs2hBl2+O7OTROe3pEMi5ZTZC4DqC/vNTz7mTcdY=;
 b=uRLcwQOl5tW7MkMarDmcEyn+MZiEo+ZBCYfRrEy2GU45k8RGq/gPesuNDLiYTzMEmfxkilJEvcRODbvkEQiBhJO3tnnPjD+npSm4sQ2G0/7JhqbaTpaiGlkqYWNiE6RypSaqTiSvncxl5/Xusv2fzU0ILTtRUpnj2n2XHLbPXWIcftoUinOzxGLtYLhvyJXIu6EBe7IxYZQ4d8cISLoI8/yZF0QFccCHbVmchsQDMYvXbSNRWVG3Di83MNTbO1KR7Voc3rNQr49UPtH4xdLGR2rTs0kMgU1j9fpfQe/lfZUoMBrlp6RBTPrEVtlMobgbKw9aJYBO86lxgXfUjq3LzA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by GV1PR10MB5940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 00:48:48 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 00:48:47 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     richardcochran@gmail.com, netdev@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
Subject: [PATCH] Fixes a null pointer dereference in ptp_ioctl
Date:   Mon,  6 Nov 2023 06:18:29 +0530
Message-ID: <DB3PR10MB683554F488A562C8A89286C2E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [XSiyIhcMB24S5xYVxYNrxhPtTaffsMoh]
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231106004829.1749714-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|GV1PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 236a2fd7-6ce8-4c35-bda6-08dbde6222c9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LC03cMxh9dSG+TeemuqOQmCegU9p99+Q7tfVXdPgqvI8p9bjz7IjAJTM4r8BIeIGDOO0KiLxLRelka4/PnE9Lia+YEpR26Vj+LwQLZ5N8edzYyNmt9SFxzdPYw4SLO/jbtrv7OuFhyR7XWARZxCCAZ4A1/FjJ4q8VexYkcIMboYwli99fdzmoU6bRVYbrtAgR631mTn6hnR9GDV3bW+U5xZiW21ZF7HmD4YVvxi8VxTfydwn+ehV4cUbH3cZ83lPXhra0jrLRguWjvdj36Ps+1R6H5sosLaEvFJycEeF+rjjUbJOO5MB+0sfNavmY7aVn0fck847i9D6wAP5bZ/Dywn8V67upzUC+cF9raBXnZWju5l8Os1rk0Cq2g2KCl6CvEl8djgyQtTCOwu6U5MwdZLC/BiS4CqsKfkklTLZCQufO/OtS4xptoXkJP1h0Ok5sAwZN0R7uDa1zHqNr4Zh96r1wyFjcPF8+ZQGiI/JIzBN0ZME/exElZk/UxQm706S2uFd9xTpSwptBRLhF/3Hhvpvx9OROlaJDGHzV07tFfQrb3CibFMNDdHVvskfMTzt1jaXeRuzwM1yWpNePLyXNCRHN6LlLR6OE6NYAFs9SjmfhvL8/3KylAByUb30ZzL9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVDxYuoRKfyZ5lUcvRny5gUK2BAFvugBzhkoNtH+ghSVKC1GXLxOot5MfBlN?=
 =?us-ascii?Q?d6D1w9mFbNx+Ykk6EquENAQA7IdCUGNL6j0QnsIhfuK5QiotIeam43igl5gV?=
 =?us-ascii?Q?8QfV0EXzJb7pZAC99IWTd42/og920cP1Q8wFZ8jMx+T9CuCkQs8ocHRXvVmg?=
 =?us-ascii?Q?ZAnONZD3WsipbOSCzGyOtXzdSFhN7u1Bj1TzBeADIXUpzDc934OAlH+9AOih?=
 =?us-ascii?Q?Lfut9sO+RUdgUJG90+VR/hcK/7PI0FT/8keTeiGhPAMhxJpmBRwqV8xB0b/C?=
 =?us-ascii?Q?n/lcBJuxFzVB7/20mwdMU3O5JvVCfNBkSmlToxn2DV84NIg1WPnGpcgHuliU?=
 =?us-ascii?Q?+w3cQroWow1AU2bNpUX+7wpsF7q46xpCyFt9oagYozKSCntg6mCelp9rC2IN?=
 =?us-ascii?Q?56mLtlJyHHrUoZiKBfPo3QWVevF/mj2ObyLqcIpzOmZ0Vp+rQxdL8h6DGOIV?=
 =?us-ascii?Q?UydysNLwboJFdfUp+nJXpeGWOnS2qLPIMsngqSiM5wiz4s4+Pt7OWp2jdUdG?=
 =?us-ascii?Q?tPKNrlrPiIyA2JHwr67O2nqkBZ9XpCXv3lIxD64HhOyg7A8uUkWP8KK6F/nJ?=
 =?us-ascii?Q?Nu0esvTh+kX6E3sbzvjSPeLXBopDDp9Zn/zjSaqTgNGjXwB0QZ319JB95xq4?=
 =?us-ascii?Q?2j4gP0FkK+cdilHKthzZ+x1ZKReLJn5xfGT7Zi30xx7p+ys3BE6mP2cvKzaC?=
 =?us-ascii?Q?JMOM8Xn1wZvzaqZzItrmVvR+7t3iFVV5N3WRJbC0jqoZVL+J5Z9PUyJa7gf3?=
 =?us-ascii?Q?Y5H1iQ0GGZj+RVZirFWfWzedYGaDT9SLguZsexymGP6kFTrH8EsxCT8hvQkf?=
 =?us-ascii?Q?PUJZld6ASDQC87WhjTwmcDS8d0mkUJAHmWtldsXu0j3lvvIEDARWBZ/T5M3S?=
 =?us-ascii?Q?DpsT693miTbIOn7pdOEz8p/DjUqGHQydFXEpKdqF/aw2YZI0fQPY8D5N4q/x?=
 =?us-ascii?Q?Nws5hwfYf+udjh12e68lJ7R1HBiHUHljq3/i07B5AWE/FlVyo1zdTtx9kw2C?=
 =?us-ascii?Q?cxU1BaEvekYQd1F8iTRfPO6p8bKYXoO9FKEdXp/Vb+q1eoV4eewcWg5qfn5l?=
 =?us-ascii?Q?ssJLIjP/akLPmFes4tXt5GKMVcOoRAhqwGNKhsYFqWLzMfl+dClWGc5ea6Mf?=
 =?us-ascii?Q?PRMR3Wcx5GupWD/ZID3+OoWDolFbyMYZESRyBQRmFThcqTn1yU0fMXfVVX20?=
 =?us-ascii?Q?gxC+m+pVCtFRjZaM3nGzT52m9EKD0Zw/3qzdEya6WN8/pFEAUqKUF3D+MA8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 236a2fd7-6ce8-4c35-bda6-08dbde6222c9
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 00:48:47.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Dashboard link: https://syzkaller.appspot.com/bug?extid=8a78ecea7ac1a2ea26e5
Reported-by: syzbot+8a78ecea7ac1a2ea26e5@syzkaller.appspotmail.com
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

