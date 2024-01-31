Return-Path: <linux-kernel+bounces-46297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891D843D94
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BEB1F2EBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B37F497;
	Wed, 31 Jan 2024 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/2AYQfw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1727F479
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698755; cv=none; b=qntuFQfBpKCYSgGerHc2EWI7ikMtk6I81LEI6NhmAfbjjg7vgoz47K2vnmcK/iGl8pVw1K+vu1E9HQgBCpxrdvauFB6TfGdzkb1L2hpUyCn7BtK0LEDQVTxnGetEOxPValWwwx/Y+bwyLMmw56cV1EBKz9LNC3WkPRl6DimVhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698755; c=relaxed/simple;
	bh=+HH4T5gCCW7B6/O11DJ1e0ynoAupK45aqEDlcF2lKb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KL+Mvekrpn3D7Pfo96EXtCScQHlWUzRBDPESQa8E5jDFKSZygZc2ZTDLOtlFc9n5woOhzJGObNHZGuD8r1eYPfLBFzkN8jvgTskVfQU6hgeBtiPTRaUKcdpik+pKC99I4tTs2xqsYxP76Ww3oSTk2qS8KH1fWJBFwDhLuwtrc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/2AYQfw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a315f43ecc3so523893866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706698751; x=1707303551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8daxsfgFAdPln+pSh5rU6HQsvWnE80v2yJ8udP+jUgI=;
        b=l/2AYQfwBSzNqbxdsaP2kVJvT8ZIAMxWdbA6Mzr6JjH7hvnI74BwrD1raCAA971bsj
         XdvQY4M7JXky6Bh1gVuapmYXbHJRxhOhr1t33pXwFOujXMCsz8MF8DAhbaDpln8DHbtR
         MeGcw7Y1BLohHkkyeQs0bnP5Gr1BI5j5W0iTBAvNJzf3PfcP6pgM3ZIPc1BOG4oi0M0j
         0ksOfNub4IK254waB301pwisgEYuEaKwo/3VQxsUv8cX4elaWUrh1x2v8U6kIgWh3C4X
         AkMEsfaELJhHxF/51eqgnGDQmi36qZm8IZAAj9MYGTXmgd9BY+QvIyOGbT+rCmXiIRtj
         xrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706698751; x=1707303551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8daxsfgFAdPln+pSh5rU6HQsvWnE80v2yJ8udP+jUgI=;
        b=T4Ck5Ik88/UVAKFhY+qbXWEMUCR6N9sUni00BDWUcAILveWgiBMrWQb5pFX4ek6PMt
         8UZ4Zcx/x2nUwVf62WNy2YhCCggNP/gu8XcoALiNRtavmVQWNOiSIQ5LIJF0je0NIua+
         5IQhKEE1wkNeHFWWN6sKCVjCC2t8kE/q49BPeOn2TZP/nGcs8DuBFMoxeTopNxcsYFFn
         Bq1Y5JN3jlrMFfXKi/v08tY5dMvGW2Jk+qnIbqNmFHwYiMV8pLhhoLvQ6B11YxvGOkVN
         xq75TNAxioxSzMc+bI2lsLv5WJw3V1jzpmTtBCguvpH2RdHMoeQipIe8+WbQ6TNru55n
         83KA==
X-Gm-Message-State: AOJu0Yz6oNWV3dDTVRPpf2RJeLsHKJ3Xy89XR1S1cffLzNx97zpSjJri
	P4rtx9I2g6493qkNdBB0N9Z2VsHFwtVUU70rRcJxzVTpeg64N1JHZdajHG19p7A=
X-Google-Smtp-Source: AGHT+IGjjVldnBQDUYLgFnpa7q/CgYzqbCS/pXV8RvKfq5UFsY2R8HJq/5hgUc8oSMFJsNTaG/qHvQ==
X-Received: by 2002:a17:906:7cf:b0:a36:5dd3:6126 with SMTP id m15-20020a17090607cf00b00a365dd36126mr948578ejc.41.1706698751437;
        Wed, 31 Jan 2024 02:59:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX5qlE/FjXIH6HPQXuhaMoBmoz78ws/YoqZ6+PxH+fsKbDCkN1t/ApHlU+lYpNhK64RDKP50ewZLknSNfh5RNFP2v1ZmzTsFU+h+KObUMgOOmGRTco+mCEVl5rGSZ4IQF8mV+Zh6u/MmzUUif3GC0p121DGv8GicaR9fmE/btRToxTFvu2gQjHAXdAh3JbpKom1eeTuiRPKUpQ9u1vP2O3zSjMeiXx/mjTJToMaGxqbTerP+Bvwscf9e/1h353xupADGsccL3Mtx86yd8cZToniLK1V73Ja4bMa+0u3rD6auDTQTbHp1xuVfjFBXt6u2i0rsQMlmsdjQ5aCAYxIMCMm+yvFsB0ng6XiGyqmynZxgPJAtGkUkMAHvh8TctorJynRuv/z33TZgZrpBKgwAdnQ+DySFF8v07z1koPGqOKNlCsKAfemGCKMnKCPlFzJF3FymWzmj7HhwyUmVlwGdge7Cew7dODxzCtmYziZNpLuRZRce/cIt+wA+3XE9lRmThovBwNyRRxGu3f91qFtTGRhepddPN/UpfquCS8Zx14R8GsBToZf0Zv09BDik2LSHAziDMQwb5UkRCUntPpq4uPv2e4g4Rv4
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a3542a13eb3sm4908793ejc.138.2024.01.31.02.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:59:10 -0800 (PST)
Message-ID: <94bf91fc-9f6e-491f-b332-d60e69ebd9d6@linaro.org>
Date: Wed, 31 Jan 2024 11:59:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: input: Add TouchNetix axiom
 touchscreen
Content-Language: en-US
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
 Jeff LaBundy <jeff@labundy.com>, catalin.popescu@leica-geosystems.com,
 mark.satterthwaite@touchnetix.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 bsp-development.geo@leica-geosystems.com
References: <20240125165823.996910-1-kamel.bouhara@bootlin.com>
 <20240125165823.996910-3-kamel.bouhara@bootlin.com>
 <2c8961ff-9fcc-402c-b048-744ae9473164@linaro.org>
 <20240130222844.GA2527859-robh@kernel.org>
 <f07d7557-c190-4154-8fc7-6a3850b1d162@linaro.org>
 <20240131090652.GB3004909@kb-xps>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240131090652.GB3004909@kb-xps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 10:06, Kamel Bouhara wrote:
> Hello,
> 
> On Wed, Jan 31, 2024 at 08:28:43AM +0100, Krzysztof Kozlowski wrote:
>> On 30/01/2024 23:28, Rob Herring wrote:
>>> On Fri, Jan 26, 2024 at 12:46:16PM +0100, Krzysztof Kozlowski wrote:
>>>> On 25/01/2024 17:58, Kamel Bouhara wrote:
>>>>> +  reset-gpios:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  vdda-supply:
>>>>> +    description: Analog power supply regulator on VDDA pin
>>>>> +
>>>>> +  vddi-supply:
>>>>> +    description: I/O power supply regulator on VDDI pin
>>>>> +
>>>>> +  startup-time-ms:
>>>>> +    description: delay after power supply regulator is applied in ms
>>>>
>>>> That's a regulator property - ramp up time.
>>>
>>> I'm sure there's an existing property name that could be used.
>>>
>>> But why is it needed? Is it variable per board with the same device? If
>>> not, it should be implied by the compatible.
>>
>> I meant, that regulators have such property. Unless this is coming from
>> the device needs, not from the regulator?
>>
> 
> After looking again into the device's datasheet [1], the delay (startup
> time) is not really optional and it shouldn't be set through devicetree.
> 
> IIUC, it have to be set unconditionally after a device reset or
> a vdda assertion.
> 
> [1]: https://www.touchnetix.com/media/dgnjohor/tnxd00394-a3-axiom_ax54a_2d_touch_controller_datasheet.pdf
> --

OK, then it's not a regulator ramp up, but rather part of device driver
(deduced from compatible).

Best regards,
Krzysztof


