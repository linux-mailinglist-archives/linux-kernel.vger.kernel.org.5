Return-Path: <linux-kernel+bounces-116781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDC88A3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A041F3D6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361F717821F;
	Mon, 25 Mar 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoGuhJrW"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055E18E0E9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360740; cv=none; b=dJBpRixxRXbeYPkXeVidx7BL1Gj4iJJu/KM+J4UJdPybggyZ9Zjw9KghPQ6ZJMSO/Mu192jWvP+xGGc2eH+vzFALiKtIZ7+mxy363UWwT1RIOxbGYbbdhifGFdO9cCd+V85xTzCm548uWAumObZFdEyGKt0TyV2jYtJD0pRy6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360740; c=relaxed/simple;
	bh=0HodlRK92+uecruCh4htnK2LTN1iC+38uJY7KjoYeFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqcB/NLGLzzqPjcg2fhu59F6XJcxSaJ6lmw88IyzPgoXRfDSjf3ye5Goir6mC3T9Umq6ued5+PzsuF29OJiUNFvOeqIQnyzAa54IGKoTLws5G6kTtHm5Bjl7L6ATUVDbwPEDnJUr25zAnbdsrdfQymjWvNa9PnvTkyGeU9JCF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IoGuhJrW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512ed314881so2950598e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711360735; x=1711965535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvul6s5HtP/ZlpqUVoqPGz55enL0nlUDBRgMBFp+K5w=;
        b=IoGuhJrWwts8QDjyyl+JjGcnDGR+kOu7Eev/rHRxxC4ko3+OG7s3L0ld7MjqWpTWJ7
         /mXqeBJaEjWLnQ2DyG/9uKkkUcdKQ8suAqblcFfMOfe5ibw8juTyE0/UksMjmFAx5oVJ
         woMgFjxN06osvSDXIbh99De75fJzu574WRXjhwDLB0t3UhjDSTR8GFsrJT9WMFWJh3jT
         KCnZYREPo10ynXZEiXy76WFMHsE/KdmaEP3HOPkqP4/c56eS+A5+VAJOffU88HiWi4QR
         beTXvcv47AwGZeQznX7Yf9GRQ/y/k3WF0TMoUlyABxXYSLwx0EZ2E0BJDQJWxnHV9Xbq
         EySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711360735; x=1711965535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvul6s5HtP/ZlpqUVoqPGz55enL0nlUDBRgMBFp+K5w=;
        b=v7OGG5YEKxBGqq97fG0o0/Kj4Bvhe1WHxxqNzpzwUCMRfxP2ueAqDk0jAsTCDhoPKz
         ST+B5m286AT6kk6Gjm06bOPZ3hTWmpEv3v1ComTOCwk9YcrhBOgt9AIT0JCpAQPo1cnw
         2+WFSn0nqPSBtYNiYYRg3Wv58AkXpL0Y3u1/OUdPiP1RGgwzeP8M73KmS1PRJDTsKZZp
         cnjhSMOD8IdaWWoBvFWsNb9hBK8aT8jNMKBgKhRsW7gb97dDaTDKWIbbw+NwnPe6bgqz
         vOfB6xjWkEDX4x6V4oAS0K17pUlsgdcuYADvvUKMxUSt/MvrQ8+lCl3Jz8wgR2VIfHiv
         /gpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBtEPx7VT59vupIEINI+7imZuLy3E/HABID5JGG/8hKI1VHBlOHRWKo4kWAcpSNq0Hy+aTaIk3+wHQD9DNDpeJPt70vhrsBhD9BvfG
X-Gm-Message-State: AOJu0YzVVGzqueb6cnyzgoDFajx0ABinrCn3XN9PFUdPdUfC2DxGpdh6
	rnj66dY6t1l451LsDdpQxmVKZDCCGgPc/2Ds387jfxhZhKP5rniO+8Vtu1PNIatNeAGF2Ic00/u
	4
X-Google-Smtp-Source: AGHT+IGzb3SBz6tSy5Lr7i7F/Sz3cD4j3aUG8XDPJWjEsVe9L0DAU0zPAgHOII3D8qom8JbnUMqTbw==
X-Received: by 2002:a19:2d41:0:b0:513:cdde:18f9 with SMTP id t1-20020a192d41000000b00513cdde18f9mr4422360lft.54.1711360735218;
        Mon, 25 Mar 2024 02:58:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25059000000b005132bf9f8dcsm1011799lfm.303.2024.03.25.02.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:58:54 -0700 (PDT)
Message-ID: <178594a2-cd5f-4608-aae6-7d68fd0817e0@linaro.org>
Date: Mon, 25 Mar 2024 10:58:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
To: Andrej Picej <andrej.picej@norik.com>, haibo.chen@nxp.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
References: <20240320100407.1639082-1-andrej.picej@norik.com>
 <20240320100407.1639082-3-andrej.picej@norik.com>
 <38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
 <e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
 <7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
 <40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
 <a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
 <1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 10:58, Andrej Picej wrote:
> On 22. 03. 24 09:14, Krzysztof Kozlowski wrote:
>> On 22/03/2024 08:39, Andrej Picej wrote:
>>> On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:
>>>> On 20/03/2024 13:05, Andrej Picej wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:
>>>>>> On 20/03/2024 11:04, Andrej Picej wrote:
>>>>>>> Document calibration properties and how to set them.
>>>>>>
>>>>>> Bindings are before users.
>>>>>
>>>>> will change patch order when I send a v2.
>>>>>
>>>>>>
>>>>>> Please use subject prefixes matching the subsystem. You can get them for
>>>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>>>>> your patch is touching.
>>>>>> There is no file extension in prefixes.
>>>>>
>>>>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?
>>>>
>>>> Did you run the command I proposed? I don't see much of "/", but except
>>>> that looks good.
>>>
>>> Ok noted.
>>>
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>>>> ---
>>>>>>>     .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
>>>>>>>     1 file changed, 15 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>>> index dacc526dc695..64958be62a6a 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>>> @@ -46,6 +46,21 @@ properties:
>>>>>>>       "#io-channel-cells":
>>>>>>>         const: 1
>>>>>>>     
>>>>>>> +  nxp,calib-avg-en:
>>>>>>> +    description:
>>>>>>> +      Enable or disable averaging of calibration time.
>>>>>>> +    enum: [ 0, 1 ]
>>>>>>> +
>>>>>>> +  nxp,calib-nr-samples:
>>>>>>> +    description:
>>>>>>> +      Selects the number of averaging samples to be used during calibration.
>>>>>>> +    enum: [ 16, 32, 128, 512 ]
>>>>>>> +
>>>>>>> +  nxp,calib-t-samples:
>>>>>>> +    description:
>>>>>>> +      Specifies the sample time of calibration conversions.
>>>>>>> +    enum: [ 8, 16, 22, 32 ]
>>>>>>
>>>>>> No, use existing, generic properties. Open other bindings for this.
>>>>>
>>>>> You mean I should use generic properties for the ADC calibration
>>>>> settings? Is there already something in place? Because as I understand
>>>>> it, these calib-* values only effect the calibration process of the ADC.
>>>>
>>>> Please take a look at other devices and dtschema. We already have some
>>>> properties for this... but maybe they cannot be used?
>>>>
>>>
>>> I did look into other ADC devices, grep across iio/adc, adc bindings
>>> folders and couldn't find anything closely related to what we are
>>> looking for. Could you please point me to the properties that you think
>>> should be used for this?
>>
>> Indeed, there are few device specific like qcom,avg-samples. We have
>> though oversampling-ratio, settling-time-us and min-sample-time (which
>> is not that good because does not use unit suffix).
> 
> Ok, these are examples but I think I should not use them, since these 
> are i.MX93 ADC specific settings, which are used for configuration of 


No vendor prefix, so they rather should be generic, not imx93
specific... But this the binding for imx93, so I don't understand your
statement.

> calibration process, and are not related to the standard conversion 
> process during runtime. Calibration process is the first step that 
> should be done after every power-on reset.
> 
>>
>> Then follow up questions:
>>   - nxp,calib-avg-en: Why is it a board-level decision? I would assume
>> this depends on user choice and what kind of input you have (which could
>> be board dependent or could be runtime decision).
> 
> Not really sure I get your question, so please elaborate if I missed the 
> point.
> This is a user choice, to enable or disable the averaging function in 
> calibration, but this is a board-level decision, probably relates on 
> external ADC regulators and input connections. The same options are used 
> for every ADC channel and this can not be a runtime decision, since 
> calibration is done before the ADC is even registered.

You now mix how Linux driver behaves with hardware. Why you cannot
recalibrate later, e.g. when something else is being connected to the
exposed pins?

Best regards,
Krzysztof


