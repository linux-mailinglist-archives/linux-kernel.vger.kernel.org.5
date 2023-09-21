Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87177AA1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjIUVFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjIUVEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:04:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D0C1130
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:18:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404fbfac998so14804485e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695320292; x=1695925092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cxYqhV2vF1/qTyjoXVFQ+TzTovUXbNHaLzLCCyWR1E=;
        b=Qlq9zJXDeIS16JGmR4ffI0Da3hcLbJhDHM/9qXAnkOw5RuBkYa1soaX9tNq0HZ4uYY
         3F0gbBhXJB0WsWUzmpNsMhLABSRjf/iZDbpMLCB4MVRm7o1ePzlh6nQkbfP/iCyN42cg
         FLYMQUzRLCxvFN2oD61BRbYSQJ1gr1O2j4DO1jna6KIPaMO7OyaBBJpkEwTeJQdzfn1l
         9ts1wnH1mUmz7wlKJGDRwbKApIK4it9lXkt+vOjRNSKIOwtL7i0gAv544Q8oCuz1nWhg
         IbzBoG2SRNojyfZJgyolTsS8EfvgWF2ymg91xz3E5DBeixn9Pay+ZG23QD7esRpsg4et
         EjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320292; x=1695925092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cxYqhV2vF1/qTyjoXVFQ+TzTovUXbNHaLzLCCyWR1E=;
        b=VvPD/8OEZCchNrVmwyLI2jgDANBZsL14OHsHmg5KJiLYsB6zP5XIGAPk3E5Y0yspfY
         uF8yUKf5CP+X/W02g3+FRiaVD+dZC2915ZqjI9uZ1go8akSR9BJirbjBSdoJjyoVNWM+
         1QjbxgWIvVew/RthMOKPyDTPm+kwt64nyyndNKH9Td2JaWhz2uYeC2PezKrTaHUoZElA
         33B+SDkA1eLD6uAcJzJZoyUOZw4JcfsbFuayH/T7d5bW/j2NjmWif5YUYPRXkZPKkMYP
         A/4b9hS3L7jSWPGgsjDjUH9L+9rXcquJp9H3nGWVGR10UGVXCvMzCZEmKiK5Lhpm9iY+
         1l9g==
X-Gm-Message-State: AOJu0Yxd8yeVwysFpAZVjz4uGxk6DE1cJz4HHkGmhlfqWfsmj+7/4ny2
        rI/sodPUfMoY3Y6H8X1diROvaE8y6VjuBcJYmiiNuUF6
X-Google-Smtp-Source: AGHT+IGvFbJ6Db71oV5a8RSKNQD5duku5npuZ17s6sJi9JPyuKunEwciIHFTyflTn2v/2DkUgSn7gA==
X-Received: by 2002:a17:907:75f2:b0:9ae:567f:6f78 with SMTP id jz18-20020a17090775f200b009ae567f6f78mr2060971ejc.19.1695291586361;
        Thu, 21 Sep 2023 03:19:46 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id s2-20020a170906354200b0098ec690e6d7sm814062eja.73.2023.09.21.03.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:19:46 -0700 (PDT)
Message-ID: <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
Date:   Thu, 21 Sep 2023 13:19:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 5/6] net: bridge: Add a configurable default
 FDB learning limit
Content-Language: en-US
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
 <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
 <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 11:06, Johannes Nixdorf wrote:
> On Wed, Sep 20, 2023 at 02:00:27PM +0300, Nikolay Aleksandrov wrote:
>> On 9/19/23 11:12, Johannes Nixdorf wrote:
>>> Add a Kconfig option to configure a default FDB learning limit system
>>> wide, so a distributor building a special purpose kernel can limit all
>>> created bridges by default.
>>>
>>> The limit is only a soft default setting and overrideable on a per bridge
>>> basis using netlink.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>    net/bridge/Kconfig     | 13 +++++++++++++
>>>    net/bridge/br_device.c |  2 ++
>>>    2 files changed, 15 insertions(+)
>>>
>>> diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
>>> index 3c8ded7d3e84..c0d9c08088c4 100644
>>> --- a/net/bridge/Kconfig
>>> +++ b/net/bridge/Kconfig
>>> @@ -84,3 +84,16 @@ config BRIDGE_CFM
>>>    	  Say N to exclude this support and reduce the binary size.
>>>    	  If unsure, say N.
>>> +
>>> +config BRIDGE_DEFAULT_FDB_MAX_LEARNED
>>> +	int "Default FDB learning limit"
>>> +	default 0
>>> +	depends on BRIDGE
>>> +	help
>>> +	  Sets a default limit on the number of learned FDB entries on
>>> +	  new bridges. This limit can be overwritten via netlink on a

overwritten doesn't sound good, how about This limit can be set (or changed)

>>> +	  per bridge basis.
>>> +
>>> +	  The default of 0 disables the limit.
>>> +
>>> +	  If unsure, say 0.
>>> diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
>>> index 9a5ea06236bd..3214391c15a0 100644
>>> --- a/net/bridge/br_device.c
>>> +++ b/net/bridge/br_device.c
>>> @@ -531,6 +531,8 @@ void br_dev_setup(struct net_device *dev)
>>>    	br->bridge_ageing_time = br->ageing_time = BR_DEFAULT_AGEING_TIME;
>>>    	dev->max_mtu = ETH_MAX_MTU;
>>> +	br->fdb_max_learned = CONFIG_BRIDGE_DEFAULT_FDB_MAX_LEARNED;
>>> +
>>>    	br_netfilter_rtable_init(br);
>>>    	br_stp_timer_init(br);
>>>    	br_multicast_init(br);
>>>
>>
>> This one I'm not sure about at all. Distributions can just create the bridge
>> with a predefined limit. This is not flexible and just adds
>> one more kconfig option that is rather unnecessary. Why having a kconfig
>> knob is better than bridge creation time limit setting? You still have
>> to create the bridge, so why not set the limit then?
> 
> The problem I'm trying to solve here are unaware applications. Assuming
> this change lands in the next Linux release there will still be quite
> some time until the major applications that create bridges (distribution
> specific or common network management tools, the container solution of
> they day, for embedded some random vendor tools, etc.) will pick it
> up. In this series I chose a default of 0 to not break existing setups
> that rely on some arbitrary amount of FDB entries, so those unaware
> applications will create bridges without limits. I added the Kconfig
> setting so someone who knows their use cases can still set a more fitting
> default limit.
> 
> More specifically to our use case as an embedded vendor that builds their
> own kernels and knows they have no use case that requires huge FDB tables,
> the kernel config allows us to set a safe default limit before starting
> to teach all our applications and our upstream vendors' code about the
> new netlink attribute. As this patch is relatively simple, we can also
> keep it downstream if there is opposition to it here though.

I'm not strongly against, just IMO it is unnecessary. I won't block the 
set because of this, but it would be nice to get input from others as
well. If you can recompile your kernel to set a limit, it should be 
easier to change your app to set the same limit via netlink, but I'm not 
familiar with your use case.

