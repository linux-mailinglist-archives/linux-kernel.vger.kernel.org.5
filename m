Return-Path: <linux-kernel+bounces-82096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC30867F33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BE41F2F08F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D512E1ED;
	Mon, 26 Feb 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ogzxs2hN"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47643AA8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969711; cv=none; b=NDEhhmXpAKNTTcuBcZWJ+Ma0ZH7OGM17DRMZP0UvshifjgHI1FLIJ9lleM3ouJkp5Tto2AkSy6I+9ZGei9doF3yCnSmW4CdmSBRHpYQlgRtr+rJyY1l2zSfjsGibikVN9CvGfTsCq3jaZx1+sjSjrTtELc48cDsHYjkrrkl79VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969711; c=relaxed/simple;
	bh=9CNH6eBrpG7Y4RPdoxYMylKkon4YJXsFwRrwUsvdA5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHHu/S+ddEhB/sfaYGQWyrxMQlgzB9nZmIVN3B7ZpbSFDts5I5OF/u5iIntCJLngYRHCl9cKW1JqN164BUOOSJhct8RxwVx7fPW5eEvSzkUS4Z2ALb0orI9IrCW2gQk+Z4VGL9IN8BVCb1Y62UKfIvCS5N0wdFIwyANVL4gerBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ogzxs2hN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2820477f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708969707; x=1709574507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojp2zJXBZwpD/60KKk/OWh1F7+E9xMLGoW5yyn8MP1Q=;
        b=Ogzxs2hNvY31TJ8yEzCuEKgsyRflf1CIFLDUPoz3SPZhcI5XpfjFcBVylwMo2p7Rw6
         YbnFWpNlssFvAjMN+5lDgvZuhx+kbJDeg79CgyfDsAFlttNl6jzn8Xu+YDdpUtV1XxK4
         2kFCv38UIhiXiAYapi0uTO1+IpyA6P6oKB37zh6Bs51kWNKmi8yzY3OUTxIbXVu7iC2N
         OSEIQAI/BsNsHjYxhP3pi2tBpZB/0hPbJf75zySUVZ5OelkBFnqYyNTYq6UZFbzkBcp0
         mr1SM79onmmHXQvdRU9vNc0Rlr6vw8VM3nvYZI0nY/i3ZPZ6Yn6B47U4CLZOklMc6Eoe
         l2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969707; x=1709574507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojp2zJXBZwpD/60KKk/OWh1F7+E9xMLGoW5yyn8MP1Q=;
        b=uWJ93PBdrQEqaSSPkQA3+z+Krpas1EicMNSN+kh7j4GStEfyR6HKkTNbw3fX1nVuIN
         07cLbaxUDjuGYEW0hme1TuHxFdQvaO4/z332CaujTuKILZRqBXJLlfSK4kDxwQeYnVYf
         Zx216eYqgIknwGMmEWTzAtjeQPCEMJIxNx5elzs9PuSAYIxeRvWivRa97tJ0Nq1ksPKP
         KaL22AhB5UiFz7lMNa6VES1/9niL/hxG0ApiAQ77tjyV+zPhWYRys4MTsZ4vo4YYX1vt
         QBpIWBtx4AANkuTJ/UXetW/AY+SYO/nPucdUGsMn11+6Q+0Rpqr09QcQIsUCAPue9mYt
         gWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEccO91vh6M2ViaLd9Eqp0bhENQ5Es8j7B+X/zrGWI86VTToFGJsKbWQyWMnuSZkeA65Cg6BQ8O6fBf7RIiDs5bE7ftus+oZfd6ESs
X-Gm-Message-State: AOJu0YxT1iPy9TelHBxKsADowRqF8FBhii7VqV16SYqAEAe8pLVGPpDJ
	XmnKkBhxKMJunW6O9A7wu4/Q+buX+nSy4CsHnGnRgIVeC7IHrY1hJFfswkiDXjY=
X-Google-Smtp-Source: AGHT+IFeR4xk7Fwu0u7VFlJ0xMPB7f8Wl3ldtiQ7PBzLuOaNIEmCyOPdZa82wTMgFMPSlFRnwQydCw==
X-Received: by 2002:a05:6000:4ed:b0:33d:6be8:bb61 with SMTP id cr13-20020a05600004ed00b0033d6be8bb61mr5836632wrb.35.1708969707330;
        Mon, 26 Feb 2024 09:48:27 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0033d6fe3f6absm8903931wrm.62.2024.02.26.09.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:48:26 -0800 (PST)
Message-ID: <1c2fe59a-daf6-4486-84ca-5880222d24bd@baylibre.com>
Date: Mon, 26 Feb 2024 18:48:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Add minimal XDP support
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
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
 <20240226172533.GG13129@kernel.org>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <20240226172533.GG13129@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Simon,

Thank you for the review.

On 2/26/24 18:25, Simon Horman wrote:
> On Fri, Feb 23, 2024 at 12:01:37PM +0100, Julien Panis wrote:
>> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
>> Ethernet driver. The following features are implemented:
>> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
>> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
>> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
>>
>> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ...
>
>> @@ -440,6 +476,27 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
>>   	dev_kfree_skb_any(skb);
>>   }
>>   
>> +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
>> +{
>> +	struct page *page;
>> +	struct sk_buff *skb;
> nit: please arrange local variables in reverse xmas tree order,
>       from longest line to shortest in new code.
>
>       This tool can be useful: https://github.com/ecree-solarflare/xmastree

You mean, for the new functions introduced in this patch only ?

>
>> +
>> +	page = dev_alloc_pages(0);
> nit: Maybe dev_alloc_page() is appropriate here?

Absolutely.

>
>> +	if (unlikely(!page))
>> +		return NULL;
>> +
>> +	len += AM65_CPSW_HEADROOM;
>> +
>> +	skb = build_skb(page_address(page), len);
>> +	if (unlikely(!skb))
> Does page need to be freed here?

Of course it does ! This will be fixed in the next version.

>
>> +		return NULL;
>> +
>> +	skb_reserve(skb, AM65_CPSW_HEADROOM + NET_IP_ALIGN);
>> +	skb->dev = ndev;
>> +
>> +	return skb;
>> +}
> ...


