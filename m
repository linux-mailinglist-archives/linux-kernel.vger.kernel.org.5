Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BA37CD3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjJRGAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:00:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF5FF9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:00:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso10881565e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697608837; x=1698213637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jYUU/zMwQ57icTdluFdkVmoJdfusA7m4N1I0RAQAJ8=;
        b=SMW+4zZRxBpo0dDRtVQcrjed634Z5Y/sGjZBrbdcU0HGjd4e7RGpNLR/VaSgKeJ40o
         pE+onUgqNbIEofkHB0KvK1Sa/IiIZdgJHVZaIy/8ylH6bi13x/JDnztldxDgtgzWg1py
         hmEUSQ2TpQq1RR2PaRpQf59I+C52JkJ/h2jaPghymUYwv0HZaJf/9QN5DiwBDauUwRiu
         3E26Oy/IqqXLegFI7Uz2wFM6WLaZiTLnd4biR6PFjCT0yLzzEYQVL2tvSAGyNm3RIBZ0
         dRQk3NaxCW2ng+K1OeUOMHq5OaYEqN6d+dzMB8rfTWJnhKI0Zq5Oxy+UMomSlnvMRVkC
         tmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697608837; x=1698213637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jYUU/zMwQ57icTdluFdkVmoJdfusA7m4N1I0RAQAJ8=;
        b=jD8Nu3/YX1BrRRmKoQxrKmkecLkMeNHAse6TDF/XOHryZsk8FkNBoNRg5F5QQAcUfG
         Oh1H2af4d6QBhe3qs0rR58/UfXbhhb1cNX5otPJ4graD0boxlHp7F9VdS09fxOn6aArW
         LqD1warGZi/2A0gRMsZHosTnu/qL5xIFoIxszVCkt+ckrN8h5r60ZpTxm4y9f4MZnI9j
         GxUn8o3fVDUCNcWM4yVigARM1gVamTnAXsZcHxpHHFADIbQWsE2zxuiwEt7wMLR8hlyN
         Yrxta/lz2SB7LiJwAVY1ZkBiU2/4+bB6aV/hgrTltew3Q/vktMugVJQ9gcSPcLl7emTL
         7k7Q==
X-Gm-Message-State: AOJu0Yzmhw/uQPFQr2f1KYK18aPIF95916eQtVSnH8PDtKnjrN4+aaUI
        oiGcddZekxTf0C9FDkeOgmxNhw==
X-Google-Smtp-Source: AGHT+IGPB7PtgGhLJB00EPY5bCertig3g1OC/hkjJkff0FeRZ0lTrQed2+3auUs93GzcwOhS6dTgyw==
X-Received: by 2002:a05:600c:19cc:b0:405:375d:b860 with SMTP id u12-20020a05600c19cc00b00405375db860mr3162436wmq.21.1697608837336;
        Tue, 17 Oct 2023 23:00:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b003fc0505be19sm722336wmq.37.2023.10.17.23.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 23:00:36 -0700 (PDT)
Message-ID: <b52d0de7-e320-4c4c-876e-346281de23a1@linaro.org>
Date:   Wed, 18 Oct 2023 08:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] dt-bindings: usb: qcom,dwc3: Introduce flattened
 qcom,dwc3 binding
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-10-ab4a84165470@quicinc.com>
 <9f53e647-7c38-435f-bc74-e4f417445830@linaro.org>
 <20231017225433.GW3553829@hu-bjorande-lv.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231017225433.GW3553829@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 00:54, Bjorn Andersson wrote:
> On Tue, Oct 17, 2023 at 08:11:45AM +0200, Krzysztof Kozlowski wrote:
>> On 17/10/2023 05:11, Bjorn Andersson wrote:
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> [..]
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      items:
>>> +        - enum:
>>> +            - qcom,ipq4019-dwc3
> [..]
>>> +            - qcom,sm8550-dwc3
>>
>> This enum could be replaced with '{}'. Alternatively, drop enum entire
>> select replaced with:
>> - contains
>>   - items:
>>       - const: qcom,dwc3
>>       - const: snps,dwc3
>>
> 
> I thought this would be what I needed as well, but unfortunately this
> select matches either qcom,dwc3, snps,dwc3, or both. With the result
> that e.g. the example in the snps,dwc3 binding matches against this and
> as expected fails when validated against this binding.
> 
> Taking yet another look at this, and reading more about json validation
> I figured out that the following matches nodes with both the
> compatibles:
> 
> select:
>   properties:
>     compatible:
>       items:
>         - const: qcom,dwc3
>         - const: snps,dwc3
>   required:
>     - compatible
> 
> [..]
>>> +
>>> +# Required child node:
>>
>> Drop
>>
> 
> Of course.
> 
>>
>> ...
>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index d81c2e849ca9..d6914b8cef6a 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -44,14 +44,18 @@ properties:
>>>        It's either a single common DWC3 interrupt (dwc_usb3) or individual
>>>        interrupts for the host, gadget and DRD modes.
>>>      minItems: 1
>>> -    maxItems: 4
>>> +    maxItems: 5
>>>  
>>>    interrupt-names:
>>> -    minItems: 1
>>> -    maxItems: 4
>>>      oneOf:
>>> -      - const: dwc_usb3
>>> -      - items:
>>> +      - minItems: 1
>>> +        maxItems: 5
>>> +        items:
>>> +          - const: dwc_usb3
>>> +        additionalItems: true
>>
>> This is not correct change. Before, one dwc_usb3 interrupt was combined
>> allowed, or a set of host+peripheral+otg+wakeup. Now, you allow combined
>> dwc_usb3 with anything.
>>
> 
> My intention here is to make below list of 5 strings be valid according
> to the snps,dwc3 (i.e. dwc_usb3 being the first item), and valid
> according to the qcom,dwc3 binding with all 5 defined.
> 
>   interrupt-names = "dwc_usb3", "hs_phy_irq", "ss_phy_irq",
> 		    "dm_hs_phy_irq", "dp_hs_phy_irq";
> 
> When I express this as:
> 
>   interrupt-names:
>     minItems: 1
>     maxItems: 5
>     oneOf:
>       - const: dwc_usb3
>       - items:
>           enum: [host, peripheral, otg, wakeup]
> 
> I get:
> 
> /local/mnt/workspace/bjorande/linux/Documentation/devicetree/bindings/usb/qcom,dwc3.example.dtb: usb@a600000: interrupt-names: 'oneOf' conditional failed, one must be fixed:
>         ['dwc_usb3', 'hs_phy_irq', 'ss_phy_irq', 'dm_hs_phy_irq', 'dp_hs_phy_irq'] is too long
>         'dwc_usb3' is not one of ['host', 'peripheral', 'otg', 'wakeup']
>         'hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
>         'ss_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
>         'dm_hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
>         'dp_hs_phy_irq' is not one of ['host', 'peripheral', 'otg', 'wakeup']
>         from schema $id: http://devicetree.org/schemas/usb/snps,dwc3.yaml#
> 
> Which to me sounds like the two oneOf branches allow me a single entry,
> or items from the set given here. In contrast, I believe that my
> proposal allow 1-5 items, where the first needs to be dwc_usb3.
> 
> But the proposal does look messy, so I'd appreciate some guidance on
> this one.

Then you need three branches I guess, with your branch listing the Qcom
specific interrupts. The point is that dwc_usb3 should not be allowed
with host/peripheral/otg/wakeup.

Best regards,
Krzysztof

