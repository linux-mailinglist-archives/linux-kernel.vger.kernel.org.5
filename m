Return-Path: <linux-kernel+bounces-164741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A965E8B81E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369491F2441D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FF1BED6A;
	Tue, 30 Apr 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbU0i7K3"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443341A38F0;
	Tue, 30 Apr 2024 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512584; cv=none; b=Nb3Sl4NbMxu2LNJbrJ7yo+9pDtf4TGnEosj/HF2hU83uQQ1TiiFA3KjMKYYuW+x78Vnj+aSZUNBocgRTeT5RveCYv7eyYPGZtnDEAhK2QEKOBq4VTFOPscbzChgwbrpP3weOCqYtuADRpNqojn31lnANyzo8t1gUCOvE6yrcl14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512584; c=relaxed/simple;
	bh=KH1BHsttIcet/0lG9JIKvolnXv53lkAL/4aSGe5wkFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ketTr+fxo3mLgtt24Vp6UfzhQ3hvu+++Flodw4GXISvZxLE+9vKiCFAFzwfd/6qgodsjZe1VUl/17Tyvf3OHlCoqlS1vQY1uiKNyjzOnnBpldcxZPLWT2iRJM7pgHMqAc5/9oPKLEJNwfV446GGt6FK6IbwEgKsECeQ52R5UHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbU0i7K3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34c0f5f5cd0so4866562f8f.2;
        Tue, 30 Apr 2024 14:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714512580; x=1715117380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ2y81c2byjlveBh1HAofGMkjm8xCH8OK2yGcAkdmF0=;
        b=dbU0i7K3rJn3KdTBoO3UUnmlYP3YZ9ngmiAnEi7bttKiISdVs4WKC6IIU+c9EJ2PHS
         nMhi7oULfL/PfBkzY2d6TFYI//a8/+Y253kAfTs3wo9u/5ZjvLEcJoAadRHhLVbQeI3z
         TLYxZaB6x5fPkMEvGM7cK9pvk/P1qROqeJV/eUGQiAe/LaWeqMp5EHwAHJmHUhyXD2Ye
         zk3yUA1lqpFHoWTLxdjQiVM2Xrd1OHvplZdg6pxkH+pSypfLcJgrwLQPqQUL2sQGnKaw
         2QhteGMDy0TOANnaFK5LLwXBvTQ9qllBEDE4EY6teU61TyfTUi+cIZvyKz0n6zzHSncI
         LFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512580; x=1715117380;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ2y81c2byjlveBh1HAofGMkjm8xCH8OK2yGcAkdmF0=;
        b=EegBDcyF786eS7RAZbFzQq9nwW51tC555ePA+utjk29WMUKAFjMj+7MgK0gLlC2cXM
         Amq6iZ0yViEa0Q5teEH/+4U6xvp6rO0aUXTC+EUjsZnOJDySPSNRzYn/CR5VlUSp+n2Q
         StB3xZGWOQqIow4t718H/+LNY/WXPsPklprak1xKtkoXQty0cG7Kk2ABx+A4v/o6BOwf
         TjKpO7YRttq+nckznqeEZOZUrd/89mvTgUC0JPKFkp1W7z5ce7k5MhpWg8tbIFQShxB7
         E+A2280AT2a1sq4h33n9aPjuSuYfxgi5B3rkIW7kw+xK1g9KD7dc+2EQm+X8ZiQTyZ9D
         HBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrUJAPukoXgOrhTA1JE3K3yfV640y1wz/AEQez9zTZ9iUY8hK0wdEbekfe9LDlKMnpCD68huNi27qJI3bU9ZmJK2wWsbqieJNtYN2Forrhr/lN718+ZBYv5nSZoRFzKpyt/A0m
X-Gm-Message-State: AOJu0YyA6zG7K8RPtLGVgWD84Vv6NBWoS7BER7+0IFMWSiIYOZ+a83D+
	8eJYxFAi6bhP6seOkuv5clMo+4UOVhgM+GEsf2wJ5CJhZ1ar8W8o
X-Google-Smtp-Source: AGHT+IEHCnF0NSG99DEHe9lxmu+Temen/zUTzj7bR+E5VYP2Bo430zxOHiyAbM6EHKNq+9iuMPFVfw==
X-Received: by 2002:a5d:4bc7:0:b0:34d:7d03:4602 with SMTP id l7-20020a5d4bc7000000b0034d7d034602mr614567wrt.1.1714512580100;
        Tue, 30 Apr 2024 14:29:40 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72f1:1900:dd93:acce:2a2a:774d? (dynamic-2a01-0c22-72f1-1900-dd93-acce-2a2a-774d.c22.pool.telefonica.de. [2a01:c22:72f1:1900:dd93:acce:2a2a:774d])
        by smtp.googlemail.com with ESMTPSA id z10-20020a05600c220a00b0041bef325c4esm7057100wml.1.2024.04.30.14.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:29:39 -0700 (PDT)
Message-ID: <2422613d-0f9c-4485-bad3-5aa7cf12c0b1@gmail.com>
Date: Tue, 30 Apr 2024 23:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: Don't conditionally compile the
 phy_link_topology creation
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>
References: <20240429131008.439231-1-maxime.chevallier@bootlin.com>
 <1ed5b8cb-c79b-44b9-8dbe-f78d7505b3b4@gmail.com>
 <20240430135734.503f51a2@device-28.home>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240430135734.503f51a2@device-28.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.04.2024 13:57, Maxime Chevallier wrote:
> Hello Heiner,
> 
> On Tue, 30 Apr 2024 10:17:31 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 29.04.2024 15:10, Maxime Chevallier wrote:
>>> The core of the phy_link_topology isn't directly tied to phylib, and at
>>> the moment it's initialized, phylib might not be loaded yet. Move the
>>> initialization of the topology to the phy_link_topology_core header,
>>> which contains the bare minimum so that we can initialize it at netdev
>>> creation.
>>>   
>>
>> The change fixes the issue for me, but according to my personal taste
>> the code isn't intuitive and still error-prone. Also there's no good
>> reason to inline a function like phy_link_topo_create() and make it
>> publicly available. Do you expect it to be ever used outside net core?
>> In general it may make sense to add a config symbol for the topology
>> extension, there seem to be very few, specialized use cases for it.
> 
> I think I'm missing the point here then. Do you mean adding a Kconfig
> option to explicitely turn phy_link_topology on ? or build it as a
> dedicated kernel module ?
> 
> Or do you see something such as "if phylib is M or Y, then build the
> topology stuff and make sure it's allocated when a netdev gets created
> ?"
> 
> Thanks,
> 
> Maxime
> 
>>
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
>>> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
>>> ---
>>>  drivers/net/phy/phy_link_topology.c    | 23 --------------------
>>>  include/linux/phy_link_topology.h      |  5 -----
>>>  include/linux/phy_link_topology_core.h | 30 +++++++++++++++++---------
>>>  3 files changed, 20 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
>>> index 985941c5c558..960aedd73308 100644
>>> --- a/drivers/net/phy/phy_link_topology.c
>>> +++ b/drivers/net/phy/phy_link_topology.c
>>> @@ -12,29 +12,6 @@
>>>  #include <linux/rtnetlink.h>
>>>  #include <linux/xarray.h>
>>>  
>>> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
>>> -{
>>> -	struct phy_link_topology *topo;
>>> -
>>> -	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
>>> -	if (!topo)
>>> -		return ERR_PTR(-ENOMEM);
>>> -
>>> -	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
>>> -	topo->next_phy_index = 1;
>>> -
>>> -	return topo;
>>> -}
>>> -
>>> -void phy_link_topo_destroy(struct phy_link_topology *topo)
>>> -{
>>> -	if (!topo)
>>> -		return;
>>> -
>>> -	xa_destroy(&topo->phys);
>>> -	kfree(topo);
>>> -}
>>> -
>>>  int phy_link_topo_add_phy(struct phy_link_topology *topo,
>>>  			  struct phy_device *phy,
>>>  			  enum phy_upstream upt, void *upstream)
>>> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
>>> index 6b79feb607e7..ad72d7881257 100644
>>> --- a/include/linux/phy_link_topology.h
>>> +++ b/include/linux/phy_link_topology.h
>>> @@ -32,11 +32,6 @@ struct phy_device_node {
>>>  	struct phy_device *phy;
>>>  };
>>>  
>>> -struct phy_link_topology {
>>> -	struct xarray phys;
>>> -	u32 next_phy_index;
>>> -};
>>> -
>>>  static inline struct phy_device *
>>>  phy_link_topo_get_phy(struct phy_link_topology *topo, u32 phyindex)
>>>  {
>>> diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
>>> index 0a6479055745..0116ec49cd1b 100644
>>> --- a/include/linux/phy_link_topology_core.h
>>> +++ b/include/linux/phy_link_topology_core.h
>>> @@ -2,24 +2,34 @@
>>>  #ifndef __PHY_LINK_TOPOLOGY_CORE_H
>>>  #define __PHY_LINK_TOPOLOGY_CORE_H
>>>  
>>> -struct phy_link_topology;
>>> +#include <linux/xarray.h>
>>>  
>>> -#if IS_REACHABLE(CONFIG_PHYLIB)
>>> -
>>> -struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
>>> -void phy_link_topo_destroy(struct phy_link_topology *topo);
>>> -
>>> -#else
>>> +struct phy_link_topology {
>>> +	struct xarray phys;
>>> +	u32 next_phy_index;
>>> +};
>>>  
>>>  static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
>>>  {
>>> -	return NULL;
>>> +	struct phy_link_topology *topo;
>>> +
>>> +	topo = kzalloc(sizeof(*topo), GFP_KERNEL);
>>> +	if (!topo)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
>>> +	topo->next_phy_index = 1;
>>> +
>>> +	return topo;
>>>  }
>>>  
>>>  static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
>>>  {
>>> -}
>>> +	if (!topo)
>>> +		return;
>>>  
>>> -#endif
>>> +	xa_destroy(&topo->phys);
>>> +	kfree(topo);
>>> +}
>>>  
>>>  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */  
>>
> 

To go a little bit more into detail:

phy_link_topo_create() and phy_link_topo_destroy() are used in net/core/dev.c
only. Do you expect them to be ever used by other callers?
If not, their functionality could be moved to net/core/dev.c.
Supposedly guarded by IS_ENABLED(CONFIG_PHYLIB), alternatively a new config
symbol for link_topo support.

To get rid of the dependency you could also lazy-inizialize
netdev->link_topo. For this phy_link_topo_add_phy() would have
to take the netdev as first argument, not the topo.
Then the first call to phy_link_topo_add_phy() would initialize
netdev->link_topo.

I think functions like phy_link_topo_get_phy() should also check for
topo != NULL first, maybe combined with a WARN_ON().
They are exported and you have no control over its use.


