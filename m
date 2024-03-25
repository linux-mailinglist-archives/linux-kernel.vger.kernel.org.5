Return-Path: <linux-kernel+bounces-116633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D38F88A19B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2218A1F3B2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8ED185231;
	Mon, 25 Mar 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nb32IC0y"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4084A15357D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355532; cv=none; b=Qrk7PJuOCveZl1qZyghpHicoCp0mjByl0ja3G5O5BiC5yN7OSotktxAjJsQD9ZteZptHAfgloMKuJI8W7DAM4nqgnjI+3id90RWChi+JAjNtyg5O3RXChbBVCNSAsBkwo7uv7KpyJpP/LDcjTutAIyeeunmo6T7vLcZmgumdYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355532; c=relaxed/simple;
	bh=nUzbBSYPjv8N+H9xKIEdwIMIeUjkj38bj4UVIfyqSWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmo3+pKaRD+lp/LJ8RECxBFFFzJnBLWhjCXPqn0t1IhILIuBR8KRiYz6q76yrAPJL1alI/Dm01o6OYuFwQ31Vdxv/K3Aet6szTG9Q1ASyMxtRrSa3OsY5tVZb3hwr6pZtmx4jgaedGQ49mdFxXvCEph6zY2FBOyeYYIsSIoAtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nb32IC0y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so25565325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711355527; x=1711960327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EJVN0cgUQnfYRe9h1VVQ0MrOz9M5AG8Pfe5rJ4y9IdM=;
        b=nb32IC0ybswF2xq74mik/4DWvgaPO2MX9Xa7eNzbz4BcqlcGebxrnY38jGEuwvohFW
         WdHAhDU+nVvqvvaCkW8+A1o4efT8Fg4pFVFIqTzCO/Rviz7v+ParWk+ZOT4LF16CzzdD
         ZUWEq3SGUKXsgJ7GCOuh8rkB8LWQYVRmp4XwnwpslYROTxHrbiGSSadpIH+tiEuEa0Q/
         9qhaZ5PZr6THu8MR5R7PWuU06qTrRG3nl+ECtslP+QTV1KLUgWQCKOlxNFmyW6tB9UYv
         H66A190RVpZo+mcnMc1+pmT9jYjF/xXhd48iHXK/r9FMlm1zgnElQHBQKIWsMRwRZTzu
         a2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711355527; x=1711960327;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJVN0cgUQnfYRe9h1VVQ0MrOz9M5AG8Pfe5rJ4y9IdM=;
        b=X5vexgJQvHSZ1vtNiporau6f6SkOVVqZUruPa2YOREhzp8Cju+G8niXf/Dp1/yVryD
         8Dc+u70YRtqwPqFfxUB5oLrtb5BWg4g3kRhTcNsFNNCnccOpL/DP6hccc6xsGCh/Kn/m
         4ZeueHm/3NG1NxU0/yFuYS3af3r4t1DpzR7cssVZH/ZlIYvwUcCJu/fIj6FaWkxUHeu1
         b0dzXa2AOO5ev9StGY6Y1YiHBuxQP1Dy26YJAgN1KNV1dZ97zQqnxfVKsbIPFR4rDbxw
         KCB2/mK5ldydwB0YiANblhtsevaGdlmpZQdtuI+4aR2NQsrmsGpy7jvQe+XyJ8muy1gF
         JDKg==
X-Forwarded-Encrypted: i=1; AJvYcCX229+nUSAJe9K3q0d4w7jPoMQihb0pzrMDGlw2TcMzghRhgbpNDXVziBDDKf8/Z7Ekt59qWjYWA2lmrjnZbN59NW6qsOAjpMwpyueP
X-Gm-Message-State: AOJu0Yz2mTGDAVO48fa0nrV7qh5GVF2nVkXJOQnwCiFQCpPnMn1b7ca5
	mYJC3oZUGFVRTndAahgSpipw0I56maSVnEox4bfDB3GR+HedrbNgIG9jq1h9mN4=
X-Google-Smtp-Source: AGHT+IEfSPV4hQK/OxtuNuY45jUFIPtq6au32J2QP9/J5O01fmDJJZnZBiQk3fcOQXpMfE0Cbkv3EQ==
X-Received: by 2002:a05:600c:3c8c:b0:414:61d9:d1f5 with SMTP id bg12-20020a05600c3c8c00b0041461d9d1f5mr4619016wmb.10.1711355527510;
        Mon, 25 Mar 2024 01:32:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm379156wrb.98.2024.03.25.01.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 01:32:06 -0700 (PDT)
Message-ID: <c3f296d2-63b0-493e-a2cd-5010dea84adb@linaro.org>
Date: Mon, 25 Mar 2024 09:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: hwmon: Add maxim max31790 driver
 bindings
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
 <20240311111347.23067-2-chanh@os.amperecomputing.com>
 <6fb70adb-aa85-4b9c-b093-afa4ec7ed056@linaro.org>
 <ab8b45c5-2ef0-4a87-87bf-f797954b4574@amperemail.onmicrosoft.com>
 <a224e752-d99b-45d3-b5db-761a698c347e@linaro.org>
 <21256600-d94d-4287-b22f-f22258121668@amperemail.onmicrosoft.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <21256600-d94d-4287-b22f-f22258121668@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 10:53, Chanh Nguyen wrote:
>>>>
>>>
>>> Hi Krzysztof,
>>> I have not yet understood your comment here. Please help give more
>>> details for my missing! Thank Krzysztof!
>>
>> I expect many more properties of a fan controller. Resources (clocks,
>> PWMs, supplies) and FAN specific properties.
>>
> 
> Hi Krzysztof,
> 
> I'm creating a base binding document for the max31790 driver. I'm basing 
> it on the drivers/hwmon/max31790.c. Currently, the max31790.c driver has 

Binding should be based on device (e.g. its datasheet), not the driver.

> not yet implemented other properties, such as clocks, fan-supply, pwms, 
> etc. So I just introduced the "compatible" and "reg" properties.
> 
> In the near future, if any other properties are necessary, I think we 
> will implement them in drivers/hwmon/max31790.c then update this binding 
> document.

Please instead read:
Documentation/devicetree/bindings/writing-bindings.rst

> 
> I look at other binding documents, I also see something similar. They 
> just introduce the "compatible" and "reg" properties.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml 

Maybe these devices are similar, maybe not. This should not be excuse to
come with really incomplete binding.

..

> I think "fan-controller" is a good node name. Do you think so?
> 

Yes.

Best regards,
Krzysztof


