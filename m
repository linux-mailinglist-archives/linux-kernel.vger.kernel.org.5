Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A87E5ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKHQMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjKHQMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:12:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC621BDD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:12:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc30bf9e22so7670815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699459919; x=1700064719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=polvhyFKi41sYRbfyXcWfNg92E/y83EB4K6tLgO22GE=;
        b=fMZnLo4HPvXvwWMfWCCcRaMigK5xh+kX8wf4RZP2ma321/Z1JYQo67/VszzQKNfw3v
         3goPttKl/odneFolWfAMNBV+uKusYqOJTz+2d+qbsrUl40GYO0Vyu5Xb1bqF0PQQxo6N
         2sXqMep1TEfCP1PvZWdk8tOgt8tDsdl1rpkNEojQ7Wct8EIXPhAQhcNA1p9dgSJqAwrl
         HqOxIDKgtzECFs4A1TVvFzQHzaGmO8FoEWWHomv9jpMcYN2EvVdhVuFTIOR+wtprT9ZU
         71u4PYuR6PLGo+o7ahJ6ZdcmIiDkmNK/Cp449N3FRHsAgoHieJXJTqhbHyVwci1HCcQG
         UYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459919; x=1700064719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=polvhyFKi41sYRbfyXcWfNg92E/y83EB4K6tLgO22GE=;
        b=DcG4/FznOj+wkTVYval7m4uRoc4Yq0kZkct0xqQkSUVSt/NMwvh0MXF4Ilds3eMqNZ
         IeU+/xH6Bdd8k/tPsa2+ED7VAvevGBfoj1zQWxoCEDA0k6GygG9emOnONcZkvj6IlVgQ
         vr8J1IpLXnIFDIUQxy53+M4ssjGMdB/om7C9IatLTDfwXfFxKGseTIs6pyuHffsPxZl4
         dWSrUszlL6XEschFzJbCTTJ9vIZSPXaMjQSJJNrS6Cn5FCTHJ/oFpuEnrvBTp/5iKQYj
         wLYfaAsicH3KFFsPTRjJCgTbezk+yPfPrY0KzBZnu2zHmdn6cun8beOuuV6ldaslkL2z
         COVQ==
X-Gm-Message-State: AOJu0Ywzp1YOSTFSUjJe5eC7Zh+Kz6Aze2VsgcgEcI9yLWC+fKfo5vmu
        FMEI0S3yW7Qot0rr2XrfWX0AiA==
X-Google-Smtp-Source: AGHT+IGIHNEVwzF/gyLgbWBbkclZC1Cl+aAPHlcgnsXyRaq8hkIiNwI80BUKnJwETkn1zLVFUQ+98w==
X-Received: by 2002:a17:902:d389:b0:1cc:4810:6f2c with SMTP id e9-20020a170902d38900b001cc48106f2cmr2906326pld.33.1699459919231;
        Wed, 08 Nov 2023 08:11:59 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::1118? ([2620:10d:c090:400::4:86d6])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902cec200b001c3be750900sm1938192plg.163.2023.11.08.08.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 08:11:58 -0800 (PST)
Message-ID: <1d1f7518-6ff9-4402-a874-5c0138bedefd@davidwei.uk>
Date:   Wed, 8 Nov 2023 08:11:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (2)
Content-Language: en-GB
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
Cc:     avagin@gmail.com, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000004ba00e0605ce2fcf@google.com>
 <20230920185952.94518-1-kuniyu@amazon.com>
From:   David Wei <dw@davidwei.uk>
In-Reply-To: <20230920185952.94518-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-20 11:59, Kuniyuki Iwashima wrote:
> From: syzbot <syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com>
> Date: Wed, 20 Sep 2023 11:02:55 -0700
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17405ab0680000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d594086f139d167
>> dashboard link: https://syzkaller.appspot.com/bug?extid=71e724675ba3958edb31
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b2e118680000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127b55c4680000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/456b02029fa8/disk-2cf0f715.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/9f9ff0c00454/vmlinux-2cf0f715.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/0ede19fba30f/bzImage-2cf0f715.xz
>>
>> The issue was bisected to:
>>
>> commit c48ef9c4aed3632566b57ba66cec6ec78624d4cb
>> Author: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Date:   Mon Sep 11 18:36:57 2023 +0000
>>
>>     tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
>>
> 
> We need this condition to put v4 sk and v4-mapped-v6 sk into
> the same bucket.
> 
> ---8<---
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index dfb1c61c0c2b..6487357d1ddd 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -822,7 +823,8 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
>  			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
>  				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
>  
> -		return false;
> +		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
> +			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb->rcv_saddr;
>  	}
>  
>  	if (sk->sk_family == AF_INET6)
> ---8<---
> 
> Scenario is like
> 
>   1) bind(v4) creates a tb2 bucket
>   2) bind(v4-mapped-v6) creates another tb2 bucket
>   3) listen(v4) finds the second tb2 and trigger warning
> 
> ---8<---
> from socket import *
> 
> s = socket()
> s.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> s.bind(('255.255.255.255', 0))
> 
> s2 = socket(AF_INET6, SOCK_STREAM)
> s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> s2.bind(('::ffff:255.255.255.255', s.getsockname()[1]))
> s.listen()
> ---8<---
> 
> Will post a formal patch after doing more tests with SO_REUSEPORT.
> 
> Thanks!

Hi Kuniyuki, did you get around to fixing and posting this patch? I
couldn't find anything on the mailing list.

Would you like help fixing this?

> 
> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15567dc4680000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17567dc4680000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13567dc4680000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+71e724675ba3958edb31@syzkaller.appspotmail.com
>> Fixes: c48ef9c4aed3 ("tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.")
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 5049 at net/ipv4/inet_connection_sock.c:587 inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
>> Modules linked in:
>> CPU: 0 PID: 5049 Comm: syz-executor288 Not tainted 6.6.0-rc2-syzkaller-00018-g2cf0f7156238 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
>> RIP: 0010:inet_csk_get_port+0xf96/0x2350 net/ipv4/inet_connection_sock.c:587
>> Code: 7c 24 08 e8 4c b6 8a 01 31 d2 be 88 01 00 00 48 c7 c7 e0 94 ae 8b e8 59 2e a3 f8 2e 2e 2e 31 c0 e9 04 fe ff ff e8 ca 88 d0 f8 <0f> 0b e9 0f f9 ff ff e8 be 88 d0 f8 49 8d 7e 48 e8 65 ca 5a 00 31
>> RSP: 0018:ffffc90003abfbf0 EFLAGS: 00010293
>> RAX: 0000000000000000 RBX: ffff888026429100 RCX: 0000000000000000
>> RDX: ffff88807edcbb80 RSI: ffffffff88b73d66 RDI: ffff888026c49f38
>> RBP: ffff888026c49f30 R08: 0000000000000005 R09: 0000000000000000
>> R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff9260f200
>> R13: ffff888026c49880 R14: 0000000000000000 R15: ffff888026429100
>> FS:  00005555557d5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000045ad50 CR3: 0000000025754000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  inet_csk_listen_start+0x155/0x360 net/ipv4/inet_connection_sock.c:1256
>>  __inet_listen_sk+0x1b8/0x5c0 net/ipv4/af_inet.c:217
>>  inet_listen+0x93/0xd0 net/ipv4/af_inet.c:239
>>  __sys_listen+0x194/0x270 net/socket.c:1866
>>  __do_sys_listen net/socket.c:1875 [inline]
>>  __se_sys_listen net/socket.c:1873 [inline]
>>  __x64_sys_listen+0x53/0x80 net/socket.c:1873
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x7f3a5bce3af9
>> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007ffc1a1c79e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3a5bce3af9
>> RDX: 00007f3a5bce3af9 RSI: 0000000000000000 RDI: 0000000000000003
>> RBP: 00007f3a5bd565f0 R08: 0000000000000006 R09: 0000000000000006
>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
>> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>>  </TASK>
