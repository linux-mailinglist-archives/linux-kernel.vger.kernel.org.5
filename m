Return-Path: <linux-kernel+bounces-29761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE9831313
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A224FB212E1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C722B65B;
	Thu, 18 Jan 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzJ+o+Br"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F9944D;
	Thu, 18 Jan 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562699; cv=none; b=sCVAFCvGfylFJvZP5zXlO10OFfyA7En5drJpitVIh6MyKoj/9Pwv7zFy/a6Bs40uHumNHCPpc6zjCyrCmAPL7FPaUzvYy1zJTeqGVjkcitbPOOE2aZZ1c1GW60msM5pC/NZghWze2BQ8TncFlqZH/BS3jO4DaiqeRJFBWiWuOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562699; c=relaxed/simple;
	bh=cw/DUQpgxBkbK5fNpBuUe09CPPbuuP8Kb4vqkUhP3ug=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=hyeQGIhBdl7hx42JB80WTaF8oInQMYYf2v3te9tl6zXPUmjMtb7By2GDcJUCVNXmB0y6hyqCQepwCJdclLwsQD48kByE2okygWT1UEvHn0cm5vi9dbPe9s31YzVgX8w5eEJsNDGps13EW9vbyLwjKMWUeLladrgfV7RIRoMattI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzJ+o+Br; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9bec20980so6623174b3a.2;
        Wed, 17 Jan 2024 23:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705562697; x=1706167497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnqK7NJlnkgLKg2e9dDqbONSyx6zKQfOIk2cR4ZCvvU=;
        b=FzJ+o+Br80R1vF7ZSB3uKrNzlzu6OnWJ8bpI/lpj+nJurZYW9n5WZtHIPnp6+LFERh
         uZRw1WDkWVgHn1uKsBLWSf026RAaX2MSJ93SRIu+Ie07hpSqL5Llho93qDNkJuPuxj2Q
         3B+Fg+rfzXshbv3CEV4oN1zn6DoUvauRiIUXTB7dU3Q/55A8YgovuSgDAx5DbLcwVwXv
         8XhaZSlJC3m4kjYMcCJBIb+Ifmj7Dl/qEBk5VkIMOXA+Z3INweFCNswgMevnVe5s1Loz
         cZj+3i4AKOyZYMvgURySOSt0lq7x6FPTCgEEKuNZLdLBPREC0T3ajzVxaN0PTu2huPk9
         B2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705562697; x=1706167497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnqK7NJlnkgLKg2e9dDqbONSyx6zKQfOIk2cR4ZCvvU=;
        b=h2+7c2pZ33kemWs3hPlO9mX+RUPbl2pfoY4NNZD02IxxjlFnkVhxVuLVCGnTSYYqGm
         8ruEgkCaND3WDj8WmpVgo5nO85P9E/X5XTFRz8jdRRnmIYCZePoCFBRJpQ/K1WeHm71y
         abd4TY382PKRZpKiSZaHyoXlgLWoz2+Lt9Zxl9GM+mGESoDYhVNP2Snuf984TdyWnxbV
         PIO+EAlyQEdEz9oY4Sa//z/ja81VFBUpIyWXD7ehlyjz8Tt0Cv0XkIIZjs9zzyJgyU84
         EcBIOauCK8NSH3UDHH86huM+obbnsI8031EeQ+lzbCKoQ7y3yQvimA0QyGT0C91Ne9wl
         zA8A==
X-Gm-Message-State: AOJu0YxPxMBhKQznRexrA+WCIhVFBPo1HpMhyNeGkC2fyZFlzMRhCm6B
	Rd1QMW2lRFzu9CBFW93AfaNF9p+IoEdtKdiOa26PWilGjPtATVQB
X-Google-Smtp-Source: AGHT+IGHMur5P7YcB7ee/RW1xLtwBbnGhhSeo71er2JxU5SxBsIG833DQcu4VH/HFF+RFmAFHZVvHA==
X-Received: by 2002:a05:6a00:238f:b0:6db:7228:ec with SMTP id f15-20020a056a00238f00b006db722800ecmr423686pfc.17.1705562697357;
        Wed, 17 Jan 2024 23:24:57 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id fm9-20020a056a002f8900b006d9b2d86bcasm2623451pfb.46.2024.01.17.23.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 23:24:56 -0800 (PST)
Message-ID: <bac390f1-ef6d-317f-a5e1-1c0c5e4e4535@gmail.com>
Date: Thu, 18 Jan 2024 16:24:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down /
 mld_ifc_work
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
 <ZaiQs6yTY7XuS06i@Laptop-X1>
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <ZaiQs6yTY7XuS06i@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/24 11:45, Hangbin Liu wrote:

Hi Hangbin,

 > On Wed, Jan 17, 2024 at 09:21:02AM -0800, Nikita Zhandarovich wrote:
 >> idev->mc_ifc_count can be written over without proper locking.
 >>
 >> Originally found by syzbot [1], fix this issue by encapsulating calls
 >> to mld_ifc_stop_work() (and mld_gq_stop_work() for good measure) with
 >> mutex_lock() and mutex_unlock() accordingly as these functions
 >> should only be called with mc_lock per their declarations.
 >>
 >> [1]
 >> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
 >>
 >> write to 0xffff88813a80c832 of 1 bytes by task 3771 on cpu 0:
 >> mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
 >> ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
 >> addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
 >> addrconf_notify+0x310/0x980
 >> notifier_call_chain kernel/notifier.c:93 [inline]
 >> raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
 >> __dev_notify_flags+0x205/0x3d0
 >> dev_change_flags+0xab/0xd0 net/core/dev.c:8685
 >> do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
 >> rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
 >> __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
 >> rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
 >> rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
 >> netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
 >> rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
 >> netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 >> netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
 >> netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
 >> ...
 >>
 >> write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
 >> mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
 >> process_one_work kernel/workqueue.c:2627 [inline]
 >> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 >> worker_thread+0x525/0x730 kernel/workqueue.c:2781
 >> ...
 >>
 >> Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
 >> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
 >> Link: 
https://lore.kernel.org/all/000000000000994e09060ebcdffb@google.com/
 >> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
 >> ---
 >> net/ipv6/mcast.c | 4 ++++
 >> 1 file changed, 4 insertions(+)
 >>
 >> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
 >> index b75d3c9d41bb..bc6e0a0bad3c 100644
 >> --- a/net/ipv6/mcast.c
 >> +++ b/net/ipv6/mcast.c
 >> @@ -2722,8 +2722,12 @@ void ipv6_mc_down(struct inet6_dev *idev)
 >> synchronize_net();
 >> mld_query_stop_work(idev);
 >> mld_report_stop_work(idev);
 >> +
 >> + mutex_lock(&idev->mc_lock);
 >> mld_ifc_stop_work(idev);
 >> mld_gq_stop_work(idev);
 >> + mutex_unlock(&idev->mc_lock);
 >> +
 >> mld_dad_stop_work(idev);
 >> }
 >>
 >
 > I saw mld_process_v1() also cancel these works when changing to v1 mode.
 > Should we also add lock there?

I think mld_process_v1() doesn't have a problem.
Because mld_process_v1() is always called under mc_lock by mld_query_work().

mld_query_work()
    mutex_lock(&idev->mc_lock);
     __mld_query_work();
        mld_process_v1();
    mutex_unlock(&idev->mc_lock);

 >
 > Thanks
 > Hangbin

Thanks a lot,
Taehee Yoo

