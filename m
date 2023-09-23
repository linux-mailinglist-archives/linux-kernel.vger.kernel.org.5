Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984E7AC506
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIWUVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIWUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:21:48 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD65113;
        Sat, 23 Sep 2023 13:21:41 -0700 (PDT)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
        by cmsmtp with ESMTP
        id k7QFqca4rDKaKk98GqKDwv; Sat, 23 Sep 2023 20:21:41 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id k98GqBLo1TrtRk98GqJM3Z; Sat, 23 Sep 2023 20:21:40 +0000
X-Authority-Analysis: v=2.4 cv=Yucc+qUX c=1 sm=1 tr=0 ts=650f48d4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=qjWHau5h7Oqj65Zv8QkA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=95dquq9h2fN9ttOm7akqcNo5sL0dJDCKRHu0Vev7ugY=; b=yULlmJmgkB+IxpSPQpy3qXxdhz
        dyiFkumbRtx2AUY/ANfZXCOI5MWyrQEPKMdJNSIATkhcknr0EaGLPGaL+EloWXqE0h+xY6KP9roRK
        CF3tYyyTudvGcSL30NPHWD6QRW0SaMzMDrMD7nHNPaSXT9eg6MznAJN8A93MPXbbtCDAEpPHBkDk1
        cUdiNOqbiGVttZfV41cgPNBMvA7GoOT4VfnsOHMGzCB08sYTQ0WIwxfeYfP5jzP4iTVkjq1o3rKG5
        rvdUXGRRFdTZtqAIvBVK32dXTisrbYLbrJ7uoNR2A80eACWCjT45nJHMEY+UuZ+mqwZ8kwhRhn5Yt
        WvW+jXUA==;
Received: from [94.239.20.48] (port=52998 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjy55-003czm-1R;
        Sat, 23 Sep 2023 03:33:39 -0500
Message-ID: <e5d6228d-e868-dc94-c49b-7cdc6a86286d@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:34:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] gpiolib: cdev: Annotate struct linereq with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175203.work.760-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175203.work.760-kees@kernel.org>
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
X-Exim-ID: 1qjy55-003czm-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:52998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAZ1ITLoOpQAUiPweuVFExqrmbpzyNOuMc55pWHHPbsvPsFM2aYMTFNed9avpToUiBmpzoL+VGrJmOt4ae2D93ZapPxrjlugh455P9YM1dHo0mMupNEP
 wdyzenrEEISL5I7bbymxJiAcV7VpCaWakrl0DY0W8jDpY0+bUcOQrH4362Su4+wD0mRU3Kyh6++dCf9sRoCxJjY2EX7KC5pDSYQubcxJmfP7ehOhzsXbZdnV
 FfJc8zZV5UWHN0wL2zwDjCIiVB3Bwq1h6mkueyD888lvL4cxzl6YMAdrrEk+Xdcrmq9uAR97FsdM/+E3bKwe6w==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 11:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct linereq.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/gpio/gpiolib-cdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index e39d344feb28..31fc71a612c2 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -572,7 +572,7 @@ struct linereq {
>   	DECLARE_KFIFO_PTR(events, struct gpio_v2_line_event);
>   	atomic_t seqno;
>   	struct mutex config_mutex;
> -	struct line lines[];
> +	struct line lines[] __counted_by(num_lines);
>   };
>   
>   #define GPIO_V2_LINE_BIAS_FLAGS \
> @@ -1656,6 +1656,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>   	lr = kzalloc(struct_size(lr, lines, ulr.num_lines), GFP_KERNEL);
>   	if (!lr)
>   		return -ENOMEM;
> +	lr->num_lines = ulr.num_lines;
>   
>   	lr->gdev = gpio_device_get(gdev);
>   
> @@ -1684,7 +1685,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>   		lr->event_buffer_size = GPIO_V2_LINES_MAX * 16;
>   
>   	atomic_set(&lr->seqno, 0);
> -	lr->num_lines = ulr.num_lines;
>   
>   	/* Request each GPIO */
>   	for (i = 0; i < ulr.num_lines; i++) {
