Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802027EDE59
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbjKPKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKPKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:20:31 -0500
X-Greylist: delayed 591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Nov 2023 02:20:26 PST
Received: from 3.mo561.mail-out.ovh.net (3.mo561.mail-out.ovh.net [46.105.44.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC1A9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:20:25 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.4.136])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 816A929AB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:04:36 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-25wj5 (unknown [10.110.171.249])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 8A1901FDCE;
        Thu, 16 Nov 2023 10:04:35 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-25wj5 with ESMTPSA
        id R6B7IDPpVWVIRQAAyXHhzg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Thu, 16 Nov 2023 10:04:35 +0000
MIME-Version: 1.0
Date:   Thu, 16 Nov 2023 12:04:35 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        skhan@linuxfoundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
        syzbot+89edd67979b52675ddec@syzkaller.appspotmail.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] mm/pgtable: return null if no ptl in
 __pte_offset_map_lock
In-Reply-To: <515cb9c1-abcd-c3f3-cc0d-c3cd248b9d6f@google.com>
References: <20231115065506.19780-1-jose.pekkarinen@foxhound.fi>
 <ZVTTbuviH9/RWYyI@casper.infradead.org>
 <1c4cb1959829ecf4f0c59691d833618c@foxhound.fi>
 <ZVUWLgFgu+jE3QmW@casper.infradead.org>
 <515cb9c1-abcd-c3f3-cc0d-c3cd248b9d6f@google.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <3cd8b7048ee38f5c5e6f9f6c5dab2deb@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 192.42.116.185
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16804056113005307546
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefkedguddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpedtfeejledvieegvdfgfeeugedtteffjeetgefffeehveduhedtleehffduudfgjeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhsvghtuhhppghusghunhhtuhdqhhhoshhtpghqvghmuhdqvhhmpgigkeeiqdeigedqkhgvrhhnvghlrdhmugenucfkphepuddvjedrtddrtddruddpudelvddrgedvrdduudeirddukeehpdduhedurdektddrvdelrddvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-16 07:23, Hugh Dickins wrote:
> On Wed, 15 Nov 2023, Matthew Wilcox wrote:
>> On Wed, Nov 15, 2023 at 06:05:30PM +0200, José Pekkarinen wrote:
>> 
>> > > I don't think we should be changing ptlock_ptr().
>> >
>> >     This is where the null ptr dereference originates, so the only
>> > alternative I can think of is to protect the life cycle of the ptdesc
>> > to prevent it to die between the pte check and the spin_unlock of
>> > __pte_offset_map_lock. Would that work for you?
> 
> Thanks for pursuing this, José, but I agree with Matthew: I don't
> think your patch is right at all.  The change in ptlock_ptr() did not
> make sense to me, and the change in __pte_offset_map_lock() leaves us
> still wondering what has gone wrong (and misses an rcu_read_unlock()).
> 
> You mentioned "I tested the syzbot reproducer in x86 and it doesn't
> produce this kasan report anymore": are you saying that you were able
> to reproduce the issue on x86 (without your patch)?  That would be very
> interesting (and I think would disprove my hypothesis below).  I ought
> to try on x86 if you managed to reproduce on it, but it's not worth
> the effort if you did not.  If you have an x86 stack and registers,
> please show (though I'm uncertain how much KASAN spoils the output).

     Hi,

     Yes, I have a local setup based in [1], where I can spin a small
vm, build the reproducer and run it in. The only thing I took from
the webpage is the kernel config file, and the image I made it locally
by debootstrapping and running the modifications in create-image.sh
manually, the kasan report follows:

[  111.408746][ T8885] general protection fault, probably for 
non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN 
NOPTI
[  111.413181][ T8885] KASAN: null-ptr-deref in range 
[0x0000000000000028-0x000000000000002f]
[  111.413181][ T8885] CPU: 1 PID: 8885 Comm: handle_kernel_p Not 
tainted 6.7.0-rc1-00007-ge612cb00e200 #6
[  111.413181][ T8885] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  111.413181][ T8885] RIP: 0010:__pte_offset_map_lock+0xfa/0x310
[  111.423642][ T8885] Code: 48 c1 e8 03 80 3c 10 00 0f 85 12 02 00 00 
4c 03 3d db 92 cf 0b 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 28 48 89 fa 
48 c1 ea 03 <80> 3c 02 00 0f 85 e2 01 00 00 4d 8b 7f 28 4c 89 ff e8 f0 
a1 3a 09
[  111.423642][ T8885] RSP: 0018:ffffc90005baf738 EFLAGS: 00010216
[  111.423642][ T8885] RAX: dffffc0000000000 RBX: 0005800000000067 RCX: 
ffffffff81ada02e
[  111.423642][ T8885] RDX: 0000000000000005 RSI: ffffffff81ad9f0f RDI: 
0000000000000028
[  111.423642][ T8885] RBP: ffff8880224c4800 R08: 0000000000000007 R09: 
0000000000000000
[  111.423642][ T8885] R10: 0000000000000000 R11: 0000000000000000 R12: 
0005088000000a80
[  111.423642][ T8885] R13: 1ffff92000b75ee9 R14: ffffc90005bafa88 R15: 
0000000000000000
[  111.423642][ T8885] FS:  00007f8d3972c6c0(0000) 
GS:ffff888069700000(0000) knlGS:0000000000000000
[  111.423642][ T8885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.423642][ T8885] CR2: 00007f8d3970af78 CR3: 00000000224d6000 CR4: 
00000000000006f0
[  111.423642][ T8885] Call Trace:
[  111.423642][ T8885]  <TASK>
[  111.423642][ T8885]  ? show_regs+0x8f/0xa0
[  111.423642][ T8885]  ? die_addr+0x4f/0xd0
[  111.423642][ T8885]  ? exc_general_protection+0x150/0x220
[  111.423642][ T8885]  ? asm_exc_general_protection+0x26/0x30
[  111.423642][ T8885]  ? __pte_offset_map_lock+0x1de/0x310
[  111.423642][ T8885]  ? __pte_offset_map_lock+0xbf/0x310
[  111.423642][ T8885]  ? __pte_offset_map_lock+0xfa/0x310
[  111.423642][ T8885]  ? __pte_offset_map_lock+0xbf/0x310
[  111.423642][ T8885]  ? __pfx___pte_offset_map_lock+0x10/0x10
[  111.423642][ T8885]  filemap_map_pages+0x336/0x13b0
[  111.423642][ T8885]  ? __pfx_filemap_map_pages+0x10/0x10
[  111.423642][ T8885]  ? rcu_read_unlock+0x33/0xb0
[  111.423642][ T8885]  do_fault+0x86a/0x1350
[  111.423642][ T8885]  __handle_mm_fault+0xe53/0x23a0
[  111.423642][ T8885]  ? __pfx___handle_mm_fault+0x10/0x10
[  111.483413][ T8885]  handle_mm_fault+0x369/0x890
[  111.483413][ T8885]  __get_user_pages+0x46d/0x15d0
[  111.483413][ T8885]  ? __pfx___get_user_pages+0x10/0x10
[  111.483413][ T8885]  populate_vma_page_range+0x2de/0x420
[  111.483413][ T8885]  ? __pfx_populate_vma_page_range+0x10/0x10
[  111.483413][ T8885]  ? __pfx_find_vma_intersection+0x10/0x10
[  111.483413][ T8885]  ? vm_mmap_pgoff+0x299/0x3c0
[  111.483413][ T8885]  __mm_populate+0x1da/0x380
[  111.483413][ T8885]  ? __pfx___mm_populate+0x10/0x10
[  111.483413][ T8885]  ? up_write+0x1b3/0x520
[  111.483413][ T8885]  vm_mmap_pgoff+0x2d1/0x3c0
[  111.483413][ T8885]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  111.483413][ T8885]  ksys_mmap_pgoff+0x7d/0x5b0
[  111.483413][ T8885]  __x64_sys_mmap+0x125/0x190
[  111.483413][ T8885]  do_syscall_64+0x45/0xf0
[  111.483413][ T8885]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  111.483413][ T8885] RIP: 0033:0x7f8d39831559
[  111.483413][ T8885] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 
00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 08 0d 00 f7 d8 64 
89 01 48
[  111.483413][ T8885] RSP: 002b:00007f8d3972be78 EFLAGS: 00000216 
ORIG_RAX: 0000000000000009
[  111.483413][ T8885] RAX: ffffffffffffffda RBX: 00007f8d3972c6c0 RCX: 
00007f8d39831559
[  111.483413][ T8885] RDX: b635773f07ebbeea RSI: 0000000000b36000 RDI: 
0000000020000000
[  111.483413][ T8885] RBP: 00007f8d3972bea0 R08: 00000000ffffffff R09: 
0000000000000000
[  111.483413][ T8885] R10: 0000000000008031 R11: 0000000000000216 R12: 
ffffffffffffff80
[  111.483413][ T8885] R13: 0000000000000000 R14: 00007fffcef921d0 R15: 
00007f8d3970c000
[  111.483413][ T8885]  </TASK>
[  111.483413][ T8885] Modules linked in:
[  111.763549][ T8885] ---[ end trace 0000000000000000 ]---
[  111.773557][ T8885] RIP: 0010:__pte_offset_map_lock+0xfa/0x310
[  111.776045][ T8885] Code: 48 c1 e8 03 80 3c 10 00 0f 85 12 02 00 00 
4c 03 3d db 92 cf 0b 48 b8 00 00 00 00 00 fc ff df 49 8d 7f 28 48 89 fa 
48 c1 ea 03 <80> 3c 02 00 0f 85 e2 01 00 00 4d 8b 7f 28 4c 89 ff e8 f0 
a1 3a 09
[  111.805040][ T8885] RSP: 0018:ffffc90005baf738 EFLAGS: 00010216
[  111.820041][ T8885] RAX: dffffc0000000000 RBX: 0005800000000067 RCX: 
ffffffff81ada02e
[  111.837884][ T8885] RDX: 0000000000000005 RSI: ffffffff81ad9f0f RDI: 
0000000000000028
[  111.855313][ T8885] RBP: ffff8880224c4800 R08: 0000000000000007 R09: 
0000000000000000
[  111.878314][ T8885] R10: 0000000000000000 R11: 0000000000000000 R12: 
0005088000000a80
[  111.910624][ T8885] R13: 1ffff92000b75ee9 R14: ffffc90005bafa88 R15: 
0000000000000000
[  111.923627][ T8885] FS:  00007f8d3972c6c0(0000) 
GS:ffff888069700000(0000) knlGS:0000000000000000
[  111.932017][ T8885] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  111.941166][ T8885] CR2: 00007fa26ac38178 CR3: 00000000224d6000 CR4: 
00000000000006f0
[  111.950619][ T8885] Kernel panic - not syncing: Fatal exception
[  111.953981][ T8885] Kernel Offset: disabled
[  111.953981][ T8885] Rebooting in 86400 seconds..

     I can test some patches for you if it helps finding out
the issue.

[1] 
https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md

     José.
