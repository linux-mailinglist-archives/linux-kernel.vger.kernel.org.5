Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB977FF59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355069AbjHQU4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355072AbjHQU4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:56:07 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D83588
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:56:06 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id WIWBquBXtQFHRWk2HqmyJu; Thu, 17 Aug 2023 20:56:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id Wk2HqJT2fi8uRWk2Hq0kby; Thu, 17 Aug 2023 20:56:05 +0000
X-Authority-Analysis: v=2.4 cv=JOsoDuGb c=1 sm=1 tr=0 ts=64de8965
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=NbqXDWlzB8Eg6oAVJmIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7LE/r6lqKrfMKF1BLJ21dJnlKtdOk7/ts0BsiXouDeE=; b=LfHNHJiyoVE8gfA3q2YJ46VxzV
        jBa7RDFAXEfn5CbmGr4+JUXY6ni8DmQEKK5BdSwsBvyfF4faDn6v3FVoPuawt4kEnaTGgGGaQIrth
        zX7MBaOjgBViwrN2L3jEWSXeFeZghuVKuUu1aQ+Xx3+cnbV1+l0P8w4fkRSV5cQlHxJz29peFwyw+
        NLGWslyVCyfFJpVg/vbedS3epzVp4I7I9TGs0mamQbSIUcTscPnby3DLvYAw28HC0D0Xu+AfzN1TP
        JSB4W6aylC5qVHtgJwJQr7pPj6hm+gvSLXm9h7NnXb/cc45vj5MOhuNgKpN8lLp4O/ZwK5Y/aKLoj
        O6Ej42iQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:54832 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qWk2G-001Mst-14;
        Thu, 17 Aug 2023 15:56:04 -0500
Message-ID: <fda93912-964c-e64a-9da0-64db917f01b6@embeddedor.com>
Date:   Thu, 17 Aug 2023 14:57:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] interconnect: icc-clk: Annotate struct icc_clk_provider
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230817202914.never.661-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230817202914.never.661-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qWk2G-001Mst-14
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:54832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 68
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOAiHWMkcNmncQ7+8OA2mFptH0MyJqAbfy1ENkE5JGqiXjIMM+DqaeJE3OmMHxxkkR1h7K8jzqjX9rejpoarkdlMT8O8ZFLsO5mvO3hfQWaWVbL2as+F
 p2B4C7C515U0Y0bOObFTeV8TiAtyaq+yqcZwREICN5KRHIqU/FIolvr937SFk5bOabWNzWWHzcumi27VLROVXBMHwzWb9U1a1kyg4NwtO2RBCzsuBXcagfa+
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 14:29, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct icc_clk_provider.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Georgi Djakov <djakov@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/interconnect/icc-clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> index 4d43ebff4257..d787f2ea36d9 100644
> --- a/drivers/interconnect/icc-clk.c
> +++ b/drivers/interconnect/icc-clk.c
> @@ -16,7 +16,7 @@ struct icc_clk_node {
>   struct icc_clk_provider {
>   	struct icc_provider provider;
>   	int num_clocks;
> -	struct icc_clk_node clocks[];
> +	struct icc_clk_node clocks[] __counted_by(num_clocks);
>   };
>   
>   #define to_icc_clk_provider(_provider) \
