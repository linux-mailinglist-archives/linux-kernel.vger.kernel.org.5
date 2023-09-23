Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5197AC307
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjIWPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjIWPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:02:14 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E894CE1;
        Sat, 23 Sep 2023 08:02:01 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTP
        id k2vBq28rsWU1ck48uqU5d4; Sat, 23 Sep 2023 15:02:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k48tq882blFgfk48tqymSf; Sat, 23 Sep 2023 15:01:59 +0000
X-Authority-Analysis: v=2.4 cv=dpLItns4 c=1 sm=1 tr=0 ts=650efde7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zpNghta1rKfd6QVcv7ngRAUbGtVPymL/xvCr6DZ/1mM=; b=CPWheT3UDfuQuO36cvgjnF1k3/
        s9ahj9STnIpRlFZf0ht3ydI0Kj9Q8F1lj7PgmXmaa5rG6sf4rDM5s0Wb9c+sx++NG8+n0XcbsFMRZ
        N0C46tZDSp0ZkwDxKlLPq37oEBdzrT3WL+5hpni9hQdHkD2Y5tBj4ODOlrKkp6aT1UEuDKjHNK/Fy
        nDAvRp6AEX/wyZKDiHTUPXyqs5uezpsL/ryt/DR15wZY2YT1vHY9ZfcBXgHy2T0UBadiVoOCrpyb6
        /qFmnLmiube3L34Jf+mKZpF5NbTXCjnKZjmX3jVOWvT+NoGjPiKI09AbTqHUM7alZO6e9gER1Zn6k
        g5kWvntQ==;
Received: from [94.239.20.48] (port=59778 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy3F-003atH-0V;
        Sat, 23 Sep 2023 03:31:45 -0500
Message-ID: <470453a9-c326-2cf2-271f-f5b61d20740b@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:32:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] irqdomain: Annotate struct irq_domain with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Marc Zyngier <maz@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175127.work.214-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175127.work.214-kees@kernel.org>
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
X-Exim-ID: 1qjy3F-003atH-0V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:59778
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE8WDLoiubZQQFAMX82gCGbLdtl1YrNWKZyyF686OTdVmZu2AhQcSdZmRYyS7ljR8SQcifOH0KVkavvOH7KkUmySW3pipmyUKO78/fEuGktWFiZ6OPJt
 fpsEk8f3P8pjf9suUF9y/Fsl3aqJtjdvVh5la44JjSDWWk0BLF7pQ9tYIcSUbZF01Tm70FigqfGU8FB3EXBMIgrfXChne7wh8Hct80p44uC5D12XcjjV2qL6
 ID57Aa+uzN+J2uO3AiKQZvLyuTJYBJY0H4QkTalUlgM=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:51, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct irq_domain.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   include/linux/irqdomain.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index 51c254b7fec2..ee0a82c60508 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -174,7 +174,7 @@ struct irq_domain {
>   	irq_hw_number_t			hwirq_max;
>   	unsigned int			revmap_size;
>   	struct radix_tree_root		revmap_tree;
> -	struct irq_data __rcu		*revmap[];
> +	struct irq_data __rcu		*revmap[] __counted_by(revmap_size);
>   };
>   
>   /* Irq domain flags */
