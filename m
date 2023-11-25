Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79D7F8CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjKYRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjKYRyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:54:32 -0500
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461A2127
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:54:39 -0800 (PST)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTPS
        id 6h1fr2VbBhqFd6wrWrLe2E; Sat, 25 Nov 2023 17:54:38 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6wrVrQmwKkUbt6wrVrWRjH; Sat, 25 Nov 2023 17:54:38 +0000
X-Authority-Analysis: v=2.4 cv=WpU4jPTv c=1 sm=1 tr=0 ts=656234de
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=6mUrkXxl0K-UJ-lciFYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fQ6gkAIpegcRMWjhELvU1rTB6lMBEW1z2DgZ25eNdo0=; b=bRBdEzawFlxZI6RfftSz5OGGHW
        z0dZeVUJfzQWuG5en1b8FHMQV64h0L/nqbMfs1ICF2ClihuEB5tdHWEllGs2HoSBvakVdJy7EtCJA
        7VT2d2wrnpYxOr9wx+6w3OB4a5BZ7j/DQJ5ZLnZFvlB4mkA9Sv0rYsIVzFnfLs/z+0fIsx16pkESP
        EigUzMG5Bj8r7dHO6vR5niEJMExQ6CmE6c9DSrbSaBdwwoWPzPyNcd0ovdbsh682p8kfjh1pCVRtx
        TWXY/M26fKScoz8f2HLGEe5Lkfx64NI008IBAyBm1U7270CHv3fTSYnXxSCW2jCb/EdqYzAIUqBTG
        2q6Hu3Wg==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:46244 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6wrU-001o7P-2I;
        Sat, 25 Nov 2023 11:54:36 -0600
Message-ID: <d7294586-04a4-49f7-8f5f-2dd66c8b4cde@embeddedor.com>
Date:   Sat, 25 Nov 2023 11:54:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Boot crash on v6.7-rc2
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Joey Gouly <joey.gouly@arm.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com>
 <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com>
Content-Language: en-US
In-Reply-To: <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com>
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
X-Exim-ID: 1r6wrU-001o7P-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:46244
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHyUqeV6zvtsZFpRirITFeuNBqkRB8qT4MmmU4i+3stVJ0IgYAY17//Rt2yLm0KgMjefrSc3wNt2Pz6/P6pXkMb/ulMeyqzVG7iSntm4bSX3vRtASsYP
 wbHI6dBEt9h9xcN670Dt2QMwfQAx5sNbZR9d6HtPR+jN0RYogugOyRYuIuqygShOO2aH7nKkC3QUA0feCIPVV2ePv2DPlgqiXS03KsdvScwtLWOuAKQBRyaI
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 09:28, Gustavo A. R. Silva wrote:
> 
> 
> On 11/24/23 04:24, Joey Gouly wrote:
>> Hi all,
>>
>> I just hit a boot crash on v6.7-rc2 (arm64, FVP model):
> 
> [..]
> 
>> Checking `struct neighbour`:
>>
>>     struct neighbour {
>>         struct neighbour __rcu    *next;
>>         struct neigh_table    *tbl;
>>     .. fields ..
>>         u8            primary_key[0];
>>     } __randomize_layout;
>>
>> Due to the `__randomize_layout`, `primary_key` field is being placed before `tbl` (actually it's the same address since it's a 0 length array). That means the 
>> memcpy() corrupts the tbl pointer.
>>
>> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide it if needed), it doesn't look as if it's a new issue.
> 
> It seems the issue is caused by this change that was recently added to -rc2:
> 
> commit 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")
> 
> Previously, one-element and zero-length arrays were treated as true flexible arrays
> (however, they are "fake" flex arrays), and __randomize_layout would leave them
> untouched at the end of the struct; the same for proper C99 flex-array members. But
> after the commit above, that's no longer the case: Only C99 flex-array members will
> behave correctly (remaining untouched at end of the struct), and the other two types
> of arrays will be randomized.

mmh... it seems that commit 1ee60356c2dc only prevents one-element arrays from being
treated as flex arrays, while the code should still keep zero-length arrays untouched:

         if (typesize == NULL_TREE && TYPE_DOMAIN(fieldtype) != NULL_TREE &&
             TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) == NULL_TREE)
                 return true;

-       if (typesize != NULL_TREE &&
-           (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
-            tree_to_uhwi(typesize) == tree_to_uhwi(elemsize))))
-               return true;
-

Sorry about the confusion.

> 
>>
>> I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary_key` didn't overlap).
>> However I tried changing the zero-length-array to a flexible one:
>>
>>     +    DECLARE_FLEX_ARRAY(u8, primary_key);
>>     +    u8        primary_key[0];
>>
>> Then the field offsets ended up overlapping, and I also got the same crash on v6.6.
> 
> The right approach is to transform the zero-length array into a C99 flex-array member,
> like this:
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 07022bb0d44d..0d28172193fa 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -162,7 +162,7 @@ struct neighbour {
>          struct rcu_head         rcu;
>          struct net_device       *dev;
>          netdevice_tracker       dev_tracker;
> -       u8                      primary_key[0];
> +       u8                      primary_key[];
>   } __randomize_layout;
> 
>   struct neigh_ops {

In any case, I think we still should convert [0] to [ ].

--
Gustavo
