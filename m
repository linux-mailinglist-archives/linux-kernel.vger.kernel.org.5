Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250CD7AA3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjIUV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjIUV5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:57:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEB88AC2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ff985e292so1145465f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695317953; x=1695922753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=m+OYi7OnRv4VEh5i1SpShTZLc6gSD6htFiKcpkZeDHu0gitc+wMigJamFr/Tar1y4m
         kegYeqkDVcELQaAXyWuUeT2A6BzCNo8ZC1OukmYyPqcd2aUAOuRIh4TQce8aNwDqkQ09
         DAbIiBF3Mw7dWIYrLo1R44NUZ92WTztn2XIR+8Dwf9YsqxRpSHZR1n0zftZs79PgZTRK
         AETsU12g8BaLXNi2L3DHnOPUCxiLwhfGFMn1nMURKfKMVIpcuha7oqggsUOuhD34q9c8
         P+Bn/h4RWjOpqxtdp8fJNyyts17Wx9i0IJ6sScyASUqMRrpuvnC+werwWtBzBSfv/Uxs
         od/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317953; x=1695922753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oet/D+JdIKmqqEXMeGgkoE2/3Tw5UCJOvyH76c8x0dQ=;
        b=B6diqtK3K+3bmhTkdpmWud5ASI3sKnSWl26uvDGvr55SKh3YPKAHeO1Vy35USZBbv0
         cce8vNr1jdO++CVVOAdkKtZ6vfZzJw9q8KEn+vgirtsTmUoivWsZLJ5wQbv/uNY2L9/W
         /5FT1/JcHhoFWf3CU23cRAvYunnLb6UKNpYyA24Wj582zuZ2DoUp/bm1XUcqeLy8INfa
         DTfYVlI0omA9UsmtHB6vB9P2eOBygZHKXwZLOZoO4Pnfp6SIrylTse42zXBj8mmiXLYV
         nf+1VrKvF33abzQIwTRgub9fZL0xPIgaq1oERkx+J/tWSy+LdFXH5AE6CHFBWROJfd2F
         kXQg==
X-Gm-Message-State: AOJu0YyGBxPh1Osv6hwUdNviK8q5BRZA7t9B1tXFUaE+PDBafukhj37v
        FtGNI2X8xNnzWb4QLgM+EwMlZQ3YqBnII6rY6aGfhP2/
X-Google-Smtp-Source: AGHT+IGSqpABR6NJIutspbmDVZEhOKpxYfh5Gelph+0yVDatq2aZ3E+NWHnq2oOH1AMJw/MFATUt/Q==
X-Received: by 2002:ac2:5b1c:0:b0:503:314f:affe with SMTP id v28-20020ac25b1c000000b00503314faffemr4577024lfn.17.1695291285601;
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b00532c32e2b2dsm622021edb.18.2023.09.21.03.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 03:14:45 -0700 (PDT)
Message-ID: <ab1130bb-38ce-1804-7981-6a4532d6ff7b@blackwall.org>
Date:   Thu, 21 Sep 2023 13:14:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 2/6] net: bridge: Set strict_start_type for
 br_policy
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
 <20230919-fdb_limit-v4-2-39f0293807b8@avm.de>
 <1c12b8f2-b28b-f326-b24f-f1ea602832d7@blackwall.org>
 <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
From:   Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZQvvgiz4rE8u6vba@u-jnixdorf.ads.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 10:23, Johannes Nixdorf wrote:
> On Wed, Sep 20, 2023 at 01:46:02PM +0300, Nikolay Aleksandrov wrote:
>> On 9/19/23 11:12, Johannes Nixdorf wrote:
>>> Set any new attributes added to br_policy to be parsed strictly, to
>>> prevent userspace from passing garbage.
>>>
>>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>>> ---
>>>    net/bridge/br_netlink.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>>> index 10f0d33d8ccf..505683ef9a26 100644
>>> --- a/net/bridge/br_netlink.c
>>> +++ b/net/bridge/br_netlink.c
>>> @@ -1229,6 +1229,8 @@ static size_t br_port_get_slave_size(const struct net_device *brdev,
>>>    }
>>>    static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
>>> +	[IFLA_BR_UNSPEC]	= { .strict_start_type =
>>> +				    IFLA_BR_MCAST_QUERIER_STATE + 1 },
>>>    	[IFLA_BR_FORWARD_DELAY]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_HELLO_TIME]	= { .type = NLA_U32 },
>>>    	[IFLA_BR_MAX_AGE]	= { .type = NLA_U32 },
>>>
>>
>> instead of IFLA_BR_MCAST_QUERIER_STATE + 1, why not move around the patch
>> and just use the new attribute name?
>> These are uapi, they won't change.
> 
> I wanted to avoid having a state between the two commits where the new
> attributes are already added, but not yet strictly verified. Otherwise
> they would present a slightly different UAPI at that one commit boundary
> than after this commit.
> 

That's not really a problem, the attribute is the same.

> This is also not the only place in the kernel where strict_start_type
> is specified that way. See e.g. commit c00041cf1cb8 ("net: bridge: Set
> strict_start_type at two policies"), even though that seems mostly be
> done to turn on strict_start_type preemtively, not in the same series
> that adds the new attribute.

Please, just use the new attribute to be more explicit where the strict 
parsing starts.

Thanks,
  Nik


