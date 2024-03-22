Return-Path: <linux-kernel+bounces-110995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2638866CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EF31C222D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB17A32;
	Fri, 22 Mar 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVNIbarK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730002900
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089270; cv=none; b=MqvNMFoq8yUYbDEegE8DyaZt7d6ZTeoSpOEpPPnyH30AL42lN2DWpV009i0ybB9fCzph4xTtmUdeVkvF5sK8AnaRPW9zYVNAvIH+y+A0VFNvqbGbG7bliUPSb870g9nnyn2k1cWPYWsJfHadAi1EApB3rYB3h1n2M/m5g9fLux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089270; c=relaxed/simple;
	bh=pMUQdn+NpQkx+HcuvNeXY3RwSMjQp/IDmADPrYayUEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtX4m1opqM1vZ9dt0IXp8yEgsEl9CvHxZdNYXexsbLm4w27JyRfSC01gUd/1gPrqslmN+vMwtT0ddZM3J2AtwGdGBGlpar2/onUNwIlCzkrZD0Il7wn+Ubw3SoZ1eo/sN79VdyeEYrsOxhga7vXDuS9Mes9kf9SOoK2hB+nx3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tVNIbarK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so2434014a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711089267; x=1711694067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rcTuZQ0Fs4yaZZjCQm1wF/V02XtYpFxlm0yryxhWGF0=;
        b=tVNIbarKT8D3lU0Q2VZPzxJ1/XAuFl5eXVREmjRByGZkkna2rQ0z3iHZAcZh3H4jte
         0wnphdjKsbd4S8EF6kSazPCOC2kxDGgjUP0Q9yd1kLAAiYxw2f4aq7MAgt16XTdlNddL
         Qb+3E5PhaeTVwqxWjB4ODhPCNt10pu9unUDTOE+Nhu4l6mO0XBV081Xp/Uh/fMLPvmLv
         QpU3jBe7g+dvw/v3D9fxwkO7JEk7Qt3/H4fddM45SjeNYBoH2RRNf4L4OFVApSXerNDO
         9JOPzHrrvtZg6yev82ba2Yp5EGu3z//2JNxDfOX9df8gCI9lYnm0JBmrPmLpPpuOhEOa
         OUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711089267; x=1711694067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcTuZQ0Fs4yaZZjCQm1wF/V02XtYpFxlm0yryxhWGF0=;
        b=J9tbrHLjWnzP/SRZ3qFMLHbMbd5pHxxyPkIYCef8jvy6Dv9nik6vNl9lFvmwGV1SAx
         IaKTQsyBKqGwu6Ze6pxdig7gMnuggdN3rLx3ziGjRwJEogO9Y2mTZGXuah6Q/NyYQ8Ir
         gyOK2jYHLYTacIii0SG5fDLXlEt98sDETv2HNR3N9GCXmOxO4XPZ1U/DHQvKK71HvUNV
         8mBxDNWJMJGRwhqUN8LmLPhbWqVeGnuC8L9JUZkZg1ImYzqSjHJWiWb4S4h5u8YCXBvi
         rpP6oLLWG0skucRQ5XcN8aHlYrJt98zGbQphFyJFsJpMCjAvssF2CxkAJ2OpKSoaTTU5
         g/Xw==
X-Gm-Message-State: AOJu0YwxM9nxtR5FD+Q99l6N1T1KItZ8mLZcwoVapdhGo/9bsejdlmY7
	+yb6T0fUAD0VW/Wb2yaXDXiWwgACjHIpsfNj4QLBuokoUeSYLl/kxtEa9wDzwMc=
X-Google-Smtp-Source: AGHT+IEKa/3xa51UQfZZsNknQ7WITcF6QcyLyV2AQIBcrK/cUfDaNIMh0wcAWoqcvIi+0VgpXYdtKw==
X-Received: by 2002:a50:bb0c:0:b0:56b:9162:92f with SMTP id y12-20020a50bb0c000000b0056b9162092fmr1005467ede.23.1711089266751;
        Thu, 21 Mar 2024 23:34:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ds8-20020a0564021cc800b0056be8a21ec4sm69768edb.32.2024.03.21.23.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:34:26 -0700 (PDT)
Message-ID: <5dd3237f-e0a2-4214-a63f-233e89a26b8d@linaro.org>
Date: Fri, 22 Mar 2024 07:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to
 dtschema
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240321180617.35390-1-five231003@gmail.com>
 <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
 <CAN19-EfCOWFqFCrF0iCaxhfZuteWawQoH0d6pTN3cgQ7p-CK6w@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAN19-EfCOWFqFCrF0iCaxhfZuteWawQoH0d6pTN3cgQ7p-CK6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 07:23, Kousik Sanagavarapu wrote:
> On Fri, 22 Mar 2024, 11:33 Krzysztof Kozlowski, <
> krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 21/03/2024 19:02, Kousik Sanagavarapu wrote:
>>
>>> +  spi-max-frequency:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> No, drop. From which other SPI binding did you take it? I asked you to
>> look at existing code.
>>
> 
> Without this, "make dt_binding_check" would break though, right at the
> position in the example where "spi-max-frequency" is used.  That was
> also the reason why additionalProperties was set to true in the last
> iteration, but after reading the doc more carefully I realized that was
> wrong after you pointed it out.
> 
> I followed along bindings/spi/nvidia,tegra114-spi.yaml.

OK, you are right, the property is used here in controller node, however
Linux driver never parsed it. It was never used, so I propose to drop it
from the binding and example. You can mention in commit msg that
spi-max-frequency was not documented thus you drop it from the example.

DTS should be fixed as well. I'll send a patch for it.

Best regards,
Krzysztof


