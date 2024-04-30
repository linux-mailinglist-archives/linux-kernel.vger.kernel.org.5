Return-Path: <linux-kernel+bounces-164368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1E8B7CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C6A1F22DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D3A17A93B;
	Tue, 30 Apr 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt8ykIfW"
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AD177992;
	Tue, 30 Apr 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494480; cv=none; b=HwvN+10NuOPCCu12XB4qWVv4avEqcdpqZZW9oNYgr8eh52xqTvU2bdbtkFGp5Jc1Dt3oT5DKWiBX1n7kDv8Fyxtki4QL00wky5iIsHZK4Jm8InTsMWHRwh/UTUUpoS80Al6KMhLRvyzpqKABIQpQQ+WK+YGhdCAZXDlfBri1gVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494480; c=relaxed/simple;
	bh=rJDlPb4ASLQZZzLVdH8uAuINKNXrJtAZBRgiHy9ePlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMBzNNI7cmrO93NDPoKrCEUeaBlBmdGdC5QKoqwgE74O0skYtvbGuMoM/glUARAsLyGWu4UOFX1L3qkYPPIa00ire4joWPXQqzqS4i/zwy5uU4UG5UbItGyAqWQ2/xIQPuJOQdm+Rl51S63PV3jOIQ9/24JLdm3U/HK7HbdGXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt8ykIfW; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-61bed5ce32fso8464247b3.2;
        Tue, 30 Apr 2024 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494477; x=1715099277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WyUpI+bsqZm6dktATA64nmoLL6nMTXAlQcvkjd29RmE=;
        b=gt8ykIfWzfk8jHpBleZJyEwSkvIG9E7PP3XyFVdbC+HbcEU1gizzteJfhI89Rh437A
         UyB9Z9Ym4PZUFOAamyqCxFcxRFKA1cALIzR7LOaCrzy2/roRf8X6/3/Ooro++zLIltSC
         8LDpN8WcuEJO16iz/AN6zLAMzk6dXaO2IccYZag5toUDpcsq0tEeRH55FhnEu0mDOPad
         S9HbjXh9YTd+gKSIHhTZFDxwXUiP7gJtpp8a0QEWG2ihhq5vbCOsJz4zavpmRRwVgaBP
         swKegLeBEsbotg8v5MKlj39mveXph9mz0pLwLIhzWCl3EEh6g3mhnamfL/GGGhQU/qIh
         GCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494477; x=1715099277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyUpI+bsqZm6dktATA64nmoLL6nMTXAlQcvkjd29RmE=;
        b=j9yPnk3sZH/qS51IFmcMWQyBQhH/8WOGTS1xKQcMFtrqx9PvFvlb+N5NaiNsV8rnk/
         91+vrNk06hTZ7XWVOHBt+045kTFHBBDe0k6YePVZ87qtvtH6OGpeEurHFPAuFQnXKn6K
         Y1mvziMcp93mQ9FdPTIQyJ/I9SWohJW7aldUPGWudZ/leBYztGIBi0my9MycCcr7wkH4
         DBY8BiuWagotcg0t6Xn9pgxc2jXid5hISrK2HkcYPP+8nN68gO8XEBbbThYLxLNCm3du
         Gl2/ncKEtONSLjmHvotZieHGV0hLEwq04KVqqYSYwZ+QpLWROeP3j9BfxVYXlTR7YMkQ
         OF/g==
X-Forwarded-Encrypted: i=1; AJvYcCXd4+zswQMFvHwvmMyrS4TCj/AxZvQO8BNCe8CRg7q6OdrmROBznbBS8X1kQMpnTUe6MRQDTFBhS6rhOVFgSWJ3aFed5cUiPpaXud53zGOVZIoHOgQNf72/2FWcGgXyUosw4cuN
X-Gm-Message-State: AOJu0YwdJb5qjZCE1MQHdyYeuoZP/3tulIJXSbI4ev9/m2hKCQrIVKYb
	Z/GX29JRiF9vPQYy2xPciIa/cT9TCCXnS2jxbmOYSyG2oXChC6c3
X-Google-Smtp-Source: AGHT+IGADJ9TPHQXgX8QG0yNVqQqugF1S2ZYflRqjNxJMWbb6ZPENPYsOth6IjtWdpdVyNs/gg2k4A==
X-Received: by 2002:a05:690c:b9b:b0:61a:e50c:1940 with SMTP id ck27-20020a05690c0b9b00b0061ae50c1940mr87426ywb.7.1714494477383;
        Tue, 30 Apr 2024 09:27:57 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id n129-20020a817287000000b0061bed877011sm235745ywc.68.2024.04.30.09.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:27:56 -0700 (PDT)
Message-ID: <f5ca9b38-3729-49a1-b221-fcc3aecba5d6@gmail.com>
Date: Tue, 30 Apr 2024 12:27:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
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
 <d36e2b82-0353-4c9c-aa89-22383c3bda2b@gmail.com>
 <20240430005949.44lcegwhmcetpddm@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240430005949.44lcegwhmcetpddm@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/2024 8:59 PM, Vladimir Oltean wrote:
> On Mon, Apr 29, 2024 at 06:07:25PM -0400, Joseph Huang wrote:
>> Something like this (some layers omitted for brevity)?
>>
>>                                        +br_iterator
>>                                        |  for each mdb
>>                                        |    _br_switchdev_mdb_notify
>> rtnl_lock                             |      without F_DEFER flag
>>   |                                    |      |
>>   +switchdev_port_attr_set_deferred    |      +switchdev_port_obj_notify
>>     |                                  |        |
>>     +dsa_port_mrouter                  |        +dsa_user_port_obj_a/d
>>       |                                |          |
>>       +mv88e6xxx_port_mrouter----------+          +mv88e6xxx_port_obj_a/d
>>                                          |
>>   +--------------------------------------+
>>   |
>> rtnl_unlock
> 
> At a _very_ superficial glance, I don't think you are properly
> accounting for the fact that even with rtnl_lock() held, there are still
> SWITCHDEV_OBJ_ID_PORT_MDB events which may be pending on the switchdev
> chain. Without a switchdev_deferred_process() flush call, you won't be
> getting rid of them, so when you rtnl_unlock(), they will still run.
> 
> Even worse, holding rtnl_lock() will not stop the bridge multicast layer
> from modifying its br->mdb_list; only br->multicast_lock will.
> 
> So you may be better off also acquiring br->multicast_lock, and
> notifying the MDB entries to the switchdev chain _with_the F_DEFER flag.

Like this?

                                       +br_iterator(dsa_cb)
                                       |  lock br->multicask_lock
                                       |  for each mdb
                                       |    br_switchdev_mdb_notify
rtnl_lock                             |      |
  |                                    |      +switchdev_port_obj_._defer
  +switchdev_port_attr_set_deferred    |  unlock br->multicast_lock
    |                                  |
    +dsa_port_mrouter                  |
      |                                |
      +mv88e6xxx_port_mrouter----------+
                                         |
  +--------------------------------------+
  |
rtnl_unlock

(potential task change)

rtnl_lock
  |
  +switchdev_deferred_process
  | flush all queued dfitems in queuing order
  |
rtnl_unlock

I'm not that familiar with the bridge code, but is there any concern 
with potential deadlock here (bewteen rtnl_lock and br->multicast_lock)?

> 
>> Note that on the system I tested, each register read/write takes about 100us
>> to complete. For 100's of mdb groups, this would mean that we will be
>> holding rtnl lock for 10's of ms. I don't know if it's considered too long.
> 
> Not sure how this is going to be any better if the iteration over MDB
> entries is done 100% in the driver, though - since its hook,
> dsa_port_mrouter(), runs entirely under rtnl_lock(). >
> Anyway, with the SWITCHDEV_F_DEFER flag, maybe the mdb object
> notifications can be made to run by switchdev only a few at a time, to
> give the network stack time to do other things as well.



