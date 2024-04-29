Return-Path: <linux-kernel+bounces-163088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F78B6552
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396F91C21932
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCD019069F;
	Mon, 29 Apr 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC5AsFe2"
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE21779BD;
	Mon, 29 Apr 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428448; cv=none; b=BDYMmZDgf6upoAJ8mKQxTpmMfAN0hL8kEoMmHJJJW9LMuYPQ2yt3ECB6SWXUZsDrGq9do6XlXKWuGyEqKZ9e0NxNnVnDLpgl1ecQJGq5G3blR2UwVwVyblP044GxzXZgQPu9aHnha7DkBWMFmk4t8HnPd9/baDPbjvh3I7Fnz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428448; c=relaxed/simple;
	bh=7RZyMoqCetWeFs8/lvQs40Xf5QXXPfb8os+0zU2U8jA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rcBDrmDnQm7uDyVtyImdSZx8Vg9y7LzTGHy/xcIq2pF0i91rS9c1vqKLH5CRrUTijaihuLE7gZBoqkWQR433LHNRc1SWbELqWOVTiZITayTTyJttHDPERWQtwRWR9fi5OgTHQAJU7evZ2gsi9hiFriAp3aILJ/a1yDmWRYuoH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC5AsFe2; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso4308084276.3;
        Mon, 29 Apr 2024 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714428446; x=1715033246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WNPjDuIsCAGhmSwDM3zYsna6zJmWSMRuz5bKNz3RO5o=;
        b=fC5AsFe24P3CQo7VAQBR3RZVy6t9RlNKVTLAiBvXva03Rtpd+njz6Uav4pGdhqdJch
         TT+WbrAh4umMeqKJHOMNmfAmXWEakKyCAMpF+Mq0sVKLWIL+U4N1BvbnzIjewgjmeOZW
         mLWqK03nLmiMF4JerzA5i9S5kcakNB6v7SLYVuNMoHnK2v6ED4a1sEczuogHwKW1FJVD
         vORyXaI9esspTcgzS6eisyRXjnT65fIsbZghbsM5jDbOEhm1V4r5lHnO3C6baNuwuzy/
         egRC0X8p7/QuXAXw5z/VaALGMm3UC+IfquP6sDqkg8xKHuZZcHJpYPhzbkEsI6wE0/nO
         K85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428446; x=1715033246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNPjDuIsCAGhmSwDM3zYsna6zJmWSMRuz5bKNz3RO5o=;
        b=BcX0bQ6peqsxuS7sKP2TqxELafQvZ0BZF5kXU6MHQPqucgVx15zyMf4jX9iHCgBMnm
         w6Pn+ectvjPvvRV52DvWA9h30V58DlAmyS9qH/joksrFBf1aybmtu0CAB0nlyRL1SLnB
         sbXaDS14NOZri31sippF3zxqc5UEfa0AHZD3WOrxvwCHWQ7zrSa7PtxOzOb7LJIfMpXo
         TafEvwbP0r2DBTfwIC4+MqOJZda2WnhRfmi8NITzmoM296clzUCJGUIW9W98NkaVrK/+
         s/1bWo0bGp8+IKCyppNJOwhJdsbqbRW419g19xJYdWJMaZXfMVzf1Ed6fA4C8KZJghrr
         8Y7A==
X-Forwarded-Encrypted: i=1; AJvYcCXmdL7alcszz8uQKCJ0ofsTrHyq4NhxbSe3rJKqPsAvrw8BwMr++Hjdcdj1pwO9r7QZZpKIbDXXXXB2i5cpCKN3odzrhXWNU2y150d4IHdpyQLkAvD/2veAqzSfRsvs/SioK6kG
X-Gm-Message-State: AOJu0YxRHNj0tTRppscyJTiNrltTjIU72Zba0esAm22vXQi5kIfAjCVW
	vH+QrVfvCXkuFPpT0dq9BJ8k4u6UCOUN1c0daze7QQvG39RbGEte
X-Google-Smtp-Source: AGHT+IGtYKzgxUyvtAKAkuiRkW/bVBzN0cAJj+xLZAhum8thFmdQgHzmotfBbOFN2fm0pk66fwcnSg==
X-Received: by 2002:a05:6902:1004:b0:de4:6f1e:c9bb with SMTP id w4-20020a056902100400b00de46f1ec9bbmr14605702ybt.26.1714428446201;
        Mon, 29 Apr 2024 15:07:26 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id x3-20020a056902102300b00dcc0cbb0aeesm5745572ybt.27.2024.04.29.15.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 15:07:25 -0700 (PDT)
Message-ID: <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
Date: Mon, 29 Apr 2024 18:07:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
From: Joseph Huang <joseph.huang.2024@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
 <20240405110745.si4gc567jt5gwpbr@skbuf>
 <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
Content-Language: en-US
In-Reply-To: <c4f5c444-832c-4376-845f-7c28e88e4436@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/2024 2:58 PM, Joseph Huang wrote:
> Hi Vladimir,
> 
> On 4/5/2024 7:07 AM, Vladimir Oltean wrote:
>> On Thu, Apr 04, 2024 at 04:43:38PM -0400, Joseph Huang wrote:
>>> Hi Vladimir,
>>>
>>> On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
>>>> Can you comment on the feasibility/infeasibility of Tobias' proposal 
>>>> of:
>>>> "The bridge could just provide some MDB iterator to save us from having
>>>> to cache all the configured groups."?
>>>> https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
>>>>
>>>> What is done here will have to be scaled to many drivers - potentially
>>>> all existing DSA ones, as far as I'm aware.
>>>>
>>>
>>> I thought about implementing an MDB iterator as suggested by Tobias, 
>>> but I'm
>>> a bit concerned about the coherence of these MDB objects. In theory, 
>>> when
>>> the device driver is trying to act on an event, the source of the 
>>> trigger
>>> may have changed its state in the bridge already.
>>
>> Yes, this is the result of SWITCHDEV_F_DEFER, used by both
>> SWITCHDEV_ATTR_ID_PORT_MROUTER and SWITCHDEV_OBJ_ID_PORT_MDB.
>>
>>> If, upon receiving an event in the device driver, we iterate over what
>>> the bridge has at that instant, the differences between the worlds as
>>> seen by the bridge and the device driver might lead to some unexpected
>>> results.
>>
>> Translated: iterating over bridge MDB objects needs to be serialized
>> with new switchdev events by acquiring rtnl_lock(). Then, once switchdev
>> events are temporarily blocked, the pending ones need to be flushed
>> using switchdev_deferred_process(), so resync the bridge state with the
>> driver state. Once the resync is done, the iteration is safe until
>> rtnl_unlock().
>>
>> Applied to our case, the MDB iterator is needed in 
>> mv88e6xxx_port_mrouter().
>> This is already called with rtnl_lock() acquired. The resync procedure
>> will indirectly call mv88e6xxx_port_mdb_add()/mv88e6xxx_port_mdb_del()
>> through switchdev_deferred_process(), and then the walk is consistent
>> for the remainder of the mv88e6xxx_port_mrouter() function.
>>
>> A helper which does this is what would be required - an iterator
>> function which calls an int (*cb)(struct net_device *brport, const 
>> struct switchdev_obj_port_mdb *mdb)
>> for each MDB entry. The DSA core could then offer some post-processing
>> services over this API, to recover the struct dsa_port associated with
>> the bridge port (in the LAG case they aren't the same) and the address
>> database associated with the bridge.

Something like this (some layers omitted for brevity)?

                                       +br_iterator
                                       |  for each mdb
                                       |    _br_switchdev_mdb_notify
rtnl_lock                             |      without F_DEFER flag
  |                                    |      |
  +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
    |                                  |        |
    +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
      |                                |          |
      +mv88e6xxx_port_mrouter----------+          +mv88e6xxx_port_obj_a/d
                                         |
  +--------------------------------------+
  |
rtnl_unlock

Note that on the system I tested, each register read/write takes about 
100us to complete. For 100's of mdb groups, this would mean that we will 
be holding rtnl lock for 10's of ms. I don't know if it's considered too 
long.


>>
>> Do you think there would be unexpected results even if we did this?
>> br_switchdev_mdb_replay() needs to handle a similarly complicated
>> situation of synchronizing with deferred MDB events.
>>  >> However, if we cache the MDB objects in the device driver, at least
>>> the order in which the events took place will be coherent and at any
>>> give time the state of the MDB objects in the device driver can be
>>> guaranteed to be sane. This is also the approach the prestera device
>>> driver took.
>>
>> Not contesting this, but I wouldn't like to see MDBs cached in each
>> device driver just for this. Switchdev is not very high on the list of
>> APIs which are easy to use, and making MDB caching a requirement
>> (for the common case that MDB entry destinations need software fixups
>> with the mrouter ports) isn't exactly going to make that any better.
>> Others' opinion may differ, but mine is that core offload APIs need to
>> consider what hardware is available in the real world, make the common
>> case easy, and the advanced cases possible. Rather than make every case
>> "advanced" :)
> 
> Just throwing some random ideas out there. Do you think it would make 
> more sense if this whole solution (rtnl_lock, iterator cb,...etc.) is 
> moved up to DSA so that other DSA drivers could benefit from it? I 
> thought about implement it (not the iterator, the current form) in DSA 
> at first, but I'm not sure how other drivers would behave, so I did it 
> with mv instead.
> 
> I guess the question is, is the current limitation (mrouter not properly 
> offloaded) an issue specific to mv or is it a limitation of hardware 
> offloading in general? I tend to think it's the latter.
> 
> But then again, if we move it to DSA, we would lose the benefit of the 
> optimization of consolidating multiple register writes into just one (as 
> done in patch 10 currently), unless we add a new switch op which takes a 
> portvec instead of a port when modifying mdb's.


