Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2747D7ABEE7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIWI2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjIWI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:28:06 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF88CC8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:27:59 -0700 (PDT)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTP
        id jx8ZqihYkOzKljxzbqHCg5; Sat, 23 Sep 2023 08:27:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jxzaqssWqHmohjxzaqHeCr; Sat, 23 Sep 2023 08:27:59 +0000
X-Authority-Analysis: v=2.4 cv=Avz9YcxP c=1 sm=1 tr=0 ts=650ea18f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=gjWtsrhGNCPogvnVG7wA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qe3KtCAORllSc14uOo/VkMifAxQFSeyAwgdtm9iTt24=; b=uypdy4HdLrWH7g0O+iDdmWgFef
        rLTVGONvlnSK/K+3/gKna+eG4wN+yDjXss0TJyUI7xwgYHljzHJLU3lM4RDL+XKMuzbtIZfypIil5
        rXJrinelPx3/e4gpcMu38oWPmNJLjBL8FAx/z4u2eYn7KkmaG8+Mzfurm4eCAceU0YqKvs2ZRY9L/
        DZFzybUHDD7NC8AnmSdI7906UH2pvsbMA19IRwULduHT1Z9SYil+9QfN97SRXfiwlxOpQwex7OMec
        zx+8Qb2I/0bwjZedHJV20p3LAv7Et1RvCuoDH43L6Jd8t3ZfZjWZrxoIX3xiAVLqNRMobU5y3S0ON
        D9EJudNA==;
Received: from [94.239.20.48] (port=34534 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxzZ-003XRR-2V;
        Sat, 23 Sep 2023 03:27:57 -0500
Message-ID: <781aa943-29de-2992-e68f-1bc062a3f4fe@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:29:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] input: Annotate struct evdev_client with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175027.work.563-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175027.work.563-kees@kernel.org>
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
X-Exim-ID: 1qjxzZ-003XRR-2V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:34534
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 80
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLHEnEeyYXRKKaczYMKmLUCBSY0t9TeIaecd2KVefLAwgF4u9+ai8uqCUsRvu6IS5SxeVmI4JpAsIxTV07VES30BLATRwTYY32YJAxE6TYqU3t7Kr5C6
 LsntpzDk1QFlLROUIr853QkjvypMzA+NGP/Bs/1doXz40JQQXG9tnmUyRXhijjyQjSI3WYwPoT3ogtx8Df3C0KDwN+DuccewmmdRJ5ngdlhUbG44r5iDy0sy
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:50, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct evdev_client.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/input/evdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 95f90699d2b1..51e0c4954600 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -50,7 +50,7 @@ struct evdev_client {
>   	bool revoked;
>   	unsigned long *evmasks[EV_CNT];
>   	unsigned int bufsize;
> -	struct input_event buffer[];
> +	struct input_event buffer[] __counted_by(bufsize);
>   };
>   
>   static size_t evdev_get_mask_cnt(unsigned int type)
