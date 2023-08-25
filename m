Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0FD787F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjHYFeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjHYFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:34:07 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7046F1BC2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:34:01 -0700 (PDT)
X-UUID: c9b0efa59e364453838be3e90bce43c6-20230825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:cbe6e406-667a-437c-b991-cddf18e07cd9,IP:-32
        768,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FIL
        E:-32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-INFO: VERSION:1.1.31,REQID:cbe6e406-667a-437c-b991-cddf18e07cd9,IP:-3276
        8,URL:-32768,TC:-32768,Content:-32768,EDM:-32768,RT:-32768,SF:-32768,FILE:
        -32768,BULK:-32768,RULE:Release_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:nil,BulkID:nil,BulkQuantity:0,Recheck:
        0,SF:nil,TC:nil,Content:nil,EDM:nil,IP:nil,URL:nil,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c9b0efa59e364453838be3e90bce43c6-20230825
X-User: wangxuewen@kylinos.cn
Received: from wxw-qitianm428-n000.. [(39.156.73.13)] by mailgw
        (envelope-from <wangxuewen@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 160933064; Fri, 25 Aug 2023 13:33:26 +0800
From:   wangxuewen@kylinos.cn
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, yangtiezhu@loongson.cn,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        wangxuewen <wangxuewen@kylinos.cn>
Subject: [PATCH] loongarch/configs: Add support for gfs and jfs filesystem type
Date:   Fri, 25 Aug 2023 13:33:22 +0800
Message-Id: <20230825053322.60328-1-wangxuewen@kylinos.cn>
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

From: wangxuewen <wangxuewen@kylinos.cn>

When the device sdx is formatted as gfs or jfs, execute the command
"mount /dev/sdx /mnt",we get:
"mount: /mnt: unknoen filesystem type 'gfs'"
"mount: /mnt: unknoen filesystem type 'jfs'"

Signed-off-by: wangxuewen <wangxuewen@kylinos.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index d64849b4cba1..d8db1f64f00b 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -759,9 +759,11 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 CONFIG_EXT3_FS_SECURITY=y
+CONFIG_JFS_FS=M
 CONFIG_XFS_FS=y
 CONFIG_XFS_QUOTA=y
 CONFIG_XFS_POSIX_ACL=y
+CONFIG_GFS2_FS=M
 CONFIG_BTRFS_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
-- 
2.34.1

