Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12A768FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGaINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGaIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:12:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027AB30D4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:09:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso61122251fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690790941; x=1691395741;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZMPq1Vq9+aiEXvy60benY4O8ZQ7ZziRieqMJ71TkNY=;
        b=r80IGWpakAO1kcNvP4errkyd0Z67dJz0N+u2Mb+NCpiXTcJZnFlp4WH3/MWAwk3n6D
         qP+gJjQscKq8VBBLvHaanb7evARPzOhjdNo51Ie2Ttv2yAPBW6XDZB2mwWWKhbb7eqEN
         yuXNT5RdcDNuq0Nc+vU0g8fn37iUa8aYAf3/7NBddvwkkYMNc5ypSM2oQNgS7gLrxepC
         u1q80apdwld9SnqjDP0gaP4Bk0e/yhYQiZy0IDaS/d2gl33SWYMQvpmmefxfyB7HbiWl
         Kl2W/XW9zi31RXEDLWiPVLoR5gM1b78fLVBl0XB6jF6M74oc9cRcRJD0PZCxzKrLx2s0
         hJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790941; x=1691395741;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZMPq1Vq9+aiEXvy60benY4O8ZQ7ZziRieqMJ71TkNY=;
        b=OvNAHOgizXMlLkED2EMX8LdxIBwOMTDTG4DLOxF5qXZx4qiYdr4Zv+4MrZJHpP+Ggn
         gnBuxyyHAV3B9kshr2lH9Kl7BUh6AGrvXu1Y487V+WgaZ8UvcrAvlnPeyxYHM/bsJU4e
         lMR9bXEKITqlMqFPhHqN0hLHQ/cEeawyTME1pCGvvmV/TwXiV15zFZSWlAnRbKXnTc4O
         gxCxyDjBLyKiJwOYLoVsIEM+HGj3FPKvvonmpmoOF/hQO5t0YUXC6BUhGaWQ+fAELbkS
         bWYWic0Hz32bnb8v563RmMHbTIzsBH95prim1GHmlwZX6fqqREWQwSF70a9kgoS67D/x
         sBrA==
X-Gm-Message-State: ABy/qLY3cW2zHzv+FB3960XqwsCaUYjhuFFdj2ev5P0UHgMD6BoGQMFq
        goS1WxHSMCqqMMlvjQvc6LTK8Q==
X-Google-Smtp-Source: APBJJlHoFNF+VGM3nk8XWKZer/sRmq1LlXeWOg6YkoYrxxXqLbMy6VRkmFl6789offjMZK/t/P1/lw==
X-Received: by 2002:a2e:9e89:0:b0:2b9:cddc:adeb with SMTP id f9-20020a2e9e89000000b002b9cddcadebmr5190141ljk.29.1690790941185;
        Mon, 31 Jul 2023 01:09:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id l13-20020a1ced0d000000b003fba2734f1esm13336442wmh.1.2023.07.31.01.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:09:00 -0700 (PDT)
Message-ID: <50935d75-bed6-4919-70fc-adcaba6a30a8@linaro.org>
Date:   Mon, 31 Jul 2023 10:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible and DT bindings
 for Amlogic C3 Reset Controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        zelong dong <zelong.dong@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, kelvin.zhang@amlogic.com
References: <20230719060954.14864-1-zelong.dong@amlogic.com>
 <20230719060954.14864-2-zelong.dong@amlogic.com>
 <f7b72ee90009f6749700a7bd79a3a63786a82a32.camel@pengutronix.de>
 <68b7d772-8dc4-a781-031b-ea33dae41751@linaro.org>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <68b7d772-8dc4-a781-031b-ea33dae41751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 18:40, Krzysztof Kozlowski wrote:
> On 28/07/2023 17:49, Philipp Zabel wrote:
>>>       maxItems: 1
>>> diff --git a/include/dt-bindings/reset/amlogic,c3-reset.h b/include/dt-bindings/reset/amlogic,c3-reset.h
>>> new file mode 100644
>>> index 000000000000..d9127863f603
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/amlogic,c3-reset.h
>>
>> Given that this is only included by
>> arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi, should this header be
>> moved to arch/arm64/boot/dts/amlogic ?
> 
> I think there is ongoing work or at least plan to use the IDs also in
> clock/reset drivers for all Amlogic platforms. Do I recall this correctly?

Yes the header is used in DT and the driver, so it's in the right place.

Neil

> 
> Best regards,
> Krzysztof
> 

