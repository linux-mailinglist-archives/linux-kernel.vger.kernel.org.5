Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA77A9790
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjIURZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIURZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:09 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBBA6585
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:09:16 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50435ad51bbso102847e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695316154; x=1695920954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pywDHr26aMIdNlh92ssNp5yeq0EGO9N0Av0l9CJtRTM=;
        b=UhxgH87c82q7ZmuX4huLPr3M06E7qJ/J59jDUL9LIzsnrLXMaRFjVmSm8vGJg3MefO
         QSFuCsEz20gJ738skjJ3SxFDrLHqwe5CCYEWxXf+MyfQf6Gr6rPvDaSErrlSUU/UYuZM
         VPFAmogOaxFjuxiE0SCct8FwJrjNLPnz458IWPiN2wrRtc9e9Jr8ZAzMHXM4cVkaoGy5
         rxxy5lghy3/ggdB7aXeFPaiIJlO+9lhIm/wzoXGTWuWR9zX+ImeRZTDIx+ZomdQGlszZ
         9WeePhIbJiwhdLbmSXhfewR1PEmmNMT+7rCm8Y09g922Qr0PsivakJOZlXVx5ANn7H9l
         F01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316154; x=1695920954;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pywDHr26aMIdNlh92ssNp5yeq0EGO9N0Av0l9CJtRTM=;
        b=gCpXBY/+XoO/hJzr+RYcHAAC4wFj2u55vWvv8DLjhYAto8weNUkeb3UDbooSL2DUZL
         LrkMgKtQia2l4hfc30dWDngghCoWqjPj5LZt9DMpHmdUARlAlelv2Ry8bzGhcKaURgKT
         V+UrHx0kIvfriggiiXNNk6EaWfEiBZBK5YNKtPSg9fz7tb/dN6950qENSCWa/9zbXdj1
         ZDiu7mxdr+7pduI6kJ2oYUH4yy9ExTGApGM4MaEI/3//Ed6e4T1fKBJke2s84H/9eeyx
         NvvOX0w85krezjDdDhAPSl6aDUBljQIhabnTyyKIBqw5WNL336h1Lsw6QQvUmqsAM83J
         57Zw==
X-Gm-Message-State: AOJu0YwFYpXzFo60+Ot3JfaNW6OINx47UfhZwkZKTZBaGslpWS7LYM4A
        2FukPwsvpAvW5IjmITeIsi1rtXUBBMWAM8lTuTMN32ZH
X-Google-Smtp-Source: AGHT+IFUh8Z6+6dwNLbxx67rrWJIEXMVs5stNBlOW661Y3biNTu5BIifVeQlIvAWerbPmTitQNmJ2g==
X-Received: by 2002:a17:906:2088:b0:9ae:3d8e:b635 with SMTP id 8-20020a170906208800b009ae3d8eb635mr4348407ejq.24.1695300707453;
        Thu, 21 Sep 2023 05:51:47 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm998745ejd.102.2023.09.21.05.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:51:47 -0700 (PDT)
Message-ID: <6d06e629-3d6b-98dc-fecc-c5336c434d81@blackwall.org>
Date:   Thu, 21 Sep 2023 15:51:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 4/6] net: bridge: Add netlink knobs for number
 / max learned FDB entries
Content-Language: en-US
From:   Nikolay Aleksandrov <razor@blackwall.org>
To:     Johannes Nixdorf <jnixdorf-oss@avm.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, David Ahern <dsahern@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-4-39f0293807b8@avm.de>
 <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
In-Reply-To: <0ae67e4d-0d51-5290-1255-1fe1b699ca14@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 15:41, Nikolay Aleksandrov wrote:
> On 9/19/23 11:12, Johannes Nixdorf wrote:
>> The previous patch added accounting and a limit for the number of
>> dynamically learned FDB entries per bridge. However it did not provide
>> means to actually configure those bounds or read back the count. This
>> patch does that.
>>
>> Two new netlink attributes are added for the accounting and limit of
>> dynamically learned FDB entries:
>>   - IFLA_BR_FDB_N_LEARNED (RO) for the number of entries accounted for
>>     a single bridge.
>>   - IFLA_BR_FDB_MAX_LEARNED (RW) for the configured limit of entries for
>>     the bridge.
>>
>> The new attributes are used like this:
>>
>>   # ip link add name br up type bridge fdb_max_learned 256
>>   # ip link add name v1 up master br type veth peer v2
>>   # ip link set up dev v2
>>   # mausezahn -a rand -c 1024 v2
>>   0.01 seconds (90877 packets per second
>>   # bridge fdb | grep -v permanent | wc -l
>>   256
>>   # ip -d link show dev br
>>   13: br: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 [...]
>>       [...] fdb_n_learned 256 fdb_max_learned 256
>>
>> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
>> ---
>>   include/uapi/linux/if_link.h |  2 ++
>>   net/bridge/br_netlink.c      | 15 ++++++++++++++-
>>   2 files changed, 16 insertions(+), 1 deletion(-)
[snip]
>> @@ -1670,7 +1680,10 @@ static int br_fill_info(struct sk_buff *skb, 
>> const struct net_device *brdev)
>>           nla_put_u8(skb, IFLA_BR_TOPOLOGY_CHANGE_DETECTED,
>>                  br->topology_change_detected) ||
>>           nla_put(skb, IFLA_BR_GROUP_ADDR, ETH_ALEN, br->group_addr) ||
>> -        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm))
>> +        nla_put(skb, IFLA_BR_MULTI_BOOLOPT, sizeof(bm), &bm) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_N_LEARNED,
>> +            atomic_read(&br->fdb_n_learned)) ||
>> +        nla_put_u32(skb, IFLA_BR_FDB_MAX_LEARNED, br->fdb_max_learned))
>>           return -EMSGSIZE;
>>   #ifdef CONFIG_BRIDGE_VLAN_FILTERING
>>
> 
> Actually you're using atomic for counting, but using a u32 for the 
> limit, you should cap it because the count can overflow. Or you should
> use atomic64 for the counting.
> 

Scratch all that, I'm speaking nonsense. Need to refresh my mind. :)
EVerything's alright. Sorry for the noise.

