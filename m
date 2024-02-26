Return-Path: <linux-kernel+bounces-81330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788186744F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B10E1C2420C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0FB5FBBB;
	Mon, 26 Feb 2024 12:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax9TMgno"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE05FBBD
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949196; cv=none; b=gMYGesjIdLpAowMd1UtudIfXEWb0QwX0WimHtKMdd8zQSdTtWVv9kzQ3tOBlyeMkRBSbX/wNpwcTjyS/ZkZ4GwvYM3Hn5/TwJtNmbgZvaSVANo+eETdfCx09/U1J+hnPgiyb18ngml9LjrRrgp1WsP4NaRMBVpuCADjPtnd/iWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949196; c=relaxed/simple;
	bh=pTYTDm4YFv+QOrr5bBaNY1rUu1WgvEgqowBld52xfmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnWenvfavr2wz6dhshFW1+VDC0TkZ2PWuOFo1KTxmcd88niFU/RBncSo5tWZNpf0LZpezUzJYssZr1hlFbjNo+BVdTPsz53mfqOndkmNIa7Dz+Sfs7kVQq98TgAVU9+34xK/KS7S6uyLjyCGffoh9Afy7pMX/vGwBz7hfgauxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ax9TMgno; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so3305421a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708949193; x=1709553993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jZb3RsfWCFtGnSiN/0Ua3do7F7uOiKDfXi71EwZXwms=;
        b=Ax9TMgno1cRe6SUSxkbjyX/hG5Y+0w/FP5globyvHZJQc0kTFxycNmWHsCbutmdha1
         QYdzeg2+PwRDEXlFIpeb81Nlm5GnwWvEloTXrY/B81eKaFEKU63ED89jiAJTngzE9pcT
         rxGsOJpcMW33qERJwGeh3h2SKtMv7oj0Y0lrDnFOHA3JJM1gcYijH/i7FxY3NShO3GTX
         I1GmyNg7GpuHfIXTkFslMxjecRRK68JKdZDFQRzJMCBwt1I38plodZyrLR0dnJh5VIxR
         yAPoB2cPZOPsEDN6UgFHl2f4YVrf0I2xws2hzNnJ1hPpq/I4mEyNHWc08HPfW2/Z0gSa
         ncSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949193; x=1709553993;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZb3RsfWCFtGnSiN/0Ua3do7F7uOiKDfXi71EwZXwms=;
        b=OeK5/cl13VWmXbRcQSCMtL09DJngoJgVEPgxofBexB0hBXM4JDfCYige0S3I8Tljh6
         KUt/graR4C6oXbeedSrd4iTfdOH0Ci4zeLk45QAIAdQNvjB8vp6/d0PpBXSkpWI5fUaK
         6R1dhOJnbcMwkVNYfxTRts3QMZtvgE+zULXSuB/gKRxOcIdaG87iVeA6DEBBEimo0n12
         slBSBpKZydpgo/RSDUI1AXl/e5pMQHWl4th95F+tt2BcSxKCBKpuDoCdI4u/e+cuVFmq
         5eOZO3olPqbLfqV8AJyZRoVWgSrar6wsoK7PSJARC4hhY9b6uMVkOGIxI2rbGN53NXqt
         SoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf9Va/ksFKL4AEymSWzR8cumwOoQxWYJdMQFUxjPit/Zxx4APJ7ChMv2uaFZF21kCWvQpzLrT32HzdshR2LMfxS0JdA64RohEyS7YX
X-Gm-Message-State: AOJu0YxILLz3iMrU1DuPsR7ET9KWrw/SY/EtA7y3QogQG9ZHHqPN4+m2
	RpWT2lSfBNjAWEWQwCnsgiFEHGtotRfQSzHU1g8zreIJ3YWki6n63oeUB1zyRI8=
X-Google-Smtp-Source: AGHT+IHVPJHNRwyZQ5ZsC6Nz8Lo7dv2F89RO73gTPCFNLMkhI8Kq4cIvhrc3ArE0rurSQnQGJyHI5g==
X-Received: by 2002:a05:6402:1817:b0:564:4221:9aa9 with SMTP id g23-20020a056402181700b0056442219aa9mr4623645edy.38.1708949193002;
        Mon, 26 Feb 2024 04:06:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n9-20020a056402060900b0056200715130sm2301671edv.54.2024.02.26.04.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 04:06:32 -0800 (PST)
Message-ID: <e1fd8cbd-060b-4d15-8256-6d8dbba545da@linaro.org>
Date: Mon, 26 Feb 2024 13:06:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] media: dt-bindings: Add Intel Displayport RX IP
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org,
 daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl,
 krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com,
 mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org,
 tzimmermann@suse.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com,
 ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-9-panikiel@google.com>
 <13aeb2ff-72f4-49d9-b65e-ddc31569a936@linaro.org>
 <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAM5zL5q0oKoTMR0jSwYVAChCOJ9iKYPRFiU1vH4qDqhHALKz4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 11:59, Paweł Anikiel wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: intel,dprx-20.0.1
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  intel,max-link-rate:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Max link rate configuration parameter
>>
>> Please do not duplicate property name in description. It's useless.
>> Instead explain what is this responsible for.
>>
>> Why max-link-rate would differ for the same dprx-20.0.1? And why
>> standard properties cannot be used?
>>
>> Same for all questions below.
> 
> These four properties are the IP configuration parameters mentioned in
> the device description. When generating the IP core you can set these
> parameters, which could make them differ for the same dprx-20.0.1.
> They are documented in the user guide, for which I also put a link in
> the description. Is that enough? Or should I also document these
> parameters here?

user-guide is something for users, like user-space programmers or
end-users. I would never open it to look for any information related to
hardware.

Anyway, external resources are a no-go. We have it clearly in submitting
patches:

https://elixir.bootlin.com/linux/v6.8-rc6/source/Documentation/process/submitting-patches.rst#L130

> 
>>
>>> +
>>> +  intel,max-lane-count:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Max lane count configuration parameter
>>> +
>>> +  intel,multi-stream-support:
>>> +    type: boolean
>>> +    description: Multi-Stream Transport support configuration parameter
>>> +
>>> +  intel,max-stream-count:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Max stream count configuration parameter
>>> +
>>> +  port:
>>> +    $ref: /schemas/graph.yaml#/properties/port
>>> +    description: SST main link
>>
>> I don't understand why you have both port and ports. Shouldn't this be
>> under ports?
> 
> I put both so that you can use the shorter port property when the
> device only has one port (i.e. no MST support). It would work fine
> without it. If you think that's unnecessary, I can remove it (and use
> the ports property even if there is only one).

No, it is fine, but then you need allOf: which will restrict to only one
of them: either port or ports.

Best regards,
Krzysztof


