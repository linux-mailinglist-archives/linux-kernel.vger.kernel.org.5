Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47177F4B85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjKVPtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjKVPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:48:49 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A338524E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:46:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a03a9009572so162443566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700668015; x=1701272815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4Sh7iGlNxumB5VcLNDx/95ABOz0bRjlVPQnOa1w1Ss=;
        b=CQFAU0dRlqcrLFCw7p3jXt7HpQVE0LgiA8/16q23Oc/Ps5o9mG4ZCpLHCTevOArdwC
         bH9adRk4puluQzMW1Yd91V6bO9YX4qw4m3JjfiYvLTg8E92gs+Id4WnFGtIr6fOCCFj1
         5/sOX7IDYe9JyOAbEsVCe+Z+Y3/iGKORdzA/Oz3jMPtjXjt35hlAQPqBLpw9uYVB3m5F
         ruzmYj9+nhRbgybtVz1zZC8q+P36R0JqadVMzZEWgTEREKxeSb0glU9ub95KGpKHK6Dt
         cbfRr4LzOkvvPbFE4yzu5uxsmP25GsmC8IMXoV26JFJ8ruDYlCJ/q/iqnStqT9UDGYHW
         GAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668015; x=1701272815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4Sh7iGlNxumB5VcLNDx/95ABOz0bRjlVPQnOa1w1Ss=;
        b=vpMbunWZ5WPEJhfP+Jc1kgh7c+VX60aHb0s55am54gclt0EiEMPy/w/g372qPNSYr1
         EeDh1mZG37oj/pB0dwTpI61BXK1QQW1iVoXES6wecFidcmTquRPQzcxJ7rtfK2Y5+gZE
         NqiWABRG24dBtsP10C0IKulEjYRptG7K1lKRkhsgYRrx5/P695YqtOSYt/xvwfM9UBrP
         OuoaNDQ94arffpqrEiI4KWIULXRoyUdhd8nfIYLBcCI/zJs6fUY4fzn47lQR3qq9ZOCb
         gJjMoI21r14O/pRUBZwRJTVX/QUy1jXcuEJsrdk6V+bhackvReYNm56NmxTmz4dw7M+a
         TLXA==
X-Gm-Message-State: AOJu0YyphmoN+Iu56Tqf2Av3TvSJezSSkMVMzeUkVfnmYjx34N8/LaK5
        s/gfA5V6NPHH7vuq7wjix5BepQ==
X-Google-Smtp-Source: AGHT+IFW5oX9fTLJ1szGuuAzjPMIHff7wKMRPiKVS9OPnwaHAonSoiXRvJddjViCI+jKD3t1JddOwQ==
X-Received: by 2002:a17:906:b158:b0:9fe:392:c535 with SMTP id bt24-20020a170906b15800b009fe0392c535mr1526575ejb.69.1700668014674;
        Wed, 22 Nov 2023 07:46:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id g26-20020a170906349a00b00a0451802b3csm1013123ejb.4.2023.11.22.07.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 07:46:54 -0800 (PST)
Message-ID: <2d9c4c93-6cea-4a44-9093-c1fd51d0a21c@linaro.org>
Date:   Wed, 22 Nov 2023 16:46:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     neil.armstrong@linaro.org, Rob Herring <robh@kernel.org>,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-3-jbrunet@baylibre.com>
 <170040994064.269288.960284011884896046.robh@kernel.org>
 <4608012c-059f-4d6a-914b-e85ad0c32ff0@linaro.org>
 <1j5y1wg3sb.fsf@starbuckisacylon.baylibre.com>
 <2e7a65da-5c1d-4dd4-ac69-7559a53afdf3@linaro.org>
 <1j1qckg21u.fsf@starbuckisacylon.baylibre.com>
 <94e69281-93e1-41cd-9cf5-81cbbc15572c@linaro.org>
 <1jwmu9et6j.fsf@starbuckisacylon.baylibre.com>
 <2bbc2031-89d7-42e9-828e-068fa06eabf4@linaro.org>
 <1jo7flerag.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1jo7flerag.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2023 16:23, Jerome Brunet wrote:
> 
> On Wed 22 Nov 2023 at 16:04, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 22/11/2023 15:34, Jerome Brunet wrote:
>>>
>>> On Wed 22 Nov 2023 at 09:37, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 20/11/2023 11:04, Jerome Brunet wrote:
>>>>>>>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>>>>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>>>>>>
>>>>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm puzzled, isn't it recommended to have a per-soc compatible now ?
>>>>
>>>> Yes, it is.
>>>>
>>>>>>> I have specifically addressed this matter in the description,
>>>>>>> haven't I ? What good would it do in this case ?
>>>>
>>>> There is nothing about compatible naming in commit msg.
>>>
>>> Krzysztof, the whole commit desciption is explanation about why a new
>>> compatible is introduced. I don't understand this comment.
>>>
>>>>
>>>>>>
>>>>>> Yes you did but I was asked for the last year+ that all new compatible
>>>>>> should be soc specific (while imprecise, in our care soc family should be ok),
>>>>>> with a possible semi-generic callback with an IP version or a first soc
>>>>>> implementing the IP.
>>>>>>
>>>>>>> Plus the definition of a SoC is very vague. One could argue that
>>>>>>> the content of the list bellow are vaguely defined families. Should we
>>>>>>> add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
>>>>>>> This list gets huge for no reason.
>>>>>>
>>>>>> I think in our case soc family is reasonable since they share same silicon
>>>>>> design.
>>>>>>
>>>>>>> We know all existing PWM of this type are the same. We have been using
>>>>>>> them for years. It is not a new support we know nothing about.
>>>>>>>
>>>>>>>>
>>>>>>>> I thought something like:
>>>>>>>> - items:
>>>>>>>>      - enum:
>>>>>>>>          - amlogic,gxbb-pwm
>>>>>>>>          - amlogic,axg-pwm
>>>>>>>>          - amlogic,g12a-pwm
>>>>>>>>      - const: amlogic,pwm-v1
>>>>>>> I'm not sure I understand what you are suggesting here.
>>>>>>> Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
>>>>>>> has that and I'm working to remove this type, so I don't get the point.
>>>>>>>
>>>>>>>>
>>>>>>>> should be preferred instead of a single amlogic,meson8-pwm-v2 ?
>>>>>>> This is named after the first SoC supporting the type.
>>>>>>> Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
>>>>>>> Plus the doc specifically advise against this type of names.
>>>>>>
>>>>>> The -v2 refers to a pure software/dt implementation versioning and not
>>>>>> an HW version, so I'm puzzled and I requires DT maintainers advice here.
>>>>>>
>>>>>> Yes meson8b is the first "known" platform, even if I'm pretty sure meson6 has
>>>>
>>>> Yes, this should be SoC-based compatible, unless you have clear
>>>> versioning scheme by SoC/IP block vendor. You named it not a HW version,
>>>> which kind of answers to the "unless" case - that's not hardware version.
>>>>
>>>
>>> This is specifically the point of the comment in commit description.
>>> We know all the PWMs compatible are the same HW (version) as one found
>>> in the meson8b.
>>>
>>> It is certain that adding more compatible, listing all the SoC, will be
>>> useless. I can do it if you insist.
>>
>> The docs you references insist on that, so yeah, I insist as well.
>>
>>>
>>>>>
>>>>> This is not my point. I picked this name because I have to pick a
>>>>> specific device based one. Not because it is actually the first or
>>>>> not. I don't see a problem with meson6 being compatible with
>>>>> meson8-pwm-v2, if that ever comes along.
>>>>
>>>> No, the point is not to use "v2". Use SoC compatibles.
>>>
>>> It is a SoC compatible. The second one.
>>
>> "v2" is not the soc. I assume meson8 is one specific SoC, right? Because
>> elinux says it is a *family*:
>> https://elinux.org/Amlogic/SoCs
>>
> 
> It is a family. yes
> 
>>
>>>
>>> The first one, as explained in the description was describing the driver
>>> more that the HW.
>>>
>>> Changing the way clock are passed from DT to the driver would be break
>>> user of the old compatible. So a new compatible is introduced. I believe
>>> this is recommended way to introduce incompatible binding changes.
>>
>> The way is not to introduce incompatible changes. Your way is also not
>> good as it breaks other users of DTS.
>>
>>>
>>> v2 here denote a new interface version, nothing to do with HW
>>> versioning. I happy to pick something else to denote this.
>>
>> Sorry, then it is not a SoC-based compatible.
>>
>>>
>>>>
>>>>>
>>>>> I think the binding here satisfy the rule that it should be specific,
>>>>> and the intent that goes with it:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n42
>>>>>
>>>>>> the same pwm architecture, this is why "amlogic,pwm-v1" as fallback seems more
>>>>>> reasonable and s4 and later pwm could use the "amlogic,pwm-v2"
>>>>>> fallback.
>>>>>
>>>>> That is not how understand this:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n82
>>>>>
>>>>
>>>> Again, where the "v2" is defined? Where is any document explaining the
>>>> mapping between version blocks and SoC parts? Why do you list here only
>>>> major version? Blocks almost always have also minor (e.g. v2.0).
>>>
>>> Again, v2 does has nothing to do with the HW. Never wrote it was.
>>> The HW remains the same.
>>
>> Don't add compatibles which are not related to HW, but represent
>> software versioning. Software does not matter for the bindings.
> 
> What I did I explicitly what is recommended in Grant's presentation from
> 2013. 10y old, but I assume slide 10 "Making an incompatible update" is
> still valid.
> 
> https://elinux.org/images/1/1e/DT_Binding_Process_glikely_ksummit_2013_10_28.pdf
> 
> Breaking the ABI of the old compatible would break all boards which use
> u-boot DT and pass it to the kernel, because the meaning of the clock
> property would change.

You broke U-Boot now as well - it will get your new DTS from the kernel
and stop working.

> 
> Doing things has suggested in this slide, and this patch, allows every
> device to continue to work properly, whether the DT given is the one
> shipped with u-boot (using the old compatible for now) or the kernel.

OK, that explains the reasons. I read your commit msg and nothing like
this was mentioned there. What's more, you did not deprecate the old
binding, thus the confusion - it looked like you add entirely new
hardware (although you put "deprecated" but in some unrelated place, not
next to the compatibles).

Anyway, the main point of Neil was that you started using generic
compatible for all SoCs, which is wrong as well. I guess this was the
original discussion.

Best regards,
Krzysztof

