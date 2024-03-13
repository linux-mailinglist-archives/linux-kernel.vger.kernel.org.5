Return-Path: <linux-kernel+bounces-101239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715AD87A476
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FB1C21C10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2A1B95C;
	Wed, 13 Mar 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFmXy3xN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124A1B5BB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320494; cv=none; b=nZTcvNUFiu+fo9GT9E0O4B5ohQsEgdzM3ZmJ2KQG8ConavMldrdczxiUNhr/KPYEvIXJShKCQwYMlwI4yAtDUVohZb6ILCcIlE4VBsMs7T9Yaboy4MjKn8gXzvztThHB+Q6YPCYck427tWoYV8xxcxdzV/8XKR23T8NIBLJ/oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320494; c=relaxed/simple;
	bh=5v3FYfVQx+cCZ/Md4FwQZ8k3ZZiH8D99lUCHYFV3Rw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kzq0dVyFWNQeOxybvOH8KGkefWkNS9aBdMKY0IoC5WLAbICL+O+v3/fZsf6kejM7jpreNbPSUISAZPqTjmp3BPBP0x92I2tTPYxggRkyZIH1cVm4K0YdTwy/L1VlfdGyny+f4lr+lWiL35lXkMKig0Mc95+lrCnNxw+bgNSMMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YFmXy3xN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e9623c3a8so624110f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710320490; x=1710925290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkXgVRwCx/PSROc9qPxXKioJynkBEzO91K77Pe9LiRs=;
        b=YFmXy3xNxXrCSjEXCQ55lh2ZBQDj3yBfNdO2XzpWc5Vzp5Ur02G7Rl2wBWaLg9Z2Pi
         w0qrGEHjljfkt/5M3Ejyb2TK0n+rQPxlVmtRFwAj+SsCGAtgVFbPokRIuA7n0zIIKAr7
         jKIQRMqH6mRwzQRzWuA8wpmfZ/iBd3lKJb/006Ol0H+TPgbH9mKkrhwfGff46lt0ljgS
         ul1xDf8uQuQrwEsXQ7eZ1sNjgsik3A0YgWvbFTtBGJeCEvtJWfSZkgL3kmDMXMmbpHvI
         8E+AuAAjZm+BZ7kfCaQUEjk5DguDV8Vmwf3QmsSycP/Abkf+667dir2SVLygqAQYvU7l
         Chtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320490; x=1710925290;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkXgVRwCx/PSROc9qPxXKioJynkBEzO91K77Pe9LiRs=;
        b=uXcK7bBnFDz9mJoBwaKhbBq0LwEvlY07djM0M1um7BIv1UVm6iIx0xDX3wn/qt7nDx
         FlfaObBWfa+iy5yCAi+KKAOXLl4oXsG5GAegH5NLibNQFTLycV2KAcD39DKBBrPaRveu
         UzI7SRzsd+Aubn8v03IuFZpIPqOYfpF11qIJj77LxQ6YOuBaUibNtd7XXjKnyhmZR2vP
         bDYINUfZnsHDmDTzZ/8HJ3/qpvmr99smS7ZLrLNjzYCnTdzYaaGMCHqupaYRKIi7iQqc
         5x5LaOG5BS5N7I1gHU4D0ISRSel85rzWMcjfVZA1hfmlUfYSzZGC3nESc5iD4cdqMNHU
         zxCg==
X-Forwarded-Encrypted: i=1; AJvYcCXsWxoW5Xqn4tBVVxaV/Lk42388hq1bWks8D/xbakIjzbeXEKu+qBGUd7wSTPmuXR9CcgD/zjvTHy2upLYPMgVlkG8VGcY0XTBi/y1A
X-Gm-Message-State: AOJu0Yw4LKdZkUYMQd5wVfQl/lgikIRyFyjGRe3ScYlk67mHhD5llsBh
	yqTCH0sCmIVF7PFmoQjZUHjwWWf2birTgyM+3lmj8DnJCdvhzp2QC4TLDnMRj+0=
X-Google-Smtp-Source: AGHT+IHHgJSXe65TRHwqQUQmKgeOeWvFDxb4TjWkWvEbkYbg9nYd6YKo7i9XWsmgKwcoFwuPe7WdJw==
X-Received: by 2002:a5d:574d:0:b0:33e:1e0:2679 with SMTP id q13-20020a5d574d000000b0033e01e02679mr1466098wrw.47.1710320490373;
        Wed, 13 Mar 2024 02:01:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id x17-20020adfdd91000000b0033e03d37685sm11040000wrl.55.2024.03.13.02.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 02:01:29 -0700 (PDT)
Message-ID: <413249a5-13b0-4a06-9819-650eb4e82b37@linaro.org>
Date: Wed, 13 Mar 2024 10:01:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
Content-Language: en-US
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syoshida@redhat.com, syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
References: <20240312145658.417288-1-ryasuoka@redhat.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240312145658.417288-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/03/2024 15:56, Ryosuke Yasuoka wrote:
> syzbot reported the following unitit-value access issue [1]:

If there is going to be any new version then: typo, uninit-value
> 
> nci_ntf_packet() calls each ntf operation parsed from skb->data. When
> the payload length is zero, each operation handler reads uninitialized
> payload and KMSAN detects this issue. Such notification packet should be
> silently discarded since it is unexpected for any notification handlers.
> 
> This patch resolved this issue by checking payload size before calling
> each notification handler codes.
> 
> BUG: KMSAN: uninit-value in nci_init_req net/nfc/nci/core.c:177 [inline]
> BUG: KMSAN: uninit-value in __nci_request net/nfc/nci/core.c:108 [inline]
> BUG: KMSAN: uninit-value in nci_open_device net/nfc/nci/core.c:521 [inline]
> BUG: KMSAN: uninit-value in nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
>  nci_init_req net/nfc/nci/core.c:177 [inline]
>  __nci_request net/nfc/nci/core.c:108 [inline]
>  nci_open_device net/nfc/nci/core.c:521 [inline]
>  nci_dev_up+0xfec/0x1b10 net/nfc/nci/core.c:632
>  nfc_dev_up+0x26e/0x440 net/nfc/core.c:118
>  nfc_genl_dev_up+0xfe/0x1d0 net/nfc/netlink.c:770
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>  genl_rcv_msg+0x11ec/0x1290 net/netlink/genetlink.c:1067
>  netlink_rcv_skb+0x371/0x650 net/netlink/af_netlink.c:2545
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1076
>  netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
>  netlink_unicast+0xf47/0x1250 net/netlink/af_netlink.c:1368
>  netlink_sendmsg+0x1238/0x13d0 net/netlink/af_netlink.c:1910
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
>  __sys_sendmsg net/socket.c:2667 [inline]
>  __do_sys_sendmsg net/socket.c:2676 [inline]
>  __se_sys_sendmsg net/socket.c:2674 [inline]
>  __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was stored to memory at:
>  nci_core_reset_ntf_packet net/nfc/nci/ntf.c:36 [inline]
>  nci_ntf_packet+0x19dc/0x39c0 net/nfc/nci/ntf.c:782
>  nci_rx_work+0x213/0x500 net/nfc/nci/core.c:1522
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2706
>  worker_thread+0xf45/0x1490 kernel/workqueue.c:2787
>  kthread+0x3ed/0x540 kernel/kthread.c:388
>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
>  slab_alloc_node mm/slub.c:3478 [inline]
>  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
>  alloc_skb include/linux/skbuff.h:1286 [inline]
>  virtual_ncidev_write+0x6d/0x280 drivers/nfc/virtual_ncidev.c:120
>  vfs_write+0x48b/0x1200 fs/read_write.c:588
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

These two lines are not really relevant, it's a virtual platform, so
whether this is Google or Amazon it does not matter, and your log paste
is already quite long. If there is going to be any resend, I propose to
drop.

> 
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574 [1]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  net/nfc/nci/ntf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> index 994a0a1efb58..56624387e253 100644
> --- a/net/nfc/nci/ntf.c
> +++ b/net/nfc/nci/ntf.c
> @@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
>  		 nci_opcode_oid(ntf_opcode),
>  		 nci_plen(skb->data));
>  
> +	if (!nci_plen(skb->data))
> +		goto end;

Looks reasonable, however wouldn't there be the same issue in
nci_rsp_packet() and other cases from nci_rx_work()? I wonder why only
NTF packets could be constructed without payload.

Best regards,
Krzysztof


