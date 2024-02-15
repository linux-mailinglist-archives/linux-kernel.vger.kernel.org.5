Return-Path: <linux-kernel+bounces-66432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90013855C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177F71F2EE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BE413AC2;
	Thu, 15 Feb 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZL84w98"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3E134CC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986364; cv=none; b=mLRZ/lZJCSaOo0AsOTM04BbhsFidMMRkZzewRW8zGowi2uffiKl4h4/LItOCwc9eugYkjdDH2iLYf40u+IDzAYQoqebEq5gMZHqLegwEYnFReTAQW/hUQJcJK46eG0gWHo53N97at6O302UnpaNeg+XJldiSfRraLVxLs/4Geqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986364; c=relaxed/simple;
	bh=yC6kHSRvKkqYYdGQqM1omwhwYRYrDp3DukkCubobnU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FrfTLyIjMUK07vHD4D5Evdn3H3OrJQ/uJG8Bfux1/3d3yv1yI/dw21xpFxH9XKKI5YOX2RYzFiwq74v9VowwWKvdh/eLEZW1jR3OH1Y8nVtcd/T80gbhWAzGovDHuPKJAqSKJhHRGhh674cNX8/+Q6+AdYZkjbfXqveRTIoBC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZL84w98; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a30e445602cso327042366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707986360; x=1708591160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNQBz1sIK/4mg2JmHpaia1KSFPNVyM9uJkIcdSOuaC4=;
        b=zZL84w983Jz3a3l9Wu1dyU8PSOrtI7pPJrzxN3fEjfIBXUAhGOyIP7lTZR8ON51y0f
         wi9ptuGiPqrqwWfEU0vnfkOtMx5T1bztlMNul9PqsVpIK5Me03yNHjCBcOY21is+o0tP
         meSfR6+jNiv1cz9J9X59mbFd5FpMowLxdnQpkxcstl7pt+hKgx8rtrkYj5SRpjcawuag
         KARSlnVvq4XUhytqV3kD6NZP+DmSjc2r1Zn7K3Phx9cPcLu841bjnfaHQ1N7KV5qmezj
         mhGOYYG0ZkJX67tBJZ5PjD1P/66JMZzp6Hw4DoZ+afzOBube1qni0sTH4BJwqBp0waNB
         eZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707986360; x=1708591160;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQBz1sIK/4mg2JmHpaia1KSFPNVyM9uJkIcdSOuaC4=;
        b=dfcxgLGxzdbuGK3T1jMy+NEmnSteBpNVoC7PIUqk3nhhavI9+C5DKrC7T+xjLxUy5u
         CU5a4rCVupsKIO3zu1CRDNEJ35u+lBeVYoOxt87tDKf5IfenH9aXaqrFbZNvG/K1s36X
         SKX02tww4RmO+jgk7NT0j4ro0upLjmmKAgDNiuBvebya9oMPHYrCdNUGQIdWjZJe70Df
         shrmE75J0Mu1+uu0qv63DehmR2XiOcfjBmfRp0cCLNZDQPyciRaTPAxX3SFmwPI0Xo3g
         Wjp3XOTTG+zyEbO+drcPdxQs0OeJT9zZ4UhUAE9sz3XzaqikjBTpnxgtqJl3j/vNcOm5
         19Bg==
X-Gm-Message-State: AOJu0YyJcYwekmnGOPGHSdEtGZCjjXBjDyvHgY8f30SS4A/zb8UaBbb/
	UniKmMhlOX8NXVL7p2At7Mhpk2DYUipoMP1w6oHipqXYR+72Asd6vJLFL68JsYg=
X-Google-Smtp-Source: AGHT+IFXMkjC59dZDD/bZU7bp5dc4sjhNvSGvhU/k6lBcUDwSv7Zh1XkBkihkLA/y57EYSoY6y7gYg==
X-Received: by 2002:a17:906:c791:b0:a3d:20ec:7d1a with SMTP id cw17-20020a170906c79100b00a3d20ec7d1amr4142606ejb.11.1707986360322;
        Thu, 15 Feb 2024 00:39:20 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vx1-20020a170907a78100b00a3d8be700ddsm318508ejc.98.2024.02.15.00.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:39:19 -0800 (PST)
Message-ID: <7be10595-3852-4fec-a53c-b7d8ddde84c3@linaro.org>
Date: Thu, 15 Feb 2024 09:39:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/22] dt-bindings: chrome: Add binding for ChromeOS Pogo
 pin connector
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
 <20240210070934.2549994-19-swboyd@chromium.org>
 <18ac05fb-a78d-4e95-a73d-461f509cdc5f@linaro.org>
 <CAE-0n50Y_GRMt8km=XjGC5Zm5dvb2t4gccznJn9HEFS4p7y8fQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE-0n50Y_GRMt8km=XjGC5Zm5dvb2t4gccznJn9HEFS4p7y8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 01:07, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2024-02-11 05:39:36)
>> On 10/02/2024 08:09, Stephen Boyd wrote:
>>> diff --git a/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
>>> new file mode 100644
>>> index 000000000000..5ba68fd95fcd
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
>>> @@ -0,0 +1,61 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
> [...]
>>
>>> +properties:
>>> +  compatible:
>>> +    const: google,pogo-pin-connector
>>> +
>>> +  "#address-cells":
>>> +    const: 1
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +  port:
>>> +    $ref: /schemas/graph.yaml#/properties/port
>>> +    description: Connection to USB2 port providing USB signals
>>> +    required:
>>> +      - endpoint
>>
>> Drop required.
> 
> Why? I'd like to make it so you can't have the node defined without
> connecting it up to the rest of the system. Is that bad?

Hm, I double checked and you're right. I thought endpoint is required
anyway by graph.yaml in dtschema, but it seems it is not.

> 
>>
>>
>>> +
>>> +patternProperties:
>>> +  "^keyboard@[0-9a-f]{1,2}$":
>>> +    description: The detachable keyboard
>>
>> If this is detachable why do you define it in DT? Only hard-wired USB
>> devices, which need some sort of special handling. are described in DT.
> 
> From the commit text:
> 
>  We expect to find a keyboard on the other side of this connector with a
>  specific vid/pid, so describe that as a child device at the port of the
>  usb device connected upstream.
> 
> ChromeOS userspace is checking that the connected device downstream of
> this port has the expected vid/pid to quickly rule out USB keyboards
> that aren't the detachable keyboard. I wanted to express this in DT so
> that it didn't live in ChromeOS userspace forever.

OK,

Best regards,
Krzysztof


