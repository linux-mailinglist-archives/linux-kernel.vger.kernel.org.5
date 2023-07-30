Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7812B76844E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjG3H60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG3H6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 03:58:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D52461BEA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 00:58:21 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cxc_AcGMZk9U8MAA--.29722S3;
        Sun, 30 Jul 2023 15:58:20 +0800 (CST)
Received: from openarena.loongson.cn (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxDc8bGMZk92ZAAA--.38932S2;
        Sun, 30 Jul 2023 15:58:19 +0800 (CST)
From:   Sui Jingfeng <suijingfeng@loongson.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] linux/list.h: Adjust coding style of the __list_del()
Date:   Sun, 30 Jul 2023 15:58:19 +0800
Message-Id: <20230730075819.39410-1-suijingfeng@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc8bGMZk92ZAAA--.38932S2
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKF45trW3Zr1UWFyfuF1fZrc_yoWfJFX_Za
        4xJw1xur1UZrZ0v34xuF92vFWY93s7J3WDuFn3twsrZFyDKFs09ay8CFnxW3y5ur43Wr98
        AFn5JF92kF1xWosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVWU
        JVW8JwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
        Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it consistent with the rest of the source code,
Also because "foo * bar" should be "foo *bar".

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index f10344dbad4d..09404cc89a34 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -109,7 +109,7 @@ static inline void list_add_tail(struct list_head *new, struct list_head *head)
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_del(struct list_head * prev, struct list_head * next)
+static inline void __list_del(struct list_head *prev, struct list_head *next)
 {
 	next->prev = prev;
 	WRITE_ONCE(prev->next, next);
-- 
2.34.1

