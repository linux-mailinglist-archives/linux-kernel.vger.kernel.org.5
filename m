Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE86375AA3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjGTI7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjGTIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:51:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C99B2699;
        Thu, 20 Jul 2023 01:51:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6682909acadso307088b3a.3;
        Thu, 20 Jul 2023 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689843105; x=1690447905;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cr2MXkR/4oA+OZ9ohluOM9ga2ihH9xMp4l0k03eWdbo=;
        b=sedc5f30vbvHYbFa79fXH4b389O1kZdEm9F0Ejeb6/4GOpaRqS2lUH4QF+BTxcyiLl
         HSxkOz/99Lutjas8xYEE8oBiNykx/VQckwCygC+zFpCw8ArlQKaIspek5czVrIpwJOU1
         iDNrmpBUYd1erSYkDR14VoueWb42DkvYPV4b60TXQgGUzU1EPGJvnPmCF77nyFbW4afH
         sXNU93owQx/ikrBtFDVIGO8fzsG/bh/ga/No0dr+FwTGAvhtWpsHE1nC5tTF4KClWgV3
         03zx4D0QBs/QtEJ1lrolcxjiMzLE/12cGgejOMHXk6wvwpDtggo07cShANtsUVuho7IW
         kZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689843105; x=1690447905;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cr2MXkR/4oA+OZ9ohluOM9ga2ihH9xMp4l0k03eWdbo=;
        b=f79S98ZVzK6OlHMKWUMp9Xuvtz7O97RdWbDJ9uxJMLJcngvI2SbrhYIBI/WnB4URij
         6VrAaMFBij8DH4ToCT+n9fAnIsRNQVXH2kb5na1FmEDiIIHe3v5wU2qCIWI3EWIL4Pe6
         srAmYKMqI1jjRxot5fcV+86EH7QCJ3/j8Lv8NNzmtZ8Yy+uqfDkT+yVhbaNF9YjLy+Lc
         6HLyklMt3u3/+etd9P4Lxu99YYpttMa9ModSm/P1qFOoFyZufKyWfYBhxtP+wPnN52k1
         OXvcNk+SUmTrEBlrlUlbf7dLdet4T5ZN9bG+gPf7fLOK+ifIi+YtQl1DTgW+HJ3+0TBg
         Z9dg==
X-Gm-Message-State: ABy/qLZIWMtgBDGmR45KjOnJJEN44M599Eg/gEB7zCzFMfI0sb1UQXmt
        nIT4mBjwx3OrGBML0gUrU5E=
X-Google-Smtp-Source: APBJJlFUVSmSAPqqBg05BO1nkV11VTbdpFR47JhyrCBZoXA3iOTRaDUVR70nACshlEY1PhiVXqBSXQ==
X-Received: by 2002:a05:6a20:4291:b0:137:3224:16c1 with SMTP id o17-20020a056a20429100b00137322416c1mr4343315pzj.45.1689843105423;
        Thu, 20 Jul 2023 01:51:45 -0700 (PDT)
Received: from [192.168.123.101] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b00682a908949bsm657449pfi.92.2023.07.20.01.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:51:44 -0700 (PDT)
Message-ID: <8b67a05d-d1b2-e228-46ca-db4c3136c29e@gmail.com>
Date:   Thu, 20 Jul 2023 17:51:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (2)
To:     syzbot <syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com>,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
References: <000000000000a054ee05bc4b2009@google.com>
From:   Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <000000000000a054ee05bc4b2009@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021. 2. 27. 오후 3:02, syzbot wrote:
 > Hello,
 >
 > syzbot found the following issue on:
 >
 > HEAD commit:    557c223b selftests/bpf: No need to drop the packet 
when th..
 > git tree:       bpf
 > console output: https://syzkaller.appspot.com/x/log.txt?x=156409a8d00000
 > kernel config: 
https://syzkaller.appspot.com/x/.config?x=2b8307379601586a
 > dashboard link: 
https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
 >
 > Unfortunately, I don't have any reproducer for this issue yet.
 >
 > IMPORTANT: if you fix the issue, please add the following tag to the 
commit:
 > Reported-by: syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com
 >
 > netlink: 'syz-executor.4': attribute type 10 has an invalid length.
 > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
 > turning off the locking correctness validator.
 > CPU: 1 PID: 22786 Comm: syz-executor.4 Not tainted 5.11.0-syzkaller #0
 > Hardware name: Google Google Compute Engine/Google Compute Engine, 
BIOS Google 01/01/2011
 > Call Trace:
 >   __dump_stack lib/dump_stack.c:79 [inline]
 >   dump_stack+0xfa/0x151 lib/dump_stack.c:120
 >   add_chain_cache kernel/locking/lockdep.c:3540 [inline]
 >   lookup_chain_cache_add kernel/locking/lockdep.c:3621 [inline]
 >   validate_chain kernel/locking/lockdep.c:3642 [inline]
 >   __lock_acquire.cold+0x3af/0x3b4 kernel/locking/lockdep.c:4900
 >   lock_acquire kernel/locking/lockdep.c:5510 [inline]
 >   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
 >   do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
 >   do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
 >   psi_group_change+0x123/0x8d0 kernel/sched/psi.c:707
 >   psi_task_change+0x142/0x220 kernel/sched/psi.c:807
 >   psi_enqueue kernel/sched/stats.h:82 [inline]
 >   enqueue_task kernel/sched/core.c:1590 [inline]
 >   activate_task kernel/sched/core.c:1613 [inline]
 >   ttwu_do_activate+0x25b/0x660 kernel/sched/core.c:2991
 >   ttwu_queue kernel/sched/core.c:3188 [inline]
 >   try_to_wake_up+0x60e/0x14a0 kernel/sched/core.c:3466
 >   wake_up_worker kernel/workqueue.c:837 [inline]
 >   insert_work+0x2a0/0x370 kernel/workqueue.c:1346
 >   __queue_work+0x5c1/0xf00 kernel/workqueue.c:1497
 >   __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1644
 >   mod_delayed_work_on+0xdd/0x1e0 kernel/workqueue.c:1718
 >   mod_delayed_work include/linux/workqueue.h:537 [inline]
 >   addrconf_mod_dad_work net/ipv6/addrconf.c:328 [inline]
 >   addrconf_dad_start net/ipv6/addrconf.c:4013 [inline]
 >   addrconf_add_linklocal+0x321/0x590 net/ipv6/addrconf.c:3186
 >   addrconf_addr_gen+0x3a4/0x3e0 net/ipv6/addrconf.c:3313
 >   addrconf_dev_config+0x26c/0x410 net/ipv6/addrconf.c:3360
 >   addrconf_notify+0x362/0x23e0 net/ipv6/addrconf.c:3593
 >   notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 >   call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2063
 >   call_netdevice_notifiers_extack net/core/dev.c:2075 [inline]
 >   call_netdevice_notifiers net/core/dev.c:2089 [inline]
 >   dev_open net/core/dev.c:1592 [inline]
 >   dev_open+0x132/0x150 net/core/dev.c:1580
 >   team_port_add drivers/net/team/team.c:1210 [inline]
 >   team_add_slave+0xa53/0x1c20 drivers/net/team/team.c:1967
 >   do_set_master+0x1c8/0x220 net/core/rtnetlink.c:2519
 >   do_setlink+0x920/0x3a70 net/core/rtnetlink.c:2715
 >   __rtnl_newlink+0xdc6/0x1710 net/core/rtnetlink.c:3376
 >   rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3491
 >   rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5553
 >   netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 >   netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 >   netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 >   netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 >   sock_sendmsg_nosec net/socket.c:652 [inline]
 >   sock_sendmsg+0xcf/0x120 net/socket.c:672
 >   ____sys_sendmsg+0x6e8/0x810 net/socket.c:2348
 >   ___sys_sendmsg+0xf3/0x170 net/socket.c:2402
 >   __sys_sendmsg+0xe5/0x1b0 net/socket.c:2435
 >   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 >   entry_SYSCALL_64_after_hwframe+0x44/0xae
 > RIP: 0033:0x465ef9
 > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
 > RSP: 002b:00007f2db3282188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 > RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465ef9
 > RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000004
 > RBP: 00000000004bcd1c R08: 0000000000000000 R09: 0000000000000000
 > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
 > R13: 00007ffea3f3a6af R14: 00007f2db3282300 R15: 0000000000022000
 > team0: Device ipvlan0 failed to register rx_handler
 >

Hi,

This issue would occur by the commit 369f61bee0f5 ("team: fix nested 
locking lockdep warning").
This patch uses the dynamic lockdep key mechanism instead of the static 
lockdep key to fix nested locking lockdep warnings.

The problem with the dynamic lockdep key mechanism is that each 
interface registers its own lockdep key.
If there are 4K interfaces, it uses 4K lockdep keys.
So, the "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" splat occurs if there 
are so many team interfaces.

I think it should use the static lockdep key instead of the dynamic 
lockdep key.
If so, all team interfaces use only 8 lockdep keys, so this splat wil be 
disappeared.
The patch will be similar to the b3e80d44f5b1 ("bonding: fix lockdep 
warning in bond_get_stats()")
and e7511f560f5 ("bonding: remove useless stats_lock_key").
I will send a patch for it.

Thanks a lot!
Taehee Yoo

 >
 > ---
 > This report is generated by a bot. It may contain errors.
 > See https://goo.gl/tpsmEJ for more information about syzbot.
 > syzbot engineers can be reached at syzkaller@googlegroups.com.
 >
 > syzbot will keep track of this issue. See:
 > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
