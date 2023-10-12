Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF07C6BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378117AbjJLLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbjJLLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:09:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2094.outbound.protection.outlook.com [40.92.58.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382F594
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/8c8wTDinwn7cFxrB8UQxp/X/9Z5doFb9YCe8qFXGyOlKeNPlcp5z1yELnoi93sWpe+ZP6jkVcr8yG+gE0euCpqFNao95vKUcZaO+WnGuNuuIFIGcUnDD8SHY2lofrKVN2TvXxEXBEfD8Tu7Hk9utoXvOwBrPdvPZ81KJWccRNbTuxKOc05cNcSbi3BPFKxJPjOpYUgDGHBiW9vdeyMPGuh9+oVjvptvh7L36UZ06i4uoH8/E030ZEuOlU7fRsCJfge7TzUBaQN0BuRWL6X3oeqk8MxrI++iNxxl97c4mGzsg9DheRQ3C2RMTkxoaxGK5vR3iRUX55B/JD6KIvjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIPcVhKphvYHB9AXSn2UFPY/PSOBBuMD+WpuD5ZR1fs=;
 b=jvuMyheShFVLtC4r1O2RHEr/DDwLg9LkIAw0imyP9Ms/39hMqtZAzKsPkJdSUKc0GNS2PaUEyU7ST1p7muQcOcx4NK/bvGaNnaHI9Q0T5ZF6rVF8QtheWWho2Y4ThfRmDJr+kJJdSOPkCM5QYUFASkQjPCj0JoKJeUBoV48dqSPDWDi0ukLY5IFNWmrvwlggtwEqXPjX79L1BUGEuKAMbkcSafGxQgAAdStrFxDf9FlLPC3MWLDD1ZSC85hvE5xFKkP3ACdRDWJ8YZUrUEPgEKtbkbxGQn2/84tnqR40vbwHjvYuRV9jVv4DPHScvZDTRtAp5vP0GkFqnMveqWIGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIPcVhKphvYHB9AXSn2UFPY/PSOBBuMD+WpuD5ZR1fs=;
 b=nFv+h+xnK4cLKiVl+3n0Rlq+PBtywiOI2BNa1+MzSw2EiNqZiRLDyuWGRAH5wnVNFZ2SMNOTlnlgov7zFiKMos4PojnBdcb/fE+1CxzSaM3xJgiRiHG/GXn1zManSxSA+Iwv8d8eZDRXENEslxIkNMcJ+g+OSLlT15eITUELoeg2IaCj9wwFUv+2ZsnNUcg2eghcfjFYA3R7ToL7IHi0yGCsZZINI14vvKd9wOYrukaLwq1b5fON7nCPSD6uEwnMulQ6Vu3exaRkPpLBBbN2PrAUZNrs9WDuOrvTlf88ZO+UuDZzVeaNVZkoOVXZ594yfCHVeI+S+rSKxWkfEtxRqg==
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:32::19)
 by DBAP193MB1097.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Thu, 12 Oct
 2023 11:09:07 +0000
Received: from VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99]) by VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 ([fe80::af68:c2a:73ce:8e99%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 11:09:07 +0000
From:   Juntong Deng <juntong.deng@outlook.com>
To:     brauner@kernel.org, jlayton@kernel.org, jack@suse.cz,
        gregkh@linuxfoundation.org, xiubli@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+2f142b57f2af27974fda@syzkaller.appspotmail.com,
        syzbot+5ad0824204c7bf9b67f2@syzkaller.appspotmail.com
Subject: [PATCH] fs/minix: Improve validity checking of superblock
Date:   Thu, 12 Oct 2023 19:07:22 +0800
Message-ID: <VI1P193MB0752662A4587C90C3DD4C5DB99D3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [HTVgY1J+M33/W0pqfi8I1pgRVoMzJS+H]
X-ClientProxiedBy: LO6P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::15) To VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:32::19)
X-Microsoft-Original-Message-ID: <20231012110722.11153-1-juntong.deng@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0752:EE_|DBAP193MB1097:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d2b238-d9a5-412a-ef2d-08dbcb13a684
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bODEC29oWXM+1MXfOTLjKSUh8zwk3La69kDSltEsxvwx/PblSasMSJA39hKwTaV+NFIVHTLTTn/RJNZiiGiCSPZMe8BbUN2eWGKT5U2cVNjyxIaAk81n6T2kuFfnyjG1cYloS3aebiZdoK9HhH7J7bRuq2I1RGjY4cBXilMqCGJ8L0X1iTKu7e3g/w3t64aPmuM5vbu7b/OYBo2c5BFTHYppBBgVe+LuH5cXOQBKTgzbR7qySIFVIAJj1fssHfrnMccX1+HDmDND/ZoUXUexgq7cfukjvpbbhw9ezxxpJJeXspn0bZxeizRp6eNlBw3diOfWNU/mLFztrZdwUHcpUF6DENmIJBxIIzJWQFfP8VeHaewbUcdoHczJM/L7NfdXhuOJ4iIcP19xl9+d5dFtuczFmGJ7/e7QcTUHhU7JAg/4doWIghe+yNTbBXMUqRSJ5gqWdkKt4DxBHb7Ug44PD9R4DiPizGUUiwJTS5HFRipFnc2QcZN5sGQOZsOWA1NX0C9DVhFSuGVlDIls8/quYgc86+PiQ8lT+2SZLyEhR0C99e1Ug9isD8G4ja87oIoRc8pCmWbyX1VW+o2hsVRJG/7i9r7ma9WSJ+TmDLbXAdUmihj3ilRWNO4pQVU+YGuO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1nodr4h7j6jrQnzCZ5lrZP/BdQHvZTrI85fYA7YKCt1GZGTDk6P4vMpDBdG?=
 =?us-ascii?Q?bxKAmF4TOiAdasN35MRCPORjwDT58WKOcHODM2c4anONRHCDofTsm3FeJSHI?=
 =?us-ascii?Q?lvxevArKIk8bDimXNNEnqb3+Sn8ImmHYQhiSbHEdOQ/ihFJinrKlTeLPKfVp?=
 =?us-ascii?Q?eHIDCsQMwObUfkzFdtK1cSR60O72d6MOR6KIYlaIH1JJczFaA5gxTRBKGxOj?=
 =?us-ascii?Q?OMoOcgrclJVeGM/TUbGgzTqAwABEJp1cxHgYbM8Qf6g3/itySfXMeTpEffzz?=
 =?us-ascii?Q?kXFfqrOQd5aPS8rUeH9E2bc+Xd1Q8gAPfdbvAbvrj1XmBDGx1rZxVf4XnmqQ?=
 =?us-ascii?Q?e4CJZAt6Mqcc33HLRk3ybZy9gZgfE1YA4g1PER3hemvuwUpAarw5HNepTbo7?=
 =?us-ascii?Q?xHbkLg8lb2tjaTvMwv7SWsVCcw5x+8Xu/4zVf+crTGB/MSZGiVvj0yiAPYsB?=
 =?us-ascii?Q?ys5xmBDZdCWmlDmfQsIM3rXEjBN1OEoH/jlfo9ByygsAurLbXz5kbK/a/BjN?=
 =?us-ascii?Q?32BOc10eiUuOYEo1+jA7pq5zuDiPe3rNwY5kH4xvHR3i0FwgXsbDk3+uykgs?=
 =?us-ascii?Q?pimqZpnALjUBtW9xi2tLFg5wXwXhE8vXwZN5HhsAieUzsRQUmp4A+7qjM9Mg?=
 =?us-ascii?Q?26MV1O17lpIqmzFPmwh4ORoa2dsFqa+mg47nWBSNAZVTKteTWj3WD9lEzqdW?=
 =?us-ascii?Q?apz2YguyeWfgq7Mf2+dWyZ9o8XkiTlT8OvrJ6QvUVO+qNjpNyo0JBnUivG4u?=
 =?us-ascii?Q?RkPhvrldB61w9cdnvzRMFQfg4HVQHQ07M1oBsBrCMa+oh6bqPcndvEl5OeTa?=
 =?us-ascii?Q?9th++3Og50iUfOZCe+BtNSaigdgh3JRHyyVC59Y/E8c5M47Ql/zDo0f5yefE?=
 =?us-ascii?Q?my7GV0nEMMoQJcb9h27X5AmEFhUpYnTOSHeGF3dnmc6dcMbnESt2Pd7PdLvI?=
 =?us-ascii?Q?iEaU1n4KTC4yZVRH4de7v0IjD0A01sElJ8OZcO5dUAwmnp6espc1LeT/8xC4?=
 =?us-ascii?Q?SpQbTya67NhIgyBfJehiyxyDWeffpDQ5TnchemK3FIEWWAwzQ+niTjVFmepu?=
 =?us-ascii?Q?vf6mRboK3TXj6N14WN1uHNOCmXpW8NhVflxfHsrrOUXBSD1wp+7QGICL50qu?=
 =?us-ascii?Q?CKSUONB0QEXPj6wUuYATksy6/uZrGym1z0JRewpg38qQAS8bpDaZhhgb4+xv?=
 =?us-ascii?Q?lo683hfdNlnUnpZSDw1i0VetpCzzaXH+y96SWNOBuk4B72HU6s+gJHvSA0I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d2b238-d9a5-412a-ef2d-08dbcb13a684
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0752.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:09:07.2034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB1097
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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

