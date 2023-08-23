Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB27850AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjHWGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjHWGea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:34:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2381E50
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:34:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so4832217a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692772466; x=1693377266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MU3Isdowj+DsCsRlrrGGs3GBgTkRvi+kExV2JBgHR90=;
        b=o23yHBgavqwsKfMWauqdS8zT9YMRxkVFjiEKXjmj4j6hUI4WdoccYudq9NvCIxELcf
         QCej+RLHtSFdaoUMy9FcdIkhhaJgAryOukZvsAPAgf9YjDKf/Ric/YkAth8km0XawcUK
         oVyn635o9URUI8KhCuHpYeprJiQFPBdcWdy5V2bq3Msv1t1+Rp7+o4YZc28AfIgDEmNc
         TKhGGhelBDLji1b+CKOVCt52KRPDE0UvroOydQUzC2MrMq4R+8udpgYls8zju9SW3kAl
         +dGWWz+tskr9KiNtfSLSKfVuMWWkzt4Z9Lsc2g05a1azi2p8jozV6xJzY8/3A5TtZMOX
         ILcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692772466; x=1693377266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU3Isdowj+DsCsRlrrGGs3GBgTkRvi+kExV2JBgHR90=;
        b=iMyX79MN62eOooAnyrYGTwR+S0G3N7n7i8tpAvDihgc/8D0dQzZGY1wMwyVmv32hwk
         w8ZzsBO6Hq3yVrV8q3C7AzXoSEMunP733moH4enY0eOlkNGwV/JpTp3b0n8WK0EK7z0l
         lmWj4XG+m2aiHBUiGcQez6ergz2xGjjleO78emOToRk0T6n+ZZ8RcFbzCZyYm7nn7tNa
         OeXBzAoLEKZqBaFqmYWkJQzxg1kd8IMiS8Rjqd/N2B3cYgikRu4YIsUKrHDWXjtCyGaY
         hCyal+3Ry1QrwZgPkJlhIF8euj2NnHEgc13zs1tkbiP2iBNw8HISdt/xRHQvKEoEQxrs
         KvNQ==
X-Gm-Message-State: AOJu0YysFZjb4YeYadiF6j+WdqW617XaaHl3l7Ragqs1Z4bBNj7Z81Cp
        81llreKSxMwQaQbhSrUNNW09uA==
X-Google-Smtp-Source: AGHT+IHhCJI/QD2v/0J0GgF4dGdn1D5mczy3eQQZvyXb4T25R/URjCtxqGab14wd0CHLKC83O5A11A==
X-Received: by 2002:aa7:d3d2:0:b0:525:528d:836f with SMTP id o18-20020aa7d3d2000000b00525528d836fmr8428350edr.18.1692772466186;
        Tue, 22 Aug 2023 23:34:26 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id w3-20020a056402128300b005222c6fb512sm8862885edv.1.2023.08.22.23.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 23:34:25 -0700 (PDT)
Message-ID: <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
Date:   Wed, 23 Aug 2023 08:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Elson Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        rogerq@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 01:58, Elson Serrao wrote:
> 
> 
> On 8/19/2023 2:35 AM, Krzysztof Kozlowski wrote:
>> On 18/08/2023 21:16, Elson Serrao wrote:
>>>
>>>
>>> On 8/15/2023 10:44 PM, Krzysztof Kozlowski wrote:
>>>> On 14/08/2023 20:50, Elson Roy Serrao wrote:
>>>>> This property allows dwc3 runtime suspend when bus suspend interrupt
>>>>> is received even with cable connected. This would allow the dwc3
>>>>> controller to enter low power mode during bus suspend scenario.
>>>>>
>>>>> This property would particularly benefit dwc3 IPs where hibernation is
>>>>> not enabled and the dwc3 low power mode entry/exit is handled by the
>>>>> glue driver. The assumption here is that the platform using this dt
>>>>> property is capable of detecting resume events to bring the controller
>>>>> out of suspend.
>>>>>
>>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> index a696f23730d3..e19a60d06d2b 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>> @@ -403,6 +403,11 @@ properties:
>>>>>        description:
>>>>>          Enable USB remote wakeup.
>>>>>    
>>>>> +  snps,runtime-suspend-on-usb-suspend:
>>>>> +    description:
>>>>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>>>>> +      case even with the USB cable connected.
>>>>
>>>> This was no tested... but anyway, this is no a DT property but OS
>>>> policy. There is no such thing as "runtime suspend" in the hardware,
>>>> because you describe one particular OS.
>>>>
>>>> Sorry, no a DT property, drop the change entirely.
>>>>
>>>>
>>> Hi Krzysztof
>>>
>>> Sorry my local dt checker had some issue and it did not catch these
>>> errors. I have rectified it now.
>>>
>>> This dt property is mainly for skipping dwc3 controller halt when a USB
>>> suspend interrupt is received with usb cable connected, so that we dont
>>> trigger a DISCONNECT event. Perhaps a better name would reflect the true
>>> usage of this?
>>>
>>> Something like snps,skip-dwc3-halt-on-usb-suspend. dwc3 cores where
>>> hibernation feature is not enabled/supported can use this property
>>
>> So this is specific to DWC3 core, thus should be just implied by compatible.
>>
> 
> Hi Krzysztof
> 
> Apologies for not being clear. Below is the reasoning behind this dt entry.
> 
> When bus suspend interrupt is received and if usb cable is connected, 
> dwc3 driver does not suspend. The aim of this series is to handle this 
> interrupt when USB cable is connected to achieve power savings. OEMs 
> might have their own implementation in their glue driver to turn off 
> clocks and other resources when USB is not in use, thus saving power. 
> But since glue layer has dependency on dwc3 driver (parent-child 
> relationship) we need to allow dwc3 driver to NOT ignore the bus suspend 
> interrupt and let the dwc3 driver suspend (so that glue driver can 
> suspend as well)

All this describes current OS implementation so has nothing to do with
bindings.

> 
> Now it is the responsibility of glue driver to detect USB wakeup signal 
> from the host during resume (since dwc3 driver is suspended at this 
> point and cannot handle interrupts). Every OEM may not have the 
> capability to detect wakeup signal. 

Again, driver architecture.

> The goal of this dt property is for 
> the dwc3 driver to allow handling of the bus suspend interrupt when such 

DT properties are not "for the drivers".

> a capability exists on a given HW platform. When this property is

Each platform has this capability. If not, then it is
compatible-related, as I said before which you did not address.


> defined dwc3 driver knows that the low power mode entry/exit is 
> controlled by the glue driver and thus it can allow the suspend 
> operation when bus suspend interrupt is received.
> 
> For example on Qualcomm platforms there is a phy sideband signalling 
> which detects the wakeup signal when resume is initiated by the host.

So compatible-specific.

> Thus qcom platforms can benefit from this feature by defining this dt 
> property. (in a parallel discussion with Thinh N to come up with a 
> better name for this dt entry).

Thanks, with quite a long message you at the end admitted this is
compatible-specific. Exactly what I wrote it one sentence previously.

Best regards,
Krzysztof

