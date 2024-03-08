Return-Path: <linux-kernel+bounces-97312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B372687689D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BB283888
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB379E3;
	Fri,  8 Mar 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfEMYwq9"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304179D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 16:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915730; cv=none; b=tde9lztyGP85iNR678hSTYmmoVV40mwKiRUqRxfastmRIly6tIbYP4ih2NEZ8/mu+qdWeS21rMSCjTqQcGxaCrBSnR/ESDEAsZibeF0NUNMxvkb6z5V3PjH5T4Mg0OfxVy7fbRPiD9QNnUeBM6tfFDVZMSsEDV5EwEp/Cc+j3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915730; c=relaxed/simple;
	bh=8HyqZabxQYf7AXqMlKh4uAssALJXweqp+r1TIBILEMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENNB18uev367r5ym+GyeGeKnEnmbzZxSlOUyMd4kbZglH8TadX2m95jOkuS+0rYkKyPEVXafeBAeJNNCSvO3jav9/DHnK7l8gRJghFHvoXk+nDYEGaqamCr83Kx+vgCrgBqULbHgXBp9L39TozRwIOHnn2ArI+7flKd+gY+46pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GfEMYwq9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so1330709a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709915727; x=1710520527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6nynSl4KKVg6PyZMjd2Anc6ZOa+XqWZVVXmkeUHlSvY=;
        b=GfEMYwq9RQwj+xl8uo+/WbF4YZvbz4tukKnPRbj8W4pF8TaOnBdKv8eWl+674/zuI1
         7IvmKP5ZorhIYpHCk+B3vM3JMIQWMUvX6pRbsaODVaSz84QezLI7jnk9h83GimQtL8WP
         6ZBwWyJKsTmRiea0tOsQ82imIb42mU3oWm71w+VYvsokp5K3UYzzFAsubseOoZ545dDb
         disZM+hNVR2Rij6Tw2UkqxyqpggRSNKWE5vMO6D7kReHsE2JuNW0HeWnBylAo1XdaJHX
         CL5/MQRimsnuNPieVF77sF/+947li1M28PmMdlZan78TYscNedgriRml59glWsRHIC5t
         h1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915727; x=1710520527;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nynSl4KKVg6PyZMjd2Anc6ZOa+XqWZVVXmkeUHlSvY=;
        b=p6GRZGo0/ozAXXAKivNP2+olcllz8x1zGMx9siw1rBaYalchwOUEN4aBWXd3T25Wc/
         nsh8xsILZyxlENo9sRqpCqtPNg5aJIGMtogaCqRvtvonXFecXepG54HwtGZ70fv5ujNp
         Qlxqk3UUYz6T24B79DRlgANBqe1EMJ+WMNqafEV0oEXNXj/RLJzx7rOCQ72CFXuaeu0L
         D7xjslL7+Qf6CZD1ILyj7xrPIugRQ1m0mL4yQPMBZM9VrM/amb+LDoN4x60oF4pwMJi/
         WaPOr6P57ex0HBcRjwvHGd9w9Qdvjqu7ME9RElXsk89YuyuJZ+REH/LTonHuG/BNySSR
         LRmA==
X-Forwarded-Encrypted: i=1; AJvYcCUGgB/GwKt3R0WlcmE+zCAlJy/nG1SRz10O9EzyaRYdewY3IW9YMOCkj8AhRtQy6roxM9WeZIeNcIk/+3ws4EbguZQQbVQPfoYbbyZs
X-Gm-Message-State: AOJu0YyAU1GAJXN8mOqvgI9xKjBilzOINcHnUbPK1OKm8GqtXHT1WWVU
	OsQ8YiGu9b1wI5pKipoPVwtliKdK7+9Pzewxv1Wk5Jhj593AsYUZzks//LUydMdSg4p+b73kxK7
	t
X-Google-Smtp-Source: AGHT+IHZabur8zMf/rq5QuXHgiZC2wfvFqCl3kkATgoC4AoKvSxhJrgcDyUuaLFSdrIF8GnBZjH5Ng==
X-Received: by 2002:a50:cd43:0:b0:566:5dcc:1c27 with SMTP id d3-20020a50cd43000000b005665dcc1c27mr2082163edj.41.1709915726684;
        Fri, 08 Mar 2024 08:35:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005653439cadcsm9242007eda.25.2024.03.08.08.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:35:26 -0800 (PST)
Message-ID: <4a4203b0-0775-45c6-8dd0-51dac41c1dbd@linaro.org>
Date: Fri, 8 Mar 2024 17:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240307114217.34784-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <4ba7af38-5cc1-428a-afec-75610934fc72@linaro.org>
 <CA+V-a8txZr8WWxtN-=Ek3WZ3GwLT3m+Tcog-5zAx+A4kZL1=yQ@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CA+V-a8txZr8WWxtN-=Ek3WZ3GwLT3m+Tcog-5zAx+A4kZL1=yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2024 11:18, Lad, Prabhakar wrote:
> Hi Krzysztof,
> 
> Thank you for the review.
> 
> On Thu, Mar 7, 2024 at 1:50 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 07/03/2024 12:42, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> This commit adds support to validate the 'interrupts' and 'interrupt-names'
>>
>> Please do not use "This commit/patch/change", but imperative mood. See
>> longer explanation here:
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
> Sure, I will update the description.
> 
>>> properties for every supported SoC. This ensures proper handling and
>>> configuration of interrupt-related properties across supported platforms.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> ---
>>> v1->v2
>>> * Defined the properties in top-level block instead of moving into
>>>   if/else block for each SoC.
>>> * Used Gen specific callback strings instead of each SoC variant
>>
>> You are sending quite a lot of patchsets touching the same, all in one
>> day. This just adds to the confusion.
>>
> Ok, I'll make it as a single series.
> 
>>> ---
>>>  .../bindings/serial/renesas,scif.yaml         | 90 +++++++++++++------
>>>  1 file changed, 62 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
>>> index af72c3420453..6ba6b6d52208 100644
>>> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
>>> @@ -83,36 +83,24 @@ properties:
>>>      maxItems: 1
>>>
>>>    interrupts:
>>> -    oneOf:
>>> -      - items:
>>> -          - description: A combined interrupt
>>> -      - items:
>>> -          - description: Error interrupt
>>> -          - description: Receive buffer full interrupt
>>> -          - description: Transmit buffer empty interrupt
>>> -          - description: Break interrupt
>>> -      - items:
>>> -          - description: Error interrupt
>>> -          - description: Receive buffer full interrupt
>>> -          - description: Transmit buffer empty interrupt
>>> -          - description: Break interrupt
>>> -          - description: Data Ready interrupt
>>> -          - description: Transmit End interrupt
>>> +    minItems: 1
>>> +    items:
>>> +      - description: Error interrupt or single combined interrupt
>>
>> That's not correct, your first interrupt can be combined.
>>
> In here we are combining and making a single list hence the
> description is updated as "Error interrupt or single combined
> interrupt". so that we dont have to list the items in the below
> if/else checks. Also when the interrupts are combined we dont specify
> interrupt-names hence in the below check we  set "interrupt-names:
> false"

I know what you did and my comment stands.

Best regards,
Krzysztof


