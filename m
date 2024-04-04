Return-Path: <linux-kernel+bounces-132188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B72899119
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3AE289B6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5F13C3F6;
	Thu,  4 Apr 2024 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctpf5X5V"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78B82D90;
	Thu,  4 Apr 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268977; cv=none; b=khWAprMkAtRekUGQ+BrjC6Fk1K3Rhq8LWyU076Sx8QkxabQf9dmpH4aDhptyKLiN1OJkJ/6yg+13PWBMdc6iDHec6dK7NyRDZPXerQiqze7SEOtoU2WUgPqTNCMV9hX6R2cDdWEsWz42uZxmMYSG2mSSyDVOhouVqP3t0q7v2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268977; c=relaxed/simple;
	bh=2Cvr25ys3NxWXABEd1YLIynAE9R9lmW3IqaHQDk8wTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzkLCpcownugAZX7mKiHCBiDhFomTkJ0LpOPLIiLG/V9znnWnBt+hsVYiWKAIBx82WBKheax2guspFlZzz7oPUMpFhCHRb7hrWcrlEVBNI67C98F9rY3hP41DOxLOeEv4iXVCM99DwdfKKC7tVlaq3X/OL5INx9KsAE8YEs4MGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctpf5X5V; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so1555867276.0;
        Thu, 04 Apr 2024 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712268973; x=1712873773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjWTLbDrbXfZQoCrQFPpaKELa9C28YtlZDvuHhfmfTs=;
        b=Ctpf5X5VEA5picVZYDsndJ9rMGtmhX0D4Z0uQ0tZV+hAx4QvA+fWPV2fBtxnlvR+P9
         ELT2woWDE+2W4k50PNmUTgKiZEwTar81mZ/lEJuwQRluG9CKo2+KiN+Hf++IDL37o0bL
         o+dPBIC8kxod/Z83ei8uNOJGmXv6Ltf8mQzp7Kta2e0l0d59KTD5ZP24Xd+U5we5lNij
         lvQBR3gfbqsN5wt7hThG+5Od3TXFDLf1rEYBYphsSCgZ0VpidiyOLOcib/oAbpCigbDc
         NGuUJRM0PtDSh8nvs63rTwOZtn9F5LHXjVfE0V5qWdl+8aXzD1X1N21I9YDoP4fpnbre
         jQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712268973; x=1712873773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjWTLbDrbXfZQoCrQFPpaKELa9C28YtlZDvuHhfmfTs=;
        b=ube2nZt3D7blceqbLnBiwt78AZNOrULsNhqQGt75XFeJIp3sCg/sxuxb2LYfHOJ0Hn
         KHOPBPBnrtNTGX+wqQyg3mOugAU2ilaCJVxqzDlRhX/CqUslyXGQb5jB0XqH4KO+2EXi
         jBpKX7Ws57l6gQYok4uaLkyYLHeWSimNaYSHAIt5sqJ1GMT1Umw/dfGcmkE8xmA7UNz2
         cqqEqLCPkBXw02Z95bUtNKeKGjVkjfzKKtsxiX1RBtutadIUyszR11diFGE2Mcn1M8w2
         bMRow3GaRIBX9v1vxqk0OZyjVQ1SxvM7Kg/syZf0YqLc44iOc8DY8pQj2Pd9jRr6pNSV
         exmw==
X-Forwarded-Encrypted: i=1; AJvYcCXXSoV7iF0M5vIEdG6uX4x/Kyzi+u0Tol8+aWTq/+4OKG4T9mvCGj2aUKlpeJYQBLyIDPDazGzZ/A5pLjc27Z6k6c29ZX9zfEMx2/ZuLXjPfJyH35S/XXAjMmCjALzHCvxiURTq
X-Gm-Message-State: AOJu0YxCeA7NV2sjaYPJqzT1i1a6WeFe/u5IOlPH9Eff2t6sJ78BLq1R
	4TVcCIXTfGLyoa72GtSyWkOzob5aE32GpEPF1Pm/7M0oT3kmwVfo
X-Google-Smtp-Source: AGHT+IH6ZdMEv89S2ceYWpApKG8b6wlIID0pRvEc4fuQzFd7XNrdq2Sa939KyWOCNWzgmK8OjT3wxA==
X-Received: by 2002:a25:c901:0:b0:dcd:407d:52e5 with SMTP id z1-20020a25c901000000b00dcd407d52e5mr3739806ybf.29.1712268973408;
        Thu, 04 Apr 2024 15:16:13 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id d7-20020a259707000000b00dc62edd58dasm72507ybo.40.2024.04.04.15.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 15:16:12 -0700 (PDT)
Message-ID: <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
Date: Thu, 4 Apr 2024 18:16:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Nikolay Aleksandrov <razor@blackwall.org>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/2024 5:59 PM, Nikolay Aleksandrov wrote:
> On 4/2/24 23:46, Vladimir Oltean wrote:
>> On Tue, Apr 02, 2024 at 09:50:51PM +0300, Nikolay Aleksandrov wrote:
>>> On 4/2/24 20:43, Vladimir Oltean wrote:
>>>> Hi Nikolai,
>>>>
>>>> On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
>>>>> For the bridge patches:
>>>>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>>>
>>>>> You cannot break the multicast flood flag to add support for a custom
>>>>> use-case. This is unacceptable. The current bridge behaviour is correct
>>>>> your patch 02 doesn't fix anything, you should configure the bridge
>>>>> properly to avoid all those problems, not break protocols.
>>>>>
>>>>> Your special use case can easily be solved by a user-space helper or
>>>>> eBPF and nftables. You can set the mcast flood flag and bypass the
>>>>> bridge for these packets. I basically said the same in 2021, if this is
>>>>> going to be in the bridge it should be hidden behind an option that is
>>>>> default off. But in my opinion adding an option to solve such special
>>>>> cases is undesirable, they can be easily solved with what's currently
>>>>> available.
>>>>
>>>> I appreciate your time is limited, but could you please translate your
>>>> suggestion, and detail your proposed alternative a bit, for those of us
>>>> who are not very familiar with IP multicast snooping?
>>>>
>>>
>>> My suggestion is not related to snooping really, but to the goal of
>>> patches 01-03. The bridge patches in this set are trying to forward
>>> traffic that is not supposed to be forwarded with the proposed
>>> configuration,
>> 
>> Correct up to a point. Reinterpreting the given user space configuration
>> and trying to make it do something else seems like a mistake, but in
>> principle one could also look at alternative bridge configurations like
>> the one I described here:
>> https://lore.kernel.org/netdev/20240402180805.yhhwj2f52sdc4dl2@skbuf/
>> 
>>> so that can be done by a user-space helper that installs
>>> rules to bypass the bridge specifically for those packets while
>>> monitoring the bridge state to implement a policy and manage these rules
>>> in order to keep snooping working.
>>>
>>>> Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
>>>> that break snooping? And then do what with the packets, forward them in
>>>> another software layer than the bridge?
>>>>
>>>
>>> The ones that are not supposed to be forwarded in the proposed config
>>> and are needed for this use case (control traffic and link-local). Obviously
>>> to have proper snooping you'd need to manage these bypass
>>> rules and use them only while needed.
>> 
>> I think Joseph will end up in a situation where he needs IGMP control
>> messages both in the bridge data path and outside of it :)
>> 
> 
> My solution does not exclude such scenario. With all unregistered mcast
> disabled it will be handled the same as with this proposed solution.
> 
>> Also, your proposal eliminates the possibility of cooperating with a
>> hardware accelerator which can forward the IGMP messages where they need
>> to go.
>> 
>> As far as I understand, I don't think Joseph has a very "special" use case.
>> Disabling flooding of unregistered multicast in the data plane sounds
>> reasonable. There seems to be a gap in the bridge API, in that this
> 
> This we already have, but..
> 
>> operation also affects the control plane, which he is trying to fix with
>> this "force flooding", because of insufficiently fine grained control.
>> 
> 
> Right, this is the part that is more special, I'm not saying it's
> unreasonable. The proposition to make it optional and break it down to
> type of traffic sounds good to me.
> 
>>>> I also don't quite understand the suggestion of turning on mcast flooding:
>>>> isn't Joseph saying that he wants it off for the unregistered multicast
>>>> data traffic?
>>>
>>> Ah my bad, I meant to turn off flooding and bypass the bridge for those
>>> packets and ports while necessary, under necessary can be any policy
>>> that the user-space helper wants to implement.
>>>
>>> In any case, if this is going to be yet another kernel solution then it
>>> must be a new option that is default off, and doesn't break current mcast
>>> flood flag behaviour.
>> 
>> Yeah, maybe something like this, simple and with clear offload
>> semantics, as seen in existing hardware (not Marvell though):
>> 
>> mcast_flood == off:
>> - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
>> - mcast_ipv4_data_flood: don't care
>> - mcast_ipv6_ctrl_flood: don't care
>> - mcast_ipv6_data_flood: don't care
>> - mcast_l2_flood: don't care
>> mcast_flood == on:
>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>> - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
>> - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
>> - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
>> - Flood L2 according to mcast_l2_flood

Did you mean

if mcast_flood == on (meaning mcast_flood is ENABLED)
- mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded anyway)
..

if mcast_flood == off (meaning mcast_flood is DISABLED)
- Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
..

? Otherwise the problem is still not solved when mcast_flood is disabled.

> 
> Yep, sounds good to me. I was thinking about something in these lines
> as well if doing a kernel solution in order to make it simpler and more
> generic. The ctrl flood bits need to be handled more carefully to make
> sure they match only control traffic and not link-local data.

Do we consider 224.0.0.251 (mDNS) to be control or data? What qualifies 
as control I guess that's my question.

> I think the old option can be converted to use this fine-grained
> control, that is if anyone sets the old flood on/off then the flood
> mask gets set properly so we can do just 1 & in the fast path and avoid
> adding more tests. It will also make it symmetric - if it can override
> the on case, then it will be able to override the off case. And to be
> more explicit you can pass a mask variable to br_multicast_rcv() which
> will get populated and then you can pass it down to br_flood(). That
> will also avoid adding new bits to the skb's bridge CB.
> 
> 


