Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2289D769178
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjGaJTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGaJTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:19:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4DB2686
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:17:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so2856238f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690795040; x=1691399840;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2uk953bwdNMqiO0gx9LYl/Ku1cESFMXCc6kgn3JBlzs=;
        b=RitRb5x6yrY3zDVwThstz0r1jBGbUKjoq96xlvK2GCxyjXNkWC0zoLPqiTPdYiS6Ql
         kHT2Mrx5JoxNvAw7R4jScAqIQQipr5xup2zJo509BmVZ788PbGsGmdSgx1Sh6J1R3H6Y
         aJ/+m0ThBiG5CqzZ+8m8ilv8s8y4K09Uoa+6B3OT2QG8InOiS16au5A34m8fl8+sE5cd
         r75urDO8NgoYVUWgKWZmIqecwxywqohImNjhm2Q93Iq+Ja/wqhaUu/ZSnRGwoFKaihN+
         Myr9GW92aljS9Wr6dbmB3Fgu47rx7CTx77dF+9L6/sNDV5SEbucw5njS1kDZVZ5Fln9h
         Aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795040; x=1691399840;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uk953bwdNMqiO0gx9LYl/Ku1cESFMXCc6kgn3JBlzs=;
        b=TQ5/JGLcd16piObzN8OIBT/+SvJ9dTLEic2TW/fSMER+jSRprnuoOUFdb85LIO7NDt
         vYHkBN3lOlgmBY6h9exJZl7vfq/kW7FAFH3GhJIUSKazMnEKL3NV8upztLHTl9PHr3FY
         WagYBi5mKjovmO3HNCaB1ttV3C0++0+Mc4bZC2Fql2TQxlQJWWV6O5KpM2nZIx11MsVE
         jznYNPAHJxjuIwrmJ56fbhi3ujMCYtvAWQa6QrBCU9ebQ14k+bqqEB98WW/7zMkwyLHq
         iTHvYoAoiOfOeYUK7L9qYxQWogOQsJmT3NpD+RNY+VAhvdaTPbDyD/+eXX1s7S04THfa
         dEpA==
X-Gm-Message-State: ABy/qLZMlRutiNhfprEIAoDKSBPuBj94MBRYuooahzu6ew9icOnkzD9v
        ReGWU2PP1gnrH70S/Nu7gjJX2g==
X-Google-Smtp-Source: APBJJlEDuxdvkuBlHEz6xcvCQ5+HTQ85ImfVu6HCehgYysTS6a2nnl6hBozXYDb3bPdGWagF6HSMJw==
X-Received: by 2002:a5d:4687:0:b0:315:a32d:311f with SMTP id u7-20020a5d4687000000b00315a32d311fmr9453837wrq.14.1690795040271;
        Mon, 31 Jul 2023 02:17:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id c4-20020a056000104400b003143b14848dsm12419609wrx.102.2023.07.31.02.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 02:17:19 -0700 (PDT)
Message-ID: <f121b407-d6da-73ab-4cc6-a7608cf069a7@linaro.org>
Date:   Mon, 31 Jul 2023 11:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: drop redundant
 status=okay
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230731090442.100856-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230731090442.100856-1-krzysztof.kozlowski@linaro.org>
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

On 31/07/2023 11:04, Krzysztof Kozlowski wrote:
> status=okay is by default.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index 2fce44939f45..cdb80e0a7718 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -181,7 +181,6 @@ sound {
>   		assigned-clock-rates = <294912000>,
>   				       <270950400>,
>   				       <393216000>;
> -		status = "okay";
>   
>   		dai-link-0 {
>   			sound-dai = <&frddr_a>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
