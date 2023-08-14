Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B9A77B373
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjHNIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjHNIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:10:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5108719B1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:09:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3159d5e409dso2964357f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000583; x=1692605383;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h96fvtK7Q6sYb+yjtmtmp5Cx7J/yaSonESREWSMDZaQ=;
        b=yiJ+a+9RMWJqN1w+rJDCBGGGGOATGap34HO6ZfAOGwJ2aU+b9EzjU8C7ICOj+Mx4he
         rMIXOfPKYID+UybVy/kZbB4jC2o4sZDEbN48qT4OPDL6hMqgyNtvNijNW4HYoh6q65bJ
         IIRb1G33nhyhrRS4IM+sqOvmoa2kcRrGujORzyMIBh0W7uggT+mfMsNeQMJmLEVWPFjN
         e6nPGUtmo6nXwK7LGfSccLn3gpPmh2ckmCTU6pUDA5snu9+Xd0htDfGq5p0KdOc3VcX1
         b/5Z11KFYBwBJj1TMvQICXaYv/duwweZfU9j29ZybSgfuN8AzjNppkAbmLOG+y+YBwn2
         Y+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000583; x=1692605383;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h96fvtK7Q6sYb+yjtmtmp5Cx7J/yaSonESREWSMDZaQ=;
        b=YE89mYTVGji/2oHxJ0FqiI0jv1oZxxz6SPC8l3d/52FRaIzxd1+22F3uCUaNdNDmoc
         aKgM6G6nJ329mpmZbIasyYb1Pmqu98hfhxGLDryy2pdjPypXffJ4RvnBOvoExTV3m+vC
         V4kWf+2JJ3gERGJGvuPbPYS+S1XEUWZzQOIXD3MdEHskt8PIrXQh3JsHZ6nZFFumVOlv
         abMjVi/9RLa9NpkAKRabjVlNlfRD22H2V1fNUtfpWz0gotv9ydRSVQoLfUZU3QBs/kvo
         FVwvjplHlzIvxtD148hVzt0pYW8jL+w8KUV6/Co+aAozVzcrceGAVeWbm048X/HuNdjC
         EnWg==
X-Gm-Message-State: AOJu0Yzu0YXaNYHbR/13DdcJKqRlcsfsfY9tsSNWG43DjCbzoeT7tNpw
        oqu2TWryIfj9GYoPE9jvXVa+7A==
X-Google-Smtp-Source: AGHT+IG5QpfTnxygk3x8uHSWEhK6bF3gN3WPZBhQegGjbp6KlbwT+Ggb6vfwd9jhaBqOIDrqTRVOYg==
X-Received: by 2002:a05:6000:188:b0:315:a235:8aa8 with SMTP id p8-20020a056000018800b00315a2358aa8mr9337209wrx.2.1692000582779;
        Mon, 14 Aug 2023 01:09:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id y9-20020a1c4b09000000b003fe1cac37d8sm16209267wma.11.2023.08.14.01.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:09:42 -0700 (PDT)
Message-ID: <7fc7371a-1b2d-ccce-1e73-6bfe70ea2b20@linaro.org>
Date:   Mon, 14 Aug 2023 10:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: qcom,pmic-glink: add a gpio
 used to determine the Type-C port plug orientation
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
 <20230804-topic-sm8550-upstream-type-c-orientation-v1-1-36dd3edec7bf@linaro.org>
 <zhm72wrjg7yazutkinv5lx55dgqtm4hmuexw2ht24fu6txxk3d@oum27inbk7si>
Organization: Linaro Developer Services
In-Reply-To: <zhm72wrjg7yazutkinv5lx55dgqtm4hmuexw2ht24fu6txxk3d@oum27inbk7si>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 18:03, Bjorn Andersson wrote:
> On Fri, Aug 04, 2023 at 03:50:07PM +0200, Neil Armstrong wrote:
>> On SM8450 and SM8550 based platforms, the Type-C plug orientation is given on a
>> GPIO line set by the PMIC.
>>
>> Document this optional Type-C connector property, and take the
>> assumption an active level represents an inverted/flipped orientation.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> index bceb479f74c5..1b0a00b19a54 100644
>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>> @@ -35,6 +35,11 @@ properties:
>>     '#size-cells':
>>       const: 0
>>   
>> +  orientation-gpios:
>> +    description: An input gpio for Type-C connector orientation, used to detect orientation
>> +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
> 
> This is a per-connector/port property, as such be part of the connector
> sub nodes rather than as a property of the shared pmic_glink entity.

This has been rejected by Rob, Dmitry & Krzysztof in:
https://lore.kernel.org/all/0fbf55e7-2140-751d-5347-f907a46ef78c@linaro.org/
&
https://lore.kernel.org/all/20230608154751.GA2750742-robh@kernel.org/

Indeed the "GPIO" is not part of the physical USB-C connector, but a property,
and it's not part of the PMIC GLINK firmware either, so ?

The PMIC function which generates this signal is handled by the PMIC GLINK
firmware, so this representation is the most accurate.

Neil

> 
> Regards,
> Bjorn
> 
>> +    maxItems: 1
>> +
>>   patternProperties:
>>     '^connector@\d$':
>>       $ref: /schemas/connector/usb-connector.yaml#
>> @@ -44,6 +49,19 @@ patternProperties:
>>   required:
>>     - compatible
>>   
>> +allOf:
>> +  - if:
>> +      not:
>> +        properties:
>> +          compatible:
>> +            contains:
>> +              enum:
>> +                - qcom,sm8450-pmic-glink
>> +                - qcom,sm8550-pmic-glink
>> +    then:
>> +      properties:
>> +        orientation-gpios: false
>> +
>>   additionalProperties: false
>>   
>>   examples:
>>
>> -- 
>> 2.34.1
>>

