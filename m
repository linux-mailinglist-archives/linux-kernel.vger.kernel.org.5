Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8FD7F77CD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345844AbjKXP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345824AbjKXP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:28:59 -0500
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064D1990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:29:05 -0800 (PST)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTPS
        id 6Uqrr6l72WcCI6Y77r95y5; Fri, 24 Nov 2023 15:29:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 6Y74rOywxqkaT6Y74rllaP; Fri, 24 Nov 2023 15:29:03 +0000
X-Authority-Analysis: v=2.4 cv=bY547cDB c=1 sm=1 tr=0 ts=6560c13f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=YArfMqtJ7KKBon4Yl2AA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TaoInkAh2k51qqNVjJ8mEGKxHgoSLe6W4K886QPYJ9c=; b=DEI9u1RIERU3SpLf+ZKYclwtwE
        a1B0c2iDk+Z/PnhZd6ICkvDKvjlyXeDArogw/v50ewvDHwZ4me8RpTaA8r6irG3QTExxr5W3hpgeN
        jyDQy3iUpa7LhDf88HzzWQPn0joJpMcn38HgkplPElVqQTmDEJ7y+p94hYYMY+jlx4u2Cm5wuKtB5
        pttWre2tXuCjGKR9yWFYq1XLpSy8xu3Ke/Yvc6l9sMqeYe+qtz1Sr76EWBTeMG2Atj8BRXrSMs898
        M4by6TxN4WIjHd2cweARSaMPrc4Cku7ZG8018Tfv4Mf1uQlw8iGfwIK+A5ZSrzoiqnXmVdm8NuGMP
        g3bNJkcQ==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:29540 helo=[192.168.0.25])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r6Y73-000sai-2D;
        Fri, 24 Nov 2023 09:29:01 -0600
Message-ID: <7086f60f-9f74-4118-a10c-d98b9c6cc8eb@embeddedor.com>
Date:   Fri, 24 Nov 2023 09:28:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Boot crash on v6.7-rc2
To:     Joey Gouly <joey.gouly@arm.com>, linux-hardening@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20231124102458.GB1503258@e124191.cambridge.arm.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231124102458.GB1503258@e124191.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6Y73-000sai-2D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:29540
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNPfE+FNGYPlAnsgo/t5b4Day0V5cgjekE9ZGS5ZmuKt5StVZKUs5EVdwZB6SECJ8w7sUQZZ2LbJWSrLhqakL6YHFQS1tzdFvs4z72O3Ji7rpTWbh6HC
 Ny4vJpO9FCf6xuc01ek69W1oSSRHd5BmJofllXBkINq8JhvSXqrjkQ2BYmaZZa4LOmU8ZRmY57dhOp5wkeT4lTzaFGIrUtncxoQiqdmphrNW6vE73N9P1ndC
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 04:24, Joey Gouly wrote:
> Hi all,
> 
> I just hit a boot crash on v6.7-rc2 (arm64, FVP model):

[..]

> Checking `struct neighbour`:
> 
> 	struct neighbour {
> 		struct neighbour __rcu	*next;
> 		struct neigh_table	*tbl;
> 	.. fields ..
> 		u8			primary_key[0];
> 	} __randomize_layout;
> 
> Due to the `__randomize_layout`, `primary_key` field is being placed before `tbl` (actually it's the same address since it's a 0 length array). That means the memcpy() corrupts the tbl pointer.
> 
> I think I just got unlucky with my CONFIG_RANDSTRUCT seed (I can provide it if needed), it doesn't look as if it's a new issue.

It seems the issue is caused by this change that was recently added to -rc2:

commit 1ee60356c2dc ("gcc-plugins: randstruct: Only warn about true flexible arrays")

Previously, one-element and zero-length arrays were treated as true flexible arrays
(however, they are "fake" flex arrays), and __randomize_layout would leave them
untouched at the end of the struct; the same for proper C99 flex-array members. But
after the commit above, that's no longer the case: Only C99 flex-array members will
behave correctly (remaining untouched at end of the struct), and the other two types
of arrays will be randomized.

> 
> I couldn't reproduce directly on v6.6 (the offsets for `tbl` and `primary_key` didn't overlap).
> However I tried changing the zero-length-array to a flexible one:
> 
> 	+	DECLARE_FLEX_ARRAY(u8, primary_key);
> 	+	u8		primary_key[0];
> 
> Then the field offsets ended up overlapping, and I also got the same crash on v6.6.

The right approach is to transform the zero-length array into a C99 flex-array member,
like this:

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 07022bb0d44d..0d28172193fa 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -162,7 +162,7 @@ struct neighbour {
         struct rcu_head         rcu;
         struct net_device       *dev;
         netdevice_tracker       dev_tracker;
-       u8                      primary_key[0];
+       u8                      primary_key[];
  } __randomize_layout;

  struct neigh_ops {

--
Gustavo
