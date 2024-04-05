Return-Path: <linux-kernel+bounces-133560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0B89A59C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1986D1F21781
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9F174ED5;
	Fri,  5 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJkFbOmN"
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626917278B;
	Fri,  5 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348568; cv=none; b=qfi+0nzCrBT6L8yWAodq7RjOyEBYV4h4Hes8DTuvirzgXfWzA9puXws/j3Mm+knOSPKY8mo8sRny7xZdBomeqx9QNovvnV8pkDjOLoHJHVf2UiO9nyBsCTIIlvP7E+efLTdgllFdI3tjY25swoiukaxFNBl9bjKov7Px+MeHZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348568; c=relaxed/simple;
	bh=/c7g36rtE40BDeZV1S/AlcHS7dY6Xj4ExtPGgjvBAJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQLLnS6PQY5nswlNehf4XDnrCWpo3/IjA3xFDKR4oSR7JIhN7t3GDhYOyijCBRU8nXuDJkb4LWeE4KpKkH9hw3K/69qU+W2Yx4F86RCB5qV5VTgNjs33MP4yblGucHQJRWSwDyEBNBmMK9AW2J7DPIh8xgbY1hIKcMZwbbeDLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJkFbOmN; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-615038fc5baso27621997b3.3;
        Fri, 05 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712348565; x=1712953365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9uO9sL7m4DMsIKcxtkPkEJUbu4NEoxIAppzIfnBTObw=;
        b=QJkFbOmNZCyJpTeJ3OHD1+CWxPuXIZmk72B7MpAHrkxuhjbWY5YwNg31+CYGxQ8gg+
         6Jl/RaOn0/IFRp2JmHlfqQOvw6KEiLygln/MiCMDt8HNSXA9BeH6nL2GiH+SMDOGUI7n
         9W/sff4BWrrjmd2E40gILEiAI0VS3gJEoJ3wJBqbsWQh8Ho3tTnOV4raveO0r6icdjNM
         /fYjHMiYmNq6xUMsSZ3XVMxQHyBPn/EtkBx91VTq697SuEnxToJuscWn21J5t6h3k41P
         6WcRCIc8pccvnjyD/qhdHavqu6keyVkr4lVEfA86uQCv5+dYIWtkviQnTnnHHSRCPAZR
         VFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712348565; x=1712953365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9uO9sL7m4DMsIKcxtkPkEJUbu4NEoxIAppzIfnBTObw=;
        b=auFIa6uCHGnnKCYstwSvTCU2dI6dFVjRVtAU46w0Xcd0Md6evH2gqf4I71uUDE99ab
         jKur8E/7rhlxeSUbxryJ9Zj7jUTWIf0bB60QiC0sxBhztNVviCA5wUEBfPzDPN7OpJWr
         OVDFXWC34Z0oQBs0HMvtuZpekLw7ZBo538iFXlTPpCqRwbO9mv2w0/FYIYy9k18wpNCK
         9Sr+maUwrhvjsR23dapZJF7MkEqr7j/phUGkxuwyXuyYx6igD2zrgpM0YpqhiBbMvw4+
         nIioRlkyDQk5uZq4EnSbXvFYM0am+/xRskoSYfSDtLPFvuzUbsIjByL1XcjHtVCRZuBQ
         lWCg==
X-Forwarded-Encrypted: i=1; AJvYcCW2yESLT1QhkZWCeJMAXBie3UB7hST2ZO5N6ZDW0wGYjnJ8tF32sm7WXuZeSn+R3KfMCcn2wD10AWA82hVhIAjhFdp5aaWRRkzViqCkAxi1dveRalZw43iaUYT5mHEF5StC7ugB
X-Gm-Message-State: AOJu0Yzui/4VVQd/sHX+6gjd8/cU22lPCqIfgyAhBrsVWoCxezWCN5QC
	DE2ksXCBjT0ELXHBu5BeH2wRb+W7Y61678xnnKW7jXg86tUdd5Z2
X-Google-Smtp-Source: AGHT+IH/fk1YAwa90MOBxgFnsa+3wbT2P6MSx+PBNEyLZqpyED42kh5pJENTlsy6ODPjOmgWmKoDIA==
X-Received: by 2002:a0d:d9d1:0:b0:615:1413:95c1 with SMTP id b200-20020a0dd9d1000000b00615141395c1mr2510706ywe.19.1712348564458;
        Fri, 05 Apr 2024 13:22:44 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id x11-20020a81b04b000000b006155d6134dasm501309ywk.141.2024.04.05.13.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 13:22:44 -0700 (PDT)
Message-ID: <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
Date: Fri, 5 Apr 2024 16:22:43 -0400
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
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/2024 7:00 AM, Nikolay Aleksandrov wrote:
> On 4/5/24 13:20, Vladimir Oltean wrote:
>> On Thu, Apr 04, 2024 at 06:16:12PM -0400, Joseph Huang wrote:
>>>>> mcast_flood == off:
>>>>> - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
>>>>> - mcast_ipv4_data_flood: don't care
>>>>> - mcast_ipv6_ctrl_flood: don't care
>>>>> - mcast_ipv6_data_flood: don't care
>>>>> - mcast_l2_flood: don't care
>>>>> mcast_flood == on:
>>>>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>>>>> - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
>>>>> - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
>>>>> - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
>>>>> - Flood L2 according to mcast_l2_flood
>>>
>>> Did you mean
>>>
>>> if mcast_flood == on (meaning mcast_flood is ENABLED)
>>> - mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded 
>>> anyway)
>>> ...
>>>
>>> if mcast_flood == off (meaning mcast_flood is DISABLED)
>>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>>> ...
>>>
>>> ? Otherwise the problem is still not solved when mcast_flood is 
>>> disabled.
>>
>> No, I mean exactly as I said. My goal was not to "solve the problem"
>> when mcast_flood is disabled, but to give you an option to configure the
>> bridge to achieve what you want, in a way which I think is more 
>> acceptable.
>>
>> AFAIU, there is not really any "problem" - the bridge behaves exactly as
>> instructed given the limited language available to instruct it 
>> ("mcast_flood"
>> covers all multicast). So the other knobs have the role of fine-tuning
>> what gets flooded when mcast_flood is on. Like "yes, but..."
>>
>> You can't "solve the problem" when it involves changing an established
>> behavior that somebody probably depended on to be just like that.
>>
>>>> Yep, sounds good to me. I was thinking about something in these lines
>>>> as well if doing a kernel solution in order to make it simpler and more
>>>> generic. The ctrl flood bits need to be handled more carefully to make
>>>> sure they match only control traffic and not link-local data.
>>>
>>> Do we consider 224.0.0.251 (mDNS) to be control or data? What 
>>> qualifies as
>>> control I guess that's my question.
>>
>> Well, as I said, I'm proposing that 224.0.0.x qualifies as control and
>> the rest of IPv4 multicast as data. Which means that, applied to your
>> case, "mcast_flood on mcast_ipv4_ctrl_flood on mcast_ipv4_data_flood off"
>> will "force flood" mDNS just like the IGMP traffic from your patches.
>> I'm not aware if this could be considered problematic (I don't think so).
>>
>> The reason behind this proposal is that, AFAIU, endpoints may choose to
>> join IGMP groups in the 224.0.0.x range or not, but RFC4541 says that
>> switches shouldn't prune the destinations towards endpoints that don't
>> join this range anyway: https://www.rfc-editor.org/rfc/rfc4541#page-6
>>
>> Whereas for IP multicast traffic towards an address outside 224.0.0.x,
>> pruning will happen as per the IGMP join tracking mechanism.
> 
> +1, non-IGMP traffic to 224.0.0.x must be flooded to all anyway
> so this should allow for a better control over it, but perhaps
> the naming should be link_local instead because control usually
> means IGMP, maybe something like mcast_ip_link_local_flood
> 

Like this?

bridge link set dev swp0 mcast_flood off
   - all flooding disabled

bridge link set dev swp0 mcast_flood on
   - all flooding enabled

bridge link set dev swp0 mcast_flood on mcast_ipv4_data_flood off 
mcast_ipv6_data_flood off
   - IPv4 data packets flooding disabled, IPv6 data packets flooding 
disabled, everything else floods (that is to say, only allow IPv4 local 
subnet and IPv6 link-local to flood)

?

The syntax seems to be counterintuitive.

Or like this?

bridge link set dev swp0 mcast_flood on mcast_ipv4_ctrl_flood on
   - only allow IPv4 local subnet to flood, everything else off

?

So basically the question is, what should the behavior be when something 
is omitted from the command line?

