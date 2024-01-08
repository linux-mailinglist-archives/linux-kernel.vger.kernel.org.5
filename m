Return-Path: <linux-kernel+bounces-20000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E87982780B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2AA28481C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA054F83;
	Mon,  8 Jan 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dsl1jFZo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="L/p7ZIlt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FD54F86;
	Mon,  8 Jan 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1704740263; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mbX2NOrWlrdLP/l4MXNn3D0/OxHGs/icq//JzU4nXPxA7QAmoAWjcNDV0YjKXxUIQ+
    p8wVTd5txLZkvlYFKsAOo8p5s2K2vK8GNBsL0TsWYWOrgjeo+x8GkT/6pD5XHiX7wezH
    8/R7U+0fZsPQcAren5iirIEis1rNCUwtiBSJCXDGbniIWTBwjg7jJSJ+mhMD+fFBD79I
    /goKrkkK1D50R5hvPaamQO+cT1QYgazjNt0hv9QInwkMMq9AtqDHY0xoxZqJXoHRGLSM
    xEWJdyZmyBVo1t8mfZJUmSGF/+FlYxQVRvOoMtzb7TGBN3lHfBRfvIn6j+lBEGM5OCtS
    t9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704740263;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J3px+OU0XxKXAITwpaExTX0RE765Q6Bda/x0EbY4UKA=;
    b=NU+UWhid9y8QPwvk9aG3CRfovQpUzyXWG2KRktQ7mBHa+DI10tchcfylD141E1OzPI
    9B4Jb1JIOGvboS0+dQEvocFwHgevTO1l80REiaGlWnBaLR9EEiXaZij7TmZHpLekr65u
    C3/bNmgJ1Xd7bMX5Vl1tTKf3VK6OUvWse/wtk1KjiLOoKq5JDJc26efokX4xyB8lWk6x
    yqv1F/dnlMcoBE8riSOBbfOBW3WmmBvGEOZ07uk9gUHFK9RStcoAjjh6AWqhodC+8w0w
    jXAB4fE+L2Wzz57VD3DYgMVM5QLePOmB2PicZSme7/TU5ZVVK1JJ57Xr2JnqDI1RtVuK
    CHUg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704740263;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J3px+OU0XxKXAITwpaExTX0RE765Q6Bda/x0EbY4UKA=;
    b=dsl1jFZoYwOPTFLdBvLOy2raOacaICxcxbKVjSRMTDks9DVuLaVPk48F8R/2GDp3aF
    S8AaOxg6d8cJ1MtierySMjtClWs63HwooL2vs+bSqLtczgpRdedBjtUOmLfJEM3WGk0+
    l0k7EX00xJvlGFNtFtn2IGk243PETZiFRP8bChrbwc9FO0leDGabltouXd2Zz0O86dnl
    YDI2BFDAJD2Pv9yszHVV9zxjOJN7iWmRcOvKERdo1YJDA/zWwZgtTW/bEfS1UkoG7UUp
    YQeNdIEKbL3g2EjRxrQPGS4N0unRA0ycN0vuOTL+lDLth6IZ9mHZHa4CXZt6aHHulpXa
    SIVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704740263;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=J3px+OU0XxKXAITwpaExTX0RE765Q6Bda/x0EbY4UKA=;
    b=L/p7ZIltLSCCwwiG30j1g+sDiJl6K2ptO3qqejk1iy3zWyAN3QKrg/CKb/hCeqWrok
    1SjhE5MF95YYbJow1uCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USPYLtQZHsrzEmm3snIDlVAt06sCg=="
Received: from [IPV6:2a00:6020:4a8e:5010:150f:f6b8:d0ef:d443]
    by smtp.strato.de (RZmta 49.10.2 AUTH)
    with ESMTPSA id K7b2c2008Ivh0WP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Jan 2024 19:57:43 +0100 (CET)
Message-ID: <14e86ea6-e038-4702-957a-39af27bfc280@hartkopp.net>
Date: Mon, 8 Jan 2024 19:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: bcm: add recvmsg flags for own, local and remote
 traffic
To: Nicolas Maier <nicolas.maier.dev@gmail.com>, mkl@pengutronix.de,
 linux-can@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1cf96afe-6a27-4fd5-975e-96122f72df2e@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <1cf96afe-6a27-4fd5-975e-96122f72df2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nicolas,

thanks for the patch!

On 07.01.24 07:44, Nicolas Maier wrote:

> @@ -642,7 +666,7 @@ static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
>   static void bcm_rx_handler(struct sk_buff *skb, void *data)
>   {
>   	struct bcm_op *op = (struct bcm_op *)data;
> -	const struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
> +	struct canfd_frame *rxframe = (struct canfd_frame *)skb->data;
>   	unsigned int i;
>   
>   	if (op->can_id != rxframe->can_id)
> @@ -657,6 +681,13 @@ static void bcm_rx_handler(struct sk_buff *skb, void *data)
>   			return;
>   	}
>   
> +	/* add flags to distinguish between own/local/remote CAN traffic */
> +	if (skb->sk) {
> +		rxframe->flags |= RX_LOCAL;
> +		if (skb->sk == op->sk)
> +			rxframe->flags |= RX_OWN;
> +	}
> +
>   	/* disable timeout */
>   	hrtimer_cancel(&op->timer);
>   

No. You are writing to a read-only skbuff, which is not yet cloned or 
copied. The read-only handling of the skb is done in the NET_RX_SOFTIRQ 
triggering can_rcv_filter() and friends.

See this note:

https://elixir.bootlin.com/linux/v6.7/source/net/can/af_can.c#L430

When you are also changing the CAN frames' content you need to 
skb_copy() the provided skb, see:

https://elixir.bootlin.com/linux/v6.7/source/net/can/gw.c#L504

So if you want to pass these new flags to the user space you should 
think of extending the parameter list of bcm_rx_update_and_send() and 
bcm_rx_cmp_to_index().

But in the first place I'm interested to know what the use-case for this 
extension is.

Best regards,
Oliver

