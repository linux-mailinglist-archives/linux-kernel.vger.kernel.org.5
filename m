Return-Path: <linux-kernel+bounces-87064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343686CEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3BA01F2308D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDE6757F0;
	Thu, 29 Feb 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iV5Rt3Z3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE5D70AF2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223590; cv=none; b=OrUSWfPk7qZna4CfwvDyoeqWuV7+lKZRl8tL3NseJnN3FaqNTp7VJNsISSzdE0mQFv/qEpBeHLdMaH1YU+Y7htWb1wxwYrNgyHO25ivH2G6VA8E5AT5EdbW3+I2JPKibqt4Ok8WOBIw5hy29PKLOHo50oOgztiOlAmbgmmihioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223590; c=relaxed/simple;
	bh=6CTKVF1fnEKMlvN0QXzawnfANZT0gKBNyyf0+IJDDMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZhLcpryppqulU6NBesZMHsaWCckg3t1FuuiVjA2nYrPQR54xXjGNq8nHsXnLV7J4JMQ067BnSIPcJan7iekDGVYCFovqdseejVN3862nlHls10rsZd8SdoBRpj/DgqrNLCTEck6W8InsEq+iv5zWXAvIHopEw/MUN5LA/ba0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iV5Rt3Z3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412c24280ffso3061665e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709223586; x=1709828386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKHrtZmwyOrlCcM0w35Ivkjsc9tUNE5z7Bg/X3rDKss=;
        b=iV5Rt3Z3aRh7ISeiOQGB/hBWh/bUL5/uwiL5kiddFXLvgvjqYY+fPS7fXI0At7k/PX
         0xhS7Z9q70DZnRUcAn2H2aXuB2NO7UhK6Gq7fwdbqJJ88yBxIVNswO5wyDrIcOL983TU
         B1KqUlM00h/x36zDj2LAf/ivkEfNpgX5K+FbPhSoRbSJ2lurUI/7Pg5h2oIpYxem9RGl
         PJQwun5ZYm70MDYq63/bLs2uXAqizaEqx9trsalSVwga8Ke/SQ/hb7irqZA8LGMJc8pw
         jbn3zvJVCBu7FbNjD1W8aJ/i5i7i08PT0Vu7REAAyvMHPHpdWo3qmZALgtapsiUva442
         vbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223586; x=1709828386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKHrtZmwyOrlCcM0w35Ivkjsc9tUNE5z7Bg/X3rDKss=;
        b=PCyexDGcwUkW79m+PiBGkuoBLJV1fbXUTE/G1GHrkkSrl34mCxMKrt4lIzlIOtqoR1
         s8UkeQ9Hv7+9CquAexjLBuxj6CnJgVxp8N0gIzZUsCsXr7dCfb2tZ4ph6hYdAJJhBidD
         Uc5TQHvU8dy21VpbZaqUaS1G7E9//5Q+JoQQtsIS+wVyI9odXiFB8va9d24Jdjrgz5ps
         C2Z9r6PSztVK9xblZrtJMY4EnVvDwDnJpuSNIwlDmokA8rlUT7BDm3UHSTPDt6jbPmHT
         V77DAlkk2JNqQeWFOQAU0HyE6IRZkRG5HlE+GIM5zAcHoNhwmMD3YP5N5oQbvQTkoxfQ
         oZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvGknPJmM1JuGwL38qEmn851da1JVPYwqgCGHR68M2n0ToltByBasJnuBqaBSQGJFTTgELGWAEkDBHusxkK7tQG2SeIfvAJxV/QJg9
X-Gm-Message-State: AOJu0YxBlk2Uh1FR/cjchUBYG2aSFYkIxVS9b2hMyChFGJrbzjiVgwj0
	Pm1f/FhWYJTpoj48W1y4Pfu9VgDOVFVmfmajMZUb7RWIAdlb8hpH44KgIwHAjEQZAPmm0Wm1TBr
	8
X-Google-Smtp-Source: AGHT+IFz2WCUYBX5DJhCdxNXuLRiVGh2lf1F8VKaJLGzdKH/fRHBW/9UoCpZpLLj2DjoM7c1e7WNMQ==
X-Received: by 2002:a05:600c:468c:b0:410:85ab:67f3 with SMTP id p12-20020a05600c468c00b0041085ab67f3mr2296654wmo.21.1709223586474;
        Thu, 29 Feb 2024 08:19:46 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b0041297d7e181sm2476660wmq.6.2024.02.29.08.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 08:19:46 -0800 (PST)
Message-ID: <65250d0c-96c1-4eb0-adbf-1d3296a7cf36@baylibre.com>
Date: Thu, 29 Feb 2024 17:19:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Add minimal XDP support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com>
 <e382df16-c78a-448d-b6d5-39a627b30652@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <e382df16-c78a-448d-b6d5-39a627b30652@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 00:18, Andrew Lunn wrote:
>> +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
>> +{
>> +	struct page *page;
>> +	struct sk_buff *skb;
>> +
>> +	page = dev_alloc_pages(0);
> You are likely to get better performance if you use the page_pool.
>
> When FEC added XDP support, the first set of changes was to make use
> of page_pool. That improved the drivers performance. Then XDP was
> added on top. Maybe you can follow that pattern.
>
>        Andrew

Hello Andrew,

Thanks for this suggestion. I've been working on it over the last days.
I encountered issues and I begin to wonder if that's a good option for
this driver. Let me explain...

This device has 3 ports:
- Port0 is the host port (internal to the subsystem and referred as CPPI
in the driver).
- Port1 and 2 are the external ethernet ports.
Each port's RX FIFO has 1 queue.

As mentioned in page_pool documentation:
https://docs.kernel.org/networking/page_pool.html
"The number of pools created MUST match the number of hardware
queues unless hardware restrictions make that impossible. This would
otherwise beat the purpose of page pool, which is allocate pages fast
from cache without locking."

So, for this driver I should use 2 page pools (for port1 and 2) if possible.

But, if I I replace any alloc_skb() with page_pool_alloc() in the original
driver, I will have to create only 1 page_pool.
This is visible in am65_cpsw_nuss_common_open(), which starts with:
"if (common->usage_count) return 0;" to ensure that subsequent code
will be executed only once even if the 2 interfaces are ndo_open'd.
IOW, skbs will be allocated for only 1 RX channel. I checked that behavior,
and that's the way it works.
This is because the host port (CPPI) has only 1 RX queue. This single
queue is used to get all the packets, from both Ports and 2 (port ID is
stored in each descriptor).

So, because of this constraint, I ended up working on the "single
page pool" option.

Questions:
1) Is the behavior described above usual for ethernet switch devices ?
2) Given that I can't use a page pool for each HW queue, is it worth
using the page pool memory model ?
3) Currently I use 2 xdp_rxq (one for port1 and another one for port2).
If an XDP program is attached to port1, my page pool dma parameter
will need to be DMA_BIDIRECTIONAL (because of XDP_TX). As a result,
even if there is no XDP program attached to port2, the setting for page
pool will need to be DMA_BIDIRECTIONAL instead of DMA_FROM_DEVICE.
In such situation, isn't it a problem for port2 ?
4) Because of 1) and 2), will page pool performance really be better for
this driver ?

I'm not familiar with network devices, so it's possible that I misunderstand
some stuffs and I might have written things that are not correct or not
consistent. If so, do not hesitate to enlighten me. :)

Julien


