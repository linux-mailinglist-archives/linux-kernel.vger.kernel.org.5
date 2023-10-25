Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAA27D62A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjJYH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJYH3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:29:37 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A5BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:29:32 -0700 (PDT)
X-UUID: 87674daba95f4c1fb6c5e9a8ab3f6fb9-20231025
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:25f7ecb1-4241-4f84-af31-99c1aff6c385,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:25f7ecb1-4241-4f84-af31-99c1aff6c385,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:86c0bffb-4a48-46e2-b946-12f04f20af8c,B
        ulkID:2310251520142F2IHU4N,BulkQuantity:3,Recheck:0,SF:66|38|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 87674daba95f4c1fb6c5e9a8ab3f6fb9-20231025
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 551621778; Wed, 25 Oct 2023 15:29:18 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     joseph.qi@linux.alibaba.com, jlbec@evilplan.org, mark@fasheh.com
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        kunwu.chan@hotmail.com, Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] ocfs2: Fix a spelling typo in comment
Date:   Wed, 25 Oct 2023 15:29:06 +0800
Message-Id: <20231025072906.14285-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a spelling typo in comment.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/ocfs2/buffer_head_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 6cb919f60011..cdb9b9bdea1f 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -345,7 +345,7 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 				if (new_bh && bh) {
 					/* If middle bh fails, let previous bh
 					 * finish its read and then put it to
-					 * aovoid bh leak
+					 * avoid bh leak
 					 */
 					if (!buffer_jbd(bh))
 						wait_on_buffer(bh);
-- 
2.34.1

