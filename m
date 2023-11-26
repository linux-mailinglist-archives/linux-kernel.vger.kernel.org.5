Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF87F9698
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjKZXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:39:24 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2064.outbound.protection.outlook.com [40.92.89.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16E8DD;
        Sun, 26 Nov 2023 15:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAvcSvdbG+TokyzFQK1bDcgJ9QyWgLP0zjWe+RTiZcZZ26ieoYk6vSkZTGLp1yl5xZ5lL8ulhZG6bLnzuR2QJ0pOYlbzGbGEOMgDI8uwquI6Xl0jKJXHJbsFaBXR60IB6sxCcvL1AVd/iGfUGqn4yf9lQfYDTxzzXohH00xhjacruJnQM0Igah63uC786B9IaElAvUToo1rmHakmYL9zju0IK7qeioG5YLAWU7/dbegmtZu9LvayDcj6Ow6RRMhqqjnGnEKYV9IYLC1QCL9ZukkPxOsSw57e5vjH8iZse7emDl4h4EF9cD1wqUqs9ybf4WK6tqiTLbL8DotgJ8uKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wf+qiAITpnKX5V8KOqn8kUOQxbUAxlqd0GbJVHRDbg=;
 b=BbE01dY7BeOOTQ/BMmjQde91NESiCZjNYLBxi4Ue+J9O4a5wFZMmtFXV4x0P8Hiih5XMS13fQA7znC0ZHqvxp8JvnIyyc58MU8HMT35RRjzL5iVuyV1IxeyP1Hu+B4ZWwe6kBXAQ5oIiJeLrWhBhA3RUCBDzHMnkm6IZce/GIi6rMMHKxiERVYAZ7fbkp8/0tp6p21DHVoJOT4HZgU9Lj+UyEQOz1fzdUo33+qZuAOad/x7YLuq7/s2ym4OnGBND1e0RY+qbuK6WmIs5AlxGFTTW218ayBBCgpK+V8HJpAwUldxocpl/X7D5dV+Iu3MDmfdG2BPcnlRmaCco4Nn4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wf+qiAITpnKX5V8KOqn8kUOQxbUAxlqd0GbJVHRDbg=;
 b=EAtrJ90aKROk+dFLxi3P8aLBtjymE1ZcjqtotdiUYvmyU1ue3QKfHrYU1KsnyzbVVemvM3797PRS/JBVx9vjfLArL8x44QegEr0hJWesaPbcNd+nuEnUXZC1JATNc8HtP9nMEkNbqLs2U6HMEFDu7BRgooQiH7ISTPeMK5eA2dPEpQgV4Ax015PeA9nDs0hYkjNGeZ2qvwZHzaZGLqsrDZ9pzIV4cP8H8JCLY3lsy//RilT4cbgVJ9HrhURiNzwt8Gv1VTLeacdI4dkRdz15P4sFdE6bBBqNgqjJrzg0BML9eur0p5w4DsGLHZhtLZKlczFquvfrJOjoFzZQypLqzw==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by PA4PR10MB5634.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 23:39:23 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 23:39:23 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     aivazian.tigran@gmail.com
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        syzbot+dc6ed11a88fb40d6e184@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] bfs: Fix null pointer dereference in bfs_move_block
Date:   Mon, 27 Nov 2023 05:09:05 +0530
Message-ID: <GV1PR10MB65635AA7F497FC3EA6235261E8BEA@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [MH/znPivgDYjYWp36sNZI4/nA7Hvj2kS]
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID: <20231126233905.717828-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|PA4PR10MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c3ef28-4071-4e39-f3ef-08dbeed8eb4b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CkSnsF6QX0/5tqMN52I1CJUqCF+K4MIS3mw2asbWhqRbro6z+A65rqdYP4mWeCl/r7WjCSXGxDq+ckGBPhJeGlHHA6DmZcrOcVW0MLY3z8M8bQz1SP2y9rUoYAigNi/khMo6jIsqaHYVPfC6axVp/zDRiQZyz6He7jTDamzr+O0OvPe9EPsTU+uT6wQCvojxACGuAkx6RP0hCBoNiTb5ky4iu8+1re7dw/U0LJ8/e8dE6/bIWNzAXkAcQOYmPwlKQygMjOwhZcWt9lKYr8jp/m1zk4YwrNxUahv9SY5NiOi2R5/1vCqqB+WJS5LBW0gnF1Mqf0PCCVqHoNcFwnjBRtH15YXs9EJ1eqQAWnjd5qsCHhrosfMk6jAjByrk+xl0obtPZX5ncc5guEHp6+99E18MO+Cn6BL5rqCR0eeas1J6r5LQcGUOF88Ms499HiwacApr3+0Ae9lsmZcR6wKr0v5DfQTbMsuQcYatIrj1U6t/zgxxsfoB7gb1pQVYrS6XBhmH4xkdgtZ5P4uI2LVmdCo9p7mK5GicsY4rWCsrf2GOtHh0lP0cw+vjdHey35xH35qQRUW0obMFUGJhAJzeqE3oEqsmkcSu7ZpSoq5CS9OmzECzgyIZK6+cAybhdXr+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4McsMYtSb0CAZnRaKX4+L2A55Njpq0bV+oByCXaBaz5QoFHPT4yaN3ZwJVF?=
 =?us-ascii?Q?fgh0PRiH5f2iE18ByFGpcpFzyQmO9Z619b/LkCpd9yjA/6NwkA4bek697Csj?=
 =?us-ascii?Q?ThEj/bBtKwZclclaTztPNJzdvwxiV7EYHlWuz6/xRCVhthl+D33+cU/TQWXR?=
 =?us-ascii?Q?A3YmUvur6YEQzJvAUJ6unlqSDHFUag868UV4JG+i/kBjyGvjE+Lj5emOQbrZ?=
 =?us-ascii?Q?C+PaUx4c9/DTsFQU1BKxi1rT4nTXlet1TAevzdUFnEB6s/cvT9vU90T11j1M?=
 =?us-ascii?Q?mV0h/JGF+CEeRlvCBzmFtzO8RUsBt47nbGjbbKNnFQ6wczL4wz1IfaqYONut?=
 =?us-ascii?Q?3bf/jSkp01J7hRl+fZJcogdmWGwhjFYIQb6oaNhepAKGq958uuKxPYfdTXPi?=
 =?us-ascii?Q?z26A6IBa8pA02KWBhA+k96CETfgnCMlwiZ5fwvNT8Gyajlr99xz4cWzmUNgZ?=
 =?us-ascii?Q?ek2BLzgb6RvtWaRG9gv8fAMq72wIxLn2eU3svahBGTrsyCkpWRd/4Vz+C+9u?=
 =?us-ascii?Q?FnwipGt486Sv8xdRqTQwOX/vQt+nfkqJiQhDCLJj5E4sq46Nu13J158YHLyV?=
 =?us-ascii?Q?JFggh9iqwSirgkxBx7XTZmdWU1YRgFA+8C9AyEZ87RyHDJEtak+gZLNRZvd0?=
 =?us-ascii?Q?EGm9HksNoaCE0VqtjCIyTr1tG9Quf+epfXAi+gwvQir3A7jrr4RSpHeWm8Hf?=
 =?us-ascii?Q?2JzdamNkkvVE/rf3Jov0ave15QcY1wLP9Dbeb9A/8TrFQJiNrlbCda/Bv6oJ?=
 =?us-ascii?Q?WMwTpljtXsmtLQuZpQH2vYmRi8pkFFDZJiu9g9yGRTeLT5Ni2fG4Tun/Kj+k?=
 =?us-ascii?Q?4Js7A6YgL/Z2ssyc294kyce1odRoctyzOky4WcQrdP+9se5T4Y5ae2yLzX90?=
 =?us-ascii?Q?eQ/GqP8I1stTQQmQb/SsypGkQlSdbzxybrwCnAvcA7t2cTMnhVZoI6RCsTLR?=
 =?us-ascii?Q?VHEudEb6SXCkcN0Oo7CSMb76V//OQSniSSA1HRHSP19YOBl5hZtGxRtbBA9h?=
 =?us-ascii?Q?XD3GWDaF24DNrMPx/jL9+dmffoN/thPbMfTQmhqkeob682ChO1Zz7yGee99/?=
 =?us-ascii?Q?rR66sm3sTdhGLHBTTG2CnhZPEZA0nGJ8dfLD0cwiUK/jVd4D4xCVU1na7z9K?=
 =?us-ascii?Q?tY27yw/K6xXaviaLcWPYafeAa5bovKcAGqfJDJuOkEtN6qVWWqjCKqEluu/7?=
 =?us-ascii?Q?gULfVzCnp/J76tzRAwSIkG4tihPQO+GuUQQHeuNK8g/+romP6hTgXmT0Zq4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c3ef28-4071-4e39-f3ef-08dbeed8eb4b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 23:39:23.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported a NULL pointer dereference in
bfs_move_block.

sb_getblk may return a NULL pointer, and if unchecked
this can lead to a NULL pointer dereference. This is
the case in bfs_move_block, where `new` is not checked
before being dereferenced in the memcpy call.

This patch adds a propper check to the return value of
sb_getblk, stored in `new` and ensures that any previously
allocated resource, is deallocated before returning with
an appropriate error code if the `new` pointer is NULL.

Closes: https://syzkaller.appspot.com/bug?extid=dc6ed11a88fb40d6e184
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 fs/bfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index adc2230079c6..8a97909b1484 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -38,7 +38,12 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	bh = sb_bread(sb, from);
 	if (!bh)
 		return -EIO;
+
 	new = sb_getblk(sb, to);
+	if (!new) {
+		bforget(bh);
+		return -ENOMEM;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);
-- 
2.25.1

