Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637D57A664E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjISOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjISOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:15:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B31A1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqkGD3WQLz4f3kjy
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:15:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdwErQllkNB7Aw--.46916S5;
        Tue, 19 Sep 2023 22:15:33 +0800 (CST)
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
To:     masahiroy@kernel.org, mcgrof@kernel.org, joe@perches.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org
Cc:     xiexiuqi@huawei.com
Subject: [PATCH 1/3] scripts/export_report.pl: fix the path suffix of module
Date:   Tue, 19 Sep 2023 22:11:19 +0800
Message-Id: <20230919141121.711084-2-xiexiuqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919141121.711084-1-xiexiuqi@huaweicloud.com>
References: <20230919141121.711084-1-xiexiuqi@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdwErQllkNB7Aw--.46916S5
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy8Jw4UAr4DWr1UWw4xCrg_yoWfAFg_uw
        sFg3yrWr47XF1qyr4UJrs0yF1rA34YyrsxCF15JF95ur1DGrZ3uF9xJ3s3WrW3Grs093yr
        Aa1qq34UAa18AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_JFC_Wr1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
        8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
        021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
        4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
        oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU1xsqJUUUUU==
X-CM-SenderInfo: x0lh5xhxtlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie XiuQi <xiexiuqi@huawei.com>

Since commit f65a486821cf ("kbuild: change module.order to list *.o instead of *.ko"),
modules.order stores .o instead of .ko. Therefore, fix it in export_report.pl.
Otherwise, the corresponding .mod.c file cannot be found.

Fixes: f65a486821cf ("kbuild: change module.order to list *.o instead of *.ko")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 scripts/export_report.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..fa3e47ac7c3b 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -54,7 +54,7 @@ sub collectcfiles {
     my @file;
     open my $fh, '< modules.order' or die "cannot open modules.order: $!\n";
     while (<$fh>) {
-	s/\.ko$/.mod.c/;
+	s/\.o$/.mod.c/;
 	push (@file, $_)
     }
     close($fh);
-- 
2.25.1

