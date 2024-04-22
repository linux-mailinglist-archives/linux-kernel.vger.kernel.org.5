Return-Path: <linux-kernel+bounces-152979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2E28AC706
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD8B20BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9850269;
	Mon, 22 Apr 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvVmx2eg"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B92A1D5;
	Mon, 22 Apr 2024 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774751; cv=none; b=LQOWpUMyhjksSKPgOUse6zcR2vFsNJc7zG3EuL/8E1vgQ3Yxv+G6oLpueTEYK0Mbv05JonmR3Vr36RI8bEdVik5c141/DcS8B5n+wOvH5/J1Vk4eR1Z9F3a67E2/Ga529Bv1Xvlqe+sTYhaBodyjehmjEO+KAXYspclaT0eRl/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774751; c=relaxed/simple;
	bh=ItqWrjV4KsXB1KfR4xf7yFZdMNV++bahmpR7BVnUJI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cAYulZEUrfyh99iWaoA3lTkEGeDR5hjCP42txcnIn0CbozuJbBsBILthwMXQbU68D2VE9o6q4Ik9XJesCaslGS6KsMS3oMPxJxl8f2wG4y+QM16VY7gtbYIWksu5iKSCCJjBx2pxjVkFPHcrxpZi5vz/Wwq+JgifmQC0NDlTWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvVmx2eg; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2dd041acff1so22596071fa.1;
        Mon, 22 Apr 2024 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774748; x=1714379548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxlY+v4R1WFPP2X8bTG9NbxEznhhcRgrGyfQ/AoxbwY=;
        b=DvVmx2egz2M3qYxNEnJcS2ce1aGVBxdDDHwCrmq3WUnXr3Gs6dSibQCwbDkjciFu5U
         2Km0xHikaWdmuvmb9ya9leM1JnL/QLlnU56Z8oOYQhAVvmdGX+JZwXWElsJY3XhiXqWt
         3hux61hAUNbY+iuZ7ACwPzo+Ard/Hf8RrB2Dy3v1xtBQCl+enaJYWWtJfszaqsbDjhrZ
         E/ZkyMA1C64yL3xFKG1LXI43tYTcbB2eJf4HV1Uw/LT4k8VLmUUFFvft5QkRyl5vsQzt
         TSeH8qu2Zbw28FN046/go7VXpS4ySyYSBMVIQcKR+aR+AquEc1noiInYmUltM5URzp6L
         hM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774748; x=1714379548;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PxlY+v4R1WFPP2X8bTG9NbxEznhhcRgrGyfQ/AoxbwY=;
        b=qSfQlh6nYbi3CY5WVIapIkpeCuQaFiNcFid6gBmk+GVylBfT1zy2fBKAz7Zs5FJK+f
         ake2nogweOEXfhNo9wC5HEUwzijTp3/l1C8pWoDyzLtthjAg3cl6TtYk5S60PylE/jNK
         nGZNJyqUttjMIApfaalQ+T1dm7Js6syWP0xR4kcxRG9a/k7QnQLMUVo2OugAC1s3XqWo
         cqh7bWrQ6Xz2tZvBeoW2pZcVcDxinnqslJJ5BctKVQTzPS0rG9pQDHdCwhjdgWgwW2p7
         kczBzkV8Yemh0EeeX5MWZOITYkvm76bURK40daA4Ee9FVgNQ+TdOC6jnDwlttoXrceKo
         uGZg==
X-Forwarded-Encrypted: i=1; AJvYcCUW1W885hww+/7MZWQhP6XsXqA2Rhtz3rg12KTTj5fxpzzJkF2JeMF03m5mefkPSu8GCQtPEnLKfPb91pjL8v25DSuHXrRX0NxCLNf244RdYse9sw/zQDM9Jq5snE/VRmSNpTzB
X-Gm-Message-State: AOJu0Yxen4LRaNEbqSwZ9B0UGkqHEYR4yp2xiDOwDO/5+7FeUmutM+Sk
	KftA3X6VapfsWGwIDcjL0+/jm+bIywB2vR15W2gF1dT7xA1+6VZ2
X-Google-Smtp-Source: AGHT+IHsBgBAcdF5nwLDpbaXlFLwOSvezPhboZlien6ff2qIWna2LxlAFUMFr2UP4OKO/zBXVP0Qbw==
X-Received: by 2002:a05:651c:10a3:b0:2dc:f305:f536 with SMTP id k3-20020a05651c10a300b002dcf305f536mr5145873ljn.1.1713774747840;
        Mon, 22 Apr 2024 01:32:27 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id e37-20020a5d5965000000b0034a44c615ddsm9357055wri.88.2024.04.22.01.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:32:27 -0700 (PDT)
Message-ID: <ae7af8b6-0952-434d-8178-8042a2db6bc9@gmail.com>
Date: Mon, 22 Apr 2024 10:32:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 alexander.duyck@gmail.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240419153542.121087-1-richardbgobert@gmail.com>
 <20240419153542.121087-2-richardbgobert@gmail.com>
 <6622bd416e567_1241e229425@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <6622bd416e567_1241e229425@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>> makes sure both are set correctly. In the common path there's only one
>> write (skb_gro_reset_offset, which replaces skb_set_network_header).
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  drivers/net/geneve.c           |  1 +
>>  drivers/net/vxlan/vxlan_core.c |  1 +
>>  include/net/gro.h              | 18 ++++++++++++++++--
>>  net/8021q/vlan_core.c          |  2 ++
>>  net/core/gro.c                 |  1 +
>>  net/ethernet/eth.c             |  1 +
>>  net/ipv4/af_inet.c             |  5 +----
>>  net/ipv4/gre_offload.c         |  1 +
>>  net/ipv6/ip6_offload.c         |  8 ++++----
>>  9 files changed, 28 insertions(+), 10 deletions(-)
>>
> 
>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
>> +{
>> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
>> +}
>> +
> 
> 
>> @@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>  	if (unlikely(!iph))
>>  		goto out;
>>  
>> -	skb_set_network_header(skb, off);
>> -
> 
> Especially for net, this is still a large patch.
> 
> Can we avoid touching all those tunnel callbacks and just set the
> offsets in inet_gro_receive and ipv6_gro_receive themselves, just
> as skb_set_network_header now:
> 
> @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>         if (unlikely(!iph))
>                 goto out;
>  
> -       skb_set_network_header(skb, off);
> +       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
> 

Thanks for the reply!

Setting network_offset on dev_gro_receive and inner_network_offset only
in the tunnel callbacks is the best option IMO. I agree that
we want a small patch to net that solves the problem, although I 
think always using ->encap_mark in the common path is not ideal. 

We can avoid changing all the tunnel callbacks by always setting
inner_network_offset in {ipv6,inet}_gro_receive and initialize
network_offset to 0 in dev_gro_receive. It will result in a small
change, without using ->encap_mark.

What are your thoughts?

