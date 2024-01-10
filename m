Return-Path: <linux-kernel+bounces-22791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8BA82A2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463ED1F295AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EE4F1F4;
	Wed, 10 Jan 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBjOg9HK"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F74F1E5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2bdc3a3c84so112026766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704920057; x=1705524857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZlzwz2Xm3MExiEQLHcNCcs3pt3gp3Qvxyp+Wgxqrio=;
        b=dBjOg9HKae+a2uEJY5KwtHvgyPmaEXdbQFw5Qn2P8e/bhQA+jrApqDSv4CfcKXLVEm
         0CJWRnfDSKg8CCL6BfqMPFfNOi2sXc6yZuUH53LTDDW8QU1g1Ie1W952WKF+LINtig2H
         /eosTRZELGLaDDNsZkEt7E5y11KkZIlR+ffsH+wAu+W6P0F2gS72vs3dU3Ng6i0bPGvv
         RvF0on2Z+27zXyeTpVo8/da5b5/VbCNdI01qmValoRwMG2Z7MmyIZCH3qPLypqquWKEb
         MS7IW4Xrr+YaEzjqeTk/RT+AkZSasXK5bGINWJfiuQIR/72tIi8qpbXxBsgAGRpgQzjc
         jUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704920057; x=1705524857;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZlzwz2Xm3MExiEQLHcNCcs3pt3gp3Qvxyp+Wgxqrio=;
        b=ZroVjbEbA9kEUJ605v1I9uHAnaPh4AvtJvqVG5Zm1t9Rms/SsqZMz8fYTdTGCO77iG
         26YHLy+rT+nqvTmcq982X9TpB3AJie7W8HRfxqPKNbTZI1UVK77cRpw0aJlyQhLsBf2B
         CZczXb4HNTZmEAUxIvJ761HpC7RAJmjVmckdwlxnuS+1D/SKCuBAkOO+zsHuIco+5DUk
         bT8jL2+FKxCsb91ROeE/AkYsy28fPoYSxFAd+rPMfr0lYl+fe4W/z9DrUG/gzM2dhkKV
         CF6K5Vi6uLceXaY/w9PSn0/j7QLRteoljuG77BSdyn5f72tbce3Ag6WpPJ/FaauZpeS2
         bJEQ==
X-Gm-Message-State: AOJu0YwGykOAzaBD5kDxtB+kw6UqGjLfN2qtJr68BusuNwYE4KrVEM6c
	f5G4HheP7IeeMaXz6ALy9l3Z1D459twv+w==
X-Google-Smtp-Source: AGHT+IFUciwUr/SQowab2PkYeuRHlqoN0WjtFUpKgZtmwgxcCaSf+3r2a4D1dPOQeU6kiMXiP37R/w==
X-Received: by 2002:a17:906:a2c8:b0:a27:e214:96b with SMTP id by8-20020a170906a2c800b00a27e214096bmr52214ejb.112.1704920057575;
        Wed, 10 Jan 2024 12:54:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709061dd700b00a2c2a9b5766sm190411ejh.97.2024.01.10.12.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 12:54:16 -0800 (PST)
Message-ID: <dc739435-d955-44f7-b5ee-9de4d5336725@linaro.org>
Date: Wed, 10 Jan 2024 21:54:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m
 clock property
Content-Language: en-US
To: Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240108135421.684263-1-tmaimon77@gmail.com>
 <20240108135421.684263-2-tmaimon77@gmail.com>
 <20240109170830.GA2772086-robh@kernel.org>
 <CAP6Zq1jCHVrFfRa6c3DZ4t2aaJTkWukeEkia0AqhzppC0mjbfg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAP6Zq1jCHVrFfRa6c3DZ4t2aaJTkWukeEkia0AqhzppC0mjbfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2024 14:47, Tomer Maimon wrote:
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: refclk
>>> +
>>>    '#clock-cells':
>>>      const: 1
>>>      description:
>>> @@ -30,12 +38,20 @@ properties:
>>>  required:
>>>    - compatible
>>>    - reg
>>> +  - clocks
>>> +  - clock-names
>>
>> New required properties are an ABI break. That's fine if you explain why
>> that's okay in the commit msg.
> What do you mean?

I think it was clear. Which part is not clear?

> Could I add the new required properties to the required list?

You just did, didn't you? And received feedback that you are breaking
the ABI.

Best regards,
Krzysztof


