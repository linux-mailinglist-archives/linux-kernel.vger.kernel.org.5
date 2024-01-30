Return-Path: <linux-kernel+bounces-44898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300D8428BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2854D284795
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A41605A6;
	Tue, 30 Jan 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bY2JjupC"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7186129
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706630715; cv=none; b=qZiWIZ1e8BHP8m6q6trQ4OQxjsu3PJN2pRAcBDTemEHfug/1dEY+Ti/qRaFN2lw3Ted6JqpfVgdRHiVrCXLo4RfTei/e9XloKYzoQSmmDPblr+i3pXo4lfY+luu87MjBgLzaQ+JVydB0ab0ZRu5LG0gsyAqw4l1Fd57VP3gbJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706630715; c=relaxed/simple;
	bh=unh5iIZOG1QtDQYkC1HtT7urjlgqmEQq3IudvN2ogOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLgyH97qC0+yEQpqhpLQPDp8tlPeEsjwFdw34WM+cY8rlWxG5LJoBeZ6CrjPx+e0TDaH1LoVOrW3bQZ3KIoJojKQJ41T5hdFkvbtPd/U9XOQ1/Mk/zL7FY0Qa5OSrsO2PT81OulXXQ8/2oKOnEp43wrnhpJ1ZTw1G/t69PYWy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bY2JjupC; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28fb463a28so492747966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706630711; x=1707235511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VDh4iDFXXue5I/l6Y1wqSIUFQdASHvv7bgRaIo08RQ=;
        b=bY2JjupCgZUxdtDOjWqYdKrzrIYi8nNYbAsAz0LhP7mnD2XNiIIA2PlAVAD8ZJvw+g
         RSMOMqwXqPetuOgJvnXyL9G3WQPfEABLUW9CcH78ENb3keJJMjeOLkh4/2d1Dn5o6cdc
         65PVlopkBJY3NwuvVEuhj5r6GlTRWZGPCGyKK737ygAz7s5lDO/ojyiBccYfcpIkzoS/
         pcwNGKWVEM+0PJMeJeOD2Z66Gkbt0ANncmYNMi3r7lSZ8JL4WUNuewM2k5v5TjvobK/y
         QLhCToH1uYHMBTPkmfTTnGUbpR1/TuZxxJwxNEAmRZ6CbykRDnUCc4Tl6hEFxFi3PhwP
         0M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706630711; x=1707235511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDh4iDFXXue5I/l6Y1wqSIUFQdASHvv7bgRaIo08RQ=;
        b=TxXqQEMPpld2GSC2OpRNt/myF1VYWvbD48fhHbDUGCyohdf9JBs7uz3p1IQmA3KR+C
         mWxOeP3xu2sT0GGmE1iDyg3Z2fUcQo/hmoVUNZlHDKTAXCxxmXiNSI85NBIMtK1Q7MBd
         V9DlB4IrjnRhknatTYqFzeo0FsybjygT0Dlgl9gbRNwgmsh+tWRyRXs7wA9nkKdyUeW1
         v+fbKawKLykX4IGpw6FJKbWEaDHszhBXZ3Lz9U7bpXN4v2QqODFBe1ZFhuetvpjG6AJ4
         R8/0oEs4sg8i58j1mV5GpffMLZhHv51/w18AbIFrqzkKZwz7AVMrNaFXP63fIFh2z3Uu
         8+4w==
X-Gm-Message-State: AOJu0YwuSuQtzaXK5ffVWJP3CWh2RYZ29zRuFgR0JnroPun1ZdPOZ69I
	Gl508RR4R/h/KkbnxyN5M51an2txobFb+pNDFH+jIOtu808s2b9sN6VnOytZBfE=
X-Google-Smtp-Source: AGHT+IEttDPY67Gj0M8Wg0MEFDrc2M7fmw+GWrrPNiUYvlM+dBE4LqXHiYWn8V/vBm0G6hMfomELuA==
X-Received: by 2002:a17:906:f208:b0:a35:2ee1:b953 with SMTP id gt8-20020a170906f20800b00a352ee1b953mr6383969ejb.26.1706630711165;
        Tue, 30 Jan 2024 08:05:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUEUEkig/baHmI5ejySEZr/n0F5q99g9miAQm0roSRF9DW50Li2aldG0TSo+h9Z1Uj7T05yM3Fa0pN+rJDCi7q1KMPcGqJC9OVObKBwjNc/oarDB1OmhqlwDkyw+GpTBgQrfnw4vKjEWE6f+lsnEJ9HJFtEwV+hfyN6rsaZNp2AbS7mn2KGwtqMAnTQDUMBxdbFjScpWbJaioHwlw8/YRM6bx8plINYceIqPHS+/nenIadsYQfYWp3vadhtiTsGnjjTuoadcZOMw2VeHvFBOPQRho9PIzeZG1tDF9eEZBCgdjOZ8er999dxaDJRJWm36LBFDWfnV9Oy1ZBmmZvR8wIH4txLn1jV1aXPDDPPjwsWrens
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id tb11-20020a1709078b8b00b00a35f9df7768sm1421990ejc.182.2024.01.30.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:05:10 -0800 (PST)
Message-ID: <32669bc7-90b5-48d9-8845-2e072a477c6e@linaro.org>
Date: Tue, 30 Jan 2024 17:05:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, hao wu <hao.wu@intel.com>, yilun xu <yilun.xu@intel.com>,
 trix@redhat.com, krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Brian CODY <bcody@markem-imaje.com>,
 Allen VANDIVER <avandiver@markem-imaje.com>, linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
 <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org>
 <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 16:45, Charles Perry wrote:
> 
>>> +
>>> +  reg:
>>> +    description:
>>> +      At least 1 byte of memory mapped IO
>>> +    maxItems: 1
>>> +
>>> +  prog_b-gpios:
>>
>>
>> No underscores in names.
>>
> 
> This is heavily based on "xlnx,fpga-slave-serial.yaml" which uses an underscore.
> I can use a dash instead but that would make things inconsistent across the two schemas. 

Inconsistency is not a problem. Duplicating technical debt is.

> 
>>
>>> +    description:
>>> +      config pin (referred to as PROGRAM_B in the manual)
>>> +    maxItems: 1
>>> +
>>> +  done-gpios:
>>> +    description:
>>> +      config status pin (referred to as DONE in the manual)
>>> +    maxItems: 1
>>> +
>>> +  init-b-gpios:
>>
>> Is there init-a? Open other bindings and look how these are called there.
>>
> 
> No, the "-b" is there to denote that the signal is active low. I think its shorthand
> for "bar" which is the overline (‾) that electronic engineer put on top of the name of the
> signal on schematics. It comes from the datasheet.

Then just "init-gpios"

..

>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - prog_b-gpios
>>> +  - done-gpios
>>> +  - init-b-gpios
>>> +
>>> +additionalProperties: true
>>
>> Nope, this cannot bue true.
>>
> 
> Ok, I'll put this to false but I'm not quite sure I understand the implications.
> 
> My reasoning behind assigning this to true was that the FPGA is an external
> device on a bus that needs to be configured by a bus controller. The bus controller
> would be the parent of the fpga DT node and the later would contain properties
> parsed by the bus controller driver.

Which bus controller? MMIO bus does not parse children properties.
Anyway, if that's the case you miss $ref to respective
peripheral-props.yaml matching your bus and then "unevaluatedProperties:
false".

Best regards,
Krzysztof


