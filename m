Return-Path: <linux-kernel+bounces-71395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE1185A484
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AF828240E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E3D36129;
	Mon, 19 Feb 2024 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2rPqSdp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46D8364A1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708348763; cv=none; b=OSx2DMnPBuPu6apM1YwW7bbBeLNWrt3VH80S5AGCV3K6NJlexX80g8xBR6DcWJUyS63qQ5iuTMtWjx5Yf6AT8wahrxaHG+o3BOD1rsPIUzHs1ueTh5hB6V3bRm85fmZzDC6h7bx9RDyCkoOrxsPkhuGVqYGXx1I6sX9l69+rvbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708348763; c=relaxed/simple;
	bh=vbqrXHGvWgLKgfURRIJTGp0HJVdWwZ8whGGl+yPEuUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIe9lgl186RUwtXRh7YoPjEMcb5in9s1Y5DfT4z3Ah7cbVSHbyeceH0JyRryfs8CaY55yNPNlL+Z7lhPJwzuhnVprUuXvrgK2ozKCpfqZaKHKb1pFHWzN/5wv/6MSxNLn3PE9kN50juqPi/D823bLWa8FJptSo8KPK8p6jc8J80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2rPqSdp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b29f82d1so1362094e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708348760; x=1708953560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1Ifl7v049WCduXQumlbXHHgTzV347e7K2w69qz5kIg=;
        b=U2rPqSdpBo6yO6Wj9qQzG4C1MbdvEJrOSm52MvkhL0lwPN3HKXq60Ic0nu74kNRYmw
         P8bHNcKRBe8LRdpkPzpkoBkT/VZkZwbU2me3e3gdEn4OrB7aB/XmRR6b9A0edPohow2O
         blKEweacNfe033dNGXZZxT9Of8ixNS5zT6OQjFjLA9hn+4YPnmmoPX6gA8YDYwMXxFmF
         cJEpMQYAXKOpaCfrzz18GhjsN2V7Ye4HMnjz/RPeVXDihJBy/Hhi12T2z6u+5K9AZLGz
         q1nV7llm6WRkMk3j3iLi/pgXK7PzxTa+LiwxjAvOMvA8fV275Vn42PfmiEdsYz5K5cIc
         YvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708348760; x=1708953560;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Ifl7v049WCduXQumlbXHHgTzV347e7K2w69qz5kIg=;
        b=FYT/mUzEOx1CHXHXnS/gKw+SDTAVOP3NmZKQAQ8xDFXh1byikr2f0YS20tz+d5QCMV
         JdR30Rgk+t/t3QeqK1R/CbVMnvGT2wIvQDMGkZjqMlY3bHKOqS/KyMfwPBiWQPG6igmV
         18XfliIAqLrsmGqhvfgxjznLTUARQvdybSjnu4CvMNC2OO2VTir8fTCJMpZiNtB7P72v
         HNCU3CvYZ6A1xpfKYp4enzxGmx/78A9nBr2U6lPlgVuvI/2OAMBnpfk7s4R9sND6etQF
         eCKp+7DeZqDd1J/0+4zJzhZ1NHDHitMIsp37yMklWkBUKZZD1cRxotDUqRFcWi8sNZfK
         g2aA==
X-Forwarded-Encrypted: i=1; AJvYcCVzDxw9SirmwPjAlFzJN7K/qp31yf7X41YH6uwthTHalOFc24voOEMv4YqjdO3I3WOtMv3F3m2XHTpgT6gVt1fIDul9x5vOwKEUjITB
X-Gm-Message-State: AOJu0YwiIlM+ypnnr7kNa6x9jO3PBopwBqj7f5E+w6GzDNNMzeVcgPr3
	1dxiluFU5Pz30iBLsWkScnqa7n71kDhAdWoBOJEbdcDVQqnJuGBzs+33l7jpqjw=
X-Google-Smtp-Source: AGHT+IEKJtnrG8HPSqihCKkFPRv3ecErckY+8bLrNPJDukNTEAkukkkfxtAR0UoY66DAorJcHYKXSg==
X-Received: by 2002:a19:8c1e:0:b0:512:a371:3b27 with SMTP id o30-20020a198c1e000000b00512a3713b27mr4105084lfd.13.1708348759987;
        Mon, 19 Feb 2024 05:19:19 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b004120537210esm11283177wmg.46.2024.02.19.05.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 05:19:19 -0800 (PST)
Message-ID: <3f26624b-7c1d-43cb-a729-5fb50d184046@linaro.org>
Date: Mon, 19 Feb 2024 14:19:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
 <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
 <ed59671f-6e0b-45a2-bae7-38f7b4b7e625@amd.com>
 <ebcfd49d-f810-4d9b-8cba-b55071fc7fa6@linaro.org>
 <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <96c0f613-7c53-4189-bfc8-7d572b308b9f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2024 14:11, Michal Simek wrote:
> 
> 
> On 2/17/24 09:26, Krzysztof Kozlowski wrote:
>> On 16/02/2024 10:42, Michal Simek wrote:
>>>
>>>
>>> On 2/16/24 10:19, Krzysztof Kozlowski wrote:
>>>> On 16/02/2024 09:51, Michal Simek wrote:
>>>>> RTC has its own power domain on Xilinx Versal SOC that's why describe it as
>>>>> optional property.
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>> ---
>>>>>
>>>>>    Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>
>>>> But Versal is not described in this binding, is it? I see only one
>>>> compatible.
>>>
>>> It is the same IP only as is on zynqmp with own power rail.
>>
>> Then you should have separate compatible, because they are not
>> identical. It would also allow you to narrow the domains to versal and
>> also require it (on versal).
> 
> I can double check with HW guys but I am quite sure IP itself is exactly the 
> same. What it is different is that there is own power domain to it (not shared 
> one as is in zynqmp case).

What does it mean shared one? If several devices share power domain,
then they all should have power-domains property.

> 
> Also Linux is non secure sw and if secure firmware won't allow to change setting 
> of it it can't be required. I am just saying that Linux doesn't need to be owner 
> of any power domain that's why it shouldn't be required property.


Best regards,
Krzysztof


