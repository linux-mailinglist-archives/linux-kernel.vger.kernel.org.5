Return-Path: <linux-kernel+bounces-132167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081C899087
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99FF28E391
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEE13C3C2;
	Thu,  4 Apr 2024 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghDKZn7M"
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034D15EA6;
	Thu,  4 Apr 2024 21:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266545; cv=none; b=JagvLsXWR252nlotuUGbqzrfBdQEFH6C0L3uIA0RnQxVTJxidb+J8JKdRqggyBZOQcKuc0Wd3mHeVbLMujXJpaOdAb6YbD1AbiSYLE5/7NArM86NVtPgfoPoHRJBSVIOBIpX7U7CN48EerzYgy1yLozdhZB1+8oTkuLt/pDSpvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266545; c=relaxed/simple;
	bh=JTQTqrzushgnpZsjVSlzwLwe3o/1zhQzYzHB9k1LTZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpfdhRgaCONPW94KtMBc7DC6BsIFhKN6D9yL1KeoacQ9qA2YRERzQ71uZUamYBU9iLqEXwkpE1e1uylw9W3AnIbj5OriTpZthRfgirANejzo9VM5oiKxSRPDCqkfpayJ5aU9vHXnOZwZC0be/wo6Zpl7IdNqI/3JHrqdNiH1wAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghDKZn7M; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-61587aa956eso13244617b3.1;
        Thu, 04 Apr 2024 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712266543; x=1712871343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYViHhuN6un7AAvGKIwNdy+ywGtCXn58gtiJR3tWorM=;
        b=ghDKZn7M1jPhUuPx7ZDQkDGvfFPXDGpF7XT9CnV0MBDv7ecV6EcR/JHF4LuNtOKqCV
         EezLgL2/DIbk7qVBeEZ5Igs+F0kvps9aCoCGto9ge+e6DVkhaD/xIbjgXw9ubedXTCoz
         cg+5L1l8LtmR6IsMJzwe7pzoDAeBrDtefuXW3AqX5Bibm2Wz7krpkKb5O965vglA8Zim
         eGCDY4Jbkm9yrt9Vpxh9SQtsuVgUoLtmk87EFoWDwVWOgM8gnoeVu0mb4j9nRJVGq5jl
         3F9IHiHvniUYnTjIfsr3BQdiB2odrj5w657T6QKRb/YSfA2zCn1K++Wk7uRrHZGRUAr+
         SMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712266543; x=1712871343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYViHhuN6un7AAvGKIwNdy+ywGtCXn58gtiJR3tWorM=;
        b=mdqzPCUqvFfVC8IzxoJ/7BXO9KsVie5isrYP7LRmLxI81DK7BXZWGFpn5jBIFPE0vy
         OdCse2hoHDTmCJmJnhNUCjFpG13buiuSnmYRnJgUEpAVoO0skQwEl8Fd6IJZLnWRiiRh
         iTzfjHETjqr8leIOr67gPjwnHNVYbgkT3t+rBG/Lyw9CLz1HWE4H88fKU7dHMy9TXdGj
         huHVV6u4VjSEzaOPzTW3X2S/JodQFvABkZpgU5cLD3+E67kWjbBOh56A/HR4fe9unRaJ
         DRVZsGaVR01hl0UW8cAqXWrIIK9NBwc/VXQHKOhZ8aNZtT6ONjAlgVQxkfq2V3S+FeVS
         yQfg==
X-Forwarded-Encrypted: i=1; AJvYcCU6h57YQi2b9XkmvZQBIPAEr/mNn0P2wQBd11mJX3yLq0giM5vsSwIT0SOqt4sXXaNLvEbjVMpstzS5NHn3b49U9LgdpTYv4E4yjq68
X-Gm-Message-State: AOJu0YxE4tIQtXBgoyOiPPCTnYqX3x84Nf6z7v/KYTOAHRbY9tsKpo33
	mwsETeNf6443h3C2jz0W5s+37H/pQEBXeBU5IBL0Kd/K1/gQDAKh
X-Google-Smtp-Source: AGHT+IEIMCXoTN7AbHHE0JMxoF9IgYcgGOsMLr0GZBAs3lfQviBkmx0Ru6prTlPBrThYniwtpK67ng==
X-Received: by 2002:a81:df12:0:b0:615:18f8:d32a with SMTP id c18-20020a81df12000000b0061518f8d32amr701219ywn.36.1712266542641;
        Thu, 04 Apr 2024 14:35:42 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id w198-20020a0dd4cf000000b00610e03c9fe8sm64368ywd.103.2024.04.04.14.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 14:35:42 -0700 (PDT)
Message-ID: <4c28d59e-0c4f-462c-8a1c-d4bd72e25115@gmail.com>
Date: Thu, 4 Apr 2024 17:35:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
To: Andrew Lunn <andrew@lunn.ch>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <f5512e7b-b572-4444-9d56-1eed9bbcda6b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 4/2/2024 8:43 AM, Andrew Lunn wrote:
> On Mon, Apr 01, 2024 at 08:10:59PM -0400, Joseph Huang wrote:
>> There is a use case where one would like to enable multicast snooping
>> on a bridge but disable multicast flooding on all bridge ports so that
>> registered multicast traffic will only reach the intended recipients and
>> unregistered multicast traffic will be dropped. However, with existing
>> bridge ports' mcast_flood flag implementation, it doesn't work as desired.
>> 
>> This patchset aims to make multicast snooping work even when multicast
>> flooding is disabled on the bridge ports, without changing the semantic of
>> the mcast_flood flag too much. Patches 1 to 4 attempt to address this issue.
>> 
>> Also, in a network where more than one multicast snooping capable bridges
>> are interconnected without multicast routers being present, multicast
>> snooping fails if:
>> 
>>   1. The source is not directly attached to the Querier
>>   2. The listener is beyond the mrouter port of the bridge where the
>>      source is directly attached
>>   3. A hardware offloading switch is involved
> 
> I've not studied the details here, but that last point makes me think
> the offload driver is broken. There should not be any difference
> between software bridging and hardware bridging. The whole idea is
> that you take what Linux can do in software and accelerate it by
> offloading to hardware. Doing acceleration should not change the
> behaviour.
> 

In patch 10 I gave a little more detail about the fix, but basically 
this is what happened.

Assuming we have a soft bridge like the following:

             bp1 +------------+
   Querier <---- |   bridge   |
                 +------------+
                bp2 |      | bp3
                    |      |
                    v      v
             MC Source    MC Listener

Here bp1 is the mrouter port, bp2 is connected to the multicast source, 
and bp3 is connected to the multicast listener who wishes to receive 
multicast traffic for that group.

After some Query/Report exchange, the snooping code in the bridge is 
going to learn about the Listener from bp3, and is going to create an 
MDB group which includes bp3 as the sole member. When the bridge 
receives a multicast packet for that group from bp2, the bridge will do 
a look up to find the members of that group (in this case, bp3) and 
forward the packet to every single member in that group. At the same 
time, the bridge will also forward the packet to every mrouter port so 
that listeners beyond mrouter ports can receive that multicast packet as 
well.

Now consider the same scenario, but with a hardware-offloaded switch:

                 +------------+
                 |   bridge   |
                 +------------+
                       ^
                       |
                       | p6 (Host CPU port)
          p1/bp1 +------------+
   Querier <---- |     sw     |
                 +------------+
             p2/bp2 |      | p3/bp3
                    |      |
                    v      v
             MC Source    MC Listener

Same Query/Report exchange, same MDB group, except that this time around 
the MDB group will be offloaded to the switch as well. So in the 
switch's ATU we will now have an entry for the multicast group and with 
p3 being the only member of that ATU. When the multicast packet arrives 
at the switch from p2, the switch will do an ATU lookup, and forward the 
packet to p3 only. This means that the Host CPU (p6) will not get a copy 
of the packet, and so the soft bridge will not have the opportunity to 
forward that packet to the mrouter port. This is what patch 10 attempts 
to address.

One possible solution of course is to add p6 to every MDB group, however 
that's probably not very desirable. Besides, it will be more efficient 
if the packet is forwarded to the mrouter port by the switch in hardware 
(i.e., offload mrouter forwarding), vs. being forwarded in the bridge by 
software.

>> The patches were developed against 5.15, and forward-ported to 6.8.
>> Tests were done on a Pi 4B + Marvell 6393X Eval board with a single
>> switch chip with no VLAN.
> 
> So what is the mv88e6xxx driver doing wrong?
> 
> 	Andrew
> 

The mv88e6xxx driver did nothing differently than the other DSA drivers. 
I chose the mv88e6xxx driver to implement the fix simply because that's 
the only platform I have at hand to verify the solution.

