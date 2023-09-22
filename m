Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071257AAEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjIVJ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjIVJ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:57:32 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FFC199
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695376624; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=G02MAYnz4vsElkJioQi2M66CtNnnmCo6vKxX8OYluReTpMiefMZwBV/2PfjST8MIlq+ZtksEOAGtBunNmK4VMRelIfOxnfll6dcFu4h6LKjAN4rcGS91Okr6Yf9l4p/HHIT36BNfMg2bNOK0lrhj5nsXPpUUFXiGh0fkghwoo5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1695376624; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=ChCUGhgrB37iVI3Jg9e5dZ5Wq3H394srZL/HegY6ww4=; 
        b=I1Goo+q0G8oQ7vUmJdXXL8+2pcAg+Xo4ThPOlNpF+nYBWgVUwCcO1ZMT5Bz52u8obmJ3R6Su0lVctHqNp6aKYcYwVEDSz09fSQJjPPESL27OXjz7lovIkbiUySR8569z3sKDadISyu9jv5hZcr9ZK4zHJxpXDrELOJNUGY5B43E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=marliere.net;
        spf=pass  smtp.mailfrom=ricardo@marliere.net;
        dmarc=pass header.from=<ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1695376624;
        s=zmail; d=marliere.net; i=ricardo@marliere.net;
        h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
        bh=ChCUGhgrB37iVI3Jg9e5dZ5Wq3H394srZL/HegY6ww4=;
        b=n8ydStTOIZQLKjZxF9Hh88d5+Cx+gVlYOm6wu6A8vcI8C0Jupe6T11PbCJCpSq7r
        RcKvqKIr0pZBXrQx5adkT0Fd3fdWZS6dvtG1E7VN5th8XV/rsEt5AfdeRp/1Ge/wM7B
        InFPa4bi+8Ym2Q8sooqEMG9pxrKf49KH2Z5CK09U=
Received: from localhost (177.104.93.54 [177.104.93.54]) by mx.zohomail.com
        with SMTPS id 1695376622146592.4625420091922; Fri, 22 Sep 2023 02:57:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 06:56:59 -0300
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com
Subject: Re: [PATCH] sound: usb: increase snd_card alloc size
Message-ID: <w6azqrep2c37i5i5yc5zp67cyhgyfwbiygax3depapzrkpesdl@twqvzqqsvkfh>
References: <20230922005152.163640-1-ricardo@marliere.net>
 <87h6nmegt9.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6nmegt9.wl-tiwai@suse.de>
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/22 10:46AM, Takashi Iwai wrote:
> On Fri, 22 Sep 2023 02:51:53 +0200,
> Ricardo B. Marliere wrote:
> > 
> > Syzbot reports a slab-out-of-bounds read of a snd_card object. When
> > snd_usb_audio_create calls snd_card_new, it passes sizeof(*chip) as the
> > extra_size argument, which is not enough in this case.
> > 
> > Relevant logs below:
> > 
> > BUG: KASAN: slab-out-of-bounds in imon_probe+0x2983/0x3910
> > Read of size 1 at addr ffff8880436a2c71 by task kworker/1:2/777
> > (...)
> > The buggy address belongs to the object at ffff8880436a2000
> >  which belongs to the cache kmalloc-4k of size 4096
> > The buggy address is located 1 bytes to the right of
> >  allocated 3184-byte region [ffff8880436a2000, ffff8880436a2c70)
> > 
> > Reported-by: syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/000000000000a838aa0603cc74d6@google.co/m
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  sound/usb/card.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/usb/card.c b/sound/usb/card.c
> > index 1b2edc0fd2e9..6578326d33e8 100644
> > --- a/sound/usb/card.c
> > +++ b/sound/usb/card.c
> > @@ -619,7 +619,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
> >  	}
> >  
> >  	err = snd_card_new(&intf->dev, index[idx], id[idx], THIS_MODULE,
> > -			   sizeof(*chip), &card);
> > +			   sizeof(*chip) + 2, &card);
> 
> Sorry, it's no-no.  We have to fix the cause of the OOB access instead
> of papering over with a random number of increase.

Hey Takashi, you are right.

> Unfortunately, most important piece of information is trimmed in the
> changelog, so I can't judge what's going on.  The only useful info
> there is that it's something to do with imon driver, but it's
> completely independent from USB-audio.  How does it access to the
> external memory allocated by snd-usb-audio driver at all?
> 
> Before jumping to the solution, we must understand the problem.

The link mentioned in the "Closes:" tag contains the logs pasted below.
I will continue to investigate the root cause of this oob access, please
let me know if you have any clue I should look into.

Thanks for reviewing!
-	Ricardo

==================================================================
BUG: KASAN: slab-out-of-bounds in imon_init_intf1 drivers/media/rc/imon.c:2323 [inline]
BUG: KASAN: slab-out-of-bounds in imon_probe+0x298f/0x38f0 drivers/media/rc/imon.c:2449
Read of size 1 at addr ffff888069cbac71 by task kworker/1:3/5066

CPU: 1 PID: 5066 Comm: kworker/1:3 Not tainted 6.5.0-rc7-next-20230821-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 imon_init_intf1 drivers/media/rc/imon.c:2323 [inline]
 imon_probe+0x298f/0x38f0 drivers/media/rc/imon.c:2449
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 5066:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1004 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1017
 kmalloc include/linux/slab.h:604 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 snd_card_new+0x74/0x110 sound/core/init.c:184
 snd_usb_audio_create sound/usb/card.c:621 [inline]
 usb_audio_probe+0x1905/0x3c60 sound/usb/card.c:827
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3623
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2daf/0x4e00 drivers/usb/core/hub.c:5822
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888069cba000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1 bytes to the right of
 allocated 3184-byte region [ffff888069cba000, ffff888069cbac70)

The buggy address belongs to the physical page:
page:ffffea0001a72e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x69cb8
head:ffffea0001a72e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 27, tgid 27 (kworker/1:1), ts 97911259229, free_ts 34249861969
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3213
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4469
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1003 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1024
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x29e/0xc70 drivers/net/netdevsim/dev.c:850
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
 free_contig_range+0xb6/0x190 mm/page_alloc.c:6385
 destroy_args+0x768/0x990 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x1d7e/0x3e00 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
 kernel_init+0x1c/0x2a0 init/main.c:1437
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff888069cbab00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888069cbab80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888069cbac00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                             ^
 ffff888069cbac80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888069cbad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

