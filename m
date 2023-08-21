Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2379D7822B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjHUERu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjHUERu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:17:50 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F9AB93
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:17:47 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="63057912"
From:   sunshijie <sunshijie@xiaomi.com>
To:     <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
        <jefflexu@linux.alibaba.com>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        sunshijie <sunshijie@xiaomi.com>
Subject: [v2] erofs: don't warn dedupe and fragments features anymore
Date:   Mon, 21 Aug 2023 12:17:37 +0800
Message-ID: <20230821041737.2673401-1-sunshijie@xiaomi.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX08.mioffice.cn (10.237.8.128) To BJ-MBX18.mioffice.cn
 (10.237.8.138)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_SOFTFAIL,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `dedupe` and `fragments` features have been merged for a year.  They are
mostly stable now.

Signed-off-by: sunshijie <sunshijie@xiaomi.com>
---
 fs/erofs/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 566f68ddf..075d476a4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -420,10 +420,6 @@ static int erofs_read_superblock(struct super_block *sb)

        if (erofs_is_fscache_mode(sb))
                erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
-       if (erofs_sb_has_fragments(sbi))
-               erofs_info(sb, "EXPERIMENTAL compressed fragments feature in use. Use at your own risk!");
-       if (erofs_sb_has_dedupe(sbi))
-               erofs_info(sb, "EXPERIMENTAL global deduplication feature in use. Use at your own risk!");
 out:
        erofs_put_metabuf(&buf);
        return ret;
--
2.41.0

#/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
