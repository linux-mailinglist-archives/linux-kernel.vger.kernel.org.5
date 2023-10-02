Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5607B5A1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJBSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJBSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:13:15 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2057.outbound.protection.outlook.com [40.92.50.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74ADC9B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8tP+pK2+rGa04aiXDyXRw0a9Xa8gCO4v2d+yJ3Xb8bVzR205EQ021XvRxd5/ix1pANj1gUidC6XGBBbDq+DJldrPty71c041kd1r7IMMFEUl+lAZ5i9E9AcH8V7n1+zfjNo7vpyu6qyovgtGKYZVrK9tOoMxExFKjyHtHGsv+vq/ryykX0mJjMrM8sHWIIN32CwHOu1kXu837OAyhvj1ergiu2XfLtwoqnRrK9YiS9VdifADXR1U5eU9q7BKYMz3aowAaAZkv7Bhsc9Sc8vV7cx4ccI3zDOXRL2hMK0LvysV3Whc6VJnIXaPC2Azc3R7rXNNwhZvaB0KYLhSuc3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIPcVhKphvYHB9AXSn2UFPY/PSOBBuMD+WpuD5ZR1fs=;
 b=PRUctppjXK1E03mM4hdN10XY1899uMJJi1tmzO96URwjLjAYPAnXVaKwdPEofasIn5ojcoNd3RJQSqcuTFhyKW/vH3ydOf8Sf5hfSZAo0/MPnRMDVrmhwpYHXxY0B89mI42inOAqRya+pErjIhVL/CVfYf3nu4rM+0FupbWjWLYZhEQcGTuwMhFJYt4Gt3p3K06kvIhQ5ZmDSg127uK19ksenjD8QD386qpMG6jWjAUMDF9mPllr71UuTtBu/LVPpCX+0gxzru9DSXJzcEmKqxb8OU0gZ3EFmGZp2VWKY7YoKsWsUFIHEaVMHnMkLSC3pnKF0lcNBnzxT7PvBRX2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIPcVhKphvYHB9AXSn2UFPY/PSOBBuMD+WpuD5ZR1fs=;
 b=Vp9TEDiMLFhuSw4hP30G9a5V7AslUdDZKjNrgU74rWOGrhF/NQLbwAGidOXD/oyYsWQFgxOVL21iZCAalksu/XiVOZkjrqJ6IEIAZt53qih2GrBtdGk/pQCbEDQEZAAJ03n69mJrDacwHQCe77N9UY9TzbsCzLQ/Ehx+SCLBE45ms/CAgeBh5CR0hl4i6hLjnjhPm7KsvlAtWlZCf2zWJ4rC9luVvfu+CahOjEy1Z7ApVJPS1lubUfmKymR7n6l3QImlrIwJUvz8s3jbBsVzwrrmUbfbisk1cH/S229XJUU9vsZ2S4btuEU2z6fNOFcg1M/L/M9RE8hYToSwSShc8Q==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by PAXP193MB2172.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 18:13:09 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::3164:ae5c:78f7:23ad%4]) with mapi id 15.20.6838.029; Mon, 2 Oct 2023
 18:13:09 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
        gregkh@linuxfoundation.org, xiubli@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+2f142b57f2af27974fda@syzkaller.appspotmail.com,
        syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com
Subject: [PATCH] fs/minix: Improve validity checking of superblock
Date:   Tue,  3 Oct 2023 02:11:01 +0800
Message-ID: <VI1P193MB0752B3E1D00BC07CDA769FFF99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [SggoI93/pmEI6yGRUW69yUdge2W5nmJr]
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231002181101.167176-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|PAXP193MB2172:EE_
X-MS-Office365-Filtering-Correlation-Id: a95e857c-d31b-4f9c-3e09-08dbc3733b65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQHHQYgNDqW4FM3MU+pTytdBku/jIqFvXj8irvkY6xTssx2zLRLzBU5aE684G62Ds8hRFCrkL7HmnfMZkibZxBY2mjdirIqU/lm94vgz0RFDC2D0p4erd9t7fajNbF80lr8fqDNTUOmLgkJSrpnCKRFKrDapkPvj0QK/KpkVlNylRzS0LyVVDjdB8CSFk05ARkapoJWNBOmxe4/HkLG2491Pi0BE/c3GBo3HW4U+b3v9B0WwdkfYhF/m3SkZm3yNlGVwWzSIBykJ42N/4pE4uc7s64QnncmmitS4d7Z+OBUdxH2V6mHibsmoq9GK61aK/pyqYP6RLarEBSGpd2Di7btBLXvT4C1gG3Jhnb24M7R9zeUYj6ihhtzx5MgImJRCbQ3VnewZfkLr1GTomkfTXBG+Sy3CCP3aC3bSvHfAVlIkcmTY3uLrq5dvS0v4MI/jmdsLS7VZVdxucALomaxj24ZIyewwndQGS455dZgonh+jFSIjIOBXrU+T09daFmx6FjQ4KxVd+smBd8S3UdBsnJM+eJRy9223ZVJI53fQtS3qjylVK2NnK1Jps7wSBUt24muYzn73/r6CJGbGF6ZUAS3kf+heDv1/J9KIh/BoEvv/do4mrBT7kHWZCHM/Y1Mve6KC5YNtCFYiO1N3U1SILl4MpJ7kKfZJ7ISsFVWo0K/fbk0Swj4dRnvkFx11V/L8HYKctVFQbs3zXYEgs7U20t3wfQBOGkhwb9J4qvj3UiPZ07CYpHrNerfAaI7yWv9t2+R2ym6MNqeveYyZT5okicS3G3uCoAGCdo+GGq1OTRTowHbRgg23UffcorQoZZ1jw/eFtjYkHfegMxhAFWy86LPXd+JUybObbvqxZmPjX9EeMAQlu9CYuTEfkl/83Snnoi9V1lF0SiGXSmVErkTy/FpqkqIQVvvsUPddIQweNz0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aygeNukl2WmGrWzifzdpl23p9oEocFuGm7ndYSGdTGoVdkbmqhosZeArDogw?=
 =?us-ascii?Q?aWC63b6MJMY8rsQxGniv3w+YDEB2mWZXGp43r3Djfkc9z7Ca9wnNZpGQPwGr?=
 =?us-ascii?Q?X85ZDokKzzYNfed1VHxvoyorCPj4l3j9m7wAGGGCZDZ5c9wIDd93nUWCN6pP?=
 =?us-ascii?Q?ma1Hli9e57E68Wp0MDYLGK5ck0lpnH3EdyUx2fPzlq88w3xFIgPx0HC3GiUT?=
 =?us-ascii?Q?S370r8GDBMMPYbmiiowKLQPdbbjVUK2b0DgbWu+burUnuMfBpUCZjJaogc9o?=
 =?us-ascii?Q?LreQiyNCuuqA3hPCoP3MfvfUQ/f7X82w3/6JBKvWBt/ViLuZ3RPCqqGDwuMS?=
 =?us-ascii?Q?LX8OwiCgEJBmS5WfE0xBYTb5laDSDwSFvr6czGsLWPsQ0RaPGP1BTkpcnArw?=
 =?us-ascii?Q?4RGI/SnMeOTw/7mOhTOKkC5GLSkXL1JWUR2ywqE6e/1Gy3GaORruHmpifMqE?=
 =?us-ascii?Q?pQXOqVmaihDqTktVj7XEhivPiyVSQoisHOCYroUmNK1L+u/hcfm5PknZm2SD?=
 =?us-ascii?Q?SHASLJXWTBQZlw+TZJ8Ar5eITk6tmJZsSTCFUjbk3mHRzTArlRW2azODsAaW?=
 =?us-ascii?Q?YyMc6Dq+rH0MCp81hmppIulj9iGRQ+3a/yvwGMB/woxhh6hQsA1IuUZ91JwF?=
 =?us-ascii?Q?GbKsnjgWUa4E8LfJVp7Rgzl4bRkXG08kHb9Et4AxmTVveCNl1PGikTxQtDsG?=
 =?us-ascii?Q?t0HX7o3dHmMaRaKm+Bm9CqUj60XTPTOTQ1Cm/7ZnxEO2DdWpMEeh5F/IN09z?=
 =?us-ascii?Q?Aec6nFeUiIvbr91rOPUeBpt/E+KOTwjZuT6TW4SV7maoc57u+aL7bX8xqsh7?=
 =?us-ascii?Q?4i9sFrW1AtsBaokQcWAxgqUDSJOctPed+DOYQj++CHqk5Gx5drHzbKpwMI/y?=
 =?us-ascii?Q?i8NaD7cfH7tGBd8heDrkkTPGdJluWiGL2mnHY/+I16Jaxcfb3q6OYHOdUjAp?=
 =?us-ascii?Q?yQot9B+PA+aKcQ0wIRVzMAJ4nQYTI601sFZyKzD1o+kG3ggM8/h8b0kGQTaZ?=
 =?us-ascii?Q?qQ9opPh1h2BAEgJhHFuYrOW/tRE5FR7utzs9ExMhUWcHVZUz96g7IUpCQfpy?=
 =?us-ascii?Q?SOCskGNyCQVc98CdGcPJRY3lbCGnuHE2Yj1x0Wi3twtEOkqEZ93knWZupzkB?=
 =?us-ascii?Q?1eP7OCMZCV9U9D/erOf/FHa44UO5J55HN30hnY9KdtZaXp3ILTDUVLA7WrrT?=
 =?us-ascii?Q?KBgTyO2BVGtq4TYzp0hNi9HMyMFP/won21tAJctFzk4+e4xcZ8aL9/rnZyg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95e857c-d31b-4f9c-3e09-08dbc3733b65
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 18:13:09.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2172
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Minix source code, s_imap_blocks, s_zmap_blocks,
s_ninodes, s_zones, s_firstdatazone, and s_log_zone_size should
be checked for validity when reading superblocks.

The following is the content of minix/fs/mfs/super.c:332

  /* Make a few basic checks to see if super block looks reasonable. */
  if (sp->s_imap_blocks < 1 || sp->s_zmap_blocks < 1
				|| sp->s_ninodes < 1 || sp->s_zones < 1
				|| sp->s_firstdatazone <= 4
				|| sp->s_firstdatazone >= sp->s_zones
				|| (unsigned) sp->s_log_zone_size > 4) {
	printf("not enough imap or zone map blocks, \n");
	printf("or not enough inodes, or not enough zones, \n"
		"or invalid first data zone, or zone size too large\n");
	return(EINVAL);
  }

This patch improve the validity checking of superblock based on the
Minix source code above.

Since the validity of s_log_zone_size is not currently checked,
this can lead to errors when s_log_zone_size is subsequently used
as a shift exponent.

The following are related bugs reported by Syzbot:

UBSAN: shift-out-of-bounds in fs/minix/bitmap.c:103:3
shift exponent 34 is too large for 32-bit type 'unsigned int'

UBSAN: shift-out-of-bounds in fs/minix/inode.c:380:57
shift exponent 65510 is too large for 64-bit type 'long unsigned int'

Reported-by: syzbot+2f142b57f2af27974fda@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2f142b57f2af27974fda
Reported-by: syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5ad0824204c7bf9b67f2
Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 fs/minix/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df575473c1cc..84c2c6e77d1d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -154,7 +154,11 @@ static bool minix_check_superblock(struct super_block *sb)
 {
 	struct minix_sb_info *sbi = minix_sb(sb);
 
-	if (sbi->s_imap_blocks == 0 || sbi->s_zmap_blocks == 0)
+	if (sbi->s_imap_blocks < 1 || sbi->s_zmap_blocks < 1 ||
+		sbi->s_ninodes < 1 || sbi->s_nzones < 1 ||
+		sbi->s_firstdatazone <= 4 ||
+		sbi->s_firstdatazone >= sbi->s_nzones ||
+		sbi->s_log_zone_size > 4)
 		return false;
 
 	/*
-- 
2.39.2

