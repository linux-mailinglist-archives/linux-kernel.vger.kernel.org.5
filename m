Return-Path: <linux-kernel+bounces-16906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F58245CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328351C221CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891124A0B;
	Thu,  4 Jan 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+IbsgUX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5D24A13
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ea98440a7so680827e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704384510; x=1704989310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KY5xP96Le0ZniVFZKeXdx8efJcLyHwWo4sSLgDSws3A=;
        b=n+IbsgUXKQNOYo3iHX08pZWvwLBhS3rFOvOVVHKPTVOlXfaqjXmHERHVEJo33CyJkN
         Ccv95sG5ZSPstsQVWzt58dJkzWKeU2yM33FNpLGvMoowKE7ZZEh88eeLd5FElLco/xhl
         ORumfISNp6kS2PXMA/PwDIrNVuT7RNOknqVIKHMrvUiWSKwzDWbERdLNNBwRUYpp7Oml
         A25GOmjgar98w5FwlYzBuMILYCWO9bgBlLzZSG3rF0Un7maKkb72wJtG8mcRlcQ9pblH
         omkxVyQzQ7EOEyw253yNgOIbfKBJ2omQHlVWIVjD4Me7EsrD+uZXS9mPCTazotH7RUFX
         Zr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384510; x=1704989310;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KY5xP96Le0ZniVFZKeXdx8efJcLyHwWo4sSLgDSws3A=;
        b=iXgziUeo0N0VhTWv532VnDHRtnwxvnjwbldiZIuIkWEZUiGCBzpCWSOkZdPMazEWP8
         Vg2TrCitZ4f5zPlQOfmglJvmj4WgVucacteawve9EIRZHs3/JGv9s5Ugjn9M9Vk9Z2ME
         RKHHYzASeS2/xItBxyVaTtMwLA6Wck2Drl8995dnNDKHsPhd8EA6PAiYvjCkHOSbc8uQ
         SsIvrw/lGUPD2UP+K0y1zPqjJxqlckRTTutQgh0Lh9Ks2s3yeQqHY/8J+uebhJ2Y3c/U
         AR6Cr4kgiykPSCEtQS0cc+rJT+2wnCnr0zdfTazIM9jNsUdGCl+TmhJa9NYlJYH+okMF
         UhlA==
X-Gm-Message-State: AOJu0YzqKUBWEoR5pITE6ChbDkJbwglmOqA/bO5uhQ9fzipaN+e5tbwf
	lCIGk1pF90OxmTjjoBqeUA5O3q9BzK2N+Q==
X-Google-Smtp-Source: AGHT+IFdBGTKty8FQQCh4+yOFP87gFD5uvSSfcnO9iQ1ufQbalsz+gQU82XLyiqDp3JaZhe3SckTJQ==
X-Received: by 2002:ac2:44aa:0:b0:50e:8504:24c3 with SMTP id c10-20020ac244aa000000b0050e850424c3mr282750lfm.114.1704384509845;
        Thu, 04 Jan 2024 08:08:29 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id o6-20020a056402444600b0055473af90a6sm16421942edb.0.2024.01.04.08.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:08:29 -0800 (PST)
Message-ID: <fcbae47b-3b28-42f0-b93f-f83932025dc1@linaro.org>
Date: Thu, 4 Jan 2024 17:08:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
Content-Language: en-US
To: Sean Anderson <sean.anderson@seco.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
 <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
 <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
 <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 17:04, Sean Anderson wrote:
> On 1/4/24 03:57, Krzysztof Kozlowski wrote:
>> On 28/12/2023 17:05, Sean Anderson wrote:
>>> On 12/22/23 10:01, Krzysztof Kozlowski wrote:
>>>> Add simple driver to control GPIO-based resets using the reset
>>>> controller API for the cases when the GPIOs are shared and reset should
>>>> be coordinated.  The driver is expected to be used by reset core
>>>> framework for ad-hoc reset controllers.
>>>
>>> How do we handle power sequencing? Often GPIOs need some pre/post delay in
>>> order to ensure proper power sequencing. For regular reset drivers, this is
>>> internal to the driver.
>>
>> It's not part of this patchset. Power sequencing is an old topic and
>> generic solutions were failing, rejected, did not solve the problems,
>> etc (choose your reason).
>>
>> Delays are device specific, so they go to drivers (depending on the
>> compatible). Complex power sequencing is way too much for simplified
>> reset-framework handling, so anyway it is expected you do it in your driver.
> 
> Well, the reason to bring it up is twofold:
> 
> - Traditionally, drivers expect the reset controller to handle all
>   necessary delays. For example, reset-k210 includes a 10us delay
>   between asserting and deasserting the reset. There's a similar thing
>   in reset-imx7, and several other reset drivers.
> - We would need to add custom assert/deassert delays to every driver
>   using this interface. These are not always added, since any given
>   device may require delays which can be inferred from its compatible.
>   However, an integrated system may require delays to be different from
>   what any individual device requires.
> 
>>>
>>> Maybe something like
>>>
>>> my-device {
>>> 	reset-gpios = <&gpio 555 GPIO_ACTIVE_LOW>;
>>>         reset-gpios-post-deassert-us = <100>;
>>
>> Feel free to add it later. This patchset, and actually all patches
>> should, solves one problem while allowing you to extend it later.
> 
> Yes, but we should try to avoid creating problems for ourselves in the
> future.
> 
>> If there is a architectural problem in my approach not allowing you to
>> extend it later, then we should discuss it.
> 
> Well, I brought up just such an architectural issue below...

Sorry, but where the issue? You did not present any arguments stating
that it is not possible to add your feature.

What is the problem to parse that property?

> 
>>> };
>>>
>>> Of course, this is a bit ambiguous if you have multiple devices using the same
>>> GPIO with different delays.
> 
> This is the most concerning one to me.
> 
>>> Maybe we take the max? But the driver below seems
>>> to only have access to one device. Which I suppose begs the question: how do
>>> we know when it's safe to deassert the reset (e.g. we've gotten to the point
>>> where all devices using this reset gpio have gotten far enough to detect that
>>> they use it)?
>>
>> The driver (reset consumer) knows when it is safe or not. You must
>> implement proper reset handling in your driver.
> 
> The driver has no idea whether it is safe or not. It just calls
> reset_assert/deassert at the appropriate time, and the reset
> framework/controller is supposed to coordinate things so e.g. the device
> doesn't get reset multiple times as multiple drivers all probe.


Sorry, then I don't get what you refer to. The driver calls deassert
when it is safe for it to do it, so the driver *knows*. Now, you claim
that driver does not know that... core also does not know, so no one knows.

Best regards,
Krzysztof


