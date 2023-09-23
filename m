Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BB7AC41C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjIWRmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjIWRlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:41:51 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1312197;
        Sat, 23 Sep 2023 10:41:44 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id jq43qZqYXDKaKk6dUqJfc5; Sat, 23 Sep 2023 17:41:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k6dSq2mYsU8Krk6dTqwOZp; Sat, 23 Sep 2023 17:41:43 +0000
X-Authority-Analysis: v=2.4 cv=Qt9NYH+d c=1 sm=1 tr=0 ts=650f2357
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=MvuuwTCpAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=oGMlB6cnAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=dVHiktpip_riXrfdqayU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YjjZtI2+QSradkh3So4qn/FdbnNOCtMPTp2Pygw8EE4=; b=Opxzzwvt/5r4akOknMcE72fnag
        JevNLzQxMTLM72aTbT//SPzUmvGry32+KZJpHh4piA3veLFyGyvuN5h75Wb7FHk6VY1r2X98u0FR0
        StsUirmtmlSIbuMcOfNiBFd0N7fh9rifwbeZaci1X8NmHdxoN66VlPuAzhW/ChXUdzoAMGAXcbiEw
        Ud2klQU0q7xqYcTQaXiNVMMzvZz8rTjuQk1i1mY7tJMPNvgkGE6e3ojwJ+5HF5px6pfDVWccxAx2i
        tm5q0IDMqxuLRkmVmZ5QRc7FKX3KA6XtdAxwyHlDcKTJmFuK8OzzLojWJGLjxeWVGBoYxCye/Pjh9
        63+glPjA==;
Received: from [94.239.20.48] (port=43056 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy4P-003c5T-0k;
        Sat, 23 Sep 2023 03:32:57 -0500
Message-ID: <b5e1a30e-ee5c-3a76-112c-3a5168d06c55@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:33:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/platform/uv: Annotate struct uv_rtc_timer_head with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Steve Wahl <steve.wahl@hpe.com>
Cc:     Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175151.work.118-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175151.work.118-kees@kernel.org>
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
X-Exim-ID: 1qjy4P-003c5T-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:43056
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPhTWVpEmV3yiU0UIMhsn9b5vKu4feTfk+sYjb26ldSjfVczAacgO64KWQBaBxU1glrGvyZccaiwYuVnwRaoVjZKPKECGywhY7Bq5gXe1lGDAbVx5WOT
 D+Iv2noSO3QzBO/zN1AAOHRJOFWy/Jg2LgAO4EKs1o7VTHO9wMgY+yuy9kJkczUrf5JdSr3Yd7K6c7Z7klzLodJEFEf3lg3V7jnGo66oNzaBj0vB8T5GjdS1
 zU391Pzu1FYEOvXIgj3JrdoHHjT1mv3alMn9JLVeZSjezPLeVZzMvX/GP4KtibYljY2vFg81Nqj77MBKQpdSbQ==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
> As found with Coccinelle[1], add __counted_by for struct uv_rtc_timer_head.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   arch/x86/platform/uv/uv_time.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index 54663f3e00cb..ff5afc8a5a41 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -53,7 +53,7 @@ struct uv_rtc_timer_head {
>   	struct {
>   		int	lcpu;		/* systemwide logical cpu number */
>   		u64	expires;	/* next timer expiration for this cpu */
> -	} cpu[];
> +	} cpu[] __counted_by(ncpus);
>   };
>   
>   /*
