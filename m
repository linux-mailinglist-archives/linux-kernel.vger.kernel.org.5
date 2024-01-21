Return-Path: <linux-kernel+bounces-31985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5908354E3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 09:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2DCD1C21CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92F364B4;
	Sun, 21 Jan 2024 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0Ta7e23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5323CB;
	Sun, 21 Jan 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705825451; cv=none; b=bu53XHBxuokgoTgS2jSD+7t+hPGt0O4hTzU96iEGL6QRusJD466FuDijpl/BAnf5KEAIYWbqxZ/aQHGih3aH8esEkHUqcrLdu/5S0Fyp6TQ6K1EEBsrjnjSwVsCAcjrbioqiQ3/rDJveNgs5NBVEZPq464SK8Vch4bfz+FKZ6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705825451; c=relaxed/simple;
	bh=FdIhIS5yNRFFwUoChCMSWfqfBXqgKEoQoWvUe+oF8QY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7eT9NhKjng8z/FYaE3Xna0t1YLW64qqSi9+rBVO2JqVJp/Z4cWhsnypF7VswBdlvEiXs3gMyTaiB4TzeHz+Ff7aDH6/x8aMwY6dorDzFn0rzwSW06T8/0vu3bZcylt5fUVbTOYaWHEmdrzkkv8tjmfjGfmVR555cH89X3FXGP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0Ta7e23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D779C433C7;
	Sun, 21 Jan 2024 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705825451;
	bh=FdIhIS5yNRFFwUoChCMSWfqfBXqgKEoQoWvUe+oF8QY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=W0Ta7e23uiYj/PydiP0Hir+jn3xXY7B+hFQE2JWYlSQR9s5lpdB3LSt5eQvu3DLKX
	 GYm4QP2TPSOhaFZMOKieVjIdHs4XxEVu1aaffaYndxdVVqcXmAS1Wm/FJBEfIIhDHG
	 z9+OXhDecJA6sBYB4qwuYeK3qFQS7YzFBbuIqSuHjW2hVc5MRsn/0XcMAedu+XRm6q
	 mCVCKcfE/kN3yYX8pMXT754B8cysQFm65VG1142q++L96H/36/W6n+0lJo4cigY5p0
	 Wuez2gdHXzCu0I9m2hUVd4f9b+KJyRIFu1QzFVRPuxgFtEzFI+07nnITklzOrZDqsS
	 QuuH77BBw9GBg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-599698a72c2so734630eaf.0;
        Sun, 21 Jan 2024 00:24:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yz8J68J32hqaWWMFVz0G7jLo4ngZLFkS36EfAa0KJP9oUQ9tzGl
	CQud9axPgstnXBqNXWu/AsHTVsnzMcSml0REfDkwnWbsuhsbeXzT/M62i6lRY8u56Ae1ozZ4qDY
	gSubD2ahjHlMr6bhnmf+syw35OKU=
X-Google-Smtp-Source: AGHT+IHFUtwIt6yhXuXL1IODHJ9ojSDCmUBSKUH6K5FxAniIpc07AX363ca8pmfBNsRWnoeqxNxd/ALqt0wj70v/iCU=
X-Received: by 2002:a05:6870:391f:b0:210:919a:7d3f with SMTP id
 b31-20020a056870391f00b00210919a7d3fmr1042066oap.33.1705825450366; Sun, 21
 Jan 2024 00:24:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8d:0:b0:513:8ad5:8346 with HTTP; Sun, 21 Jan 2024
 00:24:09 -0800 (PST)
In-Reply-To: <20240121073506.84528-1-linma@zju.edu.cn>
References: <20240121073506.84528-1-linma@zju.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 21 Jan 2024 17:24:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_3B9pTZuXSJyEpgqwvpQ1k=v9VzPNX1BtoTNZMeU8WPQ@mail.gmail.com>
Message-ID: <CAKYAXd_3B9pTZuXSJyEpgqwvpQ1k=v9VzPNX1BtoTNZMeU8WPQ@mail.gmail.com>
Subject: Re: [PATCH v1] ksmbd: fix global oob in ksmbd_nl_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com, 
	lsahlber@redhat.com, hyc.lee@gmail.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-21 16:35 GMT+09:00, Lin Ma <linma@zju.edu.cn>:
> Similar to a reported issue (check the commit b33fb5b801c6 ("net:
> qualcomm: rmnet: fix global oob in rmnet_policy"), my local fuzzer finds
> another global out-of-bounds read for policy ksmbd_nl_policy. See bug
> trace below:
>
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:386 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x24af/0x2750
> lib/nlattr.c:600
> Read of size 1 at addr ffffffff8f24b100 by task syz-executor.1/62810
>
> CPU: 0 PID: 62810 Comm: syz-executor.1 Tainted: G                 N 6.1.0
> #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x8b/0xb3 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:284 [inline]
>  print_report+0x172/0x475 mm/kasan/report.c:395
>  kasan_report+0xbb/0x1c0 mm/kasan/report.c:495
>  validate_nla lib/nlattr.c:386 [inline]
>  __nla_validate_parse+0x24af/0x2750 lib/nlattr.c:600
>  __nla_parse+0x3e/0x50 lib/nlattr.c:697
>  __nlmsg_parse include/net/netlink.h:748 [inline]
>  genl_family_rcv_msg_attrs_parse.constprop.0+0x1b0/0x290
> net/netlink/genetlink.c:565
>  genl_family_rcv_msg_doit+0xda/0x330 net/netlink/genetlink.c:734
>  genl_family_rcv_msg net/netlink/genetlink.c:833 [inline]
>  genl_rcv_msg+0x441/0x780 net/netlink/genetlink.c:850
>  netlink_rcv_skb+0x14f/0x410 net/netlink/af_netlink.c:2540
>  genl_rcv+0x24/0x40 net/netlink/genetlink.c:861
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x54e/0x800 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x930/0xe50 net/netlink/af_netlink.c:1921
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  sock_sendmsg+0x154/0x190 net/socket.c:734
>  ____sys_sendmsg+0x6df/0x840 net/socket.c:2482
>  ___sys_sendmsg+0x110/0x1b0 net/socket.c:2536
>  __sys_sendmsg+0xf3/0x1c0 net/socket.c:2565
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3b/0x90 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fdd66a8f359
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fdd65e00168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fdd66bbcf80 RCX: 00007fdd66a8f359
> RDX: 0000000000000000 RSI: 0000000020000500 RDI: 0000000000000003
> RBP: 00007fdd66ada493 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffc84b81aff R14: 00007fdd65e00300 R15: 0000000000022000
>  </TASK>
>
> The buggy address belongs to the variable:
>  ksmbd_nl_policy+0x100/0xa80
>
> The buggy address belongs to the physical page:
> page:0000000034f47940 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x1ccc4b
> flags: 0x200000000001000(reserved|node=0|zone=2)
> raw: 0200000000001000 ffffea00073312c8 ffffea00073312c8 0000000000000000
> raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffffffff8f24b000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffff8f24b080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>ffffffff8f24b100: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 07 f9
>                    ^
>  ffffffff8f24b180: f9 f9 f9 f9 00 05 f9 f9 f9 f9 f9 f9 00 00 00 05
>  ffffffff8f24b200: f9 f9 f9 f9 00 00 03 f9 f9 f9 f9 f9 00 00 04 f9
> ==================================================================
>
> To fix it, add a placeholder named __KSMBD_EVENT_MAX and let
> KSMBD_EVENT_MAX to be its original value - 1 according to what other
> netlink families do. Also change two sites that refer the
> KSMBD_EVENT_MAX to correct value.
>
> Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and
> tranport layers")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ksmbd-for-next-next, Thanks for your patch!

