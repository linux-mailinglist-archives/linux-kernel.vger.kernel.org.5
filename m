Return-Path: <linux-kernel+bounces-50103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BA847445
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843291F2D90E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA1F1474DB;
	Fri,  2 Feb 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ovroj3df"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19C1474C8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890091; cv=none; b=rC4AeFDD8bQe0lxjmRGCJ/R0DaALx1CJgRVw2j0R1sTIIwgJQ2ypSgv6WRYcXOJWvoBfZtTF45wgYx19aaMSMy4DNR5wnnY9B63eSM/i7RVBhc3zhPTkpU7zfzhMZv2uQ3tFxoXgRINcIk1rPYXGL2eB1AmWZFn26Gq6gpFpGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890091; c=relaxed/simple;
	bh=1Sy1DahY5LhmMgnq6h+UTVpAneW/WiqYKvKoRqACwPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8VcGLs/oEMHudTQsriTvvqpPr+Oqn1TglgzBHfRNVTWcYhR+vDKe4vjfvoOqSXyRVG/xYv60KcX+L9PHqjnMDM3GDgRTE3HZVhVEBwrJUKhX90DQAe2/uE+NsRod3uuKWxRqIPgWgEaZE5k9JLHVecoVu91WGsYFzQ6kL91SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ovroj3df; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0600551e8so27042581fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706890088; x=1707494888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdOH44GqBNuJv7gNhF+H71j52RbjvAKIOcCjf68RgNE=;
        b=Ovroj3df70dPtuyRQBmahU5qlBI8SM2xLqy5+or/4w0q1un2pO9WshDLPXEJldH0tv
         NrlvfJNwXIo4/16XcF21XGQnQcDcTGfbIlmfDGiP8hk/DnKPATlSzr7ChLhy2g711qtJ
         d1XYNWoB0nmasoA/p916HY8K6E+3e1CbvmkVJLrq3v6PP25m+pJyyJBjk0VVnNXbxOf8
         aU1gWuqfgbgXYoxnbBgSHzSj1LdwfkmVmE7Ep5a3OqjKC0VtS6wCS0ah9JOsMLihhMc/
         0sHzW7+2gfDr443MsP/4rJZtMvnrC76CRBY6g/GQMPvQqPD6peRpZm/81fFxEjkoOnsc
         5Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890088; x=1707494888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdOH44GqBNuJv7gNhF+H71j52RbjvAKIOcCjf68RgNE=;
        b=a0WEwrP6dgpW6AHYBAmo0Hxwts4XWsplqcf2cqvpklJreWebiKAAgylQ1PTzSrWk5w
         jPhQZ3c8urTCibtJ3dSWzBoxEtTb5X12kXWyae4h5Fw4eaiamyi4AxH5lrdkz+AMZoj1
         Esmluj1GBOA+RGaZtwIkxRPDsUJaJnn2JiqUsA9O+gO8u8NjADiEQ2TOdBet5wozeRrG
         EdBeePS55lsehS19+ifXhh92oL176jtld2Fw3k1sjKEHCpb5xzH3/x33NjhxhAYirMfo
         opp+zvYsZMimc9AZ1oHDHcSNzn3CNaooqPGxKHbPUy6GdUAHXwBJj5nciLcJho1i2RsK
         ytyg==
X-Gm-Message-State: AOJu0Yy0dAz+hLOahr8Ml4ykAVN89jjHMmGIk9/g0H8eYZl8FYLczfs6
	WFbCbQ2Ju2HnnUB322DPDFXsdIlPhhmlKMdcpc8L37Giauey5W7E+W19L3UQyUQ=
X-Google-Smtp-Source: AGHT+IFejla8/vJpaC+MwBd7ti69FX7y+1E1msZO7F5Sxy6AtRthKMme+rjGfWPCS6a6O60/eRUsfw==
X-Received: by 2002:a2e:7817:0:b0:2cc:ee90:e565 with SMTP id t23-20020a2e7817000000b002ccee90e565mr3978358ljc.9.1706890087987;
        Fri, 02 Feb 2024 08:08:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqPx1EgWdIp0lFo8BPwv2/q4cv9bzZXeZ/oyJT3AWNycWfGQEXvl4Ls9weA+6/2Pls2WfzCdZC+3RmSm++Wol4l8sJjZC0e3+dc0vch2PewDnGfg7FbJhA7+q5XJ8NXNWWhkPC5lF44NzD9uhvpohWfJ0taE2FxmByIxtl8DqNF3Xw3/Ai7BYbiwaR1kX9BFPxq/jvvf8IGcs11ThNXN/BXeTcnJt0H6apnER5n4/ERCE7Jzie5Cah9B0ZUb2BdYaDVxovzpBw6dckW6fj9C4sR/LoPX2/U4wfUGmVeQJh97iGZleLlA59+wuWwR9+o+dEwUP9J85yMVtZbKjOQThb96ZR4rjpBI/BKNb1KpO2ybgZoYAsX+Rz+EmhMbPcX41QxSI7jnpHGuILgKzKilKG4u8AIaocwTBc54vLTzTTLGY=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7da03000000b0055ef0105f2fsm928458eds.80.2024.02.02.08.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 08:08:07 -0800 (PST)
Message-ID: <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
Date: Fri, 2 Feb 2024 17:08:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
Cc: Brandon Brnich <b-brnich@ti.com>, Nas Chung <nas.chung@chipsnmedia.com>,
 Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Darren Etheridge <detheridge@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
 <20240202155813.szxvi7bfp5xh7rvw@babble>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240202155813.szxvi7bfp5xh7rvw@babble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 16:58, Nishanth Menon wrote:
> On 14:56-20240202, Krzysztof Kozlowski wrote:
>> On 02/02/2024 13:52, Nishanth Menon wrote:
>>> On 11:47-20240202, Krzysztof Kozlowski wrote:
>>>> On 01/02/2024 19:42, Brandon Brnich wrote:
>>>>> Wave521c has capability to use SRAM carveout to store reference data with
>>>>> purpose of reducing memory bandwidth. To properly use this pool, the driver
>>>>> expects to have an sram and sram-size node. Without sram-size node, driver
>>>>> will default value to zero, making sram node irrelevant.
>>>>
>>>> I am sorry, but what driver expects should not be rationale for new
>>>> property. This justification suggests clearly it is not a property for DT.
>>>>
>>>
>>> Yup, the argumentation in the commit message is from the wrong
>>> perspective. bindings are OS agnostic hardware description, and what
>>> driver does with the description is driver's problem.
>>>
>>> I will at least paraphrase my understanding:
>>> In this case, however, the hardware block will limp along with
>>> the usage of DDR (as is the current description), due to the
>>> latencies involved for DDR accesses. However, the hardware block
>>> has capability to use a substantially lower latency SRAM to provide
>>> proper performance and hence for example, deal with higher resolution
>>> data streams. This SRAM is instantiated at SoC level rather than
>>> embedded within the hardware block itself.
>>
>> That sounds like OS policy. Why would different boards with the same
>> component have this set differently? Based on amount of available
>> memory? This, I believe, is runtime configuration because it might
>> depend on user-space you run. Based on purpose (e.g. optimize for
>> decoding or general usage)? Again, run-time because same hardware board
>> can be used for different purposes.
>>
> 
> Why is this OS policy? It is a hardware capability.

How amount of SRAM size is hardware capability? Each hardware can work
probably with 1, 2 or 100 pages.

> Traditionally
> many similar hardware blocks would have allocated local SRAM for
> worst case inside the hardware block itself and don't need to use
> DDR in the first place. However, for this hardware block, it has
> capability to use some part of one of the many SRAM blocks in the SoC,
> not be shared for some part of the system - so from a hardware
> description perspective, we will need to call that out as to which
> SRAM is available for the hardware block.

Just because more than one device wants some memory, does not mean this
is hardware property. Drivers can ask how much memory available there
is. OS knows how many users of memory there is, so knows how much to
allocate for each device.

> 
> Why would different boards need this differently? simply because
> different cameras have different resolution and framerates - and you
> dont want to pay the worst case sram penalty for all product
> configuration.

Choice of resolution and framerate is runtime choice or use-case
dependent, not board level configuration, therefore amount of SRAM size
to use is as well.

> 
> Further, Linux is not the only thing that runs on these SoCs.. these are
> mixed systems with autonomous operations of uC cores who may or maynot
> (typically not) even need to communicate with MPU to state which part of
> resource they are hogging (hence the board level definition).

OK that could be the case but I could also say choice of RTOS or any
other is also board-independent.

Best regards,
Krzysztof


