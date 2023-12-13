Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C10811DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjLMTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMTB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:01:27 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE070CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50c02628291so7795843e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702494091; x=1703098891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3zkodmR2UxFPx03GluxRmK5wVljS7D1ydfe2a4+d6LQ=;
        b=V6TbtTBYrv0B8o5sjhuXAjuRYdAS7pXjqvqzChUPwFri4EbyOVe5J/JkPnKqjFxXAv
         g3YcA8W8V4hEDVMHxrsfTkpD/OL/TmG7eiYwBUyN4yd165Vc66QKfuvkuV2Nc658o8Vd
         pz5OL2Nzzc3M7PBx7SFd3MOLS4HD0JHbd7G9Fu0kPJoSAVNj670/oDmDo+5kJlFJ0Pjy
         msTlJm/HmNBMllFUf0ALFNSvq7UH8mP+7S/DnCXqiOlarTrlSsAz407K4gNrE0yKsZ9x
         erZ9QS2n6wagELoij03oHi/dY06ZutcGdZafnay7NKwLc8y/OnuGub6XTKbsNcj0fDO3
         ujiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494091; x=1703098891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3zkodmR2UxFPx03GluxRmK5wVljS7D1ydfe2a4+d6LQ=;
        b=OyF7GuSUmZTVOZGOt520pbCybXB3K23vVVDFNJafxTEl/mOh2mk6k5LPpWX8XHW6Z/
         GzScjcHMwxqWzV5m1p0pdR9e/BiAYMMCK2/X0FEnCnmprW/YgYHlVtb5SPnr6t2VZoEq
         1OSa3/NnEs+roJpRaXLwP39oo44LwvvdMg5rYhhSSJe9VC4esL2soC0Yj1PyA+SRdDd1
         kYAK0cZHJxIh9KURPQjlEFglpC1P+26ZNe2Lq2GMEExIzqSlUEvL/hVWKGaB5pX2/JbO
         7hfbGTkxCevjLH2tW8wJUO7pWQ47qj+Sc+xh1B5xDqKkGKXwTK1QT6ebj8p3Z9GLqkdZ
         J6DA==
X-Gm-Message-State: AOJu0YxASpfxbD6t4EsbwWjZZuwklmieSzE6q49fULujmdHCo4K//uv6
        XGIwjc4umR0CsgHsQEOjlLvILw==
X-Google-Smtp-Source: AGHT+IEHI18lmeRYalqAJaY5ttdR3u/fUEx8TECEk1raQLBwDSVAmYcwHwmnBr823IU9BWrLLask6w==
X-Received: by 2002:ac2:4e13:0:b0:50d:faa9:2df1 with SMTP id e19-20020ac24e13000000b0050dfaa92df1mr3211718lfr.82.1702494091617;
        Wed, 13 Dec 2023 11:01:31 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.11.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 11:01:31 -0800 (PST)
Message-ID: <e2c5d7ba-15c0-45ea-ae45-2a6deffde04e@linaro.org>
Date:   Wed, 13 Dec 2023 20:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: aim300: add AIM300 AIoT
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20231207092801.7506-1-quic_tengfan@quicinc.com>
 <20231207092801.7506-8-quic_tengfan@quicinc.com>
 <02be9f46-2187-45d0-9929-31f6a2c18b35@linaro.org>
 <11257e57-693f-46db-8f97-09e5d4c20238@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <11257e57-693f-46db-8f97-09e5d4c20238@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 15:04, Krzysztof Kozlowski wrote:
> On 11/12/2023 11:33, Krzysztof Kozlowski wrote:
>>> @@ -0,0 +1,579 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/leds/common.h>
>>> +#include "qcs8550-aim300.dtsi"
>>
>> Which includes sm8550.dtsi thus I think this is compatible with sm8550.
>> You even use sm8550 compatibles here, which is one more hint for that
>> compatibility.
>>
>> We followed this convention for RB5, although not for QRU/QDU1000 boards.
>>
>> Anyway, if you add here new SoC compatible, I would expect to see new
>> SoC DTSI.
>>
>> I don't have in my notes any previous consensus or decision in these
>> matters, so let's discuss now.
>> +CC few Linaro folks
> 
> After some talks, the idea is to create qcs8550.dtsi, which will include
> sm8550.dtsi, and add top level compatible for qcs8550 using sm8550 fallback.
To the board device tree? Otherwise it'll get overwritten.

Konrad
