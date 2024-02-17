Return-Path: <linux-kernel+bounces-70100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACA85930F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B1283AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962A80034;
	Sat, 17 Feb 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZwahyIe"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D71D6A4;
	Sat, 17 Feb 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708206738; cv=none; b=UN+0YBw5OrAq7mgLxxuQl/xm2zr39DdSN07Xsj7RcbZuY9oGl42RIZXJLj5pIM3v9mlgcKnDbhGV5HeeblD0Py9gsKAAdbM4DCD9DPl0OrbZ3QrFRoyAS6NAElGgDwbC5PV7Rr2ci5XqnWYAvVuZQFmreszBRSGqmMB5I7pUWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708206738; c=relaxed/simple;
	bh=4EU2dnNx1VAaqS1bc/A8wb3Pvl9E/U3xrq4FxtxR7iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIe3CMxb8LJjoeheEfRWcNVxE5yrLjK7Cq6G4Ixg8DnKCGcgaIKc7y7E6oa33SudIJp6PT2ywWYeLd6wOrC5KND1Z07O7t3iufmVMjflhSCkAO7ZQP6r6zqT5myWvZX5czyVkEld5NwLKoYlAhN3elW2ZWd9E3vFe3BxOzCli+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZwahyIe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71cb97937so32516435ad.3;
        Sat, 17 Feb 2024 13:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708206736; x=1708811536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Qwb2StICm1ZcfVY+px4vh8ou7p4ZZZWHOVLZwT01dpI=;
        b=fZwahyIeHaZcrmQ6rv1E958YtN/zBppI3j6VV1POd6raBQ3fl2PEPm/7NmUOw3Y62B
         7lLJDYDIZD7iaTZ+ATCkwNPKzhExHUIfzMyPidxeH+9lX//F2eBSC6i30wt+WVNTMkGz
         4pqWcddTKuZzo98vxUcS+ZDoQMZlYpBU7k4bVg/xSmk82TNpv92z1RjlrWGSqP09Xtay
         p71N4cCL+M4P1m6HnSPk4x2cpfnTUhFkWdy88/v9fSymI71rNsducvQkY4E8VNU3S3mY
         RTHrgaxYr8yeOEu0vKYBmO8O12LdfoAajZ1eTqkB+xZmLHE+yHkORT+eYhGQVmBINUNq
         xM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708206736; x=1708811536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qwb2StICm1ZcfVY+px4vh8ou7p4ZZZWHOVLZwT01dpI=;
        b=THrp7yWXOoyxs2uMDtonRf3bff3n+ShZdKAlHM0xXhZbWeN4sqlIwDpwkzQbEW1y+N
         Qov9spHlPCu/BmUyRjiXPqT5TI0hjRT78B8hlybDyGPi000rIPM7wPKQi9uC+6v+Zbiz
         k9zKgecNnEIYCbtls87RnVgnaWSdAuzpTHzB++w7C9HUQElkrZfJcOTxp0wQCe9JDopK
         aX2iUjsM1DIRAn8DR19Haq61Q7HKd7k8UkpQ913GUT2i0CEXJFau2HFGjnrmSjFbRtgL
         DikT1AI/AidsSCnOHnd+HR2DGZEFCSR4j8aOnMv8c3/SBuIGH7dV8nikvI0vpoj08yBX
         HLfA==
X-Forwarded-Encrypted: i=1; AJvYcCW0bhTujsvKd5EgdV4jZcgl3Uwsbsroub6cBaAG3KZ+THuHAePvKJFHodtx/jZ2cJKNh7xhz+fWwvwIygyeGyUlR2NmCzJMTayw2j8KRBB37Nwr0ygbkUd72I+qV+/EUR5diJdG+GYTM1Dqun7AnKntpcNsByX5YfhTFMXr6rVcbc/TAD2v
X-Gm-Message-State: AOJu0YzzzAVeFQ7kLBQ2hiqzJLSIzkCvT4irAOx8zdX9fVxlwkRP1/fd
	caQM5DDA4XTYVvTl93WW9qEhOVlL5e7xhSRVE0jxEidzu5hl0rsZeJjfpsu/
X-Google-Smtp-Source: AGHT+IH2ASY+qFz8XeL/g6ttM8ftfrgF9Cat49joO728RwRnuquL3fFhG+4cf6L7mHpsKK2tovY1RA==
X-Received: by 2002:a17:902:ce8e:b0:1db:d256:9327 with SMTP id f14-20020a170902ce8e00b001dbd2569327mr1899861plg.19.1708206735783;
        Sat, 17 Feb 2024 13:52:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e34500b001dba739d18esm1863058plc.95.2024.02.17.13.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 13:52:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <980b8f03-ede4-479c-bbbb-f896fbac5c4b@roeck-us.net>
Date: Sat, 17 Feb 2024 13:52:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tda38640: Add interrupt &
 regulator properties
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240214092504.1237402-1-naresh.solanki@9elements.com>
 <20240214-trinity-delouse-6dcd0b046895@spud>
 <0f1665e5-bae1-4a17-a976-cc225a28dad3@roeck-us.net>
 <20240214-dimly-wife-5b6239d4adec@spud>
 <b306a27e-505e-43d4-aaf8-ab31284a3396@roeck-us.net>
 <20240215-wildfire-dotted-a561e86a6054@spud>
 <9cc60b90-329b-4065-a3c8-74c208964d45@roeck-us.net>
 <20240217-studio-cytoplast-ca99a55e7a36@spud>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240217-studio-cytoplast-ca99a55e7a36@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 12:30, Conor Dooley wrote:
> On Sat, Feb 17, 2024 at 07:57:43AM -0800, Guenter Roeck wrote:
>> On 2/15/24 03:48, Conor Dooley wrote:
>>> On Wed, Feb 14, 2024 at 05:17:04PM -0800, Guenter Roeck wrote:
>>>> On 2/14/24 11:55, Conor Dooley wrote:
>>>> [ ... ]
>>>>>>> Why "vout0" if there's only one output? Is it called that in the
>>>>>>> documentation? I had a quick check but only saw it called "vout".
>>>>>>> Are there other related devices that would have multiple regulators
>>>>>>> that might end up sharing the binding?
>>>>>>>
>>>>>>
>>>>>> Primarily because that is what the PMBus core generates for the driver
>>>>>> because no one including me was aware that this is unacceptable
>>>>>> for single-output drivers.
>>>>>
>>>>> Is it unacceptable? If you're implying that I am saying it is, that's
>>>>> not what I was doing here - I'm just wondering why it was chosen.
>>>>> Numbering when there's only one seems odd, so I was just looking for the
>>>>> rationale.
>>>>>
>>>>
>>>> Given the tendency of corporate speak (aka "this was a good attempt" for
>>>> a complete screwup), and since this did come up before, I did interpret
>>>> it along that line. My apologies if that was not the idea.
>>>
>>> I'm not gonna go and decree that "vout0" is unacceptable, if it was
>>> called that in documentation that I had missed or was convention, I was
>>> just gonna say "okay, that sounds reasonable to me".
>>>
>>
>> "convention" only if lack of awareness how regulators are supposed to be named
>> is a convention.
> 
> They're "supposed" to be named whatever the binding says they are named,
> but as we've discovered none of these devices actually have bindings
> that allow regulators in the first place. I think they should be called
> whatever they're called in the documentation for the device, which in
> this case was "vout".
> 

I would agree. I'd even submit a yaml file extension for the affected drivers
to address that, but I realize that I am notoriously bad with doing that,
so I won't even try.

>>>> Still, I really don't know how to resolve this for existing PMBus drivers
>>>> which do register "vout0" even if there is only a single output regulator.
>>>
>>> I had a quick look at that series, none of the devices that I checked
>>> out there seem to have documented regulators at all. Some of the devices
>>> were only documented in trivial-devices.yaml. Relying on the naming of
>>> undocumented child nodes is a bug in those drivers & I guess nobody cares
>>> about dtbs_check complaints for those platforms. The example that was
>>> linked in the other thread doesn't even use a valid compatible :(
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts?id=8d3dea210042f54b952b481838c1e7dfc4ec751d#n21
>>> I guess it uses the i2c device ids to probe on that platform, or have
>>> I missed something there?
>>>
>>
>> I think that is correct. If I recall correctly, the I2C subsystem no longer
>> searches for compatible drivers by only looking at the device id in the
>> compatible node, so I guess one has to list "lm25066" instead of "ti,lm25066"
>> as compatible to get a match in the i2c subsystem. That is of course
>> completely wrong.
> 
> If the driver is probing based on i2c_device_id matching, is it correct to
> use DT to probe the regulators? (I don't know, that's not some sort of
> rhetorical question).

Looking into the lm25066 driver, it actually does support the "ti,lm25066"
compatible. Given that, I don't know why the dts file doesn't use it, especially
since the dts file was created after the compatible entry was added to the
lm25066 driver.

Guenter


