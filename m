Return-Path: <linux-kernel+bounces-10851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D150981DD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A7281BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C8A7F2;
	Mon, 25 Dec 2023 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huVz+q7r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8862A;
	Mon, 25 Dec 2023 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so2547487a12.2;
        Sun, 24 Dec 2023 16:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703465730; x=1704070530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8AuLE8+xjFxnn1dZsLV28zRm6wvzmNVaOv33SusHFiQ=;
        b=huVz+q7rrp0WeINFHCjzdrJrEFc/+GZn//yHRMLbH08WvBAXYcQtgJm+6s+th4YFF4
         2rurfv2QiXmFx3CEFxdKW+eTd9qsDUlxx2/R7nyQakarZlW5AWtOWQaQ8hP0QcqZoSoQ
         c2hiK/btDJ8rFsRCYP/jW0eooCeG836tah1u/bVWlv/SiiujvwXlNAlRiyJXrECF9TfM
         TAwMmgzmGAKdB561SWcnNWCMJ3FoTow43r+T86a01R3yPua6x0L6fVLABwXUXTem9vwA
         E+rkGYx4FYG9NZpCYtgwKCVLK6hup5xv0olVzYF68RMZx3Jr/Ea6WfsMOwPQETS+jfsm
         iung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703465730; x=1704070530;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8AuLE8+xjFxnn1dZsLV28zRm6wvzmNVaOv33SusHFiQ=;
        b=ohG/9SC8SN8VTdFmCTBlE4ZSJimOlfKNJjZq3TFJiIUIFVnCIV68icE5aTLF09OPpm
         CrKouT5M+EIG62BsR1molmUGxeGAxD/E/OstxDN5U742LM1qeJDJqKXvudq5jiYesMcA
         iUswkWnWFxwXUejAr3S2uL03Ngs8eZMmFQCbIj4Y5veuBh6ALubw2m6W+4lDGo5EBbx5
         K638n301HxOBdUHTRvSOf+ST+MOEcjJ3ptbDuw1zorrm5JsFZBLEa6CHSVcXRpn/I8Mr
         eoR5xIAvfm29Pc7W4wK4ThRqrGH/Ubzde4mOoJtnkJP9pZqtwV2NzsCLBUDKPyenhAyf
         oc8Q==
X-Gm-Message-State: AOJu0YwWCIF7QPcnOzr4Ejpg8lUx6ZPFmGqgiKrOY6IB4K9vg75ccuw8
	D5Duho1uvOX7s9pdoa/Lybn8Qt6SN6UcXvCiuos=
X-Google-Smtp-Source: AGHT+IHP+vQKxfDsDAknEaYPEfq/qBlWk/fVRG1ck+GQR3WEA50+bQ2EgpDjPy3ElKFjIi1daE79V0iEOv/r2bVjYFo=
X-Received: by 2002:a05:6a20:7491:b0:18c:8ff1:f16 with SMTP id
 p17-20020a056a20749100b0018c8ff10f16mr5912736pzd.1.1703465729777; Sun, 24 Dec
 2023 16:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 25 Dec 2023 08:55:18 +0800
Message-ID: <CABOYnLzRR6k6TBoLQ7oYcLtcgiq50_xrsU4Oc0iE+sEKGHwBgg@mail.gmail.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
To: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello, I reproduced this bug and comfired in the latest net tree.

If you fix this issue, please add the following tag to the commit:
Reported-by: xingwei lee <xrivendell7@gmail.com>

kernel: net 7c5e046bdcb2513f9decb3765d8bf92d604279cf
kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=f2346961f26c5509
with KASAN enabled
compiler: gcc (Debian 12.2.0-14) 12.2.0

==================================================================
BUG: KASAN: slab-use-after-free in advance_sched+0xadd/0xc60
net/sched/sch_taprio.c:973
Write of size 8 at addr ffff888023cefa90 by task kworker/1:4/12712
CPU: 1 PID: 12712 Comm: kworker/1:4 Tainted: G    B
6.7.0-rc6-00157-g7c5e046bdcb2 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: events nsim_dev_trap_report_work
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xd3/0x1b0 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:364 [inline]
print_report+0xc4/0x630 mm/kasan/report.c:475
kasan_report+0xd8/0x110 mm/kasan/report.c:588
advance_sched+0xadd/0xc60 net/sched/sch_taprio.c:973
__run_hrtimer kernel/time/hrtimer.c:1688 [inline]
__hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
__sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
RIP: 0010:__alloc_pages+0x2b4/0x23d0 mm/page_alloc.c:4590
Code: 0f 87 ab 13 00 00 45 89 e4 be 08 00 00 00 4c 89 e0 48 c1 e8 06
48 8d 3c c5 90 9f 39 8f e8 24 08
RSP: 0018:ffffc9000c227620 EFLAGS: 00000247
RAX: 0000000000000001 RBX: 1ffff92001844ed8 RCX: ffffffff81d36b5c
RDX: fffffbfff1e733f3 RSI: 0000000000000008 RDI: ffffffff8f399f90
RBP: ffffea0001fe7400 R08: 0000000000000000 R09: fffffbfff1e733f2
R10: ffffffff8f399f97 R11: 0000000000000004 R12: 0000000000000001
R13: 00000000000d2820 R14: 0000000000000000 R15: 0000000000000003
alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
alloc_slab_page mm/slub.c:1870 [inline]
allocate_slab mm/slub.c:2017 [inline]
new_slab+0x292/0x3c0 mm/slub.c:2070
___slab_alloc+0x992/0x16b0 mm/slub.c:3223
__slab_alloc.isra.0+0x56/0xa0 mm/slub.c:3322
__slab_alloc_node mm/slub.c:3375 [inline]
slab_alloc_node mm/slub.c:3468 [inline]
__kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
__do_kmalloc_node mm/slab_common.c:1006 [inline]
__kmalloc_node_track_caller+0x4e/0xd0 mm/slab_common.c:1027
kmalloc_reserve+0xef/0x260 net/core/skbuff.c:582
__alloc_skb+0x12b/0x330 net/core/skbuff.c:651
alloc_skb include/linux/skbuff.h:1286 [inline]
nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
nsim_dev_trap_report_work+0x29d/0xc80 drivers/net/netdevsim/dev.c:850
process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
process_scheduled_works kernel/workqueue.c:2700 [inline]
worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
kthread+0x2c6/0x3a0 kernel/kthread.c:388
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
</TASK>
Allocated by task 135331:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
____kasan_kmalloc mm/kasan/common.c:374 [inline]
__kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:721 [inline]
taprio_change+0x54f/0x3900 net/sched/sch_taprio.c:1881
qdisc_change net/sched/sch_api.c:1387 [inline]
tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
____sys_sendmsg+0x6b8/0x950 net/socket.c:2584
___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
__sys_sendmsg+0x117/0x1e0 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x41/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Freed by task 0:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
kasan_set_track+0x25/0x30 mm/kasan/common.c:52
kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
____kasan_slab_free mm/kasan/common.c:236 [inline]
____kasan_slab_free+0x15f/0x1b0 mm/kasan/common.c:200
kasan_slab_free include/linux/kasan.h:164 [inline]
slab_free_hook mm/slub.c:1800 [inline]
slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
slab_free mm/slub.c:3809 [inline]
__kmem_cache_free+0xc0/0x180 mm/slub.c:3822
rcu_do_batch kernel/rcu/tree.c:2158 [inline]
rcu_core+0x7fd/0x1610 kernel/rcu/tree.c:2431
__do_softirq+0x21a/0x8de kernel/softirq.c:553
Last potentially related work creation:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
__kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
__call_rcu_common.constprop.0+0x99/0x7a0 kernel/rcu/tree.c:2681
taprio_change+0x2928/0x3900 net/sched/sch_taprio.c:1991
qdisc_change net/sched/sch_api.c:1387 [inline]
tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0xd5/0x180 net/socket.c:745
____sys_sendmsg+0x6b8/0x950 net/socket.c:2584
___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
__sys_sendmsg+0x117/0x1e0 net/socket.c:2667
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0x41/0x110 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x63/0x6b
Second to last potentially related work creation:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
__kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3400
drop_sysctl_table+0x1d4/0x3b0 fs/proc/proc_sysctl.c:1508
unregister_sysctl_table fs/proc/proc_sysctl.c:1529 [inline]
unregister_sysctl_table+0x41/0x60 fs/proc/proc_sysctl.c:1521
__addrconf_sysctl_unregister net/ipv6/addrconf.c:7185 [inline]
addrconf_sysctl_unregister+0xf1/0x1c0 net/ipv6/addrconf.c:7213
addrconf_ifdown.isra.0+0x16c8/0x1ce0 net/ipv6/addrconf.c:3957
addrconf_notify+0x48f/0x19d0 net/ipv6/addrconf.c:3727
notifier_call_chain+0xb6/0x3d0 kernel/notifier.c:93
call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
call_netdevice_notifiers_extack net/core/dev.c:2005 [inline]
call_netdevice_notifiers net/core/dev.c:2019 [inline]
unregister_netdevice_many_notify+0x85b/0x19a0 net/core/dev.c:11043
unregister_netdevice_many net/core/dev.c:11099 [inline]
default_device_exit_batch+0x57f/0x740 net/core/dev.c:11568
ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
cleanup_net+0x505/0xb20 net/core/net_namespace.c:614
process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
process_scheduled_works kernel/workqueue.c:2700 [inline]
worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
kthread+0x2c6/0x3a0 kernel/kthread.c:388
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
The buggy address belongs to the object at ffff888023cefa00
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 144 bytes inside of
freed 512-byte region [ffff888023cefa00, ffff888023cefc00)
The buggy address belongs to the physical page:
page:ffffea00008f3a00 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x23ce8
head:ffffea00008f3a00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013042f40 ffffea00017a8010 ffff888013040d28
raw: 0000000000000000 0000000000150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOW0
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook+0x2e9/0x350 mm/page_alloc.c:1537
prep_new_page mm/page_alloc.c:1544 [inline]
get_page_from_freelist+0x1391/0x39a0 mm/page_alloc.c:3312
__alloc_pages+0x22d/0x23d0 mm/page_alloc.c:4568
alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
alloc_slab_page mm/slub.c:1870 [inline]
allocate_slab mm/slub.c:2017 [inline]
new_slab+0x292/0x3c0 mm/slub.c:2070
___slab_alloc+0x992/0x16b0 mm/slub.c:3223
__slab_alloc.isra.0+0x56/0xa0 mm/slub.c:3322
__slab_alloc_node mm/slub.c:3375 [inline]
slab_alloc_node mm/slub.c:3468 [inline]
__kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
kmalloc_trace+0x25/0x60 mm/slab_common.c:1098
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:721 [inline]
alloc_bprm+0x51/0xb00 fs/exec.c:1512
kernel_execve+0xaf/0x4e0 fs/exec.c:1987
call_usermodehelper_exec_async+0x256/0x4c0 kernel/umh.c:110
ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1137 [inline]
free_unref_page_prepare+0x50f/0xac0 mm/page_alloc.c:2347
free_unref_page+0x33/0x3f0 mm/page_alloc.c:2487
qlink_free mm/kasan/quarantine.c:168 [inline]
qlist_free_all+0x63/0x160 mm/kasan/quarantine.c:187
kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
____kasan_kmalloc mm/kasan/common.c:340 [inline]
__kasan_kmalloc+0x86/0xb0 mm/kasan/common.c:383
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:721 [inline]
kobject_uevent_env+0x24c/0x1800 lib/kobject_uevent.c:524
netdev_queue_add_kobject net/core/net-sysfs.c:1706 [inline]
netdev_queue_update_kobjects+0x3e5/0x520 net/core/net-sysfs.c:1747
register_queue_kobjects net/core/net-sysfs.c:1808 [inline]
netdev_register_kobject+0x297/0x3f0 net/core/net-sysfs.c:2048
register_netdevice+0x11ce/0x1cb0 net/core/dev.c:10221
veth_newlink+0x4ed/0xa00 drivers/net/veth.c:1927
rtnl_newlink_create net/core/rtnetlink.c:3521 [inline]
__rtnl_newlink+0x1173/0x1930 net/core/rtnetlink.c:3741
rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3754
rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6558
netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1368
netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
Memory state around the buggy address:
ffff888023cef980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888023cefa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

ffff888023cefa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

                        ^
ffff888023cefb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888023cefb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


=* repro.c =*
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms) { usleep(ms * 1000); }

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts)) exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

#define BITMASK(bf_off, bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type, htobe, addr, val, bf_off, bf_len)     \
 *(type*)(addr) =                                                   \
     htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | \
           (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] = 0;
 int len = strlen(buf);
 int fd = open(file, O_WRONLY | O_CLOEXEC);
 if (fd == -1) return false;
 if (write(fd, buf, len) != len) {
   int err = errno;
   close(fd);
   errno = err;
   return false;
 }
 close(fd);
 return true;
}

struct nlmsg {
 char* pos;
 int nesting;
 struct nlattr* nested[8];
 char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
                        const void* data, int size) {
 memset(nlmsg, 0, sizeof(*nlmsg));
 struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_type = typ;
 hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
 memcpy(hdr + 1, data, size);
 nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
                        int size) {
 struct nlattr* attr = (struct nlattr*)nlmsg->pos;
 attr->nla_len = sizeof(*attr) + size;
 attr->nla_type = typ;
 if (size > 0) memcpy(attr + 1, data, size);
 nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ) {
 struct nlattr* attr = (struct nlattr*)nlmsg->pos;
 attr->nla_type = typ;
 nlmsg->pos += sizeof(*attr);
 nlmsg->nested[nlmsg->nesting++] = attr;
}

static void netlink_done(struct nlmsg* nlmsg) {
 struct nlattr* attr = nlmsg->nested[--nlmsg->nesting];
 attr->nla_len = nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t reply_type,
                           int* reply_len, bool dofail) {
 if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting) exit(1);
 struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
 struct sockaddr_nl addr;
 memset(&addr, 0, sizeof(addr));
 addr.nl_family = AF_NETLINK;
 ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                    (struct sockaddr*)&addr, sizeof(addr));
 if (n != (ssize_t)hdr->nlmsg_len) {
   if (dofail) exit(1);
   return -1;
 }
 n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 if (reply_len) *reply_len = 0;
 if (n < 0) {
   if (dofail) exit(1);
   return -1;
 }
 if (n < (ssize_t)sizeof(struct nlmsghdr)) {
   errno = EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 if (hdr->nlmsg_type == NLMSG_DONE) return 0;
 if (reply_len && hdr->nlmsg_type == reply_type) {
   *reply_len = n;
   return 0;
 }
 if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
   errno = EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 if (hdr->nlmsg_type != NLMSG_ERROR) {
   errno = EINVAL;
   if (dofail) exit(1);
   return -1;
 }
 errno = -((struct nlmsgerr*)(hdr + 1))->error;
 return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock) {
 return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg, int sock,
                                  const char* family_name, bool dofail) {
 struct genlmsghdr genlhdr;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd = CTRL_CMD_GETFAMILY;
 netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
              strnlen(family_name, GENL_NAMSIZ - 1) + 1);
 int n = 0;
 int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
 if (err < 0) {
   return -1;
 }
 uint16_t id = 0;
 struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                        NLMSG_ALIGN(sizeof(genlhdr)));
 for (; (char*)attr < nlmsg->buf + n;
      attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
   if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
     id = *(uint16_t*)(attr + 1);
     break;
   }
 }
 if (!id) {
   errno = EINVAL;
   return -1;
 }
 recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 return id;
}

static int netlink_next_msg(struct nlmsg* nlmsg, unsigned int offset,
                           unsigned int total_len) {
 struct nlmsghdr* hdr = (struct nlmsghdr*)(nlmsg->buf + offset);
 if (offset == total_len || offset + hdr->nlmsg_len > total_len) return -1;
 return hdr->nlmsg_len;
}

static void netlink_add_device_impl(struct nlmsg* nlmsg, const char* type,
                                   const char* name, bool up) {
 struct ifinfomsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 if (up) hdr.ifi_flags = hdr.ifi_change = IFF_UP;
 netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr,
              sizeof(hdr));
 if (name) netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
 netlink_nest(nlmsg, IFLA_LINKINFO);
 netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg, int sock, const char* type,
                              const char* name) {
 netlink_add_device_impl(nlmsg, type, name, false);
 netlink_done(nlmsg);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_veth(struct nlmsg* nlmsg, int sock, const char* name,
                            const char* peer) {
 netlink_add_device_impl(nlmsg, "veth", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_nest(nlmsg, VETH_INFO_PEER);
 nlmsg->pos += sizeof(struct ifinfomsg);
 netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_xfrm(struct nlmsg* nlmsg, int sock, const char* name) {
 netlink_add_device_impl(nlmsg, "xfrm", name, true);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 int if_id = 1;
 netlink_attr(nlmsg, 2, &if_id, sizeof(if_id));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_hsr(struct nlmsg* nlmsg, int sock, const char* name,
                           const char* slave1, const char* slave2) {
 netlink_add_device_impl(nlmsg, "hsr", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 int ifindex1 = if_nametoindex(slave1);
 netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
 int ifindex2 = if_nametoindex(slave2);
 netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_linked(struct nlmsg* nlmsg, int sock, const char* type,
                              const char* name, const char* link) {
 netlink_add_device_impl(nlmsg, type, name, false);
 netlink_done(nlmsg);
 int ifindex = if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_vlan(struct nlmsg* nlmsg, int sock, const char* name,
                            const char* link, uint16_t id, uint16_t proto) {
 netlink_add_device_impl(nlmsg, "vlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
 netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex = if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_macvlan(struct nlmsg* nlmsg, int sock, const char* name,
                               const char* link) {
 netlink_add_device_impl(nlmsg, "macvlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 uint32_t mode = MACVLAN_MODE_BRIDGE;
 netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex = if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_add_geneve(struct nlmsg* nlmsg, int sock, const char* name,
                              uint32_t vni, struct in_addr* addr4,
                              struct in6_addr* addr6) {
 netlink_add_device_impl(nlmsg, "geneve", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
 if (addr4) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
 if (addr6) netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

#define IFLA_IPVLAN_FLAGS 2
#define IPVLAN_MODE_L3S 2
#undef IPVLAN_F_VEPA
#define IPVLAN_F_VEPA 2

static void netlink_add_ipvlan(struct nlmsg* nlmsg, int sock, const char* name,
                              const char* link, uint16_t mode,
                              uint16_t flags) {
 netlink_add_device_impl(nlmsg, "ipvlan", name, false);
 netlink_nest(nlmsg, IFLA_INFO_DATA);
 netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
 netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
 netlink_done(nlmsg);
 netlink_done(nlmsg);
 int ifindex = if_nametoindex(link);
 netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock,
                                 const char* name, bool up, const char* master,
                                 const void* mac, int macsize,
                                 const char* new_name) {
 struct ifinfomsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 if (up) hdr.ifi_flags = hdr.ifi_change = IFF_UP;
 hdr.ifi_index = if_nametoindex(name);
 netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
 if (new_name) netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
 if (master) {
   int ifindex = if_nametoindex(master);
   netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
 }
 if (macsize) netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
 int err = netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static int netlink_add_addr(struct nlmsg* nlmsg, int sock, const char* dev,
                           const void* addr, int addrsize) {
 struct ifaddrmsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 hdr.ifa_family = addrsize == 4 ? AF_INET : AF_INET6;
 hdr.ifa_prefixlen = addrsize == 4 ? 24 : 120;
 hdr.ifa_scope = RT_SCOPE_UNIVERSE;
 hdr.ifa_index = if_nametoindex(dev);
 netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
              sizeof(hdr));
 netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
 netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
 return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg, int sock, const char* dev,
                             const char* addr) {
 struct in_addr in_addr;
 inet_pton(AF_INET, addr, &in_addr);
 int err = netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
 if (err < 0) {
 }
}

static void netlink_add_addr6(struct nlmsg* nlmsg, int sock, const char* dev,
                             const char* addr) {
 struct in6_addr in6_addr;
 inet_pton(AF_INET6, addr, &in6_addr);
 int err = netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr));
 if (err < 0) {
 }
}

static struct nlmsg nlmsg;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name, const char* dev_name,
                                    const char* netdev_prefix) {
 struct genlmsghdr genlhdr;
 int len, total_len, id, err, offset;
 uint16_t netdev_index;
 int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
 if (sock == -1) exit(1);
 int rtsock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (rtsock == -1) exit(1);
 id = netlink_query_family_id(&nlmsg, sock, DEVLINK_FAMILY_NAME, true);
 if (id == -1) goto error;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd = DEVLINK_CMD_PORT_GET;
 netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
 netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
 err = netlink_send_ext(&nlmsg, sock, id, &total_len, true);
 if (err < 0) {
   goto error;
 }
 offset = 0;
 netdev_index = 0;
 while ((len = netlink_next_msg(&nlmsg, offset, total_len)) != -1) {
   struct nlattr* attr = (struct nlattr*)(nlmsg.buf + offset + NLMSG_HDRLEN +
                                          NLMSG_ALIGN(sizeof(genlhdr)));
   for (; (char*)attr < nlmsg.buf + offset + len;
        attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
     if (attr->nla_type == DEVLINK_ATTR_NETDEV_NAME) {
       char* port_name;
       char netdev_name[IFNAMSIZ];
       port_name = (char*)(attr + 1);
       snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
                netdev_index);
       netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
                             netdev_name);
       break;
     }
   }
   offset += len;
   netdev_index++;
 }
error:
 close(rtsock);
 close(sock);
}

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void netdevsim_add(unsigned int addr, unsigned int port_count) {
 write_file("/sys/bus/netdevsim/del_device", "%u", addr);
 if (write_file("/sys/bus/netdevsim/new_device", "%u %u", addr, port_count)) {
   char buf[32];
   snprintf(buf, sizeof(buf), "netdevsim%d", addr);
   initialize_devlink_ports("netdevsim", buf, "netdevsim");
 }
}

#define WG_GENL_NAME "wireguard"
enum wg_cmd {
 WG_CMD_GET_DEVICE,
 WG_CMD_SET_DEVICE,
};
enum wgdevice_attribute {
 WGDEVICE_A_UNSPEC,
 WGDEVICE_A_IFINDEX,
 WGDEVICE_A_IFNAME,
 WGDEVICE_A_PRIVATE_KEY,
 WGDEVICE_A_PUBLIC_KEY,
 WGDEVICE_A_FLAGS,
 WGDEVICE_A_LISTEN_PORT,
 WGDEVICE_A_FWMARK,
 WGDEVICE_A_PEERS,
};
enum wgpeer_attribute {
 WGPEER_A_UNSPEC,
 WGPEER_A_PUBLIC_KEY,
 WGPEER_A_PRESHARED_KEY,
 WGPEER_A_FLAGS,
 WGPEER_A_ENDPOINT,
 WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
 WGPEER_A_LAST_HANDSHAKE_TIME,
 WGPEER_A_RX_BYTES,
 WGPEER_A_TX_BYTES,
 WGPEER_A_ALLOWEDIPS,
 WGPEER_A_PROTOCOL_VERSION,
};
enum wgallowedip_attribute {
 WGALLOWEDIP_A_UNSPEC,
 WGALLOWEDIP_A_FAMILY,
 WGALLOWEDIP_A_IPADDR,
 WGALLOWEDIP_A_CIDR_MASK,
};

static void netlink_wireguard_setup(void) {
 const char ifname_a[] = "wg0";
 const char ifname_b[] = "wg1";
 const char ifname_c[] = "wg2";
 const char private_a[] =
     "\xa0\x5c\xa8\x4f\x6c\x9c\x8e\x38\x53\xe2\xfd\x7a\x70\xae\x0f\xb2\x0f\xa1"
     "\x52\x60\x0c\xb0\x08\x45\x17\x4f\x08\x07\x6f\x8d\x78\x43";
 const char private_b[] =
     "\xb0\x80\x73\xe8\xd4\x4e\x91\xe3\xda\x92\x2c\x22\x43\x82\x44\xbb\x88\x5c"
     "\x69\xe2\x69\xc8\xe9\xd8\x35\xb1\x14\x29\x3a\x4d\xdc\x6e";
 const char private_c[] =
     "\xa0\xcb\x87\x9a\x47\xf5\xbc\x64\x4c\x0e\x69\x3f\xa6\xd0\x31\xc7\x4a\x15"
     "\x53\xb6\xe9\x01\xb9\xff\x2f\x51\x8c\x78\x04\x2f\xb5\x42";
 const char public_a[] =
     "\x97\x5c\x9d\x81\xc9\x83\xc8\x20\x9e\xe7\x81\x25\x4b\x89\x9f\x8e\xd9\x25"
     "\xae\x9f\x09\x23\xc2\x3c\x62\xf5\x3c\x57\xcd\xbf\x69\x1c";
 const char public_b[] =
     "\xd1\x73\x28\x99\xf6\x11\xcd\x89\x94\x03\x4d\x7f\x41\x3d\xc9\x57\x63\x0e"
     "\x54\x93\xc2\x85\xac\xa4\x00\x65\xcb\x63\x11\xbe\x69\x6b";
 const char public_c[] =
     "\xf4\x4d\xa3\x67\xa8\x8e\xe6\x56\x4f\x02\x02\x11\x45\x67\x27\x08\x2f\x5c"
     "\xeb\xee\x8b\x1b\xf5\xeb\x73\x37\x34\x1b\x45\x9b\x39\x22";
 const uint16_t listen_a = 20001;
 const uint16_t listen_b = 20002;
 const uint16_t listen_c = 20003;
 const uint16_t af_inet = AF_INET;
 const uint16_t af_inet6 = AF_INET6;
 const struct sockaddr_in endpoint_b_v4 = {
     .sin_family = AF_INET,
     .sin_port = htons(listen_b),
     .sin_addr = {htonl(INADDR_LOOPBACK)}};
 const struct sockaddr_in endpoint_c_v4 = {
     .sin_family = AF_INET,
     .sin_port = htons(listen_c),
     .sin_addr = {htonl(INADDR_LOOPBACK)}};
 struct sockaddr_in6 endpoint_a_v6 = {.sin6_family = AF_INET6,
                                      .sin6_port = htons(listen_a)};
 endpoint_a_v6.sin6_addr = in6addr_loopback;
 struct sockaddr_in6 endpoint_c_v6 = {.sin6_family = AF_INET6,
                                      .sin6_port = htons(listen_c)};
 endpoint_c_v6.sin6_addr = in6addr_loopback;
 const struct in_addr first_half_v4 = {0};
 const struct in_addr second_half_v4 = {(uint32_t)htonl(128 << 24)};
 const struct in6_addr first_half_v6 = {{{0}}};
 const struct in6_addr second_half_v6 = {{{0x80}}};
 const uint8_t half_cidr = 1;
 const uint16_t persistent_keepalives[] = {1, 3, 7, 9, 14, 19};
 struct genlmsghdr genlhdr = {.cmd = WG_CMD_SET_DEVICE, .version = 1};
 int sock;
 int id, err;
 sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
 if (sock == -1) {
   return;
 }
 id = netlink_query_family_id(&nlmsg, sock, WG_GENL_NAME, true);
 if (id == -1) goto error;
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_a, strlen(ifname_a) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_a, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_a, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
              sizeof(endpoint_b_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[0], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v6,
              sizeof(endpoint_c_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[1], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err = netlink_send(&nlmsg, sock);
 if (err < 0) {
 }
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_b, strlen(ifname_b) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_b, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_b, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
              sizeof(endpoint_a_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[2], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v4,
              sizeof(endpoint_c_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[3], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err = netlink_send(&nlmsg, sock);
 if (err < 0) {
 }
 netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_c, strlen(ifname_c) + 1);
 netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_c, 32);
 netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_c, 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6,
              sizeof(endpoint_a_v6));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[4], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4,
              sizeof(first_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6,
              sizeof(first_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
 netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4,
              sizeof(endpoint_b_v4));
 netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
              &persistent_keepalives[5], 2);
 netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4,
              sizeof(second_half_v4));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_nest(&nlmsg, NLA_F_NESTED | 0);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
 netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6,
              sizeof(second_half_v6));
 netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 netlink_done(&nlmsg);
 err = netlink_send(&nlmsg, sock);
 if (err < 0) {
 }

error:
 close(sock);
}

static void initialize_netdevices(void) {
 char netdevsim[16];
 sprintf(netdevsim, "netdevsim%d", (int)procid);
 struct {
   const char* type;
   const char* dev;
 } devtypes[] = {
     {"ip6gretap", "ip6gretap0"}, {"bridge", "bridge0"}, {"vcan", "vcan0"},
     {"bond", "bond0"},           {"team", "team0"},     {"dummy", "dummy0"},
     {"nlmon", "nlmon0"},         {"caif", "caif0"},     {"batadv", "batadv0"},
     {"vxcan", "vxcan1"},         {"veth", 0},           {"wireguard", "wg0"},
     {"wireguard", "wg1"},        {"wireguard", "wg2"},
 };
 const char* devmasters[] = {"bridge", "bond", "team", "batadv"};
 struct {
   const char* name;
   int macsize;
   bool noipv6;
 } devices[] = {
     {"lo", ETH_ALEN},
     {"sit0", 0},
     {"bridge0", ETH_ALEN},
     {"vcan0", 0, true},
     {"tunl0", 0},
     {"gre0", 0},
     {"gretap0", ETH_ALEN},
     {"ip_vti0", 0},
     {"ip6_vti0", 0},
     {"ip6tnl0", 0},
     {"ip6gre0", 0},
     {"ip6gretap0", ETH_ALEN},
     {"erspan0", ETH_ALEN},
     {"bond0", ETH_ALEN},
     {"veth0", ETH_ALEN},
     {"veth1", ETH_ALEN},
     {"team0", ETH_ALEN},
     {"veth0_to_bridge", ETH_ALEN},
     {"veth1_to_bridge", ETH_ALEN},
     {"veth0_to_bond", ETH_ALEN},
     {"veth1_to_bond", ETH_ALEN},
     {"veth0_to_team", ETH_ALEN},
     {"veth1_to_team", ETH_ALEN},
     {"veth0_to_hsr", ETH_ALEN},
     {"veth1_to_hsr", ETH_ALEN},
     {"hsr0", 0},
     {"dummy0", ETH_ALEN},
     {"nlmon0", 0},
     {"vxcan0", 0, true},
     {"vxcan1", 0, true},
     {"caif0", ETH_ALEN},
     {"batadv0", ETH_ALEN},
     {netdevsim, ETH_ALEN},
     {"xfrm0", ETH_ALEN},
     {"veth0_virt_wifi", ETH_ALEN},
     {"veth1_virt_wifi", ETH_ALEN},
     {"virt_wifi0", ETH_ALEN},
     {"veth0_vlan", ETH_ALEN},
     {"veth1_vlan", ETH_ALEN},
     {"vlan0", ETH_ALEN},
     {"vlan1", ETH_ALEN},
     {"macvlan0", ETH_ALEN},
     {"macvlan1", ETH_ALEN},
     {"ipvlan0", ETH_ALEN},
     {"ipvlan1", ETH_ALEN},
     {"veth0_macvtap", ETH_ALEN},
     {"veth1_macvtap", ETH_ALEN},
     {"macvtap0", ETH_ALEN},
     {"macsec0", ETH_ALEN},
     {"veth0_to_batadv", ETH_ALEN},
     {"veth1_to_batadv", ETH_ALEN},
     {"batadv_slave_0", ETH_ALEN},
     {"batadv_slave_1", ETH_ALEN},
     {"geneve0", ETH_ALEN},
     {"geneve1", ETH_ALEN},
     {"wg0", 0},
     {"wg1", 0},
     {"wg2", 0},
 };
 int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (sock == -1) exit(1);
 unsigned i;
 for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
   netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
 for (i = 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
   char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
   sprintf(slave0, "%s_slave_0", devmasters[i]);
   sprintf(veth0, "veth0_to_%s", devmasters[i]);
   netlink_add_veth(&nlmsg, sock, slave0, veth0);
   sprintf(slave1, "%s_slave_1", devmasters[i]);
   sprintf(veth1, "veth1_to_%s", devmasters[i]);
   netlink_add_veth(&nlmsg, sock, slave1, veth1);
   sprintf(master, "%s0", devmasters[i]);
   netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL);
   netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL);
 }
 netlink_add_xfrm(&nlmsg, sock, "xfrm0");
 netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NULL);
 netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NULL);
 netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
 netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
 netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
 netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
 netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
 netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
 netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0",
                    "veth1_virt_wifi");
 netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
 netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_8021Q));
 netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_8021AD));
 netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
 netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
 netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L2, 0);
 netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L3S,
                    IPVLAN_F_VEPA);
 netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
 netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap");
 netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
 char addr[32];
 sprintf(addr, DEV_IPV4, 14 + 10);
 struct in_addr geneve_addr4;
 if (inet_pton(AF_INET, addr, &geneve_addr4) <= 0) exit(1);
 struct in6_addr geneve_addr6;
 if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <= 0) exit(1);
 netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
 netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
 netdevsim_add((int)procid, 4);
 netlink_wireguard_setup();
 for (i = 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
   char addr[32];
   sprintf(addr, DEV_IPV4, i + 10);
   netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
   if (!devices[i].noipv6) {
     sprintf(addr, DEV_IPV6, i + 10);
     netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
   }
   uint64_t macaddr = DEV_MAC + ((i + 10ull) << 40);
   netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macaddr,
                         devices[i].macsize, NULL);
 }
 close(sock);
}
static void initialize_netdevices_init(void) {
 int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (sock == -1) exit(1);
 struct {
   const char* type;
   int macsize;
   bool noipv6;
   bool noup;
 } devtypes[] = {
     {"nr", 7, true},
     {"rose", 5, true, true},
 };
 unsigned i;
 for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
   char dev[32], addr[32];
   sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
   sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
   netlink_add_addr4(&nlmsg, sock, dev, addr);
   if (!devtypes[i].noipv6) {
     sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
     netlink_add_addr6(&nlmsg, sock, dev, addr);
   }
   int macsize = devtypes[i].macsize;
   uint64_t macaddr = 0xbbbbbb +
                      ((unsigned long long)i << (8 * (macsize - 2))) +
                      (procid << (8 * (macsize - 1)));
   netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macaddr,
                         macsize, NULL);
 }
 close(sock);
}

#define MAX_FDS 30

static void setup_common() {
 if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
 }
}

static void setup_binderfs() {
 if (mkdir("/dev/binderfs", 0777)) {
 }
 if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
 }
 if (symlink("/dev/binderfs", "./binderfs")) {
 }
}

static void loop();

static void sandbox_common() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setsid();
 struct rlimit rlim;
 rlim.rlim_cur = rlim.rlim_max = (200 << 20);
 setrlimit(RLIMIT_AS, &rlim);
 rlim.rlim_cur = rlim.rlim_max = 32 << 20;
 setrlimit(RLIMIT_MEMLOCK, &rlim);
 rlim.rlim_cur = rlim.rlim_max = 136 << 20;
 setrlimit(RLIMIT_FSIZE, &rlim);
 rlim.rlim_cur = rlim.rlim_max = 1 << 20;
 setrlimit(RLIMIT_STACK, &rlim);
 rlim.rlim_cur = rlim.rlim_max = 128 << 20;
 setrlimit(RLIMIT_CORE, &rlim);
 rlim.rlim_cur = rlim.rlim_max = 256;
 setrlimit(RLIMIT_NOFILE, &rlim);
 if (unshare(CLONE_NEWNS)) {
 }
 if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
 }
 if (unshare(CLONE_NEWIPC)) {
 }
 if (unshare(0x02000000)) {
 }
 if (unshare(CLONE_NEWUTS)) {
 }
 if (unshare(CLONE_SYSVSEM)) {
 }
 typedef struct {
   const char* name;
   const char* value;
 } sysctl_t;
 static const sysctl_t sysctls[] = {
     {"/proc/sys/kernel/shmmax", "16777216"},
     {"/proc/sys/kernel/shmall", "536870912"},
     {"/proc/sys/kernel/shmmni", "1024"},
     {"/proc/sys/kernel/msgmax", "8192"},
     {"/proc/sys/kernel/msgmni", "1024"},
     {"/proc/sys/kernel/msgmnb", "1024"},
     {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
 };
 unsigned i;
 for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
   write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
 if (pid < 0) exit(1);
 int status = 0;
 while (waitpid(-1, &status, __WALL) != pid) {
 }
 return WEXITSTATUS(status);
}

static void drop_caps(void) {
 struct __user_cap_header_struct cap_hdr = {};
 struct __user_cap_data_struct cap_data[2] = {};
 cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
 cap_hdr.pid = getpid();
 if (syscall(SYS_capget, &cap_hdr, &cap_data)) exit(1);
 const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
 cap_data[0].effective &= ~drop;
 cap_data[0].permitted &= ~drop;
 cap_data[0].inheritable &= ~drop;
 if (syscall(SYS_capset, &cap_hdr, &cap_data)) exit(1);
}

static int do_sandbox_none(void) {
 if (unshare(CLONE_NEWPID)) {
 }
 int pid = fork();
 if (pid != 0) return wait_for_loop(pid);
 setup_common();
 sandbox_common();
 drop_caps();
 initialize_netdevices_init();
 if (unshare(CLONE_NEWNET)) {
 }
 write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
 initialize_netdevices();
 setup_binderfs();
 loop();
 exit(1);
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i = 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) == pid) return;
   usleep(1000);
 }
 DIR* dir = opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent = readdir(dir);
     if (!ent) break;
     if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd = open(abort, O_WRONLY);
     if (fd == -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) != pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds() {
 for (int fd = 3; fd < MAX_FDS; fd++) close(fd);
}

static void setup_binfmt_misc() {
 if (mount(0, "/proc/sys/fs/binfmt_misc", "binfmt_misc", 0, 0)) {
 }
 write_file("/proc/sys/fs/binfmt_misc/register", ":syz0:M:0:\x01::./file0:");
 write_file("/proc/sys/fs/binfmt_misc/register",
            ":syz1:M:1:\x02::./file0:POC");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter = 0;
 for (;; iter++) {
   int pid = fork();
   if (pid < 0) exit(1);
   if (pid == 0) {
     setup_test();
     execute_one();
     close_fds();
     exit(0);
   }
   int status = 0;
   uint64_t start = current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid) break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000) continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[6] = {0xffffffffffffffff, 0x0,
                0xffffffffffffffff, 0xffffffffffffffff,
                0xffffffffffffffff, 0xffffffffffffffff};

void execute_one(void) {
 intptr_t res = 0;
 res = syscall(__NR_socket, /*domain=*/0x11ul, /*type=*/0x800000003ul,
               /*proto=*/0);
 if (res != -1) r[0] = res;
 memcpy((void*)0x20000600, "team0\000\000\000\000\000\000\000\000\000\000\000",
        16);
 res = syscall(__NR_ioctl, /*fd=*/r[0], /*cmd=*/0x8933, /*arg=*/0x20000600ul);
 if (res != -1) r[1] = *(uint32_t*)0x20000610;
 res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
 if (res != -1) r[2] = res;
 *(uint64_t*)0x200007c0 = 0;
 *(uint32_t*)0x200007c8 = 0;
 *(uint64_t*)0x200007d0 = 0x20000780;
 *(uint64_t*)0x20000780 = 0x200002c0;
 *(uint32_t*)0x200002c0 = 0xb8;
 *(uint16_t*)0x200002c4 = 0x24;
 *(uint16_t*)0x200002c6 = 0xf0b;
 *(uint32_t*)0x200002c8 = 0;
 *(uint32_t*)0x200002cc = 0;
 *(uint8_t*)0x200002d0 = 0;
 *(uint8_t*)0x200002d1 = 0;
 *(uint16_t*)0x200002d2 = 0x12;
 *(uint32_t*)0x200002d4 = r[1];
 *(uint16_t*)0x200002d8 = 0;
 *(uint16_t*)0x200002da = 0;
 *(uint16_t*)0x200002dc = -1;
 *(uint16_t*)0x200002de = -1;
 *(uint16_t*)0x200002e0 = 0;
 *(uint16_t*)0x200002e2 = 0;
 *(uint16_t*)0x200002e4 = 0xb;
 *(uint16_t*)0x200002e6 = 1;
 memcpy((void*)0x200002e8, "taprio\000", 7);
 *(uint16_t*)0x200002f0 = 0x88;
 *(uint16_t*)0x200002f2 = 2;
 *(uint16_t*)0x200002f4 = 0x56;
 *(uint16_t*)0x200002f6 = 1;
 *(uint8_t*)0x200002f8 = 2;
 *(uint8_t*)0x200002f9 = 0;
 *(uint8_t*)0x200002fa = 0;
 *(uint8_t*)0x200002fb = 0;
 *(uint8_t*)0x200002fc = 0;
 *(uint8_t*)0x200002fd = 0;
 *(uint8_t*)0x200002fe = 0;
 *(uint8_t*)0x200002ff = 0;
 *(uint8_t*)0x20000300 = 0;
 *(uint8_t*)0x20000301 = 0;
 *(uint8_t*)0x20000302 = 0;
 *(uint8_t*)0x20000303 = 0;
 *(uint8_t*)0x20000304 = 0;
 *(uint8_t*)0x20000305 = 0;
 *(uint8_t*)0x20000306 = 0;
 *(uint8_t*)0x20000307 = 0;
 *(uint8_t*)0x20000308 = 0;
 *(uint8_t*)0x20000309 = 0;
 *(uint16_t*)0x2000030a = 8;
 *(uint16_t*)0x2000030c = 4;
 *(uint16_t*)0x2000030e = 0;
 *(uint16_t*)0x20000310 = 0;
 *(uint16_t*)0x20000312 = 0;
 *(uint16_t*)0x20000314 = 0;
 *(uint16_t*)0x20000316 = 0;
 *(uint16_t*)0x20000318 = 0;
 *(uint16_t*)0x2000031a = 0;
 *(uint16_t*)0x2000031c = 0;
 *(uint16_t*)0x2000031e = 0;
 *(uint16_t*)0x20000320 = 0;
 *(uint16_t*)0x20000322 = 0;
 *(uint16_t*)0x20000324 = 0;
 *(uint16_t*)0x20000326 = 0;
 *(uint16_t*)0x20000328 = 0;
 *(uint16_t*)0x2000032a = 0;
 *(uint16_t*)0x2000032c = 8;
 *(uint16_t*)0x2000032e = 0;
 *(uint16_t*)0x20000330 = 0;
 *(uint16_t*)0x20000332 = 0;
 *(uint16_t*)0x20000334 = 0;
 *(uint16_t*)0x20000336 = 0;
 *(uint16_t*)0x20000338 = 0;
 *(uint16_t*)0x2000033a = 0;
 *(uint16_t*)0x2000033c = 0;
 *(uint16_t*)0x2000033e = 0;
 *(uint16_t*)0x20000340 = 0;
 *(uint16_t*)0x20000342 = 0;
 *(uint16_t*)0x20000344 = 0;
 *(uint16_t*)0x20000346 = 0xd3a6;
 *(uint16_t*)0x20000348 = 0;
 *(uint16_t*)0x2000034c = 8;
 *(uint16_t*)0x2000034e = 5;
 *(uint32_t*)0x20000350 = 0;
 *(uint16_t*)0x20000354 = 0x18;
 STORE_BY_BITMASK(uint16_t, , 0x20000356, 2, 0, 14);
 STORE_BY_BITMASK(uint16_t, , 0x20000357, 0, 6, 1);
 STORE_BY_BITMASK(uint16_t, , 0x20000357, 1, 7, 1);
 *(uint16_t*)0x20000358 = 0x14;
 STORE_BY_BITMASK(uint16_t, , 0x2000035a, 1, 0, 14);
 STORE_BY_BITMASK(uint16_t, , 0x2000035b, 0, 6, 1);
 STORE_BY_BITMASK(uint16_t, , 0x2000035b, 1, 7, 1);
 *(uint16_t*)0x2000035c = 8;
 *(uint16_t*)0x2000035e = 4;
 *(uint32_t*)0x20000360 = 0x4000000;
 *(uint16_t*)0x20000364 = 8;
 *(uint16_t*)0x20000366 = 3;
 *(uint32_t*)0x20000368 = 3;
 *(uint16_t*)0x2000036c = 0xc;
 *(uint16_t*)0x2000036e = 3;
 *(uint64_t*)0x20000370 = 8;
 *(uint64_t*)0x20000788 = 0xb8;
 *(uint64_t*)0x200007d8 = 1;
 *(uint64_t*)0x200007e0 = 0;
 *(uint64_t*)0x200007e8 = 0;
 *(uint32_t*)0x200007f0 = 0;
 syscall(__NR_sendmsg, /*fd=*/r[2], /*msg=*/0x200007c0ul, /*f=*/0ul);
 res = syscall(__NR_socket, /*domain=*/0x11ul, /*type=*/0x800000003ul,
               /*proto=*/0);
 if (res != -1) r[3] = res;
 memcpy((void*)0x20000600, "team0\000\000\000\000\000\000\000\000\000\000\000",
        16);
 res = syscall(__NR_ioctl, /*fd=*/r[3], /*cmd=*/0x8933, /*arg=*/0x20000600ul);
 if (res != -1) r[4] = *(uint32_t*)0x20000610;
 res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
 if (res != -1) r[5] = res;
 *(uint64_t*)0x200007c0 = 0;
 *(uint32_t*)0x200007c8 = 0;
 *(uint64_t*)0x200007d0 = 0x20000780;
 *(uint64_t*)0x20000780 = 0x200002c0;
 memcpy((void*)0x200002c0,
        "\xb8\x00\x00\x00\x24\x00\x8d\xb0\xb1\x76\xe8\x6a\xcf\x40\xbc\x69\xf8"
        "\x0b\x0f\x00",
        20);
 *(uint32_t*)0x200002d4 = r[4];
 *(uint64_t*)0x20000788 = 0xb8;
 *(uint64_t*)0x200007d8 = 1;
 *(uint64_t*)0x200007e0 = 0;
 *(uint64_t*)0x200007e8 = 0;
 *(uint32_t*)0x200007f0 = 0;
 syscall(__NR_sendmsg, /*fd=*/r[5], /*msg=*/0x200007c0ul, /*f=*/0ul);
}
int main(void) {
 syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul, /*prot=*/7ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
         /*flags=*/0x32ul, /*fd=*/-1, /*offset=*/0ul);
 setup_binfmt_misc();
 do_sandbox_none();
 return 0;
}

=* repro.txt =*
r0 = socket(0x11, 0x800000003, 0x0)
ioctl$ifreq_SIOCGIFINDEX_team(r0, 0x8933,
&(0x7f0000000600)={'team0\x00', <r1=>0x0})
r2 = socket$netlink(0x10, 0x3, 0x0)
sendmsg$nl_route_sched(r2, &(0x7f00000007c0)={0x0, 0x0,
&(0x7f0000000780)={&(0x7f00000002c0)=@newqdisc={0xb8, 0x24, 0xf0b,
0x0, 0x0, {0x0, 0x0, 0x12, r1, {}, {0xffff, 0xffff}},
[@qdisc_kind_options=@q_taprio={{0xb}, {0x88, 0x2,
[@TCA_TAPRIO_ATTR_PRIOMAP={0x56, 0x1, {0x2, [], 0x0, [0x8, 0x4], [0x0,
0x8, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0xd3a6]}}, @TCA_TAPRIO_ATTR_SCHED_CLOCKID={0x8},
@TCA_TAPRIO_ATTR_SCHED_ENTRY_LIST={0x18, 0x2, 0x0, 0x1, [{0x14, 0x1,
0x0, 0x1, [@TCA_TAPRIO_SCHED_ENTRY_INTERVAL={0x8, 0x4, 0x4000000},
@TCA_TAPRIO_SCHED_ENTRY_GATE_MASK={0x8, 0x3, 0x3}]}]},
@TCA_TAPRIO_ATTR_SCHED_BASE_TIME={0xc, 0x3, 0x8}]}}]}, 0xb8}}, 0x0)
r3 = socket(0x11, 0x800000003, 0x0)
ioctl$ifreq_SIOCGIFINDEX_team(r3, 0x8933,
&(0x7f0000000600)={'team0\x00', <r4=>0x0})
r5 = socket$netlink(0x10, 0x3, 0x0)
sendmsg$nl_route_sched(r5, &(0x7f00000007c0)={0x0, 0x0,
&(0x7f0000000780)={&(0x7f00000002c0)=ANY=[@ANYBLOB="b800000024008db0b176e86acf40bc69f80b0f00",
@ANYRES32=r4, @ANYBLOB], 0xb8}}, 0x0)


and see also in
https://gist.github.com/xrivendell7/0e66bb071d535979eb51a76e149de1a0

I hope it helps.

Best regards.
xingwei Lee

