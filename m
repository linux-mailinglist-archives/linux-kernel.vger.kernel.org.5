Return-Path: <linux-kernel+bounces-143890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A398A3ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313221F2167A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B3E56471;
	Sat, 13 Apr 2024 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF6N3i2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599556446;
	Sat, 13 Apr 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044425; cv=none; b=kNx7hTv1XDb4/FMviQxJk2/rAKPJZR8cHmL70+dDoxkCSjxaoMSdPWko/A1y8w5pB1nfmVPK70HIxp6rv0gecCaw75vmO3HQ9EBR1r5iQgGxdlTO9j3Eegh1OZcsw+PYwBtagLDt1wZGWcKQk1EMihy6lEvjyk5iStUMHvhoNLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044425; c=relaxed/simple;
	bh=qAyRbbo4f0GT87cxJNkINLjKBToCQVPwqC0z+spTdxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8OoNp3XdJYqCga0gqDnkpgSnR/LWvQ5DweJixEWyffpK6VLoJygjDwtWHFvUQYYYc2Fn+3z8ADQath6Hwcpm+15bT7CaQH8RQUJLBGwmJty5zJIn3nyu8Kx4QJhjrmd2dRjBpgOqRcGRP2ZLhyoVMW9V/ICp2AW8x0VNqAmhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF6N3i2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86800C113CD;
	Sat, 13 Apr 2024 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044425;
	bh=qAyRbbo4f0GT87cxJNkINLjKBToCQVPwqC0z+spTdxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vF6N3i2ZXMLHC7I1MqlPUj0ow1ivoLEcwDOmwUCjUhI/H8vtxhlplEL5khz4et7WU
	 acMeiR+eBs9p7roWlz41+ZdhqD1/DggYy9leD+fu8oPU6n2pFG85g+NCBCHNllBhkd
	 BosHxo/pHIdeBDLwQsVL5PMvTxu8Uuu42E1pRNsN4wIkHYL2bUzLk+UdsBcuIiew7f
	 LRsVNP3FpSplN+BVmQ/TlvBvlTpMOROdLD5fPAOjSNLKvFe+qWrceEuxHwR0/IQxoV
	 OddXZ9gWiqH5MEIR0UBxuGwJjqmt5AKFbBcyps6kWRh2uiEq4WMfowULhP2dphOAoU
	 uYLnMJ8pd6FrA==
Message-ID: <46fe43d0-28be-4acb-b0d4-dacd84fef8e5@kernel.org>
Date: Sat, 13 Apr 2024 23:40:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: add PMIC_RST_B
 warm reset property
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matteo Lisi <matteo.lisi@engicam.com>,
 Mirko Ardinghi <mirko.ardinghi@engicam.com>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org> <ZhjhCvVNezy9r7P4@engicam>
 <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org> <Zhq8ibYrZH05/AQt@engicam>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zhq8ibYrZH05/AQt@engicam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 19:10, Fabio Aiuto wrote:
> Dear Krzysztof,
> 
> Il Sat, Apr 13, 2024 at 12:58:35PM +0200, Krzysztof Kozlowski ha scritto:
>> On 12/04/2024 09:21, Fabio Aiuto wrote:
>>> Dear Krzysztof,
>>>
>>> Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
>>>> On 11/04/2024 18:58, Fabio Aiuto wrote:
>>>>> Add property to trigger warm reset on PMIC_RST_B assertion
>>>>>
>>>>
>>>> That's rather vague and does not tell me much why this is supposed to be
>>>> board level configuration. It sounds more like a debugging feature:
>>>> during development you want to retain memory contents for pstore etc.
>>>> Then I could imagine this should be turned runtime, e.g. via
>>>> sysfs/debugfs, because for example you want to start inspecting a
>>>> customer's device.
>>>
>>> thanks, I spent too few time writing this commit log and I apologize
>>> for that. I was thinking about something like:
>>>
>>>     The default configuration of the PMIC behavior makes the PMIC
>>>     power cycle most regulators on PMIC_RST_B assertion. This power
>>>     cycling causes the memory contents of OCRAM to be lost.
>>>     Some systems needs some memory that survives reset and
>>>     reboot, therefore add a property to tell PMIC_RST_B is
>>>     wired.
>>>
>>> The actual configuration is made at probe time, anyway we need
>>> to override the default behavior of the pmic to get a warm reset
>>> everytime the PMIC_RST_B pin is asserted and this property tells
>>> us that "something is wired to that pin" and "it has to behave
>>> that way on pin assertion". Our use cases do not meet the need
>>> of further runtime configuration change.
>>
>> What is the use case?
> 
> I just have an external power button connected to that pin, it works
> either with warm reset and cold-reset-except-ldo12. Moreover the default behavior
> is cold reset and not reset-disabled. Anyway I thought it was useful for other
> people to add a property selecting behavior for that pin too as was done for
> WDOG_B. That's why I mainly duplicated the logic. If there is a pin adding a
> reset source it's a good point to provide a way to access the register bits
> related to this signal.

I don't understand what is the use case. You wrote runtime does not
solve your use case. What is the use case?

> 
>>
>> Sorry, you did not bring any further argument why this is board
>> specific. And please don't explain how probing works, but address the
>> problem here: why type of reset is specific to board design. To me it is
>> OS policy.
>>
> 
> Why reset type is specific to board design? I'm sorry but I don't know
> what you mean, as said my intention was to enlarge the number of configurable
> bits in pca9450 register space hoping this would be useful for someone.
> 
> All I can say is that is specific to board design for the same reason the
> wdog_b- reset type was specific to board design.

Specific to board design means different boards have somehow different
configuration/schematics/layout/hardware meaning they need this property
to configure device differently.

I already said it implicitly, but let's reiterate: Devicetree is for
hardware properties, not OS policies.

I also said, so repeating the same argument, the choice how you want to
reboot the system based on button press, sounds like debugging choice
thus runtime suits better.

Unless you want to say there are two signals and you want to configure
them differently? But that's your job to explain it, not mine.

Best regards,
Krzysztof


