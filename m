Return-Path: <linux-kernel+bounces-22500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96C829EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4972288625
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64CC4CB30;
	Wed, 10 Jan 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ul80SHaO"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F43FE3D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so3228899a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704904358; x=1705509158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw6sqCsRLXOTZBxcH2QDjDIvOAhestSnQEBPI9xVsMU=;
        b=ul80SHaOA9BEWpK3//kZVGh8z97V4xwiCIwueuLt/httZbtCgIqtZkfSk1yO1qNXt5
         ACv1LaqhuFN69sUyt9WIfVlACHuE5pCHPuFvULS9C75ub7NwWbMpF5Kp5MEeMtFE3s52
         r9Pdin1oTRH0fmwFsk8cvF0WQ7E0iptXNkU9KEo3hute75d7SnGyjiqV3IBJWkZcLSlA
         HOVZDZA3H4jND8r5hqyVem2i/5F7iGEBhtChk8WOY7VM3TMx1OBlEpHEAis/64HrPjld
         gGB93K/WCitXTP4BOwesIWT3EVYbngoei1ZbdI1mTfX59OByD2Igy/3HtPERAiqCfXQ2
         NOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704904358; x=1705509158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw6sqCsRLXOTZBxcH2QDjDIvOAhestSnQEBPI9xVsMU=;
        b=mBMN+XzZONsCKxcLxm3kV1J/a8M3ZGgRQGTR7vRC525OkkuSZwmMY0GGB/bkuyWwl8
         Gi5+TKW66YLwPCqdwAc9NZrUbhYLk9lQvZMLPOCeVcxEg/RqzmGeaMRXAjphjyXV/iNo
         HjxNAxF8KrU0E3/rZP9gAgnNjWFKpNL0gt3ca+rg1HfmrJ/EXx8qP1gz3Nwa6/lFKwX+
         jDm3Pn7HLSs3DDSjeN9IcUhTaxcz4b3QCozGy8S58zh255MGaMrJtw66tdFFidXOJ7BX
         FfZ0hMvGAHKT8MzYSdcoA0PZiPL5Q5fRk+9I6/rC03MWTWQO3YQmLBT6dvLtB28jormd
         GdvA==
X-Gm-Message-State: AOJu0YzdgP1POfdvRuE8lAoADJQykFQL7Q94nug22yZoH3F/pdUQz06a
	3wteMZK8qarJKMukXiFcBr4VvAuPu48Vtg==
X-Google-Smtp-Source: AGHT+IGkRx43IbE6erT6jpTixBSiBu9Z8tPzgRjElhhOR9pTbivGBzdwnwFs1MZ6B4vwrRVqGKzFZw==
X-Received: by 2002:a50:9b1a:0:b0:540:4c04:ab94 with SMTP id o26-20020a509b1a000000b005404c04ab94mr620640edi.42.1704904357603;
        Wed, 10 Jan 2024 08:32:37 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i12-20020a05640200cc00b005557a9395e1sm2136484edu.47.2024.01.10.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 08:32:36 -0800 (PST)
Date: Wed, 10 Jan 2024 17:32:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lin Ma <linma@zju.edu.cn>
Cc: quic_subashab@quicinc.com, quic_stranche@quicinc.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: qualcomm: rmnet: fix global oob in
 rmnet_policy
Message-ID: <ZZ7Go2Y2fURBU974@nanopsycho>
References: <20240110061400.3356108-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110061400.3356108-1-linma@zju.edu.cn>

Wed, Jan 10, 2024 at 07:14:00AM CET, linma@zju.edu.cn wrote:
>The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
>global out-of-bounds read when parsing the netlink attributes. See bug
>trace below:
>
>==================================================================
>BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
>BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207
>
>CPU: 0 PID: 84207 Comm: syz-executor.6 Tainted: G                 N 6.1.0 #3
>Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:284 [inline]
> print_report+0x172/0x475 mm/kasan/report.c:395
> kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
> validate_nla lib/nlattr.c:386 [inline]
> __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
> __nla_parse+0x3e/0x50 lib/nlattr.c:697
> nla_parse_nested_deprecated include/net/netlink.h:1248 [inline]
> __rtnl_newlink+0x50a/0x1880 net/core/rtnetlink.c:3485
> rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
> rtnetlink_rcv_msg+0x43c/0xd70 net/core/rtnetlink.c:6091
> netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
> netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
> netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
> netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
> sock_sendmsg_nosec net/socket.c:714 [inline]
> sock_sendmsg+0x154/0x190 net/socket.c:734
> ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
> ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
> __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>RIP: 0033:0x7fdcf2072359
>Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007fdcf13e3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>RAX: ffffffffffffffda RBX: 00007fdcf219ff80 RCX: 00007fdcf2072359
>RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
>RBP: 00007fdcf20bd493 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007fffbb8d7bdf R14: 00007fdcf13e3300 R15: 0000000000022000
> </TASK>
>
>The buggy address belongs to the variable:
> rmnet_policy+0x30/0xe0
>
>The buggy address belongs to the physical page:
>page:0000000065bdeb3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x155243
>flags: 0x200000000001000(reserved|node=0|zone=2)
>raw: 0200000000001000 ffffea00055490c8 ffffea00055490c8 0000000000000000
>raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>page dumped because: kasan: bad access detected
>
>Memory state around the buggy address:
> ffffffff92c43780: f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9 00 00 00 07
> ffffffff92c43800: f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9 06 f9 f9 f9
>>ffffffff92c43880: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
>                                                 ^
> ffffffff92c43900: 00 00 00 00 00 00 00 00 07 f9 f9 f9 f9 f9 f9 f9
> ffffffff92c43980: 00 00 00 07 f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9
>
>According to the comment of `nla_parse_nested_deprecated`, the maxtype
>should be len(destination array) - 1. Hence use `IFLA_RMNET_MAX` here.
>
>Fixes: 14452ca3b5ce ("net: qualcomm: rmnet: Export mux_id and flags to netlink")
>Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Btw, any idea why this rmnet thing, which clearly looks like a
softdevice, is in vendor directory where drivers for real devices should
reside?


