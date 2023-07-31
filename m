Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A667690DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGaIy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGaIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:54:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE719A8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:53:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso39393255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793616; x=1691398416;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k4Yh+f6GncnO7wF9Y2cPhaYuIy/Sv6tOpgODNCPb3Ok=;
        b=s4kW1TUzdfGnCNk6aS3NmscVZPyongw/PYbcbe1brXNYm7+RhosdO8udnDygsiCii1
         KKgF7nYJ0iTm2DsT30nC684d+5UhGCCewP4kSsq/XOkKaB3ooMbwes6Hh2M8Pd8Jfsei
         1UIATRNWQz0nnzIU6v67FzCY1epmLYRLTFFDCXWfLOk9G/fG+n54i9nVsM1kDXIfs7ik
         uD5f14OXNc9HxdyCwC4YnJjuD/FlH1mvgaPXor1rBA0fVfy27ue3UMnObTaICXQ8FVIQ
         q57IzV2m8BZU6yg/3mDcCOa/Q91hEUoghnWP9E3/L3qhGIVh1kV61gzH6K/dZuGEqeDZ
         Vp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793616; x=1691398416;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4Yh+f6GncnO7wF9Y2cPhaYuIy/Sv6tOpgODNCPb3Ok=;
        b=CFH5KDXTt91MtrhzzSX5/lkCS8Nlv+wSAcL8T24x4zgnXDKjD1gp54lgD5Rx3qiS55
         N6fxbO/6P9U7jT7jAF1Wrn75G8dgtN4DyvAbZnrpVT3Um27oGC538onpurWvpoTVngWD
         2L1QyREUSC/Tl0+HuOs4RADeandVGwfMSFgglkMUlx2cmUmhy/+weLxDmOVypGmECFWW
         UbDJj1H6vWp2rqtIkO+rUrgqk+yoB9QoqtOoZzB9AKYaQWCWdybtfv0PiApCTN+7cfVj
         9BhvSHBhK+X7pGLswm/FufHQMgWtdxisr8FzF6ngbN+ognatIxe0Ry4JswRWb1o47c4q
         P88w==
X-Gm-Message-State: ABy/qLaI3kqfvQt5sWXg17anuIDZMCI6l9HvAIG8+WQaQ/tvdvJi22pm
        M9iJ7M1gcyJf8twUsqK/k94Evg==
X-Google-Smtp-Source: APBJJlFkdi6dFIFk3K8ltMzX+mCMt0AqSuU5XaQhLYuJYJ0ZiNsU1f7D54DBojjArL1sPd5fOxBC5Q==
X-Received: by 2002:a7b:c019:0:b0:3f7:f584:579b with SMTP id c25-20020a7bc019000000b003f7f584579bmr6621217wmb.9.1690793615976;
        Mon, 31 Jul 2023 01:53:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003fe1e3937aesm3399576wmi.20.2023.07.31.01.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:53:35 -0700 (PDT)
Message-ID: <8a8ea225-3730-20cf-9ad0-46fbd6e5f5bb@linaro.org>
Date:   Mon, 31 Jul 2023 10:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] soc: amlogic: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714175124.4066972-1-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230714175124.4066972-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 19:51, Rob Herring wrote:
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
> ---
>   drivers/soc/amlogic/meson-canvas.c      | 1 +
>   drivers/soc/amlogic/meson-ee-pwrc.c     | 3 +--
>   drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 3 +--
>   drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
>   4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
> index 383b0cfc584e..b6e06c4d2117 100644
> --- a/drivers/soc/amlogic/meson-canvas.c
> +++ b/drivers/soc/amlogic/meson-canvas.c
> @@ -8,6 +8,7 @@
>   #include <linux/kernel.h>
>   #include <linux/mfd/syscon.h>
>   #include <linux/module.h>
> +#include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <linux/soc/amlogic/meson-canvas.h>
>   #include <linux/of_address.h>
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index f54acffc83f9..cfb796d40d9d 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -4,13 +4,12 @@
>    * Author: Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
>   #include <linux/bitfield.h>
>   #include <linux/regmap.h>
>   #include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   #include <linux/reset-controller.h>
>   #include <linux/reset.h>
>   #include <linux/clk.h>
> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> index 5d4f12800d93..33df520eab95 100644
> --- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> @@ -5,13 +5,12 @@
>    * SPDX-License-Identifier: GPL-2.0+
>    */
>   
> -#include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
>   #include <linux/bitfield.h>
>   #include <linux/regmap.h>
>   #include <linux/mfd/syscon.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   #include <linux/reset.h>
>   #include <linux/clk.h>
>   #include <linux/module.h>
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index 25b4b71df9b8..b994f03380b0 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -7,7 +7,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
>   #include <linux/io.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
>   #include <dt-bindings/power/meson-a1-power.h>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
