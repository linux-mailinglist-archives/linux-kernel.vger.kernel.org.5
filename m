Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA07549A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGOPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGOPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:11:52 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941330DC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:11:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-346129c9512so6465645ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1689433909; x=1692025909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9XlpRMNdAAEFImKOS7TDT4umEsjSeY77+bJ4P1MRe8=;
        b=KpbiwA9NRF8+W6tdUk7oAEajedYliLcT3fLwx1hKWNPafETFpJG9nnPmhVRp1UdI1a
         ec9mVwfBesk49WkdsrPfeQTQNowRCIhbKJuP16XD7dO7TZekJ8yDxNsj6kgUO5dmVinN
         O/xItmOPmt9BnCnKdfjfmpm5zf8eizKb7wHPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689433909; x=1692025909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9XlpRMNdAAEFImKOS7TDT4umEsjSeY77+bJ4P1MRe8=;
        b=ZxSVpV1f+GDUOo6aj1JruaP3mNOOvrAMf7oPYNSieD77s1QSnii5y2uhGC6E6fc+gV
         /vN16NSaQ+xCtI5l1woUSwPGOO+Io8YgNJJNlF2NEbffJhW9pKUvVGn6rtC8FCngUXrl
         NCV2Bzilx6ajuVJPYL/ix4ATxi04czqN5/yBbfvgEEeb0jYD2FbwZg50YQLmM8ZkMXGV
         Ihv1X7NzcbW1NLj+mwE0c1q3oOUJsaMPp8Qct8jGLZ0xXaC3w3C3U8sPUdiMWiQO4aQt
         Is9vE6DzfQRVEt3e7MdEUmhcri6D2H7cm6mOIkqj5o/4i66W2u5uEG2cDaPPU61xOFi1
         wu3w==
X-Gm-Message-State: ABy/qLZ+9Unsqi7V5ui6+ZXFLawzp3X3obXvHH14zGsCwZ7uNcZaVToH
        5eJIWcyVvTiJYO/8SGbRjyH3xw==
X-Google-Smtp-Source: APBJJlGJVqbBu5lKEA54CgyQF24n/fOTJfhIYz9w3XH4VGOvH3KCmWksDsEmgsEiSCeG83sO26Hgmw==
X-Received: by 2002:a05:6e02:1148:b0:343:ef5e:8286 with SMTP id o8-20020a056e02114800b00343ef5e8286mr3847417ill.7.1689433909634;
        Sat, 15 Jul 2023 08:11:49 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id f8-20020a056638022800b0042b2959e6dcsm3321388jaq.87.2023.07.15.08.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 08:11:48 -0700 (PDT)
Message-ID: <1c6175fc-496a-843c-c8c5-2173e065eaa8@ieee.org>
Date:   Sat, 15 Jul 2023 10:11:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amlogic@lists.infradead.org, linux-oxnas@groups.io,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-wpan@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        wcn36xx@lists.infradead.org
References: <20230714174809.4060885-1-robh@kernel.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230714174809.4060885-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 12:48 PM, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

(I significantly reduced the addressee list to permit the message
to be sent.)

For "drivers/net/ipa/ipa_main.c":

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/net/can/bxcan.c                                 | 1 -
>   drivers/net/can/ifi_canfd/ifi_canfd.c                   | 1 -
. . .
>   drivers/net/ieee802154/ca8210.c                         | 1 -
>   drivers/net/ipa/ipa_main.c                              | 2 +-
>   drivers/net/pcs/pcs-rzn1-miic.c                         | 1 +
>   drivers/net/phy/marvell-88x2222.c                       | 1 -
>   drivers/net/phy/mediatek-ge-soc.c                       | 2 --
>   drivers/net/wireless/ath/ath10k/ahb.c                   | 2 +-
>   drivers/net/wireless/ath/ath11k/qmi.c                   | 1 -
>   drivers/net/wireless/ath/wcn36xx/main.c                 | 3 +--
>   drivers/net/wireless/intersil/orinoco/airport.c         | 2 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c         | 1 -
>   drivers/net/wireless/silabs/wfx/bus_sdio.c              | 2 +-
>   net/core/of_net.c                                       | 1 +
>   124 files changed, 110 insertions(+), 120 deletions(-)

. . .

> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 6a2f2fc2f501..da853353a5c7 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -13,8 +13,8 @@
>   #include <linux/firmware.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/of_device.h>
>   #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/firmware/qcom/qcom_scm.h>
>   #include <linux/soc/qcom/mdt_loader.h>

. . .
