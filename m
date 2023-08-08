Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E47736DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjHHCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHHCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:42:07 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E92E78
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:42:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RKcsM1ZJQz4f3lKf
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:41:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6l1q9FkbBbIAA--.8214S6;
        Tue, 08 Aug 2023 10:42:02 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/2] hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
Date:   Tue,  8 Aug 2023 10:41:46 +0800
Message-Id: <20230808024146.1335-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230808024146.1335-1-thunder.leizhen@huaweicloud.com>
References: <20230808024146.1335-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6l1q9FkbBbIAA--.8214S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UGw45KFWUuF17Jw1kZrb_yoW5Ww1rpa
        s0gryUGF40gF4xGr1UJFWUCr1jyrZ8Ca40kFWqyw109ryxWFW7Xw4kJFW3Gr15GrWFqFnx
        Jry7t3s8Kr1UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8y89tUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Currently, function print_hex_dump() supports three dump prefixes:
DUMP_PREFIX_NONE, DUMP_PREFIX_ADDRESS and DUMP_PREFIX_OFFSET. But for some
usage scenarios, they don't work perfectly. For example, dump the content
of one task's stack. In order to quickly identify a stack frame,
DUMP_PREFIX_ADDRESS is preferred. But printing multiple 64-bit addresses
is a bit unwise when the 'sp' value is already printed. It is redundant.

For example:
dump memory at sp=ffff800080883a90:
ffff800080883a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
ffff800080883aa0: 5833f000 ffff3580 00000001 00000000
ffff800080883ab0: 40299840 ffff3580 590dfa00 ffff3580
ffff800080883ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
ffff800080883ad0: 40877180 ffff3580 590dfa00 ffff3580
ffff800080883ae0: 4090f600 ffff3580 80883cb0 ffff8000
ffff800080883af0: 00000010 00000000 00000000 00000000
ffff800080883b00: 4090f700 ffff3580 00000001 00000000

Generally, we do not dump more than 64 KB memory. It is sufficient to
print only the lower 16 bits of the address.

dump memory at sp=ffff800080883a90:
3a90: 80883ac0 ffff8000 3d8e936c ffffbd5b
3aa0: 5833f000 ffff3580 00000001 00000000
3ab0: 40299840 ffff3580 590dfa00 ffff3580
3ac0: 80883b30 ffff8000 3d938b28 ffffbd5b
3ad0: 40877180 ffff3580 590dfa00 ffff3580
3ae0: 4090f600 ffff3580 80883cb0 ffff8000
3af0: 00000010 00000000 00000000 00000000
3b00: 4090f700 ffff3580 00000001 00000000

Another benefit of adding DUMP_PREFIX_ADDRESS_LOW16 is that we don't have
to worry about %p outputting address as hashed value.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/printk.h | 1 +
 lib/hexdump.c          | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8ef499ab3c1ed2e..ccad9e8eaaf0c31 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -704,6 +704,7 @@ extern const struct file_operations kmsg_fops;
 enum {
 	DUMP_PREFIX_NONE,
 	DUMP_PREFIX_ADDRESS,
+	DUMP_PREFIX_ADDRESS_LOW16,
 	DUMP_PREFIX_OFFSET
 };
 extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 1064706d57c15ed..9458738de397e84 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -281,6 +281,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
 			break;
+		case DUMP_PREFIX_ADDRESS_LOW16:
+			printk("%s%s%04lx: %s\n", level,
+			       prefix_str, 0xffff & (unsigned long)(ptr + i), linebuf);
+			break;
 		case DUMP_PREFIX_OFFSET:
 			if (!width) {
 				unsigned long tmp = len - 1; /* offset start from 0, so minus 1 */
-- 
2.34.1

