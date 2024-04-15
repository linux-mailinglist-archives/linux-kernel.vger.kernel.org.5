Return-Path: <linux-kernel+bounces-145726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516598A5A11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12BD1F21663
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69054155A34;
	Mon, 15 Apr 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxCVRvUC"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9241C66;
	Mon, 15 Apr 2024 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206578; cv=none; b=jGSder63V7VEUFeRv+3Phz81FiZ/P5PUJi4wQSSX/I24yQoS/TItJ3tAvnMXlpH75qHIr0MEfFmfkf/3CIfZiC9VuxNIBCN/udsELi8mqeBCWoagjUlaTtQXNFIa9Vj4UzIV7zP2QbZMCnZWc45qPTMzLqdXVb2+7s29AVDaXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206578; c=relaxed/simple;
	bh=EnqOoZM7L8zRE+BK2z5fuu0GrAXBtnQ2sj9vwnH40v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFegHzkc2t7sAKoktUK70JccEnOL12Wbjc66cGXlKAgv0z3xzK7/7XtItw6zmJqQwlHVEQbtv7o32adZrlivhbdtXj3mHC664pxlBjufUGUGVw1SIZ4epZGtBoYydzC50s/aBFqj2NjKdEjTO0gF4sBy6BrisuyyywerJ2iR8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxCVRvUC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78a26aaefc8so204308985a.1;
        Mon, 15 Apr 2024 11:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713206575; x=1713811375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGoxailyTpgB4eKluQu/uwPbaDpkuYYqm0F0TBg4t0c=;
        b=XxCVRvUC6PF799qEnc3QTBjfpfk6SsNpDvFZH6YN53Pd2jeIY/QSJmR0w/e+qaNJcc
         pLLqu+cFT6DxhPsI9Mas64gKr+qJZEckg/0Qf7ZtcuNWcd1z/AmlUZ3FPHrR3FN58hN7
         +cjsJ5X8VLFFCylzDWA5NKF2ErNUR1pnrHxhD2BPXgK5utFrf1vJklHJJldabI8y5bk1
         IVMXSEuQlzrgdb+eD+o3mo3Mw7R1r2KxO5jIWArKQSi7z2oXVb3ImEAkZwCcF6qT/zVN
         DT6LrOD/0lvDJAkijWnNuKE6WZwxxwAxGpFZ4tIEWJJMIowoFIVSh6eOKRxlHxdMhVc3
         ZeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206575; x=1713811375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGoxailyTpgB4eKluQu/uwPbaDpkuYYqm0F0TBg4t0c=;
        b=jl/lmbxGJa83OebGgWuzp2iUeFDf8Wt+Wcx3C0nZk5J0WKD7mMSWxsMdB81iv5s+pz
         Lx18NpbP8qJgqcT3sOUA5HikxQnJ7knI523QrpD2mseNfimLrHBr6GeGD5mKPPaLt04B
         2LS/zGkgAE7OwzZR0ev0+G9GzEMAZbdBL1kjhbyuGnBiKvP/dkTMGSCn7uC6YpWaQhUJ
         3ObLX8U4IUFW4+VsC+enr8f0deE0PMNkaLZFCQ7KA3SNLTLp099TwOsGjQU6beIAiPTR
         q0Lo+oaYr2SSRrlr/afLPIfUVc17Kw+KxXaYPDcyq+fdTKCr8lF8SZ78Ci8Vm2auCExm
         n+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEGGslqsJsGqRstY8/ng6DTbSdui5HPV2sTW+XWqS/w1whWlo3aDN9CiFO9QxotX9t83OzZTZEXrolXKQTvDZ76+fyqwTd2336EBUenSayjKcYSGZ7BkmauOV2yn3GLqNRMrefPOG1sJZNnTFxaoLeiJl/E/N0I6supf19/NrX8fx07Q==
X-Gm-Message-State: AOJu0YxUsSM68CMUoy1hoIcWqE2xaolPYIJtG5SvopPBWcXa0UpXrleF
	m/ofLLZv6qgK3/CTSSWsaJcB3+AAX/+HnJS3NYlzmgGyv3GxJjVb7S+JzA6n
X-Google-Smtp-Source: AGHT+IGawbigy7PbNYzEZN26Vu2SWoLy7YVkHzY1QZcH8HIQQvnNHigFdc+o7KqMhHVXO/XuYgEqEg==
X-Received: by 2002:a05:620a:8202:b0:78e:e52c:6b83 with SMTP id ow2-20020a05620a820200b0078ee52c6b83mr3738353qkn.3.1713206575127;
        Mon, 15 Apr 2024 11:42:55 -0700 (PDT)
Received: from [192.168.0.137] ([79.119.110.83])
        by smtp.gmail.com with ESMTPSA id w14-20020ae9e50e000000b0078ebe12976dsm6666910qkf.19.2024.04.15.11.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:42:54 -0700 (PDT)
Message-ID: <89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
Date: Mon, 15 Apr 2024 21:42:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
 <CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
 <20240406155328.447b594f@jic23-huawei>
 <64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
 <20240413114825.74e7f3fa@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240413114825.74e7f3fa@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/04/2024 13:49, Jonathan Cameron wrote:
> On Tue, 9 Apr 2024 11:08:28 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 06/04/2024 17:53, Jonathan Cameron wrote:
>>> On Wed, 3 Apr 2024 10:40:39 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   
>>>> On Wed, Apr 3, 2024 at 2:43 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:  
>>>>>
>>>>> On 01/04/2024 22:37, David Lechner wrote:    
>>>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:    
>>>>>>>
>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>    
>>>>>
..
>>
>>>>> Other alternative that came to my mind: attribute "adi,current-channel".    
>>>>
>>>> Having a boolean flag like this would make more sense to me if we
>>>> don't agree that the suggestion below is simpler.
>>>>  

..

> 
> We do directly relate reg to channel numbers in drivers like the ad7292 (where not
> all channels are differential)  I'm not convinced either way on what is best
> here where reg is currently just an index into a channel specification, not
> meaningful for which pins are involved.
> 
> It doesn't seem worth adding an equivalent of diff-channels for a single channel
> setup but I guess it would be more consistent.
> 

Would you agree with the attribute adi,current-channel within the channel and
 diff-channels set to the correspondent current inputs (13 10 for pair IN2)?

>>
>>>>  
>>>>>    
>>>>>>> +
>>>>>>> +          Family AD411x supports a dedicated VCOM voltage input.
>>>>>>> +          To select it set the second channel to 16.
>>>>>>> +            (VIN2, VCOM) -> diff-channels = <2 16>    
>>>>>>
>>>>>> The 411x datasheets call this pin VINCOM so calling it VCOM here is a
>>>>>> bit confusing.
>>>>>>    
>>>>>
>>>>> Sure, I'll rename to VINCOM.
>>>>>    
>>>>>> Also, do we need to add a vincom-supply to get this voltage? Or is it
>>>>>> safe to assume it is always connected to AVSS? The datasheet seems to
>>>>>> indicate that the latter is the case. But then it also has this
>>>>>> special case (at least for AD4116, didn't check all datasheets)
>>>>>> "VIN10, VINCOM (single-ended or differential pair)". If it can be used
>>>>>> as part of a fully differential input, we probably need some extra
>>>>>> flag to indicate that case.
>>>>>>    
>>>>>
>>>>> I cannot see any configuration options for these use cases. All inputs
>>>>> are routed to the same mux and routed to the differential positive and
>>>>> negative ADC inputs.
>>>>>
>>>>> "VIN10, VINCOM (single-ended or differential pair)" the only difference
>>>>> between these two use cases is if you connected VINCOM to AVSS (with
>>>>> unipolar coding) or not with bipolar encoding. The channel is still
>>>>> measuring the difference between the two selected inputs and comparing
>>>>> to the selected reference.
>>>>>    
>>>>>> Similarly, do we need special handling for ADCIN15 on AD4116? It has a
>>>>>> "(pseudo differential or differential pair)" notation that other
>>>>>> inputs don't. In other words, it is more like VINCOM than it is to the
>>>>>> other ADCINxx pins. So we probably need an adcin15-supply for this pin
>>>>>> to properly get the right channel configuration. I.e. the logic in the
>>>>>> IIO driver would be if adcin15-supply is present, any channels that
>>>>>> use this input are pseudo-differential, otherwise any channels that
>>>>>> use it are fully differential.
>>>>>>    
>>>>>
>>>>> I cannot seem to understand what would a adcin15-supply be needed for.
>>>>> This input, the same as all others, enters the mux and is routed to
>>>>> either positive or negative input of the ADC.
>>>>>
>>>>> The voltage on the ADCIN15 pin is not important to the user, just the
>>>>> difference in voltage between that pin and the other one selected.
>>>>>
> 
> That statement is the root of disagreement I think.
> If they are wired for pseudo differential measurement ADCIN15 a reference voltage
> not a varying signal. It can equally be used as a negative channel of
> a differential pair.   Not different from point of view of hardware
> config, but potentially different from point of view of how the
> analog wiring is done and how we may want to present it to userspace.
> 
>>>>
>>>> These suggestions come from some recent discussion about
>>>> pseudo-differential vs. fully differential inputs (e.g. search the IIO
>>>> mailing list for AD7380).
>>>>
>>>> So what I suggested here might be more technically correct according
>>>> to what I got out of that discussion. But for this specific case, I
>>>> agree it is good enough to just treat all inputs as always
>>>> fully-differential to keep things from getting too unwieldy.  
>>>
>>> Hmm.  That whole approach to pseudo differential does get messy if
>>> we have the common line routed through the main MUX rather than an opt
>>> in only on the negative side.  
>>>
>>> If I read this right, its almost a trick to support a pseudo differential
>>> wiring with simple registers (I guess reflecting MUX limitations).
>>>
>>> So what could we do?
>>>
>>> We could assume that VINCOM is used like a conventional pseudo
>>> differential negative signal and have supply-vincom + non diffferential
>>> channels if that's the configuration wanted.
>>>
>>> Then for differential channels can support all the VINX VINX+1
>>> and swapped options.
>>> For VIN10 it gets fun as non differential and differential options
>>> I think map to same actual config.   Don't see reason we need to express
>>> that in the binding though so let that have VIN10 VINCOM (probably using
>>> a magic channel number) and  VIN10 pseudo differential.
>>>
>>> Similar setup for ADCIN15 equivalent usage
>>>
>>> Code wise this probably won't be particular hard to support in the driver
>>> (obviously I haven't tried though :) is it worth the effort to keep
>>> it inline with other devices that support pseudo differential channesl.  
>>
>> Then this would need to be done to any fully differential ADC as support
>> for pseudo differential channels is present (connect a fixed non 0 voltage
>> to the negative input).
> 
> Whilst you could argue that, I'd counter that a clearly stated pseudo
> differential mode with a simple choice of negative input (typically
> only one pin is used for these modes), is a feature of the ADC, rather
> than a wiring choice such as tying all negative inputs together and to
> a reference supply.
> 
>>
>> The AD717x family supports pseudo differential channels as well... should
>> this change be applied to them too? It is just the case that the documentation
>> does not mentions this use case.
> 
> Maybe you could argue that if we used the REF- for the negative input.
> Otherwise I think it falls into the category where there isn't a clearly defined
> pseudo differential mode.
> 

While re-reading docs I've noticed that AD7176-2 mentions pseudo differential usage:
"Pseudo Differential Inputs
 The user can also choose to measure four different single-ended
 analog inputs. In this case, each of the analog inputs is converted
 as being the difference between the single-ended input to be
 measured and a set analog input common pin. Because there is
 a crosspoint multiplexer, the user can set any of the analog inputs
 as the common pin. An example of such a scenario is to connect
 the AIN4 pin to AVSS or to the REFOUT voltage (that is, AVSS
 + 2.5 V) and select this input when configuring the crosspoint
 multiplexer. When using the AD7176-2 with pseudo differential
 inputs, the INL specification is degraded."

As the crosspoint mux is present on all models it really makes me think that this
paragraph applies to all models in the family

>>
>> I think that a distinction needs to be made here:
>> - When a device is only pseudo differential, sure, it is in a different category
>> - When a device is fully differential and you are using it as pseudo-differential
>>   you are having two inputs compared to one another
>>
>> I would need more clarification is why would supply-vincom be a requirement.
>> The voltage supplied to VINCOM will not be used in any computation within 
>> the driver. From the perspective of getting the data it doesn't matter if 
>> you are using the channel in a pseudo-differential, single ended or fully
>> differential manner.
> 
> I'd missed until now that the datasheet (I looked ad4114) says aincomm should be connected to analog
> ground so indeed nothing to turn on in this case and no offset to supply
> (the offset will be 0 so we don't present it).
> 
> I'll note the datasheet describes the VINCOM as follows.
> 
> Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when the inputs are configured
> as single-ended.  Connect AINCOM to analog ground.
> 
> The reference to single ended is pretty clear hint to me that this case
> is not a differential channel. The more complex case is the one David
> raised of the AD4116 where we have actual pseudo differential inputs.
> 

Alright, from my perspective they all pass through the same mux but okay,
not differential. The only issue would differentiating cases in AD4116 where
the pair VIN10 - VINCOM is specified as single-ended or differential pair.

Also, AD4116:
"0101101111 ADCIN11, ADCIN15. (pseudo differential or differential pair)
 0110001111 ADCIN12, ADCIN15. (pseudo differential or differential pair)
 0110101111 ADCIN13, ADCIN15. (pseudo differential or differential pair)
 0111001111 ADCIN14, ADCIN15. (pseudo differential or differential pair)"

Not really sure where the "actual pseudo differential" sits.

Would you agree with having device tree flags that specifies how is the
channel used: single-ended, pseudo-differential, differential.
For the first two, the differential flag will not be set in IIO.

>>
>> Regarding VINX VINX+1, it is not mandatory to respect those, from AD4111 page27:
>> "Due to the matching resistors on the analog front end, the
>>  differential inputs must be paired together in the following
>>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
>>  VIN6 and VIN7. If any two voltage inputs are paired in a
>>  configuration other than what is described in this data sheet,
>>  the accuracy of the device cannot be guaranteed."
> 
> OK, but I'll assume no 'good' customer of ADI will do that as any support
> engineer would grumpily point at that statement if they ever reported
> a problem :)
> 
>>
>> Tried the device and it works as fully differential when pairing any
>> VINx with VINCOM. Still works when selecting VINCOM as the positive
>> input of the ADC.
>>
>> I really see this as overly complicated and unnecessary. These families
>> of ADCs are fully differential. If you are using it to measure a single ended
>> (Be it compared to 0V or pseudo differential where you are comparing to Vref/2
>> and obtaining results [Vref/2 , -Vref/2]) the final result will not require knowing
>> the common voltage.
> 
> For single ended VINCOM should be tied to analog 0V.  If the chip docs allowed
> you to tie it to a different voltage then the single ended mode would be offset
> wrt to that value.
> 
> For the AD4116 case in pseudo differential mode, You would need an ADCIN15 supply because
> that is not connected to analog 0V.  If the device is being used in a pseudo differential
> mode that provides a fixed offset voltage.
> 
> So my preference (though I could maybe be convinced it's not worth the effort)
> is to treat pseudo differential as single ended channels where 'negative' pin is
> providing a fixed voltage (or 0V if that's relevant).  Thus measurements provided
> to userspace include the information of that offset.
> 

What do you mean by offset? I currently understand that the user will have
a way of reading the voltage of that specific supply from the driver. 

If you mean provide a different channel offset value when using it as
pseudo-differential then I would disagree


> We haven't handled pseudo differential channels that well in the past, but the
> recent discussions have lead to a cleaner overall solution and it would be good
> to be consistent going forwards.  We could deprecate the previous bindings in
> existing drivers, but that is a job for another day  (possibly never happens!)
> 

I really hope that a clean solution could be obtained for this driver as well :) 



