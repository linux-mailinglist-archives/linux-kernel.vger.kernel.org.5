Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE9770E64
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHEHWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHEHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:21:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D77B4EC8
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:21:42 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RHvCP1z22z4f3m6q
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:21:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZR_+M1kFAdsPg--.4573S6;
        Sat, 05 Aug 2023 15:21:38 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/2] hexdump: add a new dump prefix DUMP_PREFIX_ADDRESS_LOW16
Date:   Sat,  5 Aug 2023 15:21:16 +0800
Message-Id: <20230805072116.1260-3-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
References: <20230805072116.1260-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZR_+M1kFAdsPg--.4573S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UGw45KFWUuF17Jw1kZrb_yoW5WF45pa
        90gry5GF40gF4xGF1UJrWUCr1YyrZ8Ca40kFWqyw10kryxWFW7Xw4kXFW3Gry5Gr4FqFnx
        Jry7t345Kr1UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
        0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
        JVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
        WxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU89jjDUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
is a bit unwise when the 'sp' value is already printed. It is redundant
and unintuitive.

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
index 86cb4cc3eec485a..eb33e477bc96df1 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -290,6 +290,10 @@ void print_hex_dump(const char *level, const char *prefix_str, int prefix_type,
 			printk("%s%s%p: %s\n",
 			       level, prefix_str, ptr + i, linebuf);
 			break;
+		case DUMP_PREFIX_ADDRESS_LOW16:
+			printk("%s%s%04lx: %s\n", level,
+			       prefix_str, 0xffff & (unsigned long)(ptr + i), linebuf);
+			break;
 		case DUMP_PREFIX_OFFSET:
 			printk("%s%s%0*x: %s\n", level, prefix_str, width, i, linebuf);
 			break;
-- 
2.34.1

