Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3E7F8D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjKYSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:41:15 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F7E5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:41:22 -0800 (PST)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTPS
        id 6o4Frw5vbL9Ag6xajrPHoq; Sat, 25 Nov 2023 18:41:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6xairhxmnqkaT6xajr23Ar; Sat, 25 Nov 2023 18:41:21 +0000
X-Authority-Analysis: v=2.4 cv=bY547cDB c=1 sm=1 tr=0 ts=65623fd1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=_Wotqz80AAAA:8
 a=VwQbUJbxAAAA:8 a=4KXrzuhE7PJ765clYEUA:9 a=QEXdDO2ut3YA:10
 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=goA1Ty1WI/b1PzEbCaUpRffs7HZjK+azWPcoAY6Y6nA=; b=k3Js9X+7zdQjCf/Q2y8VvASKAc
        ZS8u+da5sfIk7UclJqJ8000DaIIaeqeFosLWhezTHlw9Z7wKoYX9yCf3w6SKJ7gYVOSd9XQ1Z7shK
        GHZKPYyVtWYCKLJeiJO7zWg7EbQZgr1hbUOj9OkJ8j4Z7whhLdxXoSjZtgL7cs5vEfCN6URP8NyCU
        veczIo/tSzlmd9u5x8jERMaOAK/T2MQDx8YQmlFnm26A5AxAll8KZJ0dnNyx1n5h5/19E4cVBByWH
        9pp4iaaxTNP3w6OUK0P/Sj4jFvD1U6ZKe3oq0P1TGHPdXssBXxJ2IU9KYlDxhNN9la5BcWQFvFk1k
        PwNPqKtQ==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:35520 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6xah-002ScZ-21;
        Sat, 25 Nov 2023 12:41:19 -0600
Message-ID: <c87fb595-1072-45db-8f30-71809be70648@embeddedor.com>
Date:   Sat, 25 Nov 2023 12:41:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Boot crash on v6.7-rc2
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com>
 <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com>
 <d7294586-04a4-49f7-8f5f-2dd66c8b4cde@embeddedor.com>
 <05D345C3-BAFB-4658-8F78-4BC674A764DB@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <05D345C3-BAFB-4658-8F78-4BC674A764DB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6xah-002ScZ-21
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:35520
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL3NyWsgvOgE7wxbTNq+kmyzNPcKZIjVj8HDupKXuPTG2ehkdiqhinOOzE30rMpbEpW/nVphKju9YoyrG1KO/s0ntUEVYx0IokX0z1Wej1fyg40oOwGJ
 tuLXjBS07bZdb9BO6ZjOusZN3e6koywYiSdwUPJfbhldgETuv82x59kWbCurEY4mxhLSyR5ALk+/6wt4HFSyGtjRqPdASPSkGoK1d8VsgZO8xxkZ+/0tvRKE
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/23 12:31, Kees Cook wrote:
> 
> 
> On November 25, 2023 9:54:28 AM PST, "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>>
>> On 11/24/23 09:28, Gustavo A. R. Silva wrote:
>>>
>>>
>>> On 11/24/23 04:24, Joey Gouly wrote:
>>>> Hi all,
>>>>
>>>> I just hit a boot crash on v6.7-rc2 (arm64, FVP model):
>>>
>>> [..]
>>>
>>>> Checking `struct neighbour`:
>>>>
>>>>      struct neighbour {
>>>>          struct neighbour __rcu    *next;
>>>>          struct neigh_table    *tbl;
>>>>      .. fields ..
>>>>          u8            primary_key[0];
>>>>      } __randomize_layout;
>>>>
>>>> Due to the `__randomize_layout`, `primary_key` field is being placed before `tbl` (actually it's the same address since it's a 0 length array). That means the memcpy() corrupts the tbl pointer.
>>>>
>>>> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide it if needed), it doesn't look as if it's a new issue.
>>>
>>> It seems the issue is caused by this change that was recently added to -rc2:
>>>
>>> commit 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
>>>
>>> Previously, one-element and zero-length arrays were treated as true flexible arrays
>>> (however, they are "fake" flex arrays), and __randomize_layout would leave them
>>> untouched at the end of the struct; the same for proper C99 flex-array members. But
>>> after the commit above, that's no longer the case: Only C99 flex-array members will
>>> behave correctly (remaining untouched at end of the struct), and the other two types
>>> of arrays will be randomized.
>>
>> mmh... it seems that commit 1ee60356c2dc only prevents one-element arrays from being
>> treated as flex arrays, while the code should still keep zero-length arrays untouched:
>>
>>         if (typesize == NULL_TREE && TYPE_DOMAIN(fieldtype) != NULL_TREE &&
>>             TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) == NULL_TREE)
>>                 return true;
>>
>> -       if (typesize != NULL_TREE &&
>> -           (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
>> -            tree_to_uhwi(typesize) == tree_to_uhwi(elemsize))))
>> -               return true;
>> -
> 
> This should be both the 0 and 1 checks. I think the original fix is correct: switch to a true flex array.

This code is new to me and I got a bit confused. Thanks for the clarification. :)

So, it'd be nice to apply this change:

https://lore.kernel.org/linux-hardening/b6c1c3ce-3ba0-4439-b0fb-2bb0c38586e0@embeddedor.com/

> 
>>
>> Sorry about the confusion.
>>
>>>
>>>>
>>>> I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary_key` didn't overlap).
>>>> However I tried changing the zero-length-array to a flexible one:
>>>>
>>>>      +    DECLARE_FLEX_ARRAY(u8, primary_key);
>>>>      +    u8        primary_key[0];
> 
> Was this line supposed to be "-"?
> 
>>>>
>>>> Then the field offsets ended up overlapping, and I also got the same crash on v6.6.
>>>
>>> The right approach is to transform the zero-length array into a C99 flex-array member,
>>> like this:
>>>
>>> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
>>> index 07022bb0d44d..0d28172193fa 100644
>>> --- a/include/net/neighbour.h
>>> +++ b/include/net/neighbour.h
>>> @@ -162,7 +162,7 @@ struct neighbour {
>>>           struct rcu_head         rcu;
>>>           struct net_device       *dev;
>>>           netdevice_tracker       dev_tracker;
>>> -       u8                      primary_key[0];
>>> +       u8                      primary_key[];
>>>    } __randomize_layout;
>>>
>>>    struct neigh_ops {
>>
>> In any case, I think we still should convert [0] to [ ].
> 
> I would expect the above to fix the problem. If it doesn't I'll need to take a closer look at the plugin...

I think this should fix the issue. Let me go create a proper patch for this.
I'll send it out, shortly.

--
Gustavo
