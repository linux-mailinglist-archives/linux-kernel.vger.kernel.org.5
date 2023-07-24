Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9994F75F3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjGXKyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjGXKyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:54:32 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A430BD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690196067;
        bh=XOX/z39tnUIYC7J6EKUXBGgP9+PWkGgP5iM49YV5zy0=;
        h=From:To:Cc:Subject:Date;
        b=h4AlDVM7Levuz6MojVlncNhs4/fIDhCMnPoL+6txypL9iAzJiKhUb0W7lFlSWH/sw
         kyHf33VIjro2W5Z+NXdNMNE+etn69qAYGkK3gEowPDglL1rX7D1BK5GGsLm6m3Ykvv
         Q3YPA8qXtfj02zzGUu3XRbq0u5Sg+9LIS30Cbo4E=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id BFB29C6C; Mon, 24 Jul 2023 18:47:59 +0800
X-QQ-mid: xmsmtpt1690195679tbwjgl8u0
Message-ID: <tencent_E626A858BED28C4E21C219780BC566015D0A@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7Zzzod1N7QKTZYwMcKOnxac8L0X2KaWFnpdLxFfM34CvUwbI3wf4
         YeVKCDYOdfLxmL2WPxG2/8Y9BhkYoB1TcQTDMAryJA8p3sQPFtNlbTICbZvdCPiiO5sBwYR4+qYF
         kNdl+rGOKd31iPQCxyiNt/56R1hoeZqi0uo6CxE3Xs5KrmaF7YrZ7gKH2bW29ljKX9hC8FnC1xpV
         pSP3DEWUXOXpFkN/H6bIv1Ci38D1xV/0OW4K/c+G6IlmS1iUZteEJ/IWvlqec4m1SSvFKk4eiBnT
         NUUBIZIvYvZvBhCCLU1gxKHWDDhABCH64Nl3EWkVi0GdwHHm//aIz39WAFlZ57kL8UveDPtTOpQb
         ov+eO8mBRIFHgEcNMQaCEh3IvmUvOaegIkTzhV+I5/G65eyeFDJkctZyJY0HwrABtIRe1a5pRT6o
         00H/9dE6uuOImHCAHJTAKs/Q+s0yIwdsQHF6ze+h4CNHZV6HPceTXhytM5F1ulWBIBJUooXlJY/I
         WJtOEF3v04AwuXTdCy5hVmwbt9oDWBsoZjaNbhDXuLZ5xsKomKcpk0468tHUsXW98wGhoQ2nJeGm
         +2ndoqcvim3YdxGuiK1T/ZpQGX24yXFSVulFZ9NVVyvfxBqQNZROkjY40J/WEoQWrF1tsclr7oTj
         9ufM/dtNPvMbDIJHkFa2SbZxiZM7bXmiaslObZLtkMCJqfJAPMVmh+rwKZHirGuYDrHivzc3bqtt
         G9J81h3tAaiLrAtsYWgdFXFbEaWgyxLsQXzmRKGoyPW+d758mMkTWIUDLryM5HmMN/58eKY6pMQj
         kOkJxMy3ViV+H06YxvtuJ6Wp4a+NxNArXu/nFSidnVRjIyjPpi/zjxs6Yhq5n1VRdiVku2V1NHXy
         Ow9DjaQSCKD9bu94DAzkDAgH2Y1u4uP2emo9EHWcAFecshA8K97MR/U8PJF6wzImlpLa8m4KNyYv
         bR8i6f6g0EKwwKoXimKWVpwTm66PDdSfIXpNapdFui7C8NLLe409DmwnSEpYuA
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Rong Tao <rtoax@foxmail.com>
To:     prasad@linux.vnet.ibm.com
Cc:     rtoax@foxmail.com, ast@kernel.org, frederic@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mbenes@suse.cz, pmladek@suse.com, qperret@google.com,
        rongtao@cestc.cn, tglx@linutronix.de, will@kernel.org,
        mhiramat@kernel.org
Subject: [PATCH] samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'
Date:   Mon, 24 Jul 2023 18:47:58 +0800
X-OQ-MSGID: <20230724104758.39645-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Macro symbol_put() is defined as __symbol_put(__stringify(x))

    ksym_name = "jiffies"
    symbol_put(ksym_name)

will be resolved as

    __symbol_put("ksym_name")

which is clearly wrong. So symbol_put must be replaced with __symbol_put.

When we uninstall hw_breakpoint.ko (rmmod), a kernel bug occurs with the
following error:

[11381.854152] kernel BUG at kernel/module/main.c:779!
[11381.854159] invalid opcode: 0000 [#2] PREEMPT SMP PTI
[11381.854163] CPU: 8 PID: 59623 Comm: rmmod Tainted: G      D    OE      6.2.9-200.fc37.x86_64 #1
[11381.854167] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B360M-HDV, BIOS P3.20 10/23/2018
[11381.854169] RIP: 0010:__symbol_put+0xa2/0xb0
[11381.854175] Code: 00 e8 92 d2 f7 ff 65 8b 05 c3 2f e6 78 85 c0 74 1b 48 8b 44 24 30 65 48 2b 04 25 28 00 00 00 75 12 48 83 c4 38 c3 cc cc cc cc <0f> 0b 0f 1f 44 00 00 eb de e8 c0 df d8 00 90 90 90 90 90 90 90 90
[11381.854178] RSP: 0018:ffffad8ec6ae7dd0 EFLAGS: 00010246
[11381.854181] RAX: 0000000000000000 RBX: ffffffffc1fd1240 RCX: 000000000000000c
[11381.854184] RDX: 000000000000006b RSI: ffffffffc02bf7c7 RDI: ffffffffc1fd001c
[11381.854186] RBP: 000055a38b76e7c8 R08: ffffffff871ccfe0 R09: 0000000000000000
[11381.854188] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[11381.854190] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[11381.854192] FS:  00007fbf7c62c740(0000) GS:ffff8c5badc00000(0000) knlGS:0000000000000000
[11381.854195] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11381.854197] CR2: 000055a38b7793f8 CR3: 0000000363e1e001 CR4: 00000000003726e0
[11381.854200] DR0: ffffffffb3407980 DR1: 0000000000000000 DR2: 0000000000000000
[11381.854202] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[11381.854204] Call Trace:
[11381.854207]  <TASK>
[11381.854212]  s_module_exit+0xc/0xff0 [symbol_getput]
[11381.854219]  __do_sys_delete_module.constprop.0+0x198/0x2f0
[11381.854225]  do_syscall_64+0x58/0x80
[11381.854231]  ? exit_to_user_mode_prepare+0x180/0x1f0
[11381.854237]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854241]  ? do_syscall_64+0x67/0x80
[11381.854245]  ? syscall_exit_to_user_mode+0x17/0x40
[11381.854248]  ? do_syscall_64+0x67/0x80
[11381.854252]  ? exc_page_fault+0x70/0x170
[11381.854256]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index 418c46fe5ffc..9debd128b2ab 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -70,7 +70,7 @@ static int __init hw_break_module_init(void)
 static void __exit hw_break_module_exit(void)
 {
 	unregister_wide_hw_breakpoint(sample_hbp);
-	symbol_put(ksym_name);
+	__symbol_put(ksym_name);
 	printk(KERN_INFO "HW Breakpoint for %s write uninstalled\n", ksym_name);
 }
 
-- 
2.39.3

