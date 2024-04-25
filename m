Return-Path: <linux-kernel+bounces-158315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7218B1E35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD931F211AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAD8614D;
	Thu, 25 Apr 2024 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm1GSJi/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944485269;
	Thu, 25 Apr 2024 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037972; cv=none; b=MVL4rXEz9okFBN60f8T6W6fKs+M0uRXlcQeoFg37enWG9rdScqCEDPs3Fowbo19GDFMPyNQ4DxcoQ80k6s+DWnWjUNGE/vkGOyUcCPE1DNX8yqGsaj5i24uHg0ssiebulK8sjBLQ17Rc+MrbjH/6i8MeRsSh/oXR+eSowz4vyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037972; c=relaxed/simple;
	bh=T7SvUzXNPNaghOVhRL4B9Uz9WmnB5ZSjgpxjLxrL+5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1zUxdzLdCo5Vexhypk8LfoQU1hKwpwk8dKT2CvX18ONTISVeQUGlaMRSheHlTz+0Jm8AefGc773dJeahvdQ/cRDvGuSa0kKcuh/iG2plB/cAH2TAMqiankaBs6gneLs+d8i5kgTWzfzrjvXdGZ+AyuRVMR2ET6yw2ejIBi0pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm1GSJi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F33C113CC;
	Thu, 25 Apr 2024 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714037971;
	bh=T7SvUzXNPNaghOVhRL4B9Uz9WmnB5ZSjgpxjLxrL+5M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tm1GSJi/iuVx4IbFOzTr3vtqSh5XzrLL1XU/Hp4KmTZJlzoTPuQybRrw2ib5hJhzc
	 hHD8SgemxwTh81dlj2SQeXFrnLDjBUWFRKvm75E7WEnX0zn/Y5bO8wRfjnvJ7+eBwT
	 yvzWJf7qdSOu2VVBzJigvGMV0Si+ND+/Y750uqbHFL0ol8p7q9Bx1F5ot7a+ifjYYk
	 I2kvumO5sKxEcvOz8oQERj6KM6CYOuxJiar9e5CUhVzw9daMMhGy2t0Pbwms1fwPuZ
	 G3ytUWiShsTl+/eT/7NuibyFlGUFmQFM8IJVrhyvldRG0Yeqi0ow4PxnsLP3Fu9oh2
	 +8zQRvc3EUm9g==
Message-ID: <bde4884c-117b-4e6e-8c7b-401b8320655b@kernel.org>
Date: Thu, 25 Apr 2024 11:39:24 +0200
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zii2CUeIyBwxzrBu@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 09:34, Johan Hovold wrote:
> On Tue, Apr 23, 2024 at 06:29:44PM +0200, Krzysztof Kozlowski wrote:
>> On 23/04/2024 15:46, Johan Hovold wrote:
>>> When the power supply is shared with other peripherals the reset line
>>> can be wired in such a way that it can remain deasserted regardless of
>>> whether the supply is on or not.
>>
>> To clarify: the reset line is still present and working in such case?
> 
> Yes.
> 
>>> This is important as it can be used to avoid holding the controller in
>>> reset for extended periods of time when it remains powered, something
>>> which can lead to increased power consumption. Leaving reset deasserted
>>> also avoids leaking current through the reset circuitry pull-up
>>> resistors.
>>>
>>> Add a new 'no-reset-on-power-off' devicetree property which can be used
>>> by the OS to determine when reset needs to be asserted on power down.
>>>
>>> Note that this property can also be used when the supply cannot be
>>> turned off by the OS at all.
> 
>>>    reset-gpios:
>>>      description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
>>>  
>>> +  no-reset-on-power-off:
>>
>> Missing vendor prefix. Unless you want to re-use existing property
>> "keep-power-in-suspend", but the case here mentions power off, not suspend.
> 
> No, I left out the prefix on purpose as I mentioned in the cover letter.
> There is nothing vendor specific about this property and I expect it to
> be reused for other devices.
> 
> And "keep-power-in-suspend" is too specific and indeed looks like
> instruction to the OS rather than hw description (more below), but
> importantly it is not related to the problem here (which is about
> reset, not power).
>  
>> Anyway, the property sounds like what the OS should be doing, which is
>> not what we want. You basically instruct driver what to do. We want a
>> described hardware configuration or hardware specifics.
> 
> Right, and this was why I at first rejected a property name like this in
> favour of 'reset-pulled-to-supply' in my first draft. That name
> obviously does not work as the 'supply' suffix is already claimed, but I
> also realised that it doesn't really describe the hardware property that
> allows the reset line to remain asserted.
> 
> The key feature in this hardware design is that the reset line will not
> just be pulled to the supply voltage (what other voltage would it be
> pulled to), but that it is also pulled to ground when the supply is
> disabled.

OK, if the property was specific to the hardware, then I would propose
something more hardware-related, e.g. "reset-supply-tied". However :


> Rather than trying to encode this in the property name, I settled on the
> descriptive 'no-reset-on-power-off' after the seeing the prior art in
> 'goodix,no-reset-during-suspend' property. The latter is too specific
> and encodes policy, but the former could still be considered hardware
> description and would also apply to other designs which have the
> property that the reset line should be left deasserted.
> 
> One such example is when the supply can not be disabled at all (e.g. the
> Goodix case), but I can imagine there being more than one way to design
> such reset circuits.

It seems it is common problem. LEDs have property
"retain-state-shutdown", to indicate that during system shutdown we
should not touch them (like power off). Would some variant be applicable
here? First, do we talk here about power off like system shutdown or
runtime PM, thus suspend?


Best regards,
Krzysztof


