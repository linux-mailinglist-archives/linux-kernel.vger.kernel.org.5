Return-Path: <linux-kernel+bounces-29987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BCB831649
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5223E1F21598
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0C20339;
	Thu, 18 Jan 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZQWPCiL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C89200AC;
	Thu, 18 Jan 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571786; cv=none; b=sNAOAtGlKkl/BP+vMxrtnkxKJNpCDpb3qju82o92amsPu+jFL2PJ/NHxfn24U2S4KUlxOOSEYzF72S/M9rwpcA6zTBoVNh4WfE4pAUo/p+EPHx8M5L8+4NPhE3tICDuStClae/nudbN6WXG4EmHyYtiHE7/OCXF3ab9A1SdVLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571786; c=relaxed/simple;
	bh=hWuuTgxcPQhYy8iWEJv2hwI1bR5CzV0o5I3xGjHNOwY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pGgnE956J8c1Kyim1HO2/K1ZQWCuBSq8iMyANSHePqdy6O9B61G5Odo/60UMKHQxYwHHGXU2Igm0+5UwpMLFNERUPU4aL2yW1BsRLbhho0UBvoRUbM3I+VY/4+XFFty+QG8S3cIQaIrhNklABwUr/4DuqrJPE24LYI0bMWVbW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZQWPCiL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d4414ec9c7so62679915ad.0;
        Thu, 18 Jan 2024 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705571780; x=1706176580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qh+wH52rq1O19pUhbRYFfC3OyLYjJldAfdQgu6VbbCk=;
        b=CZQWPCiLmUlH1kW/Ru2Q+TW8z83dfsoCIoi/ynaC+1TCRQ3cBvBKodx/6RmlzD6r7i
         KKZEzfZMVJ7HrtvgbTPUmxwO5h+xWfqAISCeWt/LtwcJIEWMjiElgwzBYqPQVGbm1hLR
         ufIDdAs+HFS39yBacPWmaKR1pKqMCS4cwxWgh3GDu3wuSc0qNCROTmXcG6tZtSKyp5LY
         onoCwKrXORLaXuWwvhkz1vPIOQ+e6Vo/Ah8TOmshhMoxQmI8YQrkJkfLEuwRcMayYvZx
         EFZOsNw3o/hc0ubJ4ft5Mh5QGmq99uez74gnH7uKbrK9GCInNz/opzgDPRF/odL4tIWC
         rP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705571780; x=1706176580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qh+wH52rq1O19pUhbRYFfC3OyLYjJldAfdQgu6VbbCk=;
        b=kn7CV21voxiYWUuEYNPHbgqpw37sf4oo3KBQjPSHs9gk5ZQCePxVCiXxWStubpnuZT
         TDqpUI/Kn6++5uFiyGk3pk4pGpWFaR5LBl4ew/AzI74GeIiK4Y1XEjrkz2hBrg2WO0Lx
         5FXcrFOf7bUWweUjvUvomEP+Xx4TeDMilmm/EhSidHzrpQ/vaVyTwbkI1b3HvGQJn2qT
         Lw85sta96TD/bodLlBt4rbvoL0Z3H9TwLHjuZjoPwyZF5nJo7P4Vxs3f3fZf71WGvqug
         SUw9bTxXRNgpqKmirLjr8FPiI+T5iBsgt85DL9H0M9bzoD1EiPAOhMCHQmMoq2Ld7yEt
         M0wQ==
X-Gm-Message-State: AOJu0Yy3IMEuhP8JrOCo0s9xOuXythA99CWn20szo38Z32mSIrmK/Bxm
	PQHS6SkCUWVnb//Rcqee/bZenQft98jqb840g+FjGrHz1jdWwwUz
X-Google-Smtp-Source: AGHT+IFbi904Qass+6FarhLrEOyIWehebMlhY5de+XmF3+ZUUb1r0tC1oXRW+8vZJ2FmjTwkab+7ow==
X-Received: by 2002:a17:902:d4cf:b0:1d5:4b75:f2da with SMTP id o15-20020a170902d4cf00b001d54b75f2damr532208plg.108.1705571780257;
        Thu, 18 Jan 2024 01:56:20 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902c9cb00b001d70eb36dd9sm385185pld.279.2024.01.18.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:56:19 -0800 (PST)
Date: Thu, 18 Jan 2024 17:56:15 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down /
 mld_ifc_work
Message-ID: <Zaj1vyXpp_UvJIXX@Laptop-X1>
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117172102.12001-1-n.zhandarovich@fintech.ru>

On Wed, Jan 17, 2024 at 09:21:02AM -0800, Nikita Zhandarovich wrote:
> idev->mc_ifc_count can be written over without proper locking.
> 
> Originally found by syzbot [1], fix this issue by encapsulating calls
> to mld_ifc_stop_work() (and mld_gq_stop_work() for good measure) with
> mutex_lock() and mutex_unlock() accordingly as these functions
> should only be called with mc_lock per their declarations.
> 
> [1]
> BUG: KCSAN: data-race in ipv6_mc_down / mld_ifc_work
> 
> write to 0xffff88813a80c832 of 1 bytes by task 3771 on cpu 0:
>  mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
>  ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
>  addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
>  addrconf_notify+0x310/0x980
>  notifier_call_chain kernel/notifier.c:93 [inline]
>  raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
>  __dev_notify_flags+0x205/0x3d0
>  dev_change_flags+0xab/0xd0 net/core/dev.c:8685
>  do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
>  rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
>  rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
>  rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
>  netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
>  rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
>  ...
> 
> write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
>  mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
>  process_one_work kernel/workqueue.c:2627 [inline]
>  process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
>  worker_thread+0x525/0x730 kernel/workqueue.c:2781
>  ...
> 
> Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
> Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000994e09060ebcdffb@google.com/
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  net/ipv6/mcast.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
> index b75d3c9d41bb..bc6e0a0bad3c 100644
> --- a/net/ipv6/mcast.c
> +++ b/net/ipv6/mcast.c
> @@ -2722,8 +2722,12 @@ void ipv6_mc_down(struct inet6_dev *idev)
>  	synchronize_net();
>  	mld_query_stop_work(idev);
>  	mld_report_stop_work(idev);
> +
> +	mutex_lock(&idev->mc_lock);
>  	mld_ifc_stop_work(idev);
>  	mld_gq_stop_work(idev);
> +	mutex_unlock(&idev->mc_lock);
> +
>  	mld_dad_stop_work(idev);
>  }
>  

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

