Return-Path: <linux-kernel+bounces-153811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E48AD39A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FAF282CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEB154428;
	Mon, 22 Apr 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX2sYVeI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79813F015;
	Mon, 22 Apr 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808675; cv=none; b=qGa7hQNEgBX3J56ayfgo1NbzPQVLa94gHkQaJdbMsVvwg729ccq3R4vzu36k0cLkgf1UTBiRTpFEKItyTbkS5+iShhcZnJGmEE0cpLVA18tdpj9zczOwziq4h4pTGvD/Ouwdd4JxjTIsRMXZ31isYVXsm0QDvotwjhTWnTJr+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808675; c=relaxed/simple;
	bh=VrdKMe7DNv3xa2wyk3qVfJzcLONleATKakMS6dbBY8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCRLEVDJ9U9/EjbAq+FB6Gd5qmZCj2wxGUP+4oe0QzIi7I5HwROHpH70tYR3Wade6rn6TZHrg/W8vMchFPBe0olszLjLlfSYXKpoZJ0DDb0ucIZRJsCG3u5MrSVsBEbRSbT+GuQ3O8TsI1+nlHrVC5mFcK3ddU94wWplLqfVb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX2sYVeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F98C113CC;
	Mon, 22 Apr 2024 17:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713808675;
	bh=VrdKMe7DNv3xa2wyk3qVfJzcLONleATKakMS6dbBY8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lX2sYVeI0VTlEnf0aYY930unIoBcCSbI1DVPzjnkgCR52Od/SGdKfizrumBNUEMui
	 iSR4Ehk/9GrChRq/M6xcYK3UqFmzsKk8F7koL7orJgGwRQqSzHiCnkuaF137LheG+h
	 aXGpM4AYdZSodfdAWRdzS1jkrV3V1Zjw9C3f93zZlttNTKo4w5dgjHcjoyEPkPLKJI
	 MdULLYNaYE32p4wdJVF+yTmpt8QSh03WRn/SppAYwxynNataQHKGCW4rZEuK84sLSK
	 67m/2WY7fLvB1A73ulzFf4k4Sp2qs5tcLHQViHldbRHsSmvC9y2LK/SQFJyTBwQMcv
	 n0/v6/EKURs8A==
Message-ID: <10811cbe-359f-42fe-b318-490309f95942@kernel.org>
Date: Mon, 22 Apr 2024 19:57:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: regulator: pca9450: add restart handler
 priority
To: Holger Assmann <h.assmann@pengutronix.de>, lgirdwood@gmail.com,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, yibin.gong@nxp.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20240419083104.3329252-1-h.assmann@pengutronix.de>
 <20240419083104.3329252-3-h.assmann@pengutronix.de>
 <5c1c8632-3d8f-41b1-8027-54129d8cd62c@kernel.org>
 <f70d53d2-0494-461d-9cbb-086077324e03@pengutronix.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f70d53d2-0494-461d-9cbb-086077324e03@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 10:24, Holger Assmann wrote:
> Hello Krzysztof,
> 
> also thanks for the feedback on this one.
> 
> Am 19.04.24 um 15:39 schrieb Krzysztof Kozlowski:
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> 
> Short note: I did that prior submitting, but I did it directly for the
> yaml-file and not for the directory - Those do not look the same
> regarding their prefix scheme.

No, if you run it per file or per directory, prefix is the same. Starts with regulator, doesn't it?

> 
> I will change it for my v2 and use a subject like for the directory.

regulator: dt-bindings: nxp,pca9450: add foo bar


> 
> 
>>
>>> ---
>>>  .../devicetree/bindings/regulator/nxp,pca9450-regulator.yaml   | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>> index 3d469b8e97748..7cc2d6636cf52 100644
>>> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
>>> @@ -35,6 +35,9 @@ properties:
>>>    interrupts:
>>>      maxItems: 1
>>>  
>>> +  priority:
>>> +    $ref: /schemas/power/reset/restart-handler.yaml#
>>
>> You defined object, which is not explained in commit msg. This code does
>> not look correct or it does not implement what you said.
>>
>> Please look at existing code - do you see anything like this? No, there
>> is no such code and this should raise question.
> 
> I am a bit lost on that one to be honest.
> 
> The only other instances where a "priority" for restart handling is
> described are "gpio-poweroff.yaml" and "syscon-reboot.yaml". These files
> are dedicated documentation for the reset bindings, so I tried to
> transfer the respective entry over for my commit.

Where do you see such syntax?

> 
> Do you suggest I should replace
> 
> +  priority:
> +    $ref: /schemas/power/reset/restart-handler.yaml#

I don't understand what you want to express with such syntax. That's why I suggested you to look for existing examples. There is no such code as above, so you are the first one to add it. And then the obvious question: why are you doing things quite different than others? That's pretty often a hint that something is odd.

> 
> with
> 
> +allOf:
> +  - $ref: /schemas/power/reset/restart-handler.yaml#
> 
> in order to properly include the context for the restart handling?
> Running dt_binding_check does not indicate an issue with any of those two.

Again, what do you want to achieve?

> 
> 
>>
>> You probably want to annotate that device is a restart handler?
> 
> You mean by adding to the "description" part of the file?

No. What do you want to achieve?

Best regards,
Krzysztof


