Return-Path: <linux-kernel+bounces-106376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E39687ED6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA00BB21A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276A5339F;
	Mon, 18 Mar 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWTfTRQW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DFE537E6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778855; cv=none; b=a9nKf2BBIku7W/zpJMQRPDX68bMGuqyZGEh/GRcisLlrqIvL6Fh250QkNY29KD57F2oQTzUtDznMZ7pww0HG+8jApy0Cjbk+wS7MXez7fHEHHcfZFgExq1VPLr4pI20dNteF6mW0Yon9e8pzxMf5+GieWTmTb344bHZykCYoKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778855; c=relaxed/simple;
	bh=q5uwhRfOKAScbecYwo45a2W/WLF9DI4xkykbYKAKHPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+XhmU9Dybr7GDsUnOBIOPALYRzJRgfMaC2tLT5Jfw06osF+luQvawaosOweuX3Sb1quYqZ3CS14hQwsOaBvlKPOmo/T6gohjFaqc6Yj6JSt56LVsp9UqS0JrGv6K81ZEOurmmye/cIwXp4eLiKyIoyr5vc5UQqcvGTXfuxfScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWTfTRQW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ce2bd562so104716766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710778852; x=1711383652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21NjxnHPdisLRxxx599/zFXOTzoXjNX7zPWCZ0pTvyY=;
        b=zWTfTRQWPqffEzWAPtSDcKHH8gnL/nE8fTApap9i0IAOvbwwfxrjf5t3emp0ZaQ9w/
         n+nhGR8e0L/OsZBGBEvVCCUWyFx9WbEuApouknH7cDegp4gCBte2YYcVbVqc8uBAkS0M
         /wCerczEYVSHFwf4yk9HrS1Lb1dmrgAhvqHi5tPX8x1R2zvyAj4WlNdjKVLtPhKR3bPN
         83r/hS5G8dFNcVxr8g+ZK4pvBcr2njrabl3Eyww6aMjd/pcr7WfMAxnEAMf7RPOOK9eq
         BtifWPPG0oDAQ1F/+6t3OpdeznwlejCNCC70Ds/4j57tVReY5L1PX8TiNcUq4gaTCIPR
         iiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778852; x=1711383652;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21NjxnHPdisLRxxx599/zFXOTzoXjNX7zPWCZ0pTvyY=;
        b=JT8x75IWXR0lqr50s9K8ff+cXT6+Q0CdlykLHnhFFdqV5HrdEW9rGfBgknXNfd7Dkd
         9IniM4E/ryiQTA1jcM3hUMK2//rj2G4BgL+tBTS9dflSRJpq1yxuFu9bpxP2Ehp8w5He
         HwidProhm8iYGEoIgFfhTVFQDwaHPekOZHVGId8o62rN+0JIHuA/B1bKl0RKZVYpKGXB
         nwa++neyST2tKPu6723YG/q8iS1RmaQYfMk93cO93ETxB7zQ51JuV7XvqAIw04V9lxZH
         /I4aaG4ccb+RhcfocgIR19iCrziTWAY3Sbs60O5GGelBTu7UcM5HOkwUvQfvu2jNre4j
         k0qA==
X-Forwarded-Encrypted: i=1; AJvYcCVb9ntWc167wedEpPyVn2GPqFlpYOYI9RYcwkZici6i6pmJaval9w6+8o2hUEVxRm1fbcudkJ4gmpkpsTxSfVvBCbYwstFy4DggOiNz
X-Gm-Message-State: AOJu0YyYTKx6Bp2BlhSrZJh+VcVMytrE7qQ252bagZFSDq1oNPK9HJkI
	0xbPNQn9b2XRFQtsRitfSAEtNG6gjcF2r6IBdkDMmvpKCenVfaKSazOmKYb2rkA=
X-Google-Smtp-Source: AGHT+IGMtswkicv00Hbjtf+WojTSxdNHuJs5gz+xImpkVVcBgpBuOFkmoNvDUfhN1DvxbLMvx3mY/g==
X-Received: by 2002:a17:906:2348:b0:a44:1f3:e474 with SMTP id m8-20020a170906234800b00a4401f3e474mr7058523eja.23.1710778851905;
        Mon, 18 Mar 2024 09:20:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h12-20020a170906260c00b00a457a55b814sm5022073ejc.73.2024.03.18.09.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:20:51 -0700 (PDT)
Message-ID: <c456f575-570f-40d6-9960-634da314e1d6@linaro.org>
Date: Mon, 18 Mar 2024 17:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: clock: samsung,s3c6400-clock: convert to DT
 Schema
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240312185035.720491-1-krzysztof.kozlowski@linaro.org>
 <20240317-curator-smoky-99568f9308bc@spud>
 <60039f49-a20d-49b9-8a3d-2ded499435a4@linaro.org>
 <20240317-jersey-trolling-d4678546e87d@spud>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240317-jersey-trolling-d4678546e87d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2024 16:49, Conor Dooley wrote:
> On Sun, Mar 17, 2024 at 04:26:55PM +0100, Krzysztof Kozlowski wrote:
>> On 17/03/2024 16:23, Conor Dooley wrote:
>>> On Tue, Mar 12, 2024 at 07:50:35PM +0100, Krzysztof Kozlowski wrote:
>>>> Convert Samsung S3C6400/S3C6410 SoC clock controller bindings to DT
>>>> schema.
>>>
>>>> +description: |
>>>> +  There are several clocks that are generated outside the SoC. It is expected
>>>> +  that they are defined using standard clock bindings with following
>>>> +  clock-output-names:
>>>> +   - "fin_pll" - PLL input clock (xtal/extclk) - required,
>>>> +   - "xusbxti" - USB xtal - required,
>>>> +   - "iiscdclk0" - I2S0 codec clock - optional,
>>>> +   - "iiscdclk1" - I2S1 codec clock - optional,
>>>> +   - "iiscdclk2" - I2S2 codec clock - optional,
>>>> +   - "pcmcdclk0" - PCM0 codec clock - optional,
>>>> +   - "pcmcdclk1" - PCM1 codec clock - optional, only S3C6410.
>>>
>>> I know you've only transfered this from the text binding, but what is
>>> the relevance of this to the binding for this clock controller? This
>>> seems to be describing some ?fixed? clocks that must be provided in
>>> addition to this controller. I guess there's probably no other suitable
>>> place to mention these?
>>
>> To make it correct, these should be made clock inputs to the clock
>> controller, even if the driver does not take them, however that's
>> obsolete platform which might be removed from kernel this or next year,
>> so I don't want to spend time on it.
> 
> I think the comment should probably mention that these are the expected
> inputs, part of me thought that that was what you were getting at but I
> wasn't sure if instead they were inputs to some other IP on the SoC.

I can change it, but just to emphasize: in half a year or next year we
will probably remove entire platform, thus also this binding.

Best regards,
Krzysztof


