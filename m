Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD7759314
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGSK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGSK3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:29:43 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EED51FFF;
        Wed, 19 Jul 2023 03:29:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-56341268f2fso944709a12.0;
        Wed, 19 Jul 2023 03:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762552; x=1692354552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cLoW1TQOaWlvp3NhBI7qdcwZ4QB0jKAj6tuRXeMoec=;
        b=WPe4dG8IV5s9fX2/Z33QFeBzFdkgN3D2DGwyPXvHHrKuklW7v5XgYdlnocE8NyqE7d
         2sa4VInAAEhTjDdr8d4PORMZoi2eCI50aGK/74MceoIYk2Md973VWveKcYSYcnJ8qMld
         Cp6tce5LeSHIXuEEgWVxrrNu1ofvEHJxGiuCEtR5KNrID4ZaFQhHg6EbBx5XizEst4tu
         sysTJszjJu0qJBSYiv7sqTSWElzKlFVwOIbLvS5P5XrnCAJ7fZEpNsGSBbK9PfF89Rjm
         aBgFpEwF8X1lWxRrm/V7xXgC3rkz09T/Qau94iVqKzBQr4GllFFoyysvR8d1x0LwmXDZ
         Ygsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762552; x=1692354552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cLoW1TQOaWlvp3NhBI7qdcwZ4QB0jKAj6tuRXeMoec=;
        b=DrmEGh1Op59NvGGYUygft7LglkCC63yP4D8vOKx4cZYZ1KsUeVFTtOo9W/S9v9LPk6
         7JEzUq0eEeNZH4NzxagDhtkfFrNmv+XsDToI2lWPGF5E1ePfBAIAt6O8mqlxRkcMaxQU
         HqwJnDRk8I/PsHp0DXKaCwwKfCEqB8PugfFpvT8h1uHxxyimcQlF6Q3ha1Cbh+81bzt0
         KZZYPp/X3oJqol6qBq82iAcq0ucd88DSMn+D1JKBbZbbyokZit3dB1QN6d9zF+4XrhZe
         scmulLfG9ishwUDq7lSDe+tu5wWDVhp/FMuoQjiwDdOroqDjJLPhmV/dLl5brnV6cbYu
         P2Lw==
X-Gm-Message-State: ABy/qLbM6ouFQf4Zs6IaDGLB9LeUVGTgF4yIKV85x6xTgN/iEGOxL+pB
        2ibJMdpWufJzBBS7TgvrS9g=
X-Google-Smtp-Source: APBJJlHdapFFwXVg7QIHj2SlCxGpSMVkZ7YXY9N0WNIT06DbPwKGONdFPKbpsK53hKMs6V3hHLd0zg==
X-Received: by 2002:a05:6a20:549d:b0:134:f040:e970 with SMTP id i29-20020a056a20549d00b00134f040e970mr1817921pzk.48.1689762551553;
        Wed, 19 Jul 2023 03:29:11 -0700 (PDT)
Received: from [192.168.50.148] (net-2-34-93-18.cust.vodafonedsl.it. [2.34.93.18])
        by smtp.gmail.com with ESMTPSA id s25-20020a62e719000000b0064d57ecaa1dsm2984524pfh.28.2023.07.19.03.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:29:11 -0700 (PDT)
Message-ID: <3d9515b1-2df0-9bbf-1290-d0618ff8a598@gmail.com>
Date:   Wed, 19 Jul 2023 12:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops
 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
 <cacbbb02-732e-076e-50bf-292d20a4d722@quicinc.com>
 <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
 <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
 <CAGE=qrq0CuO4J-6yC=YZ4xjL67o9QTqpei0ovX-X_8MLVeEH6g@mail.gmail.com>
 <ba04bb7b-6599-6f41-09a8-834ee280830d@quicinc.com>
 <f0609361-6fb6-a446-4e23-646201943923@linaro.org>
From:   Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <f0609361-6fb6-a446-4e23-646201943923@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/07/23 07:57, Krzysztof Kozlowski wrote:
> On 03/07/2023 17:55, Mukesh Ojha wrote:
>>
>> On 7/3/2023 12:50 PM, Krzysztof Kozlowski wrote:
>>> On Mon, 3 Jul 2023 at 08:22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>> On 7/2/2023 1:42 PM, Krzysztof Kozlowski wrote:
>>>>>>> The big difference is if firmware is not deciding where this log
>>>>>>> lives, then it doesn't need to be in DT. How does anything except the
>>>>>>> kernel that allocates the log find the logs?
>>>>>> Yes, you are correct, firmware is not deciding where the logs lives
>>>>>> instead here, Kernel has reserved the region where the ramoops region
>>>>>> lives and later with the minidump registration where, physical
>>>>>> address/size/virtual address(for parsing) are passed and that is how
>>>>>> firmware is able to know and dump those region before triggering system
>>>>>> reset.
>>>>> Your explanation does not justify storing all this in DT. Kernel can
>>>>> allocate any memory it wishes, store there logs and pass the address to
>>>>> the firmware. That's it, no need for DT.
>>>> If you go through the driver, you will know that what it does, is
>>> We talk about bindings and I should not be forced to look at the
>>> driver to be able to understand them. Bindings should stand on their
>>> own.
>> Why can't ramoops binding have one more feature where it can add a flag
>> *dynamic* to indicate the regions are dynamic and it is for platforms
>> where there is another entity 'minidump' who is interested in these
>> regions.
> Because we do not define dynamic stuff in Devicetree. Dynamic means
> defined by SW or runtime configurable. It is against the entire idea of
> Devicetree which is for non-discoverable hardware.
>
>>>> just create platform device for actual ramoops driver to probe and to
>>> Not really justification for Devicetree anyway. Whatever your driver
>>> is doing, is driver's business, not bindings.
>>>
>>>> provide this it needs exact set of parameters of input what original
>>>> ramoops DT provides, we need to keep it in DT as maintaining this in
>>>> driver will not scale well with different size/parameter size
>>>> requirement for different targets.
>>> Really? Why? I don't see a problem in scaling. At all.
>> I had attempted it here,
>>
>> https://lore.kernel.org/lkml/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/
>>
>> but got comments related to hard coding and some in favor of having
>> the same set of properties what ramoops has/provides
>>
>> https://lore.kernel.org/lkml/e25723bf-be85-b458-a84c-1a45392683bb@gmail.com/
>>
>> https://lore.kernel.org/lkml/202305161347.80204C1A0E@keescook/
> Then you were tricked. I don't get why someone else suggests that
> non-hardware property should be part of Devicetree, but anyway it's the
> call of Devicetree binding maintainers, not someone else. DT is not
> dumping ground for all the system configuration variables.

Sorry for that, I assumed the interface should be as close as possible 
to pstore, but apparently that's not the case. Why does it have to be 
different from it? It provides the same functionality and is 
configurable even if it doesn't explicitly configure non discoverable 
hardware properties.

Assuming we make the driver picks the values, how would it do that?  
Hardcoding a configuration could lead to a few problems, such as the 
allocated region being smaller than the driver defaults or driver 
defaults not fully utilizing the allocated region, possibly wasting more 
memory than it'll ever use. On top of that what happens if we want to 
configure it differently than the hardcoded default values? Via cmdline 
options? For example in the previous version it allocated the whole 
region for the console alone, while other entries, such as pmsg that 
could be useful on devices using minidump to store Android logs, was 
zero-sized.

>
>>>>>> A part of this registration code you can find in 11/21
>>>>>>
>>>>>>> I'm pretty sure I already said all this before.
>>>>>> Yes, you said this before but that's the reason i came up with vendor
>>>>>> ramoops instead of changing traditional ramoops binding.
>>>>> That's unexpected conclusion. Adding more bindings is not the answer to
>>>>> comment that it should not be in the DTS in the first place.
>>>> Please suggest, what is the other way being above text as requirement..
>>> I do not see any requirement for us there. Forcing me to figure out
>>> how to add non-hardware property to DT is not the way to convince
>>> reviewers. But if you insist - we have ABI for this, called sysfs. If
>>> it is debugging feature, then debugfs.
>> ramoops already support module params and a way to pass these parameters
>> from bootargs but it also need to know the hard-codes addresses, so,
>> doing something in sysfs will be again duplication with ramoops driver..
> Why do you need hard-coded addresses?
>
>> If this can be accommodated under ramoops, this will be very small
>> change, like this
>>
>> https://lore.kernel.org/lkml/20230622005213.458236-1-isaacmanjarres@google.com/
> That's also funny patch - missing bindings updated, missing CC DT
> maintainers.
>
> Best regards,
> Krzysztof
>
>
>
