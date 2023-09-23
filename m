Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45147ABEEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjIWI2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjIWI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:28:31 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4119E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 01:28:25 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id jjIGqYCqnDKaKjy01qHYzx; Sat, 23 Sep 2023 08:28:25 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jy00qKkeJySCujy00qYH2v; Sat, 23 Sep 2023 08:28:24 +0000
X-Authority-Analysis: v=2.4 cv=ea8uwpIH c=1 sm=1 tr=0 ts=650ea1a8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=ffdGAcwRWn2kBxf02vYA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4MkvwgfG2f0rR4J4N5IdVcabzhoeN6YMox+PAYVuHDg=; b=hxE/QxCMmIg4GIjJ1kKysfB8HW
        LFKNGposUCaPO5YrVpm8nWxVAK3o2W+f0ds0tO7A9oqB77pzkkcxWXK6oTRB+sDdwuRmwvV/ptEUk
        awn9myNLcc5/X2gj2Yu78hHNIg60AjhTgnc7r5plZqn5fhde5Bh0Npp2qxyYqp/lBiuS/snhldFK1
        K/c6pPb5EJfnMBKN1OHZUEHrFATh+gcREIhum8AispOHfQ79SfhgGlF2EI9UfzgBWMpFRt8XQuAZ/
        rjOIK6F9FfECs1uFAqYCqUYrBDN1EpSIC7q7Obf6yPmP5VPHZMF773OfRZSXGmH7XrG/VJ1nQk+0j
        D/KB/VVA==;
Received: from [94.239.20.48] (port=51144 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjxzy-003XiG-2a;
        Sat, 23 Sep 2023 03:28:23 -0500
Message-ID: <13ed115d-d0ba-f723-ee05-df0da9f56e6c@embeddedor.com>
Date:   Sat, 23 Sep 2023 10:29:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Input: Annotate struct input_leds with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230922175031.work.467-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922175031.work.467-kees@kernel.org>
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
X-Exim-ID: 1qjxzy-003XiG-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:51144
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 89
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJJ58lJBa+br6tLZR0f6EqGBkPaf4diW+LhBJB+IEN1HSzeL8bAgTcwA83zHcPqvXzIPCpaeyH7O3qat2hGzyr+Zestz/ZThIHHy307XJlRJCT15hkUF
 1VFo0JVtNBZXCzFLsLISfa4kx70WaAwB1UH2jleJch0flGJeQBugh++PIY3AYNdSJUDvfjDbMxUUnJeCOKy7Mi6oU3MErMP25Oa1nvyKVG6nVL1DUzBD/koj
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
> As found with Coccinelle[1], add __counted_by for struct input_leds.
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
>   drivers/input/input-leds.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
> index 0b11990ade46..0e935914bc3a 100644
> --- a/drivers/input/input-leds.c
> +++ b/drivers/input/input-leds.c
> @@ -44,7 +44,7 @@ struct input_led {
>   struct input_leds {
>   	struct input_handle handle;
>   	unsigned int num_leds;
> -	struct input_led leds[];
> +	struct input_led leds[] __counted_by(num_leds);
>   };
>   
>   static enum led_brightness input_leds_brightness_get(struct led_classdev *cdev)
