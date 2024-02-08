Return-Path: <linux-kernel+bounces-58837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545D84ED76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4341E1C21B65
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F40605A2;
	Thu,  8 Feb 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnGFaOVR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6885465D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434088; cv=none; b=XroHNfDhwV1+2tTFyQCcFHge2MkJgY9I3l0gu9l9Lqd/C4YPtbY63eeYUzaWZdxjhgIYRwsV3RUbW4PAfJBPfwPa8FxEpU0lo+nEhYEzB5ofoGm9wRqut3snMPRDXMd3DPEQedx5sZC/DCVqWVuiIFVmjnsi54XohkYW8UrTun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434088; c=relaxed/simple;
	bh=9j5r/pr1EIliO35fXmzoIikYmXFewW/u7vlCgIYiELg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSuRa+zCXFz1tFepATYRqiqQUZ1jNfPqUMxaGaxmSl6RRS7fASIg0u1zz3Z13s8d4owps3a8gF/3KFFCxHJMrhuHRGkhLSzF3e27vxptFKhpDFZiwTCa1nJksjsORWO8QGT8Hb71CorCJkEEYkD3I2ZmS/lkrgVCl5ZQHOxLbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cnGFaOVR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so581312a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 15:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707434082; x=1708038882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNufXJXCKu6+G1nHJMEy9AFU0fyk63nw9WZ1UB/GpnQ=;
        b=cnGFaOVRSWOtJfe434/CQ2t6Nr2eirVoCSSIggffwo6eLIGkZX7m7/KhjO9t0+/SqO
         hs2l1YfoAmeijkAeeA9TGwiQgVYWFv4mPoKGOr8x67JzZH48FzxBLOwvAmi28p1DRjST
         lQGru7OUtrWIV+F8E5tjDH8gZE9rCjL8w8SricabFq7l2/ugVVSJUULsjly2xcnMlvjR
         xclLKxbniCFBP/iDfSgfVuXfMqabjpcynvWOXg2eAk5Ncnp/qCVe2KRI/HzJZ3EB6J/0
         zGkRwDiO29h+YtXNAyJgi49xvflFC2GY7xeB0q9deg5EbnnpI6FXEA4e/lGs+60a3OYw
         VqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707434082; x=1708038882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNufXJXCKu6+G1nHJMEy9AFU0fyk63nw9WZ1UB/GpnQ=;
        b=qqj319uDOFnXP4aI3jFqAAuThBcGFqxG4vd36G5p6dDzFopDS6zrgxQg8tF+QVqT48
         kQWI5ng+cQs12LDpec5qPwmZgxniBgl+4oU2/usVdn2dojMqvHivpgLLFP0khLjVfdG8
         YnwRIKOqT6Pu9Blrg5gmft+Yp/BXy72mB0PWSxtVLMo0HlIyht69IkCM636Y9goJw8+4
         71F5Pvdrlj6lYkWl5diS7EqnRGVZNI+UxYuWTcxz02wKhOlZJzVwraX9RFTTYey/v+wE
         mdB7pjAfmX3pyQJmAgUvgG2BXTdHYYVt7KCS59OZtY4+JQ60lM098TqSBhFrs2E9hCJ8
         fDFg==
X-Gm-Message-State: AOJu0Yy+T/t3qq153nNbXVNfvNY2exttZ65nAmGvsbtKzQ5qmWBhdFzc
	wYSiQ+VFYxo7vgtmpiGNeAAdjPJFGBTOOoAlHdr05AYQ/HVEIluCd//kib1yNYg=
X-Google-Smtp-Source: AGHT+IHZzrDF1dJO86+ZGoeaHkZw5DV0jHxccZc5eSvLiRCNDIi3uZOYz1gZpe26W/rxoaQcSgZDWg==
X-Received: by 2002:a17:906:f1d7:b0:a3b:cc20:31c with SMTP id gx23-20020a170906f1d700b00a3bcc20031cmr479225ejb.41.1707434082406;
        Thu, 08 Feb 2024 15:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWmSWUK4/G7m3o2+LOVGKHhZ3XPSDr841nYQGWd66xixk2rLM9ESv4ajmt1Vqc3S/aAuj93G/FgdTSZh5iQLBEfI5nUqml6+qS0cMtNqZG0VPjm/BQRIMSwuqcq9abhkEXwsi2ijX2L2Vq1a5/e9Qz0iC5oVtJ3y1jEaqHs26iGr1k8r5xCR+f3hPODIe017eLInuE2IWQyaznZoHAgjhJTFsaC6fbEZ03LUB7pW4mKvz7XFm7sZvEW/CMlRCnivlIpzI4V+aPX6Qw77JMAX/2oW9qFa2sAf7On/3PF0aB7QhYkC4Yz59VNeRLn3VPzUZbuWyvyAvqOz1z+eguJcgVOqfLWZm96yxSPF15wdFP+LYSHU6D6fKtFf19eQZ7jZv3nU5jxIaxTZW+OXYSEoRQKLFHjcDetXY/rnnMNdOTv/0QMb5n4xkYE+JM
Received: from [192.168.192.207] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id rf22-20020a1709076a1600b00a3bb26bd7afsm161577ejc.38.2024.02.08.15.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 15:14:42 -0800 (PST)
Message-ID: <7b294518-9d4b-4648-a2b7-3843aca033a1@linaro.org>
Date: Fri, 9 Feb 2024 00:14:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
 cristian.marussi@arm.com, andersson@kernel.org, jassisinghbrar@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, quic_rgottimu@quicinc.com,
 quic_kshivnan@quicinc.com, conor+dt@kernel.org
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <7bf729a4-f3ac-4751-9275-a2aa4d62c036@linaro.org>
 <1f0c2767-c489-58a6-e5ba-9f1974072bb7@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1f0c2767-c489-58a6-e5ba-9f1974072bb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8.02.2024 11:22, Sibi Sankar wrote:
> 
> 
> On 1/18/24 01:23, Konrad Dybcio wrote:
>>
>>
>> On 1/17/24 18:34, Sibi Sankar wrote:
>>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>>> controller.
>>>
>>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>>> ---
>>
> 
> Hey Konrad,
> 
> Thanks for taking time to review the series.
> 
>> [...]
>>
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    mailbox@17430000 {
>>> +        compatible = "qcom,x1e80100-cpucp-mbox", "qcom,cpucp-mbox";
>>> +        reg = <0x17430000 0x10000>, <0x18830000 0x300>;
>>
>> These reg spaces are quite far apart.. On 7280-8550, a similar
>> mailbox exists, although it's dubbed RIMPS-mbox instead. In
>> that case, I separated the mbox into tx (via
>> qcom-apcs-ipc-mailbox.c) and rx (with a simple driver). Still
>> haven't pushed or posted that anywhere, I'd need to access
>> another machine..
>>
>> On (some of) these SoCs, one of the channels (rx[1], iirc?) clearly
>> bleeds into the CPUFREQ_HW/OSM register region, which gives an
>> impression of misrepresenting the hardware. X1E doesn't have a
>> node for cpufreq_hw defined, so I can't tell whether it's also the
>> case here.
> 
> I am aware of ^^ discussion and the X1E doesn't have this problem.
> Both the regions described are only used for mailbox communication.
> X1E uses the scmi perf protocol for cpu dvfs.

Yes, that's clear.

I am however asking for something different: I presume the CPUSS
IP hasn't changed too much on this SoC, other than having new cores and
OSM now being controlled through a different firmware interface, and I'd
like to keep the hardware description in our DT as close to the metal as
possible.

In other words, if the good ol' OSM hardware is indeed there under however
many layers of firmware, and if RX does indeed bleed into its register
space, I'd prefer there be at least a syscon node describing the actual
block, and not a magic hwio entry that's many zeroes away.

Konrad


