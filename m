Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71C7A97B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjIUR1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjIUR0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB41997
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-40475103519so12700055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695315694; x=1695920494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBT0O/Xci7r3f2IqHjI7FX0fJC0mLhgfI/yPTEIS3vE=;
        b=KsF2HMB/AX5p0ZsP26KrsKe+E7ja9Ajg21IU8nwXYSRTdGljT2zl6UMdAUmbtEASZV
         RnYSKzFcENgBd6KATjtVg/g1VGOHD+ieNowLBHH122Y6lkoy8UpOsKH6gbyig8MLIrdO
         sNqzC1zMxzyiToJF0iArL2xhcYnI3sKkiQr/f+wIV8xCqz4fXMpCAP5H32B0WmhEk+CC
         tW/at2ygDmCy+ubtmE0npAq6U3gKkU240+I9JTexSZn/nV38fZkzyHnO8RC3b9HQM9pw
         RdBibPiqqBOyHkylnydtndn6gqdbYPUn+B2ImWTXK0ZAOivtqtICrrBPkiKANIlhZ733
         3ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315694; x=1695920494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBT0O/Xci7r3f2IqHjI7FX0fJC0mLhgfI/yPTEIS3vE=;
        b=JNi4NBYS25Wu5F44GVWQzBZDhGsPZMxl1R0HIqyNlYk1cAifctuJTtmMS25wmr1/a0
         PsYA2CYZS8Z++QnjnelpjoLWS4KK0bXvuNNuLe27mzFVuBbdjG5nKMUp2EompX3HUEjQ
         aJdpDrOGQrLeJRM8NymVUx76QMQh4Q1T0MXNETvgr9OGIdfKGB+nOVLM+B0zIaGHEqks
         mw1aI56q6r5TJIVYC8yE2/tkVmL7cFrNszGlpmXUfTFcBuCbZhy5EU5A87nIG1HVaeyG
         j33qm2SkrAU1NQ4M5/BJa3lqZmw59zDrBDV2TzTw/uy53qCf/r/br9sBh3EkASXGtTDz
         o8ZQ==
X-Gm-Message-State: AOJu0Yx7xqYGjDcVcYoFdfGvJXH3DKwbDzvPWSFZd5hJACuBnbH7ExEW
        M0hHmKq0KFh58rpDUd4SXRvduA==
X-Google-Smtp-Source: AGHT+IESPHzkLKo4hVQmmDh60dY4Pt7P6L91htiazcU1+sSr3zf3jv+A/Vrd8EboGQoplhi5DKMTIw==
X-Received: by 2002:a05:600c:1e05:b0:405:3a3d:6f41 with SMTP id ay5-20020a05600c1e0500b004053a3d6f41mr723959wmb.22.1695315693942;
        Thu, 21 Sep 2023 10:01:33 -0700 (PDT)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a3-20020a5d4d43000000b003177074f830sm2260297wru.59.2023.09.21.10.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 10:01:33 -0700 (PDT)
Message-ID: <18267b34-1dcf-08d5-5ba1-4f5162e6c43a@arista.com>
Date:   Thu, 21 Sep 2023 18:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [net?] memory leak in tcp_md5_do_add
Content-Language: en-US
To:     Eric Dumazet <edumazet@google.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com>
References: <0000000000004d83170605e16003@google.com>
 <CANn89iJwQ3TCSm+SMs=W90oThgRMLoiSAcTBJ9LH2AVsJY1NBA@mail.gmail.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89iJwQ3TCSm+SMs=W90oThgRMLoiSAcTBJ9LH2AVsJY1NBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 17:59, Eric Dumazet wrote:
> On Thu, Sep 21, 2023 at 6:56 PM syzbot
> <syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1312bba8c80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5733ca1757172ad
>> dashboard link: https://syzkaller.appspot.com/bug?extid=68662811b3d5f6695bcb
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105393a8c80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1113917f480000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/29e7966ab711/disk-ee3f96b1.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/ae21b8e855de/vmlinux-ee3f96b1.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/803ee0425ad6/bzImage-ee3f96b1.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+68662811b3d5f6695bcb@syzkaller.appspotmail.com
>>
>> executing program
>> BUG: memory leak
>> unreferenced object 0xffff88810a86f7a0 (size 32):
>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<ffffffff81533d64>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1061
>>     [<ffffffff840edaa0>] kmalloc include/linux/slab.h:580 [inline]
>>     [<ffffffff840edaa0>] tcp_md5sig_info_add net/ipv4/tcp_ipv4.c:1169 [inline]
>>     [<ffffffff840edaa0>] tcp_md5_do_add+0xa0/0x150 net/ipv4/tcp_ipv4.c:1240
>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> BUG: memory leak
>> unreferenced object 0xffff88811225ccc0 (size 192):
>>   comm "syz-executor325", pid 5099, jiffies 4294978342 (age 119.240s)
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 22 01 00 00 00 00 ad de  ........".......
>>     22 0a 80 00 fe 80 00 00 00 00 00 00 00 00 00 00  "...............
>>   backtrace:
>>     [<ffffffff8153444a>] __do_kmalloc_node mm/slab_common.c:966 [inline]
>>     [<ffffffff8153444a>] __kmalloc+0x4a/0x120 mm/slab_common.c:980
>>     [<ffffffff83d75c15>] kmalloc include/linux/slab.h:584 [inline]
>>     [<ffffffff83d75c15>] sock_kmalloc net/core/sock.c:2635 [inline]
>>     [<ffffffff83d75c15>] sock_kmalloc+0x65/0xa0 net/core/sock.c:2624
>>     [<ffffffff840eb9bb>] __tcp_md5_do_add+0xcb/0x300 net/ipv4/tcp_ipv4.c:1212
>>     [<ffffffff840eda67>] tcp_md5_do_add+0x67/0x150 net/ipv4/tcp_ipv4.c:1253
>>     [<ffffffff84262c73>] tcp_v6_parse_md5_keys+0x253/0x4a0 net/ipv6/tcp_ipv6.c:671
>>     [<ffffffff840c720e>] do_tcp_setsockopt+0x40e/0x1360 net/ipv4/tcp.c:3720
>>     [<ffffffff840c81fb>] tcp_setsockopt+0x9b/0xa0 net/ipv4/tcp.c:3806
>>     [<ffffffff83d72a8b>] __sys_setsockopt+0x1ab/0x330 net/socket.c:2274
>>     [<ffffffff83d72c36>] __do_sys_setsockopt net/socket.c:2285 [inline]
>>     [<ffffffff83d72c36>] __se_sys_setsockopt net/socket.c:2282 [inline]
>>     [<ffffffff83d72c36>] __x64_sys_setsockopt+0x26/0x30 net/socket.c:2282
>>     [<ffffffff849ad699>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     [<ffffffff849ad699>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>>     [<ffffffff84a0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the bug is already fixed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite bug's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the bug is a duplicate of another bug, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
> 
> Dmitry, please take a look at this bug, we need to fix it before your
> patch series.

Sure, seems reasonable to me to fix before merging something on top.

> Thank you.

Thanks,
           Dmitry

