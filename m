Return-Path: <linux-kernel+bounces-166079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52E8B95A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FC1C20E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114224A0E;
	Thu,  2 May 2024 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdP/HWIQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFC1CABF;
	Thu,  2 May 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636476; cv=none; b=WAyB+/j69OOFeUUxbiWOSF/1YpyGPQIKtAOeAVk0eKoSnJCr1zpPEukMoMuwfdxIxvJS6CoyQgAS1Oq0pkMQ1w3ESIqb4Il6jDNtWeyZUrhstCbta8UlvIaouEjZZoiaGSu4C4eivnmN7OKM6lbQyAkIPCFhRePokQRJFv6iDvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636476; c=relaxed/simple;
	bh=Pdrfkt/RdrjtDEh2hOmpURv6T3uEqY29S00T6whl3/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i93doCEw+vU5pt9pMvZSb6z8oqeX1qJdEueKhJCMCizMlBR537j7ZFbnEXhWsNS99Vo1wdvnB2Ve4zg7e7og9in2s6hfY7bX4dY0JNkLusmjG/Dd1tW2O8Y5nnsRWS3B9dyGQilZZ4iUbULvVnkObPI/8jxPHl5ESkOekz9nzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdP/HWIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45459C113CC;
	Thu,  2 May 2024 07:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714636475;
	bh=Pdrfkt/RdrjtDEh2hOmpURv6T3uEqY29S00T6whl3/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fdP/HWIQ1txZoD3Q8EHv84d3K2XbF2aS3ySpIRnVZOv8Ma3bbuF2ASvf3jL7Xhx2j
	 +R1iTv8dIOmEL4RhSYAddUg48BJfM9xXdqYbPdNsSlA/9FeKvA4OCn/wxtG9KKPUZd
	 A+3LjxzAO1QnBskQCAgR6Vnt94Ji6O4czbOCaW1YxvEBRQoP/WQqgdGmaoHhd6zFcG
	 ltALTNK3/1SdtLnL17kn+4T811fRYDKn8JtO7uN/V72cXUCWGMceYGfmm/1HJxU1wT
	 DPYk8u9aALh96Am5NKRwgzPzAqEBERbhSRgOvncUDLixIlj6YLuK4vRZiJ6ML6CzDw
	 Vm5FgszFjRTeg==
Message-ID: <ecde24c3-55ba-45cc-8af9-94504dc4dcb9@kernel.org>
Date: Thu, 2 May 2024 09:54:29 +0200
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Mirko Ardinghi <mirko.ardinghi@engicam.com>
References: <20240411165801.143160-1-fabio.aiuto@engicam.com>
 <20240411165801.143160-2-fabio.aiuto@engicam.com>
 <e86812b3-a3aa-4bdb-9b32-a0339f0f76b5@kernel.org> <ZhjhCvVNezy9r7P4@engicam>
 <bd1e6507-dee4-4dcf-bbd3-50539270cd63@kernel.org> <Zhq8ibYrZH05/AQt@engicam>
 <46fe43d0-28be-4acb-b0d4-dacd84fef8e5@kernel.org> <Zh0ImzJZrxw4Xia+@engicam>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <Zh0ImzJZrxw4Xia+@engicam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 12:59, Fabio Aiuto wrote:
> Dear Krzysztof,
> 
> Il Sat, Apr 13, 2024 at 11:40:18PM +0200, Krzysztof Kozlowski ha scritto:
>> On 13/04/2024 19:10, Fabio Aiuto wrote:
>>> Dear Krzysztof,
>>>
>>> Il Sat, Apr 13, 2024 at 12:58:35PM +0200, Krzysztof Kozlowski ha scritto:
>>>> On 12/04/2024 09:21, Fabio Aiuto wrote:
>>>>> Dear Krzysztof,
>>>>>
>>>>> Il Thu, Apr 11, 2024 at 09:52:12PM +0200, Krzysztof Kozlowski ha scritto:
>>>>>> On 11/04/2024 18:58, Fabio Aiuto wrote:
> <snip> 
>> I don't understand what is the use case. You wrote runtime does not
>> solve your use case. What is the use case?
> 
> We experimented problems on some boards with SD card, if a cold reset
> is done when the card is powered back on it completely freezes, the way
> devices behave when unpowered for such short intervals is design specific,
> not an OS policy.
> 

Then describe the actual hardware issue, not instruct OS how to behave.
In the property name and description.

Best regards,
Krzysztof


