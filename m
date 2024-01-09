Return-Path: <linux-kernel+bounces-20667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA582833C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79EC282CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1A0358AE;
	Tue,  9 Jan 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAWOrMam"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95882E840
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5574feb7958so3080806a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704792740; x=1705397540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wah4snQswmGnEFvSDedAhSiW9BcRrZuT8Gd1vEO9mU=;
        b=CAWOrMammDW7y4JI0PSYOIUyYvEwUNU4iuF9bdBQGuc7z9EMx/OMtNKz/meENclhFH
         ffuPXUlmtw/WYeNHLbqHnj+CkJt3M9hKi9f9mNSe8wJy6wkhVVKN/mJca/+9GFdRrUdO
         aPEj+DTSH1UWBrW1S8sBRbBl7YAFBm6myDo2CO3ayvWyNHJfI28dXUCZQ0kwCOVPvNrn
         U4UrmZ/fdkFAfgI2edvYeo3w+M4Nq03bDPEK2m6iwk44aiAJQo0FDsI41ic3KTihfx+H
         s7RGZJ0ifG7pfUNPjI9brn/jz+ZLbWsTDnGPqwUR/a6I87behnZIWDbzsKM48G2fzGmK
         llOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792740; x=1705397540;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wah4snQswmGnEFvSDedAhSiW9BcRrZuT8Gd1vEO9mU=;
        b=Z4t3xl/pGdijIjIKAXwOD2RtJsblIBf/eGt162KvOD+qVsbTCVWJWe5y/KQpATWC7b
         4CoUSu6q6nzNlS3/KkViUgcexdB/adhRe9u3Mp3HgPpyvxeWxSgvXpoMM3OIo4jHJA72
         fkje4Ntl5BP98hCwXrSTgsIKbxyeFryrU5Tkht7pVWXPUWGVcSOjtibhKPYLvM27BmX/
         v+KZgyI4h9rQkRVlK+q9vdXSg9sO+vC/bfDnTdv4B8xn+OLit36g1Q3y2H3vvEGYGwBK
         NWYLvZYLUEeOIKzZqDzYaIE1zg+eAW9Bb3jKqOFCMgYr6AByCLq1tYkDJ7hntI4dl19K
         lznw==
X-Gm-Message-State: AOJu0YysZPvxqTC1FpsYaGC32FAUNxQyIh8DpoFKKzV0jLniSVVdpm5k
	xgGRUI7ZAK0gEO9GqtSjq4ik8iRt10sQmA==
X-Google-Smtp-Source: AGHT+IHWUgEzQ3qgJUmV7H5rZQgg8+oLvCSvlqVWTHttJ95r8LjS1Mg6cW/tXSaDGLnuO/Q3JfX+eA==
X-Received: by 2002:a50:a69a:0:b0:553:35f8:e143 with SMTP id e26-20020a50a69a000000b0055335f8e143mr2905308edc.67.1704792740236;
        Tue, 09 Jan 2024 01:32:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402180700b0055706e6b1f5sm750018edy.89.2024.01.09.01.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 01:32:19 -0800 (PST)
Message-ID: <a1d20997-d09b-464c-8d23-0b7a15972a2b@linaro.org>
Date: Tue, 9 Jan 2024 10:32:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
Content-Language: en-US
To: Elad Nachman <enachman@marvell.com>, Conor Dooley <conor@kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240107152557.3561341-1-enachman@marvell.com>
 <20240108-zoning-tactical-20501dccfac1@spud>
 <BN9PR18MB425195C57E2FC24D5F331C19DB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20240108-chariot-thinner-7a86808a0571@spud>
 <BN9PR18MB42513EDDDA454FA50249205BDB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BN9PR18MB42513EDDDA454FA50249205BDB6B2@BN9PR18MB4251.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 19:15, Elad Nachman wrote:
> 
> 
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel.org>
>> Sent: Monday, January 8, 2024 8:01 PM
>> To: Elad Nachman <enachman@marvell.com>
>> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
>>
>> On Mon, Jan 08, 2024 at 05:47:24PM +0000, Elad Nachman wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Conor Dooley <conor@kernel.org>
>>>> Sent: Monday, January 8, 2024 7:15 PM
>>>> To: Elad Nachman <enachman@marvell.com>
>>>> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
>>>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>> devicetree@vger.kernel.org; linux-usb@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: [EXT] Re: [PATCH] dt-bindings: usb: Add Marvell ac5
>>>>
>>>> External Email
>>>>
>>>> --------------------------------------------------------------------
>>>> -- On Sun, Jan 07, 2024 at 05:25:57PM +0200, Elad Nachman wrote:
>>>>> From: Elad Nachman <enachman@marvell.com>
>>>>>
>>>>> Add Marvell ac5 device tree bindings to generic EHCI.
>>>>> This compatible enables the Marvell Orion platform code to
>>>>> properly configure the DMA mask for the Marvell AC5 SOC.
>>>>>
>>>>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>>>>
>>>> Maybe I am dumb, but I don't understand how this does what the
>>>> commit message says. There's no fallback to generic-ehci or any
>>>> other compatible that is already understood by the driver.
>>>>
>>>> What am I missing?
>>>
>>> Following guidance by Andrew Lunn on my mmc patchset, I have split the
>>> patchset Into a single patch for dt-bindings review and another for USB
>> driver review.
>>
>> I don't understand that advice. dt-bindings should (almost) always be with
>> the driver. Otherwise you just confuse people like me.
>>
>> Perhaps Andrew meant sending dt*s* patches separately from the driver &
>> bindings?
> 
> The rational was different people making the actual merge, into different intermediate git REPOs, before mering into linux-next.

Sorry, but NAK. The submitting-patches for bindings expresses this as
well: bindings go with the driver.

There was never an advice from Andrew about splitting binding. He
clearly said that FIRST PATCH, so the DTS, goes via separate tree.
Absolutely nothing about splitting the binding.

https://lore.kernel.org/all/cfbbe706-5953-488c-9bff-f72f6d00b44f@lunn.ch/


Best regards,
Krzysztof


