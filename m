Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEB78E520
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbjHaDps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjHaDpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:45:45 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0CCC2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:45:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbnBB5tMhz4f3lgD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:45:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
        by APP4 (Coremail) with SMTP id gCh0CgAXp6niDPBkLzv8Bw--.12879S4;
        Thu, 31 Aug 2023 11:45:40 +0800 (CST)
From:   Xie XiuQi <xiexiuqi@huaweicloud.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, irogers@google.com, acme@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yangyingliang@huawei.com
Subject: [PATCH v3] tools/mm: fix undefined reference to pthread_once
Date:   Thu, 31 Aug 2023 11:42:05 +0800
Message-Id: <20230831034205.2376653-1-xiexiuqi@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAXp6niDPBkLzv8Bw--.12879S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr47AryUKryUur4xZF4xZwb_yoW8Cr4kpa
        yqkryDAF18XayIka97Ww40vrWUKFy2qa18tFyxGw4YgFy3J3y3Cr9F9Fy2vF1fZrW8Ja15
        Jw4UG3Z5WrW0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
        W3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lh5xhxtlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie XiuQi <xiexiuqi@huawei.com>

Commit 97d5f2e9ee12 ("tools api fs: More thread safety for global
filesystem variables") introduces pthread_once, so the libpthread
should be added at link time, or we'll meet the following compile
error when 'make -C tools/mm':

  gcc -Wall -Wextra -I../lib/ -o page-types page-types.c ../lib/api/libapi.a
  ~/linux/tools/lib/api/fs/fs.c:146: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:147: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:148: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:149: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:150: undefined reference to `pthread_once'
  /usr/bin/ld: ../lib/api/libapi.a(libapi-in.o):~/linux/tools/lib/api/fs/fs.c:151:
  more undefined references to `pthread_once' follow
  collect2: error: ld returned 1 exit status
  make: *** [Makefile:22: page-types] Error 1

Fixes: 97d5f2e9ee12 ("tools api fs: More thread safety for global filesystem variables")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Matthew Wilcox <willy@infradead.org>

---
v3: add it to both CFLAGS and LDFLAGS
v2: use '-pthread' instead of -lpthread'
---
 tools/mm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mm/Makefile b/tools/mm/Makefile
index 6c1da51f4177..1c5606cc3334 100644
--- a/tools/mm/Makefile
+++ b/tools/mm/Makefile
@@ -8,8 +8,8 @@ TARGETS=page-types slabinfo page_owner_sort
 LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
 
-CFLAGS += -Wall -Wextra -I../lib/
-LDFLAGS += $(LIBS)
+CFLAGS += -Wall -Wextra -I../lib/ -pthread
+LDFLAGS += $(LIBS) -pthread
 
 all: $(TARGETS)
 
-- 
2.25.1

