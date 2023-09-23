Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B667AC507
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIWUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIWUVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:21:46 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68170194;
        Sat, 23 Sep 2023 13:21:40 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id k7QEqLdyzQFHRk98Fqx5fd; Sat, 23 Sep 2023 20:21:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k98EqBLmITrtRk98EqJM2d; Sat, 23 Sep 2023 20:21:38 +0000
X-Authority-Analysis: v=2.4 cv=Yucc+qUX c=1 sm=1 tr=0 ts=650f48d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=ag1SF4gXAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S2WSjWRX2U8kFe3kVy2vGKw8Vn0k9n25pi7ggjJqCCc=; b=ep8bS5N6P6KuQHZ/t+tq3U3F6t
        x5GhoRIJhBkVI/V3WWXbvszGay0VvdT/hsRUkmPYeJfi6D2oFp2JvEproOtl3aJ9I17/StAZdb3hW
        uCfLyNoCHx5NxUJVtl/W7ZlLKBOo/oG6BdZTBm3qSnNF0MdD1iuniL9Awde7tXUrNJf2KNHbnqdwN
        lyWUvNw8jZ5uR5+2RWwMQaEL8ly7hPPTl2Ik9EVMLJpDc4xHdxjqLJ3DWkvsSvcbNMvyGuPmBef41
        59x46kFePfbVUTVtrJ1F+hwkRsxM8NWwUG/psKtuqz/QKvHxUvl6LUs6X+WoEuCMWUOrFybMZY2cz
        60jl6Skw==;
Received: from [94.239.20.48] (port=41048 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy85-003hXa-13;
        Sat, 23 Sep 2023 03:36:45 -0500
Message-ID: <36c99ef5-148a-b23a-a456-75617b8fe5c7@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:37:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hpet: Annotate struct hpets with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Clemens Ladisch <clemens@ladisch.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175348.work.056-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175348.work.056-kees@kernel.org>
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
X-Exim-ID: 1qjy85-003hXa-13
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:41048
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO8K4E1PmCCz18tvcArCjWz8BgbSHgEgO4+BNKKagdmnKtAL1AGO54d9dI94i4Hdgww7bAgLrlkSU/s7+/TC/dIDfSRJh7zNR9oUziV6Jd63nTQWLOsP
 35uxhENWzPpSQdiZ5jcLPdG21oRWNEk/oZxveHdgmGQRDnhRDztTm8Nnk04ZDWlOdGBlnvWcpFkleCQp40uCAZ38CU9Qjgr7lqHlZmL8odI6ZeK7b4EvNxf0
 RvxLrAUA8nu3BwzEOZCpuy/yjyP+Re+o7DeRQwni3EI=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:53, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct hpets.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/char/hpet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 3b2159416e62..807c389510de 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -92,7 +92,7 @@ struct hpets {
>   	unsigned long hp_delta;
>   	unsigned int hp_ntimer;
>   	unsigned int hp_which;
> -	struct hpet_dev hp_dev[];
> +	struct hpet_dev hp_dev[] __counted_by(hp_ntimer);
>   };
>   
>   static struct hpets *hpets;
