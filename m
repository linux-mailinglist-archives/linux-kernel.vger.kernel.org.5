Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214FE76918D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGaJWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjGaJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:21:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADD171A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:19:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdf08860dso777126566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795180; x=1691399980;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLlv/2g+8YJBVDyaSbIDe/tbW/4jcVh261aoxn4jYFg=;
        b=b5bGdqK85r6R18cpvUplg8qwBPV7uvlxNrCQu1TcDpI+/pX8pwx0LwFlojFPnPhDvc
         8Wo+ZAInZ2684b98m8PZHJIRIhZpuX8mEa5eimmK7qr7qjWB/9hcd0pDf2vDtVpvFyCI
         KhdRerGOQg/eCuHhdhx8qE3LP7zpJeVEd//iuJV4t0GI204Bvg4WmKj/2HMaBN7/UfKM
         Fg2wnsnNLl7uyxSoctOpkj8rnft+eZg1qF4K0UzY/CHceLeGZE8B2QDZWNf3/a8ST2ww
         RcGrqYkyO2SJ5Yr65oeun2CII7QdMYTyDDgpHtWI/WXUYSsl+QT6/dp5j+MK4V27opgF
         iqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795180; x=1691399980;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLlv/2g+8YJBVDyaSbIDe/tbW/4jcVh261aoxn4jYFg=;
        b=Jsw6YAODYj++IpM3PBxbbbVCE7KNS2IyhjuVTZs8vud5CsNcKbIo7r4UaP3nfZXTaE
         LgDA7haP6azFi92cXAScHNwq809FzN/cEZEyhhkQ5/UYEm/uGC0yFEq8izlsw6Lcynrh
         4mkkFDTgbDCV3/r3YCiCIlbXq3IhM8w9FvCfhLMFtYIQvgxigCuV2GPxrlarDEZ3NoCZ
         vkT3AmpvOPZogodKEnvVTuevA/c5+qbC7rekTrzi5sDVssfWwleXIwMCT1EFZVeN38DL
         5mqxqWVdtXlfvgT/ASU9MDCp4xtC65gQV5UmCB+FQfk4tcLiRRUgeHFtc+qJotP9utVB
         hlsA==
X-Gm-Message-State: ABy/qLZjJp4l5Em8sps3RBH1T67kY45xy4npsGXVMYpYOde6+UFnCZ2q
        GELm+p1x+lQpVaXgd+tP1gu/c5xZb94UuOpaG8Y=
X-Google-Smtp-Source: APBJJlGlo3yNJtkZt5VqMPUJ/KLVLigOGOukwoiMhJSC7gBUFtSIr5vZ8gmsj6DC0NEk4HBVWFJCmA==
X-Received: by 2002:a17:907:7f8b:b0:98d:f2c9:a1eb with SMTP id qk11-20020a1709077f8b00b0098df2c9a1ebmr7608208ejc.24.1690795180377;
        Mon, 31 Jul 2023 02:19:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906089a00b00992ddf46e65sm5839311eje.46.2023.07.31.02.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:19:40 -0700 (PDT)
Message-ID: <273bd185-4aa5-510f-0f1d-1a4cab2d4a2d@linaro.org>
Date:   Mon, 31 Jul 2023 11:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: drop redundant
 status=okay
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230731090442.100856-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731090442.100856-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:04, Krzysztof Kozlowski wrote:
> status=okay is by default.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 1 -
>  1 file changed, 1 deletion(-)

I found few more...

Best regards,
Krzysztof

