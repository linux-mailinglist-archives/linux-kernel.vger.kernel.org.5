Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF627690CD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGaIwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGaIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:51:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F525172B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:49:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so7598725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793349; x=1691398149;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h7W7YYE2gaBdXvF1/lo7GyDdBy4PWSaCW0nMcp8S290=;
        b=tIPMOZHWC/DCPEOLEvFVLcVItIT0QU/S+4xWkQBcCZ9q7l6eNLELl5hlVuxn/dCxI8
         ls0wK4RTi4m9/MnIcNx1cHV2lgaT9N51vwuHBqSWO7oebJGnUlc50+4QPtwN464XLYn8
         J0MX6/ACCl7PMroV/sKIga+urSCV46HQVKBuGQ/DOwxI5CLCB++K3aHrN9g3ehJMZ0VI
         DQUMmwywvWd9EyHscsVVDwfnLo5R4b/IRTIUWnzDAWUVHet9J+w3jM5tGB6f/ykWg5OR
         R1d6jNIukr/g/kTSD7xsiK5cL9kQhRXNaDTmwUaW47DI0dJ8N5cgoRvhGGt0SAPUVJWA
         5k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793349; x=1691398149;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7W7YYE2gaBdXvF1/lo7GyDdBy4PWSaCW0nMcp8S290=;
        b=aTtKORN/xB/AfgFQ2E9QR+uFSufYRkAJRhsmvHbV9qx40t5QdBq6Odf+1fu85vVP/z
         cmR066YyXcBnwaW6yPu2mujFzRbQYUCce4ZCAv3yp3woPCM+zkbPLA3WFx7z6N+8CplA
         A13Tl9F/AJCrk0qcTf9hwvHwLsWy2ij1bxQ5sMQpz4dkUQ+xwTCACvvhs72tSl1iaoSG
         Keza52nu6q+Z5vfQQBB0/M/Kpfc3kPT3D+HsK0ytGWbRHEvLod9DtAhV2Q9DuVUF5siT
         LRbjC5U1vFpzLOFUbrNGGwM1ERdtVsWjG9EDNMSXMbMc1usMsHKN6IOHDqW1O8Qf7MJU
         mgNw==
X-Gm-Message-State: ABy/qLYx1Jlf/iRK6WyaJYBtCXPmJxJvAd7wxInfRVNLrsn3q2HLYacT
        zsAs94tL/Lx5zQ9gt3pGT1dC5Q==
X-Google-Smtp-Source: APBJJlEzjzzfHPdjAO4t1hPBRUhwt15TSOFm9fPyDYFdX2mgRKf7NwRsU4/mLyv8fkkRD5Pq6zI4Lw==
X-Received: by 2002:adf:f611:0:b0:315:9ee6:132f with SMTP id t17-20020adff611000000b003159ee6132fmr7441633wrp.68.1690793349307;
        Mon, 31 Jul 2023 01:49:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d68d0000000b003140f47224csm12339740wrw.15.2023.07.31.01.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:49:08 -0700 (PDT)
Message-ID: <691102a4-e920-ef88-3c5b-8240b8f87c5b@linaro.org>
Date:   Mon, 31 Jul 2023 10:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 0/3] Add binding header file for GPIO interrupt of
 Amlogic Meson-G12A
Content-Language: en-US
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, martin.blumenstingl@googlemail.com,
        jbrunet@baylibre.com, khilman@baylibre.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230724060108.1403662-1-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 24/07/2023 08:01, Huqiang Qin wrote:
> After adding this binding header file, you can intuitively find
> the interrupt number corresponding to each GPIO, and apply it
> in the format of IRQID_XXX where it needs to be used.
> 
> Associated platforms:
> - Amlogic Meson-G12A
> - Amlogic Meson-G12B
> - Amlogic Meson-SM1
> 
> [PATCH 1/3]:
>    V1 -> V2: Rename irq-meson-g12a-gpio.h to amlogic,meson-g12a-gpio-intc.h
> 
> [PATCH 2/3]:
>    V1 -> V2: Include header file changed to amlogic,meson-g12a-gpio-intc.h
> 
> [PATCH 3/3]:
>    V1 -> V2: Include header file changed to amlogic,meson-g12a-gpio-intc.h
> 
> Huqiang Qin (3):
>    dt-bindings: interrupt-controller: Add header file for Amlogic
>      Meson-G12A SoCs
>    pinctrl: Replace the IRQ number in the driver with the IRQID macro
>      definition
>    arm64: dts: Replace the IRQ number with the IRQID macro definition

What's the best way to apply this patchset ?

Thanks,
Neil

> 
>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   1 +
>   .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   2 +-
>   .../dts/amlogic/meson-g12b-bananapi-cm4.dtsi  |   2 +-
>   .../boot/dts/amlogic/meson-g12b-bananapi.dtsi |   2 +-
>   .../amlogic/meson-g12b-odroid-go-ultra.dts    |   4 +-
>   .../dts/amlogic/meson-g12b-odroid-n2.dtsi     |   2 +-
>   .../boot/dts/amlogic/meson-g12b-w400.dtsi     |   2 +-
>   .../dts/amlogic/meson-sm1-a95xf3-air-gbit.dts |   2 +-
>   .../boot/dts/amlogic/meson-sm1-bananapi.dtsi  |   4 +-
>   .../boot/dts/amlogic/meson-sm1-h96-max.dts    |   2 +-
>   .../boot/dts/amlogic/meson-sm1-odroid.dtsi    |   2 +-
>   .../boot/dts/amlogic/meson-sm1-sei610.dts     |  12 +-
>   .../dts/amlogic/meson-sm1-x96-air-gbit.dts    |   2 +-
>   drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  35 ++---
>   .../amlogic,meson-g12a-gpio-intc.h            | 126 ++++++++++++++++++
>   15 files changed, 164 insertions(+), 36 deletions(-)
>   create mode 100644 include/dt-bindings/interrupt-controller/amlogic,meson-g12a-gpio-intc.h
> 
> 
> base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252

