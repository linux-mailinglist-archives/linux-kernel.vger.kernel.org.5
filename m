Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0A79ED80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjIMPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjIMPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:42:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30D2D7E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:42:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso111225466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694619719; x=1695224519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tNjhlH206IzUUkrLOTH6KtlKVYXz/q75ZTuPPcqMFk=;
        b=bW8NusU89EZJsgt42ImLk94G48WYqRmo11u07ePqNgGzHxLbAlDmBMit5T8ErBYZvx
         ShxPKx449XRRik6ik88s4JXeb0A6p8bJDGDgtyphzPHmLGrCIqxTFZLS6ZDcS1cfo7VS
         eUjc+XqpnkxjDQfPMkpWtJCoUDQzwVYcNc+auowlwkztLeWEw5EwJPpnBm2XBMdV60e1
         l5DEH0duMsd1Lfz9b50fJp64Vty9ERU4VUUV072z6njW2G2bm8oN+lOSZg0GXZwWRPDS
         JdAr+CQueysiZJ8CvTYSnzk3J+Qm700u4VG1mR0d44bUcvqbFf7SQ1RHCACQDaVGNChw
         xOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619719; x=1695224519;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tNjhlH206IzUUkrLOTH6KtlKVYXz/q75ZTuPPcqMFk=;
        b=rkrgzvwVIwLdJM/UyYs53YzcpVBAj3H+NnEYuoBBURhks2IPb9BS4ILQmVtEhnDYyl
         sBua4vqTEIkHkhxD9aaTm//xCQ44BSv+XtA+wLfiVvYOM+Odr0uW1//Oa36ka92lSwEg
         6uxN8SYBP+bR2UAj8z4+gIBLLOa2DuPsdqnoRbblH0WQwluDsJ1K4ZwpeFD0msWvZ4bp
         uqNGsJ2Zk3etaGMhmjXRIAVhleesk+2RRIh+L9jfdkHa8lWmKxDcWm3FzBsMd/zHbKeE
         d5J2/gx1zHf3PQhbfj8iivdqVDdI+LSvSqC/pGZef+YLVUDdDnyrmvBv8yplZ6Zt4jI/
         Rt1g==
X-Gm-Message-State: AOJu0YxrXZyP5yUOobX+7N5a7aZqTs7cDppypd8szuwjS35OeJg+6xiT
        N8NIOlBSDiCrRC4KKcpLhHVL4Q==
X-Google-Smtp-Source: AGHT+IE/Qamlm4QU08NosxmsDomDBqURds6+LWtMhxScI4jMdvKLNkx5zTwjQJgqvPSmZB1yXEVn4g==
X-Received: by 2002:a17:906:5181:b0:9ad:7f8b:21b with SMTP id y1-20020a170906518100b009ad7f8b021bmr2468995ejk.13.1694619719145;
        Wed, 13 Sep 2023 08:41:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id kf4-20020a17090776c400b0099c53c4407dsm8580766ejc.78.2023.09.13.08.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:41:58 -0700 (PDT)
Message-ID: <11c822f3-96f1-17d6-6c2a-feaa950aeea1@linaro.org>
Date:   Wed, 13 Sep 2023 17:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC
 board
Content-Language: en-US
To:     Yang Chen <yangchen.openbmc@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com
References: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
 <20230912140532.3797736-3-yangchen.openbmc@gmail.com>
 <1bfdc230-e358-6aa4-7d60-03b5477a6be9@linaro.org>
 <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALFa7M_GvCgmEZxvo_ZSYoCPOe+9-tQt3KHn=_cu3n7psP+PTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 15:57, Yang Chen wrote:
> Hi Krzysztof,
> 
>> +
>> +&i2c15 {
>> +     status = "okay";
>> +
>> +     eeprom@50 {
>> +             compatible = "atmel,24c128";
>> +             reg = <0x50>;
>> +     };
>> +};
>> +
>> +&adc0 {
>> +     ref_voltage = <2500>;
> 
> There is no such property in the bindings.

Fix your email setup. This is my response, not yours.

> 
>> +     status = "okay";
>> +     pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
>> +             &pinctrl_adc2_default &pinctrl_adc3_default
>> +             &pinctrl_adc4_default &pinctrl_adc5_default
>> +             &pinctrl_adc6_default &pinctrl_adc7_default>;
>> +};
>> +
>> +&adc1 {
>> +     ref_voltage = <2500>;
> 
> NAK, there is no such property.
> 

So who says what?

> Thanks for your advice, I will change this property to
> "aspeed,int-vref-microvolt" which is defined in the binding in the v2 patch.

No, why? Drop it. There is no user.

Also, do not top post.



Best regards,
Krzysztof

