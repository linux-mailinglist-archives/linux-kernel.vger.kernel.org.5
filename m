Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D41785279
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjHWIOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjHWIF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480D1728;
        Wed, 23 Aug 2023 01:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F3E65339;
        Wed, 23 Aug 2023 08:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10BC433C8;
        Wed, 23 Aug 2023 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692777874;
        bh=R0NniC3YGbpWCvZzcQoqRftt0uacgvxvVQpoUeVXp98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VQm+jx59G2GKxWpZ/PqQvUvdINvltFLq8ZUj7x21yIKAz1ntedr9YvXYiF3b4jwxB
         MyQ30MyzGAhXdxd3TObjbrFyd5rVDfKLX8728alE+l3b46hdPj+3mSRn8wtxNHhI/b
         XuFcfszPi9F01NnFKyJXUqY0PsHnvuSUDGAb959fsBqYOSnF3UPwOyiczvjXvE73aH
         6H6LvfSP/OMWlBd0brrlx5b4Nnh13s3yT0rrEz3vH1pF73qPke7N+bWxTwcMp1k3Oi
         WERhru4OJIh+YHVD42reEnAcFtl4qpOxfLdyODURW8wlLjJ3ESQtnKsLEnGtjPv8Ut
         DNwI7z0kbGqYA==
Message-ID: <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
Date:   Wed, 23 Aug 2023 11:04:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Elson Serrao <quic_eserrao@quicinc.com>,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2023 09:34, Krzysztof Kozlowski wrote:
> On 23/08/2023 01:58, Elson Serrao wrote:
>>
>>
>> On 8/19/2023 2:35 AM, Krzysztof Kozlowski wrote:
>>> On 18/08/2023 21:16, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/15/2023 10:44 PM, Krzysztof Kozlowski wrote:
>>>>> On 14/08/2023 20:50, Elson Roy Serrao wrote:
>>>>>> This property allows dwc3 runtime suspend when bus suspend interrupt
>>>>>> is received even with cable connected. This would allow the dwc3
>>>>>> controller to enter low power mode during bus suspend scenario.
>>>>>>
>>>>>> This property would particularly benefit dwc3 IPs where hibernation is
>>>>>> not enabled and the dwc3 low power mode entry/exit is handled by the
>>>>>> glue driver. The assumption here is that the platform using this dt
>>>>>> property is capable of detecting resume events to bring the controller
>>>>>> out of suspend.
>>>>>>
>>>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>>>> ---
>>>>>>    Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>>>>>>    1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> index a696f23730d3..e19a60d06d2b 100644
>>>>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>>>>> @@ -403,6 +403,11 @@ properties:
>>>>>>        description:
>>>>>>          Enable USB remote wakeup.
>>>>>>    
>>>>>> +  snps,runtime-suspend-on-usb-suspend:
>>>>>> +    description:
>>>>>> +      If True then dwc3 runtime suspend is allowed during bus suspend
>>>>>> +      case even with the USB cable connected.
>>>>>
>>>>> This was no tested... but anyway, this is no a DT property but OS
>>>>> policy. There is no such thing as "runtime suspend" in the hardware,
>>>>> because you describe one particular OS.
>>>>>
>>>>> Sorry, no a DT property, drop the change entirely.
>>>>>
>>>>>
>>>> Hi Krzysztof
>>>>
>>>> Sorry my local dt checker had some issue and it did not catch these
>>>> errors. I have rectified it now.
>>>>
>>>> This dt property is mainly for skipping dwc3 controller halt when a USB
>>>> suspend interrupt is received with usb cable connected, so that we dont
>>>> trigger a DISCONNECT event. Perhaps a better name would reflect the true
>>>> usage of this?
>>>>
>>>> Something like snps,skip-dwc3-halt-on-usb-suspend. dwc3 cores where
>>>> hibernation feature is not enabled/supported can use this property
>>>
>>> So this is specific to DWC3 core, thus should be just implied by compatible.
>>>
>>
>> Hi Krzysztof
>>
>> Apologies for not being clear. Below is the reasoning behind this dt entry.
>>
>> When bus suspend interrupt is received and if usb cable is connected, 
>> dwc3 driver does not suspend. The aim of this series is to handle this 
>> interrupt when USB cable is connected to achieve power savings. OEMs 
>> might have their own implementation in their glue driver to turn off 
>> clocks and other resources when USB is not in use, thus saving power. 
>> But since glue layer has dependency on dwc3 driver (parent-child 
>> relationship) we need to allow dwc3 driver to NOT ignore the bus suspend 
>> interrupt and let the dwc3 driver suspend (so that glue driver can 
>> suspend as well)
> 
> All this describes current OS implementation so has nothing to do with
> bindings.
> 
>>
>> Now it is the responsibility of glue driver to detect USB wakeup signal 
>> from the host during resume (since dwc3 driver is suspended at this 
>> point and cannot handle interrupts). Every OEM may not have the 
>> capability to detect wakeup signal. 
> 
> Again, driver architecture.

This is not driver architecture but SoC (hardware) architecture.
Most SoCs have some kind of Wrapper h/w logic around the USB h/w module
where they implement such logic like power/clocking/wake-up handling etc.
So this information (whether wake-up is supported or not)
should be already known to the respective Wrapper driver.

Now the missing part is how to convey this information to the USB (DWC3)
driver so it behaves in the correct way.

> 
>> The goal of this dt property is for 
>> the dwc3 driver to allow handling of the bus suspend interrupt when such 
> 
> DT properties are not "for the drivers".
> 
>> a capability exists on a given HW platform. When this property is
> 
> Each platform has this capability. If not, then it is
> compatible-related, as I said before which you did not address.
> 
> 
>> defined dwc3 driver knows that the low power mode entry/exit is 
>> controlled by the glue driver and thus it can allow the suspend 
>> operation when bus suspend interrupt is received.
>>
>> For example on Qualcomm platforms there is a phy sideband signalling 
>> which detects the wakeup signal when resume is initiated by the host.
> 
> So compatible-specific.
> 
>> Thus qcom platforms can benefit from this feature by defining this dt 
>> property. (in a parallel discussion with Thinh N to come up with a 
>> better name for this dt entry).
> 
> Thanks, with quite a long message you at the end admitted this is
> compatible-specific. Exactly what I wrote it one sentence previously.
> 
> Best regards,
> Krzysztof
> 

-- 
cheers,
-roger
