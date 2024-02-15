Return-Path: <linux-kernel+bounces-66867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77A8562D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430E11F2112B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1401C12BF2A;
	Thu, 15 Feb 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtzmAB6B"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0412AAE4;
	Thu, 15 Feb 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999225; cv=none; b=fxRDHNfK4Uix3TtlIIP2lhPojsu92AAeJg1HssIhP63qzS1jXvtdoo/DXY9dlbbhZsI14b+a2ljQVBy4fA9I2ncjbZYEKg4uRCEEUioTXl2i+wvybsSJ4fO8YI9SEa4baK0xhIzmYlXYFgBuQsegii6VcoYc8L8CGwvZxVq2hf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999225; c=relaxed/simple;
	bh=kCojogxkBPGCvdnlaw7v6wJGX03NJww1FMAv7kOWbCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zy+E97M/mpuTyCO0nPm7EMYOaLXIdnoLsCoushdr6OEdibhwUYjcssYJsR6650nxnnD2Ktai/5qjmc3fQVgekYLuV/qy3zckgLk3eHVQ1fyRqLdtXEzeQH4qCdAUtv0bikTsB22e/TQ9N8Ma5nxbyH4pMVyoT/SlBQ8Di4ZWEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtzmAB6B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-411f895c8b6so6756495e9.1;
        Thu, 15 Feb 2024 04:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707999222; x=1708604022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCltLUDIFGC1hblD4ry2SCiGjebPDwNZZNafoF/wgL0=;
        b=CtzmAB6BELkn+4Jtfd2+Ii6h9MbgnTCgFsT7DZJH1iO79t58cb6EY/5BKTHyaDdzNf
         OQboPpO3cQ9pWY9QAJuFDAuT15HIFEtUMLSCXZFa7waoe6+OeZMLjTud2GJr5Gnogh0f
         G3Jl5UmlTYYErUDAYi00LrM/iAlqGrkM//SHXDyf4JBfL+mWRCjGdkNxIWJBCGqh61o7
         Ehbw02SCxtIpXcIrzRR+cKpUqK0KG4Opek+bFLjFowMjYwTvCSACd/aD6SebpO4SAn2c
         v+jYNuWRw70iTFuhqOl+Fs8iP0Jfor1TvmPF53HGnqr7aIAvoPeQdo5VdaryQ1GbCYRG
         wtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999222; x=1708604022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCltLUDIFGC1hblD4ry2SCiGjebPDwNZZNafoF/wgL0=;
        b=ZPp+cCf+ArpiHBLQo8w2/6lFjq7HqiMSeMTkAjYLAfX4X4dunxo28hQuv8E7DABPh4
         yab1PWHry8h+TjT0ppDLAupEUBiEVq7RzAa7sNTQ7dHwSmvQBnfHr4l7f5v18iZswhP+
         q6H4dyTpUzksSGET3nJsnOvioiphFW8w10hGvvqR9QeBVRq2eKBQKebBk02HiiLLx8DS
         79jUhDOPt1tJvz3dMgyllJ5cOvTgkvESLZQTjO+rXDMy5ferGGj2Ss1sbyML3bEd8PbG
         EGrsezjgOjzEmzq11PY+RD1ks96JQkYL5sTOgZZOq7PUOTpSXAm5XSuDahH04YcrG/hh
         bzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUMrIqO+PSXOHKLA2LJm02IDJC2Bym7BuHOV1hm817bMugVs8WixixzAxTGBjYBBDSt3akSbufdu8m3fNWnXO5c91o3cxRuFGq5R4LL62XHQsslBNP3fOS3tyY7QCdAXnmVBnGA6TFsj6Nfkk9lepuU/1tKYPWvAMl16jVZiZEUB8MmwQ==
X-Gm-Message-State: AOJu0YxvA0cD4BnmZiarcGOFooktcXAL/yLYrMMoZDMMVvmlM9l9RVvk
	8zKFgGWCNbFnOIGuon9FitYle1RwGUORDUlV2QcKBXggabvwSZbQ1zTMglhXI8Y=
X-Google-Smtp-Source: AGHT+IEtfVhmb+P56obMhgGA0oXzzNXX5d8Ra2/f7VPqZcMteJxF3blC5Ww4auJ+inj64e3MEA/aeA==
X-Received: by 2002:a05:600c:198f:b0:411:e5c1:e573 with SMTP id t15-20020a05600c198f00b00411e5c1e573mr1149675wmq.7.1707999221569;
        Thu, 15 Feb 2024 04:13:41 -0800 (PST)
Received: from [192.168.176.154] ([5.14.144.108])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b00411ab6dad65sm1822214wmq.29.2024.02.15.04.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 04:13:41 -0800 (PST)
Message-ID: <73d01418-65e2-4327-b6b3-c4de501c2920@gmail.com>
Date: Thu, 15 Feb 2024 14:13:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Conor Dooley <conor@kernel.org>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com,
 jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 krzysztof.kozlowski@linaro.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 robh+dt@kernel.org
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-5-alisa.roman@analog.com>
 <20240208-occupancy-shudder-514d8569e261@spud>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20240208-occupancy-shudder-514d8569e261@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.02.2024 20:03, Conor Dooley wrote:
> Hey,
> 
> On Thu, Feb 08, 2024 at 07:24:58PM +0200, Alisa-Dariana Roman wrote:
> 
>> +patternProperties:
>> +  "^channel@([0-7a-f])$":
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        description: The channel index.
>> +        minimum: 0
>> +        maximum: 7
> 
> There are only 8 possible channels, at indices 0 to 7, so why is the
> pattern property more permissive than that? Shouldn't "^channel@[0-7]$"
> suffice?
> 
>> +
>> +       diff-channels:
> 
>> +        description: |
>> +          The differential channel pair for Ad7194 configurable channels. The
>> +          first channel is the positive input, the second channel is the
>> +          negative input.
> 
> This duplicates the description in adc.yaml
> 
>> +        items:
>> +          minimum: 1
>> +          maximum: 16
> 
> Hmm, this makes me wonder: why doesn't this match the number of channels
> available and why is 0 not a valid channel for differential measurements?
> 
> Thanks,
> Conor.

Hello and thank you for the feedback!

I will change the pattern property and the description.

Regarding the channels, I followed the existing style of the driver for 
the AD7194 channels: one iio channel for each pseudo-differential input 
channel(AINx - AINCOM), summing up to 16 channels; and one iio channel 
for each differential channel (AINx - AINy), summing up to 8 channels. 
For the diff-channels, I thought the possible values should be 1->16 
corresponding to AIN1->AIN16 (I will add this to the description as 
suggested by David).

Kind regards,
Alisa-Dariana Roman

