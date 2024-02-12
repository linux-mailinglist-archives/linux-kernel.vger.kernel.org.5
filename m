Return-Path: <linux-kernel+bounces-61409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD61851205
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DAE28211C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA232BAF0;
	Mon, 12 Feb 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oE1p/+wc"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752633985A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736721; cv=none; b=SFa3//F+kbs13D5hZ/Izho640kU/oNA2YDx/HgrXLZSS8+WY+uOicXxFxQXJwEAcOMO3gtDI/Dd+o3kvvoFOY2zItC4qv/LuoEfNMy7KSUf0QeDSqRvvLvvrYBN1I4CqcQpAPrveLvKCaPZV5fIlEq057VVQ+Uti/MGrajvMIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736721; c=relaxed/simple;
	bh=YrSH6oKFLF8HZYaabc4CdOODa7w6LOjWPGVemiAGkMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1B6XqwILwzmgJY7wCY4XN3F4wuvVX+//GmFT9IqLKgE9rALOL5NxJoe3rC6AYfT34csbEAX8SovXHGHF5WfxmJjHXnpDHPbzuc9FkqTIzfD0NFj3c+IDRGeLxIGi40cZ1VNr0Kgek+xSwG/httDSas7utw2ByIySoRz7QkmhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oE1p/+wc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso13589091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736717; x=1708341517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJb6SlIbNq78TNpPH5y0DK7EbDWTtCJKMmLSORzpT10=;
        b=oE1p/+wcOVi09DxmLxjIE1m0oNhjVVRBOwmb9g3+HaOmjuZAFZFadABE/uJJS7kUXY
         ifeaVVSeAgOvFJUnEW4GkKgflaIIFFNxXPXRXZBX+gGTmDbzQ69axKFCcEopi+N17yAT
         +wfnKBwhtYCrvRoFkfx7PJJJnA7wZEfUpph7ShDAHqqu6YUifnhN9eihhDIReYyKeJGC
         w1RsVyHvDwvvZmUwceJnB0pazhw2k/5J098LcuCuZq0HdSH7mKfqD5bNUfGwp5anAaZG
         c+DyePcpbAzZh0TEnuuR8HT5Q27nCpwgScn7W9u/88PE1YiENO5YgSw485es5dGib16O
         Ltgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736717; x=1708341517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJb6SlIbNq78TNpPH5y0DK7EbDWTtCJKMmLSORzpT10=;
        b=IW+GozreezHdMBW3gCPwWy3+b47el9JHeJeh4Uz5O7cPTOcwMAsG/yb+fmnnhGZpNj
         8tOSLhCivQyv3fMM5WKX4IU83FRiaRun4iiOjHEXQe5EXhCFc2evTAuJwpyWyD0CtVDO
         k6YSMKJxKwBLlYW6cNfsLaFwHbj3F9BzTLFepfBsJ5BYC+ZhhxM+/FSszCSL+8vCKSxt
         5O7186bcE3yRzuPb8cZlSl0DfpTaWlOoqlhQlk9A+VAUsurwehqg4/cZAOuGQ5svi7gi
         VnS7IugOlfRHPZFOinYMLNbuvpGdJuVolk6aPfeLcs4wUfV95xw/0Ft0bI6R6Vl5UF11
         r1Wg==
X-Gm-Message-State: AOJu0YxVVAwLuJeVHMCfKCNDKdU/KVdBg7dLDn4qoSM2G1WG8VfAcKXo
	LBsQSGdcxlmh1RI0Ykhnu7oGIMICS6Mww9Bky3kNFbfcycR5sc3ge8nXA89a/74=
X-Google-Smtp-Source: AGHT+IEN8QlJ89qIn9bwWROw3eV8+//0NU+QMzxuLRMA35KzbGIPbh8Ko/OAjt6aZm5EzwmVyxdntg==
X-Received: by 2002:a2e:879a:0:b0:2d0:cfe6:4364 with SMTP id n26-20020a2e879a000000b002d0cfe64364mr4638900lji.36.1707736717489;
        Mon, 12 Feb 2024 03:18:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKfpBDpyEAfY7lKhRle0mDEXJ46xqdPoDhVxtJpyyrzBQIU2j3nFXgAstEA6AU+nL2o93FID8iT4TQSH3h4ZGu8WHcyj4igSOZwGrHjH2IqXeaNKiSJwEZHvCpIp5grGnC67peFPIvuha9OtPC8K5jzmkxlMmHB69I+MlGFQZG3oPLGMNRK6wU1zNoRH7UFRA3syztdv9uF3pXyKnm5mEmLh22goWe87reP+sJ4Ie/QQ3q1J4Wlif1C/LBnpPb/gcE2T+kJJ2RxYSi14Fsh6LAjThPsWmErtbyqKXoVfF48+t/v24u68PqUuo/qR/7/vbuYdhz1Melkb6MYGlGQiHbxD7K+XxcfiPz0zp4b7YvA6ThNUGttPuIAu60y8V12E5mCHtz06jhuI7T+o2jD03sX6yVwlBxc3f8LaI5igiQRGbjiWHTdkPp+JcmZ2Xi0KLoZP8/J4ES8VGGF2gKzj3IHF/v3vYmidNhYjlf3aeyESAKtrFRbKIwsic=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id cl7-20020a5d5f07000000b0033b8881f31dsm384181wrb.68.2024.02.12.03.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:18:37 -0800 (PST)
Message-ID: <dce39e15-32a8-482c-8751-af4a133f82d2@linaro.org>
Date: Mon, 12 Feb 2024 12:18:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
 <170737972037.52344.9107022607101399076.b4-ty@linaro.org>
 <5972b6a4ae8669e2a9e872278b740b182217906b.camel@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5972b6a4ae8669e2a9e872278b740b182217906b.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 11:17, André Draszik wrote:
> Hi Krzysztof,
> 
> On Thu, 2024-02-08 at 09:08 +0100, Krzysztof Kozlowski wrote:
>>
>> On Tue, 30 Jan 2024 23:37:00 +0000, André Draszik wrote:
>>> Now that we have more than i2c interface, add aliases to ensure
>>> deterministic bus number assignment.
>>>
>>> So as to keep compatibility with existing Pixel userspace builds, use
>>> the same bus numbers for hsi2c_8 and hsi2c_12 as the downstream
>>> drivers with the intention to eventually add all the earlier busses as
>>> well.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] arm64: dts: exynos: gs101: add stable i2c aliases for gs101-oriole
>>       https://git.kernel.org/krzk/linux/c/72ccd925dcbd2ad6935a4874679b6cf5b3de7156
> 
> Is it too late to ask for this patch to be dropped please? It appears
> downstream has just changed all their aliases on Friday, whereas the
> point of this patch was to keep things aligned.
> 
> I won't post anything similar until we start integrating with Android/AOSP
> at some point in the future.

I can drop it, but the actual problem is that what if downstream keeps
changing aliases? They can do it... The aliases are not there to match
with downstream, but to have stable interface matching SCHEMATICS.

Best regards,
Krzysztof


