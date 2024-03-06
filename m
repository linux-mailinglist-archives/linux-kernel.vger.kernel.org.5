Return-Path: <linux-kernel+bounces-94593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028078741DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E21C21147
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107591B279;
	Wed,  6 Mar 2024 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="UdjRCyV+"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C019BA2;
	Wed,  6 Mar 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759982; cv=none; b=ktMEc7Pc3oDcTXalmkj6drCPFYH4SKzi9QjrrbRYNb9UpY27tVIeCpsRSzlIPGix3qN7KaWZRDHY/gjX3woE468gzCCDuTo7QEcVU8EfgywLQIB6XGmB9S6TXNX2ADnUo7LPWsgjK0DTPL7bJ8BQebWtxB9YTu4W9CcrxCbzhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759982; c=relaxed/simple;
	bh=XZQmCtyVfRqev09CE7yeyhuO5QpGTnUaZskxIdlyd0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3SPax5Nsqf4KkB6lZWksAx0Jyg18+GQwLeHZCeqz6kpbl4wfKTWeWqxzbkYVnwAfe358QJJNJayIZf4oeBbrvbUeQEorQW5d8sRxjfxyqOYN/sOA7Cp2ygY05Q3uxsc1pfr79FMhXh/bz3373MvPZvJq6WTJexVwm1xEY0T+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=UdjRCyV+; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090] (unknown [IPv6:2a00:20:700b:bdb7:2491:aaf9:faf7:2090])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 1B824C08B2;
	Wed,  6 Mar 2024 22:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1709759975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XgPterOI4srsOuxgVWf4AkdxIIFepNm6IWYUB1ZuXk=;
	b=UdjRCyV+UpxEX6d6xveotqenYSV7y10dJYB5MjF2wPLq2JotONFysOutVFByPd/ugmiSm5
	M1zfT60WQlmyTGUgg2pUMHtLeY6PPkKiwyysYeadsjJ1uWQKzD1CXVEcXFF0ziqnbkeLoa
	oEcI6Qr+FuKaaVNYpK1OCgpJ4lgerl72iEUZTraFWjai9cCB5J14R1BmDMwsLBKy3lVAeU
	GfPF9oABEVeQwX/Cl9n6IRaQl3FvhUxMImFxmd0ZnNXNA9zgOLAiDO7xNFJ2cn5Vj2IEh7
	7Wh2mSE+24yZ7/PKW1ztu2K2/U7CAtd3umZ/lC8Z3d15yjTyc2Qx5LRHmyYbRw==
Message-ID: <4c716d9f-fe03-44f7-8cc7-211a64aae94c@datenfreihafen.org>
Date: Wed, 6 Mar 2024 22:19:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wpan] mac802154: fix llsec key resources release in
 mac802154_llsec_key_del
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Alexander Aring <alex.aring@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20240228163840.6667-1-pchelkin@ispras.ru>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20240228163840.6667-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

On 28.02.24 17:38, Fedor Pchelkin wrote:
> mac802154_llsec_key_del() can free resources of a key directly without
> following the RCU rules for waiting before the end of a grace period. This
> may lead to use-after-free in case llsec_lookup_key() is traversing the
> list of keys in parallel with a key deletion:
> 
> refcount_t: addition on 0; use-after-free.
> WARNING: CPU: 4 PID: 16000 at lib/refcount.c:25 refcount_warn_saturate+0x162/0x2a0
> Modules linked in:
> CPU: 4 PID: 16000 Comm: wpan-ping Not tainted 6.7.0 #19
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:refcount_warn_saturate+0x162/0x2a0
> Call Trace:
>   <TASK>
>   llsec_lookup_key.isra.0+0x890/0x9e0
>   mac802154_llsec_encrypt+0x30c/0x9c0
>   ieee802154_subif_start_xmit+0x24/0x1e0
>   dev_hard_start_xmit+0x13e/0x690
>   sch_direct_xmit+0x2ae/0xbc0
>   __dev_queue_xmit+0x11dd/0x3c20
>   dgram_sendmsg+0x90b/0xd60
>   __sys_sendto+0x466/0x4c0
>   __x64_sys_sendto+0xe0/0x1c0
>   do_syscall_64+0x45/0xf0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Also, ieee802154_llsec_key_entry structures are not freed by
> mac802154_llsec_key_del():
> 
> unreferenced object 0xffff8880613b6980 (size 64):
>    comm "iwpan", pid 2176, jiffies 4294761134 (age 60.475s)
>    hex dump (first 32 bytes):
>      78 0d 8f 18 80 88 ff ff 22 01 00 00 00 00 ad de  x.......".......
>      00 00 00 00 00 00 00 00 03 00 cd ab 00 00 00 00  ................
>    backtrace:
>      [<ffffffff81dcfa62>] __kmem_cache_alloc_node+0x1e2/0x2d0
>      [<ffffffff81c43865>] kmalloc_trace+0x25/0xc0
>      [<ffffffff88968b09>] mac802154_llsec_key_add+0xac9/0xcf0
>      [<ffffffff8896e41a>] ieee802154_add_llsec_key+0x5a/0x80
>      [<ffffffff8892adc6>] nl802154_add_llsec_key+0x426/0x5b0
>      [<ffffffff86ff293e>] genl_family_rcv_msg_doit+0x1fe/0x2f0
>      [<ffffffff86ff46d1>] genl_rcv_msg+0x531/0x7d0
>      [<ffffffff86fee7a9>] netlink_rcv_skb+0x169/0x440
>      [<ffffffff86ff1d88>] genl_rcv+0x28/0x40
>      [<ffffffff86fec15c>] netlink_unicast+0x53c/0x820
>      [<ffffffff86fecd8b>] netlink_sendmsg+0x93b/0xe60
>      [<ffffffff86b91b35>] ____sys_sendmsg+0xac5/0xca0
>      [<ffffffff86b9c3dd>] ___sys_sendmsg+0x11d/0x1c0
>      [<ffffffff86b9c65a>] __sys_sendmsg+0xfa/0x1d0
>      [<ffffffff88eadbf5>] do_syscall_64+0x45/0xf0
>      [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Handle the proper resource release in the RCU callback function
> mac802154_llsec_key_del_rcu().
> 
> Note that if llsec_lookup_key() finds a key, it gets a refcount via
> llsec_key_get() and locally copies key id from key_entry (which is a
> list element). So it's safe to call llsec_key_put() and free the list
> entry after the RCU grace period elapses.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 5d637d5aabd8 ("mac802154: add llsec structures and mutators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

