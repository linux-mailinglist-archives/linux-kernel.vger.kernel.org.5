Return-Path: <linux-kernel+bounces-167431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE658BA986
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D6D1F23056
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7814EC7B;
	Fri,  3 May 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2bxxaql"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BA14EC61;
	Fri,  3 May 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727483; cv=none; b=Mf8Vz1575K+k/tW5vc959RoPD1scT1BdU7KsfXJo48QxkB9bcn+k2F/+jfuilR8i+odFyFp8t889LRtAIrWyAWhUowIhK/gAgF5zzijZUiNrYhpvoNrlcvc1r1g0cqcFAq2ME7bjk7qHL7dx9NimpP5i0umf75lrxQvkuKdszG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727483; c=relaxed/simple;
	bh=VizUIb/OLvF1/i6uxSjEVxNNv4bH0BlLFRFnbhZrHoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLJDwiNqQMOyKmaRrjJ2mYPAVwVW8xoR7ZuzIXxd4ikYkN9NNi1DKq/GRgoCxRjlxp2Ib+qh/25Ygc7Xf36AQ2BnB7RKT2chRZqaPaPKftmTYK8nZwIrhEFTymc7K4uOfM2lGB4GTr8qaiRHYyNJ3yHaH58gT4svhDyGaV5U/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2bxxaql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A57C4AF14;
	Fri,  3 May 2024 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727483;
	bh=VizUIb/OLvF1/i6uxSjEVxNNv4bH0BlLFRFnbhZrHoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C2bxxaqlPCCCktx4zWYgfeVigiW4irgVLzFAy9Qa2UpEhqgm+wgrzwXraXaAqlP5e
	 RKPGRS6C8+IRtOw/8SM7GVFiv6FTEp0p+438mrrOdWyeaKl0L3jXPWZwSYoEvGcugo
	 2NQIYCsSBhza0a9/zpIFHx2csBjkVN4UDkA5AHX/rlkjjjQAwfEMzH3oLYuQ4hAnE4
	 hcj10/JTz9Y9BnLLZ82J3u/3AbCfs9DlHcDPScXHEZV93L2vS4mVIQdF4/F35xjNJn
	 br7JsZ3QGIesj4nBz5Y8ZvP+/hMkxHtfOkxwb0CWeXSWXJNQ5mypySfGtuZ5ssXK7M
	 +6rV+3qDNB7Tw==
Message-ID: <48ec0bb5-a06e-4f18-97c3-1370b7facea4@kernel.org>
Date: Fri, 3 May 2024 11:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] dt-bindings: HID: i2c-hid: elan: add
 'no-reset-on-power-off' property
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423134611.31979-1-johan+linaro@kernel.org>
 <20240423134611.31979-4-johan+linaro@kernel.org>
 <2e67e4e6-83a7-4153-b6a7-cdec0ab2c171@kernel.org>
 <Zii2CUeIyBwxzrBu@hovoldconsulting.com>
 <bde4884c-117b-4e6e-8c7b-401b8320655b@kernel.org>
 <ZjNjMBNMegmTgN5B@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZjNjMBNMegmTgN5B@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 11:56, Johan Hovold wrote:
> Hi Krzysztof,
> 
> and sorry about the late reply. Got side-tracked.
> 
> On Thu, Apr 25, 2024 at 11:39:24AM +0200, Krzysztof Kozlowski wrote:
>> On 24/04/2024 09:34, Johan Hovold wrote:
>>> On Tue, Apr 23, 2024 at 06:29:44PM +0200, Krzysztof Kozlowski wrote:
>>>> On 23/04/2024 15:46, Johan Hovold wrote:
>>>>> When the power supply is shared with other peripherals the reset line
>>>>> can be wired in such a way that it can remain deasserted regardless of
>>>>> whether the supply is on or not.
> 
>>>>> This is important as it can be used to avoid holding the controller in
>>>>> reset for extended periods of time when it remains powered, something
>>>>> which can lead to increased power consumption. Leaving reset deasserted
>>>>> also avoids leaking current through the reset circuitry pull-up
>>>>> resistors.
>>>>>
>>>>> Add a new 'no-reset-on-power-off' devicetree property which can be used
>>>>> by the OS to determine when reset needs to be asserted on power down.
>>>>>
>>>>> Note that this property can also be used when the supply cannot be
>>>>> turned off by the OS at all.
>>>
>>>>>    reset-gpios:
>>>>>      description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
>>>>>  
>>>>> +  no-reset-on-power-off:
>  
>>>> Anyway, the property sounds like what the OS should be doing, which is
>>>> not what we want. You basically instruct driver what to do. We want a
>>>> described hardware configuration or hardware specifics.
>>>
>>> Right, and this was why I at first rejected a property name like this in
>>> favour of 'reset-pulled-to-supply' in my first draft. That name
>>> obviously does not work as the 'supply' suffix is already claimed, but I
>>> also realised that it doesn't really describe the hardware property that
>>> allows the reset line to remain asserted.
>>>
>>> The key feature in this hardware design is that the reset line will not
>>> just be pulled to the supply voltage (what other voltage would it be
>>> pulled to), but that it is also pulled to ground when the supply is
>>> disabled.
>>
>> OK, if the property was specific to the hardware, then I would propose
>> something more hardware-related, e.g. "reset-supply-tied". However :
>>
>>> Rather than trying to encode this in the property name, I settled on the
>>> descriptive 'no-reset-on-power-off' after the seeing the prior art in
>>> 'goodix,no-reset-during-suspend' property. The latter is too specific
>>> and encodes policy, but the former could still be considered hardware
>>> description and would also apply to other designs which have the
>>> property that the reset line should be left deasserted.
>>>
>>> One such example is when the supply can not be disabled at all (e.g. the
>>> Goodix case), but I can imagine there being more than one way to design
>>> such reset circuits.
>>
>> It seems it is common problem. LEDs have property
>> "retain-state-shutdown", to indicate that during system shutdown we
>> should not touch them (like power off). Would some variant be applicable
>> here? First, do we talk here about power off like system shutdown or
>> runtime PM, thus suspend?
> 
> A name like 'retain-state-shutdown' would also be too specific as what
> I'm describing here is that the reset line should be (or can be) left
> deasserted whenever the OS wants to power off the device.

I don't think it is more specific than yours. It is actually more
generic. First, shutdown=poweroff, so that part is the same.
retain-state means keep things enabled, asserted, deasserted, etc, so
multiple cases. Your wording is specific - only one state is kept during
power off: reset deassert.

Best regards,
Krzysztof


