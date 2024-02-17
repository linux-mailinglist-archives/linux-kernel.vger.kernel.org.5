Return-Path: <linux-kernel+bounces-69952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248348590B8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A8A1B216CB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DF7CF12;
	Sat, 17 Feb 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIbL+x5d"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2081D7A726;
	Sat, 17 Feb 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708185468; cv=none; b=rrzd2WlJLRqCByKATXu+Xi8vEoIdG72kb/f8pTXVgLj+U7IBY99xhRJgcPQ29PwUrMvj3Y36u77Rp7ySIaBAKCAKwbXvRBY6w0XoTYeKsUg3zxddy6pdnckZZ/sGHtmWYhYE9Jbw9uXN3fg9a2XR0J/puKDxFTQCA0inLMdg2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708185468; c=relaxed/simple;
	bh=sJvJQ7glnVIPixzKtNg1y7ASTR+ZQ9wALqEaOySziDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jisusFMx5gBbgB6KYjXrPnrkOOKf3RTcEr/OgmsqcN2IMrtp02vgsIU5l7bREOqcOnOVG651sjxAfOGP4ZIL9qF7JG1jlGjQkBIMcGrZ5CdX8sFWORTBLVUG437+K0keQLg40MYk+Vxgqw+mS9apU6LqNPTbsQQq/NuJG40P2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIbL+x5d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dba177c596so13914535ad.0;
        Sat, 17 Feb 2024 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708185466; x=1708790266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7Sa186WciMV73gYAssqnn0qnbEOPG+Q9oPUwWeX7nw8=;
        b=dIbL+x5dFGCo09cZINrDehENk3DCjrZWPSzNBbC+8j1n+PP8TGCBk3tU78V6X/Eh6W
         iR0yXtBjC/2/wFY9h4rS8Rz72QWrn5t53nLvcpiXufhxGw+b/C959b9eNzV3SKSZhwyW
         ZcUqxylYE/Nnwe5jbyQtVvKs3PIETFsxkNHVJZJPu+6PepHsUtcXyJvSNH6T4Z46q7VP
         IwkOU6MiWaG8vGPtk2Zlp9FB8eqsJjX6VEJIv3WC3UxmKtB1k0o7og6bPjKadSANiVjV
         YZEfjeA7sveTuxsuSiVm4munQVZMDBevPll0ZElXAvkTPeUst7vi0fY3LXV/gGH8bDbV
         PcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708185466; x=1708790266;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Sa186WciMV73gYAssqnn0qnbEOPG+Q9oPUwWeX7nw8=;
        b=SrLu1140UF0RxtBKSnRkOtxDZBjcSMVw25/qhKKjE1lk0XhtuxujHtM9PV6sw0KI4i
         dZ6Z251OHI8W5454aiwRBC6YSoZSHGyTj7+EHS3j6iBAbIzVb7G8y6x+hj5u1HfZRYf+
         b8DtaO0/gc/di9Y6N3rvyJG37FD3mXPtPrbf4DTOf/hvn0f81lTsrRZlAeiSvhYX2Bt3
         DJ5mcZgFoO9BMkH2kSGMuDOjprCruD1nBnBvlrb8KE82gYH/yakl/hMoXa6RsnSTcDWh
         wSXiuVSBCL4uZP+j5SIonVko/CyWJYTKdTutBQ7dGdrGRICXnQAm01315jbJ4/OkLMnO
         c/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1xt/VUg2EQmY2mW5PBuJjGYs/dp0qLQdPSqWXPhc1nIZbUBUqR0lk4rf9ta0bKU+4Yb9rQg0bFmkZfn3P4LDaq0ttN3w3fCz3/aZ4GUJxAJhGpOncxO32QCVSBF7louqWdBckLOLn0pHpkI30wXXpN5pNKSNCrk4z8fzeWmyTqZlkN/5
X-Gm-Message-State: AOJu0YzhcmYE8uCHGty22KIBKFmIp+MLC01/zZb1lmSOfw1nASZ/VNz5
	jdGeC9if6VFJssFnof6Y3ErW7skkdGwLzR7ljY+nwr5noNZIChgu0mYQ7pIw
X-Google-Smtp-Source: AGHT+IFwPoTHyIrGWndglyQnnTe+dSWndXMKNjxwYEgxN+EWmafDTurRB6H8eo0a9rlTXoCecNW4pA==
X-Received: by 2002:a17:902:d501:b0:1da:18e0:29c6 with SMTP id b1-20020a170902d50100b001da18e029c6mr11243812plg.33.1708185466261;
        Sat, 17 Feb 2024 07:57:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090330c400b001db9cb62f7bsm1610809plc.153.2024.02.17.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 07:57:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9cc60b90-329b-4065-a3c8-74c208964d45@roeck-us.net>
Date: Sat, 17 Feb 2024 07:57:43 -0800
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240215-wildfire-dotted-a561e86a6054@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 03:48, Conor Dooley wrote:
> On Wed, Feb 14, 2024 at 05:17:04PM -0800, Guenter Roeck wrote:
>> On 2/14/24 11:55, Conor Dooley wrote:
>> [ ... ]
>>>>> Why "vout0" if there's only one output? Is it called that in the
>>>>> documentation? I had a quick check but only saw it called "vout".
>>>>> Are there other related devices that would have multiple regulators
>>>>> that might end up sharing the binding?
>>>>>
>>>>
>>>> Primarily because that is what the PMBus core generates for the driver
>>>> because no one including me was aware that this is unacceptable
>>>> for single-output drivers.
>>>
>>> Is it unacceptable? If you're implying that I am saying it is, that's
>>> not what I was doing here - I'm just wondering why it was chosen.
>>> Numbering when there's only one seems odd, so I was just looking for the
>>> rationale.
>>>
>>
>> Given the tendency of corporate speak (aka "this was a good attempt" for
>> a complete screwup), and since this did come up before, I did interpret
>> it along that line. My apologies if that was not the idea.
> 
> I'm not gonna go and decree that "vout0" is unacceptable, if it was
> called that in documentation that I had missed or was convention, I was
> just gonna say "okay, that sounds reasonable to me".
> 

"convention" only if lack of awareness how regulators are supposed to be named
is a convention.

>> Still, I really don't know how to resolve this for existing PMBus drivers
>> which do register "vout0" even if there is only a single output regulator.
> 
> I had a quick look at that series, none of the devices that I checked
> out there seem to have documented regulators at all. Some of the devices
> were only documented in trivial-devices.yaml. Relying on the naming of
> undocumented child nodes is a bug in those drivers & I guess nobody cares
> about dtbs_check complaints for those platforms. The example that was
> linked in the other thread doesn't even use a valid compatible :(
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts?id=8d3dea210042f54b952b481838c1e7dfc4ec751d#n21
> I guess it uses the i2c device ids to probe on that platform, or have
> I missed something there?
> 

I think that is correct. If I recall correctly, the I2C subsystem no longer
searches for compatible drivers by only looking at the device id in the
compatible node, so I guess one has to list "lm25066" instead of "ti,lm25066"
as compatible to get a match in the i2c subsystem. That is of course
completely wrong.

Guenter


