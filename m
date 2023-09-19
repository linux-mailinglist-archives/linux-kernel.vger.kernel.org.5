Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1813F7A664D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjISOPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjISOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:15:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A5AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:15:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqkGD0HBsz4f3nJs
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:15:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgAnvdwErQllkNB7Aw--.46916S7;
        Tue, 19 Sep 2023 22:15:33 +0800 (CST)
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
To:     masahiroy@kernel.org, mcgrof@kernel.org, joe@perches.com,
        ojeda@kernel.org, ndesaulniers@gooogle.com,
        linux-kernel@vger.kernel.org
Cc:     xiexiuqi@huawei.com
Subject: [PATCH 3/3] scripts/export_report.pl: fix modversion checking
Date:   Tue, 19 Sep 2023 22:11:21 +0800
Message-Id: <20230919141121.711084-4-xiexiuqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919141121.711084-1-xiexiuqi@huaweicloud.com>
References: <20230919141121.711084-1-xiexiuqi@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnvdwErQllkNB7Aw--.46916S7
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4ktryrJFy8WrW5tr1xGrg_yoW8Jr1kpa
        yvk3yDGrWDtr1kAa4kJrn29347KwsI9r48Wr17Gr15WFy5XFs2kF9Ikr90grWY9rWIyay2
        g3Wvy398tF1UCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQZ2-UUUUU=
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

The definition of the "__versions" section has changed, so use the
newest format. Otherwise, the list of export-symbol-usage is empty.

  $ make export_report
  ...
  SECTION 2:
          This section reports export-symbol-usage of in-kernel
  modules. Each module lists the modules, and the symbols from that module that
  it uses.  Each listed symbol reports the number of modules using it
  
  NOTE: Got 9 CONFIG_MODVERSIONS warnings

Fixes: a3d0cb04f7df ("modpost: use __section in the output to *.mod.c"),
Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) to __section("foo")")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 scripts/export_report.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index eda570224a2d..54132a6a78ba 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -122,7 +122,7 @@ foreach my $thismod (@allcfiles) {
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\(\"__versions\"\)/);
 			next;
 		}
 		if ($state == 2) {
-- 
2.25.1

