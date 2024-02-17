Return-Path: <linux-kernel+bounces-69899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E394859002
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CEB1C2125F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBF37AE7B;
	Sat, 17 Feb 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqNgnpV2"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01B7AE5A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708179241; cv=none; b=chAN1pemJgoPiw7l98dv0rD6KwxfZJHa/L/NGb8JdQw+A1iLFucBUuSnnAh7r43nS7Jjnhn+3qOdxNqbaemsQyxqrknWvCgV0ZJNxuMj+SleG1O+wUuwcdr8k6qqWKqykEj1sEx6FUyPoEd15F8KN07SfFC1W5EaWnrdOyo/Tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708179241; c=relaxed/simple;
	bh=+wZP7vHYk/NnK6kFbVDTg8yyh97qvUTtJQ7tdP43nk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB8FPTzWBO+tolIbyEgaLbyl8lhZv1ZuBoGYPdpUmbkd5h9x5THLAhKYWoNKNp6xDeTgVt+j3s8nKDO0DNhrOwToXJn7HYoOfVyEkjxYf3c3oSjuw1Wb8dUITWMyst1sT1gHgJczNmZ9FlNx/L9lWrUTahmKXCG5vF0jOdTeAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QqNgnpV2; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so2041645a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708179238; x=1708784038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uTOVln7B9LCW+XhdWPc2Gjzczfr4Yu7an/52ckhWw4=;
        b=QqNgnpV24PRGE7rOQ32M1Gtc5JGI3+a+Jhysf+5zteoqfKZlsnRbj349tt++38Ag5Y
         PMxAEHHvFjoqALbeeGRNRzp4bYfXnzuKAxOyeC+rhA54LmueBltR6SHBwLdNnleU8S6V
         3P0n2yElwhjhuPI6fkVje0SVFTWTCFN0mjw9g1HCVVriYvvo0qpL5RueZ/8BRF01BcIf
         UMI3hsOvjD8sFiF7/qha7TfwhYz2iKnilM8oyH1IoyYgPrq3wsFmbFa5ph96swB1y+ws
         U+0QhGLWEskpws5v7JwTs9BV8hOZ4McVbHD1Gb7ONF8lkCxx7QCJpYeN238+xFsOXx4h
         KFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708179238; x=1708784038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uTOVln7B9LCW+XhdWPc2Gjzczfr4Yu7an/52ckhWw4=;
        b=piSFWlG8sr3P7ucGu4jijOvgh/hLN6tXXNxa2HbfWVa1tzWN4b8JrjbOijdRvnKVU0
         +b0y6k7lir537YspphE8k3+iJOGra8ASkvKEzR3OPe8h4RIIt6/3bjbY0oEuP7NCo1Rz
         saetFvFzyHZ1ya9cXcZRFrY9Jju8ED/JEOhjYNlUjAhcxWVgwO2HgSejp7P51dBywUA6
         EZgvDR31bBqeq+yjPIEer1xilFq7jN01WhxJeR6m9gKU2nQ43y3CeXjDg1lfN4DDvLMg
         JUejI0A5rphWuKTZFezm4/iz00XAt8YbY2XbQSMBd36bu/1OtFWT4ZyX5J4LgcoZUKWH
         5/DA==
X-Forwarded-Encrypted: i=1; AJvYcCUfMYjSMl4L+ObhehNWjzOyyOQWgDvh4rhSg9u7GcICmUvEptu6eiyHkXlYiZwFC4CNyAf9mCg3XT0MA7Tm2HqkTW14IsTx9R8I2Ec2
X-Gm-Message-State: AOJu0YwKwYedk8yX2M6kyHJ2nZg9yDJIK9lS71aiDPmaI7cHH//Ksy7O
	1LdbFdrP2q+PlyAxbczFr7FBkRErdAILn2mbe2SEilDeRGDFviRyTPXFNC/5FeE=
X-Google-Smtp-Source: AGHT+IEMqq2OOqfNnyYtkZ0A9BgvXFEj64X+pAlq9aoLXx2vdSY1XySLj9qsXAn7vJma7clpn5N9pg==
X-Received: by 2002:aa7:c48a:0:b0:563:8df4:1b2a with SMTP id m10-20020aa7c48a000000b005638df41b2amr5082857edq.39.1708179238480;
        Sat, 17 Feb 2024 06:13:58 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7d1cd000000b00563ec73bbafsm912809edp.46.2024.02.17.06.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:13:57 -0800 (PST)
Message-ID: <f52b2d5e-b2b4-48ae-a6a6-fc00c89662d2@linaro.org>
Date: Sat, 17 Feb 2024 15:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Content-Language: en-US
To: Jishnu Prakash <quic_jprakash@quicinc.com>, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
 andriy.shevchenko@linux.intel.com, daniel.lezcano@linaro.org,
 dmitry.baryshkov@linaro.org
Cc: lars@metafoo.de, luca@z3ntu.xyz, marijn.suijten@somainline.org,
 agross@kernel.org, sboyd@kernel.org, rafael@kernel.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, linus.walleij@linaro.org, quic_subbaram@quicinc.com,
 quic_collinsd@quicinc.com, quic_amelende@quicinc.com,
 quic_kamalw@quicinc.com, kernel@quicinc.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
 <20231231171237.3322376-3-quic_jprakash@quicinc.com>
 <3f812ffa-ec33-448e-b72a-ce698618a8c1@linaro.org>
 <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <13f2b558-a50d-44d3-85de-38e230212732@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 11:39, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 1/4/2024 1:48 PM, Krzysztof Kozlowski wrote:
>> On 31/12/2023 18:12, Jishnu Prakash wrote:
>>> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
>>> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
>>>
>>> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
>>> going through PBS(Programmable Boot Sequence) firmware through a single
>>> register interface. This interface is implemented on an SDAM (Shared
>>> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
>>> than a dedicated ADC peripheral.
>>>
>>> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
>>> channels and virtual channels (combination of ADC channel number and
>>> PMIC SID number) per PMIC, to be used by clients of this device.
>>>
>>> Changes since v2:
>>> - Moved ADC5 Gen3 documentation into a separate new file.
>> Changelog goes under ---.
>>
>> Why did you do this? What is the rationale? Sorry, this patchset goes
>> nowhere.
> 
> 
> I'll elaborate this more in the next patchset. There are two main 
> reasons for adding this documentation in a new file:

This was more than a month ago? You reply to my comment with 1.5 months
delay?

Sorry, I am not in the context and I am not going back to it. I have
many other emails where my questions are addressed faster than 1.5 months.

The patch is not even in my mailbox, long gone.
Why you are making it so difficult for reviewers?

You will get answers like I am not in context, sorry. Next time don't
respond after 1.5 months.


> 
> 1.This device is not exactly like the existing QCOM VADC drivers as it 
> now combines VADC functionality (reading ADC channel on client request) 
> with ADC_TM functionality (thermal threshold monitoring).

Does no explain touching bindings. Your drivers don't matter for bindings.

> 
> 2.Adding this device's bindings in the existing qcom,spmi-vadc.yaml file 

No rationale was provided in commit msg.

> is not possible as it would require updating some of the existing 
> top-level constraints. (for the older devices in that file, "reg" and 
> "interrupts" can have at most one item, while this device can have more 
> than one item under these properties.)

How is this a problem?


Best regards,
Krzysztof


