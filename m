Return-Path: <linux-kernel+bounces-158374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D58B1EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 540D0B21A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CB8664C;
	Thu, 25 Apr 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuMr6kp0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F586250;
	Thu, 25 Apr 2024 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040219; cv=none; b=BMwon4wDe926QMxhffNOjTtlZW8PsjxWdEqoz4QnPPVYVrzy6DZtGzzUv4VLsnCWIz+aHXVncAHeLa6bfj0e+9TmlDCjqAvV+rZog28dyXk+sCAlTvXp+fV0rMCImVS+dYr8XWQlF3i0DoYlACyiR1mB/moQ7Y1DBqFEaniAKxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040219; c=relaxed/simple;
	bh=hIG+/hV54iCLYeB/5AjaQyTAKf4huKvDh38dZvuucSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2yo/3P7Y6hl4+eMM/C6y88o5UYQUgRm+R3Y/wjlhyVTk/1/dkOeFfFQ7rbaCtztxadnkwjVAobVJ8+hTpyjqTAGfDaMJebXnFeWQDprKyJumGoCOq5K0KMCoO9rI//sdAKxtnAWcwQYMkW51bEj5hiWaSes2FOmeNtvQzuRg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuMr6kp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70373C113CC;
	Thu, 25 Apr 2024 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714040218;
	bh=hIG+/hV54iCLYeB/5AjaQyTAKf4huKvDh38dZvuucSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WuMr6kp0Cr2F3cXGhkm8SlaQbv3Li8QElwizGvvO1FFxvlb39BIYkK1QWWGR6R2+k
	 tdyXSxO8o+eAjDZGttKHGFayu4T+xO8gZsQeb6iM6hx/xvZYAUY+JFOwiIorCCm2+S
	 EDVr4Kiwxg5SMQQNwBUdh8GN6PMm0LR5NVfmLH133gih8aK7DEpU9X9rxThsVX1kPE
	 bXbeYwZBbPqGoj2ORamIbSBAPfqIAjmYJaZYltnL/8zlmRUVQFJrOrMWUp0giOhhDE
	 wV4qlceRPh3n1aPoCPgFpmqzWF5bonTxLb5hGhAwKVCCT2PkfEM6p4K3g4o/h5u2zb
	 VAvW9guANDgRA==
Message-ID: <06383015-51b2-4f4c-9fd8-e4f7ce12f44e@kernel.org>
Date: Thu, 25 Apr 2024 12:16:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] phy: exynos5-usbdrd: use
 exynos_get_pmu_regmap_by_phandle() for PMU regs
To: Peter Griffin <peter.griffin@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, lee@kernel.org
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
References: <20240423-usb-phy-gs101-v1-0-ebdcb3ac174d@linaro.org>
 <20240423-usb-phy-gs101-v1-2-ebdcb3ac174d@linaro.org>
 <cf7200d3-f60a-446b-b9cc-1f63e3c90740@linaro.org>
 <CADrjBPpQEbxVbDwat1fn=2tYk9r-0up0+SARFZA=qkoeFYz1Mg@mail.gmail.com>
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
In-Reply-To: <CADrjBPpQEbxVbDwat1fn=2tYk9r-0up0+SARFZA=qkoeFYz1Mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 12:02, Peter Griffin wrote:
>> I prefer to keep the syscon
>> API and change the syscon driver to expose proper regmap. IOW, use
>> generic API syscon_regmap_lookup_by_phandle() and the type of regmap
>> returned is defined by the provider (so node pointed by phandle).
>>
> 
> @Arnd - any more thoughts on Krzysztof idea above ^^
> 
> @Krzysztof - I did speak to Arnd about the idea you proposed (or my
> understanding of it at least), which was external drivers like
> exynos-pmu or altera-sysmgr.c could create the regmap and register it
> with syscon so it can be returned by
> syscon_regmap_lookup_by_phandle(). Arnd's initial feedback was he
> would prefer to keep the complexity out of syscon, and have the client
> driver support multiple backends (so syscon-reboot for example would
> support using either syscon_regmap_lookup_by_phandle() or
> exynos_get_pmu_regmap_by_phandle() to obtain it's regmap). There were
> also some concerns about syscon having to probe very early for some
> platforms.

mfd/syscon.c is postcore_initcall, so it is not that very early,
although earlier than drivers. However it does not support deferred
probe and sometimes syscon providers might need clocks and resets.

One syscon consumer (so regular driver like phy here) might work with
different providers. E.g. on earlier arm and arm64 Exynos this was
simple regmap. On Google GS this is SMC. On some foo-bar it might be
call to hypervisor or something needing clocks.

For me therefore the syscon consumer is like regmap consumer. You do not
care who provides the regmap, just want i2c or mmio regmap. Of course
the specific driver, so the consumer of regmap, knows the type of regmap
it uses, so it requests i2c or mmio.

Here we want to hide two different interfaces - mmio and SMC - behind
one regmap. We solve it by using same regmap interface for consumer, but
different syscon calls returning different regmaps.

Anyway, I want to sort it out and have some sort of global policy,
before we start doing such changes for Google GS. I am sure soon
Qualcomm will come with their need for hypervisor quirks/regmaps etc.
And then TI will come with some need.

Best regards,
Krzysztof


