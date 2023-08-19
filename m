Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32EA7819F6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHSOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjHSOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:21:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D643EB24A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:20:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so2940177e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692454824; x=1693059624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0onguFDScQ28yFTMt4lAsObdKSDFfD8I7t+EctKHSg=;
        b=rd7t09SLqd64aFO6Kijj17CqNF5ymQI2PAWj2iCsjKMiAzR8N6H88qyiCiJekpIk5+
         /8UqWGyJIEsQRdwqxO9k9goNb6Zl7CjrfnXcjn13zHUoPpS7TZ2sDmQ3RpQI6fPWoPt9
         k9KzcnvyW+ca8xVKp6ZSGESuM53YcTCwEiaWSlbr58fJ96PyX11UhQJIYOhHTPNC7SHr
         Myh6VH7Sx0WZUoLgpjBPvT9VhRZQhf47qBUfZyDHmPl4pFdsjMyNpfcLIelghQpvHG8I
         hRF95eOv8L+FXOlK0qKJSTQ1yRxSpeOMY3bwAzQKq/DENBZnHiVXPn/fU8rrV2o4Fc8I
         0ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454824; x=1693059624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0onguFDScQ28yFTMt4lAsObdKSDFfD8I7t+EctKHSg=;
        b=WV6FEGG5B2n0rwV8HkC4aYC8INtRQGquQcR3pAdKoYMaALFZrwBPyHgDlD6C6qEPs2
         aux+JkBOEcBPFX41ypJHoykuiWW+kwEh5p5/dj3Kob0nzAFwZT+armLf5Ox0h8C6nC0c
         v9KnfM9dRYo5jG66ACQGeMO2tiBDB1Obvwxk5Frtf87g4ZlkqUVkbdrBhcNRcmA5ehtY
         yPZqBk7Gnym3VSVDLtPEJTdBbAhXGoPt9f3hkvpwq5loVVSW03UIQmSO1RN7PQ3h+EcX
         jM6qQDALFoOWm8dw0uCBdHJuSC66se+mGpS8A1yt5/Hl7x1fR2ROuQSg5YHvW9pQFLVE
         aHqA==
X-Gm-Message-State: AOJu0YzHwBVV+V0jd0jriUs8CkcO93hKify2dzPvEUt9c/Y6NqrmgewF
        0PAsxrWqLoixYbZ10gxAhP4Zww==
X-Google-Smtp-Source: AGHT+IFqpjzQHVRcvUzSqexrAEcVN+laiPOBWxI+WHEn/Fkt4YQ4N9aeescuFTLbC/S4clcsiGzhaQ==
X-Received: by 2002:a05:6512:159a:b0:4f8:6e52:68ae with SMTP id bp26-20020a056512159a00b004f86e5268aemr1661887lfb.31.1692454824065;
        Sat, 19 Aug 2023 07:20:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d0c9000000b00523a43f9b1dsm2570080edo.22.2023.08.19.07.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:20:23 -0700 (PDT)
Message-ID: <a2e18e03-a50e-897a-b599-f3b6bfa6af88@linaro.org>
Date:   Sat, 19 Aug 2023 16:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/6] dt-bindings: power: add Amlogic T7 power domains
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230817071148.510575-1-xianwei.zhao@amlogic.com>
 <20230817071148.510575-5-xianwei.zhao@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230817071148.510575-5-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 09:11, Xianwei Zhao wrote:
> From: "xianwei.zhao" <xianwei.zhao@amlogic.com>

> @@ -21,6 +21,7 @@ properties:
>        - amlogic,meson-a1-pwrc
>        - amlogic,meson-s4-pwrc
>        - amlogic,c3-pwrc
> +      - amlogic,t7-pwrc
>  
>    "#power-domain-cells":
>      const: 1
> diff --git a/include/dt-bindings/power/amlogic,t7-pwrc.h b/include/dt-bindings/power/amlogic,t7-pwrc.h
> new file mode 100644
> index 000000000000..b7a13eda563c
> --- /dev/null
> +++ b/include/dt-bindings/power/amlogic,t7-pwrc.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR .*) */

This does not look correct license. Use one recommended by checkpatch.



Best regards,
Krzysztof

