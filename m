Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016AC75881B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjGRWDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGRWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:02:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A74272A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:02:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so890091e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689717716; x=1690322516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ef2ucOyrPFztJ167afpvPjPuWEm3c8OP5Iwr/4gr8wk=;
        b=rVijO4CFPg5o/ZAiyDM/6ao45V3lgDpgIuiPGl+Zkz81TNAG8UmbA0PNEmHUn8OICH
         dmNbY/KD+IIV/+e7OzaYDkquo0uWRz2ehH3FqM8FlDwm+qQFX2ftQBNI7szBKXf9AKu0
         gZ1PT+YKup8ADhqPIE7NVnFhRFdrhLoF485gKxBKVUoPqE7O24w7eUMs5b65T8zfuk0o
         xVWc/Ydd01e8+5gF2PfYjR/4rrbY3VySueIbThtJBS7EFHWvs6lKB1++In8e9EMFZkCL
         FweHyAhlbos9becjugcIyCWLETFKVIL+jCn7ZP4trb+mwYLw5ExDYH31tNlQgghewWeR
         pHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717716; x=1690322516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef2ucOyrPFztJ167afpvPjPuWEm3c8OP5Iwr/4gr8wk=;
        b=UHV8/Eia5qlAJ1dxX5IwaXePO2XRyTNhoVGSw6Fo7LsYvTazRyF1HZPO0X53tNl290
         QZOmvJC4iA6qeOFekkiSclZKbWivQ5PSfb5QlNEk7NJbKkKimimykZigleuKjw43+uuc
         9AVJ2wrh5pIWbjF3WHZMUKT/BuFUVYElS4hHlcHPtE7zsIqynaZ0XbSudXwxJwfdNiyO
         Q3fRDvSbVIl7CKPKxHDZlAtdbpK/0I5l3s1GxnuSmjZreHfG8+Ffnmi9/5KKz7d66c8z
         BT0sqPUCqHx3ckSM4/FYCsBgnyeKahl5kzWE0UtHZDJf9bH7t3oCRulEqt7x15KoHDVU
         u2Ew==
X-Gm-Message-State: ABy/qLa8RjuklrTUROKCpQwb/cAZR+0NTC+FNSSai/UtlKdqLQ9zfyRL
        9Zz1XCSIoeT0BSiFD1KMdr9SnA==
X-Google-Smtp-Source: APBJJlEqQ6B3fMFXYN0weJXmUvo7Xz+RzFP6n1yfq5Vj0oMcfhZDr4qgLS5BY56lgOux4N5gGlD1oQ==
X-Received: by 2002:a05:651c:157:b0:2b4:5cad:f246 with SMTP id c23-20020a05651c015700b002b45cadf246mr420563ljd.7.1689717715701;
        Tue, 18 Jul 2023 15:01:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c00cb00b002b6ce06618dsm700546ljr.21.2023.07.18.15.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:01:55 -0700 (PDT)
Message-ID: <d5f925e4-fbfe-cbb2-c3e6-8e806761d61e@linaro.org>
Date:   Wed, 19 Jul 2023 01:01:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125
 variant
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-10-03e430a2078c@somainline.org>
 <285facd1-bf20-aff2-b680-f796e8830038@linaro.org>
 <yzz4dddlh2no3lmuxrkuxhsuaf3brruo635pgfpnaxwffmnl6j@uk3jxtoarg7w>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <yzz4dddlh2no3lmuxrkuxhsuaf3brruo635pgfpnaxwffmnl6j@uk3jxtoarg7w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 00:00, Marijn Suijten wrote:
> On 2023-06-29 13:54:13, Dmitry Baryshkov wrote:
>> On 27/06/2023 23:14, Marijn Suijten wrote:
>>> Document availability of the 14nm DSI PHY on SM6125.  Note that this
>>> compatible uses the SoC-suffix variant, intead of postfixing an
>>> arbitrary number without the sm/sdm portion.  The PHY is not powered by
>>> a vcca regulator like on most SoCs, but by the MX power domain that is
>>> provided via the power-domains property and a single corresponding
>>> required-opps.
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>>    .../devicetree/bindings/display/msm/dsi-phy-14nm.yaml         | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>>> index a43e11d3b00d..183a26f8a6dc 100644
>>> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>>> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
>>> @@ -19,6 +19,7 @@ properties:
>>>          - qcom,dsi-phy-14nm-2290
>>>          - qcom,dsi-phy-14nm-660
>>>          - qcom,dsi-phy-14nm-8953
>>> +      - qcom,sm6125-dsi-phy-14nm
>>>    
>>>      reg:
>>>        items:
>>> @@ -35,6 +36,16 @@ properties:
>>>      vcca-supply:
>>>        description: Phandle to vcca regulator device node.
>>>    
>>> +  power-domains:
>>> +    description:
>>> +      A phandle and PM domain specifier for an optional power domain.
>>> +    maxItems: 1
>>> +
>>> +  required-opps:
>>> +    description:
>>> +      A phandle to an OPP node describing an optional performance point.
>>
>> I'd rephrase this to be something more exact, like 'desribing power
>> domain's performance point'.
> 
> Sure.  I'll leave out the word "optional", that becomes obvious from
> maxItems:1 without minItems, together with referencing a PM which itself
> is already optional.

no, default minItems is equal to maxItems. It is not listing this 
property under the required what makes it optional.

> 
> - Marijn
> 
>>> +    maxItems: 1
>>> +
>>>    required:
>>>      - compatible
>>>      - reg
>>>
>>
>> -- 
>> With best wishes
>> Dmitry
>>

-- 
With best wishes
Dmitry

