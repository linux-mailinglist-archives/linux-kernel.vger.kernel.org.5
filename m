Return-Path: <linux-kernel+bounces-23164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0D782A885
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894AE1F24577
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5812D2E4;
	Thu, 11 Jan 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="o6y5vr/b"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF085D28F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28fb463a28so510478266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704959177; x=1705563977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYbpIMGUwlGnlPHUOhhrSb64lJnYqN7/wW5haQuNtnY=;
        b=o6y5vr/b2ZLN9jbG+HvWEhIWIqxF8Vx7IzjVFFuWj6WdYspRSeA6JxtXpXnm0rya4Y
         p4ICdYQ2u0zqWwE9cUXgt4QSJwxIEQ0EjvrVWEaoIGwtKF9XtfuSBoNPQOvvD4lz4FNF
         QLnaC/SAYeR0b6CfYknIeUXDnyLEYQd4PG+Am9YEivKTCSF+LtapMMT78Sdrs2nHhhLa
         /9zcX85sxesNzxjSgGj7jNP7KlV37Pa86Ib2gexZ4RfPQwidEIIaSEDfrv6PnG5l2hik
         lng9hwEGLiRYOmKBQ5j+Mm2uBhBfuKO/LO2v0sGVV7+FSzro0K4+MsUbroRgZNjl3GD4
         N+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704959177; x=1705563977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYbpIMGUwlGnlPHUOhhrSb64lJnYqN7/wW5haQuNtnY=;
        b=HwaC685hd1LjCr+K2PxKdylaPv2BZrDy7f6nOQUkpiCoVa5b/qaLvIsyrHYb8TXEg5
         HyyQCJ0MEx6Fz9bSYb5Jwt0vRMW7gUAnkQuO3U+VY4i4jU/nmGq7BSXCcq2p4xapYsVX
         1X62VoEdx03Oz8vCmTBcp7n0ztsso5gTxfmGEvf9o5rzWgDsWNeQg4uNibEEYdRinWR2
         ayNaTMA0iLKzwbDij6aaENbTzFw+aqvBkWKfztM/OZFLkUcKWryGj5eeZoepdUCM8WLz
         o1FMwVpAq2BEThfeQZPmObhUzd5FWkRZ1N4a1uXmKy7oB8RjXC+lyMCOpSbz6RYzacmI
         6rRA==
X-Gm-Message-State: AOJu0YyWuodCOmBH0kcoFwBBBVxy4TpY/JSvTkAS4qBL3zQczcgOlUoH
	fqwJ9D1eyHSjYD3DhbqMBk9LIFl+3Tvq0w==
X-Google-Smtp-Source: AGHT+IH5I1l4L5Pm3826Zk1WGIQRq6X4Pgko4wwCvmtj9yPHS/JaEjcMU88dDCmhhDAnfZ/7AjVy2A==
X-Received: by 2002:a17:906:eecb:b0:a2c:2258:6605 with SMTP id wu11-20020a170906eecb00b00a2c22586605mr465259ejb.29.1704959176624;
        Wed, 10 Jan 2024 23:46:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id qc21-20020a170906d8b500b00a26ac5e3683sm255796ejb.100.2024.01.10.23.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:46:15 -0800 (PST)
Date: Thu, 11 Jan 2024 08:46:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: Lin Ma <linma@zju.edu.cn>, quic_stranche@quicinc.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: qualcomm: rmnet: fix global oob in
 rmnet_policy
Message-ID: <ZZ-cxifaGHx0uGO9@nanopsycho>
References: <20240110061400.3356108-1-linma@zju.edu.cn>
 <ZZ7Go2Y2fURBU974@nanopsycho>
 <b9aa0fbd-f7af-459e-b1b3-4f51029317c3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9aa0fbd-f7af-459e-b1b3-4f51029317c3@quicinc.com>

Wed, Jan 10, 2024 at 07:16:38PM CET, quic_subashab@quicinc.com wrote:
>On 1/10/2024 9:32 AM, Jiri Pirko wrote:
>> Wed, Jan 10, 2024 at 07:14:00AM CET, linma@zju.edu.cn wrote:
>> > The variable rmnet_link_ops assign a *bigger* maxtype which leads to a
>> > global out-of-bounds read when parsing the netlink attributes. See bug
>> > trace below:
>> > 
>> > ==================================================================
>> > BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
>> > BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>> > Read of size 1 at addr ffffffff92c438d0 by task syz-executor.6/84207
>> > 
>> > CPU: 0 PID: 84207 Comm: syz-executor.6 Tainted: G                 N 6.1.0 #3
>> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>> > Call Trace:
>> > <TASK>
>> > __dump_stack lib/dump_stack.c:88 [inline]
>> > dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
>> > print_address_description mm/kasan/report.c:284 [inline]
>> > print_report+0x172/0x475 mm/kasan/report.c:395
>> > kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
>> > validate_nla lib/nlattr.c:386 [inline]
>> > __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>> > __nla_parse+0x3e/0x50 lib/nlattr.c:697
>> > nla_parse_nested_deprecated include/net/netlink.h:1248 [inline]
>> > __rtnl_newlink+0x50a/0x1880 net/core/rtnetlink.c:3485
>> > rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
>> > rtnetlink_rcv_msg+0x43c/0xd70 net/core/rtnetlink.c:6091
>> > netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
>> > netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>> > netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
>> > netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
>> > sock_sendmsg_nosec net/socket.c:714 [inline]
>> > sock_sendmsg+0x154/0x190 net/socket.c:734
>> > ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
>> > ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>> > __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> > do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>> > entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> > RIP: 0033:0x7fdcf2072359
>> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>> > RSP: 002b:00007fdcf13e3168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>> > RAX: ffffffffffffffda RBX: 00007fdcf219ff80 RCX: 00007fdcf2072359
>> > RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000000000003
>> > RBP: 00007fdcf20bd493 R08: 0000000000000000 R09: 0000000000000000
>> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>> > R13: 00007fffbb8d7bdf R14: 00007fdcf13e3300 R15: 0000000000022000
>> > </TASK>
>> > 
>> > The buggy address belongs to the variable:
>> > rmnet_policy+0x30/0xe0
>> > 
>> > The buggy address belongs to the physical page:
>> > page:0000000065bdeb3c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x155243
>> > flags: 0x200000000001000(reserved|node=0|zone=2)
>> > raw: 0200000000001000 ffffea00055490c8 ffffea00055490c8 0000000000000000
>> > raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
>> > page dumped because: kasan: bad access detected
>> > 
>> > Memory state around the buggy address:
>> > ffffffff92c43780: f9 f9 f9 f9 00 00 00 02 f9 f9 f9 f9 00 00 00 07
>> > ffffffff92c43800: f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9 06 f9 f9 f9
>> > > ffffffff92c43880: f9 f9 f9 f9 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
>> >                                                  ^
>> > ffffffff92c43900: 00 00 00 00 00 00 00 00 07 f9 f9 f9 f9 f9 f9 f9
>> > ffffffff92c43980: 00 00 00 07 f9 f9 f9 f9 00 00 00 05 f9 f9 f9 f9
>> > 
>> > According to the comment of `nla_parse_nested_deprecated`, the maxtype
>> > should be len(destination array) - 1. Hence use `IFLA_RMNET_MAX` here.
>> > 
>> > Fixes: 14452ca3b5ce ("net: qualcomm: rmnet: Export mux_id and flags to netlink")
>> > Signed-off-by: Lin Ma <linma@zju.edu.cn>
>> 
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> 
>> Btw, any idea why this rmnet thing, which clearly looks like a
>> softdevice, is in vendor directory where drivers for real devices should
>> reside?
>> 
>
>I believe we had discussed this during the initial implementation patch
>series and concluded to move the code to drivers. Link for reference -
>
>https://lkml.kernel.org/netdev/217d998fd9d869f0e5ded0d1add3f550@codeaurora.org/

Okay, I forgot of course. Still, this is quite odd beast :/

