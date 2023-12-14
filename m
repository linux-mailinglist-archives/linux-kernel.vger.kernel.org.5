Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968E8135B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443500AbjLNQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjLNQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:07:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F6127
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:07:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-55202565d48so2015069a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702570050; x=1703174850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wCm7hm2Q32RWzxlkJWAENcxDAOzqYtnHB2jwyu8n2FI=;
        b=MLFYi+yd2EMzqrBTvc+mjyHDyl3M4xvm5L5lrBaeYGkD0XWYMPx61eeRvunSxTpQCb
         cNzpQ+4u7nVqgM2P9eFGFvm/NNmNQnH8c65wPM5GvHrUV/PypJbCctuAflcu8tMo81yo
         SbAZAEyTebGLvyz0ilyk92ghxNav3AF2i2pQySqdQc2OmoSzj4GvNJ79eqZv5zxuPHVG
         Mr2c84QxlPyvlFLscMvCQkzN88uQb3FpW0ERUnOnYFZTbbnGpMktMCrqDFTjWSjdFdRR
         vHq2l1jCgm8WD/fkRQsRbxwfEwT/4yJokKzFjy9KC1YoWS+8ioZhDlcdkx9lTFYdnt5D
         HIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570050; x=1703174850;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCm7hm2Q32RWzxlkJWAENcxDAOzqYtnHB2jwyu8n2FI=;
        b=RBDVNXo8aFizJSkIms7ASXvPAw/0EGz6Gm126kKZ/w7ZaM35jd0As3yFczhoQui981
         5d8+QV6O7Q9J+MTMRBgBAW3swRCp9rxMJt4jSNO3rfLeD6QHIYPrMNebhpV0nPSUnDwP
         FF+uyqd7u4gMGfssgjSUZnKojBTMvPj9wcH51j3kvAtCXMc2H/7jioFDILMuQbSUAutV
         6/bLUHhbWj8wsPBhj1FtUv5e3fw9ziKr7KMBG/GjMaciEGqvNT3ZbHjKiuMZ4ogkdQbS
         +o4+hp/UmAq6wtbMLHx0r8KHliDAj23VaFwVOcD13wcMn4n5/Vt35ja/y0liRuPzsS60
         n8hA==
X-Gm-Message-State: AOJu0YweOqomO8Qd6JGgBscSzsZaj5G908YwYNf/0pnyuCCF1ZQZ1dGV
        0tmK8zbl8rmnvEoYBgVJUS6Lfg==
X-Google-Smtp-Source: AGHT+IFIV8hHhs6BCYx/j/vneSUxeIC9+OrWm+pf+Q9EE92p6Ls2acv5BezkB8jCS4UoaeEobNeifQ==
X-Received: by 2002:a50:d785:0:b0:551:49af:b362 with SMTP id w5-20020a50d785000000b0055149afb362mr2636354edi.78.1702570049932;
        Thu, 14 Dec 2023 08:07:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id a4-20020a509e84000000b0054ccc3b2109sm7126498edf.57.2023.12.14.08.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:07:29 -0800 (PST)
Message-ID: <df84a0cc-cb38-431f-864b-012ada7bb0d5@linaro.org>
Date:   Thu, 14 Dec 2023 17:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: display: rockchip,inno-hdmi: Document
 RK3128 compatible
Content-Language: en-US
To:     Alex Bee <knaerzche@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <20231213195125.212923-2-knaerzche@gmail.com>
 <c4e394c6-c21f-4102-8c3a-f9530c0ca547@linaro.org>
 <288857ab-bebd-4f80-9cdc-9b04fa6c7386@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <288857ab-bebd-4f80-9cdc-9b04fa6c7386@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2023 16:22, Alex Bee wrote:
> 
> Am 14.12.23 um 08:53 schrieb Krzysztof Kozlowski:
>> On 13/12/2023 20:51, Alex Bee wrote:
>>> Document the compatible for RK3128's HDMI controller block.
>>> The integration for this SoC is somewhat different here: It needs the PHY's
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> OK. Not sure why checkpatch --strict  didn't tell me that I'm over the 
> limit here.
>>
>>> reference clock rate to calculate the ddc bus frequency correctly. This
>>> clock is part of a power-domain (PD_VIO), so this gets added as an optional
>>> property too.
>> If clock is part of power domain, then the power domain must be in the
>> clock controller, not here. So either you put power domain in wrong
>> place or you used incorrect reason for a change.
>   Rockchip defines it's powerdomains per clock and I was little to much 
> in that world when writing this. Actually the controller itself is part 
> of the powerdomain. Will rephrase.

Does it mean you have like 200 different power domains in one SoC? Then
how are they different than clock if there is one-to-one mapping?

>>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>>> ---
>>>   .../display/rockchip/rockchip,inno-hdmi.yaml  | 30 +++++++++++++++++--
>>>   1 file changed, 28 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>>> index 96889c86849a..9f00abcbfb38 100644
>>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,inno-hdmi.yaml
>>> @@ -14,6 +14,7 @@ properties:
>>>     compatible:
>>>       enum:
>>>         - rockchip,rk3036-inno-hdmi
>>> +      - rockchip,rk3128-inno-hdmi
>>>   
>>>     reg:
>>>       maxItems: 1
>>> @@ -22,10 +23,21 @@ properties:
>>>       maxItems: 1
>>>   
>>>     clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    items:
>>> +      - description: The HDMI controller main clock
>>> +      - description: The HDMI PHY reference clock
>>>   
>>>     clock-names:
>>> -    const: pclk
>>> +    minItems: 1
>>> +    items:
>>> +      - const: pclk
>>> +      - enum:
>>> +          - pclk
>>> +          - ref
>> That's way overcomplicated. Just items listing the names and minItems:
>> 1. See other bindings how this is done.
> OK.
>>> +
>>> +  power-domains:
>>> +    maxItems: 1
>> Is it relevant to existing device?
> 
> Will move to new variant only.
> 

Definition should be here, but in if:then: it should be disallowed
(:false) for other variants.

Best regards,
Krzysztof

