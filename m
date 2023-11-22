Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC997F4A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbjKVPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjKVPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:34:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5C19AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:33:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso4331599f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700667225; x=1701272025; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UuQvOTpszbnl9xc14Mv8OCjwyDXBhMf4cf+TfzzFh8s=;
        b=M+fdnRMSfbREYLsxZySK1YDhCykXVPOf34aVZwtskZQgVjM2SA57gTtv7dg2nbMgTE
         9rqOEHr6tKLIaZndEXfdta+yvSqso1SlBaK5aZAbmARqUxBsqRUaCObXCKflb7jJsPEA
         0O2t/7V5H/TR8KekQBkblQODbVxZqFxacTi5LfsSNA5JqtAfWqBfhlGLprgT7LuH9qDW
         NKr2QISYzrRBxvCj2jLUT3WqZEFOGvjQdnpMezHMN6IoiEUCKATDGnqbiecDCpDjmJbl
         fkF97B27Oecuk/q9JUbUDWj2N6TJaSOzsmBJE/BWebx2ttm3RRbsuVuE86CkVDfHx7QI
         5cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667225; x=1701272025;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuQvOTpszbnl9xc14Mv8OCjwyDXBhMf4cf+TfzzFh8s=;
        b=a8ALzxIfcFOvcOcSrVepEZrUgodkhGyCEPgSrLYYzJ8I4acHdLU4iQIfupccpznvNH
         O7qg7JjEU75WamoS9Gwk6S0P/wLfGOIhuou/WqiNWp4rF5l0lGyXYODbEjH1/QZulHzV
         kBeuYiQuWUnpBoLpYfoixhk4r5enVS43m9o6Ta0pdo2b5vjQMK4yK9OPTwu8stVf7EL0
         eMCB1J5zTCuHe/9bX+zVxZMdAIxdZX4d5X2F0MYo9SEBUoA59ljivE7h9a9ZXqgjQsSw
         zPjGry7BqPPmMg4qkGr6LxyLl4sOdIgHNyUv3mSNQtomxF/r24EilZDq6ouNVSZNzBS8
         Dpuw==
X-Gm-Message-State: AOJu0YzTiIgYbCcABNhi+kfmhMQB1DxCVCcFXLW/J5BBNAdpi5cz6yEa
        lpSYYtvG/pxuEnojYHWOBoVYEA==
X-Google-Smtp-Source: AGHT+IGRjDRpoRtRtIfGUdaJ+t+pi8yzkvfovHszDmXGHtyXVw/hFFAzNajS8qufz+N2FTEE3zfaGg==
X-Received: by 2002:a5d:620c:0:b0:332:c2ae:ca1e with SMTP id y12-20020a5d620c000000b00332c2aeca1emr1673659wru.62.1700667224696;
        Wed, 22 Nov 2023 07:33:44 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:d0a1:9a3c:4f4b:fa20])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d65d0000000b00332cc7c3aaasm5969561wrw.21.2023.11.22.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:33:44 -0800 (PST)
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
User-agent: mu4e 1.10.7; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, neil.armstrong@linaro.org,
        Rob Herring <robh@kernel.org>,
        JunYi Zhao <junyi.zhao@amlogic.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: pwm: amlogic: add new compatible
 for meson8 pwm type
Date:   Wed, 22 Nov 2023 16:23:25 +0100
In-reply-to: <2bbc2031-89d7-42e9-828e-068fa06eabf4@linaro.org>
Message-ID: <1jo7flerag.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 22 Nov 2023 at 16:04, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 22/11/2023 15:34, Jerome Brunet wrote:
>> 
>> On Wed 22 Nov 2023 at 09:37, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> 
>>> On 20/11/2023 11:04, Jerome Brunet wrote:
>>>>>>>>>    .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 36 +++++++++++++++++--
>>>>>>>>>    1 file changed, 34 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>>>>
>>>>>>>
>>>>>>> I'm puzzled, isn't it recommended to have a per-soc compatible now ?
>>>
>>> Yes, it is.
>>>
>>>>>> I have specifically addressed this matter in the description,
>>>>>> haven't I ? What good would it do in this case ?
>>>
>>> There is nothing about compatible naming in commit msg.
>> 
>> Krzysztof, the whole commit desciption is explanation about why a new
>> compatible is introduced. I don't understand this comment.
>> 
>>>
>>>>>
>>>>> Yes you did but I was asked for the last year+ that all new compatible
>>>>> should be soc specific (while imprecise, in our care soc family should be ok),
>>>>> with a possible semi-generic callback with an IP version or a first soc
>>>>> implementing the IP.
>>>>>
>>>>>> Plus the definition of a SoC is very vague. One could argue that
>>>>>> the content of the list bellow are vaguely defined families. Should we
>>>>>> add meson8b, gxl, gxm, sm1 ? ... or even the actual SoC reference ?
>>>>>> This list gets huge for no reason.
>>>>>
>>>>> I think in our case soc family is reasonable since they share same silicon
>>>>> design.
>>>>>
>>>>>> We know all existing PWM of this type are the same. We have been using
>>>>>> them for years. It is not a new support we know nothing about.
>>>>>>
>>>>>>>
>>>>>>> I thought something like:
>>>>>>> - items:
>>>>>>>      - enum:
>>>>>>>          - amlogic,gxbb-pwm
>>>>>>>          - amlogic,axg-pwm
>>>>>>>          - amlogic,g12a-pwm
>>>>>>>      - const: amlogic,pwm-v1
>>>>>> I'm not sure I understand what you are suggesting here.
>>>>>> Adding a "amlogic,pwm-v1" for the obsolete compatible ? No amlogic DT
>>>>>> has that and I'm working to remove this type, so I don't get the point.
>>>>>>
>>>>>>>
>>>>>>> should be preferred instead of a single amlogic,meson8-pwm-v2 ?
>>>>>> This is named after the first SoC supporting the type.
>>>>>> Naming it amlogic,pwm-v2 would feel weird with the s4 coming after.
>>>>>> Plus the doc specifically advise against this type of names.
>>>>>
>>>>> The -v2 refers to a pure software/dt implementation versioning and not
>>>>> an HW version, so I'm puzzled and I requires DT maintainers advice here.
>>>>>
>>>>> Yes meson8b is the first "known" platform, even if I'm pretty sure meson6 has
>>>
>>> Yes, this should be SoC-based compatible, unless you have clear
>>> versioning scheme by SoC/IP block vendor. You named it not a HW version,
>>> which kind of answers to the "unless" case - that's not hardware version.
>>>
>> 
>> This is specifically the point of the comment in commit description.
>> We know all the PWMs compatible are the same HW (version) as one found
>> in the meson8b.
>> 
>> It is certain that adding more compatible, listing all the SoC, will be
>> useless. I can do it if you insist.
>
> The docs you references insist on that, so yeah, I insist as well.
>
>> 
>>>>
>>>> This is not my point. I picked this name because I have to pick a
>>>> specific device based one. Not because it is actually the first or
>>>> not. I don't see a problem with meson6 being compatible with
>>>> meson8-pwm-v2, if that ever comes along.
>>>
>>> No, the point is not to use "v2". Use SoC compatibles.
>> 
>> It is a SoC compatible. The second one.
>
> "v2" is not the soc. I assume meson8 is one specific SoC, right? Because
> elinux says it is a *family*:
> https://elinux.org/Amlogic/SoCs
>

It is a family. yes

>
>> 
>> The first one, as explained in the description was describing the driver
>> more that the HW.
>> 
>> Changing the way clock are passed from DT to the driver would be break
>> user of the old compatible. So a new compatible is introduced. I believe
>> this is recommended way to introduce incompatible binding changes.
>
> The way is not to introduce incompatible changes. Your way is also not
> good as it breaks other users of DTS.
>
>> 
>> v2 here denote a new interface version, nothing to do with HW
>> versioning. I happy to pick something else to denote this.
>
> Sorry, then it is not a SoC-based compatible.
>
>> 
>>>
>>>>
>>>> I think the binding here satisfy the rule that it should be specific,
>>>> and the intent that goes with it:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n42
>>>>
>>>>> the same pwm architecture, this is why "amlogic,pwm-v1" as fallback seems more
>>>>> reasonable and s4 and later pwm could use the "amlogic,pwm-v2"
>>>>> fallback.
>>>>
>>>> That is not how understand this:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/writing-bindings.rst?h=v6.7-rc2#n82
>>>>
>>>
>>> Again, where the "v2" is defined? Where is any document explaining the
>>> mapping between version blocks and SoC parts? Why do you list here only
>>> major version? Blocks almost always have also minor (e.g. v2.0).
>> 
>> Again, v2 does has nothing to do with the HW. Never wrote it was.
>> The HW remains the same.
>
> Don't add compatibles which are not related to HW, but represent
> software versioning. Software does not matter for the bindings.

What I did I explicitly what is recommended in Grant's presentation from
2013. 10y old, but I assume slide 10 "Making an incompatible update" is
still valid.

https://elinux.org/images/1/1e/DT_Binding_Process_glikely_ksummit_2013_10_28.pdf

Breaking the ABI of the old compatible would break all boards which use
u-boot DT and pass it to the kernel, because the meaning of the clock
property would change.

Doing things has suggested in this slide, and this patch, allows every
device to continue to work properly, whether the DT given is the one
shipped with u-boot (using the old compatible for now) or the kernel.

>
> That's a clear NAK.
>
> Best regards,
> Krzysztof

