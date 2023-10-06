Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0E7BC2C7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbjJFXDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJFXC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:02:57 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07B59C;
        Fri,  6 Oct 2023 16:02:55 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id opcDqGeq1aLCxotqQqoZrt; Fri, 06 Oct 2023 23:02:55 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id otqPqgORYQ8G7otqPq0rIT; Fri, 06 Oct 2023 23:02:54 +0000
X-Authority-Analysis: v=2.4 cv=M/pelg8s c=1 sm=1 tr=0 ts=6520921e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8 a=s4AO8cZySA16zO19rckA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o83qUcTIt6yU4XdNU25hJZ8Y70pA8nqO2bf+akwXYT0=; b=mGXSa+z5OOSy4/zhUqo64iqKQo
        gaehigQh6kK0U9FgMxXrAZJaN46AX/S8uAdRdfyl5nFGnWdWSBK8WA5JvhzLXfGGA0TwHqGjurjeM
        Y9f9xg+Bne7K5vv20AQrO0sdIvNVAOPE2+/d+SU+X0n6WGNzV10/iZ/AuEEgo82rMcd8NznNmPhGQ
        KZmm59ek5xp1tVXsTQEK7/fjHSFg0iha7oqAkPviR/obZOmok1efQRMddYaw9GL9eIf104Z44Fr+/
        Fj/7V+MpYyo29t2HxylOLbqatWMX5k2ao1J8mbOhotmSOfxVfZTI7+s/NsOhdQK7cbCfhGMI5bNp3
        7of811QQ==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qorlt-001Bge-0k;
        Fri, 06 Oct 2023 15:50:05 -0500
Message-ID: <589deebd-fda5-4901-8c1f-869acd08b652@embeddedor.com>
Date:   Fri, 6 Oct 2023 22:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: samsung: Annotate struct exynos_muxed_weint_data
 with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20231006201707.work.405-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201707.work.405-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qorlt-001Bge-0k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEvuItGx7YjxZjV77BzdmamEAcVXbb/2RMIDhftSTw98Xm9fOeOoDiUE7NauZlFFHQ6LFr/aZWPnqUdmwv4G+t9gC+X7h63hHJyttWtB9eUkX0FGJgc2
 psODvHbQIOi8lvTAzwkdPubUZBJF6776vnHY9w5eFNlt7ojYqeL+//OH0YVvrBQHcS2KZ2wmGLX+pKREGdHGFYOhxALuUSrZTXn1v7LVMKDy87WcyCfaaVcK
 akHMQg8Idf9GGEuEIpfs2H64KLnw4p14q+gbhkQkgPGhbARQTRu+zRzG5UuEvhPboTwYr5UNOXCf5q5CCsSx7zvUfnx3alCX7shrEffpRFrKGCxU8YNMkeUd
 jnnjHVlm
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/23 22:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct
> exynos_muxed_weint_data. Additionally, since the element count member
> must be set before accessing the annotated flexible array member, move
> its initialization earlier.
> 
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/pinctrl/samsung/pinctrl-exynos.c | 2 +-
>   drivers/pinctrl/samsung/pinctrl-exynos.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index a8212fc126bf..6b58ec84e34b 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -616,6 +616,7 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
>   		+ muxed_banks*sizeof(struct samsung_pin_bank *), GFP_KERNEL);
>   	if (!muxed_data)
>   		return -ENOMEM;
> +	muxed_data->nr_banks = muxed_banks;
>   
>   	irq_set_chained_handler_and_data(irq, exynos_irq_demux_eint16_31,
>   					 muxed_data);
> @@ -628,7 +629,6 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
>   
>   		muxed_data->banks[idx++] = bank;
>   	}
> -	muxed_data->nr_banks = muxed_banks;
>   
>   	return 0;
>   }
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
> index 7bd6d82c9f36..3ac52c2cf998 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.h
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
> @@ -159,7 +159,7 @@ struct exynos_weint_data {
>    */
>   struct exynos_muxed_weint_data {
>   	unsigned int nr_banks;
> -	struct samsung_pin_bank *banks[];
> +	struct samsung_pin_bank *banks[] __counted_by(nr_banks);
>   };
>   
>   int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
