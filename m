Return-Path: <linux-kernel+bounces-29667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D183117D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75F2286291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD806104;
	Thu, 18 Jan 2024 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPhbhmBk"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4C5395;
	Thu, 18 Jan 2024 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545916; cv=none; b=AK8cPJ19dSB9kEu9/mYl+KJ5RePEv2DNLbhyLjiZtUkjNiK+BDN8p3q/tyQ6vMLguPWkYuiEvv9Y45V91F8v3Rq2fPZhBfxCBE09f8unQ61e5grdyOOGdhJJ5JdQNAxTS3ABR+V258mFYrlm7671bWWA8Bw9/jP7rgoR2MwtPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545916; c=relaxed/simple;
	bh=HQvFAPJRf2J5GkozGHLateTg7jJKgrg4DLcVjXxGFOI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BpyP6ZqGpdU/fVby89Bj+xovh0moFapy8Ert7bAk2WD4+gSN/JZE9vIBuG+zrFmfwfnO5j1qylu0oAII8HHjeYFSj0TtEJ/To+Bm2L9Afr/H4asB5B7DGtBOnAx1Ia97zyayyiPmIpvedtT/r30xD6aQRAOK5gIsrEain7LV7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPhbhmBk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so4570147a12.1;
        Wed, 17 Jan 2024 18:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705545914; x=1706150714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yUIrD3c+Qm4qwrdDSHm5IZk2SaKgPsurwWj69dMasY=;
        b=TPhbhmBkCu0PX68EDquIao3Bl+6K3FD/N3pSchEzfY0Yga9hdzAySO1oYV/xE/+Rey
         mIZL8Ou/9kJZ7VX+9ailrkE5pffbnEEvxwZnk0/8L7p7iSc6t9n515MoaRqXNNkrqccN
         +OCvsUy7L6dHgt+RL3AX3zhlxJCfpC6Fsfla98U7d6zpf9LdoaOZPHKb4djB+hW6y4jJ
         Mso1t1Vkx/OOvpU0BH6knildx2AdYwxKlJFd93dusfm9kX0mvTs2WjmpVXhuD94F+6nk
         11e1kAoBZEoAeJd0pdJTaetyeXfDHW5I4NC9rzDe6ph7qa+wG3Bm+vfYpE7yEM6AIjAJ
         8TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705545914; x=1706150714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yUIrD3c+Qm4qwrdDSHm5IZk2SaKgPsurwWj69dMasY=;
        b=vusnxx3BJVV0+75FHXEdnIw53jiLHE2vMo92jaKzJtk+eEbRSINCdqR77yglVKOJ/U
         rSR/9Ntw4PXZ0Rg5cnD+5fXpgYKaAapLXmRTRaE6g9XodTj0fkR2B+F5jColhtOnUlV1
         +7/sBkvfIdYvHUCaP6rDO+O/LkyNzTPF45OzJHAK40iZe9xNPBAsHkL+8Am49FMoX16B
         9KAdplI6hqzn1cMFa6MaTUOUvvpKRuYDef4BaPJ71bkF08433ZfoGnD3CX0oF5P99YlO
         w4BTtP3AjW8i4r8F+7U4KMAh+/RskzV0VgnsLqGvBvpwHg4Ry6FRf640Brf15vDqKRBS
         8JUw==
X-Gm-Message-State: AOJu0YzJPpLh+zX/eJdqIfPsuA82k4wlCewpIBlkIvE0xQkq98mXDz1t
	It/zcT04Ehvbfme77nblKQTrZkEV7anlxiVnRXSaWBtXNRhuOuxY
X-Google-Smtp-Source: AGHT+IFlYN1Cvo4UoXhKIYlQ6sad+gJnzhI+R/1bdcxn8TcQpb0YIIt3gf5Ryo0si14bBeN+TrQYtg==
X-Received: by 2002:a17:90a:ea04:b0:28f:fac1:b76b with SMTP id w4-20020a17090aea0400b0028ffac1b76bmr165660pjy.59.1705545914363;
        Wed, 17 Jan 2024 18:45:14 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id si6-20020a17090b528600b0028df5c748e4sm423268pjb.44.2024.01.17.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:45:12 -0800 (PST)
Date: Thu, 18 Jan 2024 10:45:07 +0800
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
Message-ID: <ZaiQs6yTY7XuS06i@Laptop-X1>
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

I saw mld_process_v1() also cancel these works when changing to v1 mode.
Should we also add lock there?

Thanks
Hangbin

