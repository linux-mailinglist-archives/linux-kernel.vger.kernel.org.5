Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398477A2870
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbjIOUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbjIOUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:47:16 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559572D51
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:46:53 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id h8dTqODdmWU1chFiHqTfxF; Fri, 15 Sep 2023 20:46:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFiGqaee8KPGkhFiGqwDiQ; Fri, 15 Sep 2023 20:46:52 +0000
X-Authority-Analysis: v=2.4 cv=Aur9YcxP c=1 sm=1 tr=0 ts=6504c2bc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QX4gbG5DAAAA:8 a=l0hiEBf7AAAA:8
 a=QyXUC8HyAAAA:8 a=JfrnYn6hAAAA:8 a=cm27Pg_UAAAA:8 a=qjWHau5h7Oqj65Zv8QkA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=ynCB8LqupOr-u-Kv-6Up:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+yXEUbam3ZE5YDXyhgQVpOQnERY8L95N3GOx4Xs5rzU=; b=mR3cT3YE+Pnbwo/mWQ0ePc2YJc
        q7K30d4QGhIqvgClLrXAP42qg+9wNZ53ynuemEw473MEYOUGam9x92GCK7n5ee5sI4cM46O2wRAs5
        9qNnY5hYX3d0o96cf1pMUAO1/KLKROtStuDzRAo0yVUvoOGMp/9GulfP6QotP02eRLgJ2E1EZK9Wj
        UeaSUnVXnesC5O/G/modRkZYr1gnM2zBDG07ynjLtQeGVaZMLIQs9q2rCJPQbE/IW8Duei5LTPXTB
        hsync8r48EFd7UWnMrkR0UkMjTJhOFf/Xm/e73FtEyodpdKtD+RkD66ppSGZCGdTD8uPGxHXe3KHd
        7egr4hnQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38348 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFiD-002bKA-1Z;
        Fri, 15 Sep 2023 15:46:49 -0500
Message-ID: <f6421279-e2a6-8ad5-cc46-0b292eb1223d@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:47:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] leds: mt6370: Annotate struct mt6370_priv with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alice Chen <alice_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        kernel test robot <lkp@intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201051.never.429-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915201051.never.429-kees@kernel.org>
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
X-Exim-ID: 1qhFiD-002bKA-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38348
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 252
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFSYz1hnNqEQyNj4N9ZqaF7wRdkLxoggMSEUNcMW4APu+J5On8ouROoPl6zuLjtaFBqbV/NcyD96/WvwYG0o7dIe+lSlNGszQ6Y3u/UMZTMu3+ECWAxE
 9zzmhfDtsx2LcNQFRRbf2Z3FZjpHxRZHNtj4CXjO2IHTLuCsD/MSyVSu02ZAQmQNKzeAlUGAKwDh8C9z0rArI0Nph/I0Ayvc6V9c5/6Pd6aAiJ749e19DB9H
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 14:10, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mt6370_priv.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Alice Chen <alice_chen@richtek.com>
> Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: ChiYuan Huang <cy_huang@richtek.com>
> Cc: ChiaEn Wu <chiaen_wu@richtek.com>
> Cc: kernel test robot <lkp@intel.com>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/leds/flash/leds-mt6370-flash.c | 2 +-
>   drivers/leds/rgb/leds-mt6370-rgb.c     | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-mt6370-flash.c b/drivers/leds/flash/leds-mt6370-flash.c
> index 931067c8a75f..912d9d622320 100644
> --- a/drivers/leds/flash/leds-mt6370-flash.c
> +++ b/drivers/leds/flash/leds-mt6370-flash.c
> @@ -81,7 +81,7 @@ struct mt6370_priv {
>   	unsigned int fled_torch_used;
>   	unsigned int leds_active;
>   	unsigned int leds_count;
> -	struct mt6370_led leds[];
> +	struct mt6370_led leds[] __counted_by(leds_count);
>   };
>   
>   static int mt6370_torch_brightness_set(struct led_classdev *lcdev, enum led_brightness level)
> diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
> index bb62431efe83..448d0da11848 100644
> --- a/drivers/leds/rgb/leds-mt6370-rgb.c
> +++ b/drivers/leds/rgb/leds-mt6370-rgb.c
> @@ -153,7 +153,7 @@ struct mt6370_priv {
>   	const struct mt6370_pdata *pdata;
>   	unsigned int leds_count;
>   	unsigned int leds_active;
> -	struct mt6370_led leds[];
> +	struct mt6370_led leds[] __counted_by(leds_count);
>   };
>   
>   static const struct reg_field common_reg_fields[F_MAX_FIELDS] = {
