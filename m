Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8311E79347E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjIFEua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIFEu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:50:29 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFF1A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:50:21 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-03 (Coremail) with SMTP id rQCowACHjo4HBfhk0uEgCw--.42909S2;
        Wed, 06 Sep 2023 12:50:16 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pengpeng@iscas.ac.cn, Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] mm/shmem: remove dead code can not be satisfied by "(CONFIG_SHMEM)&&(!(CONFIG_SHMEM))"
Date:   Wed,  6 Sep 2023 12:50:12 +0800
Message-Id: <20230906045012.14999-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjo4HBfhk0uEgCw--.42909S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWfZw4Dtr17tFW3XFyfCrg_yoWfWFX_Xa
        yfXF12kryUXFnI9rsYgr43Aw4Fv392gFWagryqqayYy3WDtw48Ja9rG39xG347ZFsxtrsx
        AanrJF4fKF1Y9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjco7JUUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

The value of “.fs_flags” in line 4608 is a dead code
which will never be implemented，because its conditions of
line 47 "#ifdef CONFIG_SHMEM" and line 4607 are mutually exclusive.
It is recommended to delete redundant code.

Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 mm/shmem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 13c27c343820..be050efe18cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4602,11 +4602,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-#ifdef CONFIG_SHMEM
 	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
-#else
-	.fs_flags	= FS_USERNS_MOUNT,
-#endif
 };
 
 void __init shmem_init(void)
-- 
2.17.1

