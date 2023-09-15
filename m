Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D24A7A2866
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjIOUqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjIOUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:46:01 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44C2121
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:45:54 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id gu54qg6voQFHRhFhKqvWcW; Fri, 15 Sep 2023 20:45:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFhJqV9yl5ftlhFhJqg7gI; Fri, 15 Sep 2023 20:45:53 +0000
X-Authority-Analysis: v=2.4 cv=K8UxogaI c=1 sm=1 tr=0 ts=6504c281
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
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
        bh=35M4n8eVgj1j6bFq45ZL42nsUi2E5HxS/MYJDKegMWk=; b=y3O5hke9SpkHqTxEBk1V76/17O
        X8/UilmKI7sb2dwF5M8No0h9sMvY3IW5RNi8bGY6+ev32oMX7Ddi9PEspSjAqbSkO8bU7NEV+IXPd
        EDtea8/EWgCUpeurU98q6l4YWd6Bd1UJXnzSfXjsCUfXFXKQEkZIRBa+L1LnFfldzQmO3NM/RcAPg
        cXnRPbnCJ/8SmRQaXvEksOJfJuDIQ1qHNqrJe6llk7IP1e5NyRDLusLIfCYghcepd09YoOa30ylSN
        IJ/VCIijRc3CWFsaPWgE7nq0yRSG4jDhJu00W653rd4MdV94+C/r+0yJOVt9YnB3TkzUjTeWZmsdz
        bJFxZ0iA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:34914 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFhI-002aET-1U;
        Fri, 15 Sep 2023 15:45:52 -0500
Message-ID: <6c387921-0f30-094e-204b-33ae0daa1f55@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:46:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] leds: el15203000: Annotate struct el15203000 with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915200955.never.871-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200955.never.871-kees@kernel.org>
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
X-Exim-ID: 1qhFhI-002aET-1U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:34914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 205
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNtIPbUghAae80pgfY2EZwZcsa/g7yqCenH2A9w2N6yyVWgOqkdyNaAE1llxDdY1oz2bwoxCNUPzdTpT0A2std1TNuE7wJ3lD20j3cFHHIYBBRSxdEwH
 3kjUgiOaVmWbM2VTm/DJ8aPts4pzACf1+PRdi9uRbng+iUhC/zEevTj34nDlmo2pq1Nz1AO4f+0lonLE55/gp/sLj+huVWWS3V4UzbbyjJwgYIbtsK2l/a6q
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:09, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct el15203000.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/leds/leds-el15203000.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-el15203000.c b/drivers/leds/leds-el15203000.c
> index 7e7b617bcd56..d40194a3029f 100644
> --- a/drivers/leds/leds-el15203000.c
> +++ b/drivers/leds/leds-el15203000.c
> @@ -80,7 +80,7 @@ struct el15203000 {
>   	struct spi_device	*spi;
>   	unsigned long		delay;
>   	size_t			count;
> -	struct el15203000_led	leds[];
> +	struct el15203000_led	leds[] __counted_by(count);
>   };
>   
>   #define to_el15203000_led(d)	container_of(d, struct el15203000_led, ldev)
