Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316E975DB46
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGVJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGVJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:20:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23642D4A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:20:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so24190035e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690017616; x=1690622416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKA/fSK1OrrWeVKEuVTJol/wBIFA9VP5bSnux5wICog=;
        b=YjZdWI+kciadukrVxFxWcFo2aGcqrVCODXUFim3vhrf3EKtCViolaPQXjj3bfTYg+G
         yenm0FN952WoCevkNkj5surKcradV6NMXorPKO4JVkXqFQfr24at27NvQuqFt27X8gGy
         Mqqaa8zRwS7NdwD3h/W9HPwuQEa7/KFzsT60Ldvzin1wmpo/chkg+pO46UPJBqACBf9T
         DkGui4jpagBiLnYG9HQTouivzJcHxmybd3V9qnwJbGQs7W/Da84rF99eUoZC06OSV4Jr
         cBrfne5M4kj7zrNDP3p8zSH9Qr5JGQvf6GnpdTytT2MuEvO1u5ZoGIZJspRa+HdXypEs
         B+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017616; x=1690622416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKA/fSK1OrrWeVKEuVTJol/wBIFA9VP5bSnux5wICog=;
        b=cBmfQd9eUgXdsw9gl2AMunV209Ky8fRTSDpAaqbHXZtcadRyWB1VWKeO8SYOrGBu2R
         5aFPIlj3p3s2uANj34vlZSJ67agec64+W/vDngr03emqJUWzPJz03dGWTl7C2xCrn8Xu
         ttLBKUr8RAq85V3K/aPgqWez/8YM/LqBxAQR6/7MeTs484XLrGKbmGczh+vHn8bURwtp
         f0nlTrE4r1LVyj9C9XEJvX3Tf9gGSOeMwV1pQF4O+Ou9dBfBUXdv9ZllVfvPn5eJucWM
         Q0HKiQXD0i8sCNrN4VwJ73YcwaDH6npcfEaOv6eKyAPIA8MRWa506gFrbg6cbkQoVkBw
         pojA==
X-Gm-Message-State: ABy/qLZmXslinUnpIe3LTJhSdHrPWaum+9c+8Bk42g5kjAz6Hq22Vrz3
        ggqE4Ao4u0lmh9TZ77ZNva1MXg==
X-Google-Smtp-Source: APBJJlGqGajANN85V+QyZ+Cb8nzGIbt9uqS2/bG27rvwKaRP64KNNFfMjaIp1YTbbwFeOP0JefmsCg==
X-Received: by 2002:a5d:58da:0:b0:313:ef24:6feb with SMTP id o26-20020a5d58da000000b00313ef246febmr3872494wrf.3.1690017616419;
        Sat, 22 Jul 2023 02:20:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n8-20020adfe348000000b00315af025098sm6426333wrj.46.2023.07.22.02.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:20:15 -0700 (PDT)
Message-ID: <a4b789ad-0505-1991-2005-c1825a1f3b60@linaro.org>
Date:   Sat, 22 Jul 2023 11:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] arm64: defconfig: enable Qualcomm SM6115 LPASS
 pinctrl
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230722-topic-6115_lpasstlmm-v1-0-32d1643d8774@linaro.org>
 <20230722-topic-6115_lpasstlmm-v1-3-32d1643d8774@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230722-topic-6115_lpasstlmm-v1-3-32d1643d8774@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 10:52, Konrad Dybcio wrote:
> Enable the Qualcomm SM6115 LPASS TLMM pin controller driver for
> providing GPIOs/pins for audio block on SM6115 based boards (e.g.
> QTI RB2).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6cbf6eb59378..6911101db09e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -587,6 +587,7 @@ CONFIG_PINCTRL_SDM660=y
>  CONFIG_PINCTRL_SDM670=y
>  CONFIG_PINCTRL_SDM845=y
>  CONFIG_PINCTRL_SM6115=y
> +CONFIG_PINCTRL_SM6115_LPASS_LPI=m

After recent re-shuffling in Kconfig, this will be placed differently
with savedefconfig, so maybe better to find proper (new) placement for
this now?

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

