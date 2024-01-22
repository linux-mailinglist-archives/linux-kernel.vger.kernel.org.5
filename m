Return-Path: <linux-kernel+bounces-33055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F78363CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70651284847
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13463C48E;
	Mon, 22 Jan 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miNlrR4q"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE701E4A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928218; cv=none; b=J3353EdKd69uaAwB0PI/bGy/Q7qRWZ14p9w2FAuazbdpuA2JkBcisH/zY19gRpMCKQHcd4SE6dkSlGFypThWsh8k81lnrMlsTJANUIi/38yjQxPbsEkL00uAX6uboOi5ZCZThMSs29mKnRD+/hXMkR6JCqh2gUVoKI9uToCOcNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928218; c=relaxed/simple;
	bh=BlS0demiSe1JnEnaX+WGuznDALy44iWE0Vz39zYNSps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c6cWMzWspA1weYbWNRphUimClkbU7ff9eY4l9P4CRz4/1osHeuFUr+ruMHEnTu7pDnpd5WlCWHcJ/r/b80qlG5SZU4wS7OJMTurwDR3ow8mp4EI1NywJzqs5/ZaDjkNHq0zwO6lubmiV+CrDvXYQqd4CjVgAiivTOMGE+xMvFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=miNlrR4q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so37431405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705928215; x=1706533015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihKeGnpC90MvY5sKmPc9CdNDaRZxILAyOx5j+zn8IjQ=;
        b=miNlrR4q1hGokJr1OzaLsOiABblBee6PCT8lrTN+XrVrEgr1CjDhkRBZktivuzXucE
         ZxTIb3Dx700i0Mx6C8ESxfIB7yAbYel2JR9JZ6TozgV8MGR9K4xXQhy92TciMYqAymhA
         79igvr6t3ZzkKrTOpB+F0wv/eusnc4uLhTifzhahHu1UQnKviXl5u5pxL2V50ipKGloH
         Ke4qZmjdtc2PHzJtzzLSV4u+NG+cNYccB0WuvoeWxk/qEIC1iBTk36zByeaYoKqCzZqM
         5ozPkC5ri5HJ2eGaALbTiLT0oOdUHbxZbnPSJ5De4MQmj4YvHzYy2hSIe+TJHL81oles
         h+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928215; x=1706533015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihKeGnpC90MvY5sKmPc9CdNDaRZxILAyOx5j+zn8IjQ=;
        b=KJROTSoN6Dnt9I4UC9oEbtpMbv6PeycT/i+2KilGuRKOti8t9eajlF+GUbP0HXj1jj
         98NP76AkvYjmcNVqXSVpY5GWyTnuH8wapubGrGJBzt9rRcrp3ST60xDOxVHygQgQp5Ok
         0NF5/5/o/2ryaPMXSemGist8OaoeXgiZ2r03Jqk8tat9WwZNTyftgujty+267QFAUgjH
         o/0TlOmJBx2/7yujf2h3khIzil/rHcOPbjWcRUkFOOAgTrKZ/K0Zbwm9sskcWRIw4vEX
         KQsLLYDu0szKjA4fSXP8VJ+GOyDA0fUozyzMC7ajCxs2T1Nv/3U043s1kkfK+lS7IKdM
         pPGw==
X-Gm-Message-State: AOJu0Yxg5VlsKeyKmAm/nXQx3hUv7gsXa1Z0jnulmOl245dQzFEfKZPz
	hGF3jYfU83FM7BrI3oDOV+beEHN/BlciFmdDL3ZtbauX8dZN/Yg+D+QVLG3BEII=
X-Google-Smtp-Source: AGHT+IEzCfGBrUXua9u+W8n3UjUn/hXCIVAZeFTB8AqYsN7xWeNVTmRrpd8Rjd5nRs+yUifIshxJ5w==
X-Received: by 2002:a05:600c:4fc5:b0:40e:9d77:ae00 with SMTP id o5-20020a05600c4fc500b0040e9d77ae00mr1679900wmq.254.1705928214891;
        Mon, 22 Jan 2024 04:56:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b0040e3733a32bsm42573762wmb.41.2024.01.22.04.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 04:56:54 -0800 (PST)
Message-ID: <7d87c455-7af5-4339-9088-6015d5847e88@linaro.org>
Date: Mon, 22 Jan 2024 13:56:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
 control module
Content-Language: en-US
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
 palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com,
 robh+dt@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com, guoren@kernel.org, jszhang@kernel.org,
 inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <MA0P287MB2822FBA18674540BA85035BDFE712@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <c9feb32f-1efb-4613-94c9-9d6bb0f45366@linaro.org>
 <MA0P287MB2822BCB4E43BCB495FCF9069FE752@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB2822BCB4E43BCB495FCF9069FE752@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 11:11, Chen Wang wrote:
>>>>>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>>>>>> +    type: object
>>>>> Why isn't this merged here? You do not need the child node really...
>>>>> unless the clock inputs are specific to that clock controller and you
>>>>> will have here more devices? But where are they in such case?
>>>> I don't see more devices will be included later. It should be ok to
>>>> merge them into one.
>>> hi, Krzysztof,
>>>
>>> After some double check, I find we will have more devices in
>>> system-control. For example, in the SYS_CTRL area, there is also a
>>> section of registers used to control the "General Purpose Interrupt".
>>> The pcie controller of sg2042 will use this interrupt controller which
>>> is defined in SYS_CTRL, we will add it in later work.
>>>
>> I expect then all devices to be documented.
> 
> hi, Krzysztof.
> 
> First, I'm very sorry for having double-checked with you for this system 
> controller and child node issue, but this time I'm sure there should be 
> no more child nodes except the clock and interrupt controllers, though 
> there are some other registers in SYS_CTRL section, but we will not use 
> them till now.
> 
> One question, when you say "to be documented", do you mean I need write 
> binding/yaml files for other child node? But they exceed the scope of 
> this patchset (this patchset is for clock support only). That's why I 

That's not true. The scope of this patch is to add DT binding
description for your device. If you choose any other scope, I don't
agree and I am not going to provide positive review.

> suggest just add clock-controller in this patchset and to add the 
> interrupt controller in another patchset for pcie support. This 
> mechanism should be suitable for our expansion.

How then are you going to solve the requirement: "DO attempt to make
bindings complete even"?

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L17

Best regards,
Krzysztof


