Return-Path: <linux-kernel+bounces-29758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF5831300
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0D51C220E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949DB64A;
	Thu, 18 Jan 2024 07:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuOQr6xs"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879869474;
	Thu, 18 Jan 2024 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561870; cv=none; b=iYNTZ/TxXM3l2BH3KfUqqMPpd6HAvy/EFTfGlAAXFDiFQIluEWyiyPtElsJ92l2hx+VB2Fs5l/MMcvJrVAT6q7Y1Ltwaf5eqlzOh0U4L5hSvW3KtsfwUuTFYeR1s+DqtJmbbdnGp92zomKlgg4Ih3USZSL94d/qO6WZDr9qpICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561870; c=relaxed/simple;
	bh=4GR1mh0RFzue4bnwr80BJH4ggyCgmqRZA75pypWk7dE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Uidl43jZIFkN3Ew2ItAzyQ+UCOAmiFNWtqFoXMCS+MJ5t+jyawZnTtyQKzkb7fN98wWlgOkWph2n4Y44xB6SBOtlgRzHFDIfkfajKdvXgUelsGO/Yr2pt3XrfvIdzm0OUQwwstyvMDbPVYSdtA2DjvPYKbVYxfzruwa6Abuazs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuOQr6xs; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dddfdc3244so6481466a34.1;
        Wed, 17 Jan 2024 23:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705561867; x=1706166667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io2Redcmja/oBhQbbFCEsEr4isf6i2z+OM/8zAveYjw=;
        b=EuOQr6xs/G6DmqJBLSk15mCjLJBrLey6O7sIsevv/DCDUGoWtQh3DzTv1nJY2iiZ+L
         h2Hk03TOmRTwU5MABMOp19YQxEh42ajbhTngGZ5hLjcCfU9eC9LzV/XKEsn70YI1nofX
         uP9KPV0zntUEQvUl38uBVM+ohDocpUFutU85KU6Eybed1dJ3AaFBI5OBfEpSi3PEYjPF
         m+pREwEhIeq/M9Jg0ijZziePA/NBLIcMPhCBCKf7AdFpz2MjAi+/WwNYkDMVzdHeXZ5x
         yReC0RnYLOesrFbJAGwFKqPBGvA98xZC1I4FFS+E3sFA9oNPg6Oy4Ep4C2krYspf4Z8S
         Up3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705561867; x=1706166667;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io2Redcmja/oBhQbbFCEsEr4isf6i2z+OM/8zAveYjw=;
        b=d2STE8Hlfv8bSr5FMZ3oM9OzWURYO8RrExj4t/RU4DJh5nWK+O4vJMi35cdIPAQ3t+
         GyIFWSYF2EaC9zWDv0qef/8NdnzHJWwrxTjsf4DU/WKzxhZoAhGs5rUDXPcozxn7cb7i
         d3fVFA1HDkuklILyydbVwERrJvjTtXBb/wq5F67BEZj0KrzHCMPPzV08eRBLTGWO9Mu+
         9+1MYSIEaOsl1KtRD2fwfS8DlSxO+by9aBMaN+Sni26xGMfeIW2r6Uj4dsIMUf+WGWKK
         qR6INqRZL54wnvQDel5AheNwwpvzV9Trj8Y++kJ/aI1qmbPCq/pI/ECoghg2cAK1t+9r
         Hiew==
X-Gm-Message-State: AOJu0Yyh4kRrPb6zmD9k7uIoSQjA/LNV5wccuhlceO6Xfmq/rDexw5uy
	WKpOKYDiJys4N0DKzWdQdM6npPv6eK5y6PnxXCTkV7rMSt3dXr6Y
X-Google-Smtp-Source: AGHT+IH5HVEuUnGJNI631NMg9yM8fDTqQC18ubUWn8s5EsAex2vD1ZuVL3pfnlvDw9rNBW3o1M81GQ==
X-Received: by 2002:a9d:618b:0:b0:6dc:3f8b:1c61 with SMTP id g11-20020a9d618b000000b006dc3f8b1c61mr350450otk.39.1705561867469;
        Wed, 17 Jan 2024 23:11:07 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id f11-20020a63f74b000000b005cd821a01d4sm819499pgk.28.2024.01.17.23.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 23:11:06 -0800 (PST)
Message-ID: <a7ab4f42-c7a3-1cf8-9aa6-da5d4a9ff3a1@gmail.com>
Date: Thu, 18 Jan 2024 16:11:03 +0900
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
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/18/24 02:21, Nikita Zhandarovich wrote:

Hi Nikita,
Thanks a lot for this work!

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
 > mld_ifc_stop_work net/ipv6/mcast.c:1080 [inline]
 > ipv6_mc_down+0x10a/0x280 net/ipv6/mcast.c:2725
 > addrconf_ifdown+0xe32/0xf10 net/ipv6/addrconf.c:3949
 > addrconf_notify+0x310/0x980
 > notifier_call_chain kernel/notifier.c:93 [inline]
 > raw_notifier_call_chain+0x6b/0x1c0 kernel/notifier.c:461
 > __dev_notify_flags+0x205/0x3d0
 > dev_change_flags+0xab/0xd0 net/core/dev.c:8685
 > do_setlink+0x9f6/0x2430 net/core/rtnetlink.c:2916
 > rtnl_group_changelink net/core/rtnetlink.c:3458 [inline]
 > __rtnl_newlink net/core/rtnetlink.c:3717 [inline]
 > rtnl_newlink+0xbb3/0x1670 net/core/rtnetlink.c:3754
 > rtnetlink_rcv_msg+0x807/0x8c0 net/core/rtnetlink.c:6558
 > netlink_rcv_skb+0x126/0x220 net/netlink/af_netlink.c:2545
 > rtnetlink_rcv+0x1c/0x20 net/core/rtnetlink.c:6576
 > netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 > netlink_unicast+0x589/0x650 net/netlink/af_netlink.c:1368
 > netlink_sendmsg+0x66e/0x770 net/netlink/af_netlink.c:1910
 > ...
 >
 > write to 0xffff88813a80c832 of 1 bytes by task 22 on cpu 1:
 > mld_ifc_work+0x54c/0x7b0 net/ipv6/mcast.c:2653
 > process_one_work kernel/workqueue.c:2627 [inline]
 > process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2700
 > worker_thread+0x525/0x730 kernel/workqueue.c:2781
 > ...
 >
 > Fixes: 2d9a93b4902b ("mld: convert from timer to delayed work")
 > Reported-by: syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
 > Link: 
https://lore.kernel.org/all/000000000000994e09060ebcdffb@google.com/
 > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
 > ---
 > net/ipv6/mcast.c | 4 ++++
 > 1 file changed, 4 insertions(+)
 >
 > diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
 > index b75d3c9d41bb..bc6e0a0bad3c 100644
 > --- a/net/ipv6/mcast.c
 > +++ b/net/ipv6/mcast.c
 > @@ -2722,8 +2722,12 @@ void ipv6_mc_down(struct inet6_dev *idev)
 > synchronize_net();
 > mld_query_stop_work(idev);
 > mld_report_stop_work(idev);
 > +
 > + mutex_lock(&idev->mc_lock);
 > mld_ifc_stop_work(idev);
 > mld_gq_stop_work(idev);
 > + mutex_unlock(&idev->mc_lock);
 > +
 > mld_dad_stop_work(idev);
 > }
 >

Acked-by: Taehee Yoo <ap420073@gmail.com>

