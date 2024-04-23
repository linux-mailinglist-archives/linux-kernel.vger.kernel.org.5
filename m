Return-Path: <linux-kernel+bounces-154824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2791E8AE18A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2161F23662
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BCE604C8;
	Tue, 23 Apr 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYaBeMbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0B5FDB5;
	Tue, 23 Apr 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866371; cv=none; b=HhLT3ft8mHRP064NmFEomeDCyR1aVGskCi7WTm5QoIBzaCktK4KBhvBpItGvEN3w153xNgH85gChfC35Hb29mW8/EsEkxtT0xwkYNh29Rpb4Fi/6iRHjGiwNqVxNT64cFfS6rCHOKXPA1E+KMc0CVYctikgn7pQOrvAR+gEXMTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866371; c=relaxed/simple;
	bh=oHbC2y82RY8ZSrVWmBLh/lcobyQjR/f3ec9ROiFotVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTCg0qKyA3QW6W74zl29qdQ2q5Ru8bpsuAo2hkH4Y+0kDDf1L2IdtwYIEOqLkhD5Iv0ZO8f7nYYYsp1Eja646U5JxZ+aDlkgqLO0WO7zw15M6tulmoj2iNlyl9By7fQqUeuxmC/2ILFW8F6Un15RnzuQ1yQzghDIs9W2iPODQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYaBeMbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6F3C116B1;
	Tue, 23 Apr 2024 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713866370;
	bh=oHbC2y82RY8ZSrVWmBLh/lcobyQjR/f3ec9ROiFotVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYaBeMbTWrYNsVWe2gpkDlAsFai0qqez7Bz85e33B3FcQRad+v/tnk+j3lxEMAyxK
	 PxHt+jyzpSiVpQsQbXT+JGJ8HGBODOp9eAcO9pGhkwLR47l/S7pj41HWSXDrXinNq2
	 qU074FLJJzxOV0WmIZ6yuPwYleMNtR7EV0SJl9CH3YaPyMV2kcv4qd240/l99QJh5T
	 1wYAOEVAUfD+xA0xrzSUDAFSTfHeAKpl3QTuC28ksG2zdpMgNxvbrjFTzzVWcZq1xm
	 OWoxacaoTrblY+tnjsvYckiDHr1erVUVglNzkMzmzSPfOsv2JMiPv79Kn5OI1C/r7q
	 RUWZK8LywuYVA==
Message-ID: <4c6d6957-3813-46d3-88de-ee64241bbe6f@kernel.org>
Date: Tue, 23 Apr 2024 11:59:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240422213006.505576-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <2b422e9f-bd80-4c57-a3e1-8b463b25c834@kernel.org>
 <CA+V-a8s1xDT7sGMpz_n45v9QzhpWUdJv9eXmUJoxPaJ69MiY7A@mail.gmail.com>
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
In-Reply-To: <CA+V-a8s1xDT7sGMpz_n45v9QzhpWUdJv9eXmUJoxPaJ69MiY7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 09:21, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Tue, Apr 23, 2024 at 7:29 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 22/04/2024 23:30, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> Drop 'items' keyword from compatible list which have single const value.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>>  .../devicetree/bindings/mmc/renesas,sdhi.yaml  | 18 ++++++------------
>>>  1 file changed, 6 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>>> index 29f2400247eb..90c8b1b727a8 100644
>>> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>>> @@ -12,16 +12,11 @@ maintainers:
>>>  properties:
>>>    compatible:
>>>      oneOf:
>>> -      - items:
>>> -          - const: renesas,sdhi-sh73a0  # R-Mobile APE6
>>> -      - items:
>>> -          - const: renesas,sdhi-r7s72100 # RZ/A1H
>>> -      - items:
>>> -          - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
>>> -      - items:
>>> -          - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
>>> -      - items:
>>> -          - const: renesas,sdhi-r8a7740 # R-Mobile A1
>>> +      - const: renesas,sdhi-sh73a0  # R-Mobile APE6
>>> +      - const: renesas,sdhi-r7s72100 # RZ/A1H
>>> +      - const: renesas,sdhi-r7s9210 # SH-Mobile AG5
>>> +      - const: renesas,sdhi-r8a73a4 # R-Mobile APE6
>>> +      - const: renesas,sdhi-r8a7740 # R-Mobile A1
>>
>> That's just an enum.
>>
> Are you suggesting to group them into a single enum instead...?

Yes. That's preferred form, easier to read, because it clearly documents
that binding enumerates.

But just in case you start changing all const to enums: don't. Comment
is for this patch, since you already want to touch these things.

Best regards,
Krzysztof


