Return-Path: <linux-kernel+bounces-110984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF08866AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B15284EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B88FC0A;
	Fri, 22 Mar 2024 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JicBCTRs"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C2C148
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088274; cv=none; b=mnSLijA0nS8jjOa3UY3oqNhDgq037gfo9syFYf9iY2xtuXi4KhJFQ89e+3aH6qutWsxtsm2TtbLYk3rgs808rBCSqQdv9GqObbPVXo0Q5zwLrgU6cQCA1zjNJ4XvzuIfWHt1t3TiLYLg9bl5hM1gyQTyUI9pP4R4SB4+lCncKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088274; c=relaxed/simple;
	bh=7QWjRTt2ummpls6CdbuPMzRfmumuZfXlw2FAbLs4uqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUudvwrZt/oAKR0V9ro8ooRxrK2CyZixHlAhozA9laa6hDpuJhzNiXAsA44CIUk3/6MHkPgdaE5P8yvYkOVJGuxyRRXj7xrr9GE7a8trfr8Xk9WY69aTbAAaTHBW1Dc9B6JWumlGVbdZTNKGZmbXZOlxDZD2ZwXKJkxuRU5CjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JicBCTRs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4715991c32so173186866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711088271; x=1711693071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omAuBuA6/U6J/WmiUkArJStENzk1lkMMLOUjd1MyIEg=;
        b=JicBCTRscpDZiP9o5x4gIeqZ8cvNInUHnGixW6Q68Mi2NURDg7AKji1okL+982kODg
         fLS36s2J+wA7SINkDzSn8ISj9f6B8yCWw2EEnFi0AmNV/U1Jvf00+zlbVm7o19fykrkt
         FEtQzf0AmqEzdsIvVw71MS+Ic1NiA8OIA48fGBHRLRWU3ms9RQOzMqcNoxiUfkenFD+J
         godWheoh0ZI1p8oPrO59dKbHk+P/TlCoHT7tpWwQn6O8q3A4kJlMvKZOfAXWwaRF64sv
         ZmIXIxVF96WsUyT5R0yNu2fpZROCyMNM0pBAbVfSE9kKr4tGzWPty4PSLXV4ChCrfsjZ
         MfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711088271; x=1711693071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omAuBuA6/U6J/WmiUkArJStENzk1lkMMLOUjd1MyIEg=;
        b=TSR+9HocXds93o7VpA8yQqrGWvXnCAX6Lj+cA3F7F5lYjrMO82Ol2c6NA64fh1X3v3
         fmBXSBasfsjI9Dz7g66dwU1rZRR9HhYbv8B9GwJZDekN0z8VQ9oAtBLMbZb+wesTfNG0
         F+edvOYDRHmnmQwdjaNY8oNzROkgZWNfU/dJo9vKoK7FFafcnOFi46fpXAZD2TiQ9TQ2
         XG8k+Wgx40Scgke0UOeQtsX1sN5BgwTjMA4mCqbaYO0wmf9LsYrn0yIQlOCH8z0GsZMs
         5xJcYzxMehK65kvaCIO6ykKZXDYsv7/65+aqe3UY4zHoUQsNKEFA1QhCcnUJweavVFwi
         Q8sw==
X-Forwarded-Encrypted: i=1; AJvYcCVCLTMU1biBS0BCuX6fe5lPM9nE6hFprLOplSbmCsnf8t99hlUbgDQujnIrTdGAMGlIISZ6uTcYDZqhg/Me7D4i1PqxosNWKaogb88U
X-Gm-Message-State: AOJu0YyV7dCjIQHV0ZYMvT9bpUCT9PHywIc9SB9XpUlN/1FdBZvSXG+j
	6BFUtrThrU1VCZuZxAOSB1lz+r50RnPIGKHhidECfY3eXUWtK+FqbV/vBqAxuyg=
X-Google-Smtp-Source: AGHT+IE8/2CKAhMCkAHadWAr2Zt6B+iP78C3p8mo9tDpUqx0IuosFVUu6jQ4oTyw9wcaRaoJ9wsPmQ==
X-Received: by 2002:a17:906:6a13:b0:a47:330f:f110 with SMTP id qw19-20020a1709066a1300b00a47330ff110mr499343ejc.7.1711088271346;
        Thu, 21 Mar 2024 23:17:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906844300b00a45f2dc6795sm657658ejy.137.2024.03.21.23.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:17:50 -0700 (PDT)
Message-ID: <0c84a8ab-5b92-49a3-aa14-08aaff856445@linaro.org>
Date: Fri, 22 Mar 2024 07:17:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt to
 yaml
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240318194535.2274543-1-Frank.Li@nxp.com>
 <20240320152435.GA1753500-robh@kernel.org>
 <ZfxeJ9dAXtfYW7Qq@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZfxeJ9dAXtfYW7Qq@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 17:19, Frank Li wrote:
>>> +  clocks:
>>> +    minItems: 3
>>> +    maxItems: 4
>>> +
>>> +  clock-names:
>>> +    minItems: 3
>>> +    description: |
>>> +      core:   The core clock used to access registers.
>>> +      extal:  The esai baud clock for esai controller used to
>>> +              derive HCK, SCK and FS.
>>> +      fsys:   The system clock derived from ahb clock used to
>>> +              derive HCK, SCK and FS.
>>> +      spba:   The spba clock is required when ESAI is placed as a
>>> +              bus slave of the Shared Peripheral Bus and when two
>>> +              or more bus masters (CPU, DMA or DSP) try to access
>>> +              it. This property is optional depending on the SoC
>>> +              design.
>>
>> This description should be split into each items entry below.

Description of clocks goes to clocks. Here, just items with 'const' items.

There are plenty of examples for this, most of complex devices define
clocks that way.



Best regards,
Krzysztof


