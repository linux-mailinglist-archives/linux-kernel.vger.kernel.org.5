Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083CC7AB817
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjIVRuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjIVRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:49:56 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76844194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:49:49 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id jjIGqyFeWWU1cjkHkqOYMS; Fri, 22 Sep 2023 17:49:48 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jkHjq5Q6pySCujkHkqPBtp; Fri, 22 Sep 2023 17:49:48 +0000
X-Authority-Analysis: v=2.4 cv=ea8uwpIH c=1 sm=1 tr=0 ts=650dd3bc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8
 a=e5xG7rUhXx-5Dd8OgBAA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=71wuTBueWZAsw5Nv2J92OF9IxO/5J5d8n1IYa3AcwDQ=; b=sXOt9XzZabxT+1P2H/GRHGe1Rc
        WbH0iwTO0N0TYMZ4HxF9EnOlBI0X6kBtalq4UgLcTzS82C1OfcfpsgA530jk25h+vlq4zVmGiFide
        54Q9XuRULvnVkOCe9i8hnBU+/cmPCvyJnu/Qa0EEJgb47ZwExGP/nzYX9JPoysdAytm8jS1bgPUp8
        LLeWRwgEbNq8aCupwQWFGoBTpitPuv9glJVfTZ6FEVduSXKDdXSnz4w+w+qsGW6XGV07GhdxCreIB
        1BFZgDpGum5rMuOwGfNoSNEf4yqN/VrBTcJ09fZ0iztzaCW/izRpjSGkk8cfTChzAdWVjF5x4zEmW
        ijhhX6ag==;
Received: from [94.239.20.48] (port=37230 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjkHe-004NOP-25;
        Fri, 22 Sep 2023 12:49:42 -0500
Message-ID: <3bc23613-d1d0-5a05-3057-86933b2c844a@embeddedor.com>
Date:   Fri, 22 Sep 2023 19:50:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/14] ipv4/igmp: Annotate struct ip_sf_socklist with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
        dev@openvswitch.org, linux-parisc@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-2-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkHe-004NOP-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:37230
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 45
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJcq2fk0oeMeOXZBbux7KLK6D2UXlxE33KcMo3VYnPmFNBXxTIRDbVprMlDVFs0NEXZQZWaOOogNJWUZ6bNX1sQgbTnMqfwJPKxgqwmELDm9xU/KuKhb
 MbNxUtXcWCQ6LGVVQehTDw2sXRExhWlC9qXqNt9rGbtfieKWVTlqaQ6+DuXU8c4qZ+IWURSqHbj8UU6nAV9n6/54u1vGucpR83fzWSoNrNQMMRMjyjsidmiG
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ip_sf_socklist.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/igmp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/igmp.h b/include/linux/igmp.h
> index ebf4349a53af..5171231f70a8 100644
> --- a/include/linux/igmp.h
> +++ b/include/linux/igmp.h
> @@ -39,7 +39,7 @@ struct ip_sf_socklist {
>   	unsigned int		sl_max;
>   	unsigned int		sl_count;
>   	struct rcu_head		rcu;
> -	__be32			sl_addr[];
> +	__be32			sl_addr[] __counted_by(sl_max);
>   };
>   
>   #define IP_SFBLOCK	10	/* allocate this many at once */
