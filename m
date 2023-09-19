Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB227A6541
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjISNev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjISNet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:34:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F80F4;
        Tue, 19 Sep 2023 06:34:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RqjM20HRpz4f3xcD;
        Tue, 19 Sep 2023 21:34:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgD3jd1vowll6Gp5Aw--.33633S4;
        Tue, 19 Sep 2023 21:34:39 +0800 (CST)
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
To:     bristot@kernel.org, rostedt@goodmis.org, corbet@lwn.net,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bobo.shaobowang@huawei.com
Subject: [PATCH] rtla: fix a example in rtla-timerlat-hist.rst
Date:   Tue, 19 Sep 2023 21:30:28 +0800
Message-Id: <20230919133028.697144-1-xiexiuqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3jd1vowll6Gp5Aw--.33633S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr45Gw1UAw18AryfZFW8JFb_yoW8Ar48pr
        Wjqrna9ryDZwnrJan7JwnrXry2ya97XF4UAFs8JF1293W3C3Z5KFn7Kw45AF43uF1xCa9F
        va1Fv3sxAw1Ik37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr
        1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
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

The following error message is reported when running the example in document.

  # timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1ms --no-aa
  Failed to set timerlat period
  Could not apply config

The unit of the period is microsecond, '1ms' cannot be accepted.

  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] ...
         ...
	  -p/--period us: timerlat period in us
         ...

Also fix another minor missleading comment.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 Documentation/tools/rtla/rtla-timerlat-hist.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 057db78d4095..03b7f3deb069 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -36,11 +36,11 @@ EXAMPLE
 In the example below, **rtla timerlat hist** is set to run for *10* minutes,
 in the cpus *0-4*, *skipping zero* only lines. Moreover, **rtla timerlat
 hist** will change the priority of the *timerlat* threads to run under
-*SCHED_DEADLINE* priority, with a *10us* runtime every *1ms* period. The
+*SCHED_DEADLINE* priority, with a *100us* runtime every *1ms* period. The
 *1ms* period is also passed to the *timerlat* tracer. Auto-analysis is disabled
 to reduce overhead ::
 
-  [root@alien ~]# timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1ms --no-aa
+  [root@alien ~]# timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1000 --no-aa
   # RTLA timerlat histogram
   # Time unit is microseconds (us)
   # Duration:   0 00:10:00
-- 
2.25.1

