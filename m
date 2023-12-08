Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F380AB3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574531AbjLHRxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574534AbjLHRxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:53:53 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0CB5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:53:59 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAE04FF803;
        Fri,  8 Dec 2023 17:53:55 +0000 (UTC)
Message-ID: <ab7e1ebe-b204-4f65-8fbe-f7586f2393ff@ghiti.fr>
Date:   Fri, 8 Dec 2023 18:53:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [riscv?] riscv/fixes boot error: kernel BUG in
 __phys_addr_symbol
Content-Language: en-US
To:     syzbot <syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
References: <000000000000620dd0060c02c5e1@google.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <000000000000620dd0060c02c5e1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/12/2023 18:18, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb46a0076501 riscv: Check if the code to patch lies in the..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=14aa707ae80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5c1ede998d7cef2
> dashboard link: https://syzkaller.appspot.com/bug?extid=afb726d49f84c8d95ee1
> compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: riscv64
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-eb46a007.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/472c8c5dc639/vmlinux-eb46a007.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/21ee09184ba1/Image-eb46a007.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at arch/riscv/mm/physaddr.c:31!
> Kernel BUG [#1]
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-syzkaller-geb46a0076501 #0
> Hardware name: riscv-virtio,qemu (DT)
> epc : __phys_addr_symbol+0x144/0x150 arch/riscv/mm/physaddr.c:31
>   ra : __phys_addr_symbol+0x144/0x150 arch/riscv/mm/physaddr.c:31
> epc : ffffffff800200b4 ra : ffffffff800200b4 sp : ff20000000013d10
>   gp : ffffffff861f60a0 tp : ff6000000b260000 t0 : 26747970652d3e69
>   t1 : fffffffef0a8ad5d t2 : 0000000000000000 s0 : ff20000000013d40
>   s1 : ff60000003a00000 a0 : 0000000000000006 a1 : ffffffff80000000
>   a2 : 0000000000000002 a3 : ffffffff800200b4 a4 : 0000000000000000
>   a5 : ff6000000b261000 a6 : 0000000000000003 a7 : ffffffff85456aef
>   s2 : ffffffff8816d000 s3 : ffffffff80000000 s4 : ffffffff84e6f2b0
>   s5 : ff60000003a00000 s6 : 0000000000000000 s7 : 0000000000000000
>   s8 : ffffffff861f5c40 s9 : 0000000000000000 s10: 0000000000000000
>   s11: 0000000000000000 t3 : ffffffffffffffff t4 : fffffffef0a8ad5d
>   t5 : fffffffef0a8ad5e t6 : ff60000013e80c70
> status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [<ffffffff800200b4>] __phys_addr_symbol+0x144/0x150 arch/riscv/mm/physaddr.c:31
> [<ffffffff80019ede>] __set_memory+0x1c0/0x762 arch/riscv/mm/pageattr.c:308
> [<ffffffff8001a4a4>] set_memory_rw_nx+0x24/0x30 arch/riscv/mm/pageattr.c:346
> [<ffffffff80008778>] set_kernel_memory arch/riscv/include/asm/set_memory.h:27 [inline]
> [<ffffffff80008778>] free_initmem+0x52/0x8c arch/riscv/kernel/setup.c:323
> [<ffffffff837334e6>] kernel_init+0x44/0x21e init/main.c:1450
> [<ffffffff83745cb2>] ret_from_fork+0xe/0x1c arch/riscv/kernel/entry.S:221
> Code: 84b3 4124 b745 4985 1996 bf65 7097 0025 80e7 ecc0 (9002) 7097
> ---[ end trace 0000000000000000 ]---


Ok, that's for me, lm_alias() actually does not work for linear mapping 
addresses since it assumes that the address lies in the kernel mapping, 
my bad. I'll fix that either by "extending" lm_alias() to linear mapping 
addresses or directly in the riscv code, not sure right now what's the 
best solution.

Thanks for the report,

Alex


> ----------------
> Code disassembly (best guess):
>     0:	412484b3          	sub	s1,s1,s2
>     4:	b745                	j	0xffffffffffffffa4
>     6:	4985                	li	s3,1
>     8:	1996                	sll	s3,s3,0x25
>     a:	bf65                	j	0xffffffffffffffc2
>     c:	00257097          	auipc	ra,0x257
>    10:	ecc080e7          	jalr	-308(ra) # 0x256ed8
> * 14:	9002                	ebreak <-- trapping instruction
>    16:	97 70             	Address 0x16 is out of bounds.
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
