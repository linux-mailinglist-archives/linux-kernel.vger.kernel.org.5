Return-Path: <linux-kernel+bounces-154785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E38AE0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A75282C17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4158ABF;
	Tue, 23 Apr 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY9PCbkZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330585579F;
	Tue, 23 Apr 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864459; cv=none; b=Ur9+6TvFk9HbtyuSjZWtm8vNjmHIYHy0htIKCcmgd4POp8TQTiC8tgoVLtJAeYOa1wYv57TTNXv7nR/thaUZl/kk2QfgAM16BhFpJSUfK8wHvJb1HsaRJ/uD9OmbwpFHfglHctl595H0+k3wE8HP2mwsKqgZr91lZE48WDQs0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864459; c=relaxed/simple;
	bh=EOX4YjrUbozAoGMMLpYqg+jSTn0QmSJhInxxze1hL1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bkbueAaSgdeqFNH793RI9GENMBer/+/+K0zEYMhlNCqaQ5pP/NcM2HaapOkhKy50yxScyRhNpRAqy0tnWKSn2e33AWuD2yyhdu2RODXgdOOGUm2r/mkrGgBHaD19sq214/LpOESGMfx5a5wqgYQrMw/dxRYB6KEVvBJYlb59YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY9PCbkZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4155819f710so44486955e9.2;
        Tue, 23 Apr 2024 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713864456; x=1714469256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZuXG1wkvO/B1fLmfLgdxFlZTA1lHvDftcesjTjOO0U=;
        b=hY9PCbkZ8YGhIbW5Nt2W2SuE6L5nJW83FCQk6pTHkT7WKu2E4zWn6nBgoU9ZTp0ij6
         cvD3q8no6jRGNccMoGJdYxwgVfzcoTDNlWDcYkQ5ypTdIQgYt3T37SUiQdCM7kHXusSh
         poIpkRQYBseJRTM1QrteMM4N0jUEtkzVtqBXadgMfYbE4BD6bEwGasESESdNtN8q6cjM
         siPoftzFxRXHoIJw/M5F13SqeU32gHtrPZuZmw3WTnW/EOQcSSbWe0aQd4QzjIHxVoqt
         1XqDk+efQUTylVbuSk1+8LYa3Y111UPl9M/ja6IC91VE+7Llyzcl05EAG5IPxT3iWQqm
         Q0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864456; x=1714469256;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZuXG1wkvO/B1fLmfLgdxFlZTA1lHvDftcesjTjOO0U=;
        b=IrcGs88Chu4Gb7s4vXdNImShK0aEY7w86PgmrqnyRxVSTcfHsVzTSOFA28IFKNWtDN
         /uZN76ctJ//7zIBlZlrkovCaupKQdxwUBazGDToCrEJ+Yld3mbqTNs4mdRT1YquunGRy
         vR+P+nEzcefhCglzJse0iIxoIlNwj0ixxWof2wkkNgEDA4slFatVXv2VK0ofj48wx4Rr
         cuXbro1F9MW9gjWrA+K1bPQwMj+HGpuR0rRdHQ2bmEhYNCt7hts1uwkHjMIurs01xZzj
         qqf6a88+bFE2onq4JvfOwXODdN7qsQsv6OZqyONeI7JvUD7JY8j22WSj6PaNdWuwH1yd
         mksw==
X-Forwarded-Encrypted: i=1; AJvYcCXzoKR9aiPz6aSeFcWDj14uOUmTcb7TI89/Tv0/bOjTJn5vhI5B6NQUAtv4fe/cunvfxv366JqJXPgTNiA8k/PHDytX887lS5wkwPiAGrATGUQU9qdaeAnXACqhcxyQJZBVRYqJ
X-Gm-Message-State: AOJu0Yzm2mWCz5+SPt7BVHkZKsnOJ0uz4ODVVwPmmdgXqYckECc0wBk/
	FG97nGrkY+aguEqLzc3e0wTCZwiQ6BovMJTPZF70QAjR8wRN2gqP
X-Google-Smtp-Source: AGHT+IF7etJNXP7pepoGiqYe749GYfNp1p1FkDOTbS8vOSHMIRcSPd4q24gYAxumDCb5v9mtUevTcg==
X-Received: by 2002:a05:600c:19cc:b0:418:e08c:865 with SMTP id u12-20020a05600c19cc00b00418e08c0865mr8772642wmq.25.1713864456312;
        Tue, 23 Apr 2024 02:27:36 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b0041a7581f8b6sm5108124wmb.23.2024.04.23.02.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 02:27:36 -0700 (PDT)
Message-ID: <fc6d9631-ad88-43dc-b587-7742fe47ab1e@gmail.com>
Date: Tue, 23 Apr 2024 11:27:22 +0200
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
 <ae7af8b6-0952-434d-8178-8042a2db6bc9@gmail.com>
 <662696b7c257_7539294ba@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <662696b7c257_7539294ba@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Willem de Bruijn wrote:
>>> Richard Gobert wrote:
>>>> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
>>>> makes sure both are set correctly. In the common path there's only one
>>>> write (skb_gro_reset_offset, which replaces skb_set_network_header).
>>>>
>>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>>> ---
>>>>  drivers/net/geneve.c           |  1 +
>>>>  drivers/net/vxlan/vxlan_core.c |  1 +
>>>>  include/net/gro.h              | 18 ++++++++++++++++--
>>>>  net/8021q/vlan_core.c          |  2 ++
>>>>  net/core/gro.c                 |  1 +
>>>>  net/ethernet/eth.c             |  1 +
>>>>  net/ipv4/af_inet.c             |  5 +----
>>>>  net/ipv4/gre_offload.c         |  1 +
>>>>  net/ipv6/ip6_offload.c         |  8 ++++----
>>>>  9 files changed, 28 insertions(+), 10 deletions(-)
>>>>
>>>
>>>> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
>>>> +{
>>>> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
>>>> +}
>>>> +
>>>
>>>
>>>> @@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>>>  	if (unlikely(!iph))
>>>>  		goto out;
>>>>  
>>>> -	skb_set_network_header(skb, off);
>>>> -
>>>
>>> Especially for net, this is still a large patch.
>>>
>>> Can we avoid touching all those tunnel callbacks and just set the
>>> offsets in inet_gro_receive and ipv6_gro_receive themselves, just
>>> as skb_set_network_header now:
>>>
>>> @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>>>         if (unlikely(!iph))
>>>                 goto out;
>>>  
>>> -       skb_set_network_header(skb, off);
>>> +       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
>>>
>>
>> Thanks for the reply!
>>
>> Setting network_offset on dev_gro_receive and inner_network_offset only
>> in the tunnel callbacks is the best option IMO. I agree that
>> we want a small patch to net that solves the problem, although I 
>> think always using ->encap_mark in the common path is not ideal. 
>>
>> We can avoid changing all the tunnel callbacks by always setting
>> inner_network_offset in {ipv6,inet}_gro_receive and initialize
>> network_offset to 0 in dev_gro_receive. It will result in a small
>> change, without using ->encap_mark.
>>
>> What are your thoughts?
> 
> That works. It's a bit ugly that inner_network_offset will always be
> set, even if a packet only traverses inet_gro_receive once. What is
> your concern with testing encap_mark?
> 
> How do you want to detect in udp[46]_lib_lookup_skb which of the two
> offsets to use? That would still be encap_mark based?
> 

I'd like to minimize any potential overhead, even a small one, and this way
we do not need to access encap_mark at all in the common path.

NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;

compiles to:

	movzx   eax, byte ptr [rbx+46h]
	shr     al, 1
	and     eax, 1
	mov     [rbx+rax*2+4Ch], r14w

while

NAPI_GRO_CB(skb)->inner_network_offset = off;

compiles to:

	mov     [rbx+4Eh], r14w

I do plan to add a patch to net-next after this to remove the access
entirely from inet gro callbacks, in the meantime, it looks to me like a
reasonable patch and small enough to not raise concerns.

For udp_lib_lookup I don't see a way around it so yes, it would still be
dependent on encap_mark. Since this runs in the complete phase it's less
concerning.

Let me know that you're ok with that and I'll post a v3.

