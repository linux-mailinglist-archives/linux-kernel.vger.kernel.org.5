Return-Path: <linux-kernel+bounces-125707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA28892AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27211282FB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB101C0DCE;
	Sat, 30 Mar 2024 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="qUbOKDYj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ma1aHrfh"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C17FB;
	Sat, 30 Mar 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711798724; cv=none; b=IFD3KhS43/XnH9yWNW19aNc0TkxXRTMxjbfx2UMIqO5G0WNwGVUhrOPDLYZt6SQnkNs//QnZI0jiXH26Rzt+tV8t0kzrvnUDbWI1zoYGd2EEx0x3vXNP1qG5FqnaFSyaoTrVDdQMbvi+R76KRcQOig8soRdKilXbxxFo7YRlJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711798724; c=relaxed/simple;
	bh=z0uo46mKQ+RNZgsyFQouiDEjhYodSebsHuzd5wlqUss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcZ4Trd1bqrnjgCFGlVphshBgjOrCVQv4LbhgQG530dZCdV4zfadT8cHcSqBHJ/qRyiFa0WaACxVgopZqZmn3YdjbFl+lPtREHwuWcKK6HVPlGaDzCoyvAK8NWEC/NNW6YikE9XmDnTE35E87uEYWacg07XVJlBOfB9WTuBoomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=qUbOKDYj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ma1aHrfh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8BA3711400A7;
	Sat, 30 Mar 2024 07:38:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 30 Mar 2024 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1711798721;
	 x=1711885121; bh=Z1Dd2tJZMkiVybemOt34k95e05/iiGNB8NyRWIf1KjE=; b=
	qUbOKDYj+PFY9fXLEX6Mz17/E6SbBGxS11d7urxyBUnWAFA+Ho/ttQ60lkFIbHd3
	ZumeYUnJbo8FAtaAhkq3pK+DQcM8uD3RYzRL4uf0wpfd6YcW5r68pk0C3QaVTsZe
	XqtbvrfobTS7Ql66f8ALf/88k1tRIj37HXCh23leyvK6SIm/J3zCPnwyWOZ8WNAX
	kCYyXjuCAXDH7aS2jlQIuRqfbTVSbWWT8DjLtDKTa+RZiD2g6g+DVzK3V2yAav4h
	pxDG0h2sCrwsf1VHdiGnFMtc8MGfeXnTJ03PUK3u7HGbow6Zb8+EnLcvlljl1iUH
	5BtMUAWUkieNcnV/rn7j6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711798721; x=
	1711885121; bh=Z1Dd2tJZMkiVybemOt34k95e05/iiGNB8NyRWIf1KjE=; b=m
	a1aHrfh5k7qY5VD/j7eltOYaqjVr3YxLMEMJJpiOBPYCgAlh2zU1wgD5tRulrjqN
	mgHrZ+7rKgNxWihnaByPQikds6A7pz0gpYzZ+E2fu55X0tsOAgDuInfsKsO95Ciw
	M/4QYNDR7JiSLS4rqR3kZ+nJ5VTdxMDVW1SZjuFNAMczut8GgdLZ/AqG4uWlDuI9
	3U6VnvR4cH+lB5eCwWoAX/J9jLBkzk6qkeUYEHhbG4luRIzdQafB1VEVmG2XA2o8
	xs+3ZK7r+bLJYe/gC2eC7BJdf+mCybgvGs32+p1gxHq59jFu2KmBtODLWEv9IWkf
	TeDczdGwt+nZzMkG8DBFA==
X-ME-Sender: <xms:wfkHZjafY8hfKPXTOmnlniKZ-xtCYvOkVysY3PAs_BI-vnzAWMKQrw>
    <xme:wfkHZiZqM7XRNPEOGzaHy1iqhOCAU6SGiaFT56pJ7EZJU_LuqL9oClAgXBWlYwxp-
    rw4lS3vD2q8p_WX_qU>
X-ME-Received: <xmr:wfkHZl-uqh6ZQNRPVItXvufas6oi4PketzsSm2dxe9hFAfHhS5b-YdmNwSkOevPSfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvhedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wfkHZpoEzc2v7u1MjoJa9LdVQ36I1Dvjht61oC4acFhllRZpYqCwEw>
    <xmx:wfkHZuoVqdg0ferrc7b-Gw-uVa8OTg0ZVitEhrD6o3HA-55TI8Cxgg>
    <xmx:wfkHZvQsTcoTmfwCuIqWzwbJbMz1Amql_fJFTqFDPFLtH4OKwIho0g>
    <xmx:wfkHZmrtzPQjEmKYj_Z9J0TIzROLjwb7hGkUhZ0_1tB86HbJrrNgqQ>
    <xmx:wfkHZqfsbfml50BFwW1WRUNZZcjZ9TC25V9TQN9B9fHqBNiueGpDSA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 07:38:40 -0400 (EDT)
Message-ID: <71eda6f7-0455-48ee-82b6-33f9e631f3d0@flygoat.com>
Date: Sat, 30 Mar 2024 11:38:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/loongson-pch-msi: Fix off-by-one on allocation
 error path
Content-Language: en-GB
To: Zenghui Yu <yuzenghui@huawei.com>, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, maz@kernel.org, wanghaibin.wang@huawei.com,
 Huacai Chen <chenhuacai@kernel.org>
References: <20240327142334.1098-1-yuzenghui@huawei.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20240327142334.1098-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 14:23, Zenghui Yu 写道:
> When pch_msi_parent_domain_alloc() returns an error, there is an off-by-one
> in the number of IRQs to be freed.
>
> Fix it by passing the number of successfully allocated IRQs, instead of the
> relative index of the last allocated one.
>
> Fixes: 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller")
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>


I copied that piece of code from another driver without thinking.

Good catch!
> ---
>   drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
> index 6e1e1f011bb2..dd4d699170f4 100644
> --- a/drivers/irqchip/irq-loongson-pch-msi.c
> +++ b/drivers/irqchip/irq-loongson-pch-msi.c
> @@ -136,7 +136,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
>   
>   err_hwirq:
>   	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
> -	irq_domain_free_irqs_parent(domain, virq, i - 1);
> +	irq_domain_free_irqs_parent(domain, virq, i);
>   
>   	return err;
>   }


